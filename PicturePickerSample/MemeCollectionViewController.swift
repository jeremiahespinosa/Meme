//
//  MemeCollectionViewController.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 11/9/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

  @IBOutlet var collectionView: UICollectionView!
  
  /*
  * used to access 
  */
  var memes: [Meme] {
      return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
  
  override func viewDidLoad() {
    //In tab bar controllers, ViewDidLoad only fires once, when we first load the view controller
    super.viewDidLoad()
    
  }
  
  override func viewDidAppear(animated: Bool) {
    if memes.count < 1{
      showCreateMemeController()
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    self.collectionView.reloadData()
  }
  
  @IBAction func addButtonPressed(sender: UIBarButtonItem) {
    showCreateMemeController()
  }
  
  func showCreateMemeController(){
    let createMemeVC = self.storyboard?.instantiateViewControllerWithIdentifier("CreateMemeViewController") as! CreateMemeViewController
    
    self.presentViewController(createMemeVC, animated: true, completion: nil)
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomCollectionMemeCell", forIndexPath: indexPath) as! MemeCollectionViewCell
      
      let meme = memes[indexPath.item]

      cell.memeImageView.image = meme.memedImage
    
      //cell.backgroundColor = UIColor.blackColor()
    
      return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let meme = memes[indexPath.row]
    
    let memeDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    
    memeDetailVC.memeImage = meme.memedImage
    
    let backItem = UIBarButtonItem()
    backItem.title = "Sent Memes"
    navigationItem.backBarButtonItem = backItem
    
    self.navigationController?.pushViewController(memeDetailVC, animated: true)
    
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("returning memes count \(memes.count)")
    return memes.count
  }
  
  func collectionView(collectionView: UICollectionView,
          layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
  {
    return CGSize(width: collectionView.frame.size.width/3, height: 150)
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

}
