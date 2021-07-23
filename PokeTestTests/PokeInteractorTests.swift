//
//  PodeInteractorTest.swift
//  PokeTestTests
//
//  Created by Barbara Barone on 23/07/21.
//

@testable import PokeTest
import XCTest

private final class PokeServiceMock: PokeServicing {
    var fetchExpectedResult: Pokemon?
    func fetch(completion: @escaping (Result<Pokemon, APIError>) -> Void) {
        guard let fetchExpectedResult = fetchExpectedResult else {
            completion(.failure(.genericError))
            return
        }
        completion(.success(fetchExpectedResult))
    }
}

private final class PokePresenterSpy: PokePresenting {
    var viewController: PokeDisplaying?
    private(set) var presentPokemonCallsCount = 0
    private(set) var presentErrorCallsCount = 0
    private(set) var nextStepActionCallsCount = 0
    private(set) var presentPokemonReceivedInvocations = [Pokemon]()
    private(set) var nextStepActionReceivedInvocations = [PokeAction]()
    
    
    func present(pokemon: Pokemon) {
        presentPokemonReceivedInvocations.append(pokemon)
        presentPokemonCallsCount += 1
    }
    
    func presentError() {
        presentErrorCallsCount += 1
    }
    
    func nextStep(action: PokeAction) {
        nextStepActionReceivedInvocations.append(action)
        nextStepActionCallsCount += 1
    }
}

final class PokeInteractorTests: XCTestCase {
    private let serviceMock = PokeServiceMock()
    private let presenterSpy = PokePresenterSpy()
    private lazy var sut: PokeInteracting = {
        let interactor = PokeInteractor(service: serviceMock, presenter: presenterSpy, featureFlag: true)
        return interactor
    }()
    
    func testFetch_WhenFeatureFlagIsTrueAndServiceIsSuccess_ShouldPresentPokemon() {
        let abilityInfo = AbilityInfo(name: "fire", url: "www.batata.com")
        let ability = Ability(ability: abilityInfo, isHidden: true, slot: 2)
        let pokemon = Pokemon(abilities: [ability, ability, ability])
        serviceMock.fetchExpectedResult = pokemon
        sut.fetch()
        
        XCTAssertEqual(presenterSpy.presentPokemonCallsCount, 1)
        XCTAssertEqual(presenterSpy.presentPokemonReceivedInvocations, [pokemon])
    }
    
    func testFetch_WhenFeatureFlagIsFalse_ShouldPresentError() {
        sut = PokeInteractor(service: serviceMock, presenter: presenterSpy, featureFlag: false)
        sut.fetch()
        XCTAssertEqual(presenterSpy.presentErrorCallsCount, 1)
    }
    
    func testFetch_WhenFeatureFlagIsFalseAndServiceIsFailure_ShouldPresentError() {
        sut.fetch()
        XCTAssertEqual(presenterSpy.presentErrorCallsCount, 1)
    }
}
