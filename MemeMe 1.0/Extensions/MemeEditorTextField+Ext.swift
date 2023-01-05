//
//  MemeEditorTextField+Ext.swift
//  MemeMe 1.0
//
//  Created by Golden Chimusinde on 2023/01/05.
//

import Foundation
import UIKit

extension MemeEditorViewController {

    // MARK: TextFields
    func setUpTextField(textField: UITextField, text: String) {
        let memeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth : -4.0] as? [NSAttributedString.Key  : Any
            ]
        
        textField.delegate = self
        textField.text = text
        textField.defaultTextAttributes = memeTextAttributes!
        textField.textAlignment = .center
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM"{
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
