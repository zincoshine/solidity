pragma solidity ^0.5.2;

import "./AbstractAccount.sol";


/**
 * @title Account
 */
contract Account is AbstractAccount {

  modifier onlyOwner() {
    require(
      devices[msg.sender].isOwner
    );

    _;
  }

  constructor() public {
    devices[msg.sender].isOwner = true;
    devices[msg.sender].exists = true;
    devices[msg.sender].existed = true;
  }

  function() external payable {
    //
  }

  function addDevice(address _device, bool _isOwner) onlyOwner public {
    require(
      _device != address(0)
    );
    require(
      !devices[_device].exists
    );

    devices[_device].isOwner = _isOwner;
    devices[_device].exists = true;
    devices[_device].existed = true;

    emit DeviceAdded(_device, _isOwner);
  }

  function removeDevice(address _device) onlyOwner public {
    require(
      devices[_device].exists
    );

    devices[_device].isOwner = false;
    devices[_device].exists = false;

    emit DeviceRemoved(_device);
  }

  function executeTransaction(address payable _recipient, uint256 _value, bytes memory _data) onlyOwner public returns (bytes memory _response) {
    require(
      _recipient != address(0)
    );

    bool _succeeded;
    (_succeeded, _response) = _recipient.call.value(_value)(_data);

    require(
      _succeeded
    );

    emit TransactionExecuted(_recipient, _value, _data, _response);
  }
}
