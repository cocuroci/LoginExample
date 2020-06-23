import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol LoginDisplay: AnyObject {
    func bind(_ output: LoginOutput)
}

final class LoginViewController: UIViewController, LoginDisplay {
    private let viewModel: LoginViewModelInputs
    var textEvent: Driver<String>?
    
    private let disposeBag = DisposeBag()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "email@email.com"
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    init(viewModel: LoginViewModelInputs) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.trailing.leading.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
        
        viewModel.bind(
            LoginInput(
                email: emailTextField.rx.text.orEmpty.asDriver(),
                password: passwordTextField.rx.text.orEmpty.asDriver(),
                tapEvent: loginButton.rx.tap.asSignal()
            )
        )
    }
    
    func bind(_ output: LoginOutput) {
        output.isEnabled.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
    }
}
