# Atari 2600 Platform - 6502 Assembly Language

## Introduction

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

# MOS 6502

![MOS 6502 Pinout][MOS 6502 Pin Diagram]

[MOS 6502 Pin Diagram]: assets/MOS6502.svg

The 6502 is essentially a cheaper 28-pin package. A15 to A13, and other
interuption lines are not accessible.

# Binary and Hexadecimal

How things get stored in the metal?

The hertz (symbol: Hz) is the derived unit of frequency in the International
System of Units (SI) and is defined as one cycle per second. Hertz are commonly
expressed in multiples:

- kilohertz (103 Hz, kHz)
- megahertz (106 Hz, MHz)
- gigahertz (109 Hz, GHz)
- terahertz (1012 Hz, THz)
- petahertz (1015 Hz, PHz)
- exahertz (1018 Hz, EHz)
- and zettahertz (1021 Hz, ZHz)

The components can only tell if there is high voltage, or low voltage. Two
states, On or Off, 1 or 0.

We know that data is stored on CD's, DVD's, and Blu-Rays in binary. Same with
magnetic media like hard drives.

Electricity, optical, and magnetic, they store using on or off states, 0 or 1.
These are the bits.

We are able to group bits together to represent different types of data.

11010001

## Base 10

Humans use a base 10 numeric system: decimal system. This is likely because
we have 10 fingers. Remember, fingers are also called "digits".

We have 0-9, and then we add a number to the left to get tens, twenties,
thirties, etc. It goes on into the hundreds, thousands, millions, billions, etc.

This is all based on 10. Powers of 10.

## Base 2

How do computers count in base 2?

To represent 2, we need to add a new column to the left.

As you can see here with a 2 bit representation, we can only represent numbers
0 - 3.

| 2 | 1 | Number |
|---|---| ------ |
| 0 | 0 | 0      |
| 0 | 1 | 1      |
| 1 | 0 | 2      |
| 1 | 1 | 3      |


The columns continue in powers of 2.
1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, etc.

| 16 | 8 | 4 | 2 | 1 | Number |
|----|---|---|---|---|--------|
|  0 | 0 | 0 | 0 | 0 | 0      |
|  0 | 0 | 0 | 0 | 1 | 1      |
|  0 | 0 | 0 | 1 | 0 | 2      |
|  0 | 0 | 0 | 1 | 1 | 3      |
|  0 | 0 | 1 | 0 | 0 | 4      |
|  0 | 0 | 1 | 0 | 1 | 5      |
|  0 | 0 | 1 | 1 | 0 | 6      |
|  0 | 0 | 1 | 1 | 1 | 7      |
|  0 | 1 | 0 | 0 | 0 | 8      |
|  0 | 1 | 0 | 0 | 1 | 9      |
|  0 | 1 | 0 | 1 | 0 | 10     |
|  0 | 1 | 0 | 1 | 1 | 11     |
|  0 | 1 | 1 | 0 | 0 | 12     |
|  0 | 1 | 1 | 0 | 1 | 13     |
|  0 | 1 | 1 | 1 | 0 | 14     |
|  0 | 1 | 1 | 1 | 1 | 15     |
|  1 | 0 | 0 | 0 | 0 | 16     |

The number of unique values that can be represented with `n` bits is: 2<sup>n</sup>

2 bits = 4 values (0-3)
3 bits = 8 values (0-7)
4 bits = 16 values (0-15)
5 bits = 32 values (0-31)

With a base 10 system, the number of values that can be represented is 10<sup>n</sup>

10<sup>3</sup> = 1,000 values (0-999)

8 bits is a byte (example: `00011011`)

We are familiar with storage in kilobytes, megabytes, gigabytes, terrabytes,
etc.

| 2<sup>7</sup> | 2<sup>6</sup> | 2<sup>5</sup> | <sup>4</sup> | 2<sup>3</sup> | 2<sup>2</sup> | 2<sup>1</sup> | 2<sup>0</sup> |
|---|---|---|---|---|---|---|---|
| 0 | 0 | 0 | 1 | 1 | 0 | 1 | 1 |

The 2<sup>7</sup> column is the MSD - Most significant bit
The 2<sup>0</sup> column is the LSB - Least significant bit

- 1 X 2<sup>0</sup> = 1
- 1 X 2<sup>1</sup> = 2
- 0 X 2<sup>2</sup> = 0
- 1 X 2<sup>3</sup> = 8
- 1 X 2<sup>4</sup> = 16
- 0 X 2<sup>5</sup> = 0
- 0 X 2<sup>6</sup> = 0
- 0 X 2<sup>7</sup> = 0

1 + 2 + 0 + 8 + 16 = 27

Binary and Decimal... Is there anything else?

* 10 can be divided by 2 or 5
* 12 can be divided by 2, 3, 4, or 6
* 8 can be divided by 2 or 4

Some say that we should be using base 8 or base 12. They are divisible by more
numbers than base 10.

Why do we divide the day into 24 hours? With Base 12 you can use the number as
pointer of the count, with each finger divided at the knuckles

![Base 12 Hand Diagram][Base 12 Hand Diagram]

[Base 12 Hand Diagram]: assets/base-12.png

## Base 16 - Hexadecimal

| 16<sup>0</sup> | Hex |
|----------------|-----|
| 0              | 0   |
| 1              | 1   |
| 2              | 2   |
| 3              | 3   |
| 4              | 4   |
| 5              | 5   |
| 6              | 6   |
| 7              | 7   |
| 8              | 8   |
| 9              | 9   |
| 10             | A   |
| 11             | B   |
| 12             | C   |
| 13             | D   |
| 14             | E   |
| 15             | F   |
