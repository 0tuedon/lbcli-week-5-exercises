# Construct a 2-of-3 multisig redeem script (serialized hex) using the following public keys:
publicKey1=02da2f10746e9778dd57bd0276a4f84101c4e0a711f9cfd9f09cde55acbdd2d191
publicKey2=02bfde48be4aa8f4bf76c570e98a8d287f9be5638412ab38dede8e78df82f33fa3
publicKey3=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
# The script should follow this pattern: OP_2 <pubkey1> <pubkey2> <pubkey3> OP_3 OP_CHECKMULTISIG
#
LENGTH_PUBKEY=$(echo -n $publicKey1 | wc -c | awk '{print $1/2}')
PUBKEY_LEN_HEX=$(printf '%08x\n' $LENGTH_PUBKEY | sed 's/^\(00\)*//' )

REDEEM_SCRIPT="52"$PUBKEY_LEN_HEX""$publicKey1""$PUBKEY_LEN_HEX""$publicKey2""$PUBKEY_LEN_HEX""$publicKey3"53ae"
echo $REDEEM_SCRIPT
