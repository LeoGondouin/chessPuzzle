//
//  puzzleSolver.swift
//  chessPuzzle2
//
//  Created by Leo Gondouin on 25/04/2023.
//

import Foundation

class PuzzleSolver:PuzzleManager {
    var dictPuzzle = [1:(fenCode:"r2qb1rk/ppb2p1p/2n1pPp1/B3N3/2B1P2Q/2P2R2/1P4PP/7K w - -",solutionCode:"h4h7|h8h7/f3h3|-",isMate:true,level:"medium"),2:(fenCode:"6rk/1q1n1prp/p3pN1Q/1p1b4/6R1/6P1/PP2PP1P/3R2K1 w - -", solutionCode:"h6h7|g7h7/g4g8|-",isMate:true,level:"medium"),3:(fenCode:"Q1B5/8/3p4/3N1p2/2p1k3/2n1B3/2R3K1/8 w - -", solutionCode:"a8a3|c3a2/d5f6|-",isMate:true,level:"hard"),4:(fenCode:"6k1/2R5/p1N1p2p/2N2pp1/3P4/4p1P1/P1n2PPK/1r6 w - -", solutionCode:"c6e7|g8h7/e7d5|h7g6/c5e6|b1h1/h2h1|f5f4/g3g4|h6h5/e6f8|g6h6/c7h7|-",isMate:true,level:"hard"),5:(fenCode:"6n1/3k3q/2nN4/1p2PPp1/3N2Pp/5K2/2Q5/8 w - -", solutionCode:"c2c6|d7d8/d4e6|d8e7/c6c7|-",isMate:true,level:"easy"),6:(fenCode:"5r1k/1pRRn2r/p3B3/4ppbp/7N/6P1/PP3P2/6K1 w - -", solutionCode:"h4g6|e7g6/d7h7|-",isMate:true,level:"easy"),7:(fenCode:"r4k2/5p1p/2b1pQp1/1p6/1P6/1BB2P2/4q1PP/3R3K w - -", solutionCode:"f6h8|f8e7/c3f6|-", isMate:true,level:"easy"),8:(fenCode:"8/1b3kp1/p1pQNpr1/1p2p2p/4P3/1PP4P/1P4P1/7K w - -", solutionCode:"d6d7|f7g8/d7e8|g8h7/e6f8|h7g8/f8g6|g8h7/g6e7|g7g6/e8g6|-", isMate:false,level:"hard"),9:(fenCode:"2R5/5p2/5Pkp/6p1/pp1KN1P1/1r5P/8/8 w - -", solutionCode:"c8g8|g6h7/g8g7|h7h8/e4d6|b3d3/d4d3|h6h5/d6f7|-",isMate:true,level:"medium")]
    
  var streak = 0

  var puzzleId = 0
  var fencodeToGuess=""
  var solutionCodeToGuess=""
  var level = ""
  var elo = 0
  var notationcodeAppend = ""

  var isMate = false
  var seqNum = 0
  var isWhite = true
    
  var isDone = false

    func getRandomPuzzle(elo:Int) {
    if self.elo == 0 {
        self.elo = elo
    }
      var key:Int
      if elo <= 1000 {
          key = dictPuzzle.filter({$0.value.level=="easy"}).randomElement()!.key
      }
      else if elo <= 1500 {
          key = dictPuzzle.filter({$0.value.level=="easy" || $0.value.level=="medium"}).randomElement()!.key
      }
      else {
          key = dictPuzzle.filter({$0.value.level=="easy" || $0.value.level=="medium" || $0.value.level=="hard"}).randomElement()!.key
      }
    self.puzzleId = key
    self.fencodeToGuess = dictPuzzle[key]!.fenCode
    self.solutionCodeToGuess = dictPuzzle[key]!.solutionCode
    self.isMate = dictPuzzle[key]!.isMate
    self.level = dictPuzzle[key]!.level
    self.importFENcode(FENcode: self.fencodeToGuess)
    //self.isWhite = (self.colorTurn=="w") ? true : false
    print(isWhite)
    print("\(self.fencodeToGuess) \(self.solutionCodeToGuess)")
  }

  func checkMove()-> Bool {
    var isValidSequence = false
    let splittedCode = self.solutionCodeToGuess.split(separator:"/")

    let value = String(splittedCode[seqNum])
    let internalcode = String(self.getInternalCode().split(separator:"/")[seqNum])
    let notationcode = String(self.notationCode.split(separator:"/")[seqNum])

    if isWhite {
      if value.split(separator:"|")[0] == internalcode.split(separator:"|")[0] {
        isValidSequence = true
        /*if internalcode.trimmingCharacters(in:.whitespacesAndNewlines) == self.solutionCodeToGuess.split(separator:"/").last!.trimmingCharacters(in:.whitespacesAndNewlines) && isMate {
          let notationcodeLast = notationcode.split(separator:" ")[0].replacingOccurrences(of:"+",with:"")
          self.notationcodeAppend += "\(notationcodeLast.split(separator:" ")[0])#"
        }
        else {
          self.notationcodeAppend += "\(notationcode.split(separator:" ")[0]) "
        }
        if notationcodeAppend.split(separator:" ").count%2 == 0{
          self.notationcodeAppend += "\n"
        }*/
        isWhite = false
      }
      else {
          self.streak = 0
          let malus = (level=="easy") ? 10 : (level=="medium") ? 5 : (level=="hard") ? 2 : 0
          if self.elo > 600 {
              self.elo -= malus
          }
          else {
              self.elo = 600
          }
      }
    }
    else {
      if value.split(separator:"|")[1] == internalcode.split(separator:"|")[1] {
        isValidSequence = true
        /*if internalcode.trimmingCharacters(in:.whitespacesAndNewlines) == self.solutionCodeToGuess.split(separator:"/").last!.trimmingCharacters(in:.whitespacesAndNewlines) && isMate && notationcode != "- " {
            if notationcode.split(separator:" ").indices.contains(1){
                let notationcodeLast = notationcode.split(separator:" ")[1].replacingOccurrences(of:"+",with:"")
                self.notationcodeAppend += "\(notationcodeLast.split(separator:" ")[1])#"
            }
            else {
                let notationcodeLast = notationcode.split(separator:" ")[0].replacingOccurrences(of:"+",with:"")
                self.notationcodeAppend += "\(notationcodeLast.split(separator:" ")[0])#"
            }
        }
        else {
            if notationcode.split(separator:" ").indices.contains(1){
                self.notationcodeAppend += "\(notationcode.split(separator:" ")[1]) "
            }
            else {
                self.notationcodeAppend += "\(notationcode.split(separator:" ")[0]) "
            }
        }
        if notationcodeAppend.split(separator:" ").count%2 == 0{
          self.notationcodeAppend += "\n"
        }*/
          self.isWhite = true
          
      }
      else {
          self.streak = 0
          let malus = (level=="easy") ? 10 : (level=="medium") ? 5 : (level=="hard") ? 2 : 0
          if self.elo > 600 {
              self.elo -= malus
          }
          else {
              self.elo = 600
          }
      }
    }
  print(self.notationcodeAppend)
    self.seqNum += 1
    return isValidSequence
  }
  func isFullyValidSequence()-> Bool {
    var isFullyValidSequence = false
    if self.solutionCodeToGuess == self.getInternalCode().trimmingCharacters(in: .whitespacesAndNewlines) {
      self.streak += 1
        let bonus = (level=="easy") ? 2 : (level=="medium") ? 5 : (level=="hard") ? 10 : 0
        if elo < 3000 {
            self.elo += bonus
        }
        else {
            self.elo = 3000
        }
      isFullyValidSequence = true
    }
    return isFullyValidSequence
  }
    func getTurns()->Int{
        return self.solutionCodeToGuess.components(separatedBy:"/").count
    }
  func resetSolver() {
      self.isMate = false
      self.seqNum = 0
      self.isWhite = true
      self.isDone = false
      self.clearBoard()
      self.notationCode = ""
  }

}
