//
//  CustomTableView.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 12/21/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
  
  let loadingImage = UIImage(named: "Warning")
  var loadingImageView: UIImageView
  
  var emptyView: LoadingTableViewEmptyView = LoadingTableViewEmptyView()
  
  required init(coder aDecoder: NSCoder) {
    loadingImageView = UIImageView(image: loadingImage)
    super.init(coder: aDecoder)!
    //addSubview(loadingImageView)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    emptyView = LoadingTableViewEmptyView(frame: frame)
    emptyView.hidden = true
    addSubview(emptyView)
  }
  
  override func reloadData() {
    super.reloadData()
    self.bringSubviewToFront(loadingImageView)
  }
  
  // MARK: empty view methods
  func showEmptyView() {
    emptyView.hidden = false
    
    self.bringSubviewToFront(emptyView)
  }
  
  func hideEmptyView() {
    emptyView.hidden = true
    self.sendSubviewToBack(emptyView)
  }
  
  // MARK: private methods
  // Adjust the size so that the indicator and the empty view is always in the middle of the screen
  override func layoutSubviews() {
    super.layoutSubviews()
    emptyView.frame = frame
  }
}