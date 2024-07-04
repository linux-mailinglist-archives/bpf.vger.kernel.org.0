Return-Path: <bpf+bounces-33888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1B927681
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040A11F21926
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833A1AED28;
	Thu,  4 Jul 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdpaFSKB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5D1AE876;
	Thu,  4 Jul 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097734; cv=none; b=TSxJ9itgpzjr70YO4qBxWRgZl1+lXg6y6/i1Jv4DxLA+w/+qYBm4+9+YRF4AtWxwx8Cs8gWM8G2noP4JhcRnOaa6dhRl0/VsWAWw8AUCgcqR+ll6YA72ZFmThWD0Rvmp3ScL1TGrDyVOO9wwLyOTReK6r92q9ngj+1Lk6Kp01Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097734; c=relaxed/simple;
	bh=CLQCpuvqmnBgD9vTGKcSZAqjHGvC+mRdnIHtTPH6QeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT0zB8o6j5UX/v0LFhpqFQ5owKIpzDaytXtyuuW3Cup/wHOg/2uryjyoR4i5cQeGxCZJk4O/48rjy8qqScizPtxULqsf4XnY0+dQ/ne7/sLT97NsPVbKTl0e/TyULvvXOe3Y3tJpa5DUHqO+Q0VSmYVUY3p39oT6bm2J8/rpA0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdpaFSKB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso6959241fa.0;
        Thu, 04 Jul 2024 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097731; x=1720702531; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IisAl8oOfrfYeQcJjMJI5kRn1qwRcjc/z7zNpbMqBTM=;
        b=GdpaFSKBfRfWDU2D3dqXU+tRS/THCeSeLuKIr4ewJXRkNRdGLohY1C36bFwmWw5Ro0
         g8GNU07rrC5h/7y0dr28pHd8+F0kiVGUf9yWvV0ROCC/S0rQK6NVL9H8qs2dKeqJKBUL
         KWDqrNe/Py+F6KrgrEY0KAgWia0hPJ7K84cUImXntg/kwM56+yzh1BdHTaQ26rTudY0k
         pCFtCtLHifaYRHwS7d7XT6BUr6POFDY8ljarW7g7Dn8gEBLW/KP75aDCKJVU5DmE1tOx
         K8gZd9rCdMPKW8I8ZLWPKQQyWCVAvi/J2wcdrMsG7u1+gLS4gB/v+U0S/1ZVfH2Q3jou
         USSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097731; x=1720702531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IisAl8oOfrfYeQcJjMJI5kRn1qwRcjc/z7zNpbMqBTM=;
        b=kRJpmHWJoiSB+tgO5Tz6UKh8paBrA5i/tvs+Qr1UyEi3E9YKVdXtWgRqRiwcTPalwF
         5l1qCm/O4K1vBwbH9Lv6MinngHoUUkRZWF9ddaUAU0qvWc79/K9RaPXgztRk9tzHVBVc
         +mfBL3H5HTDY+W5fORG4Idjrq+QnSvtMsAzbqAK5lxrcSBm+u7JrhDDw9Ln+46CkaFTA
         0dpvx/K7hv3JoQlKM/rr/wmQCf7UCpe6cwI01d1ALBj7xVjo0vOfkwfOia6xkGJvTAJv
         0pFNBjgJ8aTal7wQZby3OmgoYYYjw/RxnLLpMJEWhsbAYI6flb7kDHGNgiqi4ZllT1Y5
         8eBw==
X-Forwarded-Encrypted: i=1; AJvYcCWR/XERyUPmcT68lX/vz/UWJVSY+puO7j9SamEHO0O+gsDlZtKKxDbIZY1ltRgT4/k4j/JG+OSI324gw3stfSL69TT7SdHvsYgW3pAL8PPl222ytsy0TOwrVa6v9g9Mi+Mp62P6UTeEkzZNuVO0i5mvRSftOnNe+Hzd
X-Gm-Message-State: AOJu0YywePLzG0jGqGD9etG1wgy+qvSlJi+tmUBMciM69zk/szEA7V8O
	zNNXVs/JBA9YkLymsD2KeCpUtQcWsRfaU9QiMFPO1vYOOc6QfLR1
X-Google-Smtp-Source: AGHT+IEcnKmz932eZFNiupiD0RMCnB+W3lPfatW6ACtn3Rdl9ux7hoIMymXOiaKWmYqYxATMK7TOgg==
X-Received: by 2002:a2e:a988:0:b0:2ee:7255:5047 with SMTP id 38308e7fff4ca-2ee8ee0f784mr12540601fa.50.1720097730202;
        Thu, 04 Jul 2024 05:55:30 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e72csm22567491fa.23.2024.07.04.05.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:55:29 -0700 (PDT)
Date: Thu, 4 Jul 2024 15:55:26 +0300
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
Subject: Re: [PATCH RFC net-next v2 16/17] net: stmmac: Move internal PCS
 init method to stmmac_pcs.c
Message-ID: <5dsv27tygpfsmaofdtswwlsfjxzxlwnnysdziqgdglkydgoqtg@qwssdirr42bd>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-8-fancer.lancer@gmail.com>
 <Zn7KZG+KDU01APar@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7KZG+KDU01APar@shell.armlinux.org.uk>

On Fri, Jun 28, 2024 at 03:36:20PM +0100, Russell King (Oracle) wrote:
> On Mon, Jun 24, 2024 at 04:26:33PM +0300, Serge Semin wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 72c2d3e2c121..743d356f6d12 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -950,13 +950,16 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
> >  {
> >  	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
> >  
> > +	if (priv->hw->pcs)
> > +		return &priv->hw->mac_pcs;
> > +
> >  	if (priv->hw->xpcs)
> >  		return &priv->hw->xpcs->pcs;
> >  
> >  	if (priv->hw->phylink_pcs)
> >  		return priv->hw->phylink_pcs;
> >  
> > -	return stmmac_mac_phylink_select_pcs(priv, interface);
> > +	return NULL;
> 
> I really really don't like this due to:
> 

> 1. I spent a long time working out what the priority here should be, and
> you've just thrown all that work away by changing it - to something that
> I believe is incorrect.
> 

Right, the correct precedence would be to use the external PCS if one
available. It's easy to fix anyway.

> 2. I want to eventually see this function checking the interface type
> before just handing out a random PCS,

The only problem is that currently it relies on the
plat_stmmaenet_data::mac_interface field value instead of parsing the
specified interface type.(

> and it was my intention to
> eventually that into the MACs own select_pcs() methods. Getting rid of
> those methods means that the MACs themselves now can't make the
> decision which is where that should be.

Ok. Why not. We can preserve the MAC-own select_pcs() method.
(See my last comment on this email for details.)

> 
> 3. When operating in RGMII "inband" mode, the .pcs_config etc doesn't
> make much sense (we're probably accessing registers that don't exist)

Absolutely right. Current dwmac_pcs_config() implementation is fully
SGMII/TBI/RTBI-specific.

> and I had plans to split this into a RGMII "PCS" which was just a PCS
> that implemented .pcs_get_state(), a stub .pcs_config(), and a separate
> fully-featured "SGMII PCS".

Actually it's a good idea. We should have that implemented in v3.

> 
> So, I would like to eventually see here something like:
> 
> 	if (priv->hw->xpcs)
> 		return &priv->hw->xpcs->pcs;
> 
> 	if (priv->hw->phylink_pcs)
> 		return priv->hw->phylink_pcs;
> 
> 	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS)) {
> 		if (phy_interface_mode_is_rgmii(priv->plat->mac_interface))
> 			return &priv->hw->mac_rgmii_pcs;
> 
> 		if (priv->dma_cap.pcs &&
> 		    priv->plat->mac_interface == PHY_INTERFACE_MODE_SGMII)
> 			return &priv->hw->mac_sgmii_pcs;
> 	}
> 
> 	return NULL;

So the differences of my and your implementations are:
1. priv->hw->pcs field is utilized to determine the RGMII/SGMII PCS
availability (it's initialized in dwmac_pcs_init()).
2. The order of the PCS selection: internal PCS has precedence over
the external PCS'es.
3. There is a single PHY-link PCS descriptor for both RGMII "inband"
and SGMII PCSes.

There is nothing hard to settle the 2. and 3. notes. The only
problematic part is 1. due to the damn mac_device_info::ps field
implying the fixed-speed semantics for the MAC2MAC case. The field is
initialized in the stmmac_hw_setup() method based on the
mac_device_info::pcs field content. The mac_device_info::ps value is
then utilized in the stmmac_ops::core_init() methods and in
dwmac_pcs_config() to pre-define the link speed. Since I hadn't come
up with a good idea of what to do with that MAC2MAC stuff back then I
decided to preserve the mac_device_info::pcs-based semantics
everywhere.

But now I guess I've got a good idea. We can use the
plat_stmmacenet_data::mac_port_sel_speed field directly where it is
relevant. Like this:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:
static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
{
	// Drop everything priv->hw.pcs and priv->hw.ps related from here
	// due to the changes suggested further.
}

drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:
drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:
static void dwmac*_core_init(...)
{
	...
	// Directly use the plat_stmmacenet_data::mac_port_sel_speed value
	switch (priv->plat->mac_port_sel_speed) {
	case SPEED_1000:
		ps_speed = hw->link.speed1000;
		break;
	case SPEED_100:
		ps_speed = hw->link.speed100;
		break;
	case SPEED_10:
		ps_speed = hw->link.speed10;
		break;
	default:
		dev_warn(priv->device, "Unsupported port speed\n");
		break;
	}

	if (ps_speed) {
		value &= hw->link.speed_mask;
		value |= ps_speed | GMAC_CONFIG_TE;
	}
	...
}

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:
static void dwmac*_core_init(...)
{
	// There is no internal PCS in DW XGMACes. So we can freely drop
	// the hw->ps clause from here.
}

drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c:
static int dwmac_pcs_config(...)
{
	...
	// Directly use the plat_stmmacenet_data::mac_port_sel_speed value
	if (priv->plat->mac_port_sel_speed)
		val |= PCS_AN_CTRL_SGMRAL;
	...
}

After that we can freely drop the mac_device_info::ps and
mac_device_info::pcs fields. Thoughts?

> 
> > +void dwmac_pcs_init(struct mac_device_info *hw)
> > +{
> > +	struct stmmac_priv *priv = hw->priv;
> > +	int interface = priv->plat->mac_interface;
> > +
> > +	if (priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS)
> > +		return;
> > +	else if (phy_interface_mode_is_rgmii(interface))
> > +		hw->pcs = STMMAC_PCS_RGMII;
> > +	else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
> > +		hw->pcs = STMMAC_PCS_SGMII;
> > +
> > +	hw->mac_pcs.neg_mode = true;
> > +}
> 

> Please move "hw->mac_pcs.neg_mode = true;" to where the PCS method
> functions are implemented - it determines whether the PCS method
> functions take the AN mode or the neg mode, and this is a property of
> their implementations. It should not be split away from them.

Ok.

---

Seeing the series introducing the plat_stmmacenet_data::select_pcs()
method has been recently merged in, let's discuss the entire PCS
selection code a bit more. Taking into account what you said above I
guess we can implement something like this:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:
static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
                                                 phy_interface_t interface)
{
	// Platform-specific PCS selection method implying DW XPCS and
	// Lynx PCS selection (and internal PCS selection if relevant)
        if (priv->plat->select_pcs) {
                pcs = priv->plat->select_pcs(priv, interface);
                if (!IS_ERR(pcs))
                        return pcs;
        }

	// MAC-specific PCS selection method
	pcs = stmmac_mac_select_int_pcs(priv, priv->hw, priv->plat->mac_interface);
        if (!IS_ERR(pcs))
                return pcs;

        return NULL;
}

drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c:
static struct phylink_pcs *dwmac1000_select_pcs(struct mac_device_info *hw,
						phy_interface_t interface)
{
	if (phy_interface_mode_is_rgmii(interface))
		return &hw->mac_rgmii_pcs;
	else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
		return &hw->mac_sgmii_pcs;

	return NULLL
}

...

const struct stmmac_ops dwmac1000_ops = {
	...
	.select_pcs = dwmac1000_select_pcs,
	...
};

drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c:
// The same changes as in the dwmac1000_core.c file.

drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c:
// Drop my dwmac_pcs_init() implementation if we get to eliminate the 
// mac_device_info::ps and mac_device_info::pcs fields as I suggested
// earlier in this message


So what do you think?

-Serge(y)

> 
> Thanks.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

