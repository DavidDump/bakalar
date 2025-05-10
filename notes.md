## Formal Languages
Formal languages are structured systems of symbols and rules used to create statements, expressions, or programs in a precise and unambiguous way. They are often used in mathematics, computer science, linguistics, and logic to define syntax and semantics rigorously.

Key characteristics of formal languages include:
- Alphabet: A finite set of symbols from which strings (sequences of symbols) can be formed.
- Grammar: A set of rules that defines how symbols can be combined to form valid strings. This can include production rules in formal grammars, such as context-free grammars.
- Syntax: The structure or form of the strings in the language, determined by the grammar.
- Semantics: The meaning associated with the strings or expressions in the language, which can be defined separately from the syntax.
- Types: Formal languages can be classified into different types based on their complexity and the types of grammars that generate them, such as regular languages, context-free languages, context-sensitive languages, and recursively enumerable languages.

Formal languages are foundational in areas such as programming language design, automata theory, and formal verification, where precise definitions are crucial for correctness and clarity.

## Programming Languages
Programming languages are formal languages designed for instructing computers to perform specific tasks. They consist of a set of rules and syntax that allow developers to write code that can be executed by a computer. Programming languages enable the creation of software applications, algorithms, and systems by providing a means to express computations and data manipulations.

Key features of programming languages include:
- Syntax: The set of rules that defines the structure of valid statements and expressions in the language. Syntax dictates how code must be written for it to be understood by the compiler or interpreter.
- Semantics: The meaning of the statements and expressions in the language. While syntax focuses on form, semantics deals with the behavior and effects of executing the code.
- Data Types: Programming languages provide various data types (e.g., integers, floats, strings, boolean) that define the kind of data that can be manipulated and the operations that can be performed on that data.
- Control Structures: These include constructs like loops (for, while), conditionals (if, switch), and functions or methods that control the flow of execution in a program.
- Abstraction: Programming languages often provide mechanisms for abstraction, allowing developers to define complex data types and functions that simplify code and enhance readability.
- Standard Libraries: Most programming languages come with a set of built-in functions and libraries that provide common functionalities, making it easier to perform tasks without having to write everything from scratch.

Programming languages can be categorized into several types, including:
- High-level languages: These are closer to human languages and are easier to read and write (e.g., Python, Java, C#).
- Low-level languages: These are closer to machine code and provide less abstraction (e.g., Assembly language).
- Compiled languages: These are translated into machine code before execution (e.g., C, C++).
- Interpreted languages: These are executed line-by-line by an interpreter (e.g., Python, JavaScript).
- Domain-specific languages: These are tailored for specific application domains (e.g., SQL for database queries, HTML for web markup).

### Programming Language Generations
Programming language generations are used to categorize how high level a language is. Languages of later generations usually have more layers of abstractions between the programmer and the hardware. <!-- later generations arent higher level but are domain specific -->

**1st Generation Languages.** First generation languages are the oldest form of specifying code. This is basically byte code that will run directly on the processor. There is no abstraction, or textual form of this code. The raw bytes represented in hexadecimal form are categorized as the only first generation language. Every application needs to be rewritten for every hardware implementation, if the hardware uses a different instruction set.

**2nd Generation Languages.** Second generation language no longer require writing byte code instructions, they can be represented using text. Only one language falls in this category, assembly language. Similar to first generation languages, the programmer still needs to implement the software for one specific instruction set only. However, they no longer have to worry about specific instruction encoding and can just write an instruction mnemonic, that corresponds to different instructions that the hardware knows about. The assembler will determine which instruction is appropriate to use based on the operands.

**3rd Generation Languages.** Third generation languages are the first generation of languages that can be considered high level. In this generation complicated language constructs, like conditions or iterations, can be represented using a single statement. The compiler will then translate one statement into multiple processor instructions. The compiler also abstracts away the need to target specific hardware. A single program can be translated into multiple instruction sets, making code more portable. Some early languages in this generation include:
- Basic
- Algol
- FORTRAN
- B
- C

**4th Generation Languages.** Fourth generation languages include languages that do not add further abstraction layers to the language, but rather focus on solving a specific problem. These domain specific languages are worse for solving general problems, instead they have a niche use case where they excel. The languages in this generation are not necessarily newer than the languages in the previous generations. Some examples:
- Unix shell (sh, bash, fish): scripting language used to send command to the operating system
- SQL: used for managing relational databases
- R: used for data visualization

**5th Generation Languages.** Fifth generation languages do not solve problems using algorithms written by a programmer, but rather try to find a solution based on a set of constraints. Languages that assist in proving a mathematical theorem also belong in this category. These languages may use artificial intelligence techniques, and are designed to make the computer solve a problem on its own, without a programmer. Some examples:
- PROLOG
- OPS5
- Mercury

### Turing Machine
A Turing machine is a theoretical computational model developed by Alan Turing in 1936. A Turing machine is made up of the following parts:
- Tape: An infinite tape, that is divided into cells, each cell can store one symbol from the finite alphabet of the machine. This serves as both the input and the memory of the machine.
- Head: A pointer to a cell on the tape. It can read the symbol in the cell it is pointing to, or write a symbol to that cell. In addition, it can move to the left or right one cell at a time to access all the cells on the tape.
- State register: This is a memory register that is capable of storing the current state of the Turing machine. The Turing machine has a set of possible/available states, each state having different behavior based on the specified rule set.
- Rule set: A set of rules that describes the behavior of the machine for a given input tape. Each rule has a symbol the machine has to read in order to apply the rule, in addition the machine also has to be in a given state for the rule to apply. Applying the rule means writing a symbol to the cell the head is currently pointing to. After a rule has been applied the head can optionally move one cell to the left or right, based on the specified rule. The rule set always includes a special halting state signifies that the machine should stop.

The machine operates in the following way:
1. We specify the initial state of the machine.
2. The machine reads the symbol in the cell the head is currently pointing to, and finds the rule applicable to the given state.
3. The machine applies the rule, modifying the cell and optionally moving the head.
4. Repeat from step 2. until the machine reaches a halting state.

Turing machines are important basis for computer science theory. They establish important concepts like:
- Computability: A formal basis for what problems can be solved using algorithms. A problem is considered computable if there exists a Turing machine that is capable of solving it.
- Church-Turing thesis: A thesis that proposes that a function is computable if there exists a Turing machine that is capable of solving it.
- Complexity Theory: Turing machines are used to study the complexity of algorithms and the classification of problems based on their computational difficulty.

<!-- TODO:
A computer is Turing complete if..., A programming language is Turing compelete if... We can prove that if two languages are Turing Complete that they are equivalent. We can prove that ... algorithms can be solved on Turing machines, ... The real computers are ... are not Turing complete...
Why is it interesting

my is Turing complete: proof
 -->
While Turing machines are abstract and not used for practical computation, they are a foundational concept in computer science and theoretical computer science, influencing the design of modern computers and programming languages.

**Turing Completeness.** The Turing Completeness pf a programming language `P`, requires that every algorithm that we can execute on any Turing Machine must be implementable in `P`. One way of proving that a language is Turing Complete is, if we can prove that any algorithm on a Turing Machine can be executed in `P`. Effectively `P` can emulate a Turing Machine. Since Turing Machine is an equivalence relation, if `P` can emulate any Turing Machine, it can, by extension emulate all the Turing Machines.

## Parsing
Parsing is the process of analyzing a sequence of symbols, often in the form of text, to determine its grammatical structure according to a given set of rules. It is commonly used in computer science, linguistics, and programming languages.

In the context of programming, parsing typically involves breaking down code into its component parts (such as keywords, operators, and expressions) to understand its meaning and structure. This is often the first step in interpreting or compiling code.

In natural language processing (NLP), parsing refers to the analysis of sentences to understand their grammatical structure, which can help in tasks like machine translation, sentiment analysis, and information extraction.

There are different types of parsing techniques, including:
- Top-down parsing: Starts from the highest level of the parse tree and works down to the leaves.
- Bottom-up parsing: Starts from the leaves and works up to the root of the parse tree.
- Recursive descent parsing: A top-down approach that uses a set of recursive procedures to process the input.
- Shift-reduce parsing: A bottom-up approach that uses a stack to hold symbols and applies shift and reduce operations to build the parse tree.

Overall, parsing is a crucial step in understanding and processing both programming languages and natural languages.

### Parsing Rules
Parsing rules are the guidelines or formal specifications that define how a sequence of symbols (such as code or natural language) should be analyzed and structured. These rules determine how to break down the input into smaller parts and how to interpret their relationships. Parsing rules are often defined using formal grammars, which provide a systematic way to describe the syntax of a language.

Here are some key concepts related to parsing rules:
- Grammar: A set of rules that defines the structure of a language. It typically consists of:
  - Terminals: The basic symbols from which strings are formed (e.g., keywords, operators).
  - Statements: Symbols that can be replaced by groups of terminals and/or statements (e.g., expressions).
  - Productions: Rules that describe how statements can be replaced with combinations of terminals and statements.
- Context-Free Grammar (CFG): A type of grammar where the left-hand side of each production rule consists of a single statement. CFGs are widely used in programming languages and natural language processing.
- Syntax Rules: Specific rules that dictate how symbols can be combined to form valid statements or expressions. For example, in a programming language, a syntax rule might specify that an `if` statement must be followed by a condition and a block of code. 
- Parsing Techniques: Different methods for applying parsing rules, such as:
  - Top-down parsing: Uses the grammar to predict the structure of the input from the top down.
  - Bottom-up parsing: Builds the parse tree from the leaves up to the root, using the input symbols to reduce them to statements.
- Ambiguity: A situation where a single input can be parsed in multiple ways due to conflicting parsing rules. Resolving ambiguity is an important aspect of designing parsing rules.
- Precedence and Associativity: Rules that determine the order in which operators are evaluated in expressions. For example, multiplication may have higher precedence than addition, affecting how an expression is parsed.

Overall, parsing rules are essential for accurately interpreting and processing languages, whether they are programming languages or natural languages. They provide the framework for understanding the structure and meaning of the input.

### Abstract Syntax Tree as Intermediate Representation
An abstract syntax tree (AST), is a hierarchical tree structure that represents the syntactic structure of a string according to a formal grammar. It represents how the input is broken down into its elementary parts based on the parsing rules.

Key Components of an AST:
- Nodes: Each node in the tree represents a construct occurring in the input. There are typically two types of nodes:
  - Statement nodes: These represent grammatical constructs defined by the grammar (e.g., expressions, statements).
  - Terminal nodes: These represent the actual symbols from the input (e.g., keywords, operators, identifiers).
- Root: The topmost node of the tree, which represents the starting symbol of the grammar.
- Leaves: The terminal nodes at the bottom of the tree, which correspond to the actual input symbols.
- Branches: The connections between nodes that represent the relationships between different constructs.

Types of syntax trees:
- Complete Syntax Tree: Represents the exact structure of the input, including all syntactic details. It shows every element of the input, including punctuation and whitespace.
- Abstract Syntax Tree (AST): A simplified version of the complete syntax tree that omits certain syntactic details. The AST focuses on the logical structure of the input, making it easier to analyze and manipulate for further processing, such as interpretation or compilation.

Intermediate Representation: \
Intermediate representation (IR) is a data structure that represents the program during the compilation process. It serves as a bridge between the high-level source code and the low-level machine code. The AST can be considered a form of intermediate representation, as it captures the essential structure and semantics of the input code without being tied to a specific programming language syntax.

### Regular Expression
A regular expression is a sequence of characters that defines a search pattern. It is commonly used for string matching and manipulation.
Regular expressions can be used to:
- Search: Find specific patterns within text.
- Match: Determine if a string conforms to a certain pattern.
- Replace: Substitute parts of a string that match a pattern with another string.
- Split: Divide a string into an array of substrings based on a specified pattern.

Basic concepts:
- Characters: Any literal character will match themselves.
- Boolean "or" |: A vertical bar that separates alternatives.
- Grouping: Parentheses are used to define groups and precedence of operators
- Quantification: A quantifier after an element (such as a token, character, or group) specifies how many times the preceding element is allowed to repeat.
  - `?`: The question mark indicates zero or one occurrence of the preceding element.
  - `*`: The asterisk indicates zero or more occurrences of the preceding element.
  - `+`: The plus sign indicates one or more occurrences of the preceding element.
  - `{n}`: The preceding item is matched exactly n times.
  - `{min,}`: The preceding item is matched min or more times.
  - `{,max}`: The preceding item is matched max or fewer times.
  - `{min,max}`: The preceding item is matched at least min times, but no more that max times.
- Wildcard: The `.` Wildcard matches any character.
These constructions can be combined to form arbitrarily complex expressions.

### LALR Parser
A LALR parser (Look-Ahead LR parser) is a type of bottom-up parser used in compiler design for syntax analysis. It is an extension of the LR parser, which stands for "Left-to-right" and "Rightmost derivation." LALR parsers are particularly popular because they can handle a wide range of programming languages while being more memory-efficient than full LR parsers.

Key Features of LALR Parsers:
- Look-Ahead: LALR parsers use a single token of look-ahead to make parsing decisions. This means they can consider the next input symbol when determining how to parse the current state.
- State Reduction: LALR parsers maintain a finite state machine that represents the parsing states. Each state corresponds to a set of items (processing with a dot indicating how much of the processing has been seen). The parser uses these states to decide whether to shift (read the next token) or reduce (apply a processing rule).
- Combining States: LALR parsers combine states from the more powerful LR(1) parser, which uses a full look-ahead of one token, to reduce the number of states. This is done by merging states that have the same core items but differ only in their look-ahead symbols. This merging can lead to conflicts, which the parser must resolve.
- Conflict Resolution: LALR parsers can handle certain types of ambiguities and conflicts that arise during parsing, such as shift/reduce and reduce/reduce conflicts. However, they may not be able to resolve all conflicts, which can limit the types of grammars they can handle.

Advantages of LALR Parsers:
- Efficiency: LALR parsers are more memory-efficient than full LR parsers because they have fewer states, making them suitable for larger grammars.
- Powerful: They can parse a wide range of context-free grammars, including many programming languages.
- Deterministic: LALR parsers are deterministic, meaning that for a given input and state, there is a unique action to take (either shift or reduce).

Disadvantages of LALR Parsers:
- Conflict Handling: While LALR parsers can handle many conflicts, they may still encounter situations where they cannot resolve ambiguities, leading to parsing errors.
- Grammar Limitations: Some grammars that can be parsed by LR(1) parsers may not be suitable for LALR parsing due to the merging of states.

LALR parsers are widely used in compiler construction and are the basis for many parser generators, such as Yacc (Yet Another Compiler Compiler) and GNU Bison. These tools allow developers to define grammars for programming languages and automatically generate the corresponding LALR parser.

In summary, LALR parsers are a powerful and efficient tool for syntax analysis in compilers, capable of handling a wide variety of programming languages while maintaining a manageable state space.
