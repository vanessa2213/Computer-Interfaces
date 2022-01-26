OS := $(shell uname)
ifeq ($(OS),Linux)
  RM = rm -rf
else
  RM = del /Q
endif

.PHONY:all
all: clean assemble compile link objcopy run

.PHONY:clean
clean:
	$(RM) *.o *.elf *.bin

assemble:
	arm-none-eabi-as -mcpu=arm926ej-s -g startup.s -o startup.o

compile:
	arm-none-eabi-gcc -mcpu=arm926ej-s -g -c  hello.c -o hello.o

link:
	arm-none-eabi-ld -T hello.ld hello.o startup.o -o hello.elf

objcopy:
	arm-none-eabi-objcopy -O binary hello.elf hello.bin

run:
	qemu-system-arm -M versatilepb -cpu arm926 -kernel hello.bin -nographic

debug:
	qemu-system-arm -M versatilepb -m 128M -cpu arm926 -kernel hello.bin -nographic -s -S

disassemble:
	arm-none-eabi-objdump -D hello.elf > hello_disassembled.s
