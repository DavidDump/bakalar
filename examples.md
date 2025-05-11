# Code Examples
Here are some examples of common programming algorithms implemented in Benex.

Calculating the factorial of a number iteratively:
```
factorial :: (num: u64) -> u64 {
    result : u64 = 0;
    loop num {
        result = result * num;
        num = num - 1;
    }

    return result;
}
```

Calculating the factorial of a number recursivly:
```
// Factorial, recursive
factorial :: (num: u64) -> u64 {
    if num == 0 || num == 1 return 1;

    return num * factorial(num - 1);
}
```

Euclidean Algorithm, greatest common divisor:
```
GCD :: (a: u64, b: u64) -> u64 {
    loop b != 0 {
        tmp := b
        b := a % b
        a := tmp
    }

    return b;
}
```

Hello world, using functions provided by the windows API:
```
STD_HANDLE_STDOUT :: -12;

#library "kernel32.dll";
WriteFile    :: #extern (handle: s64, data: string, dataLen: u64,
                         bytesRead: u64*, overlapped: s64);
GetStdHandle :: #extern (handle: s64) -> s64;

main :: () -> u8 {
    stdout := GetStdHandle(STD_HANDLE_STDOUT);
    WriteFile(stdout, "Hello world", 11, 0, 0);
    return 0;
}
```
