.data
filename:
.string "input.txt"

buff1: .space 1
buff2: .space 1

fmt:
.string "Yes\n"
fmt2:
.string "No\n"

.globl main
main:
addi sp, sp, -48
sd s0, 0(sp)
sd s1, 8(sp)
sd s2, 16(sp)
sd s3, 24(sp)
sd s4, 32(sp)

li a0, -100
lla a1, filename
li a2, 0
li a3, 0
li a7, 56
ecall
mv s0, a0

mv a0, s0
li a1, 0
li a2, 2
li a7, 62
ecall
mv s1, a0          # s1 now has the length of the file

li s3, 0           # s3 = left pointer
addi s4, s1, -1     # s4 = right pointer

loop:
bge s3, s4, end
mv a0, s0
mv a1, s3
li a2, 0
li a7, 62
ecall

mv a0, s0
lla a1, buff1
li a2, 1
li a7, 63
ecall

mv a0, s0
mv a1, s4
li a2, 0
li a7, 62
ecall

mv a0, s0
lla a1, buff2
li a2, 1
li a7, 63
ecall

lla t0, buff1
lb t1, 0(t0)

lla t0, buff2
lb t2, 0(t0)

beq t1, t2, next
li a0, 1
lla a1, fmt2
li a2, 3
li a7, 64
ecall

mv a0, s0
li a7, 57
ecall

li a0, 0
li a7, 93
ecall

next:
addi s3, s3, 1
addi s4, s4, -1
j loop

end:
li a0, 1
lla a1, fmt
li a2, 4
li a7, 64
ecall

mv a0, s0
li a7, 57
ecall

ld s0, 0(sp)
ld s1, 8(sp)
ld s2, 16(sp)
ld s3, 24(sp)
ld s4, 32(sp)
addi sp, sp, 48

li a0, 0
li a7, 93
ecall
