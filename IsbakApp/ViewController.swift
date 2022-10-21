//
//  ViewController.swift
//  IsbakApp
//
//  Created by Can Öncü on 20.09.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapClicked(_ sender: Any) {
        if let email = emailTextField.text,  let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){
                (authDataResult, error) in
                if error != nil{
                    self.errorMessage(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız")
                    
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            self.errorMessage(titleInput: "Hata", messageInput: "Email ve Parola Giriniz")
        }
    }
    @IBAction func kayitOlClicked(_ sender: Any) {
        
        if let email = emailTextField.text,  let password = passwordTextField.text {
        //kayit ol
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authDataResult, error) in
                if error != nil{
                    self.errorMessage(titleInput: "Hata", messageInput: error?.localizedDescription ?? "Hata Aldınız")
                }else{
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            errorMessage(titleInput: "Hata!", messageInput: "Kullanıcı Adı Ve Şifre Giriniz!")
        }
        
    }
    func errorMessage(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

