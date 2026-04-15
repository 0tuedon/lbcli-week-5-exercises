# Find the P2SH address for the following redeem script:
 redeemScript="522102da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d1912102bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa352ae"

 bitcoin-cli -regtest decodescript $redeemScript | jq -r ".p2sh"
