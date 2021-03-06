{
  description = ''Fast persistent key-value store, based on libmdbx'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."nimdbx-main".dir   = "main";
  inputs."nimdbx-main".owner = "nim-nix-pkgs";
  inputs."nimdbx-main".ref   = "master";
  inputs."nimdbx-main".repo  = "nimdbx";
  inputs."nimdbx-main".type  = "github";
  inputs."nimdbx-main".inputs.nixpkgs.follows = "nixpkgs";
  inputs."nimdbx-main".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}