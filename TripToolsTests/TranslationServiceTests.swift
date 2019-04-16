//
//  TranslationServiceTests.swift
//  TripToolsTests
//
//  Created by Thomas Bouges on 2019-04-16.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import XCTest

@testable import TripTools

class TranslationServiceTests: XCTestCase {
    
    func testGetTranslationShouldPostFailedCallback() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(data: nil, response: nil, error: FakeGoogleTranslateResponseData.error)) 
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation{ (success, translationData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation{ (success, translationData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(data: nil, response: FakeGoogleTranslateResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation{ (success, translationData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    func testGetTranslationShouldPostFailedCallbackIfStatusTResponseIsfivehundred() {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(data: FakeGoogleTranslateResponseData.responseCorrectData, response: FakeGoogleTranslateResponseData.responseNot, error: nil))
        translationService.updateData(langageFrom: "en", langageTo: "es", text: "hi")
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        translationService.getTranslation{ (success, translationData) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData()  {
        // Given
        let translationService = TranslationService(translationSession: URLSessionFake(data: FakeGoogleTranslateResponseData.responseCorrectData, response: FakeGoogleTranslateResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation{ (success, translationData) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translationData)
            
            
            let translation = translationData?.data.translations[0].translatedText 
           
            
            
            XCTAssertEqual(translation, "Hola")
           
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
}
