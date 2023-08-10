enum Condition {
    case new
    case littleUsed(years: Int)
    case old
    case poor
}


struct Car {
    let company: String
    let name: String
    let weight: Double
    let topSpeed: Double
    let originalPrice: Double
    let wheel: Int
    let capacity: Int
    let isLuggageAvailable: Bool
    let isFamilyCar: Bool
    var condition: Condition = .new

    
    init(company: String, name: String, weight: Double, topSpeed: Double, price: Double, wheel: Int, capacity: Int, isLuggageAvailable: Bool = false) {
        precondition(wheel > 0, "Wheel count must be greater than 0")
        precondition(capacity > 0, "Capacity must be greater than 0")
        precondition(!company.isEmpty, "Company cannot be empty")
        precondition(!name.isEmpty, "Name cannot be empty")
        
        self.company = company
        self.name = name
        self.weight = weight
        self.topSpeed = topSpeed
        self.originalPrice = price
        self.wheel = wheel
        self.capacity = capacity
        self.isLuggageAvailable = isLuggageAvailable
        self.condition = .new
        
        if (wheel >= 4 && isLuggageAvailable) {
            self.isFamilyCar = true
        }
        else {
            self.isFamilyCar = false
        }
    }
    
    init(company: String) {
        self.init(company: company, name: "Anon", weight: 1000, topSpeed: 100, price: 0.0, wheel: 4, capacity: 5)
    }
    
    var price: Double {
        originalPrice - (originalPrice * depreciatedPercentage)
    }
    
    var depreciatedPercentage: Double {
        switch condition {
        case .new:
            return 0.0
        case .littleUsed:
            return 0.2
        case .old:
            return 0.6
        case .poor:
            return 0.95
        }
    }
}


var corolla = Car(company: "Toyota", name: "Corolla", weight: 1160, topSpeed: 150.0, price: 7_442_000.0, wheel: 4, capacity: 5, isLuggageAvailable: true)
let genericCar = Car(company: "Tesla")

print(genericCar)
print(corolla.isFamilyCar)
print(corolla.price)

corolla.condition = .poor
print(corolla.price)
