//
//  main.swift
//  ATM
//
//  Created by User on 24.01.2021.
//
import Foundation

let cardPattern = "^[0-9]{4} [0-9]{4} [0-9]{4} [0-9]{4}$"
let pinPattern = "^[0-9]{4}$"
let floatPattern = "^[0-9]+(\\.[0-9]{1,2})*$"

func readValue(fieldName: String, pattern: String) -> String {
    let nsRegExp = try! NSRegularExpression(pattern: pattern, options: []);
    var value = ""
    print("\(fieldName):")
    repeat {
        value = readLine() ?? ""
        if nsRegExp.matches(
            in: value,
            options: [],
            range: NSRange(location: 0, length: value.count)
        ).count == 0 {
            print("\(fieldName) value '\(value)' has incorrect format, should be \(pattern)")
            value = ""
            continue
        }
    } while value == ""
    return value
}

var rawCommand: String
print("Please register in Nothern bank by providing your user data")
let userName:String = readValue(fieldName: "User Name", pattern: "^[A-Z]{1}[a-z]+ [A-Z]{1}[a-z]+$")
let cardId:String = readValue(fieldName: "Card ID", pattern: cardPattern)
let pin:Int = Int(readValue(fieldName: "Pin", pattern: pinPattern))!
let cash:Float = Float(readValue(fieldName: "Cash", pattern: floatPattern))!
let deposit:Float = Float(readValue(fieldName: "Deposit Balance", pattern: floatPattern))!
let phone:String = readValue(fieldName: "Phone", pattern: "^\\+[0-9]{1,2}\\([0-9]{3}\\)\\-[0-9]{3}\\-[0-9]{2}\\-[0-9]{2}$")
let phoneBalance:Float = Float(readValue(fieldName: "Phone Balance", pattern: "^\\-*" + floatPattern.dropFirst()))!
let user:UserData = User(userName: userName, userCardId: cardId, userCardPin: pin, userCash: cash, userBankDeposit: deposit, userPhone: phone, userPhoneBalance: phoneBalance)

let bankClient = NothernBank(user: user)
var cardIdATM:String = ""
var pinATM:Int = 0
var command:DescriptionTypesAvailableOperations = .reEnterCardAndPin
var atm: ATM

print("Starting ATM...Insert card")
repeat {
switch command {
case .reEnterCardAndPin:
    cardIdATM = readValue(fieldName: "Card ID", pattern: cardPattern)
    pinATM = Int(readValue(fieldName: "Pin", pattern:pinPattern))!
case .showBalance:
    atm = ATM(userCardId: cardIdATM, userCardPin: pinATM, someBank: bankClient, action: .userPressedBalanceBtn, paymentMethod: nil)
case .topUpPhone:
    let amount:Float = Float(readValue(fieldName: "Top Up Amount", pattern: floatPattern))!
    let paymentMethod:PaymentMethod = PaymentMethod(rawValue: readValue(fieldName: "Payment Method", pattern: "[cash|deposit]"))!
    atm = ATM(userCardId: cardIdATM, userCardPin: pinATM, someBank: bankClient, action: .userPressedTopUpPhoneBtn(amount: amount), paymentMethod: paymentMethod)
case .putCashToDeposit:
    let amount:Float = Float(readValue(fieldName: "Top Up Amount", pattern: floatPattern))!
    atm = ATM(userCardId: cardIdATM, userCardPin: pinATM, someBank: bankClient, action: .userPressedPutCashToDepositBtn(amount: amount), paymentMethod: nil)
case .getCashFromDeposit:
    let amount:Float = Float(readValue(fieldName: "Withdrawal Amount", pattern: floatPattern))!
    atm = ATM(userCardId: cardIdATM, userCardPin: pinATM, someBank: bankClient, action: .userPressedGetCashFromDepositBtn(amount: amount), paymentMethod: nil)
case .endWork:
    exit(0)
default:
    print("""
            Re-enter Card ID and Pin - \(DescriptionTypesAvailableOperations.reEnterCardAndPin.rawValue),
            Show Balance - \(DescriptionTypesAvailableOperations.showBalance.rawValue),
            Top Up Phone Balance - \(DescriptionTypesAvailableOperations.topUpPhone.rawValue),
            Top Up Deposit Balance - \(DescriptionTypesAvailableOperations.putCashToDeposit.rawValue),
            Get Cash From Deposit - \(DescriptionTypesAvailableOperations.getCashFromDeposit.rawValue),
            End Work - \(DescriptionTypesAvailableOperations.endWork.rawValue)
            """)
}
    print("Choose operation (press 0 to list available operations)")
    command = DescriptionTypesAvailableOperations(rawValue: Int(readLine() ?? "0") ?? 0) ?? .showButtons
} while command != .endWork
