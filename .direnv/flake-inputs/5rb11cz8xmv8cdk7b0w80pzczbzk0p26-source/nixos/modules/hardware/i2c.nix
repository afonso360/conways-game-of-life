{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.hardware.i2c;
in

{
  options.hardware.i2c = {
    enable = mkEnableOption (lib.mdDoc ''
      i2c devices support. By default access is granted to users in the "i2c"
      group (will be created if non-existent) and any user with a seat, meaning
      logged on the computer locally.
    '');

    group = mkOption {
      type = types.str;
      default = "i2c";
      description = lib.mdDoc ''
        Grant access to i2c devices (/dev/i2c-*) to users in this group.
      '';
    };
  };

  config = mkIf cfg.enable {

    boot.kernelModules = [ "i2c-dev" ];

    users.groups = mkIf (cfg.group == "i2c") {
      i2c = { };
    };

    services.udev.packages = lib.singleton (pkgs.writeTextFile
      { name = "i2c-udev-rules";
        text = ''
          # allow group ${cfg.group} and users with a seat use of i2c devices
          ACTION=="add", KERNEL=="i2c-[0-9]*", TAG+="uaccess", GROUP="${cfg.group}", MODE="660"
        '';
        destination = "/etc/udev/rules.d/70-i2c.rules";
      });

  };

  meta.maintainers = [ maintainers.rnhmjoj ];

}
