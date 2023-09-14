Return-Path: <bpf+bounces-10035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D17A092F
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409F41F23F72
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D55421A04;
	Thu, 14 Sep 2023 15:12:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62439C;
	Thu, 14 Sep 2023 15:12:23 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307D4A8;
	Thu, 14 Sep 2023 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JCzR9bnKdQWaES21IE+SF94nKQUXujpbyIjqGFP/0Oc=; b=DocVKf/DEW9GRSxUzKW453infY
	3tYI+lAYsKsAnPVa7L81GtPxGu/JHmN0CUL5NnFS5ySgtVc0fm7xGOTr/TlNJz+qFOaxnb2S9YCLa
	xM/M+3/QGiaZJ3iIWQNW2T09x4tADGJD/aDNbarS7hf46Gy9NH411PTGoI6Zl+XttLd8Yi/6cexjh
	KAkiikxKjDnuZxrk3vLO2r/ak/Oz8I2NbDpgRuopWXji7UCf9N2hl2dLZYhiIsiQHw0hv+cl8URyC
	bh4xBVakhyntjhPPVqeBZvQ8ckzeO2McAI6zEDpVO6AkjJTIArjD2rcGxa7mmop04lraEZo5pU1fb
	Ioank7rA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40360)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qgo0u-0004Sf-1Y;
	Thu, 14 Sep 2023 16:12:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qgo0r-0004s6-VM; Thu, 14 Sep 2023 16:12:13 +0100
Date: Thu, 14 Sep 2023 16:12:13 +0100
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
Subject: Re: [PATCH net-next 1/6] net: stmmac: add stmmac_set_tx_clk_gmii()
Message-ID: <ZQMizWbkAEyTh4M7@shell.armlinux.org.uk>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmka-007Z4Z-1E@rmk-PC.armlinux.org.uk>
 <j64xmkplk2kkb4esteaic3hsofex3eishxxr3z6hppnm6heoz5@5fyj4x5qouc3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j64xmkplk2kkb4esteaic3hsofex3eishxxr3z6hppnm6heoz5@5fyj4x5qouc3>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 14, 2023 at 05:54:09PM +0300, Serge Semin wrote:
> On Thu, Sep 14, 2023 at 02:51:20PM +0100, Russell King (Oracle) wrote:
> > Add a helper function for setting the transmit clock for GMII
> > interfaces. This handles 1G, 100M and 10M using the standard clock
> > rates of 125MHz, 25MHz and 2.5MHz.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  .../ethernet/stmicro/stmmac/stmmac_platform.c | 25 +++++++++++++++++++
> >  .../ethernet/stmicro/stmmac/stmmac_platform.h |  1 +
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 0f28795e581c..f7635ed2b255 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -700,6 +700,31 @@ EXPORT_SYMBOL_GPL(stmmac_probe_config_dt);
> >  EXPORT_SYMBOL_GPL(devm_stmmac_probe_config_dt);
> >  EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
> >  
> 
> > +int stmmac_set_tx_clk_gmii(struct clk *tx_clk, unsigned int speed)
> > +{
> > +	unsigned long rate;
> > +
> > +	switch (speed) {
> > +	case SPEED_1000:
> > +		rate = 125000000;
> > +		break;
> > +
> > +	case SPEED_100:
> > +		rate = 25000000;
> > +		break;
> > +
> > +	case SPEED_10:
> > +		rate = 2500000;
> > +		break;
> > +
> > +	default:
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	return clk_set_rate(tx_clk, rate);
> > +}
> > +EXPORT_SYMBOL_GPL(stmmac_set_tx_clk_gmii);
> 
> As I already noted in v1 normally the switch-case operations are
> defined with no additional line separating the cases. I would have
> dropped them here too especially seeing the stmmac core driver mainly
> follow that implicit convention.

It's rather haphazard whether there are blank lines or not between
case statements.

> Additionally I suggest to move the method to being defined at the head
> of the file. Thus a more natural order normally utilized in the kernel
> drivers would be preserved: all functional implementations go first,
> the platform-specific things are placed below like probe()/remove()
> and their sub-functions, suspend()/resume() and PM descriptors,
> (device IDs table, driver descriptor, etc). stmmac_set_tx_clk_gmii()
> looks as a functional helper which is normally utilized on the network
> device open() stage in the framework of the fix_mac_speed() callback.
> Moreover my suggestion gets to be even more justified seeing you
> placed the method prototype at the head of the prototypes list in the
> stmmac_platform.h file.

How is one supposed to know about this? I did my best trying to work
out where they should've gone...

If it's that important, maybe add some /* Comments */ to state that
there are separate sections to the file?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

