// Dependency file: @openzeppelin/contracts/utils/Context.sol

// SPDX-License-Identifier: MIT

// pragma solidity ^0.8.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}


// Dependency file: @openzeppelin/contracts/access/Ownable.sol


// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/utils/Context.sol";
/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


// Dependency file: @openzeppelin/contracts/security/Pausable.sol


// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/utils/Context.sol";

/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
abstract contract Pausable is Context {
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by `account`.
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state.
     */
    constructor () {
        _paused = false;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view virtual returns (bool) {
        return _paused;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    modifier whenNotPaused() {
        require(!paused(), "Pausable: paused");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    modifier whenPaused() {
        require(paused(), "Pausable: not paused");
        _;
    }

    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function _pause() internal virtual whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function _unpause() internal virtual whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }
}


// Dependency file: @openzeppelin/contracts/token/ERC20/IERC20.sol


// pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// Dependency file: @openzeppelin/contracts/utils/Address.sol


// pragma solidity ^0.8.0;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain`call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: value }(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.staticcall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return _verifyCallResult(success, returndata, errorMessage);
    }

    function _verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) private pure returns(bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


// Dependency file: @openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol


// pragma solidity ^0.8.0;

// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/utils/Address.sol";

/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(IERC20 token, address spender, uint256 value) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        // solhint-disable-next-line max-line-length
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(IERC20 token, address spender, uint256 value) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


// Dependency file: @openzeppelin/contracts/security/ReentrancyGuard.sol


// pragma solidity ^0.8.0;

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor () {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and make it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}


// Root file: contracts/Allocations.sol


pragma solidity 0.8.0;

// import "@openzeppelin/contracts/access/Ownable.sol";
// import "@openzeppelin/contracts/security/Pausable.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract Allocations is Ownable, Pausable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    // SUPPLIES :: START
    uint256 public constant LIQUIDITY_SUPPLY = 6633576500 * (1 ether); //6633576500,00, 41,26%
    uint256 public constant TEAM_SUPPLY = 3014531250 * (1 ether); //3014531250,00, 18,75%
    uint256 public constant MARKETING_SUPPLY = 1848912500 * (1 ether); //1848912500,00, 11,50%,
    uint256 public constant PRESALE_SUPPLY = 1717077000 * (1 ether); //1717077000,00, 10,68%
    uint256 public constant RESERVE_SUPPLY = 1004843750 * (1 ether); //1004843750,00, 6,25%
    uint256 public constant TECHNOLOGY_SUPPLY = 803875000 * (1 ether); //803875000,00, 5%
    uint256 public constant LEGAL_SUPPLY = 562712500 * (1 ether); //562712500,00, 3,50%
    uint256 public constant ADVISOR_SUPPLY = 401937500 * (1 ether); //401937500,00, 2,5%
    uint256 public constant IDO_SUPPLY = 90034000 * (1 ether); //90034000,00, 0,56%

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

    function updatTeamWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        team = _wallet;
    }

    function updateMarketingWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        marketing = _wallet;
    }

    function updatePresaleWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        liquidity = _wallet;
    }

    function updateReserveWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        reserve = _wallet;
    }

    function updateTechnologyWallet(address _wallet) external onlyOwner {
        require(_wallet != address(0), "invalid wallet address");
        liquidity = _wallet;
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
            liquidityTimelock,
            LIQUIDITY_INITIAL_UNLOCK,
            liquidityVestingPeriod,
            liquidityCounter
        );
    }

    function updatTeamWallet() external {
        teamCounter = _grantTokens(team, TEAM_SUPPLY, teamTimelock, TEAM_INITIAL_UNLOCK, teamVestingPeriod, teamCounter);
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
        legalCounter = _grantTokens(legal, LEGAL_SUPPLY, legalTimelock, LEGAL_INITIAL_UNLOCK, legalVestingPeriod, legalCounter);
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
        idoCounter = _grantTokens(ido, IDO_SUPPLY, idoTimelock, IDO_INITIAL_UNLOCK, idoVestingPeriod, idoCounter);
    }

    /**
        internal functions
    **/
    function _grantTokens(
        address _wallet,
        uint256 _supply,
        uint256 _timelock,
        uint256 _initialUnlock,
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
