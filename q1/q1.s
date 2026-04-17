.globl make_node
make_node:
addi sp, sp, -16
sd ra, 0(sp)
sd s0, 8(sp)

mv s0, a0             # s0 = val because a0 will need to be changed to call malloc
li a0, 24
call malloc
sw s0, 0(a0)
sd zero, 8(a0)
sd zero, 16(a0)

ld ra, 0(sp)
ld s0, 8(sp)
addi sp, sp, 16
ret

.globl insert
insert:
bnez a0, next
addi sp, sp, -16
sd ra, 0(sp)
mv a0, a1
call make_node
ld ra, 0(sp)
addi sp, sp, 16
ret

next:
addi sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)         # will store root->data
sd s1, 16(sp)        # will store root->left
sd s2, 24(sp)        # will store root->right
sd s3, 32(sp)

lw s0, 0(a0)        # s0 = root->data
ld s1, 8(a0)        # s1 = root->left
ld s2, 16(a0)       # s2 = root->right
mv s3, a1
blt s0, a1, next2
addi sp, sp, -16
sd a0, 0(sp)
mv a0, s1
mv a1, s3
call insert
mv s1, a0
ld a0, 0(sp)
sd s1, 8(a0)
addi sp, sp, 16
j next3

next2:
addi sp, sp, -16
sd a0, 0(sp)
mv a0, s2
mv a1, s3
call insert
mv s2, a0
ld a0, 0(sp)
sd s2, 16(a0)
addi sp, sp, 16

next3:
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
addi sp, sp, 48
ret

.globl get
get:
beqz a0, getnullroot
j getnotnullroot

getnullroot:
li a0, 0
ret

getnotnullroot:
addi sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)

lw s0, 0(a0)
ld s1, 8(a0)
ld s2, 16(a0)
mv s3, a1
beq s0, s3, getfound
blt s0, s3, getrightSide
bgt s0, s3, getleftSide

getfound:
j getend

getleftSide:
mv a0, s1
mv a1, s3
call get
j getend

getrightSide:
mv a0, s2
mv a1, s3
call get
j getend

getend:
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
addi sp, sp, 48
ret

.globl getAtMost
getAtMost:
addi sp, sp, -48
sd ra, 0(sp)
sd s0, 8(sp)
sd s1, 16(sp)
sd s2, 24(sp)
sd s3, 32(sp)

mv s3, a0          # s3 = val
mv s2, a1          # s2 = root
li s0, -1          # s0 = answer

atmloop:
beqz s2, atmending

lw s1, 0(s2)       # s1 = root->val
beq s1, s3, atmfound
blt s1, s3, atmright
j atmleft

atmfound:
mv a0, s1
j atmdone

atmright:
mv s0, s1          # current node is a valid candidate
ld s2, 16(s2)      # move to right child
j atmloop

atmleft:
ld s2, 8(s2)       # move to left child
j atmloop

atmending:
mv a0, s0

atmdone:
ld ra, 0(sp)
ld s0, 8(sp)
ld s1, 16(sp)
ld s2, 24(sp)
ld s3, 32(sp)
addi sp, sp, 48
ret
