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

        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defaults = UserDefaults.standard
        defaults.set(Double(TipControllerLeft.text!) ?? 15, forKey: "left")
        defaults.set(Double(TipControllerMid.text!) ?? 18, forKey: "mid")
        defaults.set(Double(TipControllerRight.text!) ?? 20, forKey: "right")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
