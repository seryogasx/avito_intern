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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var skills: [String] = []
    var collectionViewCellIdentifier: String = "CollectionViewCell"
    let textHeight: CGFloat = 22.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        self.collectionView.alwaysBounceVertical = false
        let layout = GridLayout()
        layout.delegate = self
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: collectionViewCellIdentifier, bundle: nil), forCellWithReuseIdentifier: collectionViewCellIdentifier)
    }
    
    func setup(employee: Employee) {
        self.employeeNameLabel.text = "Name: \(employee.name)"
        self.employeePhoneNumberLabel.text = "Phone number: \(employee.phone_number)"
        self.skills = employee.skills.sorted { $0.lowercased() < $1.lowercased() }
        self.collectionView.reloadData()
    }
}

extension TableViewCell: UICollectionViewDelegate {
    
}

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as? CollectionViewCell else {
            print("Return default cell!")
            return UICollectionViewCell()
        }
        cell.setup(title: skills[indexPath.row])
        return cell
    }
}

extension TableViewCell: GridLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, widthForContentAtIndexPath indexPath: IndexPath) -> CGFloat {
        let text = skills[indexPath.row]
        let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.textHeight)
        let calculatedSize = (text as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.textHeight)], context: nil)
        return max(calculatedSize.width, 50)
    }
}
