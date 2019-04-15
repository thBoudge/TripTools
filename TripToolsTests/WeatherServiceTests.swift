//
//  WeatherServiceTests.swift
//  TripToolsTests
//
//  Created by Thomas Bouges on 2019-04-15.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import XCTest

@testable import TripTools

class WeatherServiceTests: XCTestCase {
    
    func testGetWeatherShouldPostFailedCallback() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: FakeWeatherResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        weatherService.updateDate(name: "bogota")
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
       weatherService.getWeather  { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: FakeWeatherResponseData.responseOk, error: nil))
       
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
        

    }
    
    func testGetWeatherShouldPostFailedCallbackIfStatusTResponseIsfivehundred() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeWeatherResponseData.responseCorrectData, response: FakeWeatherResponseData.responseNot, error: nil))
        weatherService.updateData(latitude: "13.08", longitude: "-51.087")
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        weatherService.getWeather { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.01)
        
        
    }
    
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData()  {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: FakeWeatherResponseData.responseCorrectData, response: FakeWeatherResponseData.responseOk, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { (success, weather) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            
            
            let cityName = weather?.name
            let temperature = weather?.main.temp
            
            
            XCTAssertEqual(cityName, "San Francisco")
            XCTAssertEqual(temperature, 288.21)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testupdateWeatherImageShouldReturnImageNamedependingofInt()  {
        // Given
        let weatherService = WeatherService()
        var imageName = weatherService.updateWeatherImage(condition: 150)
        XCTAssertEqual(imageName, "tstorm1")
        imageName = weatherService.updateWeatherImage(condition: 450)
        XCTAssertEqual(imageName, "light_rain")
        imageName = weatherService.updateWeatherImage(condition: 550)
        XCTAssertEqual(imageName, "shower3")
        imageName = weatherService.updateWeatherImage(condition: 650)
        XCTAssertEqual(imageName, "snow4")
        imageName = weatherService.updateWeatherImage(condition: 750)
        XCTAssertEqual(imageName, "fog")
        imageName = weatherService.updateWeatherImage(condition: 778)
        XCTAssertEqual(imageName, "tstorm3")
        imageName = weatherService.updateWeatherImage(condition: 800)
        XCTAssertEqual(imageName, "sunny")
        imageName = weatherService.updateWeatherImage(condition: 802)
        XCTAssertEqual(imageName, "cloudy2")
        imageName = weatherService.updateWeatherImage(condition: 902)
        XCTAssertEqual(imageName, "tstorm3")
        imageName = weatherService.updateWeatherImage(condition: 903)
        XCTAssertEqual(imageName, "snow5")
        imageName = weatherService.updateWeatherImage(condition: 904)
        XCTAssertEqual(imageName, "sunny")
        imageName = weatherService.updateWeatherImage(condition: 1500)
        XCTAssertEqual(imageName, "dunno")
        
    }
    
    
}
