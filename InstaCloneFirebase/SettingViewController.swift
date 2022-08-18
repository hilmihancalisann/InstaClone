//
//  SettingViewController.swift
//  InstaCloneFirebase
//
//  Created by Hilmihan Çalışan on 17.08.2022.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backClıcked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toOneVC", sender: nil)
        }catch {
            
            print("Error!")
        }
    }
    
    
}
