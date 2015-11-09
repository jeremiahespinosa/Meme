//
//  MemeFieldsDelegate.swift
//  PicturePickerSample
//
//  Created by jeremiah espinosa on 11/9/15.
//  Copyright © 2015 Jeremiah Espinosa. All rights reserved.
//

import UIKit

class MemeFieldsDelegate:  NSObject, UITextFieldDelegate{
    
    var topTextField : UITextField!  = nil
    var bottomTextField : UITextField!  = nil
//    var activeTextField : UITextField?  = nil
    
    init(topField : UITextField, bottomField: UITextField) {
        super.init()
        self.topTextField = topField
        self.bottomTextField = bottomField
        topTextField.delegate = self
        bottomTextField.delegate = self
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let newString = textField.text!.uppercaseString
        
        textField.text = newString
        
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //clear out the text field
        if topTextField == textField {
            topTextField.text = ""
        }
        else {
            bottomTextField.text = ""
        }
    }
}
    