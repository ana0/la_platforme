    var button = document.getElementById("find-me-fast");
    button.onclick = async function(){
        button.style.backgroundColor = "blue";
        if (window.ethereum) {
            window.web3 = new Web3(ethereum);
            await ethereum.enable();
            const address = await web3.eth.getAccounts();
            console.log("Connected as: " + address[0]);

            const contract = new web3.eth.Contract(tokenAbi, "0x5FbDB2315678afecb367f032d93F642f64180aa3");

            var txButton = document.createElement('button');
            txButton.innerHTML = "New transaction!";
            txButton.onclick = async function(){
                contract.methods.mint(address[0]).send({ from: address[0] })
            }
            document.body.appendChild(txButton);
        }
    };

