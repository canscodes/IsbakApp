//
//  UploadViewController.swift
//  IsbakApp
//
//  Created by Can Öncü on 21.09.2022.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func pickImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func yukleButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            //metadata: extra görselle ilgili bilgi vermek için gerke yok şu an için
            imageReference.putData(data, metadata: nil) { (storageMetaDate, error) in
                if error != nil{
                    self.hataMesajiGoster(title: "HATA!", message: error?.localizedDescription ?? "hata aldınız, tekrar deneyiniz!")
                }else{
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl{
                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = ["imageurl" : imageUrl, "yorum" :self.commentTextField.text!, "email": Auth.auth().currentUser!.email, "date": FieldValue.serverTimestamp()] as [String : Any]
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost){ (error) in
                                if error != nil{
                                    self.hataMesajiGoster(title: "hata", message: error?.localizedDescription ?? "hata aldınız, tekrar deneyiniz.")
                                }else{
                                    self.imageView.image = UIImage(named: "gorselsec")
                                    self.commentTextField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                            
                            
                            
                        }
                    }
                    }}}}}
    
        func hataMesajiGoster(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style:UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
