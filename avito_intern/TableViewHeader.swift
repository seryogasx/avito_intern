//
//  TableViewHeader.swift
//  avito_intern
//
//  Created by Сергей Петров on 08.09.2021.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(title: String) {
        self.titleLabel.text = title
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
