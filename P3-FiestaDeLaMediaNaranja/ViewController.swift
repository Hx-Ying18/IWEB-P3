//
//  ViewController.swift
//  P3-FiestaDeLaMediaNaranja
//
//  Created by Adrian on 12/10/2018.
//  Copyright © 2018 Adrian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myBirthday: Date?
    var myCrushDate: Date?
    
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var crushDateLabel: UILabel!
    @IBOutlet weak var partyDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatePL()
        partyDateLabel.setNeedsDisplay()
        birthdayLabel.setNeedsDisplay()
        crushDateLabel.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare for segue so to store the value that is given in the datepicker
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If myBirthday is not nil, it gives its value to the segue
        if segue.identifier=="Select birthday"{
            if(myBirthday != nil ){
                guard let bvc = segue.destination as? BirthdayViewController else { return }
                bvc.birthday = myBirthday!
            }
        }
        if segue.identifier=="Select crush date"{
            if(myCrushDate != nil ){
                guard let cvc = segue.destination as? CrushDateViewController else { return }
                cvc.crushDate = myCrushDate!
            }
        }
    }
    
    // Depending on the segue identifier, either the date on the label or not
    @IBAction func goHome(_ segue: UIStoryboardSegue) {
        updatePL()
        if segue.identifier == "sb ok"{
            if let bvc = segue.source as? BirthdayViewController{
                // You cannnot be born in the future
                if bvc.birthday > Date(){
                    let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("Fecha de nacimiento en el futuro")}))
                    present(alert, animated: true)
                }
                // You cannot crush before been born
                if (myCrushDate != nil) { // The crushDate previously stored
                    //print(bvc.birthday > myCrushDate!)
                    if (bvc.birthday > myCrushDate!){ // Compared with the curent crush date
                        let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean: tu fecha de enamoramiento es previa a la de nacimiento", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("")}))
                        present(alert, animated: true)
                    } else {
                        // The parameters can be well introduced
                        // If  the date introduced is valid it is stored
                        myBirthday = bvc.birthday
                        updateBL()
                        updatePL()
                    }
                } else {
                    // If  the date introduced is valid it is stored
                    myBirthday = bvc.birthday
                    updateBL()
                    updatePL()
                }
            }
        }
        if segue.identifier == "sb cancel"{
            
        }
        if segue.identifier == "sc ok" {
            if let cvc = segue.source as? CrushDateViewController{
                // You cannot crush in the future
                if cvc.crushDate > Date(){
                    let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean: tu fecha de enamoramiento forma parte del futuro", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("")}))
                    present(alert, animated: true)
                }
                
                // You cannot crush before been born
                if (myBirthday != nil) { // The birthday previously stored
                    if (myBirthday! > cvc.crushDate){ // COmpared with the curent crush date
                        let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean: tu fecha de enamoramiento es previa a la de nacimiento", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title:"ok", style:.default, handler: {(aa :UIAlertAction) in print("")}))
                        present(alert, animated: true)
                    } else {
                        // Param can be well introduced
                        //If  the date introduced is valid it is stored
                        myCrushDate = cvc.crushDate
                        updateCL()
                        updatePL()
                    }
                } else {
                    //If  the date introduced is valid it is tored
                    myCrushDate = cvc.crushDate
                    updateCL()
                    updatePL()
                }
            }
        }
        if segue.identifier == "sc cancel"{
            
        }
        
        
    }
    
    //Update bitrhdayLabel
    func updateBL(){
        
        if let bd = myBirthday{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            dateFormatter.locale = Locale(identifier: "es_ES")
            let t = dateFormatter.string(from: bd)
            birthdayLabel.text = "Nací el \(t)"
        }else{
            birthdayLabel.text = "No sé cuándo nací"
        }
    }
    
    //Update crushDateLabel
    func updateCL(){
    
        if let cd = myCrushDate{
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            dateFormatter.locale = Locale(identifier: "es_ES")
            let t = dateFormatter.string(from: cd)
            crushDateLabel.text = "Me enamoré el \(t)"
        }else{
            crushDateLabel.text = "No sé cuándo me enamoré"
        }
    }
    
    //If tehre has been introduced the dates it show the party date
    func updatePL() {
        // print((myBirthday != nil) && (myCrushDate != nil))
        if (myBirthday != nil) && (myCrushDate != nil){
            let calendar = Calendar.current
            let startingDate = calendar.startOfDay(for: myBirthday!)
            let untilDate = calendar.startOfDay(for: myCrushDate!)
            let days = Set<Calendar.Component>([.day])
            let numberOfDays = calendar.dateComponents(days, from: startingDate, to: untilDate)
            let dateMN = calendar.date(byAdding: .day, value: numberOfDays.day!, to: myCrushDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY"
            partyDateLabel.text = "Apunta este día: " + dateFormatter.string(from: dateMN!)
        }
        
    }
}

