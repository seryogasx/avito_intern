//
//  Model.swift
//  avito_intern
//
//  Created by Сергей Петров on 07.09.2021.
//

import Foundation

struct AvitoData: Codable {
    var company: Company
}

struct Company: Codable {
    var name: String
    var employees: [Employee] {
        didSet {
            employees.sort()
        }
    }
}

// MARK: Don't sort by name!
struct Employee: Codable, Comparable {
    var name: String
    var phone_number: String
    var skills: [String] {
        didSet {
            skills.sort()
        }
    }
    
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name < rhs.name
    }
}
