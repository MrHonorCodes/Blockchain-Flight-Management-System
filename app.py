from web3 import Web3

# Connect to the Ethereum testnet
w3 = Web3(Web3.HTTPProvider('https://ropsten.infura.io/v3/YOUR_INFURA_PROJECT_ID'))

# Make sure to replace 'YOUR_INFURA_PROJECT_ID' with your actual Infura project ID.

# Check if connected to blockchain
print("Connected:", w3.isConnected())

# Add your smart contract's address and ABI
contract_address = w3.toChecksumAddress('your_contract_address_here')
contract_abi = "your_contract_abi_here"

# Creating a contract object
flight_management_system = w3.eth.contract(address=contract_address, abi=contract_abi)

# Function to book a flight
def book_flight(flight_number, from_address, private_key):
    flight_price = flight_management_system.functions.getFlightDetails(flight_number).call().price
    nonce = w3.eth.getTransactionCount(from_address)
    txn_dict = {
        'to': contract_address,
        'value': flight_price,
        'gas': 2000000,
        'gasPrice': w3.toWei('40', 'gwei'),
        'nonce': nonce,
        'chainId': 3  # Ropsten testnet chain ID
    }
    # Sign transaction with your private key
    signed_txn = w3.eth.account.signTransaction(txn_dict, private_key)
    
    # Send transaction
    txn_receipt = w3.eth.sendRawTransaction(signed_txn.rawTransaction)
    
    # Wait for the transaction to be mined
    txn_receipt = w3.eth.waitForTransactionReceipt(txn_receipt)
    
    print(f"Flight booked! Transaction receipt: {txn_receipt}")

# Replace with actual values and call the function to book a flight
book_flight('FL123', 'your_ethereum_address_here', 'your_private_key_here')
