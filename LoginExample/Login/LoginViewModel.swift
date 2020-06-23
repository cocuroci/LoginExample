import Foundation
import RxSwift
import RxCocoa

struct LoginInput {
    let email: Driver<String>
    let password: Driver<String>
    let tapEvent: Signal<Void>
}

struct LoginOutput {
    let isEnabled: Driver<Bool>
}

protocol LoginViewModelInputs {
    func bind(_ input: LoginInput)
}

final class LoginViewModel {
    private var presenter: LoginPresenting
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
}

extension LoginViewModel: LoginViewModelInputs {
    func bind(_ input: LoginInput) {
        let validatedEmail = input.email.compactMap { $0.isValidEmail }
        let validatedPassword = input.password.compactMap { $0.count > 5 }
        
        let loginIsEnabled = Driver.combineLatest(
            validatedEmail,
            validatedPassword
        ) { validatedEmail, validatedPassword in
            validatedEmail && validatedPassword
        }.distinctUntilChanged()
       
        presenter.bind(LoginOutput(isEnabled: loginIsEnabled))
    }
}
