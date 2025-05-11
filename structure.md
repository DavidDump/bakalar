## Compiler Structure
Reading a text file and outputting a sequence of CPU instructions based on it seem like a pretty daunting task at first. This is why it is wise to break the problem down into smaller pieces. Each module of the compiler deals with one specific task in the compilation process.

The following code example will be used to demonstrate the work that each module of the compiler does. Each step will illustrate what steps the compiler takes and how it transforms the data.
```
main :: () -> u8 {
    print("Hello World!\n");
    return 0;
}
```

### Lexer
<!-- simple character by character iterating the source file and setting token type by lookup table -->
The lexer breaks a source file down into tokens. It is easier to verify the syntactical correctness of a program if the compiler does not have to worry about whitespace, and can just operate on larger chunks of text that belong together, like keywords or variable names.
Our lexer iterates each source file, character by character. Then it categorizes the characters into three main groups: words, numbers and punctuations. Words have to start with a letter and can contain letters, digit is or underscores. Once the lexer finds a letter it starts a word. It keeps reading until it encounters a character that is not a valid character for a word or a whitespace character. Number tokens can only contain digits. They are tokenized similarly to words, once the lexer encounters a digit it starts a number token and keeps reading until it encounters any character other than a digit. Punctuations are different, because most punctuations are only one or two characters long. They are also static in their value, a semicolon (`;`) is always a semicolon, so the value of the token does not need to be stored, while the value of a word can vary, `foo` and `bar` are both words with different values. The lexing process for punctuations involve using a lookup table that maps the token character, or characters if it is a multi character token, to it is associated token type. As mentioned before whitespace is ignored, so the lexer will just skip it, this makes the language whitespace agnostic.
The only special case that ignores these rules are comments. As comments store no information relevant to the compiler, it is adventitious to skip it as early in the compilation process as possible. Because of this, if the lexer finds two slash (`/`) characters following each other it will simply ignore all remaining character until it encounters a newline.
The lexer also keeps track of the filename and the location in the file where each token is located. This is useful to record, as it can be used later for error messages.

The hello world example would tokenize to the following tokens:
```
examples\helloWorld.bnx:1:1  {  IDENTIFIER  main              }
examples\helloWorld.bnx:1:6  {  DOUBLECOLON ::                }
examples\helloWorld.bnx:1:9  {  LPAREN      (                 }
examples\helloWorld.bnx:1:10 {  RPAREN      )                 }
examples\helloWorld.bnx:1:12 {  RARROW      ->                }
examples\helloWorld.bnx:1:15 {  TYPE        u8                }
examples\helloWorld.bnx:1:18 {  LSCOPE      {                 }
examples\helloWorld.bnx:2:5  {  IDENTIFIER  print             }
examples\helloWorld.bnx:2:10 {  LPAREN      (                 }
examples\helloWorld.bnx:2:11 {  STRING_LIT  "Hello World!\n"  }
examples\helloWorld.bnx:2:27 {  RPAREN      )                 }
examples\helloWorld.bnx:2:28 {  SEMICOLON   ;                 }
examples\helloWorld.bnx:3:5  {  RETURN      return            }
examples\helloWorld.bnx:3:12 {  INT_LITERAL 0                 }
examples\helloWorld.bnx:3:13 {  SEMICOLON   ;                 }
examples\helloWorld.bnx:4:1  {  RSCOPE      }                 }
examples\helloWorld.bnx:6:1  {  IDENTIFIER  print             }
examples\helloWorld.bnx:6:7  {  DOUBLECOLON ::                }
examples\helloWorld.bnx:6:10 {  LPAREN      (                 }
examples\helloWorld.bnx:6:11 {  IDENTIFIER  msg               }
examples\helloWorld.bnx:6:15 {  COLON       :                 }
examples\helloWorld.bnx:6:17 {  TYPE        string            }
examples\helloWorld.bnx:6:23 {  RPAREN      )                 }
examples\helloWorld.bnx:6:25 {  RARROW      ->                }
examples\helloWorld.bnx:6:28 {  TYPE        s64               }
examples\helloWorld.bnx:6:32 {  LSCOPE      {                 }
examples\helloWorld.bnx:7:5  {  RETURN      return            }
examples\helloWorld.bnx:7:12 {  INT_LITERAL 0                 }
examples\helloWorld.bnx:7:13 {  SEMICOLON   ;                 }
examples\helloWorld.bnx:8:1  {  RSCOPE      }                 }
```

### Parser
<!-- recursive desent parser -->
Parsing is verifying the syntactical validity of a grammar.
The parser is responsible for making sure that the input sequence of tokens makes grammatical sense. This is the stage of the compiler where syntax errors are caught, like trying to add a number (`1`) and a comma (`,`), ex.: `1 + ,`. This is always incorrect, and all the errors that are detected in this stage of compilation need to terminate immediately, as the incoming token stream will no longer make sense after a syntax error.
The compiler uses a handwritten recursive descent parser. A recursive descent parser uses functions to verify the validity of smaller grammatical units, each function corresponding to one unit. For example when parsing a function, the `parseFunction` function is called. As a function consists of a parameter list, return type and a scope, the corresponding `parseFunctionArgs`, `parseType`, and `parseScope` functions are called to parse these smaller elements. This style of parsing ensures that these grammatical units are parsed the same way throughout the program, even if these grammatical units appear in different language constructs.

The parser takes tokens as an input, and outputs an abstract syntax tree (AST). This AST stores the lexical components of each statement, so that it is easier to access later in the compilation process, an example would be the name of the function in a function declaration statement.

After parsing the hello world example, the parser generates the following AST:
```
VAR_CONST: {
    id: "main"
    value: FUNCTION_LIT: {
        type: U8
        args: []
        statements: [
            FUNCTION_CALL: {
                id: print
                args: [
                    "Hello World!\n"
                ]
            }
            RET: {
                expr: 0
            }
        ]
    }
}
```

### Type Checker
<!-- check each scope top to bottom, constants first, then vars, then evaluate all the child function scopes, detect circular dependencies in constants, out of order declaration -->
The type checking step ensures the semantic correctness of a program. While the arithmetic expression: `1 + "hello"` is syntactically correct, performing a binary operation on two literals, it does not make much sense. The type of the literal `1` is `s64` (or one of the other types that represent an integer number), and the type of the literal `"hello"` is string. The addition operation does not make sense on these two types, hence the type checker would report an error. Other errors, like returning the correct type from a function, or returning from all execution paths of a function are also reported in this compilation step.
Our type checker analyzes each scope from top down to resolve all the declared symbols, constants and variables, then continues down to all the child scopes defined in the current one. It recursively continues this process until there are no more scopes left to check. As our compiler supports out of order declaration for constants, the type checker has to make sure each expression only uses symbols that: 1. are also constant, 2. already have their value resolved. If one or more symbol in the expression is not defined, the compiler has no way of knowing if this symbol is defined later in the source code, or not at all, so the resolution of the value is deferred. Once only these deferred symbols remain the compiler iterates them again. It keeps repeating this process until no more new constants are resolved. If at this point there are still some deferred constants that have not been resolved, that means some expressions either contain undeclared symbols, or two constants are circularly dependent. Once all the constants are evaluated the type checker moves on to other statement types, like variables, conditions or loops. These can be evaluated in the same order they appear in the source code.
The result of the type checker is an AST that has its nodes annotated with types.

The hello world example AST, with all the type information annotated:
<!-- maybe image maybe text -->
<!-- ![bottom text types](img/helloWorldTypes.png "title types") -->
```
VAR_CONST: {
    id: "main"
    type: FUNCTION
    value: FUNCTION_LIT: {
        type: U8
        args: []
        statements: [
            FUNCTION_CALL: {
                id: print
                type: VOID
                args: [
                    {
                        type: string
                        value: "Hello World!\n"
                    }
                ]
            }
            RET: {
                expr: {
                    type: U8
                    value: 0
                }
            }
        ]
    }
}
```

### Compiler Backend
<!-- the most primitive part on the compiler, do not know what to say -->
The code generator iterates over all the functions declared in the source code, and generates instructions for each one. Each statement in a function has a case in a switch statement associated with it, that generates the instruction stream for the given statement. Expressions are generated recursively and, use the stack to store intermediate values of sub-expressions. The structure of the code generator mirrors that of the parser, and follows the idea of recursive descent.

These are the assembly instructions generated for the hello world example:
```asm
PUSH rbp
MOV rbp, rsp
; address of the "Hello World\n" string in the data section
lea rax, [ ... ]
MOV rcx, rax
SUB rsp, 0x20
; address of the print function in the import table
CALL qword ptr [ ... ]
ADD rsp, 0x20
MOV rax, 0
MOV rsp, rbp
POP rbp
MOV rcx, rax
; address of the ExitProcess function in the import table
CALL qword ptr [ ... ]
```

### Assembler
<!-- write about x86 encoding -->
An assembler takes a stream of instructions and generates byte code that a given CPU architecture can execute. Common assemblers include: **MASM**, **NASM**, **FASM**, **GASM**, these do not do any optimization on the instruction stream, they simply choose the correct byte code instruction for a given assembly instruction.
The compiler comes with its own assembler, capable of generating **x86_64** byte code. All the supported instruction encoding are stored in a lookup table. This is what the assembler uses to determine the bytes to output.

The assembly instruction from the code generation step gets translated to the following byte code instructions, for the hello world example:
```
0x55
0x48 0x89 0xE5
0x48 0x8D 0x05 0x08 0x00 0x00 0x00
0x48 0x89 0xC1
0x48 0x83 0xEC 0x20
0xFF 0x15 0xEF 0xBE 0xAD 0xDE
0x48 0x83 0xC4 0x20
0x48 0xB8 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
0x48 0x89 0xEC
0x5D
0x48 0x89 0xC1
0xFF 0x15 0xEF 0xBE 0xAD 0xDE
```

### PE32 Format
<!-- write about pe format -->
The Portable Executable 32 (PE32 for short) format, is used on the Windows operating system to store executable byte code.
The PE32 file format consists of two main parts: the headers and sections. The headers are all backwards compatible, so there are a lot of fields that are obsolete on modern systems.
A PE32 file begins with the DOS header, and a DOS stub program. This is used for backwards compatibility with MS-DOS systems. The stub program simply prints: **"This program cannot be run in DOS mode"**. However, this section does not need to contain valid data for the rest of the file to be valid, it can be all zeros.
After follows the COFF headers which contain information about the target machine the program was meant to run on, the compilation timestamp, and characteristics about the executable file. The characteristics include things like if the file is an executable, a library, an object file or a kernel module, as well as the description of the memory usage of the program. Then come the COFF optional headers, which contain the size and the location of the data and the code, as well as the address of the entry point. Information about the stack and heap size are also stored this header. After the COFF optional header follow 16 table descriptors. Each of these descriptors contains information about where a specific piece of information is located in the file. The tables that these descriptors can describe are as follows:
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
The final header is the section descriptor header. This header contains information about each section that file contains. This information includes the address and the size of the section in the file, as well as the address, size and the permissions, that the section should have once it is loaded into memory. The end of the section descriptors is indicated by a fully zeroed out section descriptor.
After this, follows the actual data of the sections, no checking or validation is done to see if any of the data is correct, it will simply be read based on the metadata provided in the descriptors earlier. 
