import UIKit

final class CalculatorViewController: UIViewController {

    private var value: Int = 0

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
        setupActions()
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

    private func setupActions() {
        increaseButton.addTarget(self, action: #selector(increaseTapped), for: .touchUpInside)
        decreaseButton.addTarget(self, action: #selector(decreaseTapped), for: .touchUpInside)
        multiplyButton.addTarget(self, action: #selector(multiplyTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc private func increaseTapped() {
        value += 1
        valueLabel.text = "\(value)"
    }

    @objc private func decreaseTapped() {
        value -= 1
        valueLabel.text = "\(value)"
    }

    @objc private func multiplyTapped() {
        value *= 2
        valueLabel.text = "\(value)"
    }
}
