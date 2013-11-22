# iterative fibonacci function

print_int = 1
print_string = 4
read_int = 5

	.text
main:
	sub	$sp, 4
	sw	$ra, ($sp)

	li	$v0, read_int
	syscall

	move	$a0, $v0
	jal	fibonacci

	move	$a0, $v0
	li	$v0, print_int
	syscall

	la	$a0, lf
	li	$v0, print_string
	syscall

	lw	$ra, ($sp)
	add	$sp, 4

	jr	$ra

# F(n) = F(n - 1) + F(n - 2)
fibonacci:
	li	$s0, 0          # first
	li	$s1, 1          # second
	li	$s2, 1          # count
	bgt	$a0, 2, numlessthan2
	li	$v0, 0		# result

numlessthan2:
	beq	$a0, 1, equalsOne
	li	$v0, 0
	b	loop

equalsOne:
	li	$v0, 1

loop:
	blt	$a0, 2, done
	bge	$s2, $a0, done

	add	$v0, $s0, $s1
	move	$s0, $s1
	move	$s1, $v0

	add	$s2, $s2, 1
	j	loop
done:
	jr	$ra

	.data
lf:
	.asciiz	"\n"
