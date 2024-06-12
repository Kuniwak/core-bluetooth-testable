import CoreBluetooth
import CoreBluetoothTestable


public class StubDescriptor: DescriptorProtocol {
    public var uuid: CBUUID
    public var characteristic: (any CharacteristicProtocol)?
    public var value: Any?
    public var _wrapped: CBDescriptor? = nil
    
    
    public init(
        uuid: CBUUID = CBUUID(nsuuid: StubUUID.zero),
        characteristic: (any CharacteristicProtocol)? = nil,
        value: Any? = nil
    ) {
        self.uuid = uuid
        self.characteristic = characteristic
        self.value = value
    }
}
