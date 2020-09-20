# Stella Emulator

[Back to Notes](./notes.md)

## Debugger

The [Stella Atari 2600 VCS emulator] comes with a debugger. This is where we
can really detect if our assembly code really does what we expect it to do
when run in the emulator.

Pressing the back-tick key on the keyboard will open the debugger mode.

![Stella Debugger][Stella Debugger]

### Video Preview

In the upper-left corner, there is a box which displays a visual representation
of what is displayed on the television set via the TIA chip.

### Prompt Tab

It has a console that accepts commands such as `help`.

### TIA Tab

It has a 'TIA' tab that can be used to view the television interface adapter
(TIA) chip registers.

![Stella Debugger TIA view][Stella Debugger TIA]

### Input/Output (I/O) Tab

The 'I/O' tab provides the state of the joystick inputs and more.

![Stella Debugger IO view][Stella Debugger IO]

### Audio Tab

The 'Audio' tab provides the state of the audio system.

![Stella Debugger Audio view][Stella Debugger Audio]

### CPU Registers

In the upper-right section of this window, we can see the registers of the
processor itself.

![Stella Debugger CPU Registers][Stella Debugger CPU Registers]

Displayed are:

- PC - Program Counter
- SP - Stack Pointer
- A - Register A
- X - Register X
- Y - Register Y
- PS - Processor Status flags
  - Negative flag
  - Overflow flag
  - Zero flag
  - Carry flag

### Memory Registers

Below the CPU register display, the memory registers and their hex values ar
shown.

![Stella Debugger Memory][Stella Debugger Memory]

### Disassembly Tab

The lower-right section of the debugger window features the 'Disassembly' tab
with the assembly commands for our ROM listed, along with the hex value
representations of those commands listed to the column on the right.

The hex representations are the op codes converted to the format used with the
6502 processor.

![Stella Debugger Disassembly][Stella Debugger Disassembly]

#### Running Commands

If you right-click on the first line (`SEI`), a menu will show that lets you
choose to 'Set PC @ current line'. You'll see the 'PC' register above set to the
address of the line after you choose this option.

![Stella Debugger Disassembly Set PC][Stella Debugger Disassembly Set PC]

We can run our ROM again from the beginning now by pressing 'Step'. This will
run each command one at a time, allowing you to see the actions of the commands
as they modify the CPU and memory registers.

[Stella Atari 2600 VCS emulator]: https://stella-emu.github.io/
[Stella Debugger]: assets/stella-debugger-full.png
[Stella Debugger TIA]: assets/stella-debugger-tia.png
[Stella Debugger Audio]: assets/stella-debugger-audio.png
[Stella Debugger IO]: assets/stella-debugger-io.png
[Stella Debugger CPU]: assets/stella-debugger-processor.png
[Stella Debugger CPU Registers]: assets/stella-debugger-cpu-registers.png
[Stella Debugger Disassembly]: assets/stella-debugger-disassembly.png
[Stella Debugger Disassembly Set PC]: assets/stella-debugger-disassembly-set-pc.png
[Stella Debugger Memory]: assets/stella-debugger-memory.png

[Back to Notes](./notes.md)
