//
//  TripToolsTests.swift
//  TripToolsTests
//
//  Created by Thomas Bouges on 2019-04-13.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import XCTest
@testable import TripTools

class DeviseServiceTests: XCTestCase {

    func testGetDeviseShouldPostFailedCallback() {
        // Given
        let deviseService = DeviseService(deviseSession: URLSessionFake(data: nil, response: nil, error: FakeFixerResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        deviseService.getDevise { (success, quote) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIfNoData() {
        // Given
        let deviseService = DeviseService(deviseSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        deviseService.getDevise { (success, quote) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }

    
    func testGetDeviseShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let deviseService = DeviseService(deviseSession: URLSessionFake(data: nil, response: FakeFixerResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        deviseService.getDevise { (success, quote) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(quote)
            
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIfStatusTResponseIsfivehundred() {
        // Given
        let deviseService = DeviseService(deviseSession: URLSessionFake(data: FakeFixerResponseData.responseCorrectData, response: FakeFixerResponseData.responseNot, error: nil))
        deviseService.changeSymbol(symbol: "EUR")
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        deviseService.getDevise{ (success, translationData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
     }
    
    func testGetDeviseShouldPostSuccessCallbackIfNoErrorAndCorrectData()  {
        
        
        // Given
        let deviseService = DeviseService(deviseSession: URLSessionFake(data: FakeFixerResponseData.responseCorrectData, response: FakeFixerResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        deviseService.getDevise { (success, quote) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(quote)
            
            
            let rate = 1.133498
            
            
            XCTAssertEqual(rate, quote!)
            
            
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

}
