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
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // By default is loaded this value in datePicker
        birthdayPicker.date = birthday
    }

    @IBAction func onOKTapped(_ sender: UIButton) {
        // You cannnot be born in the future
        if birthday > Date(){
            let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("Fecha de nacimiento en el futuro")}))
            present(alert, animated: true)
        }else{
            self.performSegue(withIdentifier:"sb ok", sender: nil)
        }
            
    }
    

    
    // MARK: - Navigation

    // If it is selector birthday ok (sb ok), stores the value in birthday. If not do nothing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sb ok"{
            birthday = birthdayPicker.date
            
//                // You cannot crush before been born
//                if (myCrushDate != nil) { // The crushDate previously stored
//                    //print(bvc.birthday > myCrushDate!)
//                    if (bvc.birthday > myCrushDate!){ // Compared with the curent crush date
//                        let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean: tu fecha de enamoramiento es previa a la de nacimiento", preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("")}))
//                        present(alert, animated: true)
//                    } else {
//                        // The parameters can be well introduced
//                        // If  the date introduced is valid it is stored
//                        myBirthday = bvc.birthday
//                        updateBL()
//                        updatePL()
//                    }
//                } else {
//                    // If  the date introduced is valid it is stored
//                    myBirthday = bvc.birthday
//                    updateBL()
//                    updatePL()
//                }
            
            
        }
        if segue.identifier == "sb cancel"{
            // Do nothing, but dismiss
        
        }
        
        
    }
    
    
    

}
