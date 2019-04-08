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

        let scriptPubKey = scriptPubKey as NSData
        let scriptPubKeyBytes = scriptPubKey.bytes.assumingMemoryBound(to: UInt8.self)
        let scriptPubKeyLen = UInt32(scriptPubKey.count)

        let txTo = txTo as NSData
        let txToBytes = txTo.bytes.assumingMemoryBound(to: UInt8.self)
        let txToLen = UInt32(txTo.count)

        var err = bitcoinconsensus_error(rawValue: 0)

        let result = bitcoinconsensus_verify_script(scriptPubKeyBytes, scriptPubKeyLen, txToBytes, txToLen, nIn, flags, &err) == 1

        return (result, BitcoinConsensusError(rawValue: err.rawValue)!)
    }
}
