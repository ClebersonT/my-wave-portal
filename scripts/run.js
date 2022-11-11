//npx hardhat run scripts/run.js

const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    //compila contrato
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    /*Hardhat criará uma rede Ethereum local para nós,
    mas apenas para este contrato.  Então, depois que 
    o script for concluído, ele destruirá essa rede local.
    Então, toda vez que você executar o contrato, será uma nova blockchain.*/
    const waveContract = await waveContractFactory.deploy();
    //sempre recomeça clean
    await waveContract.deployed();
    //print
    console.log("Contract deployed to:", waveContract.address);
    //dono do contrato
    console.log("Contract deployed by:", owner.address);

    //Basicamente é assim que podemos simular outras pessoas acessando nossas funções
    await waveContract.getTotalWaves();

    const firstWaveTxn = await waveContract.wave();
    await firstWaveTxn.wait();
  
    await waveContract.getTotalWaves();
  
    const secondWaveTxn = await waveContract.connect(randomPerson).wave();
    await secondWaveTxn.wait();
  
    await waveContract.getTotalWaves();
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