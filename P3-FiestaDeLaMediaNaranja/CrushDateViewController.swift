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
