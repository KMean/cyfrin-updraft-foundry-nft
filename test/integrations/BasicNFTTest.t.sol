// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public user1 = makeAddr("user1");
    address public user2 = makeAddr("user2");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        // could do this assertEq(basicNft.name(), "Doggy");
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(user1);
        basicNft.mintNft(PUG);
        vm.prank(user2);
        basicNft.mintNft(PUG);
        assert(basicNft.balanceOf(user1) == 1);
        assert(basicNft.balanceOf(user2) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(1))));
    }

    function testTokenUriForInvalidTokenId() public {
        vm.expectRevert();
        basicNft.tokenURI(999);
    }

    function testCannotMintWithoutPrank() public {
        vm.expectRevert();
        basicNft.mintNft(PUG);
    }

    function testMintIncrementsTokenId() public {
        vm.prank(user1);
        basicNft.mintNft(PUG);
        vm.prank(user1);
        basicNft.mintNft(PUG);
        assert(basicNft.balanceOf(user1) == 2);
        assert(basicNft.getTokenCounter() == 2);
    }

    function testOwnerOfToken() public {
        vm.prank(user1);
        basicNft.mintNft(PUG);
        address tokenOwner = basicNft.ownerOf(0);
        assert(tokenOwner == user1);
    }

    function testTransferToken() public {
        vm.prank(user1);
        basicNft.mintNft(PUG);

        vm.prank(user1);
        basicNft.safeTransferFrom(user1, user2, 0);
        assert(basicNft.balanceOf(user1) == 0);
        assert(basicNft.balanceOf(user2) == 1);
        assert(basicNft.ownerOf(0) == user2);
    }

    function testCannotTransferWithoutApproval() public {
        vm.prank(user1);
        basicNft.mintNft(PUG);

        vm.prank(user2);
        vm.expectRevert();
        basicNft.safeTransferFrom(user1, user2, 0);
    }

    function testApproveAndTransfer() public {
        vm.prank(user1);
        basicNft.mintNft(PUG);

        vm.prank(user1);
        basicNft.approve(user2, 0);

        vm.prank(user2);
        basicNft.safeTransferFrom(user1, user2, 0);

        assert(basicNft.balanceOf(user1) == 0);
        assert(basicNft.balanceOf(user2) == 1);
        assert(basicNft.ownerOf(0) == user2);
    }
}
