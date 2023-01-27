// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/IToken.sol";

import "./Layer.sol";

contract Wallet {
  address tokenAddr;

  function setTokenAddress(address _tokenAddr) public virtual {
    tokenAddr = _tokenAddr;
  }

  function getTokenAddress() public virtual returns (address) {
    return tokenAddr;
  }

  event Receive(address sender, uint amount, uint balance);

  event StartTransfer(address receiver, uint256 amount);

  address payable public owner;

  constructor() {
    owner = payable(msg.sender);
  }

  receive() external payable {
    emit Receive(msg.sender, msg.value, address(this).balance);

    address sender = msg.sender;
    uint256 amount = msg.value;
    mintSmartTokensForTokens(sender, amount);
  }

  function mintSmartTokensForTokens(address sender, uint256 amount) private {
    require(tokenAddr != address(0), "uninitialized tokenAddr");

    IToken(tokenAddr).mint(sender, amount);
  }

  Layer[] addLayerRequirements;
  Layer[] updateLayerRequirements;
  Layer[] removeLayerRequirements;

  Layer[] transferRequirements;

  struct Transfer {
    uint256 transferNum;
    address receiver;
    uint256 amount;
    Layer[] layers;
    bool executed;
  }

  Transfer[] transfers;

  uint256 lastTransferNum;

  function startTransfer(address receiver, uint256 amount) external {
    _startTransfer(receiver, amount);
  }
  
  function startTransferFrom(address sender, address receiver, uint256 amount) external {
    _startTransfer(receiver, amount);
  }

  function _startTransfer(address receiver, uint256 amount) private {
    emit StartTransfer(receiver, amount);

    Transfer memory transfer = Transfer({
      transferNum: lastTransferNum + 1,
      receiver: receiver,
      amount: amount,
      layers: transferRequirements,
      executed: false
    });

    transfers.push(transfer);

    executeLayers(transfer);
  }

  event LogLayer(uint layerNum, string layerType, bool started, bool success, bool failure);
  event HandleLayerStarted(uint layerNum, string layerType, bool started, bool success, bool failure);
  event HandleLayerSuccess(uint layerNum, string layerType, bool started, bool success, bool failure);
  event HandleLayerFailure(uint layerNum, string layerType, bool started, bool success, bool failure);

  function initTransferRequirements() public virtual {
    Layer a = new Layer();
    a.setLayerType("email");

    Layer b = new Layer();
    b.setLayerType("sms");

    Layer c = new Layer();
    c.setLayerType("transaction");

    // Layer Success
    // Layer Faiure
    // Need way to receive those events here
    // Pass callback ?

    transferRequirements.push(a);
    transferRequirements.push(b);
    transferRequirements.push(c);

    for (uint i = 0; i < transferRequirements.length; i++) {
      Layer layer = transferRequirements[i];
      string memory layerType = layer.layerType();
      bool started = layer.started();
      bool success = layer.success();
      bool failure = layer.failure();
      emit LogLayer(i, layerType, started, success, failure);
    }
  }

  function addLayer() private {
    //
  }

  function updateLayer() private {
    //
  }

  function removeLayer() private {
    //
  }

  function executeLayers(Transfer memory _transfer) private {
    for (uint i = 0; i < _transfer.layers.length; i++) {
      Layer layer = _transfer.layers[i];
      
      layer.executeStarted();
    }
  }

  function handleLayerStarted() external {
    emit HandleLayerStarted(0, "sms", true, true, true);
  }

  function handleLayerSuccess() external {
    emit HandleLayerSuccess(0, "sms", true, true, true);

    // for each transfer in transfers
    //   get transfer
    //     for each layer in transfer
    //       check if all layers are success
    //         if are then execute transfer
    //       otherwise ?
    // or something..
  }

  function handleLayerFailure() external {
    emit HandleLayerFailure(0, "sms", true, true, true);

    // for each transfer in trnsfers
    //   get transfer
    //     something...
  }

  function executeTransfer() private {

    //
  }
}
