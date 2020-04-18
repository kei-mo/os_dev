	.file	"bootpack.c"
	.text
	.section	.rodata
.LC0:
	.string	"ABC 123"
.LC1:
	.string	"Haribote OS"
	.text
	.globl	HariMain
	.type	HariMain, @function
HariMain:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	$4080, -8(%rbp)
	call	init_palette
	movq	-8(%rbp), %rax
	movzwl	6(%rax), %eax
	movswl	%ax, %edx
	movq	-8(%rbp), %rax
	movzwl	4(%rax), %eax
	movswl	%ax, %ecx
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	movl	%ecx, %esi
	movq	%rax, %rdi
	call	init_screen
	movq	-8(%rbp), %rax
	movzwl	4(%rax), %eax
	movswl	%ax, %esi
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	leaq	.LC0(%rip), %r9
	movl	$7, %r8d
	movl	$8, %ecx
	movl	$8, %edx
	movq	%rax, %rdi
	call	putfonts8_asc
	movq	-8(%rbp), %rax
	movzwl	4(%rax), %eax
	movswl	%ax, %esi
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	leaq	.LC1(%rip), %r9
	movl	$0, %r8d
	movl	$31, %ecx
	movl	$31, %edx
	movq	%rax, %rdi
	call	putfonts8_asc
	movq	-8(%rbp), %rax
	movzwl	4(%rax), %eax
	movswl	%ax, %esi
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	leaq	.LC1(%rip), %r9
	movl	$7, %r8d
	movl	$30, %ecx
	movl	$30, %edx
	movq	%rax, %rdi
	call	putfonts8_asc
.L2:
	call	io_hlt@PLT
	jmp	.L2
	.cfi_endproc
.LFE0:
	.size	HariMain, .-HariMain
	.globl	init_palette
	.type	init_palette, @function
init_palette:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	table_rgb.1853(%rip), %rdx
	movl	$15, %esi
	movl	$0, %edi
	call	set_palette
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	init_palette, .-init_palette
	.globl	set_palette
	.type	set_palette, @function
set_palette:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	call	io_load_eflags@PLT
	movl	%eax, -4(%rbp)
	call	io_cli@PLT
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	movl	$968, %edi
	call	io_out8@PLT
	movl	-20(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.L6
.L7:
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	shrb	$2, %al
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$969, %edi
	call	io_out8@PLT
	movq	-32(%rbp), %rax
	addq	$1, %rax
	movzbl	(%rax), %eax
	shrb	$2, %al
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$969, %edi
	call	io_out8@PLT
	movq	-32(%rbp), %rax
	addq	$2, %rax
	movzbl	(%rax), %eax
	shrb	$2, %al
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$969, %edi
	call	io_out8@PLT
	addq	$3, -32(%rbp)
	addl	$1, -8(%rbp)
.L6:
	movl	-8(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jle	.L7
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	io_store_eflags@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	set_palette, .-set_palette
	.globl	boxfill8
	.type	boxfill8, @function
boxfill8:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, %eax
	movl	%ecx, -36(%rbp)
	movl	%r8d, -40(%rbp)
	movl	%r9d, -44(%rbp)
	movb	%al, -32(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.L10
.L13:
	movl	-36(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.L11
.L12:
	movl	-8(%rbp), %eax
	imull	-28(%rbp), %eax
	movl	%eax, %edx
	movl	-4(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rax, %rdx
	movzbl	-32(%rbp), %eax
	movb	%al, (%rdx)
	addl	$1, -4(%rbp)
.L11:
	movl	-4(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jle	.L12
	addl	$1, -8(%rbp)
.L10:
	movl	-8(%rbp), %eax
	cmpl	16(%rbp), %eax
	jle	.L13
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	boxfill8, .-boxfill8
	.globl	init_screen
	.type	init_screen, @function
init_screen:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	-16(%rbp), %eax
	leal	-29(%rax), %edx
	movl	-12(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	%ecx, %r9d
	movl	$0, %r8d
	movl	$0, %ecx
	movl	$14, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-28(%rax), %edx
	movl	-12(%rbp), %eax
	leal	-1(%rax), %edi
	movl	-16(%rbp), %eax
	leal	-28(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	%edi, %r9d
	movl	%ecx, %r8d
	movl	$0, %ecx
	movl	$8, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-27(%rax), %edx
	movl	-12(%rbp), %eax
	leal	-1(%rax), %edi
	movl	-16(%rbp), %eax
	leal	-27(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	%edi, %r9d
	movl	%ecx, %r8d
	movl	$0, %ecx
	movl	$7, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-12(%rbp), %eax
	leal	-1(%rax), %edi
	movl	-16(%rbp), %eax
	leal	-26(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	%edi, %r9d
	movl	%ecx, %r8d
	movl	$0, %ecx
	movl	$8, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-24(%rax), %edx
	movl	-16(%rbp), %eax
	leal	-24(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	$59, %r9d
	movl	%ecx, %r8d
	movl	$3, %ecx
	movl	$7, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-4(%rax), %edx
	movl	-16(%rbp), %eax
	leal	-24(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	$2, %r9d
	movl	%ecx, %r8d
	movl	$2, %ecx
	movl	$7, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-4(%rax), %edx
	movl	-16(%rbp), %eax
	leal	-4(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	$59, %r9d
	movl	%ecx, %r8d
	movl	$3, %ecx
	movl	$15, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-5(%rax), %edx
	movl	-16(%rbp), %eax
	leal	-23(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	$59, %r9d
	movl	%ecx, %r8d
	movl	$59, %ecx
	movl	$15, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-3(%rax), %edx
	movl	-16(%rbp), %eax
	leal	-3(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	$59, %r9d
	movl	%ecx, %r8d
	movl	$2, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-3(%rax), %edx
	movl	-16(%rbp), %eax
	leal	-24(%rax), %ecx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rdx
	movl	$60, %r9d
	movl	%ecx, %r8d
	movl	$60, %ecx
	movl	$0, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-24(%rax), %ecx
	movl	-12(%rbp), %eax
	leal	-4(%rax), %r8d
	movl	-16(%rbp), %eax
	leal	-24(%rax), %edi
	movl	-12(%rbp), %eax
	leal	-47(%rax), %edx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rcx
	movl	%r8d, %r9d
	movl	%edi, %r8d
	movl	%edx, %ecx
	movl	$15, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-4(%rax), %ecx
	movl	-12(%rbp), %eax
	leal	-47(%rax), %r8d
	movl	-16(%rbp), %eax
	leal	-23(%rax), %edi
	movl	-12(%rbp), %eax
	leal	-47(%rax), %edx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rcx
	movl	%r8d, %r9d
	movl	%edi, %r8d
	movl	%edx, %ecx
	movl	$15, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-3(%rax), %ecx
	movl	-12(%rbp), %eax
	leal	-4(%rax), %r8d
	movl	-16(%rbp), %eax
	leal	-3(%rax), %edi
	movl	-12(%rbp), %eax
	leal	-47(%rax), %edx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rcx
	movl	%r8d, %r9d
	movl	%edi, %r8d
	movl	%edx, %ecx
	movl	$7, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	movl	-16(%rbp), %eax
	leal	-3(%rax), %ecx
	movl	-12(%rbp), %eax
	leal	-3(%rax), %r8d
	movl	-16(%rbp), %eax
	leal	-24(%rax), %edi
	movl	-12(%rbp), %eax
	leal	-3(%rax), %edx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	pushq	%rcx
	movl	%r8d, %r9d
	movl	%edi, %r8d
	movl	%edx, %ecx
	movl	$7, %edx
	movq	%rax, %rdi
	call	boxfill8
	addq	$8, %rsp
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	init_screen, .-init_screen
	.globl	putfont8
	.type	putfont8, @function
putfont8:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -32(%rbp)
	movl	%ecx, -36(%rbp)
	movl	%r8d, %eax
	movq	%r9, -48(%rbp)
	movb	%al, -40(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L17
.L26:
	movl	-36(%rbp), %edx
	movl	-12(%rbp), %eax
	addl	%edx, %eax
	imull	-28(%rbp), %eax
	movslq	%eax, %rdx
	movl	-32(%rbp), %eax
	cltq
	addq	%rax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -13(%rbp)
	cmpb	$0, -13(%rbp)
	jns	.L18
	movq	-8(%rbp), %rax
	movzbl	-40(%rbp), %edx
	movb	%dl, (%rax)
.L18:
	movsbl	-13(%rbp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	.L19
	movq	-8(%rbp), %rax
	leaq	1(%rax), %rdx
	movzbl	-40(%rbp), %eax
	movb	%al, (%rdx)
.L19:
	movsbl	-13(%rbp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	.L20
	movq	-8(%rbp), %rax
	leaq	2(%rax), %rdx
	movzbl	-40(%rbp), %eax
	movb	%al, (%rdx)
.L20:
	movsbl	-13(%rbp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	.L21
	movq	-8(%rbp), %rax
	leaq	3(%rax), %rdx
	movzbl	-40(%rbp), %eax
	movb	%al, (%rdx)
.L21:
	movsbl	-13(%rbp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	.L22
	movq	-8(%rbp), %rax
	leaq	4(%rax), %rdx
	movzbl	-40(%rbp), %eax
	movb	%al, (%rdx)
.L22:
	movsbl	-13(%rbp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	.L23
	movq	-8(%rbp), %rax
	leaq	5(%rax), %rdx
	movzbl	-40(%rbp), %eax
	movb	%al, (%rdx)
.L23:
	movsbl	-13(%rbp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	.L24
	movq	-8(%rbp), %rax
	leaq	6(%rax), %rdx
	movzbl	-40(%rbp), %eax
	movb	%al, (%rdx)
.L24:
	movsbl	-13(%rbp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	.L25
	movq	-8(%rbp), %rax
	leaq	7(%rax), %rdx
	movzbl	-40(%rbp), %eax
	movb	%al, (%rdx)
.L25:
	addl	$1, -12(%rbp)
.L17:
	cmpl	$15, -12(%rbp)
	jle	.L26
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	putfont8, .-putfont8
	.globl	putfonts8_asc
	.type	putfonts8_asc, @function
putfonts8_asc:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, %eax
	movq	%r9, -32(%rbp)
	movb	%al, -24(%rbp)
	jmp	.L29
.L30:
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	sall	$4, %eax
	movslq	%eax, %rdx
	leaq	hankaku(%rip), %rax
	leaq	(%rdx,%rax), %r8
	movsbl	-24(%rbp), %edi
	movl	-20(%rbp), %ecx
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %esi
	movq	-8(%rbp), %rax
	movq	%r8, %r9
	movl	%edi, %r8d
	movq	%rax, %rdi
	call	putfont8
	addl	$8, -16(%rbp)
	addq	$1, -32(%rbp)
.L29:
	movq	-32(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L30
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	putfonts8_asc, .-putfonts8_asc
	.data
	.align 32
	.type	table_rgb.1853, @object
	.size	table_rgb.1853, 48
table_rgb.1853:
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	0
	.byte	-1
	.byte	-1
	.byte	0
	.byte	0
	.byte	0
	.byte	-1
	.byte	-1
	.byte	0
	.byte	-1
	.byte	0
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-58
	.byte	-58
	.byte	-58
	.byte	-124
	.byte	0
	.byte	0
	.byte	0
	.byte	-124
	.byte	0
	.byte	-124
	.byte	-124
	.byte	0
	.byte	0
	.byte	0
	.byte	-124
	.byte	-124
	.byte	0
	.byte	-124
	.byte	0
	.byte	-124
	.byte	-124
	.byte	-124
	.byte	-124
	.byte	-124
	.ident	"GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0"
	.section	.note.GNU-stack,"",@progbits
