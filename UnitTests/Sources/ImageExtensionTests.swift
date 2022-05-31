//
//  ImageExtensionTests.swift
//  UnitTests
//
//  Created by Ismail on 31.05.2022.
//  Copyright © 2022 element.io. All rights reserved.
//

import XCTest
@testable import ElementX

class ImageExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageAnonymizationConfidenceLevel() async throws {
        let image = Asset.Images.sampleScreenshot.image

        let anonymized0_5 = try await image.anonymized()
        let anonymized0_1 = try await image.anonymized(confidenceLevel: 0.1)

        //  comparing colors is a complicated process, just compare images for now
        XCTAssertNotEqual(image, anonymized0_5)
        XCTAssertNotEqual(anonymized0_1, anonymized0_5)
    }

    func testImageAnonymizationFillColor() async throws {
        let image = Asset.Images.sampleScreenshot.image

        let anonymizedRed = try await image.anonymized()
        let anonymizedBlue = try await image.anonymized(fillColor: .blue)

        //  comparing colors is a complicated process, just compare images for now
        XCTAssertNotEqual(image, anonymizedRed)
        XCTAssertNotEqual(anonymizedBlue, anonymizedRed)
    }

}
