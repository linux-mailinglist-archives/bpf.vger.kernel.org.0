Return-Path: <bpf+bounces-33802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E99268D8
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DB81C23037
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 19:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8481891D1;
	Wed,  3 Jul 2024 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXCo8XFu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2D13DBB1;
	Wed,  3 Jul 2024 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033704; cv=none; b=acPn19yQgMj9SuBzYfXVFnl16bdJpKgJ1wt+Lm6fl8MytqVOZ4sY7amQs+f0fbmM1e86aZEieyPmD9/VcQ2/piabG8mEmK2GQv4BClf1vzZCWZoAPlhi0PEoo/DfS5jZjgRsw9guGskXNTkMbDGh4cn5hgJQ81OCPuoCwAbftUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033704; c=relaxed/simple;
	bh=AHELTwXMvADdJh/rD6giNI0MZmTBLdIUaJwSrIAR49I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXb8U3NvPvtbD1KywnR0b1++IVcQLb1ILtjiyneNoZ+PDYH9faHAlUk7YiaF3uB2LSP+5fSmQpB1Y4U0xufz3AM2cZUEHNFfCWhvqOzu2sPy7mnw3IHs3vfQarf2EUNBSGFjK4CeWrawtuEvmDb77UNV51rv8DRpMoFe/v4+/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXCo8XFu; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e72224c395so66464741fa.3;
        Wed, 03 Jul 2024 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720033700; x=1720638500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hlntWaXrDgE6HSswwW9oXi0jbGPL9ArLggt0x5XmFrg=;
        b=aXCo8XFupSzBn0Fy9MkCPP36Wv/GU98olVfgqP6LvptN2txM7bJZPBrU+XRAujUVwF
         8UNNwrptEl5kIKxSRAA7aFZDc0hFNX0AGYUdO6yZY4AzCfDOK+3N/LJLdS4xrjHbjD1U
         CQ9soYyC6D7LTCPO+HlFl4Kq0riVQeL9dIZ5L11Xnv84F6nwtaFdDxiN/iIPvy9Mdnie
         bR1otlX3IzpwF/Ue8KIMZRtNeMgy/2qzyGXn8jrcy5Oz+AB0m4TA4j5dPUy9c0zjiLI1
         o3RuVlKZ/GncxzvocCSNpwe0P4yAnjoYkASyr6AJaGJDyqHjsxRebqZSzh2xKMF0SlSh
         IWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720033700; x=1720638500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlntWaXrDgE6HSswwW9oXi0jbGPL9ArLggt0x5XmFrg=;
        b=N2udYS3uvN+2crC1t02U4MIEW5BVcFQTlJECMKeucAD3TICjEztPL8prtJx9G6LkY8
         IQbPG8hEMlU8dJoKn/sfUC75vmAAq/ilq2K0n4i6kK4rSpCM044G7ED66gL+wWu4vc06
         FEFR+VO68KX1Xe3XHQsW9IFAOOfcTXkD7v+fhga9dYoNnllz3PJFr9MSiT961KeTKNFN
         684UBibNjOmRsbZk7nCWR4FgyUx1B8NL3ete1Rdq2W2X3DtvRQa9fN8jhfTzlFrQMubr
         VtCnF9fVOFt2Dq2EuLXBx3KnqlX++QuLeDY3s2EwdBZcZvlOJNo1FMI67AgaRG5iIEmn
         550Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/zsZy+1FY0pmoaFufzo8Q2ZM8x/c210mvnzXlJ6jY6QGNLgYlwtAZEZ19sYxqDeOQYd1Nqp3KXIZ/dByjA5E6nkhsGYsN5oNpiqjEi82FwKbjUf13cyFTe4oacr3KlTsJ6SC/M2YfPIprDmFO9udaXo5k4zDd/edb
X-Gm-Message-State: AOJu0YzmRv2r/T5W9MQ0Q5SPPy9quqygOoRnQ9xpmyayJUbsXRQKJO4z
	LfbqUQlOSGieF8IncsDQZklJT9QYcEfjQ/4waYtjOBCpSHKJs5in1pCY9A==
X-Google-Smtp-Source: AGHT+IEhYsRvNc0lqvVe3TlXD9DWFvBg0+oQz1UgPDpTJWstt7MI64FMmex1waX5Hsqm8bgi3ztE2Q==
X-Received: by 2002:a2e:9ed2:0:b0:2ec:5699:5e6 with SMTP id 38308e7fff4ca-2ee5e37ff7cmr75446691fa.26.1720033700085;
        Wed, 03 Jul 2024 12:08:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5a11d48asm16798821fa.100.2024.07.03.12.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 12:08:19 -0700 (PDT)
Date: Wed, 3 Jul 2024 22:08:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Halaney <ahalaney@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 14/17] net: stmmac: Move internal PCS
 PHYLINK ops to stmmac_pcs.c
Message-ID: <4q6a2vo23clanqs36e2idzjybh7ugp7pxqldeyhkk4upfn4lhp@75mz4t7rbhjm>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-6-fancer.lancer@gmail.com>
 <Zn7Rwt9KNac2mMah@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7Rwt9KNac2mMah@shell.armlinux.org.uk>

On Fri, Jun 28, 2024 at 04:07:46PM +0100, Russell King (Oracle) wrote:
> On Mon, Jun 24, 2024 at 04:26:31PM +0300, Serge Semin wrote:
> > @@ -621,7 +548,6 @@ int dwmac1000_setup(struct stmmac_priv *priv)
> >  	mac->mii.clk_csr_shift = 2;
> >  	mac->mii.clk_csr_mask = GENMASK(5, 2);
> >  
> > -	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
> >  	mac->mac_pcs.neg_mode = true;
> 
> "mac->mac_pcs.neg_mode = true;" is a property of the "ops" so should
> move with it.
> 
> > @@ -1475,7 +1396,6 @@ int dwmac4_setup(struct stmmac_priv *priv)
> >  	mac->mii.clk_csr_mask = GENMASK(11, 8);
> >  	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
> >  
> > -	mac->mac_pcs.ops = &dwmac4_mii_pcs_ops;
> >  	mac->mac_pcs.neg_mode = true;
> 
> Also applies here.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > index 3666893acb69..c42fb2437948 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > @@ -363,6 +363,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
> >  		mac->tc = mac->tc ? : entry->tc;
> >  		mac->mmc = mac->mmc ? : entry->mmc;
> >  		mac->est = mac->est ? : entry->est;
> > +		mac->mac_pcs.ops = mac->mac_pcs.ops ?: entry->pcs;
> 

> Removing both of the above means that mac->mac_pcs.ops won't ever be set
> prior to this, so this whole thing should just be:
> 
> 		mac->mac_pcs.ops = entry->pcs;
> 		mac->mac_pcs.neg_mode = true;

Actually, no. mac->mac_pcs.ops can be set by the platform-specific
plat_stmmacenet_data::setup() method.

> 
> > +static void dwmac_pcs_get_state(struct phylink_pcs *pcs,
> > +				struct phylink_link_state *state)
> >  {
> > +	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
> >  	struct stmmac_priv *priv = hw->priv;
> >  	u32 val;
> >  
> > +	val = stmmac_pcs_get_config_reg(priv, hw);
> > +
> > +	/* TODO The next is SGMII/RGMII/SMII-specific */
> > +	state->link = !!(val & PCS_CFG_LNKSTS);
> > +	if (!state->link)
> > +		return;
> > +
> > +	switch (FIELD_GET(PCS_CFG_LNKSPEED, val)) {
> > +	case PCS_CFG_LNKSPEED_2_5:
> > +		state->speed = SPEED_10;
> > +		break;
> > +	case PCS_CFG_LNKSPEED_25:
> > +		state->speed = SPEED_100;
> > +		break;
> > +	case PCS_CFG_LNKSPEED_250:
> > +		state->speed = SPEED_1000;
> > +		break;
> > +	default:
> > +		netdev_err(priv->dev, "Unknown speed detected\n");
> > +		break;
> > +	}
> > +
> > +	state->duplex = val & PCS_CFG_LNKMOD ? DUPLEX_FULL : DUPLEX_HALF;
> > +
> > +	/* TODO Check the PCS_AN_STATUS.Link status here?.. Note the flag is latched-low */
> > +
> > +	/* TODO The next is the TBI/RTBI-specific and seems to be valid if PCS_AN_STATUS.ANC */
> >  	val = readl(priv->pcsaddr + PCS_ANE_LPA);
> 

> I thought these registers only existed of dma_cap.pcs is true ?

Right. The AN-registers are SGMII/TBI/RTBI-specific.

> If we
> start checking PCS_AN_STATUS.Link here, and this register reads as
> zeros, doesn't it mean that RMGII inband mode won't ever signal link
> up?

Right. The PCS_AN_STATUS.Link should be checked for the SGMII (and
TBI/RTBI) only. The databooks defines the flag as follows:

DW GMAC v3.73a:
Link Status   This bit indicates whether the data channel (link) is up or
R_SS_SC_LLO   down. For the TBI, RTBI or SGMII interfaces, if ANEG is going
              on, data cannot be transferred across the link and hence the
              link is given as down.

DW QoS Eth:
Link Status   When this bit is set, it indicates that the link is up between
Read-only     the MAC and the TBI, RTBI, or SGMII interface. When this bit is
              reset, it indicates that the link is down between the MAC and
              the TBI, RTBI, or SGMII interface.

I guess that in fact the flag semantics is the same on both devices.
But the Access-status for some reason different. Although DW QoS Eth
databook doesn't define any latched-low CSR. So there is a chance that
some of the databooks might be wrong in the flag access status.

> 
> >  
> > -	/* TODO Make sure that STMMAC_PCS_PAUSE STMMAC_PCS_ASYM_PAUSE usage is legitimate */
> > +	/* TODO The databook says the encoding is defined in IEEE 802.3z,
> > +	 * Section 37.2.1.4. Do we need the STMMAC_PCS_PAUSE and
> > +	 * STMMAC_PCS_ASYM_PAUSE mask here?
> > +	 */
> >  	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> >  			 state->lp_advertising,
> >  			 FIELD_GET(PCS_ANE_PSE, val) & STMMAC_PCS_PAUSE);
> 

> If it's 802.3z aka 1000base-X format, then yes, we should be using
> these bits if we are getting state from this register.

I meant that should we be using the driver-specific macro in here
seeing the field encoding is defined by the IEEE 802.3z? Is there any
ready-to-use macros/constants defined in the network subsystem core
for the standard Pause encoding (IEEE 802.3z Section 37.2.1.4)?

> 
> If TBI/RTBI is ever used, rather than trying to shoe-horn it all into
> these functions, please consider splitting them into separate PCSes,
> and sharing code between them e.g. using common functions called from
> the method functions or shared method functions where appropriate.

Ok. Sounds reasonable.

I guess your message also means that the patchset re-spinning will be
on me from now, right?) If so, please note, I can't promise I'll be
able to do that soonish. I am quite busy at the moment. I'll be
more-or-less free for that in a month or so.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

