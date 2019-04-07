import libbitcoinconsensus

public struct swiftLibconsensus {

    public static var version: UInt32 {
        return bitcoinconsensus_version()
    }
}
