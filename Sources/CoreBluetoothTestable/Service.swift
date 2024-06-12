import CoreBluetooth
import Logger


public protocol ServiceProtocol {
    // MARK: - Properties from CBAttribute
    var uuid: CBUUID { get }
    
    // MARK: - Properties from CBService
    var peripheral: (any PeripheralProtocol)? { get }
    var isPrimary: Bool { get }
    var includedServices: [any ServiceProtocol]? { get }
    var characteristics: [any CharacteristicProtocol]? { get }
    
    // MARK: - Properties for Internal Use
    var _wrapped: CBService? { get }
}


public func == (lhs: any ServiceProtocol, rhs: any ServiceProtocol) -> Bool {
    return lhs.uuid == rhs.uuid
        && lhs.peripheral?.identifier == rhs.peripheral?.identifier // NOTE: prevent mutal recursion.
        && lhs.isPrimary == rhs.isPrimary
        && optionalEquals(lhs.includedServices, rhs.includedServices) { $0 == $1 }
        && optionalEquals(lhs.characteristics, rhs.characteristics) { $0 == $1 }
}


public func == (lhs: [any ServiceProtocol], rhs: [any ServiceProtocol]) -> Bool {
    return zip(lhs, rhs).allSatisfy { $0 == $1 }
}


public func == (lhs: [any ServiceProtocol]?, rhs: [any ServiceProtocol]?) -> Bool {
    return optionalEquals(lhs, rhs) { $0 == $1 }
}


public struct Service: ServiceProtocol {
    // MARK: - Properties from CBAttribute
    public var uuid: CBUUID { service.uuid }
    
    // MARK: - Properties from CBService
    public var peripheral: (any PeripheralProtocol)? { Peripheral.from(peripheral: service.peripheral!, logger: logger) }
    public var isPrimary: Bool { service.isPrimary }
    public var includedServices: [any ServiceProtocol]? { service.includedServices.map{ $0.map { Service.init(wrapping: $0, logger: logger )} } }
    public var characteristics: [any CharacteristicProtocol]? { service.characteristics.map { $0.map { Characteristic.init(wrapping: $0, logger: logger) } } }
    
    // MARK: - Properties for Internal Use
    private let service: CBService
    private let logger: any LoggerProtocol
    public var _wrapped: CBService? { service }
    
    
    // MARK: - Initializers
    public init(wrapping service: CBService, logger: any LoggerProtocol) {
        self.service = service
        self.logger = logger
    }
}
