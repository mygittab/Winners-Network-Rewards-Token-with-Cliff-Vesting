# Winners Network Rewards Token Without Cliff & Vesting
This is BEP 20 Smartcontract.


1. Token Name: Winners Network Rewards Token
2. Token Symbol: WINS
3. Contract Name: WINS
4. Contact Link: 


# Token Distribution
![distribution](https://user-images.githubusercontent.com/56725843/119975386-74d8f880-bfbe-11eb-8ed8-e641dd1edd71.jpg)

# Installation

1. npm install -g yarn

2. yarn install

3. yarn test


# Deployment

An illustrative example of constructor parameters is in the test.

https://github.com/mygittab/Winners-Network-Rewards-Token-Without-Cliff-Vesting/blob/main/test/Allocations.js#L35


# Features:
1. Each wallet will have update<name>Wallet() function - can be updated by owner. Where name is
  - Seed 
  - PrivateSale
  - PublicSale 
  - Liquidity
  - Team
  - Marketing
  - Presale
  - Reserve
  - Technology
  - Legal
  - Advisor
  - Ido

2. Each wallet will have grantTo<name>Wallet() function - can be called by owner of Wallet. Where name is
  - Seed 
  - PrivateSale
  - PublicSale 
  - Liquidity
  - Team
  - Marketing
  - Presale
  - Reserve
  - Technology
  - Legal
  - Advisor
  - Ido

grantTo<name>Wallet() claim tokens to wallet owner with vesting parameters from distribution.

3. Initially the amount will be minted and put on contract - each wallet have to login and claim tokens from allocations. 

4. Minting function will be present which can be called by owner 

5. Burn function that can be called by owner. 




# Test output


# Mainnet Contract

