fmt:
.string "%d "

fmt2:
.string "\n"

.text
.globl main
main:
addi sp, sp, -64
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)
sd s4, 40(sp)
sd s5, 48(sp)
sd s6, 56(sp)

mv s0, a0
addi s0, s0, -1          # s0 gets the value of n
mv s1, a1                # s1 = argv

slli t1, s0, 2
slli t2, s0, 3
add t3, t1, t2

addi t3, t3, 15
andi t3, t3, -16         # align allocation size to 16
mv s6, t3

sub sp, sp, t3

addi s3, sp, 0           # s3 gets the base address of the array
add s4, sp, t1           # s4 gets the base address of the result
add s5, s4, t1           # s5 gets the base address of the stack

li s2, 1
loop:
bgt s2, s0, next

slli t0, s2, 3
add t1, s1, t0
ld t2, 0(t1)             # argv[s2]

mv a0, t2
call atoi

addi t0, s2, -1
slli t0, t0, 2
add t1, s3, t0
sw a0, 0(t1)             # arr[s2 - 1] = atoi(argv[s2])

addi s2, s2, 1
j loop

next:
addi t0, s0, -1        # index i of the array
li t1, -1              # t1 = top of the stack

loop2:
blt t0, zero, next2
blt t1, zero, c

slli t2, t1, 2
add t2, t2, s5
lw t3, 0(t2)
mv t2, t3
slli t4, t3, 2
add t4, s3, t4
lw t3, 0(t4)

slli t4, t0, 2
add t4, t4, s3
lw t5, 0(t4)
bgt t3, t5, a
addi t1, t1, -1
j loop2

a:
blt t1, zero, c
slli t4, t0, 2
add t4, t4, s4
sw t2, 0(t4)
j next3

c:
slli t4, t0, 2
add t4, t4, s4
li t2, -1
sw t2, 0(t4)

next3:
addi t1, t1, 1
slli t2, t1, 2
add t2, s5, t2
sw t0, 0(t2)
addi t0, t0, -1
j loop2

next2:
li s2, 0
printLoop:
bge s2, s0, end
slli t1, s2, 2
add t1, t1, s4
lw t2, 0(t1)
mv a1, t2
lla a0, fmt
call printf
addi s2, s2, 1
j printLoop

end:
lla a0, fmt2
call printf
li a0, 0

add sp, sp, s6

ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
ld s4, 40(sp)
ld s5, 48(sp)
ld s6, 56(sp)
addi sp, sp, 64
ret



