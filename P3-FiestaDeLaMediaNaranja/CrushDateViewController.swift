//
//  CrushDateViewController.swift
//  P3-FiestaDeLaMediaNaranja
//
//  Created by Adrian on 21/10/2018.
//  Copyright © 2018 Adrian. All rights reserved.
//

import UIKit

class CrushDateViewController: UIViewController {
    
    // Today by default
    var crushDate: Date = Date()
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var crushDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let lastCrushDate = defaults.object(forKey: "lastCrushDateStored") as? Date{
            crushDate = lastCrushDate
        }
        
        // Every time it reload it load the crushDate
        crushDatePicker.date = crushDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "sc ok"{
            // You cannnot be born in the future
            if crushDatePicker.date > Date(){
                let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean: fecha de enamoramiento en el futuro", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("")}))
                present(alert, animated: true)
                return false // Not to do the segue
            }
            if let lastBirthday = defaults.object(forKey: "lastBirthdayStored") as? Date{
                // You cannot crush before been born
                if (lastBirthday > crushDatePicker.date){ // Compared with the curent crush date
                    let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean: tu fecha de enamoramiento es previa a la de nacimiento", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("")}))
                    present(alert, animated: true)
                    return false
                }else{
                    return true
                }
            }
            return true
        }
        if identifier=="sc cancel"{
            return true
        }
        
        // In other unexpected cases
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="sc ok"{
            crushDate = crushDatePicker.date
            let defaults = UserDefaults.standard
            defaults.set(crushDate, forKey: "lastCrushDateStored")
        }
        if segue.identifier=="sc cancel"{
            
        }
    }

}
