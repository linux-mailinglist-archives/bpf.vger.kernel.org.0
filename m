Return-Path: <bpf+bounces-30748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBD38D1E3F
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72A4285C95
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 14:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A611A16F8E0;
	Tue, 28 May 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z5x6/ZeQ"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD716F847;
	Tue, 28 May 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905641; cv=none; b=SiuDY5mXgbcXchyuCx7cSVBKEOuono1tlUCayzhIY5CH7yYvn98w2mjtbvqHkxfVV9TUSUa3E7y6jezzWtyD8HLNk9ZV1M9LjX8yTzmDqGQFM9PI/R1TfzCBYbYd48lknwXsZBQ9ZJ1oJGR2+4MyvqSyk7aVx/Phsvh3uwo43bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905641; c=relaxed/simple;
	bh=KnHHGYOXuxNukpwGm2HRMB3s/FLGfk0vUDxfdAO6Nu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxY5C0f/lsdSz3kTXTpf6JZk7ICwwsdo/wTEIMw8taP+yXM0qPFgAcRDji4kVImOpTL6huK13oskO8M2VajcI/EdxcpyI8HrGQt5a0PF70cv1vfgbVKKXDOBO5LgaZRrSDs0pdX9uxg8BNYRPHhBATp4zjnrtzuTmm3PU9vWmek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z5x6/ZeQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0PFLB1+/1/l4xaKijJc9PYg2KD4MBSlBhyA5X9UR3aA=; b=Z5x6/ZeQG2drmmNniVooK7BoCU
	WZTC0F52F8XlATTbmbf8whGR5Ix/hmSkhxjUEa9Ts9wAS14CGPXBphswF9U6equukPy+RLT18aVrc
	wOi/oC0E8BS3pib0g6Yt10HS1G5RthMckqzSwg+5HXmHVwC7L32/uWRoizULBNdNFkjTA8T8fNGqP
	fpfr1FvOS8on13MPc2xwtY/P7jTUtFf3yj21l7mz/di3aC0z74IjIan/djT2AnQmkTVn1x30y066b
	XYDwPX8qgtx7vzPctfKF4FJ6LM1X6vduhS16k/HtO5wog7h6+1orH5sOoi4U3nra0CZBX9DXobEma
	6/LkEahA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59156)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBxa1-0004um-27;
	Tue, 28 May 2024 15:13:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBxa0-0003K2-7R; Tue, 28 May 2024 15:13:32 +0100
Date: Tue, 28 May 2024 15:13:32 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Byungho An <bh74.an@samsung.com>,
	Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: stmmac: Activate Inband/PCS flag
 based on the selected iface
Message-ID: <ZlXmjKtKozXThPFv@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
 <ZlN4tkY8fNM8/D8p@shell.armlinux.org.uk>
 <ukszpirecb3pwnz5bbmy7wl44ujh6t2ewrnodmrye5kjmonsz2@pgf5b2oy5n3p>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ukszpirecb3pwnz5bbmy7wl44ujh6t2ewrnodmrye5kjmonsz2@pgf5b2oy5n3p>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 28, 2024 at 04:19:49PM +0300, Serge Semin wrote:
> On Sun, May 26, 2024 at 07:00:22PM +0100, Russell King (Oracle) wrote:
> > On Sun, May 26, 2024 at 05:49:48PM +0100, Russell King (Oracle) wrote:
> > > On Sat, May 25, 2024 at 12:02:58AM +0300, Serge Semin wrote:
> > > > The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
> > > > into the DW GMAC controller. It's always done if the controller supports
> > > > at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
> > > > interfaces support was activated during the IP-core synthesize the PCS
> > > > block won't be activated either and the HWFEATURE.PCSSEL flag won't be
> > > > set. Based on that the RGMII in-band status detection procedure
> > > > implemented in the driver hasn't been working for the devices with the
> > > > RGMII interface support and with none of the SGMII, TBI, RTBI PHY
> > > > interfaces available in the device.
> > > > 
> > > > Fix that just by dropping the dma_cap.pcs flag check from the conditional
> > > > statement responsible for the In-band/PCS functionality activation. If the
> > > > RGMII interface is supported by the device then the in-band link status
> > > > detection will be also supported automatically (it's always embedded into
> > > > the RGMII RTL code). If the SGMII interface is supported by the device
> > > > then the PCS block will be supported too (it's unconditionally synthesized
> > > > into the controller). The later is also correct for the TBI/RTBI PHY
> > > > interfaces.
> > > > 
> > > > Note while at it drop the netdev_dbg() calls since at the moment of the
> > > > stmmac_check_pcs_mode() invocation the network device isn't registered. So
> > > > the debug prints will be for the unknown/NULL device.
> > > 
> > > Thanks. As this is a fix, shouldn't it be submitted for the net tree as
> > > it seems to be fixing a bug in the driver as it stands today?
> > > 
> > > Also, a build fix is required here:
> > > 
> > > > -	if (priv->dma_cap.pcs) {
> > > > -		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
> > > > -		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
> > > > -		    (interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
> > > > -		    (interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
> > > > -			netdev_dbg(priv->dev, "PCS RGMII support enabled\n");
> > > > -			priv->hw->pcs = STMMAC_PCS_RGMII;
> > > > -		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
> > > > -			netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
> > > > -			priv->hw->pcs = STMMAC_PCS_SGMII;
> > > > -		}
> > > > -	}
> > > > +	if (phy_interface_mode_is_rgmii(interface))
> > > > +		priv->hw.pcs = STMMAC_PCS_RGMII;
> > > > +	else if (interface == PHY_INTERFACE_MODE_SGMII)
> > > > +		priv->hw.pcs = STMMAC_PCS_SGMII;
> > > 
> > > Both of these assignments should be priv->hw->pcs not priv->hw.pcs.
> > > 
> > > I think there's also another bug that needs fixing along with this.
> > > See stmmac_ethtool_set_link_ksettings(). Note that this denies the
> > > ability to disable autoneg, which (a) doesn't make sense for RGMII
> > > with an attached PHY, and (b) this code should be passing the
> > > ethtool op to phylink for it to pass on to phylib so the PHY can
> > > be appropriately configured for the users desired autoneg and
> > > link mode settings.
> > > 
> > > I also don't think it makes any sense for the STMMAC_PCS_SGMII case
> > > given that it means Cisco SGMII - which implies that there is also
> > > a PHY (since Cisco SGMII with inband is designed to be coupled with
> > > something that looks like a PHY to send the inband signalling
> > > necessary to configure e.g. the SGMII link symbol replication.
> > > 
> > > In both of these cases, even if the user requests autoneg to be
> > > disabled, that _shouldn't_ affect internal network driver links.
> > > This ethtool op is about configuring the externally visible media
> > > side of the network driver, not the internal links.
> > 
> 
> > I have a concern about this patch. Have you considered dwmac-intel with
> > its XPCS support, where the XPCS is used for Cisco SGMII and 1000base-X
> > support. Does the dwmac-intel version of the core set
> > priv->dma_cap.pcs? If it doesn't, then removing the test on this will
> > cause a regression, since in Cisco SGMII mode, we end up setting
> > priv->hw->pcs to SYMMAC_PCS_SGMII where we didn't before. As
> > priv->flags will not have STMMAC_FLAG_HAS_INTEGRATED_PCS, this will
> > enable all the "integrated PCS" code paths despite XPCS clearly
> > intending to be used for Cisco SGMII.
> > 
> > I'm also wondering whether the same applies to the lynx PCS as well,
> > or in the general case if we have any kind of external PCS.
> > 
> > Hence, I think this probably needs to be:
> > 
> > 	if (phy_interface_mode_is_rgmii(interface))
> > 		priv->hw->pcs = STMMAC_PCS_RGMII;
> > 	else if (interface == PHY_INTERFACE_MODE_SGMII && priv->dma_cap.pcs)
> > 		priv->hw->pcs = STMMAC_PCS_SGMII;
> > 
> > At least this is what unpicking the awful stmmac code suggests (and I
> > do feel that my point about the shocking state of this driver is proven
> > as details like this are extremely difficult to unpick, and not
> > unpicking them correctly will lead to regressions.) Therefore, I would
> > suggest that it would be wise if you also double-checked this.
> 
> Double-checked that part. Indeed this is what I forgot to take into
> account.

Thanks for double-checking it.

> (Just realized I had a glimpse thought about checking the DW
> xGMAC/XPCS for supporting the SGMII interface, but the thought got
> away from my mind forgotten.) DW XPCS can be synthesized with having
> the GMII/MII interface connected to the MAC and SGMII downstream
> interface over a single 1000Base-X lane.
> 
> In anyway AFAICS that case has nothing to do with the PCS embedded
> into the DW GMAC or DW QoS Eth synthesized with the SGMII support. DW
> XGMAC has no embedded PCS, but could be attached to the separate DW
> XPCS device.

This is where my head starts spinning, because identifying what
"DW GMAC" and "DW QoS Eth" refer to is difficult unless one, I guess,
has the documentation.

The only references to QoS that I can find in the driver refer to
per-DMA channel interrupts, dwmac5* and one mention for a platform
driver in the Kconfig.

Grepping for "DW GMAC" doesn't give anything.

Conversely, I know from the code that only dwmac4 and dwmac1000
have support for the integrated PCS. So trying to put this together
doesn't make much sense to me. :/

Maybe "DW QoS Eth" refers to dwmac-dwc-qos-eth.c?

> About the correct implementation. Right, priv->dma_cap.pcs indicates
> that there is an embedded PCS and the flag can be set for DW GMAC or DW
> QoS Eth only. Although I would change the order:
> 
>        if (phy_interface_mode_is_rgmii(interface))
>                priv->hw->pcs = STMMAC_PCS_RGMII;
>        else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
>                priv->hw->pcs = STMMAC_PCS_SGMII;
> 
> since priv->dma_cap.pcs is a primary flag. If it isn't set the
> interface will be irrelevant.

As this is generic code, it probably makes sense to go with that, since
priv->dma_cap.pcs indicates whether the internal PCS for SGMII is
present or not rather than...

> Alternative solution could be to use the has_gmac/has_gmac4 flags
> instead. That will emphasize that the embedded PCS is expected to be
> specific for the DW GMAC and DW QoS Eth IP-cores:
> 
>        if (phy_interface_mode_is_rgmii(interface))
>                priv->hw->pcs = STMMAC_PCS_RGMII;
>        else if ((priv->plat.has_gmac || priv->plat.has_gmac4) &&
> 		interface == PHY_INTERFACE_MODE_SGMII)
>                priv->hw->pcs = STMMAC_PCS_SGMII;

which implies that gmac (dwgmac1000_core.c) and gmac4 (dwgmac4_core.c)
will always have its internal PCS if we're using SGMII mode. Does this
mean it is true that these cores will never be used with an external
PCS?

If there is a hardware flag that indicates the PCS is implemented, then
I think using that to gate whether SGMII uses the internal PCS is
better rather than using the core type.

Please can you confirm that if an external PCS (e.g. xpcs, lynx PCS)
is being used, the internal PCS will not have been synthesized, and
thus priv->dma_cap.pcs will be false? The reason I'd like to know
this is because in the future, I'd like to eliminate priv->hw->pcs,
and just have dwmac1000/dwmac4's phylink_select_pcs() method make
the decisions.

If not, then we need to think about the behaviour that
stmmac_mac_select_pcs(0 should have. Should it give priority to the
internal PCS over external PCS, or external PCS first (in which case
what do we need to do with the internal PCS.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

