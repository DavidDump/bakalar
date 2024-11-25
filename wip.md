# Formal Languages
- [wikipedia](https://en.wikipedia.org/wiki/Formal_language)
Formal languages consist of symbols and rules which are used to construct statements or programs. They are often used in mathematics, computing or linguistics to formaly define the grammar of a language. They consist of an alphabet, the basic symbols and building blocks of the grammar. The grammar is the set of rules that describe how symbols can be combined to form words. The words combine to form the syntax of the given language. Based on the complexity of the language and the grammar that specifies it, languages can be classified into different categories, such as regular languages, context-free languages, context-sensitive languages, and recursively enumerable languages.

# Programming Languages
- [wikipedia](https://en.wikipedia.org/wiki/Programming_language)
Programming languages are formal languages that are designed to describe specific tasks to computers. They consist of garmmar rules that make it possible to describe processor instructions in human language. Languages have a syntax that describes valid statements and expressions that can be translated or interpreted. Languages that handle data may ensure that the format used to write the data to memory is consistent with the format used to read the data. This is done by using a typesystem, and checking the type of each memory read and write operation. Languages may also provide ways of describing data as an aggregate type. 
TODO:
- controll flow
- abstraction
- standard library
Languages can be categorized the following ways:
- High level languages: language constructs are more removed from the hardware that the program is running on. examples: Python, Java, C#
- Low level languages: languages that are closer related in structure to the underlying hardware it is running on. examples: Assembly
- Compiled languages: these languages use a compiler to translate the source code to bytecode of the processor architecture it is targeting. examples: C, C++
- Interpreted languages: these languages use an interpreter to execute the statements the source code line by line. examples: Python, JavaScript

# Programming language generations
- [wikipedia page](https://en.wikipedia.org/wiki/Programming_language_generations)
Programming languages can be categorized into generations. The generation was used to indicate the power of the language. Earlier generations are lower level languages, while later generations are higher level languages. The term was coined to differentiate higher level languages (third generation) from lower level languages (first generation).

## First generation
- [wikipedia page](https://en.wikipedia.org/wiki/First-generation_programming_language)
First generation programing languages are the lowest level languages. They are machine level languages that often dont require translation, leaving out the compilation and linking step entirely. This means that the language is made up of binary numbers. This is a generational way to categorize machinec code.

## Second generation
- [wikipedia page](https://en.wikipedia.org/wiki/Second-generation_programming_language)
Second generation programming language is a generational way to categorize assembly language. The main difference from first generation languages is that the code is human readable, which makes it easier to work with than machine code. The source file is then converted to machine code using an assembler, based on the target processor family. In assembly each line consists of a mnemonic and possibly operands. The mnemonic represents a processor instruction and the operands are the values that instruction is executed on. The only place assembly is used in modern programs is kernel or driver development. Its main disadvantages are that the programmer is required to write programs on the scale of individual instructions rather than logical steps. Also the resulting program is processor architecture specific making it less portable.

## Third generation
- [wikipedia page](https://en.wikipedia.org/wiki/Third-generation_programming_language)
Third generation programming languages are higher level and more machine independent. Some examples are: BASIC, C, Java and Pascal. These languages move the responsibility of dealing with low level concepts line memory layout, typesafety to the compiler. They are more abstract than previous languages, therefore are considered high level languages. The first high level languages were instruduced in the late 1950s. Some notable examples include: Fortran, BASIC, COBOL and C. This category contains a wide variaty of languages, therefore can be subdivided even further, like object orientedness. Programs writen in third generation languages are processor architecture agnostic.

# Turing Machine
- [wikipedia page](https://en.wikipedia.org/wiki/Turing_machine)
A Turing machine is a theoretical computational model developed by Alan Turing in 1936. A turing machine is made up of the following parts:
- Tape: An infinite tape, that is divided into cells, each cell can store one symbol. This serves as both the input and the memory of the machine.
- Head: It can read  the symbol in the cell it is pointing to, or write a symbol to that cell. Additionaly it can move to the left or right one cell at a time to access all the cells on the tape.
- State register: This is a memory register that is capable of storing what state the turing machine is currenty in. The turing machine has a set of states that it can be in, each state having different behavior based on the ruleset specified.
- Ruleset: A set of rules that describes the behavior of the machine for a given input tape. Each rule has a symbol the machine has to read in order to apply the rule, additionaly the machine also has to be in a given state for the rule to apply. Applying the rule means writing a symbol to the cell the head is currently pointing to. After a rule has been applyed the head cen optionally move one cell to the left of right, based on what is specified in the rule.

The machine operates in the following way:
1. An initial state is specified, that the machine starts in.
2. The machine reads the symbols in the cell the head is currently pointing to, and finds the rule applicable based on the state.
3. The machine applyes the rule, modifying the cell and optionally moving the head.
4. Repeat from step 2. until the machine reaches a halting state. The halting state is a special state that indicated that the machine should stop.

Turing machines are important basis for computer science theory. It establishes important constepts like:
- Computability: A formal basis for what problems can be solved using algorithms. A problem is considered computable if there exists a Turing machine that is capable of solving it.
- Church-Turing thesis: A thesis that proposes that a function is computable if there exists a Turing machine that is capable of solving it.
- Complexity Theory: Turing machines are used to study the complexity of algorithms and the classification of problems based on their computational difficulty.
