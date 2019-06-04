import Foundation
import XCTest
import PackStream

@testable import Bolt

class EncryptedSocketTests: XCTestCase {

    var socketTests: SocketTests?



    override func setUp() {
        self.continueAfterFailure = false
        super.setUp()

        do {
            let config = TestConfig.loadConfig()
            let socket = try EncryptedSocket(hostname: config.hostname, port: config.port)
            let settings = ConnectionSettings(username: config.username, password: config.password, userAgent: "BoltTests")
            self.socketTests = SocketTests(socket: socket, settings: settings)

        } catch {
            XCTFail("Cannot have exceptions during socket initialization")
        }
    }

    static var allTests: [(String, (EncryptedSocketTests) -> () throws -> Void)] {
        return [
//            ("testMichaels100k", testMichaels100k),
//            ("testMichaels100kCannotFitInATransaction", testMichaels100kCannotFitInATransaction),
            ("testRubbishCypher", testRubbishCypher),
            ("testUnwind", testUnwind),
            ("testUnwindWithToNodes", testUnwindWithToNodes),
        ]
    }

    /*
    func testMichaels100k() throws {
        XCTAssertNotNil(socketTests)
        try socketTests?.templateMichaels100k()
    }

    func testMichaels100kCannotFitInATransaction() throws {
        XCTAssertNotNil(socketTests)
        try socketTests?.templateMichaels100kCannotFitInATransaction()
    }
    */

    func testRubbishCypher() throws {
        XCTAssertNotNil(socketTests)
        try socketTests?.templateRubbishCypher()
    }

    func testUnwind() throws {
        XCTAssertNotNil(socketTests)

        let exp = expectation(description: "\(#function)\(#line)")
        
        DispatchQueue.global(qos: .background).async {
            try! self.socketTests?.templateUnwind()
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 40, handler: nil)
    }

    func testUnwindWithToNodes() throws {
        XCTAssertNotNil(socketTests)
        try socketTests?.templateUnwindWithToNodes()
    }

}
