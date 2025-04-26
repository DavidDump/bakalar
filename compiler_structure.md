# Compiler Structure
Reading a text file and outputing a sequence of CPU instructions based on it seem like a pretty daunting task at first. This is why its wise to break the problem down into smaller pieces. Each section of the compiler deals with one specific task in the compilation process.
<!-- TODO: This sounds kinda dumb, maybe rewrite -->

## Lexer
<!-- simple character by character iterating the source file and setting token type by lookup table -->
The lexer breaks a source file down into tokens. Its easier to verify the syntactical correctness of a program if the compiler doesn't have to wory about whitespace, and can just operate on larger chunks of text that belong togeather, like keywords or variable names.
Our lexer iterates each source file, character by character. Then it categorizes the characters into three main groups, words, numbers and punctuations. Words have to start with a letter and can contain letters, digits or underscores. Once the lexer finds a letter it starts a word. It keeps reading until it encounters a character that isn't a valid character for a word or a whitespace character. Number tokens can only contain digits. They are tokenized similarly to words, once the lexer encounters a digit it starts a number token and keeps reading until it encounters any character other than a digit. Punctiations are different, because most punctiations are only one or two chacters long. They are also static in their value, a semicolon (`;`) is always a semicolon, so the value of the token doesn't need to be stored, while the value of a word can varry, `foo` and `bar` are both words with different values. The lexing process for punctiations involve using a lookup table that maps the token charcter, or characters if its a multi char token, to its associated token type. As mentioned before whitespace is ignored, so the lexer will just skip it, this makes the language whitespace agnostic.
The only special case that ignores these rules are comments. As comments store no information relevant to the compiler, it is adventagious to skip it as early in the compilation process as possible. Because of this, if the lexer finds two slash (`/`) characters following each other it will simply ignore all remaining character until it encounter a newline.
The lexer also keeps track of the filename and the location in the file where each token is located. This is usefull to record here as it can be used later for error messeges.

## Parser
<!-- recursive desent parser -->
The parser is responsible for making sure that the input sequence of tokens makes gramatical sense. This stage of the compiler is where syntax errors are caught, like trying to add a number (`1`) and a comma (`,`), ex.: `1 + ,`. This is always incorrect, and all the errors that are detected in this stage of compilation need to terminate immediately, as incoming token stream will no longer make sence after a syntax error.
This compiler uses a handwritten recursive descent parser. Parsing is verifying the syntactical validity of a grammar. A recursive descent parser uses functions to varify this validity of smaller gramatical units, each function corresponding to one unit. For example when parsing a function the `parseFunction` function is called. As a function is comprised of a parameter list, return type and a scope, the corresponding `parseFunctionArgs`, `parseType`, and `parseScope` functions are called to parse these smaller elements. This style of parsing ensures that these gramatical units are parsed the same way throughout the program, even if these gramatical units apear in different language constructs.

The parser taken tokens as an input, and outputs an abstract syntax tree (AST). This AST stores the lexical components of each statement, so that its easier to access later in the compilation process, an example would be the name of the function in a function declaration statement.

## Typechecker
<!-- check each scope top to bottom, constants first, then vars, then evaluate all the child function scopes, detect circular dependencies in constants, out of order declaration -->
The typechecking step ensures the semantic correctness of a program. While the arithmetic expression: `1 + "hello"` is syntactically correct, it doesn't make much sense. The type of the literal `1` is `s64` (or one of the other types that represent a, integer number), and the type of the string literal `"hello"` is string. The addition operaion doesn't make sense on these two types, hence the typechecker would return an error. Other types of problems in the source code are also cought in this compilation step, like fucntions for retruning a value on all execution paths.
My typechecker checks each scope from top down to resolve all the symbols declared, constants and variables, then in continues down to all the child scopes defined in the current one. It recursevly continues this process until there are no more scopes left to check. As this compiler supports out of order declaration for constants, the typechecker has to make sure each expression only uses symbols that: 1. are also constant, 2. already have their value resolved. If one or more symbols in the expression are not defined the compiler has no way of knowing if this symbol is defined later in the source code or not at all, so the resolution of the value is defered. Once only these defered symbols remain the compiler iterates them again. It keeps repeating this process until all the constants in the current scope are evaluated. If some defered constants are left over but no new ones got evaluated in the current iteration, it means two expressions are circularly dependant and they cannot be evaluated. Once all the constants are evaluated the typechecker continues to typecher all the child scopes defined in the current one.
The result of the typechecker is an AST that has types associated with all the symbols and expressions, it also collects all the functions that are declared and need to be generated later.

## Codegen
<!-- the most primitive part on the compiler, dont know what to say -->
The codegenerator iterates over all the functions declared in the source code, and generates instructions for each one. Each statement in a function has a case in a switch statement associated with it that generates the instruction stream for the given statement. Expressions are generated recursively and, use the stack to store intermediate values of subexpressions. The structure of the codegenerator mirrors that of the parser, and follows the idea of recursive descent.

## Assembler
<!-- write about x86 encoding -->
An assembler takes a stream of instructions and generates bytecode that a given CPU architecture can execute. Common assemblers include: **MASM**, **NASM**, **FASM**, **GASM**, these dont do any optimization on the instruction stream, they simply choose the correct bytecode instruction for a given assembly instruction.
The compiler comes with its own assembler, capable of generaing x86_64 bytecode. All the supported instruction encodings are stored in a lookup table. This is what the assembler uses to determine the bytes to output.

## PE32 Format
<!-- write about pe format -->
The Portable Executable 32 (PE32 for short) format, is used on the Windows operating system to store executable bytecode.
The PE32 file format consists of two main parts: the headers and sections. The headers are all backwards compatible, so there are a lot of fields that are obsolete on modern systems.
A PE32 file begins with the DOS header, and a DOS stub program. This is used for backwards compatibility with MS-DOS systems. The stub program simply prints: "This program cannot be run in DOS mode". However this section doesn't need to contain valid data for the rest of the file to be valid, it can be all zeros.
After follows the COFF headers which contain information about the target machine the program was meant to run on, the compilation timestamp, and characteristics about the executable file. The characterictics include things like if the file is an executable, a library, an object file or a kernel module, as well as the description of the memory usage of the program. Then come the COFF optional headers, which contain the size and the location of the data and the code, aswell as the address of the entry point. Information about the stack and heap size are also stored this header. After the COFF optional header follow 16 table descriptors. Each of these descriptors contains inforamtion about where a specific piece of information is located in the file. The tables that these descriptors can describe are as follows:
- Export table - describes exported symbols
- Import table - describes imported symbols
- Resource table - describes binary data "resources" present in the file
- Exception table - list of function pointers to exception handlers
- Certificate table - describes certificates used to verify the file
- Base relocation table - describes how addressed got moved by the linker
- Debug information - contains debug information
- Architecture data - reserved, set to 0
- Global pointer - value to be stored in the global pointer register
- TLS table - describes information about variables stored in thread local storage
- Load config table - obsolete, used on Windows NT
- Bound import - obsolete
- Import address table - copy of the import table, the OS will fill out the pointers to imported functions when loading the section into memory
- Delay import descriptor - same as the import table, but the functions described here will only be loaded when called
- CLR runtime header - .NET metadata

The final descriptor is zeroed out to indicate the end of the descriptors. Out of all of these the only ones that need to contain relevant information for the PE32 file to be valid are: the import table for executables and the export table for library files.
The final header is the section descriptor header. This header contains information about each section that file contains. This information includes the address and the size of the section in the file, aswell as the address, size and the permissions, that the section should have once it is loaded into memory. The end of the section descriptors is indicated by a fully zeroed out section descriptor.
After this file contains the actual data of the sections, no checking or validation is done to see if any of the data is correct, it will simply be read based on the metadata provided in the descriptors earlier. 
