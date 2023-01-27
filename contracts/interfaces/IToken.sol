// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

interface IToken {
  function mint(address account, uint256 amount) external;
}
