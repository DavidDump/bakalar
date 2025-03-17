# x86 architecture
some history about the architecture, maybe about the itanium and how Intel was unable to standardize a new ISA despite spending millions on it. readining about the instructions and why some exist, explain what is the purpose of some instructions. some closing thoughts that summarize the section.

Explain how the architecture works, how instructions are encoded, maybe some datail about x86 thats needed to understand how certaint instructions work.

## Anatomy of an instruction
x86 is a varriable length instrucion set, meaning each instruction can have a different length. The processor has no way of knowing the length of the instruction its about to read, only by reading and processing the bytes does it know when it reaches the end of an instrucion.
A single instrucion has a size limit of 15 bytes.
|||||||
|:-:|:-:|:-:|:-:|:-:|:-:|
|Rex prefix|Opcode|ModR/M|SIB|Displacement|Immediate|
|1 byte <br> optonal|1-3 bytes|1 byte <br> optional|1 byte <br> optional|1-4 bytes <br> optional|1-8 bytes <br> optional|

- **ModR/M byte**: The ModR/M byte consists of 3 "fields" in this order: the mod(2 bits), the reg(3 bits) and the rm(3 bits) field. 
  - Reg and RM fields: There are 8 addressable registers in 32-bit mode, each represented by a 3 bit number: eax(0), ecx(1), edx(2), ebx(3), esp(4), ebp(5), esi(6), edi(7). These numbers are used in the rm and reg field to encode the two operands of the instuction. Whether the rm or reg field is used as the first of second operand is determined by the opcode.
  - Mod field: The mod field is used to indicate the addressing mode:
    ```
    PUSH, eax             ; mod = 3, direct addressing
    PUSH, [eax]           ; mod = 0, indirect addressing without displacement
    PUSH, [eax + 0x12]    ; mod = 1, indirect addressing with 8 bit displacement
    PUSH, [eax + 0x1234]  ; mod = 2, indirect addressing with 32 bit displacement
    ```
  - Reg field extention: If the instrucion only uses one operand the reg field can be used to extend the opcode. In this case the reg field doesnt contain a register but a opcode extention instead.
- **Displacement**: Displacement is the value added to the register in the rm field of the ModR/M byte, in case of mod = 1 or mod = 2.
- **Opcode**: The opcode of the instruction, some instructions that address only one register, use the bottom 3 bits to store that register, removing the need for a ModR/M byte.
- **SIB byte**: A SIB byte can only be present if a ModR/M byte is also presend in the instrucion. The SIB byte follows a similar layout to the ModR/M byte only with the following fields: scale(2), index(3), base(3). This byte indicates one of the operands will have the following form:
  ```
  PUSH [base + index * scale]
  ```
  Base and index are register given in the same form as in the ModR/M byte. The scale can be one of the following values:
  - X1: scale = 0
  - X2: scale = 1
  - X4: scale = 2
  - X8: scale = 3
- **REX prefix**: The REX prefix is used in 64-bit mode to extend the number of addressable register. The top 4 bits have to be set to 0b0100. The bottom 4 bits specify the following one bit fields: W, R, X, B. These fields are used to extend the existing register locations. The new registers are as follows: r8(8), r9(9), r10(10), r11(11), r12(12), r13(13), r14(14), r15(15)
  - W field: The W field is set when the operand size is 64 bits.
  - R field: If the reg field of the ModR/M byte contains an operand register the R field is used to extend it.
  - X field: If the index field of the SIB byte contains an operand register the X field is used to extend it.
  - B field: This field can extend either the rm field of the ModR/M byte, or the base field of the SIB byte, depending on what type of addressing is used.
- **Immediate**: The immediate data value used, if one of the operands is an immediate (literal).

## Syntax
x86 assmebly language has two main forms of syntax: Intel syntax and AT&T syntax. Intel syntax is mainly used in the Windows world, and AT&T syntax is dominant in the Unix world, since Unix was created at AT&T Bell Labs. The main differences are:
||AT&T|Intel|
|---|---|---|
|Registers and literals|Registers are prefixed with % (%rax), literals are prefixed with $ ($5).|Neither registers nor literals are prefixed.|
|Parameter order|`MOVQ $5, %rax` <br> Source before the destination.|`MOV rax, 5` <br> Destination before source.|
|Parameter size|`MOVL $0x24, %eax` <br> Mnemonics are suffixed with a letter indicating the size of the operands: <br> q - 64-bits <br> l - 32-bits <br> w - 16-bits <br> b - 8-bits.|`MOV eax, 0x24` <br> Derived from the name of the register used. <br> rax - 64-bit <br> eax - 32-bit <br> ax - 16-bit <br> ah/al - 8-bit|
|Effective addresses|`MOVQ offset(%rbx, %rcx, 4), %rax` <br> General syntax: DISPLACEMENT(BASE, INDEX, SCALE) <br> In this example the displacement type "offset" is used the calculate the address for: %rbx + %rcx * 4|`MOV rax, [ebx + ecx * 4]` <br> Arithmetic expressions in square brackets. Size keywords like "byte", "word", "dword" or "qword" have to be used if the size cannot be determined from the operands.|

In the examples I will be using Intel syntax.
## Registers
TODO: something about registers

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
Furthermore both the MUL and the DIV instructions have a signed version. These instructions behave the same as their unsigned counterpart with the only differnce being that the result will have the correct sign in case of performing the opration on a positive and a negative number.
```
IMUL rbx        ; rdx:rax = rax * rbx
IDIV rcx        ; rax = rdx:rax / rcx, rdx = remainder
```
The ADD and SUB instructions dont have a separate signed version as the sign of the result will be correct when performing these operations on either signed or unsigned operands, provided that both operands are of the same signedness.

TODO: maybe mention INC and DEC

## Logical instrucions
Logical instructions perform operations on the individual bits of the operands.

The AND(&), OR(|), XOR(^) instructions each take two operands that they compare bit by bit and set the result bit based on a truth table:
|A|B|A & B|A \| B|A ^ B|
|---|---|:-:|:-:|:-:|
|0|0|0|0|0|
|0|1|0|1|1|
|1|0|0|1|1|
|1|1|1|1|0|

These instructions follow the same pattern in their syntax, the first operand is the destination and the second is the source. In the following examples rax contains 34 and rbx contains 35.
#### AND example:
```
; 34 = 0b100010
; 35 = 0b100011
; AND ----------
;      0b100010
AND rax, rbx    ; rax = rax & rbx
```
#### OR example:
```
; 34 = 0b100010
; 35 = 0b100011
; OR  ----------
;      0b100011
OR rax, rbx     ; rax = rax | rbx
```
#### XOR example:
```
; 34 = 0b100010
; 35 = 0b100011
; XOR ----------
;      0b000001
XOR rax, rbx     ; rax = rax ^ rbx
```

The NOT instrucion only has one operand, it simply inverts all the bits.
```
MOV rax, 42     ; 0b101010
NOT rax         ; after the instruction rax will contain 0b010101
```

TODO: left shift, right shift

## Flow control instrucions

## Memory I/O instrucions
