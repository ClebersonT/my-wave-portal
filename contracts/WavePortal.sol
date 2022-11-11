//comentario identificador de licença SPDX"
// SPDX-License-Identifier: UNLICENSED

//versão do compilador Solidity 
pragma solidity ^0.8.17;

//logs do meu contrato
import "hardhat/console.sol";

//ao ser chamado meu contrato executará o que a classe contem
contract WavePortal {
    uint256 totalWaves;

    constructor() {
        console.log("Sou um contrato inteligente");
    }

    //msg.sender => endereço da carteira de quem chamou a função
    //totalWaves => valor armazenado permanentemente no contrato
    function wave() public {
        totalWaves += 1;
        console.log("%s Acenou!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("Nos temos %d total de acenos!", totalWaves);
        return totalWaves;
    }
}
