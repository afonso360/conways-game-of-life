# Autogenerated from vk-cts-sources.py
{ fetchurl, fetchFromGitHub }:
rec {
  ESExtractor = fetchFromGitHub {
    owner = "Igalia";
    repo = "ESExtractor";
    rev = "v0.2.5";
    hash = "sha256-A3lyTTarR1ZJrXcrLDR5D7H1kBwJNyrPPjEklRM9YBY=";
  };

  amber = fetchFromGitHub {
    owner = "google";
    repo = "amber";
    rev = "933ecb4d6288675a92eb1650e0f52b1d7afe8273";
    hash = "sha256-v9z4gv/mTjaCkByZn6uDpMteQuIf0FzZXeKyoXfFjXo=";
  };

  glslang = fetchFromGitHub {
    owner = "KhronosGroup";
    repo = "glslang";
    rev = "77417d5c9e0a5d4c79ddd0285d530b45f7259f0d";
    hash = "sha256-BNgnhTl7/+nC5D7Jl7QME5+qIbm+I0Wh/tf9F4WhW3U=";
  };

  jsoncpp = fetchFromGitHub {
    owner = "open-source-parsers";
    repo = "jsoncpp";
    rev = "9059f5cad030ba11d37818847443a53918c327b1";
    hash = "sha256-m0tz8w8HbtDitx3Qkn3Rxj/XhASiJVkThdeBxIwv3WI=";
  };

  spirv-headers = fetchFromGitHub {
    owner = "KhronosGroup";
    repo = "SPIRV-Headers";
    rev = "1feaf4414eb2b353764d01d88f8aa4bcc67b60db";
    hash = "sha256-VOq3r6ZcbDGGxjqC4IoPMGC5n1APUPUAs9xcRzxdyfk=";
  };

  spirv-tools = fetchFromGitHub {
    owner = "KhronosGroup";
    repo = "SPIRV-Tools";
    rev = "01828dac778d08f4ebafd2e06bd419f6c84e5984";
    hash = "sha256-i1rDMVpUiNdacDe20DsN67/rzK5V434EzfSv97y+xGU=";
  };

  video-parser = fetchFromGitHub {
    owner = "nvpro-samples";
    repo = "vk_video_samples";
    rev = "7d68747d3524842afaf050c5e00a10f5b8c07904";
    hash = "sha256-L5IYDm0bLq+NlNrzozu0VQx8zL1na6AhrkjZKxOWSnU=";
  };

  vulkan-docs = fetchFromGitHub {
    owner = "KhronosGroup";
    repo = "Vulkan-Docs";
    rev = "9fff8b252a3688c0231fa78709084bbe677d3bf7";
    hash = "sha256-KpKsKTY5xCSZ5Y92roa0fq/iqc1hVJNS7l87RFcxyRQ=";
  };


  prePatch = ''
    mkdir -p external/ESExtractor external/amber external/glslang external/jsoncpp external/spirv-headers external/spirv-tools external/video-parser external/vulkan-docs

    cp -r ${ESExtractor} external/ESExtractor/src
    cp -r ${amber} external/amber/src
    cp -r ${glslang} external/glslang/src
    cp -r ${jsoncpp} external/jsoncpp/src
    cp -r ${spirv-headers} external/spirv-headers/src
    cp -r ${spirv-tools} external/spirv-tools/src
    cp -r ${video-parser} external/video-parser/src
    cp -r ${vulkan-docs} external/vulkan-docs/src
  '';
}