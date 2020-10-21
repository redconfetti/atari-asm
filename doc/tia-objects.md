# TIA Screen Objects

[Back to Notes](./notes.md)

When the Atari 2600 was being designed, they were concerned with making it a
universal Pong machine, supporting games with similar concepts as Pong or
Tank.

Standard objects:

* Background color
* Playfield - Background elements of the arena, boundaries
* Player0
* Player1
* Missile0 - From Tank
* Missile1 - From Tank
* Ball - From Pong

Scanlines will be rendered based on how we configure the TIA's screen objects
(via TIA registers).

## Background

* Takes the whole visible screen (160 x 192)
* We can only change the background color per each horizontal scanline (COLUBK)
* The background is always displayed behind all the other elements

## Playfield

* 20-bit pattern, rendered over the left side of the scanline
* One color per horizontal scanline
* The right side will either repeat or reflect the same pattern

* PF0, PF1, PF2
* COLUPF - Color of Playfield
* CTRLPF - Control Playfield (8 bit register) with flags
  * D0: Reflect
  * D1: Score
  * D2: Priority
  * D4-D5: Ball size (1, 2, 4, 8)

![Combat game][Combat game]

[Combat game]: assets/combat.jpg
[Playfield diagram]: assets/playfield-diagram.png

As you can see here, our background is red, with a light orange being used
to represent the playfield obstacles.

The score shown at the top is also part of the playfield.

### Playfield Patterns

How are these playfield objects drawn to the screen?

We use the PF0, PF1, and PF2 registers to define the playfield. The register
values in total represent one half of the playfield that is repeated or
reflected (mirrored).

![Playfield diagram][Playfield diagram]

* PF0 - 4 bits - 4,5,6,7
* PF1 - 8 bits - 7,6,5,4,3,2,1,0
* PF2 - 8 bits - 0,1,2,3,4,5,6,7

You simply set the bits in the right register, and it will be drawn to the
screen for the current scanline being rendered.

#### Example 1

* PF0 = 0000        <- <- order
* PF1 = 00000000    order -> ->
* PF2 = 00000000    <- <- order
* REFLECT = 0

Note that the PF1 register ordering is inverted.

Resulting scanline:
```shell
------------------------------------------
|                                        |
------------------------------------------
```

#### Example 2

* PF0 = 0001        <- <- order
* PF1 = 00000000    order -> ->
* PF2 = 00000000    <- <- order
* REFLECT = 0

Resulting scanline:
```shell
------------------------------------------
|X                   X                   |
------------------------------------------
```

#### Example 3

* PF0 = 0011        <- <- order
* PF1 = 00000000    order -> ->
* PF2 = 00000000    <- <- order
* REFLECT = 0

Resulting scanline:
```shell
------------------------------------------
|XX                  XX                  |
------------------------------------------
```

#### Example 4

* PF0 = 1111        <- <- order
* PF1 = 11110000    order -> ->
* PF2 = 00000000    <- <- order
* REFLECT = 0

Resulting scanline:
```shell
------------------------------------------
|XXXXXXXX            XXXXXXXX            |
------------------------------------------
```

#### Example 5

* PF0 = 1111        <- <- order
* PF1 = 11111110    order -> ->
* PF2 = 00010101    <- <- order
* REFLECT = 0

Resulting scanline:
```shell
------------------------------------------
|XXXXXXXXXXX X X X   XXXXXXXXXXX X X X   |
------------------------------------------
```

#### Example 6

* PF0 = 1111        <- <- order
* PF1 = 11111110    order -> ->
* PF2 = 00010101    <- <- order
* REFLECT = 1

Note that this is using reflect to get a mirror of the pattern.

Resulting scanline:
```shell
------------------------------------------
|XXXXXXXXXXX X X X      X X X XXXXXXXXXXX|
------------------------------------------
```

## Player

* Each is an independent 8-bit pattern (GRP0, GRP1) with a foreground color
  (COLUP0, COLUP1) that can be positioned at any column of the scanline.
* Each player can be horizontally stretched, multiplied, or inverted.
  * NUSIZ0, NUSIZ0 (number/size)
  * REFPO, REFP1 (reflect player)

| NUSIZ0 | REFP0 | Result                                |
|--------|-------|---------------------------------------|
| 000    | 0     | Normal sprite                         |
| 001    | 0     | Repeats twice                         |
| 010    | 0     | Repeats twice with space              |
| 011    | 0     | Repeats 3 times                       |
| 100    | 0     | Repeats twice with 2 spaces           |
| 101    | 0     | Stretches sprite                      |
| 110    | 0     | Repeats 3 times with spaces inbetween |
| 111    | 0     | Stretches sprite across 2 spaces      |

If the REFP0 (reflect) has a value of 1, the sprite is simply mirrored with the
same affect as listed above.

## Missiles / Ball

* Can be positioned just like players, but no bit pattern.
* Just one pixel, but it can be horizontally stretched (2x, 4x, 8x)
* M0 and M1 share the player 1 (PO) and player 2 (P1) colors
* BL uses the PF foreground color
* We have a limitation of up to 2 missiles only on the same horizontal space

## What is the Plan?

For each scanline, configure the TIA registers for each object before the beam
reaches its intended position.

The time slot is very short, forcing programmers to pick and choose what to
change, reusing as much as they can.

We want to create a simple playfield bordering our screen, with a blue
background.

* 7 scanlines - no playfield
* 7 scanlines - top playfield border
* 164 scanlines - playfield only on sides of screen
* 7 scanlines - top playfield border
* 7 scanlines - no playfield

![Playfield Example 1][Playfield Example 1]

[Playfield Example 1]: assets/playfield-example-1.png

## Modifying the Playfield Registers

See [playfield.asm](../src/4_playfield/playfield.asm)

For our 3 lines of VSYNC, we're able to use a feature of the DASM assembler
using the keywords `REPEAT` and `REPEND` to repeat our VSYNC expression 3 times.

```assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Generate the three lines of VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  REPEAT 3
    sta WSYNC ; three scanlines for VSYNC
  REPEND

  lda #0
  sta VSYNC       ; turn off VSYNC
```

We can use the same thing for our 37 lines of VBLANK

```assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Let the TIA output the recommended 37 scanlines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  REPEAT 37
    sta WSYNC
  REPEND

  lda #0
  sta VBLANK      ; turn off VBLANK
```

We use a literal binary value to set the reflection register for the playfield
to 1.

```assembly
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set the CTRLPF register to allow playfield reflection
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ldx #%00000001 ; CTRLPF register (D0 means reflect the PF)
  stx CTRLPF
```

[Back to Notes](./notes.md)
