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
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

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

    /*
    * Este é um endereço => mapeamento uint, o que significa que posso associar um endereço a um número!
    * Neste caso, estarei armazenando o endereço com a última vez que o usuário acenou para nós.
    */
    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Sou um contrato inteligente");
         /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    //msg.sender => endereço da carteira de quem chamou a função
    //totalWaves => valor armazenado permanentemente no contrato

    //mudando um pouquinho... usuario me envia no front-end
    function wave(string memory _message) public {
        /** 
        *Precisamos garantir que o registro de data e hora atual seja pelo menos 15 minutos maior do que o último registro de data e hora que armazenamos
        */
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

         /*
         * atualizamos o timestamp que temos para o user
         */
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s Acenou!", msg.sender, _message);
    
        /*
        * armazenando os dados no array
        */
        waves.push(Wave(msg.sender, _message, block.timestamp));

         /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        if (seed < 50) {
            console.log("%s won!", msg.sender);

            //envio de eth para quem acenar
            //saldo do meu contrato: address(this).balance
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "tentativa de sacar mais do que o contrato tem em dinheiro."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Falha ao sacar.");
        }

        emit NewWave(msg.sender, block.timestamp, _message);
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
