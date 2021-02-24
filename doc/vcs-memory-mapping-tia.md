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

The 6507 chip has only 13 address pins-- A0 through A12-- so the usable
addresses are an 8K block from $0000 through $1FFF. Internally the 6507 still
uses 16-bit addresses, but since there are no pins for A13 through A15, any
attempt to access $2000 through $FFFF will actually access $0000 through $1FFF:

| Page      | Range       | Description       | Hex             | Spaces |
| ----------|-------------|-------------------|-----------------|--------|
| Zero      | 0000 - 002C | TIA (write)       | `$00 - $2C`     | 45     |
| Zero      | 002D - 002F | ?                 | `$2D - $2F`     | 2      |
| Zero      | 0030 - 003D | TIA (read)        | `$30 - $3D`     | 14     |
| Zero      | 003E - 007F | ?                 | `$3E - $7F`     | 66     |
| Zero      | 0080 - 00FF | RIOT (RAM)        | `$80 - $FF`     | 128    |
| Non-Zero  | 0280 - 0297 | RIOT (I/O, Timer) | `$280 - $297`   | 32     |
| Non-Zero  | F000 - FFFF | Cartridge (ROM)   | `$F000 - $FFFF` | 256    |

The TIA and RIOT (RAM) span the 256 addresses?

The [zero page], or base page, is the block of memory at the very beginning
of a computer's address space, that is, the page whose starting address is zero.

In the 1970's, computer RAM was as fast or faster than the CPU, so it made
sense to have few registers, and use the main memory as an extended pool of
extra registers. This "zero page" range of addresses is faster to access than
other locations in such systems, but no longer applies to modern systems.

[zero page]: https://en.wikipedia.org/wiki/Zero_page

## Mirrored Memory

Taken from [AtariAge - Mirrored memory]:

The 6507 chip has only 13 address pins-- A0 through A12-- so the usable
addresses are an 8K block from $0000 through $1FFF. Internally the 6507 still
uses 16-bit addresses, but since there are no pins for A13 through A15, any
attempt to access \$2000 through \$FFFF will actually access \$0000 through
\$1FFF:

| Range            | Description                 |
|------------------|-----------------------------|
| \$E000 - \$FFFF  | 8K mirror of $0000 - $1FFF  |
| \$C000 - \$DFFF  | 8K mirror of $0000 - $1FFF  |
| \$A000 - \$BFFF  | 8K mirror of $0000 - $1FFF  |
| \$8000 - \$9FFF  | 8K mirror of $0000 - $1FFF  |
| \$6000 - \$7FFF  | 8K mirror of $0000 - $1FFF  |
| \$4000 - \$5FFF  | 8K mirror of $0000 - $1FFF  |
| \$2000 - \$3FFF  | 8K mirror of $0000 - $1FFF  |
| \$0000 - \$1FFF  | 8K of addressable memory    |

[AtariAge - Mirrored memory]: https://atariage.com/forums/topic/192418-mirrored-memory/?tab=comments#comment-2439795

## Sending Instructions to the Display

See [colorbg.asm](../src/2_colorbg/colorbg.asm) for usage of
the `CLEAN_START` macro from [macro.h](../src/include/macro.h).

Our program is setup to set the background color of the screen to yellow.

If you see the [Atari 2600 NTSC color palette] reference in Wikipedia, you'll
see that pure yellow has a luminance/hue value of 1/14, represented by `1E` in
hexadecimal.

[Atari 2600 NTSC color palette]: https://en.wikipedia.org/wiki/Television_Interface_Adaptor#NTSC_palette

We have a `Makefile` in our directory with the commands used to assemble our
`cart.bin` cartridge file, and also our command to run the cartridge in Stella.

```bash
cd src/2_colorbg
make all
make run
```

After running the program, you might notice that it's not displaying yellow.
You have to press the 'TAB' key to access the options, then select
'Game Properties'. Under the 'Emulation' tab, select 'NTSC' for 'TV format'.

Now we can see the yellow displayed on the screen. There is yellow and black
flickering on the screen. Why is this? Because line 8 of our program continually
is clearing the memory when we return to START.

If we comment this out and reassemble our cartridge, then run it in NTSC mode,
it will display a solid yellow background.

## Stella Debugger Warnings

You might notice when you load your cartridge in Stella that the 'Prompt' tab
has several messages shown.

```shell
Stella 6.2.1
> autoExec():

script file '~/Library/Application Support/Stella/autoexec.script' not found
script file 'cart.script' not found
config file '~/Library/Application Support/Stella/cfg/cart.cfg' not found
list file 'cart.lst' not found
symbol file 'cart.sym' not found
```

These are warning messages about certain files that Stella supports for certain
purposes. Right now our Makefile is only generating the cart.bin file as its
out put.

`dasm *.asm -f3 -v0 -ocart.bin`

We can expand this to generate other files that Stella is looking for.

`dasm *.asm -f3 -v0 -ocart.bin -lcart.lst -scart.sym`

* cart.lst - list file
* cart.sym - contains symbols from our source code, variable names, addressing
  labels, etc.

This symbols file is useful to programmers because we're able to see the labels
we use instead of just a memory address.

Before:
```Assembly
F0090:
  STA $0, X
  DEX
  BNE F0090
```

After:
```Assembly
MEMLOOP:
  STA $0, X
  DEX
  BNE F0090
```

If you run your cartridge again, you'll see the symbols used in the debugger
for Stella.

You'll still get warnings concerning these files, but these can be left alone.

* cart.script - script file
* autoexec.script - system level Stella start script
* cart.cfg - system level general Stella config

## NTSC Video Synchronization

The VCS was designed to work with two configurations of TIA chip - the NTSC
(North American) version, and PAL (most of Europe / Africa / Asia).

The NTSC synchronization method specifies a certain method of synchronization
between the CPU and the rendered display, with certain buffers of time for the
CPU to prepare the upcoming frame rendered to the screen.

Each full rendering to the entire screen is referred to as the 'frame'.

### Scanlines

In modern computers we're able to store the state of every pixel that is being
displayed on the screen. The VCS system was designed during a time when memory
was not available to store a mirror of the frame being displayed to the CRT.

The TIA chip instead deals with scanlines drawn from left to right across the
screen rapidly, from top to bottom. Programmers had to do something called
"racing the beam". Everything has to be done scanline-by-scanline.

### Horizontal Blank

How does our processor know when we are done rendering a specific scanline?
There is something called a Horizontal Blank, which takes up 68 color clocks,
which is the period of time when the 3.8 megahertz clock is not drawing the
scanline to the screen after it has finished the last scanline.

* Horizontal Blank - 68 color clocks
* Visible Scanline - 160 color clocks (pixels)

So it is during the 68 color clocks that we can reconfigure what the content of
the rendered scanline will be during the 160 color clocks.

To control when a scanline finishes, the processor is halted until it receives
a WSYNC signal from the TIA. This keeps the processor from performing actions
while the TIA is resetting.

### Vertical syncronization

The NTSC format tells us that there is a time period called the 'vertical sync',
which is 3 scanlines. This tells our VCS when a frame starts and ends.

After the 3 scanlines, there is a space called the 'vertical blank', which is
37 scanlines long, is a buffer space before rendering visible lines.

After the Vertical sync, vertical blank, and rendered scanlines, we have 30
scanlines called the 'over scan', before we start with a new frame again.

```shell
------------------------------------------------------
|            VERTICAL SYNC (3 scanlines)             |
------------------------------------------------------
|                                                    |
|           VERTICAL BLANK (37 scanlines)            |
|                                                    |
------------------------------------------------------
|              |                                     |
|              |                                     |
|              |                                     |
|  HORIZONTAL  |           RENDERED PIXELS           |
|    BLANK     |           (192 scanlines)           |
|              |                                     |
|              |                                     |
|              |                                     |
------------------------------------------------------
|                                                    |
|             OVERSCAN (30 scanlines)                |
|                                                    |
------------------------------------------------------
```

* NTSC Standard
  * Vertical Sync - 3 scanlines
  * Vertical Blank - 37 scanlines
  * Visible Scanline - 192 scanlines
  * Overscan - 30 scanlines

* Vertical color clocks - 228

There is a relationship between the color clocks, and the CPU cycles.
There are 228 total vertical color clocks (68 horizontal blank + 160 rendered),
which correspond to 76 CPU cycles.

228 color clocks / 76 CPU cycles = 3 color clocks per CPU cycle

We have to program in lockstep with these NTSC specifications.

### NTSC in Assembly

```assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start a new frame by turning on VBLANK and VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NextFrame:
  lda #2                ; same as binary #%00000010
  sta VBLANK            ; turn on VBLANK
  sta VSYNC             ; turn on VSYNC
```

We are actually going to have a loop that we run through frame by frame, jumping
to `NextFrame` after the previous loop completes.

We are storing the decimal 2 value in register A, then we're sending that value
to the VBLANK and VSYNC memory locations.

```assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate the three lines of VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  sta WSYNC             ; first scanline
  sta WSYNC             ; second scanline
  sta WSYNC             ; third scanline

  lda #0
  sta VSYNC             ; turn off VSYNC
```

When we write the value to the WSYNC memory address, this halts the processor
during the TIA scanline process for each of the 3 scanlines.

Then writing the decimal value of 0 to the VSYNC memory address ends the
VSYNC process.

```assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Output the 37 recommended lines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ldx #37               ; count of 37 scanlines
LoopVBlank:
  sta WSYNC             ; hit WSYNC to wait for the next scanline
  dex                   ; decrement X
  bne LoopVBlank        ; loop until X==0

  lda #0
  sta VBLANK            ; turn off VBLANK
```

Here we set a value in register X for the number of times we want to loop
through the process of waiting (WSYNC). We decrement the value in X, then we
loop back to `LoopVBlank` if the value of X is not equal to 0 (Break if not
equal).

After the loop is complete, we turn off the VBLANK mode.

## Painting the CRT

We're going to paint a rainbow to the CRT with our program. See our
[rainbow directory](../src/3_rainbow) for code.

[Back to Notes](./notes.md)
