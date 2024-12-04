# x86 architecture
some history about the architecture, maybe about the itanium and how Intel was unable to standardize a new ISA despite spending millions on it. readoning about the instructions and why some exist, explain what is the purpose of some instructions. some closing thoughts that summarize the section.

## Registers
TODO: something about registers

Mention using intet syntax for assembly.
## Arithmetic instrucions
The processor has a component called the ALU (arithmetic logic unit), that is capable of performing basic arithmetic and logical operations on some data. The most basic ones include: addition (ADD), subtraction (SUB), multiplications (MUL), division (DIV). The ADD and SUB operations require two opearands, the source and the destination:
```
ADD rax, rbx    ; rax = rax + rbx
SUB rax, rbx    ; rax = rax - rbx
```
The MUL instructions only requires one operand, as the RAX register is impicitly used as one of the operands of the multiplication. As both the operands of the instruction are 64-bit registers the result can overflow by more that just one bit. For this reason the result is stored in two 64-bit registers, the upper bits in RDX and the lower bits in RAX.
```
MUL rbx         ; rdx:rax = rax * rbx
```
The DIV instruction is the inverse of MUL so the input is given in two 64-bit registers, the upper bits in RDX and the lower in RAX. The instruction only takes one operand, the divisor. After the operation is performed the result is stored in two registers, RAX will contain the whole part of the result and RDX will conaint the ramainder of the division.
```
DIV rcx         ; rax = rdx:rax / rcx, rdx = remainder
```
Furthermore both the MUL and the DIV instructions have a signed version. These instructions behave the same as their unsigned counterpart with the only differnce being that the result will have the correct sign in case of parforming the opration on a positive and a nagative number.
```
IMUL rbx        ; rdx:rax = rax * rbx
IDIV rcx        ; rax = rdx:rax / rcx, rdx = remainder
```
The ADD and SUB instructions dont have a separate signed version as the sign of the result will be correct when performing these operations on either signed or unsigned operands, provided that both operands are of the same signedness.

## Logical instrucions
Logical instructions perform operations on the individual bits of the data.

The AND operation compares the two operands bit by bit and sets the result bit based on this truth table:
|A|B|result|
|---|---|:-:|
|0|0|0|
|0|1|0|
|1|0|0|
|1|1|1|
