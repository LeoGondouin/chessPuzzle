    //
    //  FENcodeValidator.swift
    //  chessPuzzle2
    //
    //  Created by Leo Gondouin on 17/04/2023.
    //
    import Foundation

    class FENcodeValidator {
      var FENcode: String
      enum Errors: String {
        case moreThan4Parts = "FENCode mal formaté (Il faut 4 parties)"
        case regexp1stPart =
          "La première partie de votre FENcode contient des caractères non référencés"
        case rank1stPart = "Il y a plus de lignes référencées que de lignes existantes sur un échequier"
        case files1stPart =
          "Une ligne référencie des pièces posées après le nombre de cases d'un échéquier pour une ligne"
        case regexp2ndPart =
          "La deuxième partie de votre FENcode contient des caractères non référencés"
        case regexp3rdPart =
          "La troisième partie de votre FENcode contient des caractères non référencés"
        case regexp4thPart =
          "La quatrième partie de votre FENcode contient des caractères non référencés"
      }

      init(FENcode: String) {
        self.FENcode = FENcode
      }

      func checkIntegrity() -> String {
        if FENcode.split(separator: " ").count != 4 {
          return "(ERREUR) \(Errors.moreThan4Parts.rawValue)"
        }
        let pos = FENcode.split(separator: " ")[0]
        let colorTurn = FENcode.split(separator: " ")[1]
        let castles = FENcode.split(separator: " ")[2]
        let en_passant = FENcode.split(separator: " ")[3]

        let allowedCharsPattern1st = "^[rRnNbBqQkKpP1-8/\\/]+$"
        let regex1st = try! NSRegularExpression(pattern: allowedCharsPattern1st, options: [])
        let range1st = NSRange(location: 0, length: pos.utf16.count)
        let matches1st = regex1st.matches(in: String(pos), options: [], range: range1st)
        if matches1st.count <= 0 {
          return "(ERREUR) \(Errors.regexp1stPart.rawValue)"
        }

        let nbSlash = pos.components(separatedBy: "/").count - 1

        if nbSlash > 7 {
          return "(ERREUR) \(Errors.rank1stPart.rawValue)"
        }
        for elem in pos.split(separator: "/") {
          let somme =
            elem.filter { $0.isLetter }.count + elem.compactMap { $0.wholeNumberValue }.reduce(0, +)
          if somme > 8 {
            return "(ERREUR) \(Errors.files1stPart.rawValue)"
          }
        }
        let allowedCharsPattern2nd = "^[wb]+$"
        let regex2nd = try! NSRegularExpression(pattern: allowedCharsPattern2nd, options: [])
        let range2nd = NSRange(location: 0, length: colorTurn.utf16.count)
        let matches2nd = regex2nd.matches(in: String(colorTurn), options: [], range: range2nd)
        if matches2nd.count <= 0 {
          return "(ERREUR) \(Errors.regexp2ndPart.rawValue)"
        }
        let allowedCharsPattern3rd = "^[QqKk\\-]+$"
        let regex3rd = try! NSRegularExpression(pattern: allowedCharsPattern3rd, options: [])
        let range3rd = NSRange(location: 0, length: castles.utf16.count)
        let matches3rd = regex3rd.matches(in: String(castles), options: [], range: range3rd)
        if matches3rd.count <= 0 {
          return "(ERREUR) \(Errors.regexp3rdPart.rawValue)"
        }
        let allowedCharsPattern4th = "^([a-h][1-8])|\\-"
        let regex4th = try! NSRegularExpression(pattern: allowedCharsPattern4th, options: [])
        let range4th = NSRange(location: 0, length: en_passant.utf16.count)
        let matches4th = regex4th.matches(in: String(en_passant), options: [], range: range4th)
        if matches4th.count <= 0 {
          return "(ERREUR) L\(Errors.regexp4thPart.rawValue)"
        }
        return "Success"
      }
    }
