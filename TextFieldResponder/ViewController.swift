//
//  ViewController.swift
//  TextFieldResponder
//
//  Created by Sierra 2 on 13/10/17.
//  Copyright © 2017 SandsHellCreations. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TFResponder.shared.addResponders(textFields)
    }
}

class TFResponder: NSObject, UITextFieldDelegate {
    
    static let shared = TFResponder()
    
    var textFields: [UITextField]?
    
    func addResponders(_ TextFieldArray: [UITextField]) {
        textFields = TextFieldArray
        textFields?.forEach({ $0.returnKeyType = .next //setting return key type for all textFields
                            $0.delegate = TFResponder.shared }) //setting delegates for all textFields
        textFields?.last?.returnKeyType = .done  //Last index
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Magic code if textfield is last then resign else becomeFirstResponder to next TextField
        var selectedIndex = 0
        for index in 0..<(textFields?.count ?? 0) {
            if textField == textFields?[index] ?? UITextField() {
                selectedIndex = index
            }
        }
        _ = (textField == textFields?.last) ? textField.resignFirstResponder() : textFields?[selectedIndex + 1].becomeFirstResponder()
        return true
    }
}

