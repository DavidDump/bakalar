# Formal Languages
- [wikipedia](https://en.wikipedia.org/wiki/Formal_language) \
Formal languages consist of symbols and rules which are used to construct statements or programs. They are often used in mathematics, computing or linguistics to formaly define the grammar of a language. They consist of an alphabet, the basic symbols and building blocks of the grammar. The grammar is the set of rules that describe how symbols can be combined to form words. The words combine to form the syntax of the given language. Based on the complexity of the language and the grammar that specifies it, languages can be classified into different categories, such as regular languages, context-free languages, context-sensitive languages, and recursively enumerable languages.

# Programming Languages
- [wikipedia](https://en.wikipedia.org/wiki/Programming_language) \
Programming languages are formal languages that are designed to describe specific tasks to computers. They consist of garmmar rules that make it possible to describe processor instructions in human readable language. Languages have a syntax that describes valid statements and expressions that can be translated or interpreted. Languages that handle data may ensure that the format used to write the data to memory is consistent with the format used to read the data. This is done by using a typesystem, and checking the type of each memory read and write operation. Languages may also provide ways of describing data as an aggregate type. 

TODO:
- controll flow
- abstraction
- standard library

Languages can be categorized the following ways:
- High level languages: language constructs are more removed from the hardware that the program is running on. examples: Python, Java, C#
- Low level languages: languages that are closer related in structure to the underlying hardware it is running on. examples: Assembly
- Compiled languages: these languages use a compiler to translate the source code to bytecode of the processor architecture it is targeting. examples: C, C++
- Interpreted languages: these languages use an interpreter to execute the statements the source code line by line. examples: JavaScript, (LISP), (OCAML), Haskell? NOT Python

# Programming language generations
- [wikipedia page](https://en.wikipedia.org/wiki/Programming_language_generations) \
Programming languages can be categorized into generations. The generation was used to indicate the power of the language. Earlier generations are lower level languages, while later generations are higher level languages. The term was coined to differentiate higher level languages (third generation) from lower level languages (first generation).

## First generation
- [wikipedia page](https://en.wikipedia.org/wiki/First-generation_programming_language) \
First generation programing languages are the lowest level languages. They are machine level languages that often dont require translation, leaving out the compilation and linking step entirely. This means that the language is made up of binary numbers. This is a generational way to categorize machinec code.

## Second generation
- [wikipedia page](https://en.wikipedia.org/wiki/Second-generation_programming_language) \
Second generation programming language is a generational way to categorize assembly language. The main difference from first generation languages is that the code is human readable, which makes it easier to work with than machine code. The source file is then converted to machine code using an assembler, based on the target processor family. In assembly each line consists of a mnemonic and possibly operands. The mnemonic represents a processor instruction and the operands are the values that instruction is executed on. The only place assembly is used in modern programs is kernel or driver development. Its main disadvantages are that the programmer is required to write programs on the scale of individual instructions rather than logical steps. Also the resulting program is processor architecture specific making it less portable.

## Third generation
- [wikipedia page](https://en.wikipedia.org/wiki/Third-generation_programming_language) \
Third generation programming languages are higher level and more machine independent. Some examples are: BASIC, C, Java and Pascal. These languages move the responsibility of dealing with low level concepts line memory layout, typesafety to the compiler. They are more abstract than previous languages, therefore are considered high level languages. The first high level languages were instruduced in the late 1950s. Some notable examples include: Fortran, BASIC, COBOL and C. This category contains a wide variaty of languages, therefore can be subdivided even further, like object orientedness. Programs writen in third generation languages are processor architecture agnostic.

# x86 architecture
x86 is a family of instruction set architectures (ISAs) based on the Intel 8086 microprocessor, which was introduced in 1978. It has since become the most used CPU architecture for computers. x86 is a Complex Instruction Set Computing (CISC) architecture, meaning it has a large number of instructions, where a single instructions can execute several low-level operations. Instructions are variable-length, the architecture is stack-based that supports both 16-bit and 32-bit addressing modes. The architecture also includes a large number of specialized instructions for tasks such as floating-point arithmetic, string manipulation, and memory management. The architecture ensures backwards compatibility, allowing software designed for older x86 processors to run on newer ones. It also has multiple operating modes, including real mode and protected mode.
The newer x86-64 ISA introduced support for 64-bit addressing mode, along with a 4-level paging mode. This allows for more virtual and physical memory to be used by the processor.

## 3 types of instructions
### Arithmetic and logical
Explain what the instrucitons do, why they exist and how they are used in the language

Arithmetic operations are used to perform mathematical calculations:
- Addition: ADD
- Subtraction: SUB
- Unsigned multiplication: MUL
- Signed multiplication: IMUL
- Unsigned division: DIV
- Signed division: IDIV
- Increment: INC
- Decrement: DEC

Logical operations are used to perform bitwise operations on binary data:
- AND:
- OR:
- XOR:
- NOT:
- Shift Operations:
  - shift left: SHL
  - shift right: SHR
  - shift arithmetic left: SAL
  - shift arithmetic right: SAR
- Rotate Operations:
  - rotate left: ROL
  - rotate right: ROR

### Flow control
Flow control operations in x86 architecture are instructions that alter the instruction address register. These operations are essential for implementing flow control structures such as loops, conditionals, and function calls.
- Unconditional Jump: JMP
- Conditional Jumps: \
  Conditional jumps allow the program to branch based of the state of the EFLAGS register. The CMP instruction is used to compare two values, by subtracting one from the other, without saving the result. This sets the flags in the EFLAGS register, so one of the following conditional jumps can be used:
  - JE (Jump if Equal): Jumps if the zero flag (ZF) is set.
  - JNE (Jump if Not Equal): Jumps if the zero flag (ZF) is not set.
  - JG (Jump if Greater): Jumps if the zero flag (ZF) is clear and the sign flag (SF) is equal to the overflow flag (OF).
  - JL (Jump if Less): Jumps if the sign flag (SF) is not equal to the overflow flag (OF).
  - JGE (Jump if Greater or Equal): Jumps if the sign flag (SF) is equal to the overflow flag (OF).
  - JLE (Jump if Less or Equal): Jumps if the zero flag (ZF) is set or the sign flag (SF) is not equal to the overflow flag (OF).
- Loop Instructions: \
Loop instructions are used to create loops in the program:
  - LOOP: Decrements the CX register (or ECX in 32-bit mode) and jumps to a specified label if CX is not zero.
  - LOOPZ (or LOOPE): Decrements CX and jumps if CX is not zero and the zero flag (ZF) is set.
  - LOOPNZ (or LOOPNE): Decrements CX and jumps if CX is not zero and the zero flag (ZF) is not set.
***For example this instruction can be used in the following code***!!!
if (a>0) {

}
here the instruction if LOOPNZ because the conditional is a compare to zero...

- Function Calls and Returns: \
These instructions are used for calling and returning from functions:
  - CALL: Calls a procedure by pushing the return address onto the stack and jumping to the specified address.
  - RET: Returns from a procedure by popping the return address from the stack and jumping to that address.
- Interrupts:
  - INT: Triggers a software interrupt, which can be used for system calls or to handle exceptions.
  - IRET: Returns from an interrupt service routine.

### Memory I/O
- Memory Operations: \
Memory operations involve reading from and writing to the system's memory. The primary instructions for memory operations include:
  - MOV: This instruction is used to transfer data between registers, memory locations, and I/O ports.
  - PUSH: This instruction pushes a value onto the stack.
  - POP: This instruction pops a value from the stack into a register or memory location.
  - LEA (Load Effective Address): This instruction loads the effective address of a memory operand into a register.
- I/O Operations: \
I/O operations are used to communicate with peripheral devices. In x86 architecture, there are specific instructions for handling I/O:
  - IN: This instruction reads data from an I/O port into a register.
  - OUT: This instruction writes data from a register to an I/O port.
- String Operations: \
String operations can also be considered memory operations, as they manipulate blocks of memory. Common string instructions include:
  - MOVS: Moves a string from the source address to the destination address.
  - CMPS: Compares two strings.
  - SCAS: Scans a string for a specific value.
  - LODS: Loads a string from memory into a register.
  - STOS: Stores a value from a register into a string in memory.

# Turing Machine
- [wikipedia page](https://en.wikipedia.org/wiki/Turing_machine) \
A Turing machine is a theoretical computational model developed by Alan Turing in 1936. A turing machine is made up of the following parts:
- Tape: An infinite tape, that is divided into cells, each cell can store one symbol. This serves as both the input and the memory of the machine.
- Head: It can read  the symbol in the cell it is pointing to, or write a symbol to that cell. Additionaly it can move to the left or right one cell at a time to access all the cells on the tape.
- State register: This is a memory register that is capable of storing the current state of the turing machine. The turing machine has a set of possible/available states, each state having different behavior based on the specified ruleset.
- Ruleset: A set of rules that describes the behavior of the machine for a given input tape. Each rule has a symbol the machine has to read in order to apply the rule, additionaly the machine also has to be in a given state for the rule to apply. Applying the rule means writing a symbol to the cell the head is currently pointing to. After a rule has been applied the head can optionally move one cell to the left or right, based on the specified rule.

The machine operates in the following way:
1. We specify the initial state of the machine.
2. The machine reads the symbol in the cell the head is currently pointing to, and finds the rule applicable to the given state.
3. The machine applies the rule, modifying the cell and optionally moving the head.
4. Repeat from step 2. until the machine reaches a halting state. The halting state is a special state that indicated that the machine should stop.

Turing machines are important basis for computer science theory. They establish important constepts like:
- Computability: A formal basis for what problems can be solved using algorithms. A problem is considered computable if there exists a Turing machine that is capable of solving it.
- Church-Turing thesis: A thesis that proposes that a function is computable if there exists a Turing machine that is capable of solving it.
- Complexity Theory: Turing machines are used to study the complexity of algorithms and the classification of problems based on their computational difficulty.

A computer is Turing complete if..., A programming language is turing compelete if... We can prove that if two languages are Turing Complete that they are equivalent. We can prove that ... algorithms can be solved on turing machines, ... The real computers are ... are not Turing complete...
Why is it interesting

my is turing complete: proof

# Regular Expressions
A regular expressions is a language that defines a search pattern. It is commonly used for string matching and manipulation.
Regular expressions can be used to:
- Search: Find specific patterns within text.
- Match: Determine if a string conforms to a certain pattern.
- Replace: Substitute parts of a string that match a pattern with another string.
- Split: Divide a string into an array of substrings based on a specified pattern.

A regular expressions consist of the following elements:
- Characters: Any literal characater will match themselves.
- Boolean "or" |: A vertical bar that seperates alternatives.
- Grouping: Parentheses are used to define groups and precedence of operators
- Quantification: A quantifier after an element specifies how many times the preceding element is allowed to repeat.
  - ?: The question mark indicates zero or one occurrences of the preceding element.
  - *: The asterisk indicates zero or more occurrences of the preceding element.
  - +: The plus sign indicates one or more occurrences of the preceding element.
  - {n}: The preceding item is matched exactly n times.
  - {min,}: The preceding item is matched min or more times.
  - {,max}: The preceding item is matched max or less times.
  - {min,max}: The preceding item is matched at least min times, but no more that max times.
- Wildcard: The `.` Wildcard maches any characater.
These elements can be combined to form arbitrarily complex expressions.
