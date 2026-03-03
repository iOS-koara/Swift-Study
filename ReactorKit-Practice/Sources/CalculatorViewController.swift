import UIKit
import RxSwift
import RxCocoa

final class CalculatorViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel = CalculatorViewModel()

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
            .bind(to: viewModel.increaseTap)
            .disposed(by: disposeBag)

        decreaseButton.rx.tap
            .bind(to: viewModel.decreaseTap)
            .disposed(by: disposeBag)

        multiplyButton.rx.tap
            .bind(to: viewModel.multiplyTap)
            .disposed(by: disposeBag)
        
        viewModel.valueText
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
