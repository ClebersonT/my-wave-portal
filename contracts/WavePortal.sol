//comentario identificador de licença SPDX"
// SPDX-License-Identifier: UNLICENSED

//versão do compilador Solidity 
pragma solidity ^0.8.17;

//logs do meu contrato
import "hardhat/console.sol";

//ao ser chamado meu contrato executará o que a classe contem
contract WavePortal {
    uint256 totalWaves;

      /*
     * eventos solidity!
     */
    event NewWave(address indexed from, uint256 timestamp, string message);

    /*
     * struct
     */
    struct Wave {
        address waver; // endereço que user acenou
        string message; // mensagem que o usuario enviou.
        uint256 timestamp; // timestamp de quando foi enviado.
    }

    /*
     * variavel para guardar os acenos
     */
    Wave[] waves;

    constructor() {
        console.log("Sou um contrato inteligente");
    }

    //msg.sender => endereço da carteira de quem chamou a função
    //totalWaves => valor armazenado permanentemente no contrato

    //mudando um pouquinho... usuario me envia no front-end
    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s Acenou!", msg.sender, _message);
    
        /*
        * armazenando os dados no array
        */
        waves.push(Wave(msg.sender, _message, block.timestamp));
        emit NewWave(msg.sender, block.timestamp, _message);
    
        //envio de eth para quem acenar
        //saldo do meu contrato: address(this).balance
        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance, "tentando retirar mais dinheiro do que tem o contrato"
        );    
        (bool success, ) = (msg.sender).call{value: prizeAmount}(""); //enviamos o dinheiro
        require(success, "Falha ao sacar");
    }
   
    /*
    * retornará a struct
    */
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Nos temos %d total de acenos!", totalWaves);
        return totalWaves;
    }
}
