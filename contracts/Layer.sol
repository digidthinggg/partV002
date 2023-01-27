// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/IWallet.sol";

contract Layer {
  address walletAddr;

  function setWalletAddress(address _walletAddr) public virtual {
    walletAddr = _walletAddr;
  }

  string public layerType;

  bool public started;
  bool public success;
  bool public failure;

  constructor() {
    //
  }

  function setLayerType(string memory _layerType) public virtual {
    layerType = _layerType;
  }

  function executeStarted() public virtual {
    started = true;
    success = false;
    failure = false;

    IWallet(walletAddr).handleLayerStarted();
  }

  function executeSuccess() public virtual {
    started = false;
    success = true;
    failure = false;
    
    IWallet(walletAddr).handleLayerSuccess();
  }

  function executeFailure() public virtual {
    started = false;
    success = false;
    failure = true;

    IWallet(walletAddr).handleLayerFailure();
  }
}
