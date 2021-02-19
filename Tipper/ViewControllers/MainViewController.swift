//  MainViewController.swift
//  Tipper
//
//  Created by Favian Flores on 1/30/21.

import UIKit

class MainViewController: UIViewController {
	let defaults = UserDefaults.standard

	@IBOutlet weak var billAmountTextField: UITextField!
	@IBOutlet weak var numberOfPeopleTextField: UITextField!
	@IBOutlet weak var tipLabel: UILabel!
	@IBOutlet weak var totalLabel: UILabel!
	@IBOutlet weak var tipPerPersonLabel: UILabel!
	@IBOutlet weak var totalPerPersonLabel: UILabel!
	@IBOutlet weak var tipChoiceSegCtrl: UISegmentedControl!

	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(saveData),
			name: UIApplication.willResignActiveNotification,
			object: nil
		)
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(restoreData),
			name: UIApplication.willEnterForegroundNotification,
			object: nil
		)
		setDefaults()
		restoreData()
		billAmountTextField.becomeFirstResponder()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateTipController()
		calculateTip()
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	@IBAction func userInput(_ sender: Any) {
		calculateTip()
	}

	func setDefaults() {
		if defaults.value(forKey: "tipChoiceSegCtrl0") == nil {
			defaults.set(15, forKey: "tipChoiceSegCtrl0")
		}
		if defaults.value(forKey: "tipChoiceSegCtrl1") == nil {
			defaults.set(18, forKey: "tipChoiceSegCtrl1")
		}
		if defaults.value(forKey: "tipChoiceSegCtrl2") == nil {
			defaults.set(20, forKey: "tipChoiceSegCtrl2")
		}
		if defaults.value(forKey: "tipChoiceSegCtrlDefault") == nil {
			defaults.set(1, forKey: "tipChoiceSegCtrlDefault")
		}
		if defaults.value(forKey: "tipChoiceSegCtrlIndex") == nil {
			defaults.set(1, forKey: "tipChoiceSegCtrlIndex")
		}
	}

	func updateTipController() {
		tipChoiceSegCtrl.setTitle(
			String(defaults.integer(forKey: "tipChoiceSegCtrl0")) + "%",
			forSegmentAt: 0
		)
		tipChoiceSegCtrl.setTitle(
			String(defaults.integer(forKey: "tipChoiceSegCtrl1")) + "%",
			forSegmentAt: 1
		)
		tipChoiceSegCtrl.setTitle(
			String(defaults.integer(forKey: "tipChoiceSegCtrl2")) + "%",
			forSegmentAt: 2
		)
	}

	func calculateTip() {
		let left = defaults.integer(forKey: "tipChoiceSegCtrl0")
		let mid = defaults.integer(forKey: "tipChoiceSegCtrl1")
		let right = defaults.integer(forKey: "tipChoiceSegCtrl2")
		let tipPercentages = [left, mid, right]

		let people = Double(numberOfPeopleTextField.text!) ?? 1.0
		let bill = Double(billAmountTextField.text!) ?? 0.0
		let tip = (bill * Double(tipPercentages[tipChoiceSegCtrl.selectedSegmentIndex]) * 0.01)
		let total = bill + tip

		let billPerPerson = bill / people
		let tipPerPerson = tip / people
		let totalPerPerson = billPerPerson + tipPerPerson

		tipLabel.text = String(format: "$%.2f", tip)
		totalLabel.text = String(format: "$%.2f", total)
		tipPerPersonLabel.text = String(format: "$%.2f", tipPerPerson)
		totalPerPersonLabel.text = String(format: "$%.2f", totalPerPerson)
	}

	@objc func restoreData() {
		let date = Date()
		let deleteDataby = defaults.value(forKey: "deleteDataBy")
		if deleteDataby != nil && date > deleteDataby as! Date {
			defaults.set("", forKey: "billAmount")
			defaults.set("", forKey: "numberOfPeople")
			defaults.set(
				defaults.integer(forKey: "tipChoiceSegCtrlDefault"),
				forKey: "tipChoiceSegCtrlIndex"
			)
		}
		billAmountTextField.text = defaults.string(forKey: "billAmount")
		numberOfPeopleTextField.text = defaults.string(forKey: "numberOfPeople")
		tipChoiceSegCtrl.selectedSegmentIndex = defaults.integer(forKey: "tipChoiceSegCtrlIndex")
		updateTipController()
		calculateTip()
	}

	@objc func saveData() {
		defaults.set(Double(billAmountTextField.text!), forKey: "billAmount")
		defaults.set(Int(numberOfPeopleTextField.text!), forKey: "numberOfPeople")
		defaults.set(Int(tipChoiceSegCtrl.selectedSegmentIndex), forKey: "tipChoiceSegCtrlIndex")
		defaults.set(Date(timeInterval: 600, since: Date()), forKey: "deleteDataBy")
	}
}
