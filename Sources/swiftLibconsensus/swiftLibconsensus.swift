import Foundation
import libbitcoinconsensus

public struct swiftLibconsensus {

    public static var version: UInt32 {
        return bitcoinconsensus_version()
    }

    public enum BitcoinConsensusError: UInt32 {
        case ERR_OK = 0
        case ERR_TX_INDEX
        case ERR_TX_SIZE_MISMATCH
        case ERR_TX_DESERIALIZE
        case ERR_AMOUNT_REQUIRED
        case ERR_INVALID_FLAGS
    }

    /**

     - Parameters:
        - scriptPubKey: previous unspent output script
        - txTo: serialized transaction spending an output
        - nIn: input index that is spending the scriptPubKey
        - flags:

    */
    public static func verifyScript(scriptPubKey: Data, txTo: Data, nIn: UInt32, flags: UInt32) -> (Bool, BitcoinConsensusError) {

        let scriptPubKey = pointerAndCount(data: scriptPubKey)
        let txTo = pointerAndCount(data: txTo)
        var err = bitcoinconsensus_error(rawValue: 0)

        let result = bitcoinconsensus_verify_script(scriptPubKey.pointer, scriptPubKey.count, txTo.pointer, txTo.count, nIn, flags, &err) == 1

        return (result, BitcoinConsensusError(rawValue: err.rawValue)!)
    }
}

extension swiftLibconsensus {

    static func pointerAndCount(data: Data) -> (pointer: UnsafePointer<UInt8>, count: UInt32) {

        let pointer = (data as NSData).bytes.assumingMemoryBound(to: UInt8.self)
        let count = UInt32(data.count)

        return (pointer, count)
    }
}
