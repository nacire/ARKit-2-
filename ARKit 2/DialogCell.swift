//
//  DialogCell.swift
//  ARKit 2
//
//  Created by nacire on 9/27/18.
//  Copyright © 2018 nacire. All rights reserved.
//

import UIKit

class DialogCell: UICollectionViewCell {
    
    var delegate: DialogCollectionViewCellDelegate?
    var index = 0
    
    @IBOutlet var screenButton: UIButton!
    @IBOutlet var screenLabel: UILabel!
    @IBAction func screenImageButton(_ sender: Any) {
        
        delegate?.screenImageButton(index: index)
    }
}

protocol DialogCollectionViewCellDelegate {
    
    func screenImageButton(index: Int)
}
