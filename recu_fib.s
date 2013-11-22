# recursive fibonacci function

print_int = 1
print_string = 4
read_int = 5

	.text
main:
	sub	$sp, 4
	sw	$ra, 0($sp)

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

	lw	$ra, 0($sp)
	add	$sp, 4

	jr	$ra

# recursive fibonacci
# if n == 0 return 0
# if n == 1 return 1
# else return f(n - 1) + f(n - 2)

fibonacci:
	sub	$sp, 12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)

	move	$s0, $a0
	
	beq	$a0, 0, iszero
	beq	$a0, 1, isone
	
	sub	$a0, $s0, 1
	
	jal	fibonacci
	move	$s1, $v0
	sub	$a0, $s0, 2
	
	jal	fibonacci
	add	$v0, $v0, $s1

	b	done
iszero:
	li	$v0, 0
	b	done
isone:
	li	$v0, 1
done:
	lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	add	$sp, 12

	jr	$ra

	.data
lf:
	.asciiz	"\n"
