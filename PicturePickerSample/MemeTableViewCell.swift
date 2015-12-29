//
//  MemeTableViewCell.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 11/11/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memeImageView: UIImageView!
  @IBOutlet weak var memeTopText: UILabel!
  @IBOutlet weak var memeBottomText: UILabel!
    
    //@IBOutlet weak var schemeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
