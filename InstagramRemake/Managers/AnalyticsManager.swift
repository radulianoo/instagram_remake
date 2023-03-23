//
//  AnalyticsManager.swift
//  InstagramRemake
//
//  Created by Octav Radulian on 22.03.2023.
//

import Foundation
import FirebaseAnalytics

final class AnalyticsManager {
    //singleton
    static let shared = AnalyticsManager()

    private init() {}
    
    func logEvent() {
        Analytics.logEvent("", parameters: [:])
    }

}
