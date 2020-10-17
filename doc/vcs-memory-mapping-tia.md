# VCS Memory Map and the TIA

[Back to Notes](./notes.md)

## VCS Memory Mapping

We already touched upon the existence of a memory map when we mentioned the
code starting with `$F000` and ending with `$FFFF` to write our instructions.

We mentioned a zero page memory address from `$0000` to `$00FF` as the
space for the RAM and the TIA registers.

When we mention a memory map, we are discussing where things are located in
address space.

### VCS Bus

Within the VCS Bus we have 3 important things to interface with.

* TIA (Television Interface Adapter)
* PIA (Peripheral Interface Adapter) RAM
* ROM (Read Only Memory) Cartridge

### TIA registers

`$00` - `$7F`

Most store or poke values in the TIA. Functions of these registers include:

* Setting background color
* Color of the Player 1 Sprite
* Color of the Player 2 Sprite
* Synchronizations of the horizontal and vertical beams

If we store a value in `$09`, this will set the color of the background.

### PIA registers

`$80` - `$FF`

These are the registers for our PIA RAM

### Cartridge ROM

`$F000` - `$FFFF`

This is where our instructions, our OP codes, are stored.

`$FFFC` is our reset vector. `$FFFE` is our break interuption.

### Other

From `$280` - `$297` we also have our timer, and PIA ports, but the most
important things in our memory map are listed above.

### Helper

Do we need to remember all these details of which memory locations map to
certain functionality? No. We can store these references in a helper header
file - `vcs.h`. This contains useful definitions of important memory space
addresses.

In this file we assign certain constants that point to those addresses.

```Assembly
COLUP0 ds 1 ;$06 xxxx xxx0  Color Luminance Player 0
COLUP1 ds 1 ;$07 xxxx xxx0  Color Luminance Player 1
COLUPF ds 1 ;$08 xxxx xxx0  Color Luminance Playfield
COLUBK ds 1 ;$09 xxxx xxx0  Color Luminance Background
```

We're going to use these as aliasses. To use this file, we simply need to
add the command `include "vcs.h"`.

There is also a `macro.h` file that includes a couple useful macros for us to
use with the assembler - `include "macro.h"`. This includes functions such as
a sleep macro (causing the program to pause for a moment, clearing the memory,
etc. See [DASM Helpers]

[DASM Helpers]: https://github.com/munsie/dasm/tree/master/machines/atari2600

## Memory Map and Page Zero

The specifications of the Atari 2600 claim that it has 128 bytes of RAM memory,
so why do the page zero addresses go from $00 to $FF, which is 256 addresses
long?

* Zero Page
  * 0000 - 002C - TIA (write) - `$00 - $2C` - 45 address spaces
  * 002D - 002F - ? - 2 address spaces
  * 0030 - 003D - TIA (read) - `$30 - $3D` - 14 address spaces
  * 003E - 007F - ? - 66 address spaces
  * 0080 - 00FF - RIOT (RAM) - `$80 - $FF` - 128 address spaces
* Non-Zero Page
  * 0280 - 0297 - RIOT (I/O, Timer) - 32 address spaces
  * F000 - FFFF - Cartridge (ROM) - 256 address spaces

The TIA and RIOT (RAM) span the 256 addresses?

The [zero page], or base page, is the block of memory at the very beginning
of a computer's addres space, that is, the page whose starting address is zero.

In the 1970's, computer RAM was as fast or faster than the CPU, so it made
sense to have few registers, and use the main memory as an extended pool of
extra registers. This "zero page" range of addresses is faster to access than
other locations in such systems, but no longer applies to modern systems.

[zero page]: https://en.wikipedia.org/wiki/Zero_page

## Sending Instructions to the Display



## Stella Debugger Warnings

## NTSC Video Synchronization

## Painting the CRT

[Back to Notes](./notes.md)
