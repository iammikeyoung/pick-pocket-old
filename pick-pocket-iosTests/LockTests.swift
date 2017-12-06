//
//  LockTests.swift
//  pick-pocket-ios
//
//  Created by Nicholas Servidio on 1/7/17.
//
//

import XCTest
@testable import pick_pocket_ios

class LockTests: XCTestCase {
    func testCorrectGuess() {
        let sut = Lock(code: "123")
        let result = sut.submit(guess: "123")
        XCTAssertEqual(result.correct, 3)
        XCTAssertEqual(result.misplaced, 0)
    }

    func testOneCorrectOneMisplaced() {
        let sut = Lock(code: "123")
        let result = sut.submit(guess: "134")
        XCTAssertEqual(result.correct, 1)
        XCTAssertEqual(result.misplaced, 1)
    }

    func testOneMisplaced() {
        let sut = Lock(code: "123")
        let result = sut.submit(guess: "414")
        XCTAssertEqual(result.correct, 0)
        XCTAssertEqual(result.misplaced, 1)
    }

    func testNoneCorrect() {
        let sut = Lock(code: "123")
        let result = sut.submit(guess: "456")
        XCTAssertEqual(result.correct, 0)
        XCTAssertEqual(result.misplaced, 0)
    }

    func testDuplicatesGuess() {
        let sut = Lock(code: "123")
        let result = sut.submit(guess: "122")
        XCTAssertEqual(result.correct, 2)
        XCTAssertEqual(result.misplaced, 0)
    }

    func testPrecedence() {
        let sut = Lock(code: "123")
        let result = sut.submit(guess: "114")
        XCTAssertEqual(result.correct, 1)
        XCTAssertEqual(result.misplaced, 0)
    }

    func testDuplicatesCode() {
        let sut = Lock(code: "2245")
        let result = sut.submit(guess: "1122")
        XCTAssertEqual(result.correct, 0)
        XCTAssertEqual(result.misplaced, 2)
    }

    func testMultiplesMisplaced() {
        let sut = Lock(code: "323")
        let result = sut.submit(guess: "232")
        XCTAssertEqual(result.correct, 0)
        XCTAssertEqual(result.misplaced, 2)
    }

    func testMultiplesMixed() {
        let sut = Lock(code: "323")
        let result = sut.submit(guess: "332")
        XCTAssertEqual(result.correct, 1)
        XCTAssertEqual(result.misplaced, 2)
    }
}
