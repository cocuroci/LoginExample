import Foundation
import RxSwift
import RxCocoa

protocol LoginPresenting {
    var viewController: LoginDisplay? { get set }
    func bind(_ output: LoginOutput)
}

final class LoginPresenter: LoginPresenting {
    weak var viewController: LoginDisplay?
 
    func bind(_ output: LoginOutput) {
        viewController?.bind(output)
    }
}
