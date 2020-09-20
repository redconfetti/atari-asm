default: help

# Show make usage
help:
	@echo ''
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo '  build      Compiles cleanmem.asm to binary executable'
	@echo '  run        Run cartridge in Stella emulator'
	@echo '  clean      Removes binaries'
	@echo ''

# Assemble for Atari 2600
build:
	@dasm cleanmem.asm -f3 -v0 -ocart.bin
	@echo 'Build complete'
	@echo ''

# Run cartridge in Stella Emulator
run:
	@/usr/local/bin/stella ./cart.bin &

# Clean up directory
clean:
	@rm -f cart.bin
	@echo 'Cleaned'
	@echo ''
