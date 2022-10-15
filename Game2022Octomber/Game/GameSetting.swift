//
//  GameSetting.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import SwiftUI

class GameSetting : ObservableObject {
    
    @Published var PauseButton     : Bool = true
    @Published var settingButton   : Bool = false
    @Published var nameBackground   : String = "AcbrnqXoi"
    @Published var OnOffBackground   : Bool = false
    @Published var score : Int = 0
    @Published var reclama : Bool = false
    @Published var nameTransparency : BGSetting =  BGSetting.Ver
    @Published var startGame        : Bool = false
    @Published var soundOn          : Bool = true
    
}

enum BGSetting : String, CaseIterable, Identifiable {
 
    case Ver
    case VerA
    case VerB
    
    var id: String { return self.rawValue }
    
    func lineX() -> String {
        switch self {
            
        case .Ver:  return "ColorA"
        case .VerA: return "ColorC"
        case .VerB: return "ColorE"
        }
    }
    func lineY() -> String {
        switch self {
            
        case .Ver:  return "ColorB"
        case .VerA: return "ColorD"
        case .VerB: return "ColorF"
        }
    }
    
}

