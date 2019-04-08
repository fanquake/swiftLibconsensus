import XCTest
import libbitcoinconsensus
@testable import swiftLibconsensus

final class swiftLibconsensusTests: XCTestCase {

    let tx: Data = Data(fromHexEncodedString: "01000000015884e5db9de218238671572340b207ee85b628074e7e467096c267266baf77a4000000006a4730440220340f35055aceb14250e4954b23743332f671eb803263f363d1d7272f1d487209022037a0eaf7cb73897ba9069fc538e7275c5ae188e934ae47ca4a70453b64fc836401210234257444bd3aead2b851bda4288d60abe34095a2a8d49aff1d4d19773d22b32cffffffff01a0860100000000001976a9147821c0a3768aa9d1a37e16cf76002aef5373f1a888ac00000000")!

    func testVersion() {
        XCTAssertEqual(swiftLibconsensus.version, UInt32(1))
    }

    func testVerify() {

        let scriptPubKey = Data(fromHexEncodedString: "76a9144621d47f08fcb1e6be0b91144202de7a186deade88ac")!

        let txTo = tx

        let nIn: UInt32 = 0
        let flags: UInt32 = 0

        let result = swiftLibconsensus.verifyScript(scriptPubKey: scriptPubKey, txTo: txTo, nIn: nIn, flags: flags)

        XCTAssertEqual(result.0, true)
        XCTAssertEqual(result.1, swiftLibconsensus.BitcoinConsensusError.ERR_OK)
    }

    func testDeserializeFail() {
        let scriptPubKey = Data(fromHexEncodedString: "76a9144621d47f08fcb1e6be0b91144202de7a186deade88ac")!

        let txTo = Data(fromHexEncodedString: "abcdef")!

        let nIn: UInt32 = 0
        let flags: UInt32 = 0

        let result = swiftLibconsensus.verifyScript(scriptPubKey: scriptPubKey, txTo: txTo, nIn: nIn, flags: flags)

        XCTAssertEqual(result.0, false)
        XCTAssertEqual(result.1, swiftLibconsensus.BitcoinConsensusError.ERR_TX_DESERIALIZE)
    }

    func testIndexOutOfRange() {
        let scriptPubKey = Data(fromHexEncodedString: "76a9144621d47f08fcb1e6be0b91144202de7a186deade88ac")!

        let txTo = tx

        let nIn: UInt32 = 999
        let flags: UInt32 = 0

        let result = swiftLibconsensus.verifyScript(scriptPubKey: scriptPubKey, txTo: txTo, nIn: nIn, flags: flags)

        XCTAssertEqual(result.0, false)
        XCTAssertEqual(result.1, swiftLibconsensus.BitcoinConsensusError.ERR_TX_INDEX)
    }

    static var allTests = [
        ("testVersion", testVersion),
        ("testVerify", testVerify),
        ("testDeserializeFail", testDeserializeFail),
        ("testIndexOutOfRange", testIndexOutOfRange)
    ]
}

extension Data {

    init?(fromHexEncodedString string: String) {

        // Convert 0 ... 9, a ... f, A ...F to their decimal value,
        // return nil for all other input characters
        func decodeNibble(u: UInt16) -> UInt8? {
            switch(u) {
            case 0x30 ... 0x39:
                return UInt8(u - 0x30)
            case 0x41 ... 0x46:
                return UInt8(u - 0x41 + 10)
            case 0x61 ... 0x66:
                return UInt8(u - 0x61 + 10)
            default:
                return nil
            }
        }

        self.init(capacity: string.utf16.count / 2)

        var even = true
        var byte: UInt8 = 0

        for c in string.utf16 {
            guard let val = decodeNibble(u: c) else { return nil }
            if even {
                byte = val << 4
            } else {
                byte += val
                self.append(byte)
            }
            even = !even
        }
        guard even else { return nil }
    }
}
