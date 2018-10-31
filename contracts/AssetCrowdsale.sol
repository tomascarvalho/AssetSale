pragma solidity 0.4.24;

import 'openzeppelin-solidity/contracts/crowdsale/Crowdsale.sol';
import 'openzeppelin-solidity/contracts/crowdsale/validation/CappedCrowdsale.sol';
import 'openzeppelin-solidity/contracts/crowdsale/distribution/RefundableCrowdsale.sol';
import 'openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol';
import 'openzeppelin-solidity/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol';
/*
contract AssetCrowdsale is Crowdsale, TimedCrowdsale, RefundableCrowdsale, PostDeliveryCrowdsale, CappedCrowdsale {

    constructor(
        uint256 rate,         // rate, in TKNbits
        address wallet,       // wallet to send Ether
        ERC20 token,          // the token
        uint256 cap,            // the cap, in wei
        uint256 goal,          // total goal, in wei
        uint256 openingTime,  // opening time in unix epoch seconds
        uint256 closingTime   // closing time in unix epoch seconds
    )
        PostDeliveryCrowdsale()
        RefundableCrowdsale(goal) // cap and goal are the same, as we want to sell all tokens
        TimedCrowdsale(openingTime, closingTime)
        CappedCrowdsale(cap)
        Crowdsale(rate, wallet, token)
        public
    {
        // nice, we just created a crowdsale that's only open
        // for a certain amount of time
        // and stops accepting contributions once it reaches `cap`
        // and then users can `withdrawTokens()` to get the tokens they're owed
        // this crowdsale will, if it doesn't hit `goal`, allow everyone to get their money back
        // by calling claimRefund(...)
        require(goal <= cap);
    }
} */

/**
 * @title SampleCrowdsaleToken
 * @dev Very simple ERC20 Token that can be minted.
 * It is meant to be used in a crowdsale contract.
 */
contract AssetCrowdsaleToken is ERC20Mintable, ERC20Detailed {
  constructor(string name, string symbol) public ERC20Detailed(name, symbol, 18) {}
}

/**
 * @title SampleCrowdsale
 * @dev This is an example of a fully fledged crowdsale.
 * The way to add new features to a base crowdsale is by multiple inheritance.
 * In this example we are providing following extensions:
 * CappedCrowdsale - sets a max boundary for raised funds
 * RefundableCrowdsale - set a min goal to be reached and returns funds if it's not met
 * MintedCrowdsale - assumes the token can be minted by the crowdsale, which does so
 * when receiving purchases.
 *
 * After adding multiple features it's good practice to run integration tests
 * to ensure that subcontracts works together as intended.
 */
// XXX There doesn't seem to be a way to split this line that keeps solium
// happy. See:
// https://github.com/duaraghav8/Solium/issues/205
// --elopio - 2018-05-10
// solium-disable-next-line max-len
contract AssetCrowdsale is TimedCrowdsale, RefundableCrowdsale, PostDeliveryCrowdsale, CappedCrowdsale {

  constructor(
    uint256 openingTime,
    uint256 closingTime,
    uint256 rate,
    address wallet,
    uint256 cap,
    ERC20Mintable token,
    uint256 goal
  )
    public
    Crowdsale(rate, wallet, token)
    PostDeliveryCrowdsale()
    RefundableCrowdsale(goal) // cap and goal are the same, as we want to sell all tokens
    TimedCrowdsale(openingTime, closingTime)
    CappedCrowdsale(cap)
  {
    //As goal needs to be met for a successful crowdsale
    //the value needs to less or equal than a cap which is limit for accepted funds
    require(goal <= cap);
  }
}
