import CoreBluetooth
import CoreBluetoothTestable


public class StubService: ServiceProtocol {
    public var uuid: CBUUID
    public var peripheral: CBPeripheral?
    public var isPrimary: Bool
    public var includedServices: [CBService]?
    public var characteristics: [CBCharacteristic]?
    public var _wrapped: CBService? = nil
    
    
    public init(
        uuid: CBUUID = CBUUID(nsuuid: StubUUID.zero),
        peripheral: CBPeripheral? = nil,
        isPrimary: Bool = false,
        includedServices: [CBService]? = nil,
        characteristics: [CBCharacteristic]? = nil
    ) {
        self.uuid = uuid
        self.peripheral = peripheral
        self.isPrimary = isPrimary
        self.includedServices = includedServices
        self.characteristics = characteristics
    }
}
