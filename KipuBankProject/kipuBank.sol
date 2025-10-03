// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;
/*
 @title Banco para depositos y extracciones.
 @author Ramiro Julian Rodriguez.
 @notice Este contrato es una consigna del tp del curso ETH dev pack impartido por ETHKIPU.
 @custom:security Este es un contrato educativo y NO debe ser usado en PRODUCCION.
 */

contract KipuBank {

    // @notice limite maximo de retiro por transacción
    // @dev se define en el constructor y no puede cambiar
    uint256 public immutable withdrawalLimit;

    // @notice limite global de depósitos en el contrato
    // @dev se define en el constructor y no puede cambiar
    uint256 public immutable bankCap;

    // @notice total de ETH depositado en el contrato
    uint256 public totalDeposited;

    // @dev mapeo de usuario a saldo en su boveda
    mapping(address => uint256) private vaults;

    //@notice numero de depositos realizados por cada usuario
    mapping(address => uint256) public depositCount;

    // @notice numero de retiros realizados por cada usuario
    mapping(address => uint256) public withdrawalCount;

    // @notice se emite cuando un usuario realiza un deposito exitoso
    event Deposit(address user, uint256 amount);

    // @notice se emite cuando un usuario realiza un retiro exitoso
    event Withdrawal(address user, uint256 amount);


    // @dev se lanza cuando el deposito excede el limite global
    error DepositLimitReached();

    // @dev se lanza cuando el retiro excede el limite por transacción
    error WithdrawalLimitExceeded();

    // @dev se lanza cuando el usuario no tiene saldosuficiente 
    error InsufficientBalance();

    // @dev se lanza cuando el monto enviado es cero
    error ZeroAmountNotAllowed();

    // @param _withdrawalLimit limite de retiro por transacción
    // @param _bankCap limite global de depósitos
    constructor(uint256 _withdrawalLimit, uint256 _bankCap) {
        withdrawalLimit = _withdrawalLimit;
        bankCap = _bankCap;
    }

    receive() external payable {
        deposit();
    }

    fallback() external payable {
        deposit();
    }

    // @notice retira ETH de la boveda personal hasta el limite permitido
    // @param amount monto a retirar.
    // @dev se valida si el monto es mayor a cero y al limite de extraccion, y si no excede el balance actual de la boveda.
    function withdraw(uint256 amount) external {
        if (amount == 0) revert ZeroAmountNotAllowed();
        if (amount > withdrawalLimit) revert WithdrawalLimitExceeded();
        if (!_hasEnoughBalance(msg.sender, amount)) revert InsufficientBalance();

        vaults[msg.sender] -= amount;
        totalDeposited -= amount;
        withdrawalCount[msg.sender]++;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        emit Withdrawal(msg.sender, amount);
    }

    // @notice deposita ETH en la boveda personal
    // @dev verifica el limite global antes de aceptar el depósito
    function deposit() public payable {
        if (msg.value == 0) revert ZeroAmountNotAllowed();
        if (totalDeposited + msg.value > bankCap) revert DepositLimitReached();

        vaults[msg.sender] += msg.value;
        totalDeposited += msg.value;
        depositCount[msg.sender]++;

        emit Deposit(msg.sender, msg.value);
    }

    // @dev valida si el usuario tiene saldo suficiente
    // @param user dirección del usuario
    // @param amount monto a verificar
    // @return es verdadero si tiene saldo suficiente
    function _hasEnoughBalance(address user, uint256 amount) private view returns (bool) {
        return vaults[user] >= amount;
    }

    // @notice consulta el saldo de la boveda personal
    // @return saldo en ETH
    function getVaultBalance() external view returns (uint256) {
        return vaults[msg.sender];
    }
}
