//
//  ScreenIdentifier.swift
//  ElementX
//
//  Created by Ismail on 21.06.2022.
//  Copyright © 2022 Element. All rights reserved.
//

import Foundation

enum UITestScreenIdentifier: String {
    case login
    case serverSelection
    case serverSelectionNonModal
    case authenticationFlow
    case simpleRegular
    case simpleUpgrade
    case settings
    case bugReport
    case bugReportWithScreenshot
    case splash
    case roomPlainNoAvatar
    case roomEncryptedWithAvatar
    case sessionVerification
}

extension UITestScreenIdentifier: CustomStringConvertible {
    var description: String {
        rawValue.titlecased()
    }
}

extension UITestScreenIdentifier: CaseIterable { }

private extension String {
    func titlecased() -> String {
        replacingOccurrences(of: "([A-Z])",
                             with: " $1",
                             options: .regularExpression,
                             range: range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
