//
//  UploadViewController.swift
//  InstaCloneFirebase
//
//  Created by Hilmihan Çalışan on 17.08.2022.
//

import UIKit
import Firebase
import FirebaseStorage




class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cemmendText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRocognizer = UITapGestureRecognizer(target: self, action: #selector(choosenImage))
        imageView.addGestureRecognizer(gestureRocognizer)
    }
    

    @objc func choosenImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    @IBAction func uploadButton(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uudi = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uudi).jpg")
            imageReferance.putData(data, metadata: nil) { metadata, error in
            
            if error != nil {
                
                self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                
            }else {
                
                imageReferance.downloadURL { ( url, error) in
                    
                    
                    if error == nil {
                        
                        let imageUrl = url?.absoluteString
                        
                        //DATABASE
                        
                        let firestoreDatabase = Firestore.firestore()
                        
                        var firestoreReferance : DocumentReference? = nil
                        
                        let firestorePost = ["imageUrl" : imageUrl!, "posteBy" : Auth.auth().currentUser!.email!, "postCommed" : self.cemmendText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0 ] as [String : Any]
                        
                        firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                            if error != nil {
                                
                                self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                            
                            }else {
                                
                                self.imageView.image = UIImage(named: "seleckt2" )
                                self.cemmendText.text = ""
                                self.tabBarController?.selectedIndex = 0
                            }
                        })
                        
                    }
                    
                }
                    
                }
            }
            
        }
            
          
        
    
    }
            
        
        
    }
    


