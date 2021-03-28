#![no_std]
#![no_main]
#![feature(abi_efiapi)]
#![feature(lang_items)]

use core::{fmt::Write, panic::PanicInfo};
use uefi::prelude::*;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[entry]
fn efi_main(_handle: Handle, system_table: SystemTable<Boot>) -> Status {
    writeln!(system_table.stdout(), "Hello Rust!!").unwrap();

    loop {}

    // Status::SUCCESS
}

#[lang = "eh_personality"]
extern "C" fn eh_personality() {}
