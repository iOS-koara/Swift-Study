import UIKit
import RxSwift
import RxCocoa

final class CalculatorViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    //- Publish vs Behavior → 초기값 0이 필요하니까 Behavior
    //- Subject vs Relay → UI 상태는 에러/완료로 끊기면 안 되니까 Relay
    private let valueRelay = BehaviorRelay<Int>(value: 0)

    // MARK: - UI

    private let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .monospacedDigitSystemFont(ofSize: 80, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let increaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 36, weight: .medium)
        return button
    }()

    private let decreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 36, weight: .medium)
        return button
    }()

    private let multiplyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("×2", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 36, weight: .medium)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bind()
    }

    private func setupLayout() {
        let buttonStack = UIStackView(arrangedSubviews: [decreaseButton, multiplyButton, increaseButton])
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 20

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(valueLabel)
        view.addSubview(buttonStack)

        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            buttonStack.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 40),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }

    // MARK: - Bind

    private func bind() {
        increaseButton.rx.tap
            .map { [weak self] in (self?.valueRelay.value ?? 0) + 1 }
            .bind(to: valueRelay)
            .disposed(by: disposeBag)

        decreaseButton.rx.tap
            .map { [weak self] in (self?.valueRelay.value ?? 0) - 1 }
            .bind(to: valueRelay)
            .disposed(by: disposeBag)

        multiplyButton.rx.tap
            .map { [weak self] in (self?.valueRelay.value ?? 0) * 2 }
            .bind(to: valueRelay)
            .disposed(by: disposeBag)
        
        valueRelay
            .map { "\($0)" }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
