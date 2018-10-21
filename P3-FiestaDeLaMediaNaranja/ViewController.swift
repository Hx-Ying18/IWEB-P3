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
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Prepare for segue so to store the value that give the datepicker
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // Depending on the segue identifier, either the date on the label or not
    @IBAction func goHome(_ segue: UIStoryboardSegue) {
        if segue.identifier == "sb ok"{
            if let bvc = segue.source as? BirthdayViewController{
                // You cannnot be born in the future
                if bvc.birthday > Date(){
                    let alert = UIAlertController(title: "Error", message: "Bájate del DeLorean", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"ok", style:.default))
                    present(alert, animated: true)
                    } else {
                    //If  the date introduced is valid it is tored
                    myBirthday = bvc.birthday
                    updateBL()
                }
            }
        }
        if segue.identifier == "sb cancel"{
            
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
}

