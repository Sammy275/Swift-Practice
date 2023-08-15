// A basic calculator
let numberOne: Double
let numberTwo: Double
let operation: String

print("Some examples of how the calculator works.")
print("Enter like this: \n12 + 34\n23.4 * 2\n9 / 3")
print("Please make sure that there is a space present in between the operator and the numbers")
print("Enter 0 as operator to exit\n\n\n\n\n")

func performCalculation() -> Int? {
    print("Please enter: ", terminator: "")
    if let rawInput = readLine() {
        let parsedInput = rawInput.split(separator: " ")
        
        if (parsedInput.count == 3) {
            if let numberOne = Double(parsedInput[0]), let numberTwo = Double(parsedInput[2]) {
                let operation = String(parsedInput[1])
                
                switch operation {
                case "+":
                    print(numberOne + numberTwo)
                case "-":
                    print(numberOne - numberTwo)
                case "*":
                    print(numberOne * numberTwo)
                case "/":
                    print(numberOne / numberTwo)
                case "0":
                    return nil
                default:
                    print("Unknown operation")
                }
            }
            else {
                print("Please make sure that valid numbers are provided")
            }
        }
        else {
            print("Please make sure the input is in correct format")
        }
    }
    
    return 1
}

while true {
    if performCalculation() == nil {
        break
    }
}

