//
//  CollectionViewCell.swift
//  avito_intern
//
//  Created by Сергей Петров on 10.09.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(title: String) {
        self.titleButton.setTitle(title, for: .normal)
        self.titleButton.setLayer()
    }
}


extension UIButton {
    func setLayer() {
        UIGraphicsBeginImageContext(layer.frame.size)

        let recPath = UIBezierPath(roundedRect: frame, byRoundingCorners: [.topLeft, .bottomRight, .topRight, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1).setFill()
        recPath.fill()
        let imageBuffer = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        layer.contents = imageBuffer?.cgImage
        titleEdgeInsets = UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)
    }
}
