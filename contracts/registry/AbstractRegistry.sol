pragma solidity >= 0.5.0 < 0.6.0;


/**
 * @title Abstract Registry
 */
contract AbstractRegistry {

  event ServiceRegistered(address sender, address service);
  event ServiceEnabled(address sender, address service);
  event ServiceDisabled(address sender, address service);
  event AccountRegistered(address sender, address service);

  function serviceExists(address _service) public view returns (bool);

  function serviceEnabled(address _service) public view returns (bool);

  function serviceDisabled(address _service) public view returns (bool);

  function accountExists(address _account) public view returns (bool);

  function registerService(address _service, bool _canRegisterAccounts) public;

  function registerService(address _service, bool _canRegisterAccounts, bytes memory _guardianSignature) public;

  function enableService(address _service) public;

  function disableService(address _service) public;

  function registerAccount(address _account) public;
}