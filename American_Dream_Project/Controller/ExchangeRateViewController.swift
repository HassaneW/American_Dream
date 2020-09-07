
import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var conversionDollars: UILabel!
    @IBOutlet weak var conversionCfa: UILabel!
    @IBOutlet weak var moneyTextField : UITextField!
    var money : Money?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setUpTextField()
    }
    func setUpTextField() {
        moneyTextField.delegate = self
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        moneyTextField.inputAccessoryView = toolbar
        addToolbar()
    }
    func setUp() {
        MoneyService.shared.getMoneys { [weak self] (resultMoney) in
            switch resultMoney {
            case .success(let money):
                print(money)
                self?.money = money
                self?.updateMoney()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func updateMoney() {
        DispatchQueue.main.async {
            self.dateLabel.text = self.money?.date
            self.conversionDollars.text = self.calculConversionDollars()
            self.conversionCfa.text = self.calculConversionCfa()
        }
    }
    func calculConversionDollars() -> String {
        guard let amount = moneyTextField.text
            else { return ""}
        guard let convertDollarAmount = Double(amount)
            else { return ""}
        guard let amountDollars = money?.monnaie.dollar else { return ""}
        let convertDollars = amountDollars * convertDollarAmount
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD"
        guard let convertCurrencyFormatDollars = formatter.string(for: convertDollars) else { return ""}
        return convertCurrencyFormatDollars
    }
    func calculConversionCfa() -> String {
        guard let amount = moneyTextField.text
            else { return ""}
        guard let convertCfaAmount = Double(amount)
            else { return ""}
        guard let amountCfa = money?.monnaie.cfa else { return ""}
        let convertCfa = amountCfa * convertCfaAmount
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "CFA"
        guard let convertCurrencyFormatCfa = formatter.string(for: convertCfa) else { return ""}
        return String(convertCurrencyFormatCfa)
    }
    func addToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 44))
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clikedClear))
        let convert = UIBarButtonItem(title: "Convert", style: .plain, target: self, action: #selector(clikedConvert))
        let spaceBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([clear, spaceBtn, convert], animated: true)
        self.moneyTextField.inputAccessoryView = toolbar
    }
    @objc func clikedClear() {
        moneyTextField.text = ""
    }
    @objc func clikedConvert() {
        updateMoney()
        moneyTextField.resignFirstResponder()
    }
}
extension ExchangeRateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "." && (textField.text?.contains(".") == true) {
            return false
        }
        return true
    }
}

