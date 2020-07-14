# Tock 2.0 System Call Exploration

One of the goals for Tock 2.0 is to increase the number of values that can be
returned from a system call from 1 to N. A major question is whether N should be
2 or more, and how many more.

This question seems to boil down to performance and ergonomics in C and Rust.
Specifically, if we can return more values with no performance or ergonomic
overhead, we want to allow more return values. But if it's constly to do so, we shouldn't.

The working hypothesis is that 2 return values will be both ergonomic and
performant since they can simply be packed into an int64_t/i64 single return
value in C. Moreover, it *might* be performant to allow up to 4 return values as
we're already using 4 registers for system call arguments. However, it's unclear
whether this would be ergonomic (especially in C where multiple return values
are not supported) and if it indeed would be performant.

To ground this in (at least anecdotal) data, we wrote a prototype implementation
of a userland system call wrapper in both C and Rust with 4 return values, used
them to write three functions of varying complexities, and compiled each (with
optimizations) to Thumb assembly to see what the resulting binaries actually do.

The results are in `test.c.s` for the C version and `test.rs.s` for the Rust version.