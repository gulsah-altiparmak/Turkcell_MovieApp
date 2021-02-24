//
//  CollectionViewCell.swift
//  UICollectionInsideUITable
//
//  Created by Gulsah Altiparmak on 19.02.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
  
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
 
}
