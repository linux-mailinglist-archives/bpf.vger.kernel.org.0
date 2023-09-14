Return-Path: <bpf+bounces-10033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D27A08E6
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BA01C20E27
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDF262A4;
	Thu, 14 Sep 2023 15:03:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843F28E28;
	Thu, 14 Sep 2023 15:03:30 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3031BA8;
	Thu, 14 Sep 2023 08:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RE3IKnkVM1o//7e7tQAyrkiYmQQrfQVxuj7YjxSm9tg=; b=nhdYLCMoe8emRkBajZTeqgMGF2
	9N7Aj3Jtq6ogxxz/sjndT5aWDpEVH8biPtO56utKLzIyBE+6HwBcthKC+b/2EYi55i+W54HjJQxh2
	gOSYO+osjvn/NvYfaZJPB+ZdYe0KgP7Rh9BsQsOEbfGNVwqtvyBPyek4N0lf0oGVEfhNrndgB0D12
	88LgA9dJ8IsMGW4SOmPy3fPvBOxv4HMsPUZ77LaCjBXHHnJASzsH8RwBzDEuI4Wc779Jubsx6jpRC
	QqbOHcWZIenwxmKLCazJo5l8ibGARlIILqcUS2mjdsaaHAwnQ3Tgu7vxDRaiZehFKsvznbOC4X0VR
	4A0Y7owg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49528)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qgnsH-0004Qz-2Y;
	Thu, 14 Sep 2023 16:03:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qgnsD-0004r8-H3; Thu, 14 Sep 2023 16:03:17 +0100
Date: Thu, 14 Sep 2023 16:03:17 +0100
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
Message-ID: <ZQMgtXSTsNoZohnx@shell.armlinux.org.uk>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>
 <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 14, 2023 at 05:37:13PM +0300, Serge Semin wrote:
> On Thu, Sep 14, 2023 at 02:51:35PM +0100, Russell King (Oracle) wrote:
> > Use stmmac_set_tx_clk_gmii().
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 60 +++++--------------
> >  1 file changed, 16 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > index d920a50dd16c..5731a73466eb 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> > @@ -1081,28 +1081,14 @@ static void rk3568_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
> >  {
> >  	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
> >  	struct device *dev = &bsp_priv->pdev->dev;
> > -	unsigned long rate;
> > -	int ret;
> > -
> > -	switch (speed) {
> > -	case 10:
> > -		rate = 2500000;
> > -		break;
> > -	case 100:
> > -		rate = 25000000;
> > -		break;
> > -	case 1000:
> > -		rate = 125000000;
> > -		break;
> > -	default:
> > -		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
> > -		return;
> > -	}
> > -
> > -	ret = clk_set_rate(clk_mac_speed, rate);
> > -	if (ret)
> > -		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
> > -			__func__, rate, ret);
> > +	int err;
> > +
> > +	err = stmmac_set_tx_clk_gmii(clk_mac_speed, speed);
> > +	if (err == -ENOTSUPP)
> 
> > +		dev_err(dev, "invalid speed %uMbps\n", speed);
> > +	else if (err)
> > +		dev_err(dev, "failed to set tx rate for speed %uMbps: %pe\n",
> 
> These type specifiers should have been '%d' since the speed variable
> is of the signed integer type here.

Okay, having re-reviewed the changes, I'm changing them _all_ back to
be %d, because that is the _right_ thing. It is *not* unsigned, even
if fix_mac_speed() thinks that it is. It isn't. It's signed, and it's
stmmac bollocks implicitly casting it to unsigned - and that is
_wrong_.

So, on that point, my original submission was more correct than this
one, and you led me astray.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

