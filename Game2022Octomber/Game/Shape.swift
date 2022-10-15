//
//  Shape.swift
//  Game2022Octomber
//
//  Created by Dosi Dimitrov on 13.10.22.
//

import Foundation
import SwiftUI

struct RectangleElipse: Shape {

    func path(in rect: CGRect) -> Path {
        
        return Path { path in

            let topRadius = ((rect.maxX / 6) * 3 )

            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX - topRadius, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - topRadius, y: -topRadius),
                        radius: topRadius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 0),
                        clockwise: true)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxX ))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
  
        }
    }
}

struct RectangleTopElipse: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path { path in

            let topRadius = ((rect.maxX / 6) * 3 )
           
         
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY + topRadius))
            path.addArc(center: CGPoint(x: rect.maxX - topRadius , y:rect.maxY + topRadius ),
                       radius: topRadius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: -90),
                        clockwise: true)

            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY ))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.closeSubpath()
  
        }
    }
}


struct qestionShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            let radius = rect.maxX / 16
            let delta  = rect.maxX / 3
            
            path.move(to: CGPoint(x: 0, y: radius ))
            path.addArc(center: CGPoint(x: radius, y: radius),
                        radius: radius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: -90),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius ),
                        radius: radius,
                        startAngle: Angle(degrees: -90),
                        endAngle: Angle(degrees: 0),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius - delta))
            path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius - delta),
                        radius: radius,
                        startAngle: Angle(degrees: 0),
                        endAngle: Angle(degrees: 90),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX  - delta , y: rect.maxY  - delta))
            path.addLine(to: CGPoint(x: rect.midX   , y: rect.maxY + delta / 2  - delta))
            path.addLine(to: CGPoint(x: rect.minX  + delta  , y: rect.maxY  - delta ))
            path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius - delta),
                        radius: radius,
                        startAngle: Angle(degrees: 90),
                        endAngle: Angle(degrees: 180),
                        clockwise: false)
            path.closeSubpath()
        }
    }
}
