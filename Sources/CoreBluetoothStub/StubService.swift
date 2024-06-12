import CoreBluetooth
import CoreBluetoothTestable


public class StubService: ServiceProtocol {
    public var uuid: CBUUID
    public var peripheral: (any PeripheralProtocol)?
    public var isPrimary: Bool
    public var includedServices: [any ServiceProtocol]?
    public var characteristics: [any CharacteristicProtocol]?
    public var _wrapped: CBService? = nil
    
    
    public init(
        uuid: CBUUID = CBUUID(nsuuid: StubUUID.zero),
        peripheral: (any PeripheralProtocol)? = nil,
        isPrimary: Bool = false,
        includedServices: [any ServiceProtocol]? = nil,
        characteristics: [any CharacteristicProtocol]? = nil
    ) {
        self.uuid = uuid
        self.peripheral = peripheral
        self.isPrimary = isPrimary
        self.includedServices = includedServices
        self.characteristics = characteristics
    }
}
