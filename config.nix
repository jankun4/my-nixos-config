{
packageOverrides = super: let self = super.pkgs; in
 {
  myHaskellEnv = self.haskellPackages.ghcWithHoogle
                   (haskellPackages: with haskellPackages; [
                   #libraries
                   aeson
                   Control-Engine
                   #tools
                   stack
                   cabal-install
                   stylish-haskell
                   hindent
                   apply-refact
                   hlint
                   intero
                   ]);
 };
}
