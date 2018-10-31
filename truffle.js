/*
 * NB: since truffle-hdwallet-provider 0.0.5 you must wrap HDWallet providers in a
 * function when declaring them. Failure to do so will cause commands to hang. ex:
 * ```
 * mainnet: {
 *     provider: function() {
 *       return new HDWalletProvider(mnemonic, 'https://mainnet.infura.io/<infura-key>')
 *     },
 *     network_id: '1',
 *     gas: 4500000,
 *     gasPrice: 10000000000,
 *   },
 */

require('dotenv').config()  // Store environment-specific variable from '.env' to process.env

var HDWalletProvider = require("truffle-hdwallet-provider");

module.exports = {
    networks: {
        ropsten: {
            provider: function() {
                return new HDWalletProvider(process.env.MNENOMIC, "https://ropsten.infura.io/v3/" + process.env.INFURA_API_KEY)
            },
            network_id: 3
        }
    }
};
