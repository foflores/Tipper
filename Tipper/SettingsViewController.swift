//  SettingsViewController.swift
//  Tipper
//
//  Created by Favian Flores on 2/1/21.

import UIKit

class SettingsViewController: UIViewController {

	// Outlets
    @IBOutlet weak var tipControllerLeft: UITextField!
    @IBOutlet weak var tipControllerMiddle: UITextField!
    @IBOutlet weak var tipControllerRight: UITextField!
	@IBOutlet weak var sampleTipController: UISegmentedControl!
	
	let defaults = UserDefaults.standard
	
	// View Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        tipControllerLeft.becomeFirstResponder()
    }
	
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		saveTipControllerValues()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		sampleTipController.setTitle(String(defaults.integer(forKey: "tipControllerLeft")) + "%", forSegmentAt: 0)
		sampleTipController.setTitle(String(defaults.integer(forKey: "tipControllerMiddle")) + "%", forSegmentAt: 1)
		sampleTipController.setTitle(String(defaults.integer(forKey: "tipControllerRight")) + "%", forSegmentAt: 2)
		sampleTipController.selectedSegmentIndex = defaults.integer(forKey: "tipControllerChoice")
	}
	
	// Functions
	func saveTipControllerValues() {
		if tipControllerLeft.text! != "" {
			defaults.set(Double(tipControllerLeft.text!), forKey: "tipControllerLeft")
		}
		if tipControllerMiddle.text! != "" {
			defaults.set(Double(tipControllerMiddle.text!), forKey: "tipControllerMiddle")
		}
		if tipControllerRight.text! != "" {
			defaults.set(Double(tipControllerRight.text!), forKey: "tipControllerRight")
		}
		defaults.set(Int(sampleTipController.selectedSegmentIndex), forKey: "tipControllerChoice")
	}
	
	@IBAction func updateSampleTipController(_ sender: Any) {
		var left : String, middle : String, right : String
		if tipControllerLeft.text! == "" {
			left = defaults.string(forKey: "tipControllerLeft")! + "%"
		}
		else {
			left = tipControllerLeft.text! + "%"
		}
		if tipControllerMiddle.text! == "" {
			middle = defaults.string(forKey: "tipControllerMiddle")! + "%"
		}
		else {
			middle = tipControllerMiddle.text! + "%"
		}
		if tipControllerRight.text! == "" {
			right = defaults.string(forKey: "tipControllerRight")! + "%"
		}
		else {
			right = tipControllerRight.text! + "%"
		}
		sampleTipController.setTitle(left, forSegmentAt: 0)
		sampleTipController.setTitle(middle, forSegmentAt: 1)
		sampleTipController.setTitle(right, forSegmentAt: 2)
	}
	
	
}
