all:
	dasm cleanmem.asm -f3 -v0 -ocart.bin -lcart.lst -scart.sym

run:
	stella cart.bin &

clean:
	@rm -f *.bin
	@rm -f *.lst
	@rm -f *.sym
	@echo 'Cleaned'
	@echo ''
