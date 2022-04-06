//
//  CustomCorner.swift
//  UI-532
//
//  Created by nyannyan0328 on 2022/04/06.
//

import SwiftUI

struct CustomCorner: Shape{
    var coner : UIRectCorner
    var radi : CGFloat
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: coner, cornerRadii: CGSize(width: radi, height: radi))
        
        return Path(path.cgPath)
    }
}

