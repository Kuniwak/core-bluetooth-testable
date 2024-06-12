import CoreBluetooth
import CoreBluetoothTestable


public class StubCharacteristic: CharacteristicProtocol {
    public var uuid: CBUUID
    public var service: (any ServiceProtocol)?
    public var properties: CBCharacteristicProperties
    public var value: Data?
    public var descriptors: [any DescriptorProtocol]?
    public var isNotifying: Bool
    public var _wrapped: CBCharacteristic? = nil
    
    
    public init(
        uuid: CBUUID = CBUUID(nsuuid: StubUUID.zero),
        service: (any ServiceProtocol)? = nil,
        properties: CBCharacteristicProperties = [],
        value: Data? = nil,
        descriptors: [any DescriptorProtocol]? = nil,
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
