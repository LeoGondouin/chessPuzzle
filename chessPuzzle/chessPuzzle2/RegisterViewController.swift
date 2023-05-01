//
//  registerViewController.swift
//  chessPuzzle2
//
//  Created by Leo Gondouin on 17/04/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    var dictRegistered:[String:(String,String,Int)]?=nil
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var lblError: UILabel!
    var isSolving = false
    
    var selectedRole = "Guesser"
    var selectedLevel = "Beginner"
    

    @IBOutlet weak var menuRole: UIButton!
    
    @IBOutlet weak var menuLevel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLevelMenu()
        self.setRoleMenu()
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier:String, sender: Any?) -> Bool {
        var shouldRedirect = true
        if let value = self.dictRegistered![txtUsername.text!] {
            lblError.text! = "L'utilisateur existe déjà"
            shouldRedirect = false
        }
        return shouldRedirect
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ViewController {
            let vc = segue.destination as? ViewController
            if let value = vc?.dictRegistered[txtUsername.text!] {

            } else {
                let elo:Int = (self.selectedLevel == "Beginner") ? 1000 : (self.selectedLevel == "Intermediate") ? 1300 : (            self.selectedLevel == "Advanced") ? 1600  : 0
                vc?.dictRegistered[txtUsername.text!] = (password:txtPassword.text!,role:self.selectedRole,elo:elo)
            }
        }
    }
    
    func setLevelMenu () {
        print("ok")
        let levelClicked = {(action : UIAction) in
            self.selectedLevel = action.title
        }
        menuLevel.menu = UIMenu(children : [
            UIAction(title : "Beginner", state: .on,handler:levelClicked),
            UIAction(title : "Intermediate", state: .on,handler:levelClicked),
            UIAction(title : "Advanced",state: .on,handler:levelClicked)
        ])
    }
    
    func setRoleMenu () {
        let menuClicked = {(action : UIAction) in
            if action.title=="Creator"{
                self.menuLevel.isHidden = true
                self.selectedLevel = ""
            }
            else {
                self.menuLevel.isHidden = false
            }
            self.selectedRole = action.title
        }
        menuRole.menu = UIMenu(children : [
            UIAction(title : "Guesser", subtitle:"To solve puzzles", state: .on,handler:menuClicked),
            UIAction(title : "Creator", subtitle:"To create puzzles", state: .on,handler:menuClicked)
        ])
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
