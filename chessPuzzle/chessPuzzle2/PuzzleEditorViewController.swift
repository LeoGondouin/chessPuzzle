//
//  PuzzleEditorViewController.swift
//  chessPuzzle2
//
//  Created by Leo Gondouin on 17/04/2023.
//

import UIKit

class PuzzleEditorViewController: UIViewController {

    var dictButtons:[String:UIButton] = [:]
    var puzzleManager = PuzzleManager()
    @IBOutlet weak var menuPieces: UIButton!
    
    var pieceToPlace:String? = "Wpawn"
    var piecePlayed:String? = nil
    
    var username = ""
    var role = ""
    var elo = ""
    
    var limitReached = false
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var txtExport: UITextField!
    @IBOutlet weak var btnExport: UIButton!
    @IBOutlet weak var btnImport: UIButton!
    @IBOutlet weak var lblFenCode: UILabel!
    @IBOutlet weak var btnColor: UIButton!
    @IBOutlet weak var ctnPieces: UIView!
    @IBOutlet weak var txtExportFENCode: UITextField!
    @IBOutlet weak var txtImportFENCode: UITextField!
    
    @IBOutlet weak var btnPuzzle: UIButton!
    
    @IBOutlet weak var txtNotationCode: UITextView!
    @IBOutlet weak var lblNotationCode: UILabel!
    @IBOutlet weak var btnResetSequence: UIButton!
    
    @IBOutlet weak var lblError: UILabel!
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
        self.bindButtontoSquare()
        self.setPieceMenu()
        btnColor.setTitle("It's \((puzzleManager.colorTurn=="w") ? "white" : "black") to play",for: .normal)
        /*puzzleManager.mapToInternalBoard(funcRP: puzzleManager.getRelativePos, square: "A3", piece: "Brook")
        puzzleManager.mapToInternalBoard(funcRP: puzzleManager.getRelativePos, square: "F3", piece: "Wpawn")
        puzzleManager.mapToInternalBoard(funcRP: puzzleManager.getRelativePos, square: "H2", piece: "Wking")*/
        // Do any additional setup after loading the view.
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
    func clearHighlight(){
        for (key,_) in dictButtons {
            dictButtons[key]?.backgroundColor=UIColor.gray
        }
    }
    func placePiece(square:String){
        if let piece = pieceToPlace {
            if piece != "eraser" {
                puzzleManager.mapToInternalBoard(funcRP:puzzleManager.getRelativePos, square: square, piece: piece)
                dictButtons[square]?.setImage(UIImage(named:"\(piece).png"), for: .normal)
            }
            else {
                puzzleManager.capture(square: square, color: (String(puzzleManager.getSelectedPiece(square:square).prefix(1))=="W") ? "B" : "W")
                puzzleManager.mapToInternalBoard(funcRP:puzzleManager.getRelativePos, square: square, piece: "")
                dictButtons[square]?.setImage(UIImage(), for: .normal)
            }
        }
        print(puzzleManager.board)
        print(puzzleManager.piecesCoordsWhite)
        print(puzzleManager.piecesCoordsBlack)
    }
    func movePiece(square:String){
        if !self.limitReached {
            if puzzleManager.startSquare != "" {
                puzzleManager.destinationSquare = square
                if puzzleManager.startSquare == puzzleManager.destinationSquare {
                    puzzleManager.startSquare = ""
                    puzzleManager.destinationSquare = ""
                    clearHighlight()
                }
            }
            else {
                if puzzleManager.getSelectedPiece(square: square) != ""{
                    if puzzleManager.getSelectedPiece(square: square).prefix(1) == puzzleManager.colorTurn.uppercased() {
                        self.piecePlayed = puzzleManager.getSelectedPiece(square: square)
                        puzzleManager.startSquare=square
                        highlightSquare(arr: puzzleManager.getPossibleMoves(square: square))
                    }
                }
            }
            if puzzleManager.startSquare != "" && puzzleManager.destinationSquare != "" {
                if puzzleManager.getPossibleMoves(square: puzzleManager.startSquare).contains(puzzleManager.destinationSquare){
                    if puzzleManager.destinationSquare == square {
                        if let value = self.piecePlayed {
                            dictButtons[square]?.setImage(UIImage(named:"\(value).png"),for:.normal)
                        }
                    }
                    puzzleManager.playMove(start: puzzleManager.startSquare, destination: puzzleManager.destinationSquare)
                    showNotationCode()
                    if puzzleManager.getSelectedPiece(square:puzzleManager.startSquare) == ""{
                        dictButtons[puzzleManager.startSquare]?.setImage(UIImage(), for: .normal)
                    }
                    puzzleManager.startSquare=""
                    puzzleManager.destinationSquare=""
                    clearHighlight()
                }
            }
        }
        
        /*print("start : \(puzzleManager.startSquare)")
        print("end : \(puzzleManager.destinationSquare)")
        print(puzzleManager.piecesCoordsBlack)
        print(puzzleManager.piecesCoordsWhite)
        print(puzzleManager.board)
        //print(puzzleManager.getPossibleMoves(square: "C3"))*/
    }
    func showNotationCode() {
        if puzzleManager.notationCode.split(separator: "/").count <= 7 {
            txtNotationCode?.text = puzzleManager.notationCode.replacingOccurrences(of: "/", with: "\n")
        }
        else {
            lblNotationCode.isHidden = false
            lblNotationCode.text = "Vous ne pouvez pas renseigner une séquence supérieure à 7 coups !"
            self.limitReached = true
        }
    }
    @IBAction func A1_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "A1")
        }
        else {
            placePiece(square: "A1")
        }
    }
    @IBAction func A2_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "A2")
        }
        else {
            placePiece(square: "A2")
        }
    }
    @IBAction func A3_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "A3")
        }
        else {
            placePiece(square: "A3")
        }
    }
    @IBAction func A4_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "A4")
        }
        else {
            placePiece(square: "A4")
        }
    }
    @IBAction func A5_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "A5")
        }
        else {
            placePiece(square: "A5")
        }
    }
    @IBAction func A6_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "A6")
        }
        else {
            placePiece(square: "A6")
        }
    }
    @IBAction func A7_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "A7")
        }
        else {
            placePiece(square: "A7")
        }
    }
    @IBAction func A8_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "A8")
        }
        else {
            placePiece(square: "A8")
        }
    }
    
    @IBAction func B1_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "B1")
        }
        else {
            placePiece(square: "B1")
        }
    }
    @IBAction func B2_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "B2")
        }
        else {
            placePiece(square: "B2")
        }
    }
    @IBAction func B3_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "B3")
        }
        else {
            placePiece(square: "B3")
        }
    }
    @IBAction func B4_click(_ sender: Any) {
        if puzzleManager.isRecording {
            movePiece(square: "B4")
        }
        else {
            placePiece(square: "B4")
        }
    }
     @IBAction func B5_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "B5")
         }
         else {
             placePiece(square: "B5")
         }
     }
    @IBAction func B6_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "B6")
         }
         else {
             placePiece(square: "B6")
         }
    }
    @IBAction func B7_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "B7")
         }
         else {
             placePiece(square: "B7")
         }
    }
    @IBAction func B8_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "B8")
         }
         else {
             placePiece(square: "B8")
         }
    }
    
    @IBAction func C1_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "C1")
         }
         else {
             placePiece(square: "C1")
         }
    }
    @IBAction func C2_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "C2")
         }
         else {
             placePiece(square: "C2")
         }
    }
    @IBAction func C3_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "C3")
         }
         else {
             placePiece(square: "C3")
         }
    }
    @IBAction func C4_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "C4")
         }
         else {
             placePiece(square: "C4")
         }
    }
    @IBAction func C5_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "C5")
         }
         else {
             placePiece(square: "C5")
         }
    }
    @IBAction func C6_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "C6")
         }
         else {
             placePiece(square: "C6")
         }
    }
    @IBAction func C7_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "C7")
         }
         else {
             placePiece(square: "C7")
         }
    }
    @IBAction func C8_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "C8")
         }
         else {
             placePiece(square: "C8")
         }
    }
    
    @IBAction func D1_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "D1")
         }
         else {
             placePiece(square: "D1")
         }
    }
    @IBAction func D2_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "D2")
         }
         else {
             placePiece(square: "D2")
         }
    }
    @IBAction func D3_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "D3")
         }
         else {
             placePiece(square: "D3")
         }
    }
    @IBAction func D4_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "D4")
         }
         else {
             placePiece(square: "D4")
         }
    }
    @IBAction func D5_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "D5")
         }
         else {
             placePiece(square: "D5")
         }
    }
    @IBAction func D6_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "D6")
         }
         else {
             placePiece(square: "D6")
         }
    }
    @IBAction func D7_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "D7")
         }
         else {
             placePiece(square: "D7")
         }
    }
    @IBAction func D8_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "D8")
         }
         else {
             placePiece(square: "D8")
         }
    }
    
    @IBAction func E1_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "E1")
         }
         else {
             placePiece(square: "E1")
         }
    }
    @IBAction func E2_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "E2")
         }
         else {
             placePiece(square: "E2")
         }
    }
    @IBAction func E3_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "E3")
         }
         else {
             placePiece(square: "E3")
         }
    }
    @IBAction func E4_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "E4")
         }
         else {
             placePiece(square: "E4")
         }
    }
    @IBAction func E5_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "E5")
         }
         else {
             placePiece(square: "E5")
         }
    }
    @IBAction func E6_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "E6")
         }
         else {
             placePiece(square: "E6")
         }
    }
    @IBAction func E7_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "E7")
         }
         else {
             placePiece(square: "E7")
         }
    }
    @IBAction func E8_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "E8")
         }
         else {
             placePiece(square: "E8")
         }
    }
    @IBAction func F1_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "F1")
         }
         else {
             placePiece(square: "F1")
         }
    }
    @IBAction func F2_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "F2")
         }
         else {
             placePiece(square: "F2")
         }
    }
    @IBAction func F3_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "F3")
         }
         else {
             placePiece(square: "F3")
         }
    }
    @IBAction func F4_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "F4")
         }
         else {
             placePiece(square: "F4")
         }
    }
    @IBAction func F5_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "F5")
         }
         else {
             placePiece(square: "F5")
         }
    }
    @IBAction func F6_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "F6")
         }
         else {
             placePiece(square: "F6")
         }
    }
    @IBAction func F7_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "F7")
         }
         else {
             placePiece(square: "F7")
         }
    }
    @IBAction func F8_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "F8")
         }
         else {
             placePiece(square: "F8")
         }
    }
    
    @IBAction func G1_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "G1")
         }
         else {
             placePiece(square: "G1")
         }
    }
    @IBAction func G2_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "G2")
         }
         else {
             placePiece(square: "G2")
         }
    }
    @IBAction func G3_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "G3")
         }
         else {
             placePiece(square: "G3")
         }
    }
    @IBAction func G4_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "G4")
         }
         else {
             placePiece(square: "G4")
         }
    }
    @IBAction func G5_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "G5")
         }
         else {
             placePiece(square: "G5")
         }
    }
    @IBAction func G6_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "G6")
         }
         else {
             placePiece(square: "G6")
         }
    }
    @IBAction func G7_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "G7")
         }
         else {
             placePiece(square: "G7")
         }
    }
    @IBAction func G8_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "G8")
         }
         else {
             placePiece(square: "G8")
         }
    }
    
    @IBAction func H1_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "H1")
         }
         else {
             placePiece(square: "H1")
         }
    }
    @IBAction func H2_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "H2")
         }
         else {
             placePiece(square: "H2")
         }
    }
    @IBAction func H3_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "H3")
         }
         else {
             placePiece(square: "H3")
         }
    }
    @IBAction func H4_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "H4")
         }
         else {
             placePiece(square: "H4")
         }
    }
    @IBAction func H5_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "H5")
         }
         else {
             placePiece(square: "H5")
         }
    }
    @IBAction func H6_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "H6")
         }
         else {
             placePiece(square: "H6")
         }
    }
    @IBAction func H7_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "H7")
         }
         else {
             placePiece(square: "H7")
         }
    }
    @IBAction func H8_click(_ sender: Any) {
         if puzzleManager.isRecording {
             movePiece(square: "H8")
         }
         else {
             placePiece(square: "H8")
         }
    }
/*    func spawnPiecesOnExternalBoard(){
        for (rank,file) in puzzleManager.piecesCoordsWhite {
            let square = puzzleManager.getSquare(rank,file)
            let piece = puzzleManager.getSelectedPiece(square:
            switch(piece){
                case "Wpawn":
                    dictButtons[puzzleManager.getSquare(rank, file]).setImage(whitepawnimg)
            }
        }
    }*/
    
    func cleanExternalBoard(){
        
    }
    func spawnPiecesToExternalBoard(){
        for (r,f) in puzzleManager.piecesCoordsBlack {
            let square = puzzleManager.getSquare(r, f)
            dictButtons[square]?.setImage(UIImage(named:puzzleManager.getSelectedPiece(square: square)), for: .normal)
        }
        for (r,f) in puzzleManager.piecesCoordsWhite {
            let square = puzzleManager.getSquare(r, f)
            dictButtons[square]?.setImage(UIImage(named:puzzleManager.getSelectedPiece(square: square)), for: .normal)
        }
    }
    @IBAction func btnImport_click(_ sender: Any) {
        if let code = txtImportFENCode.text {
            var fencode = puzzleManager.importFENcode(FENcode: code)
            if fencode=="Success" {
                lblFenCode.textColor = UIColor.green
            }
            lblFenCode.text = fencode
        }
        btnColor.setTitle("It's \((puzzleManager.colorTurn=="w") ? "white" : "black") to play",for: .normal)
        print(puzzleManager.kingCoordsBlack)
        print(puzzleManager.kingCoordsWhite)
        spawnPiecesToExternalBoard()
    }
    @IBAction func btnExport(_ sender: Any) {
        txtExportFENCode.isHidden = false
        txtExportFENCode.text = puzzleManager.exportFENCode(colorTurn: Character(puzzleManager.colorTurn), castles: "-", en_passant: "-")
    }
    func setPieceMenu () {
        let piecesClicked = {(action : UIAction) in
            if let value = action.subtitle {
                self.pieceToPlace = value
            }
            else {
                self.pieceToPlace = action.title
            } }
        
        menuPieces.menu = UIMenu(children : [
            UIAction(title : "White pawn",subtitle:"Wpawn", state: .on,handler:piecesClicked),
            UIAction(title : "White knight",subtitle:"Wknight",state: .on,handler:piecesClicked),
            UIAction(title : "White bishop",subtitle:"Wbishop",state: .on,handler:piecesClicked),
            UIAction(title : "White queen",subtitle:"Wqueen",state: .on,handler:piecesClicked),
            UIAction(title : "White king",subtitle:"Wking",state: .on,handler:piecesClicked),
        
            UIAction(title : "Black pawn",subtitle:"Bpawn", state: .on,handler:piecesClicked),
            UIAction(title : "Black knight",subtitle:"Bknight",state: .on,handler:piecesClicked),
            UIAction(title : "Black bishop",subtitle:"Bbishop",state: .on,handler:piecesClicked),
            UIAction(title : "Black queen",subtitle:"Bqueen",state: .on,handler:piecesClicked),
            UIAction(title : "Black king",subtitle:"Bking",state: .on,handler:piecesClicked),
            UIAction(title : "eraser",state: .on,handler:piecesClicked),
        ])
    }
    @IBAction func btnStart(_ sender: Any) {
        let msg = puzzleManager.startSequence()
        if (msg=="Success") {
            puzzleManager.isRecording = true
            showSequenceMenu()
            puzzleManager.initFenCode = puzzleManager.exportFENCode(colorTurn: Character(puzzleManager.colorTurn), castles: "-", en_passant: "-")
        }
        else {
            lblError!.text = msg
        }
    }
    
    func showSequenceMenu(){
        lblFenCode.isHidden = true
        txtImportFENCode.isHidden = true
        btnImport.isHidden = true
        btnColor.isHidden = true
        txtExportFENCode.isHidden = true
        btnExport.isHidden = true
        menuPieces.isHidden = true
        lblError.isHidden = true
        btnStart.isHidden = true
        
        txtNotationCode.isHidden = false
        btnResetSequence.isHidden = false
        lblNotationCode.isHidden = false
        btnPuzzle.isHidden = false
    }

    @IBAction func btnColor_click(_ sender: Any) {
        puzzleManager.changeColorTurn()
        btnColor.setTitle("It's \((puzzleManager.colorTurn=="w") ? "white" : "black") to play",for: .normal)
    }
    @IBAction func btnResetSequence_click(_ sender: Any) {
        puzzleManager.notationCode = ""
        txtNotationCode.text = ""
        lblNotationCode.text = ""
        txtExportFENCode.isHidden = false
        puzzleManager.clearBoard()
        puzzleManager.importFENcode(FENcode: puzzleManager.initFenCode)
        spawnPiecesToExternalBoard()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is HomePageViewController {
            let ps = PuzzleSolver()
            var dictPuzzle = ps.dictPuzzle
            let nextkey = dictPuzzle.keys.max()!+1
            let vc = segue.destination as? HomePageViewController
            print(role)
            vc?.role = role
            vc?.username = username
            vc?.elo = elo
            dictPuzzle[nextkey] = (puzzleManager.exportFENCode(colorTurn:"w", castles: "-", en_passant: "-"),puzzleManager.getInternalCode(),true,"easy")
            vc?.dictPuzzles = dictPuzzle
            
        }
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
