import CoreBluetooth
import Logger


public protocol CharacteristicProtocol {
    // MARK: - Properties from CBAttribute
    var uuid: CBUUID { get }
    
    // MARK: - Properties from CBCharacteristic
    var service: (any ServiceProtocol)? { get }
    var properties: CBCharacteristicProperties { get }
    var value: Data? { get }
    var descriptors: [any DescriptorProtocol]? { get }
    var isNotifying: Bool { get }
    
    // MARK: - Properties for Internal Use
    var _wrapped: CBCharacteristic? { get }
}


public func == (lhs: any CharacteristicProtocol, rhs: any CharacteristicProtocol) -> Bool {
    return lhs.uuid == rhs.uuid
        && lhs.service?.uuid == rhs.service?.uuid // NOTE: prevent mutal recursion.
        && lhs.properties == rhs.properties
        && lhs.value == rhs.value
        && lhs.descriptors == rhs.descriptors
        && lhs.isNotifying == rhs.isNotifying
}


public func == (lhs: [any CharacteristicProtocol], rhs: [any CharacteristicProtocol]) -> Bool {
    return zip(lhs, rhs).allSatisfy { $0 == $1 }
}


public func == (lhs: [any CharacteristicProtocol]?, rhs: [any CharacteristicProtocol]?) -> Bool {
    return optionalEquals(lhs, rhs) { $0 == $1 }
}


public struct Characteristic: CharacteristicProtocol {
    // MARK: - Properties from CBAttribute
    public var uuid: CBUUID { characteristic.uuid }
    
    // MARK: - Properties from CBCharacteristic
    public var service: (any ServiceProtocol)? { self.characteristic.service.map { Service.init(wrapping: $0, logger: logger) } }
    public var properties: CBCharacteristicProperties { characteristic.properties }
    public var value: Data? { characteristic.value }
    public var descriptors: [any DescriptorProtocol]? { characteristic.descriptors.map { $0.map { Descriptor.init(wrapping: $0, logger: logger) } } }
    public var isNotifying: Bool { characteristic.isNotifying }
    
    // MARK: - Properties for Internal Use
    private let characteristic: CBCharacteristic
    private let logger: any LoggerProtocol
    public var _wrapped: CBCharacteristic? { characteristic }
    
    
    // MARK: - Initializers
    public init(wrapping characteristic: CBCharacteristic, logger: any LoggerProtocol) {
        self.characteristic = characteristic
        self.logger = logger
    }
}
