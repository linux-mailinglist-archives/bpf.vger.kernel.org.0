Return-Path: <bpf+bounces-10037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6F47A0968
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B001728211F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D162111B;
	Thu, 14 Sep 2023 15:27:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9039C;
	Thu, 14 Sep 2023 15:27:29 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED8C2105;
	Thu, 14 Sep 2023 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jgO0TPjzDMW3uGSemtPUC52aZ0oc1pKGl6v400Y/eSU=; b=y7/3F1nrPEbpVb4EBm2YZ0JbJM
	r8HoMpjBHSbhYHIBI1qKimpRPZPgdkksmPPND6UY2sQVyXf0EiTWQ6i4g1RLLMq8b2NRcdpIbUkI1
	tyFz2eKW43Q9d0WDlhUWL5cDc5FZ+V1QIHIyzk5SXWPxogvqVMtDwcNH+QPg6FdPI5Nkehn1nNDsG
	Jm2P1tj7HpKovJ7HSD0i04CYBw2OIyQT95TQ6Zo9zFpGPBJjhgEzjrhG+vLC/Npqfc1D54hqdYT79
	brVw0SpsGaW7kpKp2Mewz9YFER/FidPd4GbBttZhvsdWALwyVOXPqIRy42lQuAfn2NqKKax8otJkP
	KjQtWypw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56988)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qgoFV-0004U6-09;
	Thu, 14 Sep 2023 16:27:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qgoFT-0004sQ-80; Thu, 14 Sep 2023 16:27:19 +0100
Date: Thu, 14 Sep 2023 16:27:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samin Guo <samin.guo@starfivetech.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 4/6] net: stmmac: rk: use
 stmmac_set_tx_clk_gmii()
Message-ID: <ZQMmV2pSCAX8AJzz@shell.armlinux.org.uk>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>
 <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
 <ZQMgtXSTsNoZohnx@shell.armlinux.org.uk>
 <rene2x562lqsknmwpaxpu337mhl4bgynct6vcyryebvem2umso@2pjocnxluxgg>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rene2x562lqsknmwpaxpu337mhl4bgynct6vcyryebvem2umso@2pjocnxluxgg>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 14, 2023 at 06:22:33PM +0300, Serge Semin wrote:
> On Thu, Sep 14, 2023 at 04:03:17PM +0100, Russell King (Oracle) wrote:
> > On Thu, Sep 14, 2023 at 05:37:13PM +0300, Serge Semin wrote:
> > > On Thu, Sep 14, 2023 at 02:51:35PM +0100, Russell King (Oracle) wrote:
> > > > Use stmmac_set_tx_clk_gmii().
> > > > 
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > >  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 60 +++++--------------
> > > >  1 file changed, 16 insertions(+), 44 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > index d920a50dd16c..5731a73466eb 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > > > @@ -1081,28 +1081,14 @@ static void rk3568_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
> > > >  {
> > > >  	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
> > > >  	struct device *dev = &bsp_priv->pdev->dev;
> > > > -	unsigned long rate;
> > > > -	int ret;
> > > > -
> > > > -	switch (speed) {
> > > > -	case 10:
> > > > -		rate = 2500000;
> > > > -		break;
> > > > -	case 100:
> > > > -		rate = 25000000;
> > > > -		break;
> > > > -	case 1000:
> > > > -		rate = 125000000;
> > > > -		break;
> > > > -	default:
> > > > -		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
> > > > -		return;
> > > > -	}
> > > > -
> > > > -	ret = clk_set_rate(clk_mac_speed, rate);
> > > > -	if (ret)
> > > > -		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
> > > > -			__func__, rate, ret);
> > > > +	int err;
> > > > +
> > > > +	err = stmmac_set_tx_clk_gmii(clk_mac_speed, speed);
> > > > +	if (err == -ENOTSUPP)
> > > 
> > > > +		dev_err(dev, "invalid speed %uMbps\n", speed);
> > > > +	else if (err)
> > > > +		dev_err(dev, "failed to set tx rate for speed %uMbps: %pe\n",
> > > 
> > > These type specifiers should have been '%d' since the speed variable
> > > is of the signed integer type here.
> > 
> 
> > Okay, having re-reviewed the changes, I'm changing them _all_ back to
> > be %d, because that is the _right_ thing. It is *not* unsigned, even
> > if fix_mac_speed() thinks that it is. It isn't. It's signed, and it's
> > stmmac bollocks implicitly casting it to unsigned - and that is
> > _wrong_.
> 
> Yes, stmmac is wrong in casting it to the unsigned type, but even
> seeing the original type is intended to be signed doesn't mean the
> qualifier should be fixed separately from the variables type and
> function prototypes. It will cause even more confusion. IMO the best
> way would be to fix the plat_stmmacenet_data->fix_mac_speed()
> prototype and the respective methods in the glue drivers. But it would
> be too bulky and most likely out of your interest to be done. So I
> would still have the variables type and the format qualifier type
> matching here and in the rest of the drivers especially seeing the
> original code in the imx, starfive, rk, QoS Eth LLDDs sticks to the
> convention described by me.

I won't be doing that, sorry. If that's not acceptable, then I'm
junking this series.

What I will be doing is getting rid of as many users of fix_mac_speed()
as possible, but that's for a future patch series.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

