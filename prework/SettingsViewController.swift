//
//  SettingsViewController.swift
//  prework
//
//  Created by Favian Flores on 2/1/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var TipControllerLeft: UITextField!
    @IBOutlet weak var TipControllerMid: UITextField!
    @IBOutlet weak var TipControllerRight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TipControllerLeft.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = UserDefaults.standard
        if TipControllerLeft.text! != "" {
            defaults.set(Double(TipControllerLeft.text!), forKey: "left")
        }
        if TipControllerMid.text! != "" {
            defaults.set(Double(TipControllerMid.text!), forKey: "mid")
        }
        if TipControllerRight.text! != "" {
            defaults.set(Double(TipControllerRight.text!), forKey: "right")
        }
    }
}
