import XCTest
@testable import swiftLibconsensus

final class swiftLibconsensusTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swiftLibconsensus().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
