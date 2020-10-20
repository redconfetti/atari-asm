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

As you can see here, our background is red, with a light orange being used
to represent the playfield obstacles.

The score shown at the top is also part of the playfield.

### Playfield Patterns

How are these playfield objects drawn to the screen?

We use the PF0, PF1, and PF2 registers to define the playfield. The register
values in total represent one half of the playfield that is repeated or
reflected (mirrored).

![Playfield diagram][Playfield diagram]

[Combat game]: assets/combat.jpg
[Playfield diagram]: assets/playfield-diagram.png

[Back to Notes](./notes.md)
