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

    it("has a liquidity supply -  41,26% 6 633 576 500", async function () {
      expect(await this.allocations.LIQUIDITY_SUPPLY()).to.be.bignumber.equal(
        ether("6633576500")
      );
    });

    it("has a team supply -  18,75% 3014531250", async function () {
      expect(await this.allocations.TEAM_SUPPLY()).to.be.bignumber.equal(
        ether("3014531250")
      );
    });

    it("has a marketing supply -  11,50% 1 848 912 500", async function () {
      expect(await this.allocations.MARKETING_SUPPLY()).to.be.bignumber.equal(
        ether("1848912500")
      );
    });

    it("has a presale supply -  10,68% 1 7170 77 000", async function () {
      expect(await this.allocations.PRESALE_SUPPLY()).to.be.bignumber.equal(
        ether("1717077000")
      );
    });

    it("has a reserve supply -  6,25% 1 004 843 750", async function () {
      expect(await this.allocations.RESERVE_SUPPLY()).to.be.bignumber.equal(
        ether("1004843750")
      );
    });

    it("has a technology supply -  5% 803 875 000", async function () {
      expect(await this.allocations.TECHNOLOGY_SUPPLY()).to.be.bignumber.equal(
        ether("803875000")
      );
    });

    it("has a legal supply -  3,50% 562 712 500", async function () {
      expect(await this.allocations.LEGAL_SUPPLY()).to.be.bignumber.equal(
        ether("562712500")
      );
    });

    it("has a advisor supply -  2,5% 401 937 500", async function () {
      expect(await this.allocations.ADVISOR_SUPPLY()).to.be.bignumber.equal(
        ether("401937500")
      );
    });

    it("has a ido supply -  0,56% 90 034 000", async function () {
      expect(await this.allocations.IDO_SUPPLY()).to.be.bignumber.equal(
        ether("90034000")
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
});
