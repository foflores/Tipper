//  SettingsViewController.swift
//  Tipper
//
//  Created by Favian Flores on 2/1/21.

import UIKit

class SettingsViewController: UIViewController {
	let defaults = UserDefaults.standard

	@IBOutlet weak var defaultTip0TextField: UITextField!
	@IBOutlet weak var defaultTip1TextField: UITextField!
	@IBOutlet weak var defaultTip2TextField: UITextField!
	@IBOutlet weak var defaultTipSegCtrl: UISegmentedControl!

	@IBAction func updateDefaultTipSegCtrl(_ sender: Any) {
		var left: String, middle: String, right: String
		if defaultTip0TextField.text! == "" {
			left = defaults.string(forKey: "defaultTip0TextField")! + "%"
		} else {
			left = defaultTip0TextField.text! + "%"
		}
		if defaultTip1TextField.text! == "" {
			middle = defaults.string(forKey: "defaultTip1TextField")! + "%"
		} else {
			middle = defaultTip1TextField.text! + "%"
		}
		if defaultTip2TextField.text! == "" {
			right = defaults.string(forKey: "defaultTip2TextField")! + "%"
		} else {
			right = defaultTip2TextField.text! + "%"
		}
		defaultTipSegCtrl.setTitle(left, forSegmentAt: 0)
		defaultTipSegCtrl.setTitle(middle, forSegmentAt: 1)
		defaultTipSegCtrl.setTitle(right, forSegmentAt: 2)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		defaultTipSegCtrl.setTitle(
			String(defaults.integer(forKey: "defaultTip0TextField")) + "%",
			forSegmentAt: 0
		)
		defaultTipSegCtrl.setTitle(
			String(defaults.integer(forKey: "defaultTip1TextField")) + "%",
			forSegmentAt: 1
		)
		defaultTipSegCtrl.setTitle(
			String(defaults.integer(forKey: "defaultTip2TextField")) + "%",
			forSegmentAt: 2
		)
		defaultTipSegCtrl.selectedSegmentIndex = defaults.integer(forKey: "tipChoiceSegCtrlDefault")
		defaultTip0TextField.becomeFirstResponder()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		saveSettings()
	}

	func saveSettings() {
		if defaultTip0TextField.text! != "" {
			defaults.set(Double(defaultTip0TextField.text!), forKey: "defaultTip0TextField")
		}
		if defaultTip1TextField.text! != "" {
			defaults.set(Double(defaultTip1TextField.text!), forKey: "defaultTip1TextField")
		}
		if defaultTip2TextField.text! != "" {
			defaults.set(Double(defaultTip2TextField.text!), forKey: "defaultTip2TextField")
		}
		let index = defaultTipSegCtrl.selectedSegmentIndex
		if index != defaults.integer(forKey: "tipChoiceSegCtrlDefault") {
			defaults.set(Int(defaultTipSegCtrl.selectedSegmentIndex), forKey: "tipChoiceSegCtrlDefault")
		}
	}
}
