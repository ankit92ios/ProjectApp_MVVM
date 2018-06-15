//
//  ProjectAppCell.swift
//  ProjectApp
//
//  Created by Ankit on 6/1/18.
//  Copyright © 2018 Ankit. All rights reserved.
//

import UIKit

class ProjectAppCell: UITableViewCell {

    @IBOutlet weak var lblSno: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    
    @IBOutlet weak var imgProf: UIImageView!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.showbackview()
    }
    
    func showbackview(){
        imgProf.layer.cornerRadius = imgProf.frame.height/2
        imgProf.layer.masksToBounds = true
        backView.layer.borderColor = UIColor.lightGray.cgColor
        backView.layer.borderWidth = 1.0
        backView.layer.shadowColor = UIColor.lightGray.cgColor
        backView.layer.shadowOpacity = 1.0
        backView.layer.shadowOffset = CGSize(width:1, height:1)
        backView.layer.shadowRadius = 1
        backView.layer.borderColor = UIColor.lightGray.cgColor
        backView.layer.borderWidth = 0.1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
