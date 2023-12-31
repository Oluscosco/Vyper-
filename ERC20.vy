# @dev Implementation of ERC-20 token standard.
# @author Olubola Morgan

Transfer: event({_from: indexed(address), _to: indexed(address), _value: uint256})
Approval: event({_owner: indexed(address), _spender: indexed(address), _value: uint256})

name: public(bytes[40])
symbol: public(bytes[5])
decimals: public(uint256)
balances: map(address, uint256)
allowances: map(address, map(address, uint256))
total_supply: uint256


@public
def __init__(_name: bytes[40], _symbol: bytes[5], _decimals: uint256, _supply: uint256):
    init_supply: uint256 = _supply * 10 ** _decimals
    self.name = _name
    self.symbol = _symbol
    self.decimals = _decimals
    self.balances[msg.sender] = init_supply
    self.total_supply = init_supply
    log.Transfer(ZERO_ADDRESS, msg.sender, init_supply)


@public
@constant
def totalSupply() -> uint256:

    return self.total_supply


@public
@constant
def balanceOf(_owner : address) -> uint256:

    return self.balances[_owner]


@public
@constant
def allowance(_owner : address, _spender : address) -> uint256:

    return self.allowances[_owner][_spender]


@public
def transfer(_to : address, _value : uint256) -> bool:

    self.balances[msg.sender] -= _value
    self.balances[_to] += _value
    log.Transfer(msg.sender, _to, _value)
    return True


@public
def transferFrom(_from : address, _to : address, _value : uint256) -> bool:
 
    self.balances[_from] -= _value
    self.balances[_to] += _value
    self.allowances[_from][msg.sender] -= _value
    log.Transfer(_from, _to, _value)
    return True


@public
def approve(_spender : address, _value : uint256) -> bool:
 
    self.allowances[msg.sender][_spender] = _value
    log.Approval(msg.sender, _spender, _value)
    return True
