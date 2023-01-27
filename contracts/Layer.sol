// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Layer {
  string public layerType;

  bool public started;
  bool public success;
  bool public failure;

  constructor() {
  }

  function setLayerType(string memory _layerType) public virtual {
    layerType = _layerType;
  }

  function executeStarted() public virtual {
    started = true;
    success = false;
    failure = false;
  }

  function executeSuccess() public virtual {
    started = false;
    success = true;
    failure = false;
  }

  function executeFailure() public virtual {
    started = false;
    success = false;
    failure = true;
  }
}
