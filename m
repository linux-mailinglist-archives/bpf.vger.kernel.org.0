Return-Path: <bpf+bounces-33804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5715092694A
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0772628A256
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A5D18E77F;
	Wed,  3 Jul 2024 20:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="i0+XC9bQ"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA34C6C;
	Wed,  3 Jul 2024 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037270; cv=none; b=ERzEDEVpqjTWYmA1532zeWehSL+eO21aWWfGkjB2VCHArV+pLbgAPjKhEE66RqadmIoUi/RBjphgEAVli2fWyklwbR0lDwRlemz3LO8W9MoH80HWD4VixMKZ1E+ii9FeelMn7UbSPU70AHhkbdUP0iFYSZDUu1WpOW6UoLor87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037270; c=relaxed/simple;
	bh=0F16IKVHq+8dmNCyYOHRKPgDCKr7yywi6qOdCdgoCz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvJBQROVPki/IkE7ys7VAyxrgMOtTdz/A0H+Yu8aEFu0MyGhcrKNVGuoZ7nM9soJbUawRLWyvekmMoz/s2Rffkqk7lPR/JH9xyykjgv8vYgXifyxwV2uCYeOwzr6dxrK1KMb8ePKgdrf0VrFVHOjSAkoVYJTdr+/Je1vlnULnW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=i0+XC9bQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=icXRBmhduGTP09MP9/bdmtA71NiiR3AvLh8eFv8j8m0=; b=i0+XC9bQnyLQanJGNjCrxwavyx
	/WlX/IwrrH0NU0fwQh+LW+aKJpW9Q+ctAi5CgyAENkonD4542+fX9wB6639I6pOe4tn3hhz1u0hyD
	UWRmIAE3qZizkjvnFeGufi5mCxtK7YMCwZwbEVE1eHax1jJazBq7AHb3QvAbCNTYq+MHzZHiABs2F
	94is70/yGZJ1QGaN1Q7xxxL2Q6hZXZ3F8SsUmEOqwMs1ILYZbCam1707MjSIHE97RUHYF325w8hcF
	k8/qnHXYET/DUrZkfDZ/WWqp9XpasXn7bx03xxzIcbOyjnVzAlSHa0pwcrBG5GJpmSqVVAOk+CbXz
	p7R/StvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37272)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sP6GA-00066Q-0J;
	Wed, 03 Jul 2024 21:07:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sP6GA-0003Fw-Jq; Wed, 03 Jul 2024 21:07:22 +0100
Date: Wed, 3 Jul 2024 21:07:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 14/17] net: stmmac: Move internal PCS
 PHYLINK ops to stmmac_pcs.c
Message-ID: <ZoWvejkng/Ch/YIz@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-6-fancer.lancer@gmail.com>
 <Zn7Rwt9KNac2mMah@shell.armlinux.org.uk>
 <4q6a2vo23clanqs36e2idzjybh7ugp7pxqldeyhkk4upfn4lhp@75mz4t7rbhjm>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4q6a2vo23clanqs36e2idzjybh7ugp7pxqldeyhkk4upfn4lhp@75mz4t7rbhjm>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 03, 2024 at 10:08:16PM +0300, Serge Semin wrote:
> On Fri, Jun 28, 2024 at 04:07:46PM +0100, Russell King (Oracle) wrote:
> > On Mon, Jun 24, 2024 at 04:26:31PM +0300, Serge Semin wrote:
> > > @@ -621,7 +548,6 @@ int dwmac1000_setup(struct stmmac_priv *priv)
> > >  	mac->mii.clk_csr_shift = 2;
> > >  	mac->mii.clk_csr_mask = GENMASK(5, 2);
> > >  
> > > -	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
> > >  	mac->mac_pcs.neg_mode = true;
> > 
> > "mac->mac_pcs.neg_mode = true;" is a property of the "ops" so should
> > move with it.
> > 
> > > @@ -1475,7 +1396,6 @@ int dwmac4_setup(struct stmmac_priv *priv)
> > >  	mac->mii.clk_csr_mask = GENMASK(11, 8);
> > >  	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
> > >  
> > > -	mac->mac_pcs.ops = &dwmac4_mii_pcs_ops;
> > >  	mac->mac_pcs.neg_mode = true;
> > 
> > Also applies here.
> > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > index 3666893acb69..c42fb2437948 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > @@ -363,6 +363,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
> > >  		mac->tc = mac->tc ? : entry->tc;
> > >  		mac->mmc = mac->mmc ? : entry->mmc;
> > >  		mac->est = mac->est ? : entry->est;
> > > +		mac->mac_pcs.ops = mac->mac_pcs.ops ?: entry->pcs;
> > 
> 
> > Removing both of the above means that mac->mac_pcs.ops won't ever be set
> > prior to this, so this whole thing should just be:
> > 
> > 		mac->mac_pcs.ops = entry->pcs;
> > 		mac->mac_pcs.neg_mode = true;
> 
> Actually, no. mac->mac_pcs.ops can be set by the platform-specific
> plat_stmmacenet_data::setup() method.

mac->mac_pcs is there for the _internal_ MAC only, not for platforms
to fiddle around with (remember, my patch set adds this!)

I think you're thinking of mac->phylink_pcs which platforms can and
do fiddle with.

> > > +	/* TODO Check the PCS_AN_STATUS.Link status here?.. Note the flag is latched-low */
> > > +
> > > +	/* TODO The next is the TBI/RTBI-specific and seems to be valid if PCS_AN_STATUS.ANC */
> > >  	val = readl(priv->pcsaddr + PCS_ANE_LPA);
> > 
> 
> > I thought these registers only existed of dma_cap.pcs is true ?
> 
> Right. The AN-registers are SGMII/TBI/RTBI-specific.

Therefore, I suggest that if state->interface is RGMII, then these
registers should not be accessed.

My idea is to provide two PCS per MAC:

One simple one which covers RGMII which only reads the PHYIF/RGSMIIIS
register, does no configuration, but does implement the .pcs_enable/
.pcs_disable etc. The .pcs_validate method should also be empty for
this because the AutoNeg ethtool capability does not refer to the
inband signalling, but to the media PHY.

Then a more complex PCS implementation that does everything the RGMII
one does, but also the bits for SGMII (and TBI/RTBI).

> > If we
> > start checking PCS_AN_STATUS.Link here, and this register reads as
> > zeros, doesn't it mean that RMGII inband mode won't ever signal link
> > up?
> 
> Right. The PCS_AN_STATUS.Link should be checked for the SGMII (and
> TBI/RTBI) only. The databooks defines the flag as follows:
> 
> DW GMAC v3.73a:
> Link Status   This bit indicates whether the data channel (link) is up or
> R_SS_SC_LLO   down. For the TBI, RTBI or SGMII interfaces, if ANEG is going
>               on, data cannot be transferred across the link and hence the
>               link is given as down.
> 
> DW QoS Eth:
> Link Status   When this bit is set, it indicates that the link is up between
> Read-only     the MAC and the TBI, RTBI, or SGMII interface. When this bit is
>               reset, it indicates that the link is down between the MAC and
>               the TBI, RTBI, or SGMII interface.
> 
> I guess that in fact the flag semantics is the same on both devices.
> But the Access-status for some reason different. Although DW QoS Eth
> databook doesn't define any latched-low CSR. So there is a chance that
> some of the databooks might be wrong in the flag access status.

Yes, it sounds like it.

> > > -	/* TODO Make sure that STMMAC_PCS_PAUSE STMMAC_PCS_ASYM_PAUSE usage is legitimate */
> > > +	/* TODO The databook says the encoding is defined in IEEE 802.3z,
> > > +	 * Section 37.2.1.4. Do we need the STMMAC_PCS_PAUSE and
> > > +	 * STMMAC_PCS_ASYM_PAUSE mask here?
> > > +	 */
> > >  	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> > >  			 state->lp_advertising,
> > >  			 FIELD_GET(PCS_ANE_PSE, val) & STMMAC_PCS_PAUSE);
> > 
> 
> > If it's 802.3z aka 1000base-X format, then yes, we should be using
> > these bits if we are getting state from this register.
> 
> I meant that should we be using the driver-specific macro in here
> seeing the field encoding is defined by the IEEE 802.3z? Is there any
> ready-to-use macros/constants defined in the network subsystem core
> for the standard Pause encoding (IEEE 802.3z Section 37.2.1.4)?

include/uapi/linux/mii.h:

#define ADVERTISE_1000XFULL     0x0020  /* Try for 1000BASE-X full-duplex */
	/* GMAC_ANE_FD */
#define ADVERTISE_1000XHALF     0x0040  /* Try for 1000BASE-X half-duplex */
	/* GMAC_ANE_HD */
#define ADVERTISE_1000XPAUSE    0x0080  /* Try for 1000BASE-X pause    */
	/* GMAC_ANE_PSE bit 0 */
#define ADVERTISE_1000XPSE_ASYM 0x0100  /* Try for 1000BASE-X asym pause */
	/* GMAC_ANE_PSE bit 1 */
#define ADVERTISE_LPACK         0x4000  /* Ack link partners response  */
	/* GMAC_ANE_ACK */

#define LPA_1000XFULL           0x0020  /* Can do 1000BASE-X full-duplex */
	/* GMAC_ANE_FD */
#define LPA_1000XHALF           0x0040  /* Can do 1000BASE-X half-duplex */
	/* GMAC_ANE_HD */
#define LPA_1000XPAUSE          0x0080  /* Can do 1000BASE-X pause     */
	/* GMAC_ANE_PSE bit 0 */
#define LPA_1000XPAUSE_ASYM     0x0100  /* Can do 1000BASE-X pause asym*/
	/* GMAC_ANE_PSE bit 1 */
#define LPA_RESV                0x1000  /* Unused...                   */
	/* GMAC_ANE_RFE bit 0 */
#define LPA_RFAULT              0x2000  /* Link partner faulted        */
	/* GMAC_ANE_RFE bit 1 */
#define LPA_LPACK               0x4000  /* Link partner acked us       */
	/* GMAC_ANE_ACK */

> > If TBI/RTBI is ever used, rather than trying to shoe-horn it all into
> > these functions, please consider splitting them into separate PCSes,
> > and sharing code between them e.g. using common functions called from
> > the method functions or shared method functions where appropriate.
> 
> Ok. Sounds reasonable.
> 
> I guess your message also means that the patchset re-spinning will be
> on me from now, right?) If so, please note, I can't promise I'll be
> able to do that soonish. I am quite busy at the moment. I'll be
> more-or-less free for that in a month or so.

Not necessarily - some good news today, the high priority issue I was
working on is lower priority at last, which means I've more time to
look at mainline again. Bad news... I need a break after about 2.5
months of frustrations, which could be from this weekend!

Given the fix for the LNKMOD issue, I suspect that won't be merged
into net-next until after the weekend, but I'll see whether I can
sneak a respin of the patch set once that's happened. That said,
given that we'll be at -rc7, it's likely too late to be thinking
about getting the PCS changes queued up for this coming merge
window. In any case, I don't think even if I did post a series, we're
at the point where we have something that would be ready.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

