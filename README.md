# Atari 2600 Assembly Experiments

Assembly for the MOS 6507 microprocessor, taken from
[Learn Assembly Language by Making Games for the Atari 2600]
(also available as [Assembly 6502 for Atari 2600 Games]) on [Pikuma.com].

## Notes

See [Notes](doc/notes.md)

## Setup

Install the [DASM 8-bit macro assembler] using [Homebrew] (for Mac):

```shell
brew install dasm
```

Intall the Stella using [Homebrew]:

```shell
brew install stella
```

[learn assembly language by making games for the atari 2600]: https://www.udemy.com/course/programming-games-for-the-atari-2600/
[DASM 8-bit macro assembler]: https://dasm-assembler.github.io/
[Homebrew]: https://brew.sh/
[Assembly 6502 for Atari 2600 Games]: https://courses.pikuma.com/courses/atari2600
[Pikuma.com]: https://www.pikuma.com/

## Assembling

```shell
# change to directory with rom code
cd src/cleanmemory

# use makefile
make
make run
make clean
```

## Emulator

Assembled binaries are run using the [Stella Atari 2600 VCS emulator]

[Stella Atari 2600 VCS emulator]: https://stella-emu.github.io/

## Resources

* [Atari 2600 Programming for Newbies](https://www.randomterrain.com/atari-2600-memories.html#assembly_language)
