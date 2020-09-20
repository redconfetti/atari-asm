# Atari 2600 Platform - 6502 Assembly Language

[Back to Notes](./notes.md)

Atari was founded in 1972, famous for the [Pong] arcade gane (1972).

Pong and [Tank] arcade games both used hard wired circuitry. They did not use
cartridges like the Atari 2600. Both games have similar objects.

- Player 1 & 2
- Scoreboard
- Ball / Misile
- Playing field
- Collisions

All their objects are rendered.

In 1975, Atari decided to release a console based on programmable design, code
named "Stella". This is what became the Atari Video Computer System (Atari VCS),
also known as the "Atari 2600".

People want to understand computer architecture. This can help you understand
that.

- [Atari 2600] Hardware Specs
- [6502]/[6507] processor
- Working with digital values (bin/hex)
- Using Atari emulator
- Assembling your own ROM cartridges
- The basics of 6502 assembly language
- Video, Audio, and Input Adapters
- Code Examples and Techniques

Note: x86 processors use an assembly language that is intended for use by
compilers, not humans. 6502 assembly is made for game programmers.

[Atari]: https://en.wikipedia.org/wiki/Atari
[Tank]: https://en.wikipedia.org/wiki/Tank_(video_game)
[Atari 2600]: https://en.wikipedia.org/wiki/Atari_2600
[6502]: https://en.wikipedia.org/wiki/MOS_Technology_6502
[6507]: https://en.wikipedia.org/wiki/MOS_Technology_6507

## Hardware and Architecture

### CPUs

Three processors were considered.

- Intel 8080
- Motorola 6800
- MOS 6502 9bought by Commodore before release)

The MOS 6502 also powered the:

- Apple II - 1977
- Commodore 64 - 1982
- BBC Micro - 1982
- Famicom / Nintendo Entertainment System (NES) - 1983
- Atari Lynx (handheld game system) - 1989
- Tamagotchi digital pets - 1996

### Specs

- CPU: 1.19 MHz 6507
- Audio/Video: [TIA Chip] (Television Interface Adapter)
- RAM: 128 bytes - [6532 RAM-I/O-Timer (RIOT) Chip]
- ROM: game cartridges: 4 KB
- Input: two controller ports (joystick, paddle, etc)
- Output: TV via RCA connector (NTSC, PAL, SECAM)

### Hardware Releases

There were several releases of the Atari 2600.

- 1977 - "Heavy Sixer" - Called this due to the heavy aluminum radio-frequency
  shielding, as well as ​1⁄2-inch-thick (12 mm) plastic bottom half.
- 1978 - "Light Sixer" - A lighter version
- 1980 - "Four Switch" - Only 4 switches on the top of the console instead of 6.
  The two difficulty switches were moved to the back of the console.
- 1981 - "Darth Vader" - The first console to officially use "2600" in the name
  instead of VCS. Does not have woodgrain on the front and is primarily black,
  resulting in the nickname of "Darth Vader".
- 1986 - "2600 JR" - New redesigned version featuring a smaller, cost-reduced,
  form factor with a modernized Atari 7800-like appearance.

[Pong]: https://en.wikipedia.org/wiki/Pong
[TIA Chip]: https://en.wikipedia.org/wiki/Television_Interface_Adaptor
[6532 RAM-I/O-Timer (RIOT) Chip]: https://en.wikipedia.org/wiki/MOS_Technology_6532

## MOS 6502

![MOS 6502 Pinout][MOS 6502 Pin Diagram]

[MOS 6502 Pin Diagram]: assets/MOS6502.svg

The 6502 is essentially a cheaper 28-pin package. A15 to A13, and other
interuption lines are not accessible.

## Memory Positions

Adapted from [](https://www.randomterrain.com/atari-2600-memories-tutorial-andrew-davie-05.html)

The 6502 is able to address 65536 (2^16) bytes of memory, each with a unique
address. However the 2600 CPU (6507) is only able to directly access 2^13 bytes
(8192 bytes) of memory. Only 13 of the 16 address lines are connected
physically.

| Address Range  | Size (Bytes) | Function           |
|----------------|--------------| ------------------ |
| $0000 - $007F  |              | TIA registers      |
| $0080 - $00FF  | 128          | RAM                |
| $0200 - $02FF  |              | RIOT registers     |
| $1000 - $1FFF  | 4096         | ROM                |

### Zero is Zero

`%0000000000000` to `%1111111111111` = from `$0000` to `$1FFF`

`$0000` is the same as '%000'. Zero is zero (0 is 0).

### Reads and/or Writes

All communication between the CPU and hardware (ROM, RAM, I/O, the TIA, etc) is
through reads and/or writes to memory locations.

The memory range between $0 and $1FFFF must contain our RAM, some must contain
our ROM (program), and some must allow us to communicate with the TIA or other
hardware connected to the machine.

### RAM

We only have 128 bytes of RAM on the 2600. It lives at addresses $80 - $FF.
Any write to $80 (128 decimal) will be to the first byte of RAM.

### TIA

Writing to the TIA registers is just like any other area of memory, however when
you write to those locations, the TIA is 'watching' them and thus changing what
it draws on a scanline.

- $0000
- ...
- ...
- $FFF7
- $FFF8
- $FFF9
- $FFFA
- $FFFB
- $FFFC - Reset vector
- $FFFD
- $FFFE
- $FFFF - Last memory position

[Back to Notes](./notes.md)
