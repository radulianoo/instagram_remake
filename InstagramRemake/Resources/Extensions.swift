//
//  Extensions.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 27.03.2023.
//

import Foundation
import UIKit

extension UIView {
    
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        frame.origin.y + height
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var right: CGFloat {
        frame.origin.x + width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var width: CGFloat {
        frame.size.width
    }
    
}
