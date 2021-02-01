//
//  ViewController.swift
//  prework
//
//  Created by Favian Flores on 1/30/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "left") == nil {
            defaults.set(15, forKey: "left")
        }
        if defaults.value(forKey: "mid") == nil {
            defaults.set(18, forKey: "mid")
        }
        if defaults.value(forKey: "right") == nil {
            defaults.set(20, forKey: "right")
        }
    }

    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0.0
        let defaults = UserDefaults.standard
        let left = defaults.integer(forKey: "left")
        let mid = defaults.integer(forKey: "mid")
        let right = defaults.integer(forKey: "right")
        let tipPercentages = [left, mid, right]
        let tip = bill * Double(tipPercentages[tipControl.selectedSegmentIndex]) * 0.01
        let total = bill + tip
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let bill = Double(billAmountTextField.text!) ?? 0.0
        let defaults = UserDefaults.standard
        let left = defaults.integer(forKey: "left")
        let mid = defaults.integer(forKey: "mid")
        let right = defaults.integer(forKey: "right")
        tipControl.setTitle(String(left) + "%", forSegmentAt: 0)
        tipControl.setTitle(String(mid) + "%", forSegmentAt: 1)
        tipControl.setTitle(String(right) + "%", forSegmentAt: 2)
        let tipPercentages = [left, mid, right]
        let tip = bill * Double(tipPercentages[tipControl.selectedSegmentIndex]) * 0.01
        let total = bill + tip
        
        tipAmountLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

