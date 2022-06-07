# 8bitArray
8bitArray is an implementation of an array in huff, it can store up to 32 8-bit values in a single storage slot. 8bitArray does all the bitwise operations so you don't have to.

**DISCLAMER: contracts are not audited nor optimized**

## Prerequisities

Make sure you have the following programs installed:

- [huffc](https://github.com/huff-language/huffc)
- [foundry](https://github.com/foundry-rs/foundry)

## Tests

To run tests:
```shell
    forge test
```
NB: foundry template is from this [article](https://medium.com/@jtriley15/huff-vs-yul-for-evm-smart-contracts-620d1d618197).

## Bytecode

You can generate the bytecode for the testing interface yourself with this:
```shell
    huffc src/8bitArray_testingInterface.huff --bytecode
```