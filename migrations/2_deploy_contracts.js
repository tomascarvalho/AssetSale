var AssetToken = artifacts.require("AssetCrowdsaleToken");
var AssetCrowdsale = artifacts.require("AssetCrowdsale");

module.exports = function(deployer, network, accounts)
{
    const startTime = Date.now()/1000|0 + 120;
    const endTime = startTime + (3600 * 1 * 1); // *1 hour *1 days
    const rate = 1;
    const wallet = accounts[0];
    return deployer
        .then(() => {
            return deployer.deploy(AssetToken, 'AssetToken', 'AST');
        })
        .then(() => {
            return deployer.deploy(
                AssetCrowdsale,
                startTime,
                endTime,
                rate,
                wallet,
                1000000,
                AssetToken.address,
                1000000
            );
        });
};
