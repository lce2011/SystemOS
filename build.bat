nasm -f bin ./src/boot.asm -o ./bin/boot.bin

"C:\Program Files\qemu\qemu-system-i386.exe" -hda ./bin/boot.bin