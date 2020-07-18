.PHONY: all
all: test.c.s test2.c.s test.rs.s

.PHONY: clean
clean:
	rm -f test.c.s test2.c.s test.rs.s

test.c.s: test.c test.h
	arm-none-eabi-gcc -O3 -S $< -o $@

test2.c.s: test2.c test2.h
	arm-none-eabi-gcc -O3 -S $< -o $@

test.rs.s: test.rs
	rustc --target=thumbv7em-none-eabi -Copt-level=3 --crate-type=lib --emit asm -o $@ $<
