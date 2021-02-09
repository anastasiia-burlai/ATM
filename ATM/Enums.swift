//
//  Enums.swift
//  ATM
//
//  Created by User on 07.02.2021.
//

// Тексты ошибок
enum TextErrors: String {
    case incorrectCardIdOrPin = "CardID or pin is incorrect. Please check your data and try again"
    case missingPaymentType = "You chose to top up your phone, but didn't select payment method. Please select one of the applicable payment methods: Cash, Deposit"
    case negativeAmount = "Requested sum is zero or less. Please specify positive sum and try again"
    case insufficientSumInCash = "Not enough cash. Please try another sum"
    case insufficientSumOnDeposit = "Not enough funds on deposit. Please try another sum"
}
 
// Виды операций, выбранных пользователем (подтверждение выбора)
enum DescriptionTypesAvailableOperations: Int {
    case showButtons = 0
    case reEnterCardAndPin
    case showBalance
    case topUpPhone
    case putCashToDeposit
    case getCashFromDeposit
    case endWork
}
 
// Действия, которые пользователь может выбирать в банкомате (имитация кнопок)
enum UserActions {
    case userPressedBalanceBtn
    case userPressedGetCashFromDepositBtn(amount: Float)
    case userPressedPutCashToDepositBtn(amount: Float)
    case userPressedTopUpPhoneBtn(amount: Float)
}
 
// Способ оплаты/пополнения наличными или через депозит
enum PaymentMethod: String {
    case cash
    case deposit
}
