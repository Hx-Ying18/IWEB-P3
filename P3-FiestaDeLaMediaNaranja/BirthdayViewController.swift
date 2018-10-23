//
//  BirthdayViewController.swift
//  P3-FiestaDeLaMediaNaranja
//
//  Created by Adrian on 21/10/2018.
//  Copyright © 2018 Adrian. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {

    // It is initialized with the current value
    var birthday: Date = Date()
    
    //Callback closure
    var cb: ((Date) -> ())?
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // By default is loaded this value in datePicker
        birthdayPicker.date = birthday
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sb ok"{
            // You cannnot be born in the future
            if birthdayPicker.date > Date(){
                let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("Fecha de nacimiento en el futuro")}))
                present(alert, animated: true)
                return false // Not to do the segue
            }
        }
        return true
    }
    
    // If it is selector birthday ok (sb ok), stores the value in birthday. If not do nothing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sb ok"{
            //birthday = birthdayPicker.date
            cb?(birthdayPicker.date)
        }
        if segue.identifier == "sb cancel"{
            // Do nothing, but dismiss
        
        }
        
        
    }
    
    
    

}
