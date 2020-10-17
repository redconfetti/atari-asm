# Address Modes

[Back to Notes](./notes.md)

We use commands such as the 'LDA' command, used to load the 'A' register.

## Immediate Mode

The command `LDA #80` will load the 'A' register with the literal decimal value
of '80'. The hash symbol is used to specify a literal value.

This command is translated into Op code `A9 50` by the assembler.

## Absolute (Zero Page) Mode

The command `LDA $80` looks similar, but is a different instruction. This uses
a different addressing mode. This second one loads the 'A' register with the
value of the memory address at the location `$80`.

This command is translated into Op code `A5 80` by the assembler.

## Hexidemical Literal

What if we want to load the accumulator with the literal hexadecimal value of
'80'? We would use the command `LDA #$80`.

[Back to Notes](./notes.md)
