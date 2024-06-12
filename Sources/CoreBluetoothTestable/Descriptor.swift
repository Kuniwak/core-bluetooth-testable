import CoreBluetooth
import Logger
import MirrorDiffKit


public protocol DescriptorProtocol {
    // MARK: - Properties from CBAttribute
    var uuid: CBUUID { get }
    
    // MARK: - Properties from CBDescriptor
    var characteristic: (any CharacteristicProtocol)? { get }
    var value: Any? { get }
    
    // MARK: - Properties for Internal Use
    var _wrapped: CBDescriptor? { get }
}


public func == (lhs: any DescriptorProtocol, rhs: any DescriptorProtocol) -> Bool {
    return lhs.uuid == rhs.uuid
        && lhs.characteristic?.uuid == rhs.characteristic?.uuid // NOTE: prevent mutal recursion.
        && lhs.value =~ rhs.value
}


public func == (lhs: [any DescriptorProtocol], rhs: [any DescriptorProtocol]) -> Bool {
    return zip(lhs, rhs).allSatisfy { $0 == $1 }
}


public func == (lhs: [any DescriptorProtocol]?, rhs: [any DescriptorProtocol]?) -> Bool {
    return optionalEquals(lhs, rhs) { $0 == $1 }
}


public struct Descriptor: DescriptorProtocol {
    // MARK: - Properties from CBAttribute
    public var uuid: CBUUID { descriptor.uuid }
    
    // MARK: - Properties from CBDescriptor
    public var characteristic: (any CharacteristicProtocol)? { descriptor.characteristic.map{ Characteristic.init(wrapping: $0, logger: logger) } }
    public var value: Any? { descriptor.value }
    
    // MARK: - Properties for Internal Use
    private let descriptor: CBDescriptor
    public var _wrapped: CBDescriptor? { descriptor }
    
    // MARK: - Properties for Internal Use
    private let logger: any LoggerProtocol
    
    // MARK: - Initializers
    public init(wrapping descriptor: CBDescriptor, logger: any LoggerProtocol) {
        self.descriptor = descriptor
        self.logger = logger
    }
}
