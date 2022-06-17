%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

func array_even_product(arr : felt*, size) -> (product : felt):
    if size == 0:
        return (product=1)
    end

    # size is not zero.
    let (product_of_rest) = array_even_product(arr=arr + 2, size=size - 2)
    return (product=[arr] * product_of_rest)
end

func main{output_ptr : felt*}():
    const ARRAY_SIZE = 4

    # Allocate an array.
    let (ptr) = alloc()

    # Populate some values in the array.
    assert [ptr] = 9
    assert [ptr + 1] = 16
    assert [ptr + 2] = 25
    assert [ptr + 3] = 2

    # Call array_even_product to compute the product of even elements.
    let (product) = array_even_product(arr=ptr, size=ARRAY_SIZE)

    # Write the product to the program output.
    serialize_word(product)
    return ()
end