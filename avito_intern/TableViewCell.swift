//
//  TableViewCell.swift
//  avito_intern
//
//  Created by Сергей Петров on 07.09.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeePhoneNumberLabel: UILabel!
    @IBOutlet weak var employeeSkillsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(employee: Employee) {
        self.employeeNameLabel.text = employee.name
        self.employeePhoneNumberLabel.text = employee.phone_number
        self.employeeSkillsLabel.text = employee.skills.sorted { $0.lowercased() < $1.lowercased() } .joined(separator: ", ")
    }
}
