//
//  AltruisMazeTests.swift
//  AltruisMazeTests
//
//  Created by Bomar, Shawn L on 2/23/20.
//  Copyright © 2020 Bomar-Pradhan. All rights reserved.
//

import XCTest
@testable import AltruisMaze

class AltruisMazeTests: XCTestCase {

    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testplayerLoadSucceeds() {
        let testgoodPlayer = Player.init(name: "Hagi", tradePoints: 5, altruismPoints: 2)
        XCTAssertNotNil(testgoodPlayer)
    }
    
    func testplayerDataBad(){
        let testbadPlayer = Player.init(name: "Reggie", tradePoints: -2, altruismPoints: 0)
        XCTAssertNil(testbadPlayer)
    }
    
    func testplayerPointsGood(){
        let testgoodPlayer = Player.init(name: "Marco", tradePoints: 10, altruismPoints: 5)
        XCTAssertEqual(10, testgoodPlayer?.tradePoints)
    }
    
    func testplayerPointsBad(){
        let testbadPlayer = Player.init(name: "Polo", tradePoints: 7, altruismPoints: 3)
        XCTAssertNotEqual(25, testbadPlayer?.altruismPoints)
    }
    
    func testGoodKeyNaming(){
        let goodtestkey = DoorKey.init(color: "Green")
        var testing: Bool
        if(goodtestkey.name == "Green Key"){
            testing = true
        }
        else{
            testing = false
        }
        XCTAssertTrue(testing)
    }
    
    func testBadKeyNaming(){
        let badtestkey = DoorKey.init(color: "Blue")
        var testing: Bool
        if(badtestkey.name == "Red Key"){
            testing = true
        }
        else{
            testing = false
        }
        XCTAssertFalse(testing)
    }
    
    
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
