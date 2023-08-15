// Retrieving the two biggest numbers from an array

func getTwoBiggest(from array: [Int]) throws -> (first: Int, second: Int) {
    if array.isEmpty || array.count < 2 {
        fatalError("Array does not have enough members")
    }
    
    var firstBiggest = Int.min
    var secondBiggest = Int.min
    
    for number in array {
        if number > firstBiggest {
            secondBiggest = firstBiggest
            firstBiggest = number
        }
        else if number > secondBiggest && number != firstBiggest {
            secondBiggest = number
        }
    }
//    let sortedArray = array.sorted(by: >)
    return (first: firstBiggest, second: secondBiggest)
}

let array = [2, 1, 12, 6, 10, 8, 7, 12]


if let result = try? getTwoBiggest(from: array) {
    print("First biggest: \(result.first)")
    print("Second biggest: \(result.second)")
}

