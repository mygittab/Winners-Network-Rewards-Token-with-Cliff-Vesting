// SPDX-License-Identifier: MIT

pragma solidity 0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Allocations is Ownable, Pausable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    // SUPPLIES :: START
    uint256 public constant LIQUIDITY_SUPPLY = 6633576500 * 1e16; //66335765,00, 41,26%
    uint256 public constant TEAM_SUPPLY = 3014531250 * 1e16; //30145312,5, 18,75%
    uint256 public constant MARKETING_SUPPLY = 1848912500 * 1e16; //18489125, 11,50%,
    uint256 public constant PRESALE_SUPPLY = 1717077000 * 1e16; //17170770, 10,68%
    uint256 public constant RESERVE_SUPPLY = 1004843750 * 1e16; //10048437,50, 6,25%
    uint256 public constant TECHNOLOGY_SUPPLY = 803875000 * 1e16; //8038750, 5%
    uint256 public constant LEGAL_SUPPLY = 562712500 * 1e16; //5627125, 3,50%
    uint256 public constant ADVISOR_SUPPLY = 401937500 * 1e16; //4019375, 2,5%
    uint256 public constant IDO_SUPPLY = 90034000 * 1e16; //900340 0,56%

    // SUPPLIES :: CLIFF
    uint256 public constant LIQUIDITY_CLIFF_PERIOD = 30 days; //1 month
    uint256 public constant TEAM_CLIFF_PERIOD = 0; //none
    uint256 public constant MARKETING_CLIFF_PERIOD = 0; //none
    uint256 public constant PRESALE_CLIFF_PERIOD = 0; //none
    uint256 public constant RESERVE_CLIFF_PERIOD = 365 days; //12 month
    uint256 public constant TECHNOLOGY_CLIFF_PERIOD = 0; //none
    uint256 public constant LEGAL_CLIFF_PERIOD = 0; //none
    uint256 public constant ADVISOR_CLIFF_PERIOD = 0; //none
    uint256 public constant IDO_CLIFF_PERIOD = 0; //none

    //SUPPLIES :: END
    uint256 public liquidityTimelock;
    uint256 public teamTimelock;
    uint256 public marketingTimelock;
    uint256 public presaleTimelock;
    uint256 public reserveTimelock;
    uint256 public technologyTimelock;
    uint256 public legalTimelock;
    uint256 public advisorTimelock;
    uint256 public idoTimelock;

    //SUPPLUES :: INITIALLY
    uint256 public constant LIQUIDITY_INITIAL_UNLOCK = 0; // none
    uint256 public constant TEAM_INITIAL_UNLOCK = 15 * 1e16; //15%
    uint256 public constant MARKETING_INITIAL_UNLOCK = 1 ether; //100%
    uint256 public constant PRESALE_INITIAL_UNLOCK = 15 * 1e16; //15%
    uint256 public constant RESERVE_INITIAL_UNLOCK = 0; //none
    uint256 public constant TECHNOLOGY_INITIAL_UNLOCK = 25 * 1e16; //25%
    uint256 public constant LEGAL_INITIAL_UNLOCK = 25 * 1e16; //25%
    uint256 public constant ADVISOR_INITIAL_UNLOCK = 25 * 1e16; //25%
    uint256 public constant IDO_INITIAL_UNLOCK = 1 ether; //100%

    uint256 public threshold = 100000; //

    //MONTHS
    uint256 public liquidityVestingPeriod = 10; //10% for 10 months
    uint256 public teamVestingPeriod = 17; //5% for 17 months (rest 85%), 15% initially
    uint256 public presaleVestingPeriod = 0; //none
    uint256 public marketingVestingPeriod = 17; //5% for 17 months (rest 85%), 15% initially
    uint256 public reserveVestingPeriod = 12; //8.33% each month for 12 months(100%)
    uint256 public technologyVestingPeriod = 3; //25% for 3 months (75%), 25% initially
    uint256 public legalVestingPeriod = 3; //25% for 3 months (75%), 25% initially
    uint256 public advisorVestingPeriod = 3; //25% for 3 months (75%), 25% initially
    uint256 public idoVestingPeriod = 0; //none

    //WALLETS
    address public liquidity;
    address public team;
    address public marketing;
    address public presale;
    address public reserve;
    address public technology;
    address public legal;
    address public advisor;
    address public ido;

    //COUNTERS
    uint256 public liquidityCounter;
    uint256 public teamCounter;
    uint256 public marketingCounter;
    uint256 public presaleCounter;
    uint256 public reserveCounter;
    uint256 public technologyCounter;
    uint256 public legalCounter;
    uint256 public advisorCounter;
    uint256 public idoCounter;

    //PUBLIC VARS
    IERC20 public token;
    uint256 startTime;

    constructor(uint256 _startTime, IERC20 _token) {
        require(address(_token) != address(0), "invalid token address");

        require(_startTime != 0, "invalid start time");

        token = _token;
        startTime = _startTime;

        _initializeTimelock(_startTime);
    }

    /**
        Update wallet functions
    **/
    function updateLiquidityWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        liquidity = _wallet;
    }

    function updateTeamWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        team = _wallet;
    }

    function updateMarketingWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        marketing = _wallet;
    }

    function updatePresaleWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        presale = _wallet;
    }

    function updateReserveWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        reserve = _wallet;
    }

    function updateTechnologyWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        technology = _wallet;
    }

    function updateLegalWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        legal = _wallet;
    }

    function updateAdvisorWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        advisor = _wallet;
    }

    function updateIdoWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        ido = _wallet;
    }

    /**
        update public varibles
    **/

    function updateToken(IERC20 _token) external onlyOwner {
        require(address(_token) != address(0), "invalid token address");
        token = _token;
    }

    function updateStartTime(uint256 _startTime) external onlyOwner {
        require(_startTime != 0, "invalid start time");
        startTime = _startTime;
        _initializeTimelock(_startTime);
    }

    function updateThreshold(uint256 _threshold) external onlyOwner {
        threshold = _threshold;
    }

    /**
        grant tokens
    **/

    function grantToLiquidityWallet() external {
        liquidityCounter = _grantTokens(
            liquidity,
            LIQUIDITY_SUPPLY,
            LIQUIDITY_INITIAL_UNLOCK,
            liquidityTimelock,
            liquidityVestingPeriod,
            liquidityCounter
        );
    }

    function grantToTeamWallet() external {
        teamCounter = _grantTokens(team, TEAM_SUPPLY, TEAM_INITIAL_UNLOCK, teamTimelock, teamVestingPeriod, teamCounter);
    }

    function grantToMarketingWallet() external {
        teamCounter = _grantTokens(
            marketing,
            MARKETING_SUPPLY,
            MARKETING_INITIAL_UNLOCK,
            marketingTimelock,
            marketingVestingPeriod,
            marketingCounter
        );
    }

    function grantToPresaleWallet() external {
        presaleCounter = _grantTokens(
            presale,
            PRESALE_SUPPLY,
            PRESALE_INITIAL_UNLOCK,
            presaleTimelock,
            presaleVestingPeriod,
            presaleCounter
        );
    }

    function grantToReserveWallet() external {
        reserveCounter = _grantTokens(
            reserve,
            RESERVE_SUPPLY,
            RESERVE_INITIAL_UNLOCK,
            reserveTimelock,
            reserveVestingPeriod,
            reserveCounter
        );
    }

    function grantToTechnologyWallet() external {
        technologyCounter = _grantTokens(
            technology,
            TECHNOLOGY_SUPPLY,
            TECHNOLOGY_INITIAL_UNLOCK,
            technologyTimelock,
            technologyVestingPeriod,
            technologyCounter
        );
    }

    function grantToLegalWallet() external {
        legalCounter = _grantTokens(legal, LEGAL_SUPPLY, LEGAL_INITIAL_UNLOCK, legalTimelock, legalVestingPeriod, legalCounter);
    }

    function grantToAdvisorWallet() external {
        advisorCounter = _grantTokens(
            advisor,
            ADVISOR_SUPPLY,
            ADVISOR_INITIAL_UNLOCK,
            advisorTimelock,
            advisorVestingPeriod,
            advisorCounter
        );
    }

    function grantToIdoWallet() external {
        idoCounter = _grantTokens(ido, IDO_SUPPLY, IDO_INITIAL_UNLOCK,  idoTimelock, idoVestingPeriod, idoCounter);
    }

    /**
        internal functions
    **/
    function _grantTokens(
        address _wallet,
        uint256 _supply,
        uint256 _initialUnlock,
        uint256 _timelock,
        uint256 _period,
        uint256 _counter
    ) internal nonReentrant returns (uint256 _newCounter) {
        uint256 _amountToClaim = 0;
        if (_initialUnlock != 0) {
            _amountToClaim = (_supply * _initialUnlock) / 1 ether; //initial percent
        }

        if (_period != 0) {
            //checking cliff, monthes
            if ((_counter < _period) && (_timelock < block.timestamp)) {
                uint256 monthsFromStart = (block.timestamp - startTime) / 30 days; //months from start
                uint256 unlockAmount = (_supply / _period) * monthsFromStart; //current unlock amounts

                _newCounter = _counter + monthsFromStart;

                _amountToClaim = _amountToClaim + unlockAmount;
            }
        }

        if ((_amountToClaim > 0) && ((token.balanceOf(address(this)) - threshold) >= _amountToClaim)) {
            token.safeTransfer(_wallet, _amountToClaim);
        }
    }

    function _initializeTimelock(uint256 _startTime) internal {
        liquidityTimelock = _startTime + LIQUIDITY_CLIFF_PERIOD;
        teamTimelock = _startTime + TEAM_CLIFF_PERIOD;
        marketingTimelock = _startTime + MARKETING_CLIFF_PERIOD;
        presaleTimelock = _startTime + PRESALE_CLIFF_PERIOD;
        reserveTimelock = _startTime + RESERVE_CLIFF_PERIOD;
        technologyTimelock = _startTime + TECHNOLOGY_CLIFF_PERIOD;
        advisorTimelock = _startTime + ADVISOR_CLIFF_PERIOD;
        legalTimelock = _startTime + LEGAL_CLIFF_PERIOD;
        idoTimelock = _startTime + IDO_CLIFF_PERIOD;
    }
}
