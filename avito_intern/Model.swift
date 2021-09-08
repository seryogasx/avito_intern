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
    var employees: [Employee]
}

struct Employee: Codable {
    var name: String
    var phone_number: String
    var skills: [String]
}
