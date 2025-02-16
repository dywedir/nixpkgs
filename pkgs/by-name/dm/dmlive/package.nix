{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  makeWrapper,
  openssl,
  mpv,
  ffmpeg,
  nodejs,
}:

rustPlatform.buildRustPackage rec {
  pname = "dmlive";
  version = "5.5.4";

  src = fetchFromGitHub {
    owner = "THMonster";
    repo = pname;
    rev = "688ddda12ed70a7ad25ede63e948e1cba143a307"; # no tag
    hash = "sha256-M7IZ2UzusWovyhigyUXasmSEz4J79gnFyivHVUqfUKg=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-eHbnAOMWfGSVYrLqhfoZ4tXHy6GXKzB7sHN8ZQwE//0=";

  OPENSSL_NO_VENDOR = true;

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    openssl
  ];

  postInstall = ''
    wrapProgram "$out/bin/dmlive" --prefix PATH : "${
      lib.makeBinPath [
        mpv
        ffmpeg
        nodejs
      ]
    }"
  '';

  meta = {
    description = "Tool to play and record videos or live streams with danmaku";
    homepage = "https://github.com/THMonster/dmlive";
    license = lib.licenses.mit;
    mainProgram = "dmlive";
    maintainers = with lib.maintainers; [ nickcao ];
  };
}
