//
//  LoadingTableViewEmptyView.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 12/21/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import UIKit

class LoadingTableViewEmptyView: UIView {
  
  @IBOutlet weak var emptyImageView: UIImageView!
  @IBOutlet weak var emptyTextLabel: UILabel!
  @IBOutlet weak var view: UIView!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    setupView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  func setupView() {
    NSBundle.mainBundle().loadNibNamed("LoadingTableViewEmptyView", owner: self, options: nil)
    view.frame = self.frame
    addSubview(view)
  }
}
