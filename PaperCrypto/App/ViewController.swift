// ViewController.swift
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var cryptoList: [CryptoMarketListElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        Service.shared.fetchCryptoMarketList(currency: .USD)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] crypto in
                guard let self = self,
                      let cryptoData = crypto else { return }
                
                self.cryptoList = cryptoData
                self.cryptoList.forEach { element in
                    print(element.name, element.currentPrice)
                }
            }, onError: { error in
                print(error)
                // Handle error state here
                // self.view?.setLoading(isLoading: false)
                // self.view?.dataError()
            })
            .disposed(by: disposeBag)
    }
}
