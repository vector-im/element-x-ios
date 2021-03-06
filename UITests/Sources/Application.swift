//
//  Application.swift
//  UITests
//
//  Created by Stefan Ceriu on 13/04/2022.
//  Copyright © 2022 Element. All rights reserved.
//

import XCTest

struct Application {
    static func launch() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchEnvironment = ["IS_RUNNING_UI_TESTS": "1"]
        app.launch()
        return app
    }
}

extension XCUIApplication {
    func goToScreenWithIdentifier(_ identifier: UITestScreenIdentifier) {
        let button = buttons[identifier.rawValue]
        let lastLabel = staticTexts["lastItem"]
        
        while !button.isHittable, !lastLabel.isHittable {
            tables.firstMatch.swipeUp()
        }
        
        button.tap()
    }
}
