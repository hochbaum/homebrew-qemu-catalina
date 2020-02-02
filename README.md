Since Catalina has fucked up Cocoa frontend, here are some fixed formulas using SDL2 instead of Cocoa for you.

## Installing
Either
```
brew tap lhochbaum/homebrew-qemu-catalina
brew install qemu-system-<your arch>
```
Or
```
git clone git@github.com:lhochbaum/homebrew-qemu-catalina.git
cd homebrew-qemu-catalina/
brew install --build-from-source qemu-system-<your arch>.rb
```