import Foundation

enum UserError: Error {
    case badInformation
}


struct Employee {
    private static var currentId = 1
    
    let id: Int
    let firstName: String
    let middleName: String?
    let lastName: String
    let birthday: Date
    let salary: Double
    
    init(id: Int? = nil, firstName: String, middleName: String?, lastName: String, birthday: Date, salary: Double) {
        if let id = id {
            self.id = id
        }
        else {
            self.id = Employee.currentId
            Employee.currentId += 1
        }
        
        self.firstName = firstName
        self.middleName = middleName
        self.lastName = lastName
        self.birthday = birthday
        self.salary = salary
    }
    
    var fullname: String {
        "\(firstName)\(middleName == nil ? " " : " \(middleName!) ")\(lastName)"
    }
    
    
    var age: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        
        return ageComponents.year!
    }
}

func getUserInfo() -> (firstName: String, middleName: String, lastName: String, birthday: Date, salary: Double)? {
    print("Enter first name of the user: ", terminator: "")
    let firstName = readLine()!
    
    print("Enter middle name of the user, Leave empty if not present: ", terminator: "")
    let middleName = readLine()!
    
    print("Enter last name of the user: ", terminator: "")
    let lastName = readLine()!
    
    print("Enter birthday of the user, The format is dd-mm-yyyy: ", terminator: "")
    let birthdayDate = readLine()!
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd-MM-yyyy" // Set the desired date format
    
    guard let birthdayDate = dateFormatter.date(from: birthdayDate) else { // Replace with the actual birthday string
        // Now you have the birthday date stored in the 'birthdayDate' variable
        print("Unknown birthday date")
        return nil
    }
    
    print("Enter salary of the user: ", terminator: "")
    guard let salary = Double(readLine()!) else {
        print("Something is wrong with salary")
        return nil
    }
    
    return (firstName: firstName, middleName: middleName, lastName: lastName, birthday: birthdayDate, salary: salary)
}


func viewEmployees() {
    if employeeList.isEmpty {
        print("There are no employees currently")
    }
    
    for employee in employeeList {
        print("\n\n\n")
        print("ID: \(employee.id)")
        print("Name: \(employee.fullname)")
        print("Age: \(employee.age)")
        print("Salary: \(employee.salary)")
        print("\n\n\n")
    }
}

func insertEmployee() throws {
    guard let userInfo = getUserInfo() else {
        print("Cancelling operation")
        throw UserError.badInformation
    }
    
    let newEmployee = Employee(firstName: userInfo.firstName, middleName: userInfo.middleName.isEmpty ? nil : userInfo.middleName, lastName: userInfo.lastName, birthday: userInfo.birthday, salary: userInfo.salary)
    
    employeeList.append(newEmployee)
    print("Employee inserted!")
}

func deleteEmployee() {
    print("Enter id of the employee you want to delete: ", terminator: "")
    let employeeId = Int(readLine()!)!
    
    employeeList.removeAll { employee in
        employee.id == employeeId
    }
    
    print("Employee has been removed")
}

func updateEmployee() throws {
    print("Enter id of the user you want to update: ", terminator: "")
    let employeeId = Int(readLine()!)!
    
    guard let userInfo = getUserInfo() else {
        print("Cancelling operation")
        throw UserError.badInformation
    }
    
    employeeList.removeAll { employee in
        employee.id == employeeId
    }
    let updatedEmployee = Employee(id: employeeId, firstName: userInfo.firstName, middleName: userInfo.middleName.isEmpty ? nil : userInfo.middleName, lastName: userInfo.lastName, birthday: userInfo.birthday, salary: userInfo.salary)
    employeeList.append(updatedEmployee)
    
    print("Updated the employee")
}

print("This is employee information center.")
print("Enter 1 to view all employees.")
print("Enter 2 to insert an employee.")
print("Enter 3 to delete an employee.")
print("Enter 4 to update an employee.")
print("Enter 5 to exit")

var employeeList: Array<Employee> = []

while true {
    print("\n\n\n")
    print("Enter command: ", terminator: "")
    guard let command = readLine() else { break }
    
    switch command {
        
    case "1":
        viewEmployees()
        
    case "2":
        guard (try? insertEmployee()) != nil else {continue}
        
    case "3":
        deleteEmployee()
        
    case "4":
        guard (try? updateEmployee()) != nil else {continue}
        
    case "5":
        print("Bye Bye!")
        break
    default:
        print("Unknown command")
    }
}

