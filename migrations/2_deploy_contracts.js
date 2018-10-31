var AssetToken = artifacts.require("AssetCrowdsaleToken");
var AssetCrowdsale = artifacts.require("AssetCrowdsale");

module.exports = function(deployer) {
    deployer.deploy(AssetToken, "AssetToken#1", "AST#1").then(function() {
        return deployer.deploy(1541003400, 1541010600, 1, 0x3F9EBd1f916BdCE3F11fd62a103f540B388Be6B2, 1000000, , 1000000);
     });

};
