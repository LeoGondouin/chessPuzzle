//
//  HomePageViewController.swift
//  chessPuzzle2
//
//  Created by Leo Gondouin on 25/04/2023.
//

import UIKit

class HomePageViewController: UIViewController {
    var username:String=""
    var role:String = ""
    var elo:String = ""
    
    var dictPuzzles:[Int:(String,String,Bool,String)] = [:]

    
    @IBOutlet weak var btnManager: UIButton!
    @IBOutlet weak var btnSolver: UIButton!
    
    @IBOutlet weak var lblHello: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblElo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dictPuzzles)
        lblHello.text = "Hello \(username)"
        lblRole.text = "You're a(n) \(role)"
        if elo != "" {
            lblElo.text = "Your current elo is \(elo)"
        }
        if role=="Guesser" || role == "Admin" {
            btnSolver.isHidden = false
        }
        if role == "Creator" || role == "Admin" {
            btnManager.isHidden = false
        }
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is SolveViewController {
            let vc = segue.destination as? SolveViewController
            vc?.elo = Int(self.elo)!
            vc?.username = username
            vc?.role = role
            vc?.dictPuzzles = self.dictPuzzles
        }
        if segue.destination is PuzzleEditorViewController {
            let vc = segue.destination as? PuzzleEditorViewController
            vc?.elo = self.elo
            vc?.username = self.username
            vc?.role = self.role
        }
    }
   /* func setLevelMenu() {
        menuPieces.menu = UIMenu(children : [
            UIAction(title : "White pawn",subtitle:"Wpawn", state: .on,handler:piecesClicked),
            UIAction(title : "eraser",state: .on,handler:piecesClicked),
        ])
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
