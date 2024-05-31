Return-Path: <bpf+bounces-31069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22698D69B9
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 21:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC301C23862
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977CC16D304;
	Fri, 31 May 2024 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="U9SexC7R"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301198060E;
	Fri, 31 May 2024 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183854; cv=none; b=XlDIMHj/VAtHhVnktq/VDfEbdA8Q8ELrfSgnCeCy3M3Y6CnWNhTfM+I8hZ8uTbam/AAxwfVHGa11MJktMG3aZf8V6wFXo2+MA1L8sQYmwt+781mxCcpUSd9u4ESzDry+o8k5RTTOECewNtpOvybrkg01WGZa4cSbz41q3foJWHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183854; c=relaxed/simple;
	bh=z8uzJKSifRIK3GWiIUeZtQqc65MtApfDUecHoBdeV9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsbDs10O6w2gIrFUwo0W0/y8L0r8A1SYpbZD3wFAS3TN0hnokqmD/9A/b61CWqKzYwkMRO/aQsKl0YObcRi+nS62kW4xASOe3mmhumflCsEj96pB5HSUtFZXNBfGD9YdUbJuXn0lmS74zqpHogokfe768oHBCGxaKAW2iL6y0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=U9SexC7R; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S9mHIQQm5cGqY4bLkFBXjSdhRykuzFxJcjgIe1svJ7o=; b=U9SexC7RC1hTsF5vRAxJnxnJHH
	dLZ1LflYfoWO2OuCxU3MR/vYqdR8AnSAoiapTc7PddjybP1/HklAAtGiMy4fdM7EwuHzjeF8xIgMW
	7rFAlHEZ0h/biUPgz1WP1lHgtPa//j1awSS89+F/LIn27ufOa1cEqIAysshEBKohpguuOPgn6Nerh
	zU91Zd6pp1Ch4PoReIusHdSM7J5EAGI7a1ca7+WFpQ3J12c5ZRiGWDwPo2Q7//op8FfDNrPWko7k0
	d9ScfhUslZAvjwP2Rqn97OeFHIaHLh0mFydPe1qKXiZr13uo47vVAYO4tQIdskwVeY+/SKObQs4v1
	YK+IDRcA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43346)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sD7xN-0000RY-17;
	Fri, 31 May 2024 20:30:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sD7xL-0006Hk-IZ; Fri, 31 May 2024 20:30:27 +0100
Date: Fri, 31 May 2024 20:30:27 +0100
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
Message-ID: <ZlolU6+lUaXQSQID@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
 <ZlN4tkY8fNM8/D8p@shell.armlinux.org.uk>
 <ukszpirecb3pwnz5bbmy7wl44ujh6t2ewrnodmrye5kjmonsz2@pgf5b2oy5n3p>
 <ZlXmjKtKozXThPFv@shell.armlinux.org.uk>
 <x4snwm24lqebfcu3xqipwnxcexxbxhfijw7ldsukk23tn5k3rc@g3tfmynhvm26>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x4snwm24lqebfcu3xqipwnxcexxbxhfijw7ldsukk23tn5k3rc@g3tfmynhvm26>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi Serge,

Thanks for the reply. I've attempted to deal with most of these in my
v2 posting, but maybe not in the best way yet.

On Fri, May 31, 2024 at 08:13:49PM +0300, Serge Semin wrote:
> > Does this
> > mean it is true that these cores will never be used with an external
> > PCS?
> 
> Sorry, I was wrong to suggest the (priv->plat.has_gmac ||
> priv->plat.has_gmac4)-based statement. Indeed there is a case of having DW
> QoS Eth and DW XPCS synthesized together with the SGMII/1000Base-X
> downstream interface. Not sure why it was needed to implement that way
> seeing DW QoS Eth IP-core supports optional SGMII PHY interface out of
> box, but AFAICS Intel mGBE is that case. Anyway the correct way to
> detect the internal PCS support is to check the PCSSEL flag set in the
> HWFEATURE register (preserved in the stmmac_priv::dma_cap::pcs field).

We can only wonder why!

> > Please can you confirm that if an external PCS (e.g. xpcs, lynx PCS)
> > is being used, the internal PCS will not have been synthesized, and
> > thus priv->dma_cap.pcs will be false?
> 
> Alas I can't confirm that. priv->dma_cap.pcs only indicates the
> internal PCS availability. External PCS is an independent entity from
> the DW *MAC IP-core point of view. So the DW GMAC/QoS Eth/XGMAC
> controllers aren't aware of its existence. It's the low-level platform
> driver/code responsibility to somehow detect it being available
> ("pcs-handle" property, plat->mdio_bus_data->has_xpcs flag, etc).
> 
> Regarding the internal PCS, as long as the DW GMAC or DW QoS Eth is
> synthesized with the SGMII/TBI/RTBI PHY interface support
> priv->dma_cap.pcs will get to be true. Note the device can be
> synthesized with several PHY interfaces supported. As long as
> SGMII/TBI/RTBI PHY interface is any of them, the flag will be set
> irrespective from the PHY interface activated at runtime. 

I've been debating about this, and given your response, I'm wondering
whether we should change stmmac_mac_select_pcs() to instead do:

static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
						 phy_interface_t interface)
{
	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
	struct phylink_pcs *pcs;

	if (priv->plat->select_pcs) {
		pcs = priv->plat->select_pcs(priv, interface);
		if (!IS_ERR(pcs))
			return pcs;
	}

	return stmmac_mac_phylink_select_pcs(priv, interface);
}

and push the problem of whether to provide a PCS that overrides
the MAC internal PCS into platform code. That would mean Intel mGBE
would be able to override with XPCS. rzn1 and socfpga can then do
their own thing as well.

I'm trying hard not to go down another rabbit hole... I've just
spotted that socfpga sets mac_interface to PHY_INTERFACE_MODE_SGMII.
That's another reason for pushing this down into platform drivers -
if platform drivers are doing weird stuff, then we can contain their
weirdness in the platform drivers moving it out of the core code.

> You can extend the priv->dma_cap.pcs flag semantics. So it could
> be indicating three types of the PCS'es:
> RGMII, SGMII, XPCS (or TBI/RTBI in future).

If TBI/RTBI gets supported, then this would have to be extended, but I
get the impression that this isn't popular.

> I guess the DW XPCS implementation might be more preferable. From one
> side DW XPCS SGMII can support up to 2.5Gbps speed, while the DW
> GMAC/QoS Eth SGMII can work with up to 1Gbps speed only. On the other
> hand the DW XPCS might be available over the MDIO-bus, which is slower
> to access than the internal PCS CSRs available in the DW GMAC/QoS Eth
> CSRs space. So the more performant link speed seems more useful
> feature over the faster device setup process.

I think which should be used would depend on how the hardware is wired
up. This brings us back to platform specifics again, which points
towards moving the decision making into platform code as per the above.

> One thing I am not sure about is that there is a real case of having
> the DW GMAC/QoS Eth synthesized with the native SGMII/TBI/RTBI PHY
> interface support and being attached to the DW XPCS controller, which
> would have the SGMII downstream PHY interface. DW XPCS has only the
> XGMII or GMII/MII upstream interfaces over which the MAC can be
> attached.

That gives us another possibility, but needs platforms to be doing
the right thing. If mac_interface were set to XGMII or GMII/MII, then
that would exclude the internal MAC PCS.

> So DW GMAC/QoS Eth and DW XPCS can be connected via the
> GMII/MII interface only. Regarding Intel mGBE, it likely is having a
> setup like this:
> 
> +------------+          +---------+
> |            | GMII/MII |         |   SGMII
> | DW QoS Eth +----------+ DW XPCS +------------
> |            |          |         | 1000Base-X
> +------------+          +---------+


So as an alternative, 

     mac_interface            phy_interface

     XGMII/GMII/MII           SGMII/1000Base-X
MAC ---------------- DW XPCS ------------------

     INTERNAL                SGMII/TBI/RTBI
MAC ---------- Internal PCS ----------------

     INTERNAL                  RGMII
MAC ---------- Internal "PCS" --------------

One of the problems here, though, is socfpga. It uses mac_interface
with RGMII*, MII, GMII, SGMII and RMII. I think it's confusing
mac_interface for phy_interface, but I haven't read through enough
of it to be certain.

So that again leads me back to my proposal above for
stmmac_mac_select_pcs() as the least likely to break proposition -
at least given how things are at the moment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

