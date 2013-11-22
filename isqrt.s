# Integer square root of a number

print_int = 1
print_string = 4
read_int = 5

# same driver program as iter_fib.s and recu_fib.s
	.text
main:
	sub	$sp, 4
	sw	$ra, ($sp)

	li	$v0, read_int
	syscall

	move	$a0, $v0
	jal	isqrt

	move	$a0, $v0
	li	$v0, print_int
	syscall

	la	$a0, lf
	li	$v0, print_string
	syscall

	lw	$ra, ($sp)
	add	$sp, 4

	jr	$ra

# Get integer square root of $a0
# isqrt = floor(sqrt($a0))

# algorithm is build up the result (v0) one digit at
# a time. It seems pretty fast: after every loop, a variable
# that starts at the lowest power of four before the value in $a0
# gets divided by 4, and when it reaches 0 the algorithm stops. By
# dividing by 4, it can get to zero pretty quickly.
# Finding the integer square root of one million takes about 10 loops, for
# example, which is rather fast.
isqrt:
	li	$v0, 0		# result
	li	$s0, 1
	sll	$s0, $s0, 30
	move	$s1, $a0
	bgt	$s0, $s1, loop

shift:
	srl	$s0, $s0, 2
	bgt	$s0, $s1, shift

loop:
	add	$s2, $s0, $v0
	blt	$s1, $s2, shiftright
	sub	$s1, $s1, $s2
	srl	$v0, $v0, 1
	add	$v0, $v0, $s0
	b	continue

shiftright:
	srl	$v0, $v0, 1

continue:
	srl	$s0, $s0, 2
	bne	$s0, 0, loop

done:
	jr	$ra

	.data
lf:
	.asciiz	"\n"
