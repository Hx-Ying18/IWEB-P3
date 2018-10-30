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
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var crushDateLabel: UILabel!
    @IBOutlet weak var partyDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // It initialize the values of myBirthday if are stored in userdefault

        // If already stored one
        if let lastBirthday = defaults.object(forKey: "lastBirthdayStored") as? Date{
            myBirthday = lastBirthday
            updateBL()
        }
        // If already stored one
        if let lastCrushDate = defaults.object(forKey: "lastCrushDateStored") as? Date{
            myCrushDate = lastCrushDate
            updateCL()
        }

        updatePL()
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
        if segue.identifier == "sb ok"{
            // If already stored one
            if let lastBirthday = defaults.object(forKey: "lastBirthdayStored") as? Date{
                myBirthday = lastBirthday
                updateBL()
            }
            // print(birthdayLabel.text ?? "Empty yet")
            updatePL()
            // print(partyDateLabel.text ?? "Empty yet")

        }
        if segue.identifier == "sb cancel"{}
        if segue.identifier == "sc ok" {
            // If already stored one
            if let lastCrushDate = defaults.object(forKey: "lastCrushDateStored") as? Date{
                myCrushDate = lastCrushDate
                updateCL()
            }
            updatePL()

        }
        if segue.identifier == "sc cancel"{}
        
        
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
            
            // Code to add a day
            //let seconds = 60*60*24
            //let interval : TimeInterval = Date(seconds)
            //typealias TimeInterval = Double(seconds)
            //let dateMNgood = dateMN?.dateByAddingTimeInterval(TimeInterval: interval )
        }
        
    }
}

