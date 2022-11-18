//npx hardhat run scripts/run.js

const main = async () => {
    //compila contrato
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    /*Hardhat criará uma rede Ethereum local para nós,
    mas apenas para este contrato.  Então, depois que 
    o script for concluído, ele destruirá essa rede local.
    Então, toda vez que você executar o contrato, será uma nova blockchain.*/
    const waveContract = await waveContractFactory.deploy();
    //sempre recomeça clean
    await waveContract.deployed();

    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());
    
   /**
    * Vamos enviar algumas ondas / acenos
    */

   let waveTxn = await waveContract.wave("uma mensagem");
   await waveTxn.wait(); // esperando ser minerada a transação

   const [_, randomPerson] = await hre.ethers.getSigners();
   waveTxn = await waveContract.connect(randomPerson).wave("outra menssagem!");
   await waveTxn.wait(); // esperando ser minerada a transação

   let allWaves = await waveContract.getAllWaves();
   console.log(allWaves);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0); // sair sem erro
    } catch (error) {
      console.log(error);
      process.exit(1); //sair ao indicar um erro
    }
    // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
  };
  
  runMain();