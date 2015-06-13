//
//  ClosetCell.swift
//  CoRee
//
//  Created by 佐藤一輝 on 2015/06/13.
//  Copyright (c) 2015年 validtationError. All rights reserved.
//

import UIKit

class ClosetCell: UITableViewCell {
    @IBOutlet var cloth_title: UILabel!
    @IBOutlet var cloth_image: UIImageView!
    
    var clothImageName = ["tops.jpg", "jacket.jpg", "pants.jpg","shoes.jpg","hat.jpg"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool){
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(title:String,cellIndex:Int) {
        self.cloth_title.text = title
        self.cloth_image.image = UIImage(named: clothImageName[cellIndex])
    }
}
