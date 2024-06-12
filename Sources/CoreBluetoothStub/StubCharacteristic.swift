import CoreBluetooth
import CoreBluetoothTestable


public class StubCharacteristic: CharacteristicProtocol {
    public var uuid: CBUUID
    public var service: CBService?
    public var properties: CBCharacteristicProperties
    public var value: Data?
    public var descriptors: [CBDescriptor]?
    public var isNotifying: Bool
    public var _wrapped: CBCharacteristic? = nil
    
    
    public init(
        uuid: CBUUID = CBUUID(nsuuid: StubUUID.zero),
        service: CBService? = nil,
        properties: CBCharacteristicProperties = [],
        value: Data? = nil,
        descriptors: [CBDescriptor]? = nil,
        isNotifying: Bool = false
    ) {
        self.uuid = uuid
        self.service = service
        self.properties = properties
        self.value = value
        self.descriptors = descriptors
        self.isNotifying = isNotifying
    }
}
