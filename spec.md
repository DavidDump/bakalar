# Lang Spec
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
  #run
  #if
  #char
  #assert_param
  #type - maybe if need
  #import
  #extern
  #private
  #public
  #caller_line
  #caller_func
  #caller_file
  #no_discard
  ...
typeof (maybe typeinfo) keyword
  explain runtime type information
using keyword

maybes:
  list of all keywords at the begining
  list of all operators at the begining
-->

Draft of some of the ideas that inspired me to do the language:
- not opinionated, lets you do what you want
- native compiled
- strongly and statically typed
- not a big idea language, doesnt introduce anything new, just refines existing ideas
- compile time execution, note: i dont know if i can finish this feature in time
- using compile time execution, programs can be self contained, no need for build systems
- joy of programming, programming is a activity that i enjoy doing, when typing in code i dont want to fight with the compiler, once i know what i want to happen i want to be able to describe it as simply as possible and have the compiler do what i want
- fast compiler time for fast iteration of ideas

The programming language is a strongly statically typed language, that compiles down to native x86 machine code.

Programming is an activity many enjoy doing not just for work but recreationaly aswell. This language aims to make the act of designing software easier by letting the programmer iterate over the code faster than more verbose languages, like C or Java, but also require less bureaucratic bookeeping for a semantically correct program, than languages like Rust or Java.

The programming language is not a "big idea" language. It doesnt introduce any revolutionary concepts to programming language design. It merly aims to refine existing concept so that they are more aligned with what the programmer usually wants to use them for.
The design aims to allow the programmer to use powerful concepts like generics, without having to play "type tetris", having to figure out what type goes where, when refactoring code.
The programming language is a collection of ideas the we often implement ourselves when programming in lower level languages that dont provide them out of the box.

No useless busywork, like manually having to dereference pointers in C when after refactoring the code flip-flops from value to pointer or vice versa. Or when coping

The programming language aims to have fast compile times so that features like incremental compilation are not needed. 
Fast compile times allow the programmer to quicly try out ideas or morph them in some way that gets closer to the solution to the problem that they are currently dealing with.

The main inspiration for the language was the Jai programming language, written by Jonathan Blow. This language is currently in closed beta, meaning its not publicly accesible,

Many features in the language are implemented in userspace, or runtime, as this leaves to compiler behaving like a traditional low level compiler wihtout bloating it, while also allowing better syntax support for all the features. All of these features can be turned off. This also means there is no "voodoo" duiring runtime, and a programmer can implement their own features that behave similarly to native compiler features.

## Literals
- integer literals consist of one or more digits, ex.: `123`
  - all integer literals are always positive numbers, signs like plus (`+`) or minus (`-`) are operators and not part of the literal
  - integer literals can be specified in hexadecimal or in binary format as well
    - hexadecimal integer literals are prefixed with a `0x`, ex.: `0xCAFEBABE`
    - binary integer literals are prefixed with a `0b`, ex.: `0b110100`
  - underscores (`_`) can be used inside an integer literal to make them easier to read, ex.: `1_200`, `0xFF_CA`, `0b1101_00110100`
- floating point literals consist of zero or more digits, followed by a dot (`.`), followed by zero or more digits, ex.: `3.14`, `10.`, `.5`
  - all floating point literals are always positive numbers, signs like plus (`+`) or minus (`-`) are operators and not part of the literal
  - if the digits before the dot (`.`) are ommited the compiler will assume 0 before the dot (`.`)
  - if the digits after the dot (`.`) are ommited the compiler will assume 0 after the dot (`.`)
  - these assumptions mean, that the following representations for the floating point literal 0 are all valid: `0.0`, `0.`, `.0`, `.`
- boolean literals can be one of two values: `true` or `false`
- string literals open with a double quote (`"`) followed by any number of UTF-8 characters, followed by a closing double quote (`"`), ex.: `"Hello World!"`
  - the backslash (`\`) character followed by another character can be used to instert a special character into the string literal:
    - `\n` inserts a newline character
    - `\r` inserts a carriage return character
    - `\t` inserts a tab character
    - `\"` inserts a double quote character
    - `\\` inserts a backslash
  - if a string literal spans two or more lines the newline at the end line will also be added to the string literals as if `\n` was used, the same is true for tabs
- function literals consist of an **argument list**, a **return type list**, and a **function body**
  - the argument list is enclosed in parenthesis (`( ... )`) and contains zero or more arguments, an argument in a name followed by a colon (`:`) and a type, multiple arguments are comma (`,`) separated, ex.: `(number1: u64, number2: u64)`
  - the return type list is a comma (`,`) separated list of types, the list can be ommited if the function doesn't return anything, ex.: `u64, bool`
  - the argument list and the return type list are delimited by the arrow symbol (`->`), if the return type list is ommited this symbol can also be ommited
  - the funtion body is a list of statements enclosed in curly braces (`{ ... }`)
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
  - complex (compound?) types include: `struct`, `enum`, `function`, `type`
    - struct type literals start with the keyword `struct` followed by a list of variable or constant declarations enclosed in curly braces (`{ ... }`), ex.: `struct { ... }`
    - enum type literals start with the keyword `enum` followed by a comma (`,`) seperated list of names enclosed in curly braces (`{ ... }`), ex.: `enum { ... }`
  <!-- - TODO: better explain this section -->

<!-- TODO: function call is also kindof a literal -->

## Expressions
Expressions can be single literals, binary expressions or unary expressions. Binary expressions consist of a infix operator and two subexpressions. Unary expressions consist of a prefix operator and a single subexpression.

## Symbols
The names of variables and constants are referred to as symbols. A symbol has to start with a letter, followed by any number of letters, digits on underscores (`_`). The programmer can bind expressions to symbols. Binding a constant symbol uses the double colon (`::`) operator, binding a variable symbol uses the colon-equals (`:=`) operator. Example of binding a constants and a variable symbol:
```
foo :: 1; // This is a constant symbol
bar := 2; // This is a variable symbol
```
The difference between constants and variables is that constant expressions need to be know at compile time, while variable expressions do not. Variable expressions can also change, while constant expressions can not. Lastly when constant symbols are used in an expression they get replaced by their literal value during compile time. An example of this behaviour:
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
If we use variables instead in the second example, the expressions of `ONE` and `TWO` are first stored in memory, then read from memory again when the operation is perfored. NOTE: this is a simple example end using SSE both cases would generate the same bytecode.

All symbols have a type. The type of a symbol is either explicitly specified by the programmer or infered by the compiler. If the programmer wishes to specify a type they can do so after the first colon (`:`) of the declaration operators (`:=` or `::`). Example:
```
foo : u32 = 42;
```
If no type if provided the compiler will try to infer the type. Simple expressions like `true` or `"Example"`, that can only be one type will be infered as such (???). Numbers like integers and floating points that can have a varying level of precision will always be infered as the highes level of precision possible, ie.: `s64`, `f64`. Complex types like structs and enums that implicitly specify their type in the literal value, can have the type ommited from the literal value if the symbol already has a explicitly specified type. Example of this behaviour:
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

## Control Flow
<!-- if, loop, defer, break, continue -->
### If
The `if` keyword is mostly the same as other programming languages, as it is followed by a condition and a body that gets executed if the condition evaluates to `true`. The condition is a expression, and the body is a list of statements enclosed in curly braces (`{ ... }`). If the body only contains one statement the curly braces (`{ ... }`) can be ommited. One notable difference however is that the parenthesis (`( ... )`) around the condition are optional, howerver if parenthesis are present they are part of the expression not the `if` statement. An `if` block can optionaly be followed by either an `else if` or an `else` block. An `else if` block also requires a condition before the body. Examples:
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

### Loop for a while
<!-- TODO: maybe write more about why not `for`, `while` -->
Usually languages use two keywords for iteration: `for` and `while`. Other that the slightly different syntax there is very little difference between these two constructs. This programming language only has one, the `loop` keyword. A loop stantement starts with a `loop` keyword, followed by a optional expression and a body. There a multiple ways to use this keyword, each with its own unsique behaviour:
- Loop without a condition, this case is an infinite loop, ex.:
  - `loop { ... }`
- Loop with an expression that evaluates to a number, this case will iterate a fixed amount of times, and the expression will only be evaluated once, before the loop iteration begins, this means that if the expression contains variables, and these variables change in the body of the loop, the number of iterations will not change, ex.:
  - `loop 5 { ... }` - this will iterate 5 times
  - `loop foo { ... }` - foo is assumed to be a integer, this will iterate foo number of times, regardless if foo changes in the loop body
- Loop with an expression that evaluates to a boolean, this case will iterate while the expression evaluates to `true`, this means the expression will be evaluated and checked every iteration of the loop, ex.:
  - `loop foo < 5 { ... }` - foo is assumed to be a integer, this will iterate while foo is less than 5, the condition is checked on each iteration of the loop
- Loops can also iterate over arrays, in this case instead of a expression, the `loop` keyword is followd by a name, that the Nth element will be bound to every iteration, the `in` keyword, and lastly the array to iterate over, ex.:
  - `loop number in numbers { ... }` - numbers is assumend to be and array, number will be bound to the value of the Nth element of the array
  - `loop number* in numbers { ... }` - numbers is assumend to be and array, number will be bound to the referance of the Nth element of the array
<!-- NOTE: maybe clearer names in the last two examples -->

Similarly to the `if` statement, the `loop` body can also have its curly braces (`{ ... }`) ommited if the body only contains one statement. Another similarity with the `if` keyword is that the expression following the `loop` keyword doesn't need to be enclosed in parenthesis (`( ... )`). If parenthesis are provided they are not part of the `loop` statement, instead are part of the expression.

### Continue, break
<!-- TODO: mabye merge with the loops section -->
<!-- TODO: decide if i want to add named loops and mention continuing and breaking out of names loops -->
Similar to most languages, the `continue` and `break` keywords are present in this programming language. They behave as expected, `continue` skips to the next iteration of a loop, `break` ends the loops early.

<!-- TODO: move somewhere where this makes sense -->
This is a semicolon language, meaning there is a semicolon (`;`) at the end of each statement.

### Defer
The `defer` keyword can be used to specify code that should be executed at the end of the scope. It is followed by a semicolon (`;`) separated list of statements enclosed in curly braces (`{ ... }`). Like all other keywords that have a body, the enclosing curly braces (`{ ... }`) can be ommited if the body only contains one statement. The statments are executed in reverse order in which they were specified.

## Functions
<!-- default values, multiple return types, overloading, variadics, generics, #assert_param -->
### Default values
Function parameters can have default values that will be used in case the function is called without providing a value for that parameter. Default values are specified using an equals (`=`) and the value, after the parameter type, ex.: `(number: u32 = 10) -> u32 { ... }`. When calling a function with a default parameter in the middle of the parameter list, it is possible to simply ommit the value of the parameter in the middle of the argument list, ex.: `foo(arg1,, arg3)`. This example will pass symbols `arg1` as the fist argument and `arg3` as the third argument. The second parameter will use its default value. If a default value is provide the type of the parameter can be ommited, as the value can be used to infer the type.

### Return values
When a function has multiple return values, the `return` keyword needs to be followed by a comma (`,`) separated list of expressions. The list of return types is similar to the parameter list of the function literal, because each return type can also be named and can have a default value. If the return type is named the symbol is declared at the begining of the function and can be assigned to, if it also has a default value it will immediatly be assigned that value. If named return types are used all return types have to be named. Once all the return symbols have a value assigned to them, the `return` keyword can be used without any expressions.
<!-- TODO: examples -->

### Overloading
When binding function literals to a constant symbol, there is a special rule, where multiple functions can be bound to the same symbol as long as the parameter list differs in its types.

### Variadics
Variadic functions like `printf` in C can take any number of arguments of any type. In the case of `printf` the number and type of arguments is passed to the function by the format string. In this programming language variadic function parameters are specified by replacing the type of the last parameter with a tripple dot (`...`), ex.: `(fmt: string, args: ...) { ... }`. Variadic parameters cannot have a default value, and only one variadic parameter can be specified. Inside the function body the symbol bound to the variadic parameter will have a type of array of any.

### Generics
A generic version of a function can be specified by replacing the type of one or more parameters, with a symbol name prefixed by a dollar sign (`$`), this will declare a generic parameter, ex.: `(arg: $T)`. When calling the function the programmer can pass an argument of any type to the generic parameter. Inside the function body the symbol prefix by a dollar sign (`$`) will be bound to the type that the calling argument had. Later uses of this symbol do not need the dollar sign (`$`) prefix. This symbol can be used both in the function declaration and body, ex.: `(arg1: $T, arg2: T) -> T { ... }`.
When declaring a generic function with `$T`, `T` will only be bound to the base type, not the pointer type, so `u32*` would result in `T == u32`, if we expect a pointer it needs to be specified explicitly, like this `$T*`.

A generic parameter accepts any type as its argument, the way the parameter is used in the function can be a clue as to what types are valid. The programmer can be more explicit about this by using the `#assert_param` compiler directive. This compiler directive is similar to a regular assertion:
```
assert_param :: (condition: bool, message: string, args: ...);
```
The two differences between this directive and `#assert`, is that this directive can only be used inside a function body, abd that the condition has to contain at least one symbol defined in the function parameter list. If the condition provided is false the compiler will report an error at the function callsite, with the message provided. The compiler will also mark the arguments that were used in the condition, as errors along the reported message. This can be used to assert centaint properties of the parameters of generic functions, and report any isssues as a compiler error.
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
    #assert_param(isNumber(T), "Parameter types need to be numbers, provided: %", T);
    return num1 + num2;
}
```

<!-- ### Validate directive -->

## Structs
Structs in this language can be parameterized. Structure parameter l follow the `struct` keyword, and have all the same properties of function parameter lists. The paremeter then can be used inside the structure body, ex.:
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
## Syntax Sugar of Strings and Dynamic Arrays
String and dynamic arrays are implemented partially in userspace using structs. When declaring a string or a dynamic array the compiler will rewrite the code to the corresponding structure declaration before parsing.
String syntax sugar:
```
// String use the following struct
String :: struct {
    length: u64;
    data: u8*;
}

// When declaring a string the contents of the literal will be stored in the .data section of the binary
// The compiler will store the pointer the string bytes in the `data` field, and the bytes count in the `length` field
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

// The array access operator `[]` has special behaviour with the dynamic array struct.
arr[0] = 1;
// This will be rewrittend as such:
arr.data[0];
```

## Operators
<!-- all the operators, mention that there is no impicit casting -->
### Binary Infix Operators
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

### Unary Prefix Operators
This language supports two unary operators, one arithmetic and one logical:
- minus (`-`)
- not (`!`)

The **not** operator can be used on the boolean type to invert it. The **minus** operator can be used on numereical types. It is worth noting that this operator is not part of the literal, and that its not possible to specify negative numbers as literals. All literal specified are positive, and need to be negated using the **minus** operator if a negative number is required.

<!-- dereference, something to replace ternary operators -->