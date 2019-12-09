global    _start
section   .text
_start:
	mov rax, 161 ; linux x64 chroot
	mov rdi, path ; pass our path
	syscall ; and off we go...

	test rax,rax ; error check
	jnz err

	mov rax, 80 ; linux x64 chdir
	mov rdi, root
	syscall

	test rax,rax ; error check
	jnz err


	mov rax, 59 ; linux x64 execve
	mov rdi, sh ; shell
	mov rsi, argv ; args
	mov rdx, env ; env
	syscall ; replace current image with sh
	; go straight to error if we don't replace the image
err:
	mov rax, 1
	mov rdi, 2
	mov rsi, msg
	mov rdx, msg_end - msg
	syscall

	mov rax, 60
	mov rdi, -1
	syscall

path:	db "/pwn", 0
sh:	db "/bin/sh", 0
msg:	db "Error: probably /pwn not mounted",10
root:	db "/",0
msg_end:
argv:	dq sh
env:	dq 0
