# Create a time-based CSV script that would lock funds for 6 months (using 30-day months)
# Time-based CSV uses 512-second units with the type flag (bit 22) set
# publicKey=02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277

SIX_MONTHS=$(( 6 * 30 * 24 * 3600 / 512 | 0x400000 ))
SIX_MONTHS_HEX=$(printf '%08x\n' $SIX_MONTHS | sed 's/^\(00\)*//')

LITTLE_ENDIAN=$(echo $SIX_MONTHS_HEX | tac -rs .. | echo "$(tr -d '\n')")

CSV_SCRIPT="03"$LITTLE_ENDIAN"b27576"
PUBKEY="02e3af28965693b9ce1228f9d468149b831d6a0540b25e8a9900f71372c11fb277"

HASHED_SCRIPT=$(echo -n $PUBKEY | xxd -r -p | openssl dgst -sha256 -binary | openssl dgst -rmd160 | awk '{print $2}')

FULL_SCRIPT=""$CSV_SCRIPT"a914"$HASHED_SCRIPT"88ac"
echo $FULL_SCRIPT

