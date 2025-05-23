# List Of All The Functions
This is a list of all the functions that are present in the Benex compiler codebase, aswell as a short description of what each function does.

## Lexer
```c
// Tokeninzes a source file
// @mem - arena allocator that will be used
//        for memory allocation during the function
// @source - a string containing the full source code
// @filename - the name of the file that the source was loaded from
Array(Token) Tokenize(Arena* mem, String source, String filename);
// Returns if the character input is a ASCII letter or not
bool isLetter(u8 c);
// Returns if the character input is a ASCII digit or not
bool isNumber(u8 c);
// Returns if the character input is a ASCII whitespace or not
bool isWhitespace(u8 c);
// Returns if the character input is a valid charcter
// in a symbol name or not
bool isValidVariableNameChar(u8 c);
// Returns if the string input is a valid simple type name or not
bool isType(String value);

// Debug function, print a single token
void TokenPrint(Token t);
// Debug function, print a single token as a row of a table
void TokenPrintAsTable(Token t, int locWidth,
                       int symbolNameWidth, int symbolWidth);
// Debug function, pretty print an array of tokens as a table
void TokensPrint(Array(Token)* tokens);
```

## Parser
```c
// Parse an array of tokens
// @tokens - the input tokens
// @mem - arena allocator that will be used
//        for memory allocation during the function
ParseResult Parse(Array(Token) tokens, Arena* mem);
// Consumes a single token from the tokens in the context,
// and returns it
Token parseConsume(ParseContext* ctx);
// Peeks at a single token from the tokens in the context,
// and returns it
Token parsePeek(ParseContext* ctx, int num);
// Stores a constant declaration in a scope
// @scope - the scope to store the declaration in
// @id - the name of the symbol that was declared
// @expr - the value that the symbol was bound to
void parseScopeStoreConst(Scope scope, String id, Expression* expr);
// Stores a variable declaration in a scope
// @scope - the scope to store the declaration in
// @id - the name of the symbol that was declared
// @statement - the type or the expression
//              used to infer the type of the symbol
void parseScopeStoreVar(Scope* scope, String id,
                        Statement* statement);
// Creates a binary expression
Expression* makeBinary(Arena* mem, Expression* left,
                       Token op, Expression* right);
// Creates a unary expression
Expression* makeUnary(ParseContext* ctx, Arena* mem, Token next);
// Creates an int or float expression
Expression* makeNumber(ParseContext* ctx, Arena* mem, Token tok);
// Creates a symbol expression
Expression* makeSymbol(Arena* mem, Token identifier);
// Creates a function call expression
Expression* makeFunctionCall(ParseContext* ctx,
                             Arena* mem, Token next);
// Creates a string expression
Expression* makeString(Arena* mem, Token value);
// Creates a bool expression
Expression* makeBool(Arena* mem, Token value);
// Creates a function call expression
Expression* makeFunctionLit(ParseContext* ctx,
                            Arena* mem, bool isExtern);
// Creates a compiler instruction expression
Expression* makeCompInstructionLeaf(ParseContext* ctx, Arena* mem);
// Creates a structure literal expression
Expression* makeStructLit(ParseContext* ctx, Arena* mem, Token next);
// Creates a structure field access expression
Expression* makeStructFieldAccess(ParseContext* ctx,
                                  Arena* mem, Token next);
// Identifies if the leaf expression currently parsed
// is a function call
bool isFunctionCall(ParseContext* ctx, Token next);
// Identifies if the leaf expression currently parsed
// is an int or a float
bool parseIsNumber(Token next);
// Identifies if the leaf expression currently parsed
// is a unary
bool isUnaryOperator(Token next);
// Identifies if the leaf expression currently parsed
// is a structure literal
bool isStructLit(ParseContext* ctx, Token next);
// Identifies if the leaf expression currently parsed
// is a field access of a structure
bool isStructFieldAccess(ParseContext* ctx, Token next);
// Identifies if the leaf expression currently parsed
// is a function call
bool isFunctionLit(ParseContext* ctx, Token next);
// Attempts to parse function args,
// if successful return the arguments,
// if not print error to user and exit
Array(FunctionArg) parseFunctionArgs(ParseContext* ctx, Arena* mem);
// Creates a generic scope and initializes it with the correct data
// @mem - arena allocator that will be used
//        for memory allocation during the function
// @parent - the parent of this scope
GenericScope* parseGenericScopeInit(Arena* mem, Scope parent);
// Creates a global scope and initializes it with the correct data
// @mem - arena allocator that will be used
//        for memory allocation during the function
// @parent - the parent of this scope
GlobalScope* parseGlobalScopeInit(Arena* mem, Scope parent);
// Convert a generic scope type into a scope type
Scope makeScopeFromGeneric(GenericScope* scope);
// Convert a global scope type into a scope type
Scope makeScopeFromGlobal(GlobalScope* scope);
// Attempt to parse a generic scope into target,
// if successful the target doesnt need to be returned
// as its passed in as a pointer,
// if not print error to user and exit
void parseGenericScopeInto(ParseContext* ctx,
                           Arena* mem, GenericScope* target);
// Attempt to parse a generic scope,
// if successful returns a generic scope,
// if not print error to user and exit
GenericScope* parseGenericScope(ParseContext* ctx,
                                Arena* mem, Scope parent);
// Attempt to parse a type,
// if successful returns a parsed type,
// if not print error to user and exit
ParsedType* parseType(ParseContext* ctx, Arena* mem);
// Identify the type of the initializer list of a structure literal,
// designated or positional initializer list
StructInitializerListType structGetListType(ParseContext* ctx,
                                            Token next);
// Attempt to parse a leaf node of an expression,
// if successful returns the leaf node,
// if not print error to user and exit
Expression* parseLeaf(ParseContext* ctx, Arena* mem);
// Return if the token is a operator or not
bool isOperator(Token token);
// Returns the presedence level of an operator
s64 getPresedence(Token token);
// Continue parsing an expression
// where operators have been verified to have increasing presedence
// @ctx - the context of the parser
// @mem - arena allocator that will be used
//        for memory allocation during the function
// @left - the left subexpression of the resulting expression
// @minPrec - the minimum presedence
//            of the operators encountered so far
// @return the parsed subexpression
Expression* parseIncreasingPresedence(ParseContext* ctx, Arena* mem,
                                      Expression* left, s64 minPrec);
// Continue parsing an expression
// where operators have been verified to have decreasing presedence
// @ctx - the context of the parser
// @mem - arena allocator that will be used
//        for memory allocation during the function
// @minPrec - the minimum presedence
//            of the operators encountered so far
// @return the parsed subexpression
Expression* parseDecreasingPresedence(ParseContext* ctx,
                                      Arena* mem, s64 minPrec);
// Attempt to parse an expression,
// if successful returns the expression,
// if not prints error to user and exits
Expression* parseExpression(ParseContext* ctx, Arena* mem);
// Checks if the token at the top of the context is a semicolon token,
// if not prints error to user and exits
bool parseCheckSemicolon(ParseContext* ctx);
// Attempt to parse a single statement,
// if successful returns the statement,
// if not prints error to user and exits
Statement* parseStatement(ParseContext* ctx,
                          Arena* mem, Scope containingScope);
// Attempt to parse a global scope into target,
// if successful the target doesnt need to be returned
// as its passed in as a pointer,
// if not prints error to user and exits
GlobalScope* parseGlobalScopeInto(ParseContext* ctx, Arena* mem,
                                  GlobalScope* globalScope);
// Attempt to parse a global scope,
// if successful returns a global scope,
// if not prints error to user and exits
GlobalScope* parseGlobalScope(ParseContext* ctx, Arena* mem);
```

## Typechecker
```c
// Typechecks the AST returned by the parser,
// if successful return the AST with types associated with the nodes
TypecheckedScope* typecheck(Arena* mem, ParseResult* parseResult);
// Evaluates a constant binary expression
// @lhs - the left subexpression
// @operator - the operation to perform on the two subexpressions
// @rhs - the right subexpression
// @return the result of the operation, with type information
ConstValue evaluateBinaryExpression(ConstValue lhs,
                                    Token operator, ConstValue rhs);
// Evaluates a constant unary expression
// @operator - the operation to perform on the expression
// @value - the expression to apply the operation to
// @return the result of the operation, with type information
ConstValue evaluateUnaryExpression(Token operator, ConstValue value);
// Returns true if a symbol is defined
// @containing - the scope to start checking in,
//               parent scopes are also checked
// @constants - all the constant and their values
//              that are visible from this scope
// @id - the name of the sybol
// @return true if defined, false if not
bool isSymbolDefined(TypecheckedScope* containing,
                     Hashmap(String, ConstValue)* constants,
                     String id);
// Declare a variable in a scope, check for redefinitions
// @scope - the scope that the variable is declared in
// @constants - all the constant and their values
//              that are visible from this scope
// @id - the name of the variable
// @type - the type of the variable
void saveVariable(TypecheckedScope* scope,
                  Hashmap(String, ConstValue)* constants,
                  String id, TypeInfo* type);
// Declare a parameter of a function scope, check for redefinitions
// @scope - the function scope that the parameter is declared in
// @constants - all the constant and their values
//              that are visible from this scope
// @id - the name of the parameter
// @type - the type of the parameter
void saveParam(TypecheckedScope* scope,
               Hashmap(String, ConstValue)* constants,
               String id, TypeInfo* type);
// Declare a constant in a scope, check for redefinitions
// @scope - the scope that the constant is declared in
// @constants - all the constant and their values
//              that are visible from this scope
// @id - the name of the constant
// @val - the value of the constant
void saveConstant(TypecheckedScope* containing,
                  Hashmap(String, ConstValue)* constants,
                  String id, ConstValue val);
// Declare a function in a scope, check for redefinitions
// @scope - the scope that the function is declared in
// @constants - all the constant and their values
//              that are visible from this scope
// @id - the name of the function
// @val - the value of the function
void saveFunction(TypecheckedScope* scope,
                  Hashmap(String, ConstValue)* constants,
                  String id, ConstValue val);
// Declare a struct in a scope, check for redefinitions
// @scope - the scope that the struct is declared in
// @constants - all the constant and their values
//              that are visible from this scope
// @id - the name of the struct
// @val - the value of the struct
void saveStruct(TypecheckedScope* scope,
                Hashmap(String, ConstValue)* constants,
                String id, TypeInfo* val);
// Creates a TypecheckedScope and initializes it with the correct data
// @mem - arena allocator that will be used
//        for memory allocation during the function
// @parent - the parent of this scope
TypecheckedScope* TypecheckedScopeInit(Arena* mem,
                                       TypecheckedScope* parent);
// Evaluates a single constant expression
EvaluateConstantResult
evaluateConstant(Expression* expr, Arena* mem,
                 Hashmap(String, ConstValue)* evaluatedConstatants);
// Converts a constant value to an expression
Expression ConstValueToExpression(Arena* mem, ConstValue value);
// Finds the value bound to a constant symbol
// @constants - all the constant and their values
//              that are visible from this scope
// @identifier - the name of the symbol
ConstResult findConstant(Hashmap(String, ConstValue)* constants,
                         String identifier);
// Finds the value bound to a struct symbol
// @scope - the scope to start checking in,
//          parent scopes are also checked
// @identifier - the name of the symbol
TypeResult findStruct(TypecheckedScope* scope, String identifier);
// Finds the value bound to a function symbol
// @scope - the scope to start checking in,
//          parent scopes are also checked
// @id - the name of the symbol
TypeResult findFunctionType1(TypecheckedScope* scope, String id);
// Finds the value bound to a variable symbol
// @scope - the scope to start checking in,
//          parent scopes are also checked
// @id - the name of the symbol
TypeResult findVariableType(TypecheckedScope* scope, String id);
// Attemts to typecheck a single expression,
// if successful returns the typechecked expression,
// if not prints error to user and exits
TypecheckedExpression*
typecheckExpression(Arena* mem, Expression* expr,
                    TypecheckedScope* scope,
                    Hashmap(String, ConstValue)* constants,
                    TypeInfo* expected);
// Finds all the function and structure declarations in a scope
FunctionsInScope
typecheckProcessConsts(Arena* mem, Scope scope,
                       Hashmap(String, ConstValue)* target);
// Attemts to typecheck all the functions in a scope,
// if not successful prints error to user and exits
void typecheckFunctions(Arena* mem,
                        Hashmap(String, ConstValue)* constants,
                        TypecheckedScope* parent,
                        FunctionsInScope functions);
// Attemts to typecheck a scope,
// rather that returning the typechecked scope,
// the result parameter is used to return the result,
// if not successful prints error to user and exits
void typecheckScopeInto(Arena* mem, GenericScope* scope,
                        TypecheckedScope* result,
                        Hashmap(String, ConstValue)* constants,
                        TypeInfo* expectedReturnType);
// Attemts to typecheck a scope,
// if successful returns a typechecked scope,
// if not prints error to user and exits
TypecheckedScope*
typecheckScope(Arena* mem, GenericScope* scope,
               TypecheckedScope* parent,
               Hashmap(String, ConstValue)* constants,
               TypeInfo* expectedReturnType);
// Attemts to typecheck the global scope,
// if successful returns a typechecked scope,
// if not prints error to user and exits
TypecheckedScope*
typecheckGlobalScope(Arena* mem, GlobalScope* scope,
                     Hashmap(String, ConstValue)* constants);
```

## Backend / Assembler
```c
// Emit the bytecode of a typechecked AST
GenContext gen_x86_64_bytecode(Arena* mem, TypecheckedScope* scope);
// Emit a ModR/M byte into the code buffer of the context
void genModRMByte(GenContext* ctx, AddressingMode mod,
                  Register reg, Register rm);
// Emit a SIB byte into the code buffer of the context
void genSIBByte(GenContext* ctx,
                Scale scale, Register index, Register base);
// Emit a REX byte into the code buffer of the context
void genRexByte(GenContext* ctx,
                u8 w, Register r, Register x, Register b);
// Emit 8 bytes of data into the code buffer of the context
void Emit8(GenContext* ctx, u8 data);
// Emit 16 bytes of data into the code buffer of the context
void Emit16(GenContext* ctx, u16 data);
// Emit 32 bytes of data into the code buffer of the context
void Emit32(GenContext* ctx, u32 data);
// Emit 64 bytes of data into the code buffer of the context
void Emit64(GenContext* ctx, u64 data);
// Emit direct addressing bytes into the code buffer of the context
void EmitDirect(GenContext* ctx, Register reg, Register rm);
// Emit indirect addressing bytes into the code buffer of the context
void EmitIndirect(GenContext* ctx, Register reg, Register rm);
// Emit indirect addressing with 8 byte displacement,
// bytes into the code buffer of the context
void EmitIndirectDisplaced8(GenContext* ctx, Register reg,
                            Register rm, u8 displacement);
// Emit indirect addressing with 32 byte displacement,
// bytes into the code buffer of the context
void EmitIndirectDisplaced32(GenContext* ctx, u8 reg,
                             Register rm, u32 displacement);
// Emit SIB addressing, bytes into the code buffer of the context
void EmitIndirectSIB(GenContext* ctx, u8 reg, Register rm,
                     Register index, Scale scale);
// Emit SIB addressing with 8 bytes displacement,
// bytes into the code buffer of the context
void EmitIndirectDisplaced8SIB(GenContext* ctx, u8 reg, Register rm,
                               Register index, Scale scale,
                               u8 displacement);
// Emit SIB addressing with 32 bytes displacement,
// bytes into the code buffer of the context
void EmitIndirectDisplaced32SIB(GenContext* ctx, u8 reg, Register rm,
                                Register index, Scale scale,
                                u32 displacement);
// Emit RIP relative addressing,
// bytes into the code buffer of the context
void EmitIndirectDisplacedRip(GenContext* ctx, u8 reg,
                              u32 displacement);
// Emit absolute addressing,
// bytes into the code buffer of the context
void EmitIndirectAbsolute(GenContext* ctx, u8 reg,
                          u32 displacement);
// Returns true if the instruction encoding is zeroed out
bool isZeroStruct(InstructionEncoding* enc);
// Returns true if the two instruction encodings match
bool checkEncodingsMatch(OperandType operandType,
                         OpType encodingOperandType);
// Emit the bytecode of an instruction into 
void genInstruction(GenContext* ctx, Instruction inst);
// Emit the bytecode of an external function call
// into the code buffer of the context
void gen_callExtern(GenContext* ctx, String name);
// Emit the bytecode of an internal function call
// into the code buffer of the context
void gen_call(GenContext* ctx, String name);
// Emit the bytecode of a data section memory access
// into the code buffer of the context
void gen_DataInReg(GenContext* ctx, Register reg, String name);
// Align a number to the specified alignment
u64 align(u64 num, u64 alignment);
// Emit a push instruction to the code buffer of the context,
// and keep track of the stack pointer relative to
// the function scope base
void genPush(GenContext* ctx, GenScope* scope, Register reg);
// Emit a pop instruction to the code buffer of the context,
// and keep track of the stack pointer relative to
// the function scope base
void genPop(GenContext* ctx, GenScope* scope, Register reg);
// Finds the symbol offset relative to the frame base,
// returns result or an error
SymbolLocationResult findSymbolLocation(GenScope* scope,
                                        String name);
// Finds the type of a function, returns result or an error
TypeInfo* findFunctionType(GenScope* localScope, String id);
// Emit bytecode, to cast the left hand side expression,
// to the type of the right hand side expression,
// into the code buffer of the context
void gen_x86_64_cast(GenContext* ctx, TypecheckedExpression* lhs,
                     TypecheckedExpression* rhs,
                     GenScope* localScope);
// Find the offset of a field in a struct by name,
// returns result or an error
StructFieldResult findStructFieldOffsetByName(TypeInfo* structType,
                                              String fieldName);
// Find the offset of a field in a struct by field index,
// returns result or an error
StructFieldResult findStructFieldOffsetByIndex(TypeInfo* structType,
                                               u64 index);
// Find the type of a variable, returns result or an error
VariableTypeResult findVariableType(GenScope* scope, String id);
// Emit the bytecode of an expression to the code buffer
// of the context, the result of the expression will end up in the
// rax register
void gen_x86_64_expression(GenContext* ctx,
                           TypecheckedExpression* expr,
                           GenScope* localScope);
// Emit the bytecode of a condition to the code buffer of the context,
// returns the offset that should get patched,
// where the target address of the jump is stored,
// in case the condition is false
u64 gen_x86_64_condition(GenContext* ctx, TypecheckedExpression* expr,
                         GenScope* localScope);
// Patch the address at the target location, with the provide value
void gen_patchAddress(GenContext* ctx,
                      u64 patchTarget, u64 targetAddress);
// Create a scope and initialize all the correct values
GenScope* genScopeInit(Arena* mem, TypecheckedScope* from,
                       GenScope* parent);
// Emit the bytecode of a scope into the code buffer of the context
void genGenericScope(GenContext* ctx, Arena* mem,
                     TypecheckedScope* scope, GenScope* parentScope);
// Emit the bytecode of a single statement
// into the code buffer of the context
void genStatement(GenContext* ctx, Arena* mem,
                  TypecheckedStatement statement, GenScope* genScope);
// Calculate and reserve stackspace
// at the begining of a function scope,
// for each variable used in the function scope
void calculateSpaceForVariables(GenScope* genScope,
                                TypecheckedScope* scope);
// Emit the bytecode of a single function
// into the code buffer of the context
GenScope* genFunction(GenContext* ctx, Arena* mem, String id,
                      ConstValue fnScope, GenScope* parent);
// Emit the bytecode for all the functions in a scope
// into the code buffer of the context,
// and all the functions declared in their scope recursively
void genAllFunctionsRecursively(GenContext* ctx, Arena* mem,
                                TypecheckedScope* scope,
                                GenScope* parent);
```

## PE32 generator
```c
// Generates a PE32 executable file
// from the bytecode generated by the assembler
Array(u8) genExecutable(Hashmap(String, LibName)* libs,
                        Array(u8) bytecode,
                        Array(AddrToPatch) names,
                        Hashmap(String, UserDataEntry)* userData,
                        Array(AddrToPatch) dataToPatch,
                        u64 entryPointOffset);
// Find the address that a function will have
// once the section is loaded into memory
u32 findFunctionRVA(Hashmap(String, LibName)* libs, String name);
// Find the address that data stored in the data sections will have
// once the section is loaded into memory
u32 findDataRVA(Hashmap(String, UserDataEntry)* userData,
                String name);
// Create the data section from the hashmap of data entries
ParsedDataSection
parseDataSection(Hashmap(String, LibName)* libs,
                 Hashmap(String, UserDataEntry)* userData,
                 IMAGE_SECTION_HEADER *header);
```

## Miscellaneous functions
### Types
```c
// Returns the string representation of a type
String TypeToString(Arena* mem, TypeInfo* typeInfo);
// Initializer a simple typeInfo struct of type t
TypeInfo* TypeInitSimple(Arena* mem, Type t);
// Returns the size of a type in bytes
u64 TypeToByteSize(TypeInfo* type);
// Returns true if type is signed
bool TypeIsSigned(TypeInfo* type);
// Returns true if type is unsigned
bool TypeIsUnsigned(TypeInfo* type);
// Returns true if type is a float
bool TypeIsFloat(TypeInfo* type);
// Returns true if type is a integer
bool TypeIsInt(TypeInfo* type);
// Returns true if type is a number (integer or float)
bool TypeIsNumber(TypeInfo* type);
// Returns true if type is a boolean
bool TypeIsBool(TypeInfo* type);
// Returns true if type is a type
bool TypeIsType(TypeInfo* type);
// Returns true if type is a struct
bool TypeIsStructDef(TypeInfo* type);
// Returns true if two types match
bool TypeMatch(TypeInfo* type1, TypeInfo* type2);
// Returns the default type for an integer
Type TypeDefaultInt();
// Returns the default type for a float
Type TypeDefaultFloat();
```

### Strings
```c
// Creates a string from a c-string
String StringFromCstrLit(char* cstr);
// Creates a string from a c-string,
// copies it into the memory allocated by the arena
String StringFromCstr(Arena* mem, char* cstr);
// Returns true if two string are equal
bool StringEquals(String str1, String str2);
// Returns true if a string and a c-string are equal
bool StringEqualsCstr(String str1, char* cstr);
// Returns true if a string contains a substring
bool StringContains(String str1, char* cstr);
// Converts a string value to a u64
u64 StringToU64(String value);
// Converts a u64 value to a string
String StringFromU64(Arena* mem, u64 value);
// Converts a string value to a u32
u32 StringToU32(String value);
// Converts a string value to a s64
s64 StringToS64(String value);
// Converts a s64 value to a string
String StringFromS64(Arena* mem, s64 value);
// Converts a f64 value to a string
String StringFromF64(Arena* mem, f64 value);
// Returns true if a string ends with a substring
bool StringEndsWith(String str, String end);
// Returns the index of the last occurrence of a character,
// if the character is not present in the string returns -1
s64 StringLastIndexOf(String str, u8 c);
// Calculate the djb2 hash of a string
u64 StringHash(String str);
```

### Memory Arenas
```c
// Creates a new memory region
Region *new_region(size_t capacity);
// Frees an existing memory region
void free_region(Region *r);
// Allocates the requested amount of bytes in an arena
void *arena_alloc(Arena *a, size_t size_bytes);
// Resizes a region of memory in an arena
void *arena_realloc(Arena *a, void *oldptr,
                    size_t oldsz, size_t newsz);
// Reset an arena to its initial state for future reuse
void arena_reset(Arena *a);
// Frees all the memory allocated in an arena
void arena_free(Arena *a);
```

### Operator Functions
```c
// Evaluate the result of a constant addition operation
ConstValue _add(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant subtraction operation
ConstValue _sub(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant multiplication operation
ConstValue _mul(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant division operation
ConstValue _div(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant boolean less than operation
ConstValue _less(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant boolean greater than operation
ConstValue _greater(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant boolean less than or equals operation
ConstValue _less_eq(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant boolean greater than or equals operation
ConstValue _greater_eq(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant boolean equals operation
ConstValue _equals(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant boolean not equals operation
ConstValue _not_equals(ConstValue lhs, ConstValue rhs);
// Evaluate the result of a constant cast operation
ConstValue _as(ConstValue lhs, ConstValue rhs);
```
