{
  lib,
  buildPythonPackage,
  click,
  fetchFromGitHub,
  poetry-core,
  pydantic,
  pytestCheckHook,
  pythonOlder,
  toml,
}:

buildPythonPackage rec {
  pname = "maison";
  version = "1.4.3";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "dbatten5";
    repo = "maison";
    tag = "v${version}";
    hash = "sha256-2hUmk91wr5o2cV3un2nMoXDG+3GT7SaIOKY+QaZY3nw=";
  };

  pythonRelaxDeps = [ "pydantic" ];

  nativeBuildInputs = [
    poetry-core
  ];

  propagatedBuildInputs = [
    click
    pydantic
    toml
  ];

  checkInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "maison" ];

  meta = with lib; {
    description = "Library to read settings from config files";
    mainProgram = "maison";
    homepage = "https://github.com/dbatten5/maison";
    changelog = "https://github.com/dbatten5/maison/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ fab ];
  };
}
