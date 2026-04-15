# Create a CSV script that would lock funds until one hundred and fifty blocks had passed
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277
#

RELATIVE_BLOCKTIME=150
BLOCKTIME_HEX=$(printf '%08x\n' $RELATIVE_BLOCKTIME | sed 's/^\(00\)*//' )
hexfirst=$(echo $BLOCKTIME_HEX | cut -c1)
[[ 0x$hexfirst -gt 0x7 ]] && BLOCKTIME_HEX="00"$BLOCKTIME_HEX
LITTLE_ENDIAN_BLOCKTIME=$(echo $BLOCKTIME_HEX | tac -rs .. | echo "$(tr -d '\n')")
LENGTH_TIMESTAMP=$(echo -n $LITTLE_ENDIAN_BLOCKTIME | wc -c | awk '{print $1/2}')
CSV_SCRIPT="02"$LITTLE_ENDIAN_BLOCKTIME"b27576"
PUBKEY="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"

HASHED_SCRIPT=$(echo -n $PUBKEY | xxd -r -p  | openssl dgst -sha256 -binary | openssl dgst -rmd160 | awk '{print $2}')

FULL_SCRIPT=""$CSV_SCRIPT"a914"$HASHED_SCRIPT"88ac"
echo $FULL_SCRIPT

