global    _start
section   .text
_start:
	mov rax, 161 ; linux x64 chroot
	mov rdi, path ; pass our path
	syscall ; and off we go...

	mov rax, 59 ; linux x64 execve
	mov rdi, sh ; shell
	mov rsi, argv ; args
	mov rdx, 0 ; env
	syscall ; replace current image with sh
path:	db "/pwn", 0
sh:	db "/bin/sh", 0
argv:	dq sh, 0
