//
//  ViewController.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 9/26/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    
  @IBOutlet weak var navigationBar: UINavigationBar!
    //@IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    var mainScreenSize : CGSize = UIScreen.mainScreen().bounds.size // Getting main screen size
    
    var memeFieldsDelegate : MemeFieldsDelegate? = nil
  
  var memes: [Meme] {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
  }

    override func viewDidLoad() {
        super.viewDidLoad()
      
      applyTextFieldAttributes(topTextField)
      applyTextFieldAttributes(bottomTextField)

        disableAndHideFields()
        
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        
        memeFieldsDelegate = MemeFieldsDelegate(topField: topTextField, bottomField: bottomTextField)
      
      if memes.count < 1{
         cancelButton.enabled = false
      }else {
        cancelButton.enabled = true
      }
      
    }
  
  func applyTextFieldAttributes(textField: UITextField){
    let memeTextAttributes = [
      NSStrokeColorAttributeName : UIColor.blackColor(),
      NSForegroundColorAttributeName :  UIColor.whiteColor(),
      NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
      NSStrokeWidthAttributeName : -7.0
    ]
    textField.defaultTextAttributes     = memeTextAttributes
    textField.textAlignment             = NSTextAlignment.Center
    textField.autocapitalizationType    = UITextAutocapitalizationType.AllCharacters
  }
  
    override func viewWillAppear(animated: Bool) {
        subscribeToKeyboardNotifications()
        subscribeToKeyboardWillHideNotification()
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
        unsubscribeFromKeyboardWillHideNotification()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder(){
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        if view.frame.origin.y != 0 {
            //view.frame.origin.y += getKeyboardHeight(notification)
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardWillHideNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardWillHideNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIKeyboardWillShowNotification, object: nil)
    }

    func save() {
        //create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text! , originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        //add meme to memes array on Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        navigationBar?.hidden = true
        bottomToolBar?.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        
        let memedImage : UIImage =
        
        UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        navigationBar?.hidden = false
        navigationBar?.hidden = false
        
        return memedImage
    }
    
    @IBAction func pickAnImage(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pictureFromCamera(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        else{
            print("camera not available")
        }

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        if let image = image as? UIImage {
            imagePickerView.contentMode  = UIViewContentMode.ScaleAspectFit
            imagePickerView.image = image
            topTextField.hidden = false
            bottomTextField.hidden = false
            shareButton.enabled = true
        }
    
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //user canceled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButtonClicked(sender: UIBarButtonItem) {
        
        //step 1 generate a memed image
        let saveImage = generateMemedImage()
        
        //step 2 define an instance of the ActivityViewController
        
        //step 3 pass the ActivityViewController a memedImage as an activity item
        let sharedVC = UIActivityViewController(activityItems: [saveImage], applicationActivities: nil)
        
        sharedVC.completionWithItemsHandler = {
            (s: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        //step 4 present the ActivityViewController
        presentViewController(sharedVC, animated: true, completion: nil)
    }
    
    func disableAndHideFields(){
        imagePickerView.image = nil
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.hidden = true
        bottomTextField.hidden = true
        
//        cancelButton.enabled = false
        shareButton.enabled = false
    }
    
    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        
        disableAndHideFields()
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
//        picker.dismissViewControllerAnimated(true, completion: nil)
//        
//        let imageObj:UIImage! = info[UIImagePickerControllerOriginalImage] as? UIImage
//
//        imagePickerView.image = imageResize(imageObj , sizeChange: mainScreenSize)
//        
      topTextField.hidden = false
      bottomTextField.hidden = false
      
      shareButton.enabled = true
      if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
        self.imagePickerView.contentMode  = UIViewContentMode.ScaleAspectFit
        self.imagePickerView.image        = image
      }
      picker.dismissViewControllerAnimated(true, completion: nil)
    }
  
    func imageResize (imageObj:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
}

