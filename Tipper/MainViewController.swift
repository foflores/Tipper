//  MainViewController.swift
//  Tipper
//
//  Created by Favian Flores on 1/30/21.

import UIKit

class MainViewController: UIViewController {
    
	// Outlets
    @IBOutlet weak var billAmountTextField: UITextField!
	@IBOutlet weak var numberOfPeopleTextField: UITextField!
	@IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
	@IBOutlet weak var tipController: UISegmentedControl!
	
	// Global
	let defaults = UserDefaults.standard
	
	// User Inputs
	@IBAction func textFieldInput(_ sender: Any) {
		calculateTip()
	}
	
	@IBAction func segmentedControlInput(_ sender: Any) {
		calculateTip()
	}
	 
	// View Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(setSaveTimer), name: UIApplication.willResignActiveNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(restoreBillAmount), name: UIApplication.willEnterForegroundNotification, object: nil)
		restoreBillAmount()
		setTipControllerDefaults()
		billAmountTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		billAmountTextField.becomeFirstResponder()
        updateTipControllerValues()
        calculateTip()
    }
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	// Functions
	func setTipControllerDefaults() {
		if defaults.value(forKey: "tipControllerLeft") == nil {
			defaults.set(15, forKey: "tipControllerLeft")
		}
		if defaults.value(forKey: "tipControllerMiddle") == nil {
			defaults.set(18, forKey: "tipControllerMiddle")
		}
		if defaults.value(forKey: "tipControllerRight") == nil {
			defaults.set(20, forKey: "tipControllerRight")
		}
		if defaults.value(forKey: "tipControllerChoice") == nil {
			defaults.set(1, forKey: "tipControllerChoice")
		}
	}
	
	func updateTipControllerValues() {
		tipController.setTitle(String(defaults.integer(forKey: "tipControllerLeft")) + "%", forSegmentAt: 0)
		tipController.setTitle(String(defaults.integer(forKey: "tipControllerMiddle")) + "%", forSegmentAt: 1)
		tipController.setTitle(String(defaults.integer(forKey: "tipControllerRight")) + "%", forSegmentAt: 2)
		tipController.selectedSegmentIndex = defaults.integer(forKey: "tipControllerChoice")
	}

	func calculateTip() {
		let left = defaults.integer(forKey: "tipControllerLeft")
		let mid = defaults.integer(forKey: "tipControllerMiddle")
		let right = defaults.integer(forKey: "tipControllerRight")
		let tipPercentages = [left, mid, right]
		
		let people = Double(numberOfPeopleTextField.text!) ?? 1.0
		let bill = (Double(billAmountTextField.text!) ?? 0.0)/people
		let tip = (bill * Double(tipPercentages[tipController.selectedSegmentIndex]) * 0.01)
		let total = bill + tip
		
		tipAmountLabel.text = String(format: "$%.2f", tip)
		totalLabel.text = String(format: "$%.2f", total)
		
		defaults.set(Double(billAmountTextField.text!), forKey: "billAmount")
		defaults.set(Int(numberOfPeopleTextField.text!), forKey: "numberOfPeople")
		defaults.set(Int(tipController.selectedSegmentIndex), forKey: "tipControllerIndex")
	}

	@objc func restoreBillAmount() {
		let date = Date()
		if (defaults.value(forKey: "deleteBillAmountBy") != nil && date > defaults.value(forKey: "deleteBillAmountBy") as! Date) {
			defaults.set("", forKey: "billAmount")
			defaults.set("", forKey: "numberOfPeople")
		}
		billAmountTextField.text = defaults.string(forKey: "billAmount")
		numberOfPeopleTextField.text = defaults.string(forKey: "numberOfPeople")
	}
	
	@objc func setSaveTimer() {
		defaults.set(Date(timeInterval: 600, since: Date()), forKey: "deleteBillAmountBy")
	}
}
