//
//  MemeDetailViewController.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 12/21/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController : UIViewController {
  
  @IBOutlet weak var memeImageView: UIImageView!
  var memeImage : UIImage? = nil
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  override func viewDidLoad() {
    //print("viewDidLoad: imageView is \(self.imageView)")
    memeImageView.image =  memeImage
  }
}