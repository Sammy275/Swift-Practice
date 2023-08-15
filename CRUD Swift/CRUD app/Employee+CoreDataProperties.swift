//
//  Employee+CoreDataProperties.swift
//  CRUD app
//
//  Created by Saim on 15/08/2023.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var id: Int16
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var middleName: String?
    @NSManaged public var birthday: Date?
    @NSManaged public var salary: Double

}

extension Employee : Identifiable {

}


extension Employee {
    var fullname: String {
        "\(firstName!)\(middleName == nil ? " " : " \(middleName!) ")\(lastName!)"
    }
    
    
    var age: Int {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday!, to: Date())
        
        return ageComponents.year!
    }
}
