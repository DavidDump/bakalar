# Formal Languages
Formal languages are structured systems of symbols and rules used to create statements, expressions, or programs in a precise and unambiguous way. They are often used in mathematics, computer science, linguistics, and logic to define syntax and semantics rigorously.

Key characteristics of formal languages include:
- Alphabet: A finite set of symbols from which strings (sequences of symbols) can be formed.
- Grammar: A set of rules that defines how symbols can be combined to form valid strings. This can include production rules in formal grammars, such as context-free grammars.
- Syntax: The structure or form of the strings in the language, determined by the grammar.
- Semantics: The meaning associated with the strings or expressions in the language, which can be defined separately from the syntax.
- Types: Formal languages can be classified into different types based on their complexity and the types of grammars that generate them, such as regular languages, context-free languages, context-sensitive languages, and recursively enumerable languages.

Formal languages are foundational in areas such as programming language design, automata theory, and formal verification, where precise definitions are crucial for correctness and clarity.

# Programming Languages
Programming languages are formal languages designed for instructing computers to perform specific tasks. They consist of a set of rules and syntax that allow developers to write code that can be executed by a computer. Programming languages enable the creation of software applications, algorithms, and systems by providing a means to express computations and data manipulations.

Key features of programming languages include:
- Syntax: The set of rules that defines the structure of valid statements and expressions in the language. Syntax dictates how code must be written for it to be understood by the compiler or interpreter.
- Semantics: The meaning of the statements and expressions in the language. While syntax focuses on form, semantics deals with the behavior and effects of executing the code.
- Data Types: Programming languages provide various data types (e.g., integers, floats, strings, booleans) that define the kind of data that can be manipulated and the operations that can be performed on that data.
- Control Structures: These include constructs like loops (for, while), conditionals (if, switch), and functions or methods that control the flow of execution in a program.
- Abstraction: Programming languages often provide mechanisms for abstraction, allowing developers to define complex data types and functions that simplify code and enhance readability.
- Standard Libraries: Most programming languages come with a set of built-in functions and libraries that provide common functionalities, making it easier to perform tasks without having to write everything from scratch.

Programming languages can be categorized into several types, including:
- High-level languages: These are closer to human languages and are easier to read and write (e.g., Python, Java, C#).
- Low-level languages: These are closer to machine code and provide less abstraction (e.g., Assembly language).
- Compiled languages: These are translated into machine code before execution (e.g., C, C++).
- Interpreted languages: These are executed line-by-line by an interpreter (e.g., Python, JavaScript).
- Domain-specific languages: These are tailored for specific application domains (e.g., SQL for database queries, HTML for web markup).

# Programming language generations
## 1GL
A first-generation programming language (1GL) refers to the earliest type of programming languages, which are essentially machine languages. These languages consist of binary code (0s and 1s) that the computer's central processing unit (CPU) can directly execute.

Key characteristics of first-generation programming languages include:
- Machine Code: 1GLs are composed entirely of machine code, which is the lowest level of programming language. Each instruction corresponds directly to a specific operation that the CPU can perform.
- Hardware Specificity: Machine code is specific to a particular computer architecture. This means that code written for one type of CPU will not work on another without modification.
- No Abstraction: There is no abstraction in 1GLs; programmers must manage all aspects of the hardware directly, including memory addresses and CPU instructions.
- Difficult to Read and Write: Because 1GLs consist of binary code, they are extremely difficult for humans to read, write, and debug. This makes programming in machine code very error-prone and time-consuming.

Due to these characteristics, first-generation programming languages are rarely used today. Instead, higher-level languages (2GLs, 3GLs, and beyond) have been developed to provide more abstraction, readability, and ease of use for programmers. However, understanding machine code is still important for certain areas of computer science, such as systems programming, embedded systems, and performance optimization.

## 2GL
A second-generation programming language (2GL) is a type of low-level programming language that is closer to machine code than high-level programming languages (third-generation languages, or 3GLs). 2GLs are often referred to as assembly languages. They provide a way to write instructions that a computer's CPU can execute directly, but they are more human-readable than raw binary machine code.

Key characteristics of second-generation programming languages include:
- Symbolic Representation: 2GLs use symbolic names (mnemonics) to represent machine-level instructions, making it easier for programmers to write and understand code compared to binary code.
- Hardware Specificity: Assembly languages are typically specific to a particular computer architecture or processor family, meaning that code written in one assembly language may not work on a different type of hardware without modification.
- Direct Control: Programmers have direct control over hardware resources, such as memory and CPU registers, allowing for fine-tuned optimization and performance.
- Low-Level Operations: 2GLs allow for low-level operations, such as bit manipulation and direct memory access, which are not typically available in higher-level languages.

Examples of second-generation programming languages include:
- x86 Assembly Language: Used for programming Intel and AMD processors.
- ARM Assembly Language: Used for programming ARM processors, commonly found in mobile devices and embedded systems.
- MIPS Assembly Language: Used for programming MIPS architecture processors, often used in academic settings and embedded systems.

While 2GLs provide powerful capabilities for system-level programming and performance optimization, they require a deep understanding of the underlying hardware and are generally more complex and time-consuming to write than higher-level languages. As a result, they are less commonly used for general application development today, but they are still important in areas such as operating systems, embedded systems, and performance-critical applications.

## 3GL
A third-generation programming language (3GL) is a type of high-level programming language that is more abstract than second-generation languages (2GLs), which are typically assembly languages. 3GLs are designed to be easier for humans to read and write, allowing programmers to express their logic in a way that is closer to natural language.

Key characteristics of third-generation programming languages include:
- High-Level Abstraction: 3GLs provide a higher level of abstraction from the hardware, allowing developers to write code without needing to manage memory or hardware details directly.
- Structured Programming: Many 3GLs support structured programming concepts, which promote clear and organized code through the use of control structures like loops, conditionals, and functions.
- Portability: Code written in 3GLs can often be run on different types of computer systems with minimal modification, making them more portable than lower-level languages.
- Rich Libraries and Frameworks: 3GLs typically come with extensive libraries and frameworks that provide pre-written code for common tasks, further simplifying the development process.

Examples of third-generation programming languages include:
- C: A powerful and widely used language that provides low-level access to memory and system resources.
- C++: An extension of C that includes object-oriented programming features.
- Java: A language designed to be platform-independent, with a strong emphasis on object-oriented programming.
- Python: Known for its readability and simplicity, making it popular for beginners and experienced developers alike.
- Ruby: A dynamic, object-oriented language known for its elegant syntax.

Overall, 3GLs are widely used in software development for a variety of applications, from system software to web development.

## 4GL
A fourth-generation programming language (4GL) is a type of programming language that is designed to be more user-friendly and closer to human language than its predecessors (first, second, and third generation languages). 4GLs are often used for database management, report generation, and other high-level tasks that require less detailed programming.

Key characteristics of 4GLs include:
- Higher Abstraction: They provide a higher level of abstraction, allowing developers to focus on what they want to achieve rather than how to implement it.
- Declarative Syntax: Many 4GLs use a declarative syntax, meaning that users specify what they want to accomplish without detailing the control flow or the steps to achieve it.
- Rapid Application Development (RAD): 4GLs are often used in environments that require rapid application development, enabling quicker development cycles.
- Database Interaction: They typically include built-in support for database operations, making it easier to interact with databases.

Examples of fourth-generation programming languages include SQL (Structured Query Language), MATLAB, and various report generators and data manipulation languages. These languages are often used in business applications, data analysis, and other areas where efficiency and ease of use are important.

## 5GL
A fifth-generation programming language (5GL) is a type of programming language that is designed to facilitate problem-solving and programming through a more declarative approach, often focusing on artificial intelligence (AI) and advanced computing tasks. 5GLs aim to allow programmers to specify what they want to achieve without detailing how to achieve it, often using natural language or graphical interfaces.

Key characteristics of fifth-generation programming languages include:
- Declarative Nature: 5GLs allow users to express the logic of a computation without describing its control flow. This means that programmers can focus on the "what" rather than the "how."
- Artificial Intelligence: Many 5GLs are designed to support AI applications, including knowledge-based systems, expert systems, and natural language processing.
- High-Level Abstraction: They provide a high level of abstraction, often allowing users to work with complex data structures and algorithms without needing to manage low-level details.
- Graphical Interfaces: Some 5GLs incorporate graphical programming environments, enabling users to create programs through visual representations rather than traditional coding.
- Automatic Reasoning: 5GLs often include features for automatic reasoning, allowing the system to infer conclusions from given facts and rules.

Examples of fifth-generation programming languages include:
- Prolog: A logic programming language that is particularly well-suited for tasks involving AI, such as natural language processing and theorem proving.
- LISP: While often considered a 3GL, certain implementations and extensions of LISP are used in AI research and can be associated with 5GL characteristics.
- SQL: While primarily a database query language, its declarative nature aligns with some 5GL principles.

Overall, fifth-generation programming languages are still an evolving concept, and while they are not as widely adopted as earlier generations, they represent a significant step toward more intuitive and powerful programming paradigms, particularly in the realm of artificial intelligence and complex problem-solving.

# Turing Machine
A Turing machine is a theoretical computational model introduced by the mathematician and logician Alan Turing in 1936. It is used to formalize the concept of computation and to explore the limits of what can be computed. A Turing machine consists of the following components:

- Tape: An infinite tape divided into discrete cells, each capable of holding a symbol from a finite alphabet. The tape serves as both the input and the memory of the machine.

- Head: A read/write head that can move left or right along the tape. The head can read the symbol in the current cell, write a new symbol, or erase the existing symbol.

- State Register: A finite set of states, including a special start state and one or more halting states. The state register keeps track of the current state of the machine.

- Transition Function: A set of rules that dictate how the machine behaves based on its current state and the symbol it reads from the tape. The transition function specifies:
  - The new state to transition to.
  - The symbol to write on the tape (which can be the same as the one read or a different one).
  - The direction to move the head (left or right).

The operation of a Turing machine proceeds as follows:
- The machine starts in the initial state with the tape containing the input symbols.
- Based on the current state and the symbol under the head, the transition function determines the next state, the symbol to write, and the direction to move the head.
- The machine continues this process until it reaches a halting state, at which point it stops executing.

Turing machines are significant for several reasons:
- Computability: They provide a formal framework for understanding what problems can be solved algorithmically. A problem is considered computable if there exists a Turing machine that can solve it.
- Church-Turing Thesis: This thesis posits that any function that can be computed by an algorithm can be computed by a Turing machine, establishing it as a fundamental model of computation.
- Complexity Theory: Turing machines are used to study the complexity of algorithms and the classification of problems based on their computational difficulty.

While Turing machines are abstract and not used for practical computation, they are a foundational concept in computer science and theoretical computer science, influencing the design of modern computers and programming languages.

## Turing completeness:
- Arbitrary Memory Access: The system should allow for the manipulation of an arbitrary amount of memory, enabling it to store and retrieve data as needed during computation.
- Conditional Branching: The system must support conditional statements (e.g., if-then-else constructs) that allow it to make decisions based on the current state or value of data. This enables the system to change its behavior based on different inputs.
- Ability to Change State: The system must have a way to maintain and change its internal state. This is similar to the state register of a Turing machine, allowing the system to keep track of where it is in its computation.

# Regular Expression
A regular expression (often abbreviated as regex or regexp) is a sequence of characters that defines a search pattern. It is commonly used for string matching and manipulation.
Regular expressions can be used to:
- Search: Find specific patterns within text. For example, you can use regex to search for email addresses, phone numbers, or specific words in a document.
- Match: Determine if a string conforms to a certain pattern. For instance, you can check if a string is a valid date format or if it contains only digits.
- Replace: Substitute parts of a string that match a pattern with another string. This is useful for tasks like sanitizing input or formatting text.
- Split: Divide a string into an array of substrings based on a specified pattern.

Basic concepts:
- Characters: Any literal characater will match themselves.
- Boolean "or" |: A vertical bar that seperates alternatives.
- Grouping: Parentheses are used to define groups and precedence of operators
- Quantification: A quantifier after an element (such as a token, character, or group) specifies how many times the preceding element is allowed to repeat.
  - ?: The question mark indicates zero or one occurrences of the preceding element.
  - *: The asterisk indicates zero or more occurrences of the preceding element.
  - +: The plus sign indicates one or more occurrences of the preceding element.
  - {n}: The preceding item is matched exactly n times.
  - {min,}: The preceding item is matched min or more times.
  - {,max}: The preceding item is matched max or less times.
  - {min,max}: The preceding item is matched at least min times, but no more that max times.
- Wildcard: The `.` Wildcard maches any characater.
These constructions can be combined to form arbitrarily complex expressions.
