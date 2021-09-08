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
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setup(employee: Employee) {
        self.employeeNameLabel.text = employee.name
        self.employeePhoneNumberLabel.text = employee.phone_number
        self.employeeSkillsLabel.text = employee.skills.sorted().joined(separator: ", ")
    }
}
