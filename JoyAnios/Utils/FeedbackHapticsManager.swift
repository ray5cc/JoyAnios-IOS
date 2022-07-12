//
//  FeedbackHapticsManager.swift
//  JoyAnios
//
//  Created by 武雷 on 2022/5/7.
//

import Foundation
import SwiftUI

struct FeedbackHapticsManager {
    // TODO: Using Core Haptics to emulate a more real sense
    // Refer: https://developer.apple.com/documentation/corehaptics

    public func trigger(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        // release
    }

}
