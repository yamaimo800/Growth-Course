//
//  SignUpViewController.swift
//  ScheduleAppSample
//
//  Created by 山本英介 on 2021/06/10.
//

import UIKit


//class SignUpViewController: UIViewController, UITextFieldDelegate {
//
//    @IBOutlet var userIdTextField: UITextField!
//    @IBOutlet var emailTextField: UITextField!
//    @IBOutlet var passwordTextField: UITextField!
//    @IBOutlet var confirmTextField: UITextField!
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        userIdTextField.delegate = self
//        emailTextField.delegate = self
//        passwordTextField.delegate = self
//        confirmTextField.delegate = self
//
//        // Do any additional setup after loading the view.
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//
//    @IBAction func signUp() {
//        let user = NCMBUser()
//
//        if (userIdTextField.text!.count) > 4  {
//            print("文字数が足りません")
//            return
//        }
//
//        user.userName = userIdTextField.text!
//        user.mailAddress = emailTextField.text!
//
//        if passwordTextField.text == confirmTextField.text {
//            user.password = passwordTextField.text!
//        } else {
//            print("パスワードの不一致")
//        }
//
//        user.signUpInBackground { (error) in
//            if error != nil {
//        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
//            UIApplication.shared.keyWindow?.rootViewController = rootViewController
//        }
//
//
//
//
//
//
//
//        }
//    }
//}
