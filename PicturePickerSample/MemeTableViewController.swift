//
//  MemeTableViewController.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 11/9/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import UIKit

class MemeTableViewController : UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        
    }
}
