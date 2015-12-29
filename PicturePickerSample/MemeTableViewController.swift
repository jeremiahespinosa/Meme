//
//  MemeTableViewController.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 11/9/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import UIKit

//class MemeTableViewController : UITableViewController{
class MemeTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate{

  @IBOutlet weak var tableView: CustomTableView!
  
  /*
  * used to access object
  */
  var memes: [Meme] {
      return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }
  
  override func viewDidLoad() {
    //In tab bar controllers, ViewDidLoad only fires once, when we first load the view controller
    super.viewDidLoad()
    
    setUpContent();
  }
  
  override func viewWillAppear(animated: Bool) {
    self.tableView.reloadData()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setUpContent(){
    //tableView.showEmptyView()
  }

  @IBAction func addButtonPressed(sender: UIBarButtonItem) {
    let createMemeVC = self.storyboard?.instantiateViewControllerWithIdentifier("CreateMemeViewController") as! CreateMemeViewController
    
    self.presentViewController(createMemeVC, animated: true, completion: nil)
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      print("returning memes count \(memes.count)")
      return memes.count
  }
    
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      
      print("creating cell")
    
      let cell = tableView.dequeueReusableCellWithIdentifier("CustomMemeTableCell") as! MemeTableViewCell
    
      let meme = memes[indexPath.item]
      
      cell.memeImageView.image = meme.memedImage
//      cell.memeImageView.contentMode = .ScaleAspectFit
    
      // Set the name and image
      cell.memeTopText.text = meme.topText as NSString as String
      cell.memeBottomText.text = meme.bottomText as NSString as String
    
      return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let meme = memes[indexPath.row]
    
    let memeDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
    
    memeDetailVC.memeImage = meme.memedImage
    
    let backItem = UIBarButtonItem()
    backItem.title = "Sent Memes"
    navigationItem.backBarButtonItem = backItem
    
    self.navigationController?.pushViewController(memeDetailVC, animated: true)
      
  }
}
