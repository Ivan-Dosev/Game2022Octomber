//
//  Bool+PipeRandom.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import Foundation
import CoreGraphics

extension Bool {
    
    static var pseudoRandomPipe: Bool {
        return CGFloat.range(min: 1.0, max: 2.0) <= 1.6
    }
}
