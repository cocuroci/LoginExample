import UIKit

final class LoginFactory {
    static func make() -> UIViewController {
        let presenter = LoginPresenter()
        let viewModel = LoginViewModel(presenter: presenter)
        let viewController = LoginViewController(viewModel: viewModel)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
