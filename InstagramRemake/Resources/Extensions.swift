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

extension Decodable {
    init?(with dictionary: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) else {
            return nil
        }
        guard let result = try? JSONDecoder().decode(Self.self, from:  data) else {
            return nil
        }
        self = result
    }
}

// extension to leverage on codable when writing data on the database, no to create the redundant dictionary
//what is encodable it will be converted in a dictionary
extension Encodable {
    func asDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return json
    }
}


