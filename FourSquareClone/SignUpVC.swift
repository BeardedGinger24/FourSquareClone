//
//  ViewController.swift
//  FourSquareClone
//
//  Created by Mher Oganesyan on 10/22/19.
//  Copyright © 2019 Mher Oganesyan. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        let parseObject = PFObject(className: "Fruits")
//        parseObject["name"] = "Banana"
//        parseObject["calories"] = 150
//        parseObject.saveInBackground { (success, error) in
//            if error != nil {
//                print(error?.localizedDescription)
//            } else {
//                print("uploaded")
//            }
//        }
        
//        let query = PFQuery(className: "Fruits")
//        query.whereKey("name", equalTo: "apple")
//        query.findObjectsInBackground { (objects, error) in
//            if error != nil {
//                print(error?.localizedDescription)
//            } else {
//                print(objects)
//            }
//        }
    }

    @IBAction func signinClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
                } else {
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        } else {
            makeAlert(title: "Error", message: "username or password is empty")
        }
    }
    
    @IBAction func signupClicked(_ sender: Any) {
        if usernameText.text != "" && passwordText.text != "" {
            let user = PFUser()
            user.username = usernameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
                } else {
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        } else {
            makeAlert(title: "Error", message: "username or password is empty")
        }
    }
    
    func makeAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okbutton)
        self.present(alert, animated: true, completion: nil)
    }
}

