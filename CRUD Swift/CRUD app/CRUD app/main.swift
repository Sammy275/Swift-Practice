import Foundation
import CoreData

enum EmployeeError: Error {
    case badInformation
}

var container = NSPersistentContainer(name: "MainModel")
container.loadPersistentStores { storeDescription, error in
    if let error = error {
        fatalError("Fatal Error loading store: \(error.localizedDescription)")
    }
}

let viewContext = container.viewContext

func getUserInfo() -> (id: Int, firstName: String, middleName: String, lastName: String, birthday: Date, salary: Double)? {
    print("Enter id of the user: ", terminator: "")
    let employeeId = Int(readLine()!)!
    
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
    
    return (id: employeeId, firstName: firstName, middleName: middleName, lastName: lastName, birthday: birthdayDate, salary: salary)
}


func viewEmployees() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
    
    var employeeList: [Employee] = []
    do {
        employeeList = try viewContext.fetch(fetchRequest) as! [Employee]
    }
    catch {
        print("Could not fetch an employee")
    }
    
    if employeeList.isEmpty {
        print("There are no employees currently")
        return
    }
    
    for employee in employeeList {
        print("\n\n\n")
        print("ID: \(employee.id)")
        print("Name: \(employee.fullname)")
        print("Age: \(employee.age)")
        print("Salary: \(employee.salary)")
        print("\n")
    }
}

func checkEmployeeRecurring(id: Int) -> Bool {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
    
    var employeeList: [Employee] = []
    do {
        employeeList = try viewContext.fetch(fetchRequest) as! [Employee]
    }
    catch {
        print("Could not fetch an employee")
    }
    
    if employeeList.isEmpty {
        return false
    }
    
    for employee in employeeList {
        if employee.id == id {
            return true
        }
    }
    
    return false
}

func insertEmployee() throws {
    guard let userInfo = getUserInfo() else {
        print("Cancelling operation")
        throw EmployeeError.badInformation
    }
    
    let isEmployeeRecurring = checkEmployeeRecurring(id: userInfo.id)
    
    if isEmployeeRecurring == false {
        let newEmployee = Employee(context: viewContext)
        newEmployee.id = Int16(userInfo.id)
        newEmployee.firstName = userInfo.firstName
        newEmployee.middleName = userInfo.middleName.isEmpty ? nil : userInfo.middleName
        newEmployee.lastName = userInfo.lastName
        newEmployee.birthday = userInfo.birthday
        newEmployee.salary = userInfo.salary
        
        
        
        do {
            try viewContext.save()
        }
        catch {
            print("Could not save the Employee")
        }
        
        print("Employee inserted!")
    }
    else {
        print("The employee with same id already exists")
        print("Could not add the Employee")
    }
    
}

func deleteEmployee() {
    print("Enter id of the employee you want to delete: ", terminator: "")
    let employeeId = Int(readLine()!)!
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
    fetchRequest.predicate = NSPredicate(format: "id == %d", employeeId)
    
    do {
        let results = try viewContext.fetch(fetchRequest) as! [Employee]
        if let employeeToDelete = results.first {
            viewContext.delete(employeeToDelete)
        }
    }
    catch {
        print("Error fetching data")
    }
    
    do {
        try viewContext.save()
    }
    catch {
        print("Could not delete the Employee")
    }
    
    print("Employee has been removed")
}


func deleteAllEmployee() {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
    
    do {
        let results = try viewContext.fetch(fetchRequest) as! [Employee]
        
        for employee in results {
            viewContext.delete(employee)
        }
    }
    catch {
        print("Error fetching data")
    }
    
    do {
        try viewContext.save()
    }
    catch {
        print("Could not delete the Employee")
    }
    
    print("Employee has been removed")
}


func updateEmployee() throws {
    print("Enter id of the user you want to update: ", terminator: "")
    let employeeId = Int(readLine()!)!
    
    guard let userInfo = getUserInfo() else {
        print("Cancelling operation")
        throw EmployeeError.badInformation
    }
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
    fetchRequest.predicate = NSPredicate(format: "id == %d", employeeId)
    
    do {
        let results = try viewContext.fetch(fetchRequest) as! [Employee]
        if let employeeToUpdate = results.first {
            employeeToUpdate.firstName = userInfo.firstName
            employeeToUpdate.middleName = userInfo.middleName.isEmpty ? nil : userInfo.middleName
            employeeToUpdate.lastName = userInfo.lastName
            employeeToUpdate.birthday = userInfo.birthday
            employeeToUpdate.salary = userInfo.salary
        }
    }
    catch {
        print("Error fetching data")
    }
    
    do {
        try viewContext.save()
    }
    catch {
        print("Could not Update the Employee")
    }
    
    print("Updated the employee")
}

print("This is employee information center.")
print("Enter 1 to view all employees.")
print("Enter 2 to insert an employee.")
print("Enter 3 to delete an employee.")
print("Enter 4 to update an employee.")
print("Enter 5 to exit")


infiniteLoop: while true {
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
        break infiniteLoop
    default:
        print("Unknown command")
    }
}

//deleteAllEmployee()
