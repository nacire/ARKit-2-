//
//  Dialog.swift
//  ARKit 2
//
//  Created by nacire on 9/27/18.
//  Copyright © 2018 nacire. All rights reserved.
//

import UIKit

class Dialog: UIViewController {

    var delegate: DialogDelegate?
    
    let images = ["Screen1", "Screen2", "Screen3"]
    let titles = ["iPhone 1", "iPhone 2", "iPhone 3"]
    let screens = ["iPhone-x1", "iPhone-x2", "iPhone-x3"]
    @IBOutlet var screenCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        screenCollectionView.delegate = self
        screenCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

   

}

extension Dialog: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screen", for: indexPath) as! DialogCell
        
        cell.screenButton.setImage(UIImage(named: screens[indexPath.row]), for: .normal)
        cell.screenLabel.text = titles[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
    }
    
    
}

extension Dialog: DialogCollectionViewCellDelegate {
    func screenImageButton(index: Int) {
        
        dismiss(animated: true, completion: nil)
        delegate?.screenImageButton(image: UIImage(named: images[index])!)
        
    }
    
    
}


protocol DialogDelegate {
    
    func screenImageButton(image: UIImage)
}
