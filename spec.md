## Language Specification
<!--
-literals
types
  int
  float
  string
  bool
  function
  struct
  enum
  type - calling convention should be part of the type
  any
  casting (as)
  arrays (fixed size, dynamic size?)
  pointers
    auto dereferencing
comments
-symbol (what is a valid symbol)
-variable declaration
-constant declaration
maybe types here
-control flow (if, loop, defer) also want to mention break, continue
-functions: default values, multiple return types, overloading, variadics, generics
structs in more detail
  string in more detail, explain that its a struct
  dynamic array in more detail, explain that its a struct
enums in more detail
  tagged enums
  NOTE: Enumerated Array need to be a feature
operators
  arithmetic
  logical
  dereference
  something to replace ternary operators
context - i quite like the context in odin might implement something similar
compiler directive
  #run - compile time execution, if the code inside return a value, that value will be inserted in the source code
  #if - compile time conditional compilation
  #char - specify the ascii value of a single character, argument in a string with length one, compiler error if length not one
  #assert_param
  #type - return the type of a symbol, maybe if need
  #import - paste the content of the file here, not just bnx file, similar to c
  #load - merge the AST of the target source file with the current file, only bnx files
  #extern
  #private - make single symbol private, some other directive (dont know name yet), that makes all future symbol declarations in this file private
  #public - make single symbol public, some other directive (dont know name yet), that makes all future symbol declarations in this file public
  #caller_line - used in function default value, line the function was called from
  #caller_func - used in function default value, parent function the current function was called from
  #caller_file - used in function default value, file name the function was called from
  #no_discard - mark a return value that it needs to be assigned to a variable by the caller
  ...
typeof (maybe typeinfo) keyword
  explain runtime type information
using keyword

maybes:
  list of all keywords at the begining
  list of all operators at the begining
-->

### Literals
- integer literals consist of one or more digits, ex.: `123`
  - all integer literals are always positive numbers, signs like plus (`+`) or minus (`-`) are operators and not part of the literal
  - integer literals can be specified in hexadecimal or in binary format as well
    - hexadecimal integer literals are prefixed with a `0x`, ex.: `0xCAFEBABE`
    - binary integer literals are prefixed with a `0b`, ex.: `0b110100`
  - underscores (`_`) can be used inside an integer literal to make them easier to read, ex.: `1_200`, `0xFF_CA`, `0b1101_00110100`
- floating point literals consist of zero or more digits, followed by a dot (`.`), followed by zero or more digits, ex.: `3.14`, `10.`, `.5`
  - all floating point literals are always positive numbers, signs like plus (`+`) or minus (`-`) are operators and not part of the literal
  - if the digits before the dot (`.`) are omitted the compiler will assume 0 before the dot (`.`)
  - if the digits after the dot (`.`) are omitted the compiler will assume 0 after the dot (`.`)
  - these assumptions mean, that the following representations for the floating point literal 0 are all valid: `0.0`, `0.`, `.0`, `.`
- boolean literals can be one of two values: `true` or `false`
- string literals open with a double quote (`"`) followed by any number of UTF-8 characters, followed by a closing double quote (`"`), ex.: `"Hello World!"`
  - the backslash (`\`) character followed by another character can be used to insert a special character into the string literal:
    - `\n` inserts a newline character
    - `\r` inserts a carriage return character
    - `\t` inserts a tab character
    - `\"` inserts a double quote character
    - `\\` inserts a backslash
  - if a string literal spans two or more lines the newline at the end line will also be added to the string literals as if `\n` was used, the same is true for tabs
- function literals consist of an **argument list**, a **return type tuple**, and a **function body**
  - the argument list is enclosed in parentheses (`( ... )`) and contains zero or more arguments, an argument in a name followed by a colon (`:`) and a type, multiple arguments are comma (`,`) separated, ex.: `(number1: u64, number2: u64)`
  - the return type list is a comma (`,`) separated list of types, the list can be omitted if the function does not return anything, ex.: `u64, bool`
  - the argument list and the return type tuple are delimited by the arrow symbol (`->`), if the return type tuple is omitted this symbol can also be omitted
  - the function body is a list of statements enclosed in curly braces (`{ ... }`)
  example of a function literal: `(number1: u64, number2: u64) -> u64, bool { ... }`
- struct literals start with the name of the struct followed by a comma (`,`) separated initializer list enclosed in curly braces (`{ ... }`)
  - two types of initializer lists are supported:
    - positional initializers, ex.: `Vec2{1, 2}`
    - designated initializers, ex.: `Vec2{.x = 1, .y = 2}`
- enum literals start with the name of an enum followed by a dot (`.`) and a name that is defined in that enum, ex.: `colors.RED`
- type literals can be a simple type or a complex type
  - simple types include:
    - integer types: `u8`, `u16`, `u32`, `u64`, `s8`, `s16`, `s32`, `s64` - the **u** or **s** prefix specifies whether the integer is **unsigned** or **signed**, and the numbers following are the number of bits used to store the value
    - floating point types: `f32`, `f64` - similar to integer types, the numbers following the **f** are the number of bits used to store the value
    - boolean type: `bool`
    - string type: `string`
    - any type: `any` - can hold a value of any type
  - user defined types include: `struct`, `enum`, `function`, `type`
    - struct type literals start with the keyword `struct` followed by a list of variable or constant declarations enclosed in curly braces (`{ ... }`), ex.: `struct { ... }`
    - enum type literals start with the keyword `enum` followed by a comma (`,`) separated list of names enclosed in curly braces (`{ ... }`), ex.: `enum { ... }`
  <!-- - TODO: better explain this section -->

<!-- TODO: function call is also kindof a literal -->

### Expressions
Expressions can be single literals, binary expressions or unary expressions. Binary expressions consist of an infix operator and two sub-expressions. Unary expressions consist of a prefix operator and a single sub-expression.

### Symbols
The names of variables and constants are referred to as symbols. A symbol has to start with a letter, followed by any number of letters, digits on underscores (`_`). The programmer can bind expressions to symbols. Binding a constant symbol uses the double colon (`::`) operator, binding a variable symbol uses the colon-equals (`:=`) operator. Example of binding a constant and a variable symbol:
```
foo :: 1; // This is a constant symbol
bar := 2; // This is a variable symbol
```
The difference between constants and variables is that constant expressions need to be known at compile time, while variable expressions do not. Variable expressions can also change, while constant expressions can not. Lastly when constant symbols are used in an expression they get replaced by their literal value during compile time. An example of this behavior:
```
ONE :: 1;
TWO :: 2;
result := ONE + TWO;
```
In the above example the expressions of `ONE` and `TWO` are not stored in memory anywhere. They simply get replaced during compile time, resulting in the expression `1 + 2` being generated.
<!-- TODO: (This enables the compiler to later optimize the expression even further, ie.: constant folding.) -->
```
ONE := 1;
TWO := 2;
result := ONE + TWO;
```
If we use variables instead in the second example, the expressions of `ONE` and `TWO` are first stored in memory, then read from memory again when the operation is performed. NOTE: this is a simple example end using SSA both cases would generate the same byte code.

All symbols have a type. The type of symbol is either explicitly specified by the programmer or inferred by the compiler. If the programmer wishes to specify a type they can do so after the first colon (`:`) of the declaration operators (`:=` or `::`). Example:
```
foo : u32 = 42;
```
If no type is provided the compiler will try to infer the type. Simple expressions like `true` or `"Example"`, that can only be one type will be inferred as such. Numbers like integers and floating points that can have a varying level of precision will always be inferred as the highest level of precision possible, i.e.: `s64`, `f64`. Complex types like structs and enums that implicitly specify their type in the literal value, can have the type omitted from the literal value if the symbol already has an explicitly specified type. Example of this behavior:
<!-- TODO: // Vec2 :: struct { x, y: f64; } -->
```
Vec2 :: struct {
    x: f64;
    y: f64;
}

pos : Vec2 = {0.0, 0.0};
```
If no expression is provided it is mandatory to provide a type. Symbols without an expression by definition cannot be constant, as their value is not known at the time of their declaration.
```
foo: bool;
```
<!-- TODO: reassign -->

### Control Flow
<!-- if, loop, defer, break, continue -->
#### If
The `if` keyword is mostly the same as other programming languages, as it is followed by a condition and a body that gets executed if the condition evaluates to `true`. The condition is a expression, and the body is a list of statements enclosed in curly braces (`{ ... }`). If the body only contains one statement the curly braces (`{ ... }`) can be omitted. One notable difference however is that the parenthesis (`( ... )`) around the condition are optional, however if parenthesis are present they are part of the expression not the `if` statement. An `if` block can optionally be followed by either an `else if` or an `else` block. An `else if` block also requires a condition before the body. Examples:
```
foo := 1;

if foo != 0 foo = 1;

if foo > 0 {
    foo = 0;
} else if foo < 0 {
    foo = -1;
} else if foo == 0 {
    foo = 999;
}

if foo == 999 {
    foo = 0;
} else {
    foo = 10;
}
```

#### Loop for a while
<!-- TODO: maybe write more about why not `for`, `while` -->
Usually languages use two keywords for iteration: `for` and `while`. Other that the slightly different syntax there is very little difference between these two constructs. This programming language only has one, the `loop` keyword. A loop statement starts with a `loop` keyword, followed by an optional expression and a body. There are multiple ways to use this keyword, each with its own unique behavior:
- Loop without a condition, this case is an infinite loop, ex.:
  - `loop { ... }`
- Loop with an expression that evaluates to a number, this case will iterate a fixed amount of times, and the expression will only be evaluated once, before the loop iteration begins, this means that if the expression contains variables, and these variables change in the body of the loop, the number of iterations will not change, ex.:
  - `loop 5 { ... }` - this will iterate 5 times
  - `loop foo { ... }` - foo is assumed to be an integer, this will iterate foo number of times, regardless if foo changes in the loop body
- Loop with an expression that evaluates to a boolean, this case will iterate while the expression evaluates to `true`, this means the expression will be evaluated and checked every iteration of the loop, ex.:
  - `loop foo < 5 { ... }` - foo is assumed to be an integer, this will iterate while foo is less than 5, the condition is checked on each iteration of the loop
- Loops can also iterate over arrays, in this case instead of an expression, the `loop` keyword is followed by a name, that the Nth element will be bound to every iteration, the `in` keyword, and lastly the array to iterate over, ex.:
  - `loop number in numbers { ... }` - numbers is assumed to be an array, number will be bound to the value of the Nth element of the array
  - `loop number* in numbers { ... }` - numbers is assumed to be an array, number will be bound to a pointer to the Nth element of the array
<!-- NOTE: maybe clearer names in the last two examples -->

Similarly to the `if` statement, the `loop` body can also have its curly braces (`{ ... }`) omitted if the body only contains one statement. Another similarity with the `if` keyword is that the expression following the `loop` keyword does not need to be enclosed in parentheses (`( ... )`). If parenthesis are provided they are not part of the `loop` statement, instead are part of the expression.

#### Continue, break
<!-- TODO: maybe merge with the loops section -->
<!-- TODO: decide if i want to add named loops and mention continuing and breaking out of names loops -->
Similar to most languages, the `continue` and `break` keywords are present in this programming language. They behave as expected, `continue` skips to the next iteration of a loop, `break` ends the loops early.

<!-- TODO: move somewhere where this makes sense -->
This is a semicolon language, meaning there is a semicolon (`;`) at the end of each statement.

#### Defer
The `defer` keyword can be used to specify code that should be executed at the end of the scope. It is followed by a semicolon (`;`) separated list of statements enclosed in curly braces (`{ ... }`). Like all other keywords that have a body, the enclosing curly braces (`{ ... }`) can be omitted if the body only contains one statement. The statements are executed in reverse order in which they were specified.

### Functions
<!-- default values, multiple return types, overloading, variadics, generics, #assert_param -->
#### Default values
Function parameters can have default values that will be used in case the function is called without providing a value for that parameter. Default values are specified using an equals (`=`) and the value, after the parameter type, ex.: `(number: u32 = 10) -> u32 { ... }`. When calling a function with a default parameter in the middle of the parameter list, it is possible to simply omit the value of the parameter in the middle of the argument list, ex.: `foo(arg1,, arg3)`. This example will pass symbols `arg1` as the fist argument and `arg3` as the third argument. The second parameter will use its default value. If a default value is provided the type of the parameter can be omitted, as the value can be used to infer the type.

#### Return values
When a function has multiple return values, the `return` keyword needs to be followed by a comma (`,`) separated list of expressions. The list of return types is similar to the parameter list of the function literal, because each return type can also be named and can have a default value. If the return type is named the symbol is declared at the beginning of the function and can be assigned to, if it also has a default value it will immediately be assigned that value. If named return types are used all return types have to be named. Once all the return symbols have a value assigned to them, the `return` keyword can be used without any expressions.
<!-- TODO: examples -->

#### Overloading
When binding function literals to a constant symbol, there is a special rule, where multiple functions can be bound to the same symbol as long as the parameter list differs in its types.

#### Variadics
Variadic functions like `printf` in C can take any number of arguments of any type. In the case of `printf` the number and type of arguments is passed to the function by the format string. In this programming language variadic function parameters are specified by replacing the type of the last parameter with a triple dot (`...`), e.g.: `(fmt: string, args: ...) { ... }`. Variadic parameters cannot have a default value, and only one variadic parameter can be specified. Inside the function body the symbol bound to the variadic parameter will have a type of array of any.

#### Generics
A generic version of a function can be specified by replacing the type of one or more parameters, with a symbol name prefixed by a dollar sign (`$`), this will declare a generic parameter, ex.: `(arg: $T)`. When calling the function the programmer can pass an argument of any type to the generic parameter. Inside the function body the symbol prefix by a dollar sign (`$`) will be bound to the type that the calling argument had. Later uses of this symbol do not need the dollar sign (`$`) prefix. This symbol can be used both in the function declaration and body, ex.: `(arg1: $T, arg2: T) -> T { ... }`.
When declaring a generic function with `$T`, `T` will only be bound to the base type, not the pointer type, so `u32*` would result in `T == u32`, if we expect a pointer it needs to be specified explicitly, like this `$T*`.

A generic parameter accepts any type as its argument, the way the parameter is used in the function can be a clue as to what types are valid. The programmer can be more explicit about this by using the `#assert_param` compiler directive. This compiler directive is similar to a regular assertion:
```
assert_param :: (condition: bool, message: string, args: ...);
```
The two differences between this directive and `#assert`, is that this directive can only be used inside a function body, and that the condition has to contain at least one symbol defined in the function parameter list. If the condition provided is false the compiler will report an error at the function call site, with the message provided. The compiler will also mark the arguments that were used in the condition, as errors along the reported message. This can be used to assert certain properties of the parameters of generic functions, and report any issues as a compiler error.
```
isNumber :: (param: Type) -> bool {
    return (
        param == u8  ||
        param == u16 ||
        param == u32 ||
        param == u64 ||
        param == s8  ||
        param == s16 ||
        param == s32 ||
        param == s64 ||
        param == f32 ||
        param == f64
    );
}

add :: (num1: $T, num2: T) -> T {
    #assert_param(isNumber(T),
                  "Parameter type is not a number: %\n", T);
    return num1 + num2;
}
```

<!--
#### Validate directive
This directive can be used to specify a function that should be called when the compiler is typechecking a function. The signature of the validation function is as follows: `(args: ...) -> (result: bool, msg: string)`. The `args` parameter is an array of arguments passed to the function that is being validated. The `result` boolean is used to indicate whether the typecchecking of the funcion succeeded. If this is false the `msg` value is used as the error messege that will be displayed to the user. The following example will demonstrate how this directive can be used to validate the number of arguments for the print function call.
```
print_validate :: (args: ...) -> (result: bool, msg: string) {
    // this assert indicates incorrect use of the #validate directive, not a failed validation
    assert(args.length > 0,
           "can only validate function with at least one arg");

    format_arg := args[0];
    args = args[1..args.length - 1];

    expected_arg_count := 0;
    loop c in format_arg {
        if c == '%' {
            expected_arg_count += 1;
        }
    }

    result = expected_arg_count == args.length - 1;
    msg = formatf("Incorrect number of arguments provided, the format specifier expects: %, provided: %\n", expected_arg_count, args.length - 1);
    return;
}

print :: #validate(print_validate) (format: string, args: ...) { ... }
```
-->

### Structs
Structs in this language can be parameterized. Structure parameter l follow the `struct` keyword, and have all the same properties of function parameter lists. The parameter then can be used inside the structure body, ex.:
```
hashmap :: struct (key: type, value: type) {
    keys: key[...];
    values: value[...];
}
```
Parameterized functions can be declared the same way as calling a function.
```
map: hashmap(string, u8);
```

<!-- TODO: These will get moved somewhere else -->
### Syntax Sugar of Strings and Dynamic Arrays
String and dynamic arrays are implemented partially in user space using structs. When declaring a string or a dynamic array the compiler will rewrite the code to the corresponding structure declaration before parsing.
String syntax sugar:
```
// Strings are defined by the following struct
String :: struct {
    length: u64;
    data: u8*;
}

// When declaring a string the contents of the literal
// will be stored in the .data section of the binary
// The compiler will store the pointer the string bytes
// in the `data` field, and the bytes count in the `length` field
```
Dynamic array syntax sugar:
```
// Dynamic arrays use the following struct
DynamicArray :: struct (dataType: type, defaultSize: u64 = 32) {
    capacity: u64;
    size: u64;
    data: dataType*;

    // More code here...
}

arr: u8[...];
// This declaration will be rewritten as such:
arr: DynamicArray(u8);

// The array access operator `[]`
// has special behaviour with the dynamic array struct.
arr[0] = 1;
// This will be rewrittend as such:
arr.data[0] = 1;
```

### Operators
<!-- TODO: all the operators, mention that there is no implicit casting -->
#### Binary Infix Operators
Arithmetic operators are:
- plus (`+`)
- minus (`-`)
- multiply (`*`)
- divide (`/`)

These operators can operate on integer or floating point literals of any size. The left and right side types have to be same in order for the operation to be valid. The resulting type of these operations is the same type as the input left and right side types.

Logical operators are:
- less than (`<`)
- greater than (`>`)
- less than or equal (`<=`)
- greater than or equal (`>=`)

These operators can operate on integer or floating point literals of any size. Similarly to arithmetic operators the types of the left and right side have to match. The result type of these operations however is a boolean type.

Additional logical operators that operate on different types:
- equal (`==`)
- not equal (`!=`)

These two operators can accept any types as operands, compare their equality then result in a boolean type.

Bitwise operators are:
- shift left (`<<`)
- shift right (`>>`)

These operators can also operate on any numerical types of any size. The resulting type will be the same type as the left hand side type.

#### Unary Prefix Operators
This language supports two unary operators, one arithmetic and one logical:
- minus (`-`)
- not (`!`)

The **not** operator can be used on the boolean type to invert it. The **minus** operator can be used on numerical types. It is worth noting that this operator is not part of the literal, and that it is not possible to specify negative numbers as literals. All literal specified are positive, and need to be negated using the **minus** operator if a negative number is required.

<!-- TODO: dereference, pointer, something to replace ternary operators -->
