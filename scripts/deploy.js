//implementar na rede local "npx hardhat run scripts/deploy.js --network localhost"
/*
Implantamos o contrato e também temos seu endereço no blockchain! a saida do comando acima
Nosso site vai precisar disso para saber onde procurar no blockchain o contrato
*/ 

//"gas used" => poder computacional necessária para executar operações específicas na rede.
//Gás é a taxa necessária para realizar uma transação Ethereum
// O gás é denominado em unidades chamadas gwei.

const main = async () => {
    const [deployer] = await hre.ethers.getSigners();
    const accountBalance = await deployer.getBalance();
  
    console.log("Deploying contracts with account: ", deployer.address);
    console.log("Account balance: ", accountBalance.toString());
  
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
  
    console.log("WavePortal address: ", waveContract.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();