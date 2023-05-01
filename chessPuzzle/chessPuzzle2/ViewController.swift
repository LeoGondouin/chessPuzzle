//
//  ViewController.swift
//  chessPuzzle2
//
//  Created by Leo Gondouin on 17/04/2023.
//

import UIKit

class ViewController: UIViewController {
    var dictRegistered = ["Guesser1":(password:"Guesser123",role:"Guesser",elo:1000),"Creator1":(password:"Creator123",role:"Creator",elo:0),"Admin1":(password:"Admin123",role:"Admin",elo:1600)]
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dictRegistered)
        // Do any additional setup after loading the view.
        
    }
    override func shouldPerformSegue(withIdentifier identifier:String, sender: Any?) -> Bool {
        var shouldRedirect = false
        if identifier == "HomeSegue" {
             if let registrationTuple = self.dictRegistered[txtUsername.text!] {
                 if registrationTuple.password == txtPassword.text!.trimmingCharacters(in: .whitespaces) {
                  shouldRedirect = true
                 }
             }
        }
        else if identifier == "RegisterSegue" {
            shouldRedirect = true
        }
        return shouldRedirect
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HomePageViewController {
            let vc = segue.destination as? HomePageViewController
            vc?.username = txtUsername.text!
            if let value = self.dictRegistered[txtUsername.text!] {
                vc?.role = value.role
                vc?.elo = String(value.elo)
            }
        }
        else if segue.destination is RegisterViewController{
            let vc = segue.destination as? RegisterViewController
            vc?.dictRegistered = self.dictRegistered
        }
    }
}

