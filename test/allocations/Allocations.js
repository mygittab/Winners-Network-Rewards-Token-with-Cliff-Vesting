const {
  balance,
  BN,
  expectEvent,
  expectRevert,
  ether,
  time,
} = require("@openzeppelin/test-helpers");

const WinsToken = artifacts.require("WINS");
const Allocations = artifacts.require("Allocations");

contract("Allocations", function (accounts) {
  describe("Supply", function () {
    const [
      owner,
      wallet,
      liquidity,
      team,
      marketing,
      presale,
      reserve,
      technology,
      legal,
      advisor,
      ido,
    ] = accounts;

    const from = owner;
    const name = "Winners Network Rewards Token";
    const symbol = "WINS";
    const initialSupply = ether("180000000");

    const allocationsSupply = ether("160775000");

    beforeEach(async function () {
      this.token = await WinsToken.new(name, symbol, initialSupply, {
        from: from,
      });

      const startTime = (await time.latest()).add(time.duration.weeks(1));

      this.allocations = await Allocations.new(startTime, this.token.address, {
        from: from,
      });

      await this.token.transfer(this.allocations.address, allocationsSupply, {
        from: from,
      });
    });

    it("has a total supply - 160 775 000 ", async function () {
      expect(
        await this.token.balanceOf(this.allocations.address)
      ).to.be.bignumber.equal(allocationsSupply);
    });

    it("has a liquidity supply -  41,26% 6 633 765", async function () {
      expect(await this.allocations.LIQUIDITY_SUPPLY()).to.be.bignumber.equal(
        ether("66335765")
      );
    });

    it("has a team supply -  18,75% 30 145 312, 5", async function () {
      expect(await this.allocations.TEAM_SUPPLY()).to.be.bignumber.equal(
        ether("30145312.5")
      );
    });

    it("has a marketing supply -  11,50% 18 489 125", async function () {
      expect(await this.allocations.MARKETING_SUPPLY()).to.be.bignumber.equal(
        ether("18489125")
      );
    });

    it("has a presale supply -  10,68% 17 170 770", async function () {
      expect(await this.allocations.PRESALE_SUPPLY()).to.be.bignumber.equal(
        ether("17170770")
      );
    });

    it("has a reserve supply -  6,25% 10 048 437,5", async function () {
      expect(await this.allocations.RESERVE_SUPPLY()).to.be.bignumber.equal(
        ether("10048437.5")
      );
    });

    it("has a technology supply -  5% 8 038 750", async function () {
      expect(await this.allocations.TECHNOLOGY_SUPPLY()).to.be.bignumber.equal(
        ether("8038750")
      );
    });

    it("has a legal supply -  3,50% 5 627 125", async function () {
      expect(await this.allocations.LEGAL_SUPPLY()).to.be.bignumber.equal(
        ether("5627125")
      );
    });

    it("has a advisor supply -  2,5% 4 019 375", async function () {
      expect(await this.allocations.ADVISOR_SUPPLY()).to.be.bignumber.equal(
        ether("4019375")
      );
    });

    it("has a ido supply -  0,56% 900 340", async function () {
      expect(await this.allocations.IDO_SUPPLY()).to.be.bignumber.equal(
        ether("900340")
      );
    });
  });

  describe("Change Wallet Process", function () {
    const [
      owner,
      wallet,
      liquidity,
      team,
      marketing,
      presale,
      reserve,
      technology,
      legal,
      advisor,
      ido,
    ] = accounts;

    const from = owner;
    const name = "Winners Network Rewards Token";
    const symbol = "WINS";
    const initialSupply = ether("180000000");

    const allocationsSupply = ether("160775000");

    beforeEach(async function () {
      this.token = await WinsToken.new(name, symbol, initialSupply, {
        from: from,
      });

      const startTime = (await time.latest()).add(time.duration.weeks(1));

      this.allocations = await Allocations.new(startTime, this.token.address, {
        from: from,
      });

      await this.token.transfer(this.allocations.address, allocationsSupply, {
        from: from,
      });
    });

    it("owner can update liquidity wallet", async function () {
      await this.allocations.updateLiquidityWallet(liquidity, { from: from });
      expect(await this.allocations.liquidity()).to.be.equal(liquidity);
    });

    it("owner can update team wallet", async function () {
      await this.allocations.updateTeamWallet(team, { from: from });
      expect(await this.allocations.team()).to.be.equal(team);
    });

    it("owner can update marketing wallet", async function () {
      await this.allocations.updateMarketingWallet(marketing, { from: from });
      expect(await this.allocations.marketing()).to.be.equal(marketing);
    });

    it("owner can update presale wallet", async function () {
      await this.allocations.updatePresaleWallet(presale, { from: from });
      expect(await this.allocations.presale()).to.be.equal(presale);
    });

    it("owner can update reserve wallet", async function () {
      await this.allocations.updateReserveWallet(reserve, { from: from });
      expect(await this.allocations.reserve()).to.be.equal(reserve);
    });

    it("owner can update technology wallet", async function () {
      await this.allocations.updateTechnologyWallet(technology, { from: from });
      expect(await this.allocations.technology()).to.be.equal(technology);
    });

    it("owner can update legal wallet", async function () {
      await this.allocations.updateLegalWallet(legal, { from: from });
      expect(await this.allocations.legal()).to.be.equal(legal);
    });

    it("owner can update advisor wallet", async function () {
      await this.allocations.updateAdvisorWallet(advisor, { from: from });
      expect(await this.allocations.advisor()).to.be.equal(advisor);
    });

    it("owner can update ido wallet", async function () {
      await this.allocations.updateIdoWallet(ido, { from: from });
      expect(await this.allocations.ido()).to.be.equal(ido);
    });

    /*
        only owner can update
    */

    it("only owner can update liquidity wallet", async function () {
      await expectRevert(
        this.allocations.updateLiquidityWallet(liquidity, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });

    it("only owner can update team wallet", async function () {
      await expectRevert(
        this.allocations.updateTeamWallet(team, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });

    it("only owner can update marketing wallet", async function () {
      await expectRevert(
        this.allocations.updateMarketingWallet(marketing, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });

    it("only owner can update presale wallet", async function () {
      await expectRevert(
        this.allocations.updatePresaleWallet(presale, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });

    it("only owner can update reserve wallet", async function () {
      await expectRevert(
        this.allocations.updateReserveWallet(reserve, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });

    it("only owner can update technology wallet", async function () {
      await expectRevert(
        this.allocations.updateTechnologyWallet(technology, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });

    it("only owner can update legal wallet", async function () {
      await expectRevert(
        this.allocations.updateLegalWallet(legal, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });

    it("only owner can update advisor wallet", async function () {
      await expectRevert(
        this.allocations.updateAdvisorWallet(advisor, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });

    it("only owner can update ido wallet", async function () {
      await expectRevert(
        this.allocations.updateIdoWallet(ido, {
          from: wallet,
        }),
        "Ownable: caller is not the owner"
      );
    });
  });

  describe("Cliff Period Validation", function () {
    const [
      owner,
      wallet,
      liquidity,
      team,
      marketing,
      presale,
      reserve,
      technology,
      legal,
      advisor,
      ido,
    ] = accounts;

    const from = owner;
    const name = "Winners Network Rewards Token";
    const symbol = "WINS";
    const initialSupply = ether("180000000");

    const allocationsSupply = ether("160775000");

    beforeEach(async function () {
      this.token = await WinsToken.new(name, symbol, initialSupply, {
        from: from,
      });

      this.startTime = (await time.latest()).add(time.duration.weeks(1));

      this.allocations = await Allocations.new(
        this.startTime,
        this.token.address,
        {
          from: from,
        }
      );

      await this.token.transfer(this.allocations.address, allocationsSupply, {
        from: from,
      });
    });

    it("should has 30 days liquidity cliff", async function () {
      const cliff = await this.allocations.LIQUIDITY_CLIFF_PERIOD();
      expect(await this.allocations.liquidityTimelock()).to.be.bignumber.equal(
        this.startTime.add(cliff)
      );
    });

    it("should has 30 days liquidity cliff", async function () {
      const cliff = await this.allocations.LIQUIDITY_CLIFF_PERIOD();
      expect(cliff).to.be.bignumber.equal(time.duration.days(30));
      expect(await this.allocations.liquidityTimelock()).to.be.bignumber.equal(
        this.startTime.add(cliff)
      );
    });

    it("should has 0 days team cliff", async function () {
      expect(await this.allocations.teamTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days marketing cliff", async function () {
      expect(await this.allocations.marketingTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days presale cliff", async function () {
      expect(await this.allocations.presaleTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 365 days reserve cliff", async function () {
      const cliff = await this.allocations.RESERVE_CLIFF_PERIOD();
      expect(cliff).to.be.bignumber.equal(time.duration.days(365));
      expect(await this.allocations.reserveTimelock()).to.be.bignumber.equal(
        this.startTime.add(cliff)
      );
    });

    it("should has 0 days technology cliff", async function () {
      expect(await this.allocations.technologyTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days legal cliff", async function () {
      expect(await this.allocations.legalTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days advisor cliff", async function () {
      expect(await this.allocations.advisorTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days ido cliff", async function () {
      expect(await this.allocations.idoTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });
  });

  describe("Cliff Period Validation after change start time", function () {
    const [
      owner,
      wallet,
      liquidity,
      team,
      marketing,
      presale,
      reserve,
      technology,
      legal,
      advisor,
      ido,
    ] = accounts;

    const from = owner;
    const name = "Winners Network Rewards Token";
    const symbol = "WINS";
    const initialSupply = ether("180000000");

    const allocationsSupply = ether("160775000");

    beforeEach(async function () {
      this.token = await WinsToken.new(name, symbol, initialSupply, {
        from: from,
      });

      this.startTime = (await time.latest()).add(time.duration.weeks(1));

      this.allocations = await Allocations.new(
        this.startTime,
        this.token.address,
        {
          from: from,
        }
      );

      await this.token.transfer(this.allocations.address, allocationsSupply, {
        from: from,
      });

      this.startTime = this.startTime.add(time.duration.weeks(2));

      await this.allocations.updateStartTime(this.startTime, { from: from });
    });

    it("only owner can update start time", async function () {
      await expectRevert(
        this.allocations.updateStartTime(this.startTime, { from: wallet }),
        "Ownable: caller is not the owner"
      );
    });

    it("should has 30 days liquidity cliff", async function () {
      const cliff = await this.allocations.LIQUIDITY_CLIFF_PERIOD();
      expect(await this.allocations.liquidityTimelock()).to.be.bignumber.equal(
        this.startTime.add(cliff)
      );
    });

    it("should has 30 days liquidity cliff", async function () {
      const cliff = await this.allocations.LIQUIDITY_CLIFF_PERIOD();
      expect(cliff).to.be.bignumber.equal(time.duration.days(30));
      expect(await this.allocations.liquidityTimelock()).to.be.bignumber.equal(
        this.startTime.add(cliff)
      );
    });

    it("should has 0 days team cliff", async function () {
      expect(await this.allocations.teamTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days marketing cliff", async function () {
      expect(await this.allocations.marketingTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days presale cliff", async function () {
      expect(await this.allocations.presaleTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 365 days reserve cliff", async function () {
      const cliff = await this.allocations.RESERVE_CLIFF_PERIOD();
      expect(cliff).to.be.bignumber.equal(time.duration.days(365));
      expect(await this.allocations.reserveTimelock()).to.be.bignumber.equal(
        this.startTime.add(cliff)
      );
    });

    it("should has 0 days technology cliff", async function () {
      expect(await this.allocations.technologyTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days legal cliff", async function () {
      expect(await this.allocations.legalTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days advisor cliff", async function () {
      expect(await this.allocations.advisorTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });

    it("should has 0 days ido cliff", async function () {
      expect(await this.allocations.idoTimelock()).to.be.bignumber.equal(
        this.startTime
      );
    });
  });

  describe("Initial allocations", function () {
    const [
      owner,
      wallet,
      liquidity,
      team,
      marketing,
      presale,
      reserve,
      technology,
      legal,
      advisor,
      ido,
    ] = accounts;

    const from = owner;
    const name = "Winners Network Rewards Token";
    const symbol = "WINS";
    const initialSupply = ether("180000000");

    const allocationsSupply = ether("160775000");

    beforeEach(async function () {
      this.token = await WinsToken.new(name, symbol, initialSupply, {
        from: from,
      });

      this.startTime = (await time.latest()).add(time.duration.weeks(1));

      this.allocations = await Allocations.new(
        this.startTime,
        this.token.address,
        {
          from: from,
        }
      );

      await this.token.transfer(this.allocations.address, allocationsSupply, {
        from: from,
      });
    });

    it("should has 0 liquidity initial allocation", async function () {
      await this.allocations.updateLiquidityWallet(liquidity, { from: from });

      expect(await this.token.balanceOf(liquidity)).to.be.bignumber.equal(
        ether("0")
      );

      await this.allocations.grantToLiquidityWallet({ from: from });

      expect(await this.token.balanceOf(liquidity)).to.be.bignumber.equal(
        ether("0")
      );
    });

    it("should has 15% team initial allocation", async function () {
      await this.allocations.updateTeamWallet(team, { from: from });

      expect(await this.token.balanceOf(team)).to.be.bignumber.equal(
        ether("0")
      );

      await this.allocations.grantToTeamWallet({ from: from });
      const supply = await this.allocations.TEAM_SUPPLY();
      const initialUnlock = await this.allocations.TEAM_INITIAL_UNLOCK(); //percent

      expect(initialUnlock).to.be.bignumber.equal(ether("0.15")); //15%

      const percent = supply.mul(initialUnlock).div(ether("1"));

      expect(await this.token.balanceOf(team)).to.be.bignumber.equal(percent);
    });

    it("should has 100% marketing initial allocation", async function () {
      await this.allocations.updateMarketingWallet(marketing, { from: from });
      expect(await this.token.balanceOf(marketing)).to.be.bignumber.equal(
        ether("0")
      );
      await this.allocations.grantToMarketingWallet({ from: from });
      const supply = await this.allocations.MARKETING_SUPPLY();
      const initialUnlock = await this.allocations.MARKETING_INITIAL_UNLOCK(); //percent, 100%

      expect(initialUnlock).to.be.bignumber.equal(ether("1"));

      const percent = supply.mul(initialUnlock).div(ether("1"));

      expect(await this.token.balanceOf(marketing)).to.be.bignumber.equal(
        percent
      );
    });

    it("should has 15% presale initial allocation", async function () {
      await this.allocations.updatePresaleWallet(presale, { from: from });

      expect(await this.token.balanceOf(presale)).to.be.bignumber.equal(
        ether("0")
      );

      await this.allocations.grantToPresaleWallet({ from: from });
      const supply = await this.allocations.PRESALE_SUPPLY();
      const initialUnlock = await this.allocations.PRESALE_INITIAL_UNLOCK(); //percent

      expect(initialUnlock).to.be.bignumber.equal(ether("0.15")); //15%

      const percent = supply.mul(initialUnlock).div(ether("1"));

      expect(await this.token.balanceOf(presale)).to.be.bignumber.equal(
        percent
      );
    });

    it("should has 0% reserve initial allocation", async function () {
      await this.allocations.updateReserveWallet(reserve, { from: from });

      expect(await this.token.balanceOf(reserve)).to.be.bignumber.equal(
        ether("0")
      );

      await this.allocations.grantToReserveWallet({ from: from });

      expect(await this.token.balanceOf(reserve)).to.be.bignumber.equal(
        ether("0")
      );
    });

    it("should has 25% technology initial allocation", async function () {
      await this.allocations.updateTechnologyWallet(technology, { from: from });

      expect(await this.token.balanceOf(technology)).to.be.bignumber.equal(
        ether("0")
      );

      await this.allocations.grantToTechnologyWallet({ from: from });
      const supply = await this.allocations.TECHNOLOGY_SUPPLY();
      const initialUnlock = await this.allocations.TECHNOLOGY_INITIAL_UNLOCK(); //percent

      expect(initialUnlock).to.be.bignumber.equal(ether("0.25")); //25%

      const percent = supply.mul(initialUnlock).div(ether("1"));

      expect(await this.token.balanceOf(technology)).to.be.bignumber.equal(
        percent
      );
    });

    it("should has 25% legal initial allocation", async function () {
      await this.allocations.updateLegalWallet(legal, { from: from });

      expect(await this.token.balanceOf(legal)).to.be.bignumber.equal(
        ether("0")
      );

      await this.allocations.grantToLegalWallet({ from: from });
      const supply = await this.allocations.LEGAL_SUPPLY();
      const initialUnlock = await this.allocations.LEGAL_INITIAL_UNLOCK(); //percent

      expect(initialUnlock).to.be.bignumber.equal(ether("0.25")); //25%

      const percent = supply.mul(initialUnlock).div(ether("1"));

      expect(await this.token.balanceOf(legal)).to.be.bignumber.equal(percent);
    });

    it("should has 25% advisor initial allocation", async function () {
      await this.allocations.updateAdvisorWallet(advisor, { from: from });

      expect(await this.token.balanceOf(advisor)).to.be.bignumber.equal(
        ether("0")
      );

      await this.allocations.grantToAdvisorWallet({ from: from });
      const supply = await this.allocations.ADVISOR_SUPPLY();
      const initialUnlock = await this.allocations.ADVISOR_INITIAL_UNLOCK(); //percent

      expect(initialUnlock).to.be.bignumber.equal(ether("0.25")); //25%

      const percent = supply.mul(initialUnlock).div(ether("1"));

      expect(await this.token.balanceOf(advisor)).to.be.bignumber.equal(
        percent
      );
    });

    it("should has 100% ido initial allocation", async function () {
      await this.allocations.updateIdoWallet(ido, { from: from });
      expect(await this.token.balanceOf(ido)).to.be.bignumber.equal(ether("0"));
      await this.allocations.grantToIdoWallet({ from: from });
      const supply = await this.allocations.IDO_SUPPLY();
      const initialUnlock = await this.allocations.IDO_INITIAL_UNLOCK(); //percent, 100%

      expect(initialUnlock).to.be.bignumber.equal(ether("1")); //100%

      const percent = supply.mul(initialUnlock).div(ether("1"));

      expect(await this.token.balanceOf(ido)).to.be.bignumber.equal(percent);
    });
  });
});
