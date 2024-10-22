fn main() {
    unsafe { libc::puts("Hello\0".as_ptr() as *const i8) };
}
