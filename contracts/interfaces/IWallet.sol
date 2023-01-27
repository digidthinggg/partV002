// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

interface IWallet {
  function startTransfer(address receiver, uint256 amount) external;
  function startTransferFrom(address sender, address receiver, uint256 amount) external;
}
