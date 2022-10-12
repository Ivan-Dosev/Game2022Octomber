//
//  DeviceMotion.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import CoreMotion
import SwiftUI

 class MotionManager : ObservableObject {
 
     @Published var manager : CMMotionManager = .init()
     @Published var xValue : CGFloat = 0
 
     func detectMotion() {
       //  if !manager.isDeviceMotionActive {
             manager.deviceMotionUpdateInterval = 1/40
             manager.startDeviceMotionUpdates(to: .main) { [weak self] motion, err in
                 if let attitude = motion?.attitude{
                     self?.xValue = attitude.roll
                   //  print(attitude.roll)
                 }
             }
        // }
     }
     func stopMotionUpdate() {
         manager.stopDeviceMotionUpdates()
     }
 }
