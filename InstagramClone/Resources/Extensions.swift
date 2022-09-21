//
//  Extensions.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/15.
//

import Foundation
import UIKit

extension UIView{
    var top : CGFloat{
        frame.origin.y
    }
    
    var bottom : CGFloat{
        frame.origin.y + height
    }
    
    var left : CGFloat{
        frame.origin.x
    }
    
    var right : CGFloat{
        frame.origin.x + width
 
    }
    
    var width : CGFloat{
        frame.size.width
    }
    
    var height : CGFloat{
        frame.size.height
    }
}

extension Decodable{
    init?(with dictonary: [String:Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dictonary, options: .prettyPrinted) else {
            return nil
        }
        guard let result = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }        
        self = result
    }
}

extension Encodable {
    func asDictonary() -> [String:Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
        return json
    }
}

extension DateFormatter {
    static let formatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}


extension String {
    static func data(from date : Date) -> String? {
        let formatter = DateFormatter.formatter
        let string = formatter.string(from: date)
        return string
    }
}
