//
//  SolveViewController.swift
//  chessPuzzle2
//
//  Created by Leo Gondouin on 17/04/2023.
//

import UIKit
class SolveViewController: UIViewController {
    
    var dictButtons:[String:UIButton] = [:]
    var puzzleSolver = PuzzleSolver()
    
    @IBOutlet weak var lblElo: UILabel!
    var elo = 0
    var username = ""
    var role = ""
    var dictPuzzles:[Int:(String,String,Bool,String)] = [:]
    
    var piecePlayed:String? = nil
    
    @IBOutlet weak var lblWinStreak: UILabel!
    @IBOutlet weak var lblPuzzleId: UILabel!
    @IBOutlet weak var lblColorTurn: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblTurns: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var A1: UIButton!
    @IBOutlet weak var A2: UIButton!
    @IBOutlet weak var A3: UIButton!
    @IBOutlet weak var A4: UIButton!
    @IBOutlet weak var A5: UIButton!
    @IBOutlet weak var A6: UIButton!
    @IBOutlet weak var A7: UIButton!
    @IBOutlet weak var A8: UIButton!
    
    @IBOutlet weak var B1: UIButton!
    @IBOutlet weak var B2: UIButton!
    @IBOutlet weak var B3: UIButton!
    @IBOutlet weak var B4: UIButton!
    @IBOutlet weak var B5: UIButton!
    @IBOutlet weak var B6: UIButton!
    @IBOutlet weak var B7: UIButton!
    @IBOutlet weak var B8: UIButton!
    
    

    @IBOutlet weak var C1: UIButton!
    @IBOutlet weak var C2: UIButton!
    @IBOutlet weak var C3: UIButton!
    @IBOutlet weak var C4: UIButton!
    @IBOutlet weak var C5: UIButton!
    @IBOutlet weak var C6: UIButton!
    @IBOutlet weak var C7: UIButton!
    @IBOutlet weak var C8: UIButton!
    
    @IBOutlet weak var D1: UIButton!
    @IBOutlet weak var D2: UIButton!
    @IBOutlet weak var D3: UIButton!
    @IBOutlet weak var D4: UIButton!
    @IBOutlet weak var D5: UIButton!
    @IBOutlet weak var D6: UIButton!
    @IBOutlet weak var D7: UIButton!
    @IBOutlet weak var D8: UIButton!
    
    
    @IBOutlet weak var E1: UIButton!
    @IBOutlet weak var E2: UIButton!
    @IBOutlet weak var E3: UIButton!
    @IBOutlet weak var E4: UIButton!
    @IBOutlet weak var E5: UIButton!
    @IBOutlet weak var E6: UIButton!
    @IBOutlet weak var E7: UIButton!
    @IBOutlet weak var E8: UIButton!
    
    @IBOutlet weak var F1: UIButton!
    @IBOutlet weak var F2: UIButton!
    @IBOutlet weak var F3: UIButton!
    @IBOutlet weak var F4: UIButton!
    @IBOutlet weak var F5: UIButton!
    @IBOutlet weak var F6: UIButton!
    @IBOutlet weak var F7: UIButton!
    @IBOutlet weak var F8: UIButton!
    
    
    @IBOutlet weak var G1: UIButton!
    @IBOutlet weak var G2: UIButton!
    @IBOutlet weak var G3: UIButton!
    @IBOutlet weak var G4: UIButton!
    @IBOutlet weak var G5: UIButton!
    @IBOutlet weak var G6: UIButton!
    @IBOutlet weak var G7: UIButton!
    @IBOutlet weak var G8: UIButton!
    
    @IBOutlet weak var H1: UIButton!
    @IBOutlet weak var H2: UIButton!
    @IBOutlet weak var H3: UIButton!
    @IBOutlet weak var H4: UIButton!
    @IBOutlet weak var H5: UIButton!
    @IBOutlet weak var H6: UIButton!
    @IBOutlet weak var H7: UIButton!
    @IBOutlet weak var H8: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if dictPuzzles.keys.count > 0 {
            print("hi")
            puzzleSolver.dictPuzzle.removeAll()
            puzzleSolver.dictPuzzle = self.dictPuzzles
        }
        puzzleSolver.getRandomPuzzle(elo:self.elo)
        lblWinStreak!.text = "Winstreak : \(puzzleSolver.streak)"
        lblElo.text = "Current elo \(elo)"
        lblPuzzleId!.text = "Puzzle #\(puzzleSolver.puzzleId)"
        lblColorTurn!.text = "It's \((puzzleSolver.colorTurn=="w") ? "white" : "black") to move"
        lblTurns!.text = "There is \(puzzleSolver.getTurns()) turns left"
        // Do any additional setup after loading the view.
        self.bindButtontoSquare()
        self.spawnPiecesToExternalBoard()
    
        //puzzleSolver.mapToInternalBoard(funcRP: puzzleSolver.getRelativePos, square: "C3", piece: "Bknight")
        // Do any additional setup after loading the view.
    }
    
    func spawnPiecesToExternalBoard(){
        for (r,f) in puzzleSolver.piecesCoordsBlack {
            let square = puzzleSolver.getSquare(r, f)
            dictButtons[square]?.setImage(UIImage(named:puzzleSolver.getSelectedPiece(square: square)), for: .normal)
        }
        for (r,f) in puzzleSolver.piecesCoordsWhite {
            let square = puzzleSolver.getSquare(r, f)
            dictButtons[square]?.setImage(UIImage(named:puzzleSolver.getSelectedPiece(square: square)), for: .normal)
        }
    }
    
    func bindButtontoSquare() {
        dictButtons["A1"] = A1
        dictButtons["A2"] = A2
        dictButtons["A3"] = A3
        dictButtons["A4"] = A4
        dictButtons["A5"] = A5
        dictButtons["A6"] = A6
        dictButtons["A7"] = A7
        dictButtons["A8"] = A8
        
        dictButtons["B1"] = B1
        dictButtons["B2"] = B2
        dictButtons["B3"] = B3
        dictButtons["B4"] = B4
        dictButtons["B5"] = B5
        dictButtons["B6"] = B6
        dictButtons["B7"] = B7
        dictButtons["B8"] = B8
        
        dictButtons["C1"] = C1
        dictButtons["C2"] = C2
        dictButtons["C3"] = C3
        dictButtons["C4"] = C4
        dictButtons["C5"] = C5
        dictButtons["C6"] = C6
        dictButtons["C7"] = C7
        dictButtons["C8"] = C8
        
        dictButtons["D1"] = D1
        dictButtons["D2"] = D2
        dictButtons["D3"] = D3
        dictButtons["D4"] = D4
        dictButtons["D5"] = D5
        dictButtons["D6"] = D6
        dictButtons["D7"] = D7
        dictButtons["D8"] = D8
        
        dictButtons["E1"] = E1
        dictButtons["E2"] = E2
        dictButtons["E3"] = E3
        dictButtons["E4"] = E4
        dictButtons["E5"] = E5
        dictButtons["E6"] = E6
        dictButtons["E7"] = E7
        dictButtons["E8"] = E8
        
        dictButtons["F1"] = F1
        dictButtons["F2"] = F2
        dictButtons["F3"] = F3
        dictButtons["F4"] = F4
        dictButtons["F5"] = F5
        dictButtons["F6"] = F6
        dictButtons["F7"] = F7
        dictButtons["F8"] = F8
        
        dictButtons["G1"] = G1
        dictButtons["G2"] = G2
        dictButtons["G3"] = G3
        dictButtons["G4"] = G4
        dictButtons["G5"] = G5
        dictButtons["G6"] = G6
        dictButtons["G7"] = G7
        dictButtons["G8"] = G8
        
        dictButtons["H1"] = H1
        dictButtons["H2"] = H2
        dictButtons["H3"] = H3
        dictButtons["H4"] = H4
        dictButtons["H5"] = H5
        dictButtons["H6"] = H6
        dictButtons["H7"] = H7
        dictButtons["H8"] = H8
    }
    func highlightSquare(arr:Set<String>){
        for (key,_) in dictButtons {
            if arr.contains(key) {
                dictButtons[key]?.backgroundColor=UIColor.black
            }
            else{
                dictButtons[key]?.backgroundColor=UIColor.gray
            }
        }
    }
    func clearExternalBoard(){
        for (key,_) in dictButtons {
            dictButtons[key]?.setImage(UIImage(), for: .normal)
            print(key)
        }
    }
    func clearHighlight(){
        for (key,_) in dictButtons {
            dictButtons[key]?.backgroundColor=UIColor.gray
        }
    }
    
    func oppositeMove() {
        let index = (puzzleSolver.colorTurn=="w") ? 0 : 1
        if String(String(puzzleSolver.solutionCodeToGuess.split(separator:"/")[puzzleSolver.seqNum]).split(separator:"|")[index]) != "-" {
            let solutioncodeOppositeStart = String(String(String(puzzleSolver.solutionCodeToGuess.split(separator:"/")[puzzleSolver.seqNum]).split(separator:"|")[index]).uppercased().prefix(2))
            let solutioncodeOppositeEnd = String(String(String(puzzleSolver.solutionCodeToGuess.split(separator:"/")[puzzleSolver.seqNum]).split(separator:"|")[index]).uppercased().suffix(2))
            self.piecePlayed = puzzleSolver.getSelectedPiece(square:solutioncodeOppositeStart)
            puzzleSolver.playMove(start: solutioncodeOppositeStart, destination: solutioncodeOppositeEnd)
            dictButtons[solutioncodeOppositeStart]?.setImage(UIImage(), for: .normal)
            dictButtons[solutioncodeOppositeEnd]?.setImage(UIImage(named:"\(self.piecePlayed!).png"), for: .normal)
        }
        print(puzzleSolver.getInternalCode())
        print(puzzleSolver.solutionCodeToGuess)
    }
    
    func movePiece(square:String){
        if !puzzleSolver.isDone {
                if puzzleSolver.startSquare != "" {
                    puzzleSolver.destinationSquare = square
                    if puzzleSolver.startSquare == puzzleSolver.destinationSquare {
                        puzzleSolver.startSquare = ""
                        puzzleSolver.destinationSquare = ""
                        clearHighlight()
                    }
                }
                else {
                    if puzzleSolver.getSelectedPiece(square: square) != ""{
                        if puzzleSolver.getSelectedPiece(square: square).prefix(1) == puzzleSolver.colorTurn.uppercased() {
                            self.piecePlayed = puzzleSolver.getSelectedPiece(square: square)
                            puzzleSolver.startSquare=square
                            highlightSquare(arr: puzzleSolver.getPossibleMoves(square: square))
                        }
                    }
                }
                if puzzleSolver.startSquare != "" && puzzleSolver.destinationSquare != "" {
                    if puzzleSolver.getPossibleMoves(square: puzzleSolver.startSquare).contains(puzzleSolver.destinationSquare){
                        if puzzleSolver.destinationSquare == square {
                            if let value = self.piecePlayed {
                                dictButtons[square]?.setImage(UIImage(named:"\(value).png"),for:.normal)
                            }
                        }
                        puzzleSolver.playMove(start: puzzleSolver.startSquare, destination: puzzleSolver.destinationSquare)
                        if puzzleSolver.getSelectedPiece(square:puzzleSolver.startSquare) == ""{
                            dictButtons[puzzleSolver.startSquare]?.setImage(UIImage(), for: .normal)
                        }
                        print(puzzleSolver.initcolorTurn)
                        print(puzzleSolver.colorTurn)
                        if puzzleSolver.initcolorTurn != puzzleSolver.colorTurn {
                            oppositeMove()
                        }
                        if puzzleSolver.checkMove() {
                            print(puzzleSolver.seqNum)
                            lblTurns!.text = "There is \(puzzleSolver.getTurns()-(puzzleSolver.seqNum)) turns left"
                            if puzzleSolver.isFullyValidSequence() {
                                puzzleSolver.isDone = true
                                lblError.textColor = UIColor.green
                                lblError.text = "Congrats you have finished the puzzle successfully!"
                                lblError.isHidden = false
                                btnNext.isHidden = false
                            }
                        }
                        else {
                            puzzleSolver.isDone = true
                            lblError.textColor = UIColor.red
                            lblError.text = "You played the wrong move"
                            lblError.isHidden = false
                            btnNext.isHidden = false
                            
                        }
                        puzzleSolver.startSquare=""
                        puzzleSolver.destinationSquare=""
                        clearHighlight()
                    }
                }
            }
        }
    
    @IBAction func A1_click(_ sender: Any) {
        movePiece(square: "A1")
    }
    @IBAction func A2_click(_ sender: Any) {
        movePiece(square: "A2")
    }
    @IBAction func A3_click(_ sender: Any) {
        movePiece(square: "A3")
    }
    @IBAction func A4_click(_ sender: Any) {
        movePiece(square: "A4")
    }
    @IBAction func A5_click(_ sender: Any) {
        movePiece(square: "A5")
    }
    @IBAction func A6_click(_ sender: Any) {
        movePiece(square: "A6")
    }
    @IBAction func A7_click(_ sender: Any) {
        movePiece(square: "A7")
    }
    @IBAction func A8_click(_ sender: Any) {
        movePiece(square: "A8")
    }
    
    
    @IBAction func B1_click(_ sender: Any) {
        movePiece(square: "B1")
    }
    @IBAction func B2_click(_ sender: Any) {
        movePiece(square: "B2")
    }
    @IBAction func B3_click(_ sender: Any) {
        movePiece(square: "B3")
    }
    @IBAction func B4_click(_ sender: Any) {
        movePiece(square: "B4")
    }
    @IBAction func B5_click(_ sender: Any) {
        movePiece(square: "B5")
    }
    @IBAction func B6_click(_ sender: Any) {
        movePiece(square: "B6")
    }
    @IBAction func B7_click(_ sender: Any) {
        movePiece(square: "B7")
    }
    @IBAction func B8_click(_ sender: Any) {
        movePiece(square: "B8")
    }
    
    @IBAction func C1_click(_ sender: Any) {
        movePiece(square: "C1")
    }
    @IBAction func C2_click(_ sender: Any) {
        movePiece(square: "C2")
    }
    @IBAction func C3_click(_ sender: Any) {
        movePiece(square: "C3")
    }
    @IBAction func C4_click(_ sender: Any) {
        movePiece(square: "C4")
    }
    @IBAction func C5_click(_ sender: Any) {
        movePiece(square: "C5")
    }
    @IBAction func C6_click(_ sender: Any) {
        movePiece(square: "C6")
    }
    @IBAction func C7_click(_ sender: Any) {
        movePiece(square: "C7")
    }
    @IBAction func C8_click(_ sender: Any) {
        movePiece(square: "C8")
    }
    
    @IBAction func D1_click(_ sender: Any) {
        movePiece(square: "D1")
    }
    @IBAction func D2_click(_ sender: Any) {
        movePiece(square: "D2")
    }
    @IBAction func D3_click(_ sender: Any) {
        movePiece(square: "D3")
    }
    @IBAction func D4_click(_ sender: Any) {
        movePiece(square: "D4")
    }
    @IBAction func D5_click(_ sender: Any) {
        movePiece(square: "D5")
    }
    @IBAction func D6_click(_ sender: Any) {
        movePiece(square: "D6")
    }
    @IBAction func D7_click(_ sender: Any) {
        movePiece(square: "D7")
    }
    @IBAction func D8_click(_ sender: Any) {
        movePiece(square: "D8")
    }
    
    @IBAction func E1_click(_ sender: Any) {
        movePiece(square: "E1")
    }
    @IBAction func E2_click(_ sender: Any) {
        movePiece(square: "E2")
    }
    @IBAction func E3_click(_ sender: Any) {
        movePiece(square: "E3")
    }
    @IBAction func E4_click(_ sender: Any) {
        movePiece(square: "E4")
    }
    @IBAction func E5_click(_ sender: Any) {
        movePiece(square: "E5")
    }
    @IBAction func E6_click(_ sender: Any) {
        movePiece(square: "E6")
    }
    @IBAction func E7_click(_ sender: Any) {
        movePiece(square: "E7")
    }
    @IBAction func E8_click(_ sender: Any) {
        movePiece(square: "E8")
    }
    
    
    @IBAction func F1_click(_ sender: Any) {
        movePiece(square: "F1")
    }
    @IBAction func F2_click(_ sender: Any) {
        movePiece(square: "F2")
    }
    @IBAction func F3_click(_ sender: Any) {
        movePiece(square: "F3")
    }
    @IBAction func F4_click(_ sender: Any) {
        movePiece(square: "F4")
    }
    @IBAction func F5_click(_ sender: Any) {
        movePiece(square: "F5")
    }
    @IBAction func F6_click(_ sender: Any) {
        movePiece(square: "F6")
    }
    @IBAction func F7_click(_ sender: Any) {
        movePiece(square: "F7")
    }
    @IBAction func F8_click(_ sender: Any) {
        movePiece(square: "F8")
    }
    
    @IBAction func G1_click(_ sender: Any) {
        movePiece(square: "G1")
    }
    @IBAction func G2_click(_ sender: Any) {
        movePiece(square: "G2")
    }
    @IBAction func G3_click(_ sender: Any) {
        movePiece(square: "G3")
    }
    @IBAction func G4_click(_ sender: Any) {
        movePiece(square: "G4")
    }
    @IBAction func G5_click(_ sender: Any) {
        movePiece(square: "G5")
    }
    @IBAction func G6_click(_ sender: Any) {
        movePiece(square: "G6")
    }
    @IBAction func G7_click(_ sender: Any) {
        movePiece(square: "G7")
    }
    @IBAction func G8_click(_ sender: Any) {
        movePiece(square: "G8")
    }
    
    @IBAction func H1_click(_ sender: Any) {
        movePiece(square: "H1")
    }
    @IBAction func H2_click(_ sender: Any) {
        movePiece(square: "H2")
    }
    @IBAction func H3_click(_ sender: Any) {
        movePiece(square: "H3")
    }
    @IBAction func H4_click(_ sender: Any) {
        movePiece(square: "H4")
    }
    @IBAction func H5_click(_ sender: Any) {
        movePiece(square: "H5")
    }
    @IBAction func H6_click(_ sender: Any) {
        movePiece(square: "H6")
    }
    @IBAction func H7_click(_ sender: Any) {
        movePiece(square: "H7")
    }
    @IBAction func H8_click(_ sender: Any) {
        movePiece(square: "H8")
    }
    @IBAction func btnNext_click(_ sender: Any) {
        puzzleSolver.piecesCoordsWhite.removeAll()
        puzzleSolver.piecesCoordsBlack.removeAll()
        puzzleSolver.kingCoordsBlack = nil
        puzzleSolver.kingCoordsWhite = nil
        
        puzzleSolver.resetSolver()
        clearExternalBoard()
        

        lblError.isHidden = true
        btnNext.isHidden = true
        
        puzzleSolver.getRandomPuzzle(elo:elo)
        lblWinStreak!.text = "Winstreak : \(puzzleSolver.streak)"
        lblElo!.text = "Current elo : \(puzzleSolver.elo)"
        lblPuzzleId!.text = "Puzzle #\(puzzleSolver.puzzleId)"
        lblColorTurn!.text = "It's \((puzzleSolver.colorTurn=="w") ? "white" : "black") to move"
        lblTurns!.text = "There is \(puzzleSolver.getTurns()) turns left"
        self.spawnPiecesToExternalBoard()
        self.elo = puzzleSolver.elo
        print(puzzleSolver.board)
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
