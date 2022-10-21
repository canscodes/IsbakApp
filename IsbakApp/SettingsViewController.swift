//
//  SettingsViewController.swift
//  IsbakApp
//
//  Created by Can Öncü on 21.09.2022.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func cikisYapClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)

        }catch{
            print("hata")
        }
  
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
