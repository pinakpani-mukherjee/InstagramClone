//
//  AnalyticsManager.swift
//  InstagramClone
//
//  Created by Pinakpani Mukherjee on 2022/09/15.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager{
    static let shared = AnalyticsManager()
    
    private init() {}
    
    func logEvent(){
        Analytics.logEvent("", parameters: [:])
    }
    
}

