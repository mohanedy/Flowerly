//
//  DetailsViewController.swift
//  Flowerly
//
//  Created by Mohaned Yossry on 5/2/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import SDWebImage
import ChameleonFramework
class DetailsViewController: UIViewController {
    
    @IBOutlet weak var flowerImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    var flower:Flower?
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let safeFlower = flower{
            nameLabel.text = safeFlower.name.capitalized
            descLabel.text = safeFlower.description
            flowerImage.sd_setImage(with: URL(string: safeFlower.imgURL), placeholderImage: UIImage(named: "background.png"),completed:{
                (image, error, cacheType,imgUrl)in
                let avgImageColor =   UIColor(averageColorFrom: image!)
                DispatchQueue.main.async {
                    self.colorView.backgroundColor = avgImageColor
                    self.backButton.tintColor = UIColor(contrastingBlackOrWhiteColorOn: avgImageColor, isFlat: true)
                }
                
            })
            
            
        }
        
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
