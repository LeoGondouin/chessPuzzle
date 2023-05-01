// Classe gérant la partie "Manager" de l'application
class PuzzleManager {
  //Tuple pour conserver la position des pièces
  var piecesCoordsWhite=[(rank:Int,file:Int)]()
  var piecesCoordsBlack=[(rank:Int,file:Int)]()

  //Les rois ayant des comportements différents, on les stock de côté afin de ne pas avoir à reparcourir les variables du dessus
  var kingCoordsBlack:(rank:Int,file:Int)? = nil
  var kingCoordsWhite:(rank:Int,file:Int)? = nil

  // Afin de déterminer si le premier coup est à faire chez les blancs ou les noirs (ne change pas)
  var initcolorTurn = ""

  // Afin de déterminer à qui est le tour
  var colorTurn = ""

  // Afin de déterminer si un pion est capturable par "en passant"
  var en_passant = ""

  // Afin de déterminer les roques possibles
  var castles = ""

  // Booléen déterminant le comportement des cases si faux, les pièces sont justes posées, si vrai, les pièces seront jouées et les coups seront enregistrés
  var isRecording = false

  // Pour déterminer quel coup sera joué
  var startSquare=""
  var destinationSquare=""

  // Pour conserver la notation des coups joués
  var notationCode=""

  // Afin de prendre une "photo" de l'échiquier à un moment T (utilisé pour la fonction restreignant le mouvement des pièces clouées)
  var currentFenCode = ""
  var currentPiecesBlackCoords = [(rank:Int,file:Int)]()
  var currentPiecesWhiteCoords = [(rank:Int,file:Int)]()

  // Afin de garder le FEN code fait avant de déplacer les pièces (au cas où le créateur veuille ré-initialiser les coups jouer)
  var initFenCode = ""
    
  // Matrice à 2 dimensions afin de représenter un échiquier interne, essentiel pour tous les calculs
    var board = [
      ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""],
      ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""],
      ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""],
      ["", "", "", "", "", "", "", ""], ["", "", "", "", "", "", "", ""],
    ]

    // Enumération du code des pièces noires
    enum blackPieces: String {
      case r = "Brook"
      case n = "Bknight"
      case b = "Bbishop"
      case q = "Bqueen"
      case k = "Bking"
      case p = "Bpawn"
    }

    // Enumération du code des pièces blanches
    enum whitePieces: String {
      case R = "Wrook"
      case N = "Wknight"
      case B = "Wbishop"
      case Q = "Wqueen"
      case K = "Wking"
      case P = "Wpawn"
    }

    // Pour reset l'échiquier interne
    func clearBoard(){
      self.piecesCoordsWhite.removeAll()
      self.piecesCoordsBlack.removeAll()
      self.kingCoordsWhite = nil
      self.kingCoordsBlack = nil
      for i in 0..<self.board.count {
        for j in 0..<self.board.count {
          board[i][j]=""
        }
      }
    }

  //Fonction chargeant les pièces sur l'échiquier interne et stockant la position de chaque pièce
  func importFENcode(FENcode: String) -> String{
    clearBoard()
    let FENcodeTrimmed = FENcode.trimmingCharacters(in: .whitespacesAndNewlines)
    let validator = FENcodeValidator(FENcode: FENcodeTrimmed)
    //Si le code est bon je continue
    if validator.checkIntegrity() != "Success" { return validator.checkIntegrity()}
    var i = 0
    var j = 1

    let pos = FENcodeTrimmed.split(separator: " ")[0]
    let colorTurn = FENcodeTrimmed.split(separator: " ")[1]
    let castles = FENcodeTrimmed.split(separator: " ")[2]
    self.castles = String(castles)
    let en_passant = FENcodeTrimmed.split(separator: " ")[3]
    self.en_passant = String(en_passant)

    // Parcours de chaque caractères de la première partie du FEN code afin de placer les pièces
    for char in pos {
      // Si le caractère est un entier n, je passe n colonne
      if let step: Int = Int(String(char)) {
        j += step
      } else {
        switch char {
        // Si c'est un "/"" je passe à la ligne suivante
        case "/":
          i += 1
          j = 0
        // Sinon je place la pièce sur l'échiquier interne et dans le tableau de coordonnées associé
        case "r":
          board[i][j - 1] = blackPieces.r.rawValue
          piecesCoordsBlack.append((rank:i,file:j-1))
        case "R":
          board[i][j - 1] = whitePieces.R.rawValue
          piecesCoordsWhite.append((rank:i,file:j-1))
        case "n":
          board[i][j - 1] = blackPieces.n.rawValue
          piecesCoordsBlack.append((rank:i,file:j-1))
        case "N":
          board[i][j - 1] = whitePieces.N.rawValue
          piecesCoordsWhite.append((rank:i,file:j-1))
        case "b":
          board[i][j - 1] = blackPieces.b.rawValue
          piecesCoordsBlack.append((rank:i,file:j-1))
        case "B":
          board[i][j - 1] = whitePieces.B.rawValue
          piecesCoordsWhite.append((rank:i,file:j-1))
        case "q":
          board[i][j - 1] = blackPieces.q.rawValue
          piecesCoordsBlack.append((rank:i,file:j-1))
        case "Q":
          board[i][j - 1] = whitePieces.Q.rawValue
          piecesCoordsWhite.append((rank:i,file:j-1))
        case "k":
          board[i][j - 1] = blackPieces.k.rawValue
          piecesCoordsBlack.append((rank:i,file:j-1))
          kingCoordsBlack = (rank:i,file:j-1)
        case "K":
          board[i][j - 1] = whitePieces.K.rawValue
          piecesCoordsWhite.append((rank:i,file:j-1))
          kingCoordsWhite = (rank:i,file:j-1)
        case "p":
          board[i][j - 1] = blackPieces.p.rawValue
          piecesCoordsBlack.append((rank:i,file:j-1))
        case "P":
          board[i][j - 1] = whitePieces.P.rawValue
          piecesCoordsWhite.append((rank:i,file:j-1))
        default: break
        }
        // Quand une pièce placé, il faut passer une colonne de plus
        j += 1
      }
    }

    // Traitement du roque
    var castleString = ""
    for castle in castles {
      switch castle {
      case "Q": castleString += "White may castle queen's side"
      case "K": castleString += "White may castle king's side"
      case "q": castleString += "Black may castle queen's side"
      case "k": castleString += "Black may castle king's side"
      default: break
      }
      castleString += " / "
    }
    castleString = String(castleString.dropLast(3))

    //Définition de la couleur du premier coup
    self.colorTurn = String(colorTurn)
    self.initcolorTurn = String(colorTurn)

    print("It's \((colorTurn=="w") ? "white" : "black") to play")
    if !castles.contains("-") {
      print(castleString)
    }

    //Définition du pion capturable par en_passant
    var letterEnPassant: Substring
    var numberEnPassant: Substring
    var capturablePawn: Int
    if !en_passant.contains("-") {
      letterEnPassant = en_passant.prefix(1)
      numberEnPassant = en_passant.suffix(1)
      capturablePawn =
        (colorTurn == "w") ? Int(String(numberEnPassant))! - 1 : Int(String(numberEnPassant))! + 1
      print("The \(letterEnPassant)\(capturablePawn) pawn can be captured by \"en passant\"")
      
    }
      return ""
  }

  // Lecture de l'échiquier interne afin de récupérer le FEN code de l'échiquier actuel
  func exportFENCode(colorTurn: Character, castles: String, en_passant: String) -> String {
    var fenCode: String = ""
    var step = 0
    for line in board {
      for i in 0...line.count - 1 {
        if line[i] == "" {
          step += 1
          continue
        } else {
          if step >= 1 && step <= 7 {
            fenCode += String(step)
            step = 0
          }
          switch line[i] {
          case blackPieces.r.rawValue: fenCode += "r"
          case whitePieces.R.rawValue: fenCode += "R"
          case blackPieces.n.rawValue: fenCode += "n"
          case whitePieces.N.rawValue: fenCode += "N"
          case blackPieces.b.rawValue: fenCode += "b"
          case whitePieces.B.rawValue: fenCode += "B"
          case blackPieces.q.rawValue: fenCode += "q"
          case whitePieces.Q.rawValue: fenCode += "Q"
          case blackPieces.k.rawValue: fenCode += "k"
          case whitePieces.K.rawValue: fenCode += "K"
          case blackPieces.p.rawValue: fenCode += "p"
          case whitePieces.P.rawValue: fenCode += "P"
          default: break
          }
        }
      }
        if step != 0 {
            fenCode += "\(step)/"
        }
    step = 0
    }
    fenCode = String(fenCode.dropLast(1))
    let otherParameters = " \(colorTurn) \(castles) \(en_passant)"
    fenCode += otherParameters
    return fenCode
  }

  // Obtenir la position à partir de la case de l'échiquier (par exemple B2->rang:6,colonne:1)
  func getRelativePos(_ square: String) -> (rank:Int, file:Int) {
    let arrFile = ["A", "B", "C", "D", "E", "F", "G", "H"]
    let squareRank = square.suffix(1)
    let squareFile = String(square.prefix(1))
    var j = 0
    while arrFile[j] != squareFile { j += 1 }
    return (8 - Int(squareRank)!, j)
  }

  // Obtenir la case à partir de la position relative (par exemple rang:6,colonne:1->"B2")
  func getSquare(_ rank: Int, _ file: Int) -> String {
    var i = 8
    while i != file {i -= 1}
    let fileLetter = Character(UnicodeScalar(i + 65)!)
    return "\(fileLetter)\(8-rank)"
  }

  // Afin de placer les pièces sur l'échiquier interne directement
  func mapToInternalBoard(funcRP: (String) -> (rank: Int, file: Int), square: String, piece: String) {
    board[funcRP(square).rank][funcRP(square).file] = piece
    if piece.prefix(1)=="B" {
      piecesCoordsBlack.append(funcRP(square))
      if piece.contains("king"){
        self.kingCoordsBlack=funcRP(square)
      }
    }
    else if piece.prefix(1)=="W"{
      piecesCoordsWhite.append(funcRP(square))
      if piece.contains("king"){
        self.kingCoordsWhite=funcRP(square)
      }
    }
  }
  
  // Afin de connaitre le code de la pièce à partir de la case renseigné
  func getSelectedPiece(square: String) -> String {
    return board[getRelativePos(square).rank][getRelativePos(square).file]
  }

  // Pour connaitre les cases attaquées par une pièce sélectionnée (utilisée pour déterminer les mouvements du roi (getKingPossibleMoves) (afin qu'il ne puisse pas se mettre en échec volontairement))
  func getTargetedSquares(square: String) -> Set<String> {
    // Récupération de la position actuelle sur l'échiquier à partir de la case renseignée
    let pos = getRelativePos(square)


    var arrTargetedSquare = Set<String>()

    //En fonction de la pièce étant sur la cases choisie, on ajoute les cases que cette pièce attaque, tout en vérifiant que la case calculée est toujours sur l'échiquier et en vérifiant si certaine pièces restreignent les cases attaquées par la pièce sélectionnée

    switch getSelectedPiece(square:square){
      case "Wpawn":
        if pos.rank - 1 >= 0 {
          if pos.file - 1 >= 0 {
            arrTargetedSquare.insert(getSquare(pos.rank - 1, pos.file - 1))
          }
          if pos.file + 1 <= 7 {
            arrTargetedSquare.insert(getSquare(pos.rank - 1, pos.file + 1))
          }
        }
      case "Bpawn":
        if pos.rank + 1 >= 0 {
          if pos.file - 1 >= 0 {
            arrTargetedSquare.insert(getSquare(pos.rank + 1, pos.file - 1))
          }
          if pos.file + 1 <= 7 {
            arrTargetedSquare.insert(getSquare(pos.rank + 1, pos.file + 1))
          }
        }
      case let sq where sq.contains("king"):
        if pos.rank - 1 >= 0 {
          arrTargetedSquare.insert(getSquare(pos.rank - 1, pos.file))
        }
        if pos.rank + 1 <= 7 {
          arrTargetedSquare.insert(getSquare(pos.rank + 1, pos.file))
        }
        if pos.file - 1 >= 0 {
          arrTargetedSquare.insert(getSquare(pos.rank, pos.file-1))
        }
        if pos.file + 1 <= 7 {
          arrTargetedSquare.insert(getSquare(pos.rank, pos.file+1))
        }
        if pos.rank - 1 >= 0 && pos.file - 1 >= 0 {
          arrTargetedSquare.insert(getSquare(pos.rank-1, pos.file-1))
        }
        if pos.rank + 1 <= 7 && pos.file - 1 >= 0 {
          arrTargetedSquare.insert(getSquare(pos.rank+1, pos.file-1))
        }
        if pos.rank - 1 >= 0 && pos.file + 1 <= 7 {
          arrTargetedSquare.insert(getSquare(pos.rank-1, pos.file+1))
        }
        if pos.rank + 1 <= 7 && pos.file + 1 <= 7 {
          arrTargetedSquare.insert(getSquare(pos.rank+1, pos.file+1))
        }
      case let sq where sq.contains("rook"):
        for i in 0...7 {
          if pos.file + i <= 7 {
            if getSelectedPiece(square:getSquare(pos.rank, pos.file + i))==""{
              arrTargetedSquare.insert(getSquare(pos.rank, pos.file + i))
            }
            else if(getSquare(pos.rank, pos.file + i) != square){
              arrTargetedSquare.insert(getSquare(pos.rank, pos.file + i))
              break
            }
          }
        }
        for i in 0...7 {
          if pos.file - i >= 0 {
            if getSelectedPiece(square:getSquare(pos.rank, pos.file - i))==""{
              arrTargetedSquare.insert(getSquare(pos.rank, pos.file - i))
            }
            else if (getSquare(pos.rank, pos.file - i) != square) {
              arrTargetedSquare.insert(getSquare(pos.rank, pos.file - i))
              break
            }
          }
        }
        for i in 0...7 {
          if pos.rank + i <= 7 {
            if getSelectedPiece(square:getSquare(pos.rank+i, pos.file))==""{
              arrTargetedSquare.insert(getSquare(pos.rank+i, pos.file))
            }
            else if (getSquare(pos.rank+i, pos.file) != square) {
              arrTargetedSquare.insert(getSquare(pos.rank+i, pos.file))
              break
            }
          }
        }
        for i in 0...7 {
          if pos.rank - i >= 0 {
            if getSelectedPiece(square:getSquare(pos.rank-i, pos.file))==""{
              arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file))
            }
            else if (getSquare(pos.rank-i, pos.file) != square){
              arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file))
              break
            }
          }
        }
    case let sq where sq.contains("bishop"):
      for i in 0...7 {
        if pos.rank + i <= 7 && pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file+i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank + i, pos.file + i))
          }
          else if(getSquare(pos.rank+i, pos.file+i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank + i, pos.file + i))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 && pos.file - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file-i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file-i))
          }
          else if(getSquare(pos.rank-i, pos.file-i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file-i))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 && pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file+i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file+i))
          }
          else if(getSquare(pos.rank-i, pos.file+i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file+i))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 && pos.file - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file-i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank+i, pos.file-i))
          }
          else if(getSquare(pos.rank+i, pos.file-i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank+i, pos.file-i))
            break
          }
        }
      }
    case let sq where sq.contains("queen"):
     for i in 0...7 {
        if pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank, pos.file + i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank, pos.file + i))
          }
          else if(getSquare(pos.rank, pos.file + i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank, pos.file + i))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.file-i>=0 {
          if getSelectedPiece(square:getSquare(pos.rank, pos.file - i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank, pos.file - i))
          }
          else if(getSquare(pos.rank, pos.file-i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank, pos.file - i))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file))==""{
            arrTargetedSquare.insert(getSquare(pos.rank+i, pos.file))
          }
          else if(getSquare(pos.rank+i, pos.file) != square){
            arrTargetedSquare.insert(getSquare(pos.rank+i, pos.file))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file))==""{
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file))
          }
          else if(getSquare(pos.rank-i, pos.file) != square){
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 && pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file+i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank + i, pos.file + i))
          }
          else if(getSquare(pos.rank+i, pos.file+i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank + i, pos.file + i))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 && pos.file - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file-i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file-i))
          }
          else if(getSquare(pos.rank-i, pos.file-i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file-i))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 && pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file+i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file+i))
          }
          else if(getSquare(pos.rank-i, pos.file+i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank-i, pos.file+i))
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 && pos.file - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file-i))==""{
            arrTargetedSquare.insert(getSquare(pos.rank+i, pos.file-i))
          }
          else if(getSquare(pos.rank+i, pos.file-i) != square){
            arrTargetedSquare.insert(getSquare(pos.rank+i, pos.file-i))
            break
          }
        }
      }
    case let sq where sq.contains("knight"):
      if pos.file - 1 >= 0 && pos.rank + 2 <= 7 {
        arrTargetedSquare.insert(getSquare(pos.rank + 2, pos.file - 1))
      }
      if pos.file + 1 <= 7 && pos.rank + 2 <= 7 {
        arrTargetedSquare.insert(getSquare(pos.rank + 2, pos.file + 1))
      }
      if pos.rank - 2 >= 0 && pos.file + 1 <= 7 {
        arrTargetedSquare.insert(getSquare(pos.rank - 2, pos.file + 1))
      }
      if pos.rank - 2 >= 0 && pos.file - 1 >= 0 {
        arrTargetedSquare.insert(getSquare(pos.rank - 2, pos.file - 1))
      }
      if pos.rank - 1 >= 0 && pos.file + 2 <= 7 {
        arrTargetedSquare.insert(getSquare(pos.rank - 1, pos.file + 2))
      }
      if pos.rank + 1 <= 7 && pos.file + 2 <= 7 {
        arrTargetedSquare.insert(getSquare(pos.rank + 1, pos.file + 2))
      }
      if pos.file - 2 >= 0 && pos.rank + 1 <= 7 {
        arrTargetedSquare.insert(getSquare(pos.rank + 1, pos.file - 2))
      }
      if pos.file - 2 >= 0 && pos.rank - 1 >= 0 {
        arrTargetedSquare.insert(getSquare(pos.rank - 1, pos.file - 2))
      }
      default:
        break
    }
    return arrTargetedSquare
  }

  //Même type de fonction que la précédente, mais calcule tous les mouvements possibles (par exemple pour les pions, dans celle d'avant on calculait juste les cases adjacentes diagonales attaquables par les pions, ici on calcule les mouvements ou le pion avance sans attaquer mais aussi, si le pion peut vraiment bouger en diagonale adjacente, ce qui est seulement possible si une pièce ennemie est présent sur l'une des cases en diagonale adjacente).

  //On tient aussi compte des couleurs sur cette fonction, si une pièce ennemie est présente sur une case possible, on peut aller jusqu'à elle mais pas plus loin, tandis que si c'est une pièce alliée on s'arrête juste avant.

  //Cette fonction filtre aussi les mouvements des rois afin qu'il ne puissent pas se suicider et empêche les autres pièces alliées de bouger si leur mouvement implique la mort de leur roi par la suite (clouage)

  func getPossibleMoves(square: String) -> Set<String> {
    let pos = getRelativePos(square)
    var arrPossibleMoves = Set<String>()
    switch getSelectedPiece(square: square) {
    case "Wpawn":
      if pos.rank == 6 {
        if getSelectedPiece(square: getSquare(pos.rank - 2, pos.file)) == "" {
          arrPossibleMoves.insert(getSquare(pos.rank - 2, pos.file))
        }
      }
      if pos.rank - 1 >= 0 {
        if getSelectedPiece(square: getSquare(pos.rank - 1, pos.file)) == "" {
          arrPossibleMoves.insert(getSquare(pos.rank - 1, pos.file))
        }
        if pos.file - 1 >= 0 {
          if getSelectedPiece(square: getSquare(pos.rank - 1, pos.file - 1)).prefix(1)=="B" {
            arrPossibleMoves.insert(getSquare(pos.rank - 1, pos.file - 1))
          }
        }
        if pos.file + 1 <= 7 {
          if getSelectedPiece(square: getSquare(pos.rank - 1, pos.file + 1)).prefix(1)=="B" {
            arrPossibleMoves.insert(getSquare(pos.rank - 1, pos.file + 1))
          }
        }
      }
    case "Bpawn":
      if pos.rank == 1 {
        if getSelectedPiece(square: getSquare(pos.rank + 2, pos.file)) == "" {
          arrPossibleMoves.insert(getSquare(pos.rank + 2, pos.file))
        }
      }
      if pos.rank + 1 <= 7 {
        if getSelectedPiece(square: getSquare(pos.rank + 1, pos.file)) == "" {
          arrPossibleMoves.insert(getSquare(pos.rank + 1, pos.file))
        }
        if pos.file - 1 >= 0 {
          if getSelectedPiece(square: getSquare(pos.rank + 1, pos.file - 1)).prefix(1)=="W" {
            arrPossibleMoves.insert(getSquare(pos.rank + 1, pos.file - 1))
          }
        }
        if pos.file + 1 <= 7 {
          if getSelectedPiece(square: getSquare(pos.rank + 1, pos.file + 1)).prefix(1)=="W" {
            arrPossibleMoves.insert(getSquare(pos.rank + 1, pos.file + 1))
          }
        }
      }
    case let sq where sq.contains("king"):
      if pos.rank - 1 >= 0 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank - 1, pos.file)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank - 1, pos.file)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank-1, pos.file)).prefix(1)=="" {
          arrPossibleMoves.insert(getSquare(pos.rank - 1, pos.file))
        }
      }
      if pos.rank - 1 >= 0 && pos.file - 1 >= 0 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank - 1, pos.file-1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank - 1, pos.file-1)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank-1, pos.file-1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank - 1, pos.file - 1))
        }
      }
      if pos.rank - 1 >= 0 && pos.file + 1 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank - 1, pos.file+1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank - 1, pos.file+1)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank-1, pos.file+1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank - 1, pos.file + 1))
        }
      }
      if pos.rank + 1 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+1, pos.file)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+1, pos.file)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank+1, pos.file)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank + 1, pos.file))
        }
      }
      if pos.file - 1 >= 0 && pos.rank + 1 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank + 1, pos.file-1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank + 1, pos.file-1)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank+1, pos.file-1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank + 1, pos.file - 1))
        }
      }
      if pos.file + 1 <= 7 && pos.rank + 1 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank + 1, pos.file+1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank + 1, pos.file+1)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank+1, pos.file+1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank + 1, pos.file + 1))
        }
      }
      if pos.file - 1 >= 0 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank, pos.file-1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank, pos.file-1)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank, pos.file-1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank, pos.file - 1))
        }
      }
      if pos.file + 1 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank, pos.file+1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank, pos.file+1)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank, pos.file+1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank, pos.file + 1))
        }
      }
      // Filtrage afin d'emêcher les rois de se suicider
      /*arrPossibleMoves = getKingPossibleMoves(Array(arrPossibleMoves),String(getSelectedPiece(square:getSquare(pos.rank, pos.file)).prefix(1)))*/
    case let sq where sq.contains("rook"):
      
      for i in 0...7 {
        if pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank, pos.file + i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank, pos.file + i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank, pos.file + i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank, pos.file + i)).prefix(1)=="B")){
            arrPossibleMoves.insert(getSquare(pos.rank, pos.file + i))
            break
          }
          else if(getSquare(pos.rank, pos.file + i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.file-i>=0 {
          if getSelectedPiece(square:getSquare(pos.rank, pos.file - i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank, pos.file - i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank, pos.file-i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank, pos.file-i)).prefix(1)=="B")){
            arrPossibleMoves.insert(getSquare(pos.rank, pos.file - i))
            break
          }
          else if(getSquare(pos.rank, pos.file-i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file))==""{
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file)).prefix(1)=="B")) {
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file))
            break
          }
          else if(getSquare(pos.rank+i, pos.file) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file))==""{
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file))
          }
            else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file))=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file)).prefix(1)=="B")){
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file))
            break
          }
          else if(getSquare(pos.rank-i, pos.file) != square){
            break
          }
        }
      }
    case let sq where sq.contains("bishop"):
      for i in 0...7 {
        if pos.rank + i <= 7 && pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file+i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file+i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file+i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file+i)).prefix(1)=="B")) {
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file+i))
            break
          }
          else if(getSquare(pos.rank+i, pos.file+i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 && pos.file - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file-i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file-i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file-i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file-i)).prefix(1)=="B")) {
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file-i))
            break
          }
          else if(getSquare(pos.rank-i, pos.file-i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 && pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file+i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file+i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file+i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file+i)).prefix(1)=="B")) {
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file+i))
            break
          }
          else if(getSquare(pos.rank-i, pos.file+i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 && pos.file - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file-i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file-i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file-i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file-i)).prefix(1)=="B")) {
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file-i))
            break
          }
          else if(getSquare(pos.rank+i, pos.file-i) != square){
            break
          }
        }
      }
    case let sq where sq.contains("queen"):
     for i in 0...7 {
        if pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank, pos.file + i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank, pos.file + i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank, pos.file + i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank, pos.file + i)).prefix(1)=="B")) {
            arrPossibleMoves.insert(getSquare(pos.rank, pos.file + i))
            break
          }
          else if(getSquare(pos.rank, pos.file + i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.file-i>=0 {
          if getSelectedPiece(square:getSquare(pos.rank, pos.file - i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank, pos.file - i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank, pos.file-i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank, pos.file-i)).prefix(1)=="B")) {
            arrPossibleMoves.insert(getSquare(pos.rank, pos.file - i))
            break
          }
          else if(getSquare(pos.rank, pos.file-i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file))==""{
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file)).prefix(1)=="B")){
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file))
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file))==""{
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file))
          }
            else if((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file))=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file)).prefix(1)=="B")){
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file))
            break
          }
          else if(getSquare(pos.rank-i, pos.file) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 && pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file+i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank + i, pos.file + i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file+i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file+i)).prefix(1)=="B")){
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file+i))
            break
          }
          else if(getSquare(pos.rank+i, pos.file+i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 && pos.file - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file-i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file-i))
          }
          else if ((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file-i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file-i)).prefix(1)=="B")) {
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file-i))
            break
          }
          else if(getSquare(pos.rank-i, pos.file-i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank - i >= 0 && pos.file + i <= 7 {
          if getSelectedPiece(square:getSquare(pos.rank-i, pos.file+i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file+i))
          }
          else if((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file+i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-i, pos.file+i)).prefix(1)=="B")){
            arrPossibleMoves.insert(getSquare(pos.rank-i, pos.file+i))
            break
          }
          else if(getSquare(pos.rank-i, pos.file+i) != square){
            break
          }
        }
      }
      for i in 0...7 {
        if pos.rank + i <= 7 && pos.file - i >= 0 {
          if getSelectedPiece(square:getSquare(pos.rank+i, pos.file-i))==""{
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file-i))
          }
          else if((sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file-i)).prefix(1)=="W") || (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+i, pos.file-i)).prefix(1)=="B")){
            arrPossibleMoves.insert(getSquare(pos.rank+i, pos.file-i))
            break
          }
          else if(getSquare(pos.rank+i, pos.file-i) != square){
            break
          }
        }
      }
    case let sq where sq.contains("knight"):
      if pos.file - 1 >= 0 && pos.rank + 2 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+2, pos.file-1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+2, pos.file-1)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank+2, pos.file-1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank + 2, pos.file - 1))
        }
      }
      if pos.file + 1 <= 7 && pos.rank + 2 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+2, pos.file+1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+2, pos.file+1)).prefix(1)=="W") ||
          getSelectedPiece(square:getSquare(pos.rank+2, pos.file+1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank + 2, pos.file + 1))
        }
      }
      if pos.rank - 2 >= 0 && pos.file + 1 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-2, pos.file+1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-2, pos.file+1)).prefix(1)=="W")  || getSelectedPiece(square:getSquare(pos.rank-2, pos.file+1)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank - 2, pos.file + 1))
        }
      }
      if pos.rank - 2 >= 0 && pos.file - 1 >= 0 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-2, pos.file-1)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-2, pos.file-1)).prefix(1)=="W")  || getSelectedPiece(square:getSquare(pos.rank-2, pos.file-1)).prefix(1)=="" {
          arrPossibleMoves.insert(getSquare(pos.rank - 2, pos.file - 1))
        }
      }
      if pos.rank - 1 >= 0 && pos.file + 2 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-1, pos.file+2)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-1, pos.file+2)).prefix(1)=="W")  || getSelectedPiece(square:getSquare(pos.rank-1, pos.file+2)).prefix(1)=="" {
          arrPossibleMoves.insert(getSquare(pos.rank - 1, pos.file + 2))
        }
      }
      if pos.rank + 1 <= 7 && pos.file + 2 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+1, pos.file+2)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+1, pos.file+2)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank+1, pos.file+2)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank + 1, pos.file + 2))
        }
      }
      if pos.file - 2 >= 0 && pos.rank + 1 <= 7 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank+1, pos.file-2)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank+1, pos.file-2)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank+1, pos.file-2)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank + 1, pos.file - 2))
        }
      }
      if pos.file - 2 >= 0 && pos.rank - 1 >= 0 {
        if (sq.prefix(1)=="W" && getSelectedPiece(square:getSquare(pos.rank-1, pos.file-2)).prefix(1)=="B") || (sq.prefix(1)=="B" && getSelectedPiece(square:getSquare(pos.rank-1, pos.file-2)).prefix(1)=="W") || getSelectedPiece(square:getSquare(pos.rank-1, pos.file-2)).prefix(1)==""{
          arrPossibleMoves.insert(getSquare(pos.rank - 1, pos.file - 2))
        }
      }
    default: break
    }
    // Une pièce ne peut pas faire du sur place
    arrPossibleMoves.remove(square)

    // Afin de restreindre les pièces clouées
    return filterKingVulnerableMoves(square:square,moves:arrPossibleMoves)
  }

  // Permet de restreindre d'avantage les cases possibles du roi, afin qu'il ne puisse pas se suicider
  // Le principe est le suivant, en fonction de la couleur du roi, on va vérifier les carrés attaquables par les pièces ennemies, si elles correspondent à l'une des cases accessibles par le roi, on l'enlève des possibilités
/*  func getKingPossibleMoves(_ kingFreeSquares:[String],_ color:String)->Set<String>{
    var targetedKingSquares = Set<String>()
    var arrKingFinalMoves = Set<String>()
    if color=="W" {
      for (rank,file) in self.piecesCoordsBlack{
        //if getSelectedPiece(square:getSquare(rank,file)) != "Wking" {
          targetedKingSquares.formUnion(getTargetedSquares(square:getSquare(rank,file)))
        //}
      }
    }
    if color=="B" {
      for (rank,file) in self.piecesCoordsWhite{
        //if getSelectedPiece(square:getSquare(rank,file)) != "Bking" {
          targetedKingSquares.formUnion(getTargetedSquares(square:getSquare(rank,file)))
        //}
      }
    }
    arrKingFinalMoves.formUnion(kingFreeSquares.filter{ !targetedKingSquares.contains($0) })
    return arrKingFinalMoves
  }*/

  // Permet de vérifier si le roi est actuellement attaqué ou non
  //on vérifie si la coordonnée actuelle du roi est directement attaquée par une pièce ennemie
  func isChecked(color:String)->Bool {
    var checked = false
    if color=="W" {
      if let index = self.kingCoordsWhite {
        for (r,f) in self.piecesCoordsBlack {
          if getTargetedSquares(square:getSquare(r,f)).contains(getSquare(index.rank,index.file)){
            checked = true
          }
        }
      }
    }
    if color=="B" {
      if let index = self.kingCoordsBlack {
        for (r,f) in self.piecesCoordsWhite {
          if getTargetedSquares(square:getSquare(r,f)).contains(getSquare(index.rank,index.file)) {
            checked = true
          }
        }
      }
    }
    return checked
  }

  // Fonction permettant de restreindre les mouvements des pièces alliées afin qu'elle ne puisse pas laisser leurs rois vulnérable volontairement
  // On prend une "photo" de l'échiquier et des positions actuelle pour chaque déplacement possible on le joue sur l'échiquier, si ce déplacement ne met pas le roi de la même couleur en échec, on l'ajoute au moves possibles après filtrage de pièces clouées, puis on rollback (on revient à la position initiale de l'échiquier avant les calculs de pièces mettant le roi allié en échec ou non)
  func filterKingVulnerableMoves(square:String,moves:Set<String>)-> Set<String>{
    var movesFinal = Set<String>()
    self.currentFenCode = self.exportFENCode(colorTurn:Character(self.colorTurn),castles:self.castles,en_passant:self.en_passant)
    self.currentPiecesBlackCoords = self.piecesCoordsBlack
    self.currentPiecesWhiteCoords = self.piecesCoordsWhite
    let color = String(getSelectedPiece(square:square).prefix(1))
    for move in moves {
      print(getSelectedPiece(square:move).prefix(1))
      if color != String(getSelectedPiece(square:move).prefix(1)) && getSelectedPiece(square:move) != "" {
        capture(square:move,color:color)
      }
      updatePosition(square:square,color:color,pos:getRelativePos(move),piece:getSelectedPiece(square:square))

      if !isChecked(color:color){
        movesFinal.insert(move)
        print(move)
      }
      rollback()
    }
    return movesFinal
  }

  // Fonction permettant de déplacer une pièce sur l'échiquier interne et de conserver le code du déplacement réalisé puis laisser le tour à l'adversaire
  func playMove(start:String,destination:String){
    self.startSquare = start
    self.destinationSquare = destination

    // Fonction permettant de sauvergarder le code de la solution
    self.recordSequence()
    self.changeColorTurn()
  }

  // Permet de déterminer si la position actuelle est légale pour commencer un enregistrement des coups de la solution
  func startSequence()->String{
    // Il faut au moins les deux rois adverses sur l'échiquier
    if self.kingCoordsWhite == nil || self.kingCoordsWhite == nil {
      return "Il faut au moins un roi blanc et un roi noir pour démarrer l'enregistrement"
    }
    // Il ne faut pas que le roi soit menacé par les pièces ennemies dès le début avec ces mêmes pièces ennemies commençant le puzzle (elles pourraient juste capturer le roi)
    else if isChecked(color:"W") && colorTurn=="b"{
        return "Les noirs ne peuvent pas commencer, le roi blanc est attaqué"
    }
    else if isChecked(color:"B") && colorTurn=="w"{
      return "Les blancs ne peuvent pas commencer, le roi noir est attaqué"
    }
    // Si les critères sont validés, on peut commencer l'enregistrement
    else {
      self.isRecording = true
      print("Commencement de l'enregistrement")
      return "Success"
    }
  }
  // Afin de laisser le tour à l'adversaire après le coup joué
  func changeColorTurn() {
    self.colorTurn = (self.colorTurn=="w") ? "b" : "w"
  }
  
  // Actualise le tour joué sur l'échiquier et sur la position des pièces
  func updatePosition(square:String,color:String,pos:(rank:Int,file:Int),piece:String){
      if color=="W" && !piece.contains("king"){
        if let index = self.piecesCoordsWhite.firstIndex(where: { $0.rank == getRelativePos(square).rank && $0.file == getRelativePos(square).file }) {
            self.piecesCoordsWhite[index] = pos
        }
      }
      else if color=="W" && piece.contains("king"){
         self.kingCoordsWhite = pos
      }
      if color=="B" && !piece.contains("king"){
        if let index = self.piecesCoordsBlack.firstIndex(where: { $0.rank == getRelativePos(square).rank && $0.file == getRelativePos(square).file }) {
            self.piecesCoordsBlack[index] = pos
        }
      }
      else if color=="B" && piece.contains("king"){
         self.kingCoordsBlack = pos
      }
    board[getRelativePos(square).rank][getRelativePos(square).file] = ""
    board[pos.rank][pos.file] = piece
  }
  
  // Supprime le tuple du tableau de coordonnée associé, si la pièce ennemie a capturé la pièce
  func capture(square:String,color:String){
      if color=="W"{
        if let index = self.piecesCoordsBlack.firstIndex(where: {$0.rank == getRelativePos(square).rank && $0.file == getRelativePos(square).file}){
          self.piecesCoordsBlack.remove(at:index)
        }
      }
      if color=="B"{
        if let index = self.piecesCoordsWhite.firstIndex(where: {$0.rank == getRelativePos(square).rank && $0.file == getRelativePos(square).file}){
          self.piecesCoordsWhite.remove(at:index)
        }
      }
  }

  // Permet de revenir à la position avant les calculs de mouvements de pièce alliées mettant le roi de la même couleur en échec
  func rollback(){
    self.importFENcode(FENcode:self.currentFenCode)
    self.piecesCoordsBlack = self.currentPiecesBlackCoords
    self.piecesCoordsWhite = self.currentPiecesWhiteCoords
  }

  // Fonction enregistrant le code de la solution
  func recordSequence(){
    var pieceCode = ""
    var notationBit = ""
      // On restreint un puzzle à 7 séquence maximum
      if self.notationCode.split(separator: "/").count <= 7 {
          // Si les noirs commencent les blancs ont comme début "-"
          if self.notationCode == "" && self.colorTurn=="b" {
              notationBit = " - "
          }
          // Quand c'est un mouvement de pion, on spécifie juste sa colonne
          if getSelectedPiece(square:self.startSquare).contains("pawn"){
              pieceCode = String(self.startSquare.prefix(1))
          }
          // Quand c'est un mouvement de cavalier, on spécifie N avant les déplacements
          else if getSelectedPiece(square:self.startSquare).contains("knight"){
              pieceCode = "N"
          }
          else {
              // La première lettre des autres pièces respecte la notation
              let piece = getSelectedPiece(square:self.startSquare)
              pieceCode = String(piece[piece.index(piece.startIndex,offsetBy:1)]).uppercased()
          }
            // S'il n'y a pas de pièce capturée, on note juste la première lettre du code de la pièce suivie par sa case de départ et de fin
          if getSelectedPiece(square:self.destinationSquare)=="" {
              notationBit += "\(pieceCode)\(self.startSquare.lowercased())\(self.destinationSquare.lowercased())"
          }
            // Sinon c'est la première lettre + case de départ + "x" + sa case de fin
          else {
              notationBit += "\(pieceCode)\(self.startSquare.lowercased())x\(self.destinationSquare.lowercased())"
              capture(square:self.destinationSquare,color:String(getSelectedPiece(square:self.startSquare).prefix(1)))
          }
            //Si les rois sont mis en échec, à la fin du code, il y aura un "+"
          if getSelectedPiece(square:self.startSquare).prefix(1)=="W" {
              updatePosition(square:self.startSquare,color:"W",pos:getRelativePos(self.destinationSquare),piece:getSelectedPiece(square:self.startSquare))
              if isChecked(color:"B"){
                  notationBit += "+"
              }
          }
          if getSelectedPiece(square:self.startSquare).prefix(1)=="B" {
              updatePosition(square:self.startSquare,color:"B",pos:getRelativePos(self.destinationSquare),piece:getSelectedPiece(square:self.startSquare))
              if isChecked(color:"W"){
                  notationBit += "+"
              }
          }
          if notationBit != "" {
              self.notationCode += "\(notationBit) "
          }
          if self.notationCode.split(separator:" ").count % 2 == 0{
              self.notationCode += "/"
          }
      }
  }
  func loadInitialBoard() {
      self.importFENcode(FENcode:"rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w - -")
  }
/*  func cleanCode(){
    if self.notationCode.split(separator:"/").last!.split(separator:" ").count==1 {
      self.notationCode += "- "
    }
    var cleanCode = ""
    for item in self.notationCode.split(separator:"/"){
        cleanCode += "\(item.dropLast())/"
    }
    self.notationCode = cleanCode
  }*/
  // Le notationCode est juste pour l'utilisateur, on se contentera d'un code plus simple de notre côté stockant juste le mouvement de départ puis le mouvement de fin suivi d'un "|" pour obtenir le mouvement de l'adversaire suivi par un "/" pour changer de séquence. (cela nous est égal de savoir quelle pièce est présente sur quelle case, s'il y a eu une capture, ou si le roi est en échec)
  func getInternalCode()->String{
    var code = self.notationCode.filter({ char in
        return !char.isUppercase && char != "x" && char != "+"})
    code = code.trimmingCharacters(in: .whitespacesAndNewlines)
    code = code.replacingOccurrences(of:" /",with:"/")
    code = code.replacingOccurrences(of:" ",with:"|")

    // Si les noirs commmencent les blancs ont comme code "-" au premier tour
    /*if self.initcolorTurn == "b" {
      code = "- \(code)"
    }*/
    // S'il n'y a pas le dernier mouvement des noirs, on finit par "-" comme dernier mouvement
    if code.split(separator:"/").last!.split(separator:"|").count==1 {
      code += "|- "
    }
      return code.trimmingCharacters(in: .whitespaces)
  }
}
