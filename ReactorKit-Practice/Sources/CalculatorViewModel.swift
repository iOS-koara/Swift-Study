import RxSwift
import RxCocoa

final class CalculatorViewModel {

    // Input
    let increaseTap = PublishRelay<Void>()
    let decreaseTap = PublishRelay<Void>()
    let multiplyTap = PublishRelay<Void>()

    // Output
    let valueText: Observable<String>

    private let valueRelay = BehaviorRelay<Int>(value: 0)
    private let disposeBag = DisposeBag()

    init() {
        valueText = valueRelay.map { "\($0)" }
        bindActions()
    }

    private func bindActions() {
        increaseTap
            .map { [weak self] in (self?.valueRelay.value ?? 0) + 1 }
            .bind(to: valueRelay)
            .disposed(by: disposeBag)

        decreaseTap
            .map { [weak self] in (self?.valueRelay.value ?? 0) - 1 }
            .bind(to: valueRelay)
            .disposed(by: disposeBag)

        multiplyTap
            .map { [weak self] in (self?.valueRelay.value ?? 0) * 2 }
            .bind(to: valueRelay)
            .disposed(by: disposeBag)
    }
}
