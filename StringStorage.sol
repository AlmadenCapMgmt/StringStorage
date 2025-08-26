// SPDX-License-Identifier: MIT
  pragma solidity ^0.8.24;

  contract StringStorage {
      // Private variable to store the string data
      string private storedString;

      // Public variable to track the contract owner
      address public owner;

      // Event emitted when a string is stored
      event StringStored(string indexed value, address indexed sender);

      // Event emitted when ownership is transferred
      event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

      // Modifier to restrict access to owner-only functions
      modifier onlyOwner() {
          require(msg.sender == owner, "Only owner can call this function");
          _;
      }

      // Constructor sets the deployer as the initial owner
      constructor() {
          owner = msg.sender;
          emit OwnershipTransferred(address(0), msg.sender);
      }

      // Function to store a new string (owner-only)
      // @param newString The string value to store
      function setString(string memory newString) public onlyOwner {
          storedString = newString;
          emit StringStored(newString, msg.sender);
      }

      // Function to retrieve the stored string (public access)
      // @return The currently stored string
      function getString() public view returns (string memory) {
          return storedString;
      }

      // Function to transfer ownership to a new address (owner-only)
      // @param newOwner The address to transfer ownership to
      function transferOwnership(address newOwner) public onlyOwner {
          require(newOwner != address(0), "New owner cannot be zero address");
          address previousOwner = owner;
          owner = newOwner;
          emit OwnershipTransferred(previousOwner, newOwner);
      }
  }
