//
//  ViewController.swift
//  PictureShrApp
//
//  Created by Erbil Can on 3.09.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var emailTexField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func girisYapTiklandi(_ sender: Any) {
        if emailTexField.text != "" && sifreTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTexField.text!, password: sifreTextField.text!) { (autdataresult, error) in
                if error != nil{
                    self.hataMesaji(titleInput: "Hata!", messageInput: error?.localizedDescription ?? "Hata aldınız. Tekrar deneyiniz")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            }
            
        }else {
            self.hataMesaji(titleInput: "Hata", messageInput: "Email ve şifre giriniz!")
        }
    }
    
    @IBAction func kayiOlTiklandi(_ sender: Any) {
        if emailTexField.text != "" && sifreTextField.text != "" {
            
            //kullanıcı kayıt işlemleri
            Auth.auth().createUser(withEmail: emailTexField.text!, password: sifreTextField.text!) { authdataresult, error in
                if error != nil{
                    self.hataMesaji(titleInput: "Hata", messageInput: error!.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            hataMesaji(titleInput: "Hata", messageInput: "Email ve şifre giriniz")
        }
    }
    func hataMesaji(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
        
        
    }
}

