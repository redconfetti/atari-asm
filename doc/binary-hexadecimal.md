# Binary and Hexadecimal

[Back to Notes](./notes.md)

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

- 10 can be divided by 2 or 5
- 12 can be divided by 2, 3, 4, or 6
- 8 can be divided by 2 or 4

Some say that we should be using base 8 or base 12. They are divisible by more
numbers than base 10.

Why do we divide the day into 24 hours? With Base 12 you can use the number as
pointer of the count, with each finger divided at the knuckles

![Base 12 Hand Diagram][Base 12 Hand Diagram]

[Base 12 Hand Diagram]: assets/base-12.png

## Base 16 - Hexadecimal

Hexadecimal is an easier to remember representation of binary representations.

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

For example this binary representation `01001111` is 79 in decimal, but '4F'
in hexadecimal.

See [Binary to Hex]

[Binary to Hex]: https://www.rapidtables.com/convert/number/binary-to-hex.html

[Back to Notes](./notes.md)
