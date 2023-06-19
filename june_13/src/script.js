var button = document.getElementById("find-me-fast");
button.onclick = async function(){
    button.style.backgroundColor = "blue";
    if (window.ethereum) {
        window.web3 = new Web3(ethereum);
        await ethereum.enable();
        const address = await web3.eth.getAccounts();
        console.log("Connected as: " + address[0]);

        const contract = new web3.eth.Contract(tokenAbi, "");

        var txButton = document.createElement('button');
        txButton.innerHTML = "New transaction!";
        txButton.onclick = async function(){
            contract.methods.transfer(address[0], 10).send({ from: address[0] })
        }
    }
};
