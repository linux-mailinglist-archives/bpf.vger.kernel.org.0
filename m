Return-Path: <bpf+bounces-33909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892C4927E07
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 21:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099EF1F24633
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9B13D276;
	Thu,  4 Jul 2024 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMgoR0KY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739242F23;
	Thu,  4 Jul 2024 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122987; cv=none; b=TZgHmyoQkZO7stGUGbHN6oOgffSzyE+tA2U1/5vCff3Un5t1c9MGsaMFL5a7XLc8MTYYRcF/qB0tD54yeAErbQkfxfwxVhniAaErR3AIC01O4dvfYoAZcIOha8ylGuYuM3/oBbz7i3PqwkhKr/wiYpFKlOmwbhtKqeQgr/m1b/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122987; c=relaxed/simple;
	bh=YFGCG+Y1mFcp8uFnyfNRgPfbiEY3mJmP+i948uSZaZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4maeH6nIte+VtMl/QKYg3dNeSeT8GbSCODFJo/18/Ldo0PZ/S2aNl25Mz81ih9trvjEgfZ6hX5XuKCZVlWUd5QlLKeKa/eA0oNKB3Hd0RjnOJvuEOkeVrSfakOw6+yCuHB8i+SE7X/j3gHB/8id/x0FTFINdcCIAqcQmAAhCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMgoR0KY; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ee920b0781so4894211fa.1;
        Thu, 04 Jul 2024 12:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720122983; x=1720727783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T5hX7DNMSGVPeQt2ruoRa6Yr82t4hcURljOV5Qu5BwY=;
        b=RMgoR0KY1tpqCCpw7l6djTj1Ra0HgLbKVQjtxn5EtZ3yCRnMJ//Pw38SpJ6GVDmd68
         yxE1T2BQn3NKp01M/9Cq30SDKDyHRJW6sLvNdKgccL2JWNSGOJKy5aFrMULI4OlfMs7e
         GhxjPzD0JP2uizwco1AsEDwZ0/THmiiPn/ulPBxA7PjVwbGCCP84qmjaXlSw0+GsxTcN
         Y2akbb655HD3Dvj9OwzDBYvHNhku0KlJ50Yx3FGsgqWeQZZjRVkjOtJxAWhb0YFu7vZw
         do/a2RvShce6l55YIUU4vMkd8FkTnWbNRfgXGlZaFY/6uisu61Noeh9Dxu+KzyG1plpO
         vVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720122983; x=1720727783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5hX7DNMSGVPeQt2ruoRa6Yr82t4hcURljOV5Qu5BwY=;
        b=Y7TMl0mAaLbcIanFGKrYTfeUvL/QG/koW4r2LvpSA0NumKnwKCKK7g2oOJP9hoVb3x
         k7Hm/sIW5kxK98PHn9J67mvzuen9uGR4fTRioaZ19zsNZY6cmdmSUHBEpgraL4/YK2Hc
         1f0RCZryu3494o3nz7ESpwY0NWnFi8qk+BBPhPpb8JRbARSE02/3xYKMrZF8XHP1luvl
         yb4z9eibY9H8hNpMncRLZ8vm8Eq6xcqe+iWS+tLEiXmLyReeqAv0fr7u/TKjH/jzXd5P
         6MjFtOr1ApGacFQnQxjgJIEMQEhdHuF8zuMzuTiY6QRlaWtqACxC8v2aCCB/6WOCYkBH
         Fo5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW7X7bIqkU8Nb4+XNVqF+JDSUMBR8ZYUGoj4YG7E2qtovk+qbLK4qsbJNl3//fC+RVrdwFV7Ta0S++6aJ6J/buJVjiH2W6W/XcSslO/HXO5WD9S0iNaXN0JlT8XQPu1bkO7gJenO37K1O7jUB70AgiZe38eTCT7nqk
X-Gm-Message-State: AOJu0YzhvdBRdlEQbuHemINPPXOkKBZ9SVhi757tX11u3zBFL9SeiEGn
	cFCVWJfcSG4MKcHbE9speLek05vqJJoCx8fJ2NxDVBj9ic2kPm82
X-Google-Smtp-Source: AGHT+IGbU17GjcUH7kKqzQCOajDryup2rgaM1Kxc28/sqbd8meWamzP4ZHG3VTliJxJ1isrF/OA3gA==
X-Received: by 2002:ac2:596a:0:b0:52e:767a:ada7 with SMTP id 2adb3069b0e04-52ea06ba8afmr1576303e87.50.1720122982057;
        Thu, 04 Jul 2024 12:56:22 -0700 (PDT)
Received: from mobilestation ([95.79.180.161])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0bbf0sm2585230e87.25.2024.07.04.12.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 12:56:21 -0700 (PDT)
Date: Thu, 4 Jul 2024 22:56:19 +0300
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
Message-ID: <3mpvgoh6sdyccpppmwkoqugvoyv3spgyry47gg6sjmpg5es3iy@zqd3p3k6lpnn>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-6-fancer.lancer@gmail.com>
 <Zn7Rwt9KNac2mMah@shell.armlinux.org.uk>
 <4q6a2vo23clanqs36e2idzjybh7ugp7pxqldeyhkk4upfn4lhp@75mz4t7rbhjm>
 <ZoWvejkng/Ch/YIz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoWvejkng/Ch/YIz@shell.armlinux.org.uk>

On Wed, Jul 03, 2024 at 09:07:22PM +0100, Russell King (Oracle) wrote:
> On Wed, Jul 03, 2024 at 10:08:16PM +0300, Serge Semin wrote:
> > On Fri, Jun 28, 2024 at 04:07:46PM +0100, Russell King (Oracle) wrote:
> > > On Mon, Jun 24, 2024 at 04:26:31PM +0300, Serge Semin wrote:
> > > > @@ -621,7 +548,6 @@ int dwmac1000_setup(struct stmmac_priv *priv)
> > > >  	mac->mii.clk_csr_shift = 2;
> > > >  	mac->mii.clk_csr_mask = GENMASK(5, 2);
> > > >  
> > > > -	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
> > > >  	mac->mac_pcs.neg_mode = true;
> > > 
> > > "mac->mac_pcs.neg_mode = true;" is a property of the "ops" so should
> > > move with it.
> > > 
> > > > @@ -1475,7 +1396,6 @@ int dwmac4_setup(struct stmmac_priv *priv)
> > > >  	mac->mii.clk_csr_mask = GENMASK(11, 8);
> > > >  	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
> > > >  
> > > > -	mac->mac_pcs.ops = &dwmac4_mii_pcs_ops;
> > > >  	mac->mac_pcs.neg_mode = true;
> > > 
> > > Also applies here.
> > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > > index 3666893acb69..c42fb2437948 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > > @@ -363,6 +363,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
> > > >  		mac->tc = mac->tc ? : entry->tc;
> > > >  		mac->mmc = mac->mmc ? : entry->mmc;
> > > >  		mac->est = mac->est ? : entry->est;
> > > > +		mac->mac_pcs.ops = mac->mac_pcs.ops ?: entry->pcs;
> > > 
> > 
> > > Removing both of the above means that mac->mac_pcs.ops won't ever be set
> > > prior to this, so this whole thing should just be:
> > > 
> > > 		mac->mac_pcs.ops = entry->pcs;
> > > 		mac->mac_pcs.neg_mode = true;
> > 
> > Actually, no. mac->mac_pcs.ops can be set by the platform-specific
> > plat_stmmacenet_data::setup() method.
> 
> mac->mac_pcs is there for the _internal_ MAC only, not for platforms
> to fiddle around with (remember, my patch set adds this!)
> 
> I think you're thinking of mac->phylink_pcs which platforms can and
> do fiddle with.

Actually I did mean mac->mac_pcs.ops. AFAICS the stmmac_hwif_init()
method semantics implies that the plat_stmmacenet_data::setup()
function responsibility is to allocate the mac_device_info instance
and pre-initialize it' fields with the data specific for the
particular device including the DW MAC HW-interface ops. Like it's
done in the dwmac-sun8i.c driver (and in the currently being reviewed
Loongson GMAC/GNET series). So I suppose it should also concern the
internal PCS ops implementation being added by you. In case if some
particular controller has some internal PCS peculiarities required to
be fixed on the PHY-link PCS ops implementation level. No?

> 
> > > > +	/* TODO Check the PCS_AN_STATUS.Link status here?.. Note the flag is latched-low */
> > > > +
> > > > +	/* TODO The next is the TBI/RTBI-specific and seems to be valid if PCS_AN_STATUS.ANC */
> > > >  	val = readl(priv->pcsaddr + PCS_ANE_LPA);
> > > 
> > 
> > > I thought these registers only existed of dma_cap.pcs is true ?
> > 
> > Right. The AN-registers are SGMII/TBI/RTBI-specific.
> 

> Therefore, I suggest that if state->interface is RGMII, then these
> registers should not be accessed.

Fully agree.

> 
> My idea is to provide two PCS per MAC:
> 
> One simple one which covers RGMII which only reads the PHYIF/RGSMIIIS
> register, does no configuration, but does implement the .pcs_enable/
> .pcs_disable etc. The .pcs_validate method should also be empty for
> this because the AutoNeg ethtool capability does not refer to the
> inband signalling, but to the media PHY.
> 
> Then a more complex PCS implementation that does everything the RGMII
> one does, but also the bits for SGMII (and TBI/RTBI).

Agreed. Good idea.

> 
> > > If we
> > > start checking PCS_AN_STATUS.Link here, and this register reads as
> > > zeros, doesn't it mean that RMGII inband mode won't ever signal link
> > > up?
> > 
> > Right. The PCS_AN_STATUS.Link should be checked for the SGMII (and
> > TBI/RTBI) only. The databooks defines the flag as follows:
> > 
> > DW GMAC v3.73a:
> > Link Status   This bit indicates whether the data channel (link) is up or
> > R_SS_SC_LLO   down. For the TBI, RTBI or SGMII interfaces, if ANEG is going
> >               on, data cannot be transferred across the link and hence the
> >               link is given as down.
> > 
> > DW QoS Eth:
> > Link Status   When this bit is set, it indicates that the link is up between
> > Read-only     the MAC and the TBI, RTBI, or SGMII interface. When this bit is
> >               reset, it indicates that the link is down between the MAC and
> >               the TBI, RTBI, or SGMII interface.
> > 
> > I guess that in fact the flag semantics is the same on both devices.
> > But the Access-status for some reason different. Although DW QoS Eth
> > databook doesn't define any latched-low CSR. So there is a chance that
> > some of the databooks might be wrong in the flag access status.
> 
> Yes, it sounds like it.
> 
> > > > -	/* TODO Make sure that STMMAC_PCS_PAUSE STMMAC_PCS_ASYM_PAUSE usage is legitimate */
> > > > +	/* TODO The databook says the encoding is defined in IEEE 802.3z,
> > > > +	 * Section 37.2.1.4. Do we need the STMMAC_PCS_PAUSE and
> > > > +	 * STMMAC_PCS_ASYM_PAUSE mask here?
> > > > +	 */
> > > >  	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> > > >  			 state->lp_advertising,
> > > >  			 FIELD_GET(PCS_ANE_PSE, val) & STMMAC_PCS_PAUSE);
> > > 
> > 
> > > If it's 802.3z aka 1000base-X format, then yes, we should be using
> > > these bits if we are getting state from this register.
> > 
> > I meant that should we be using the driver-specific macro in here
> > seeing the field encoding is defined by the IEEE 802.3z? Is there any
> > ready-to-use macros/constants defined in the network subsystem core
> > for the standard Pause encoding (IEEE 802.3z Section 37.2.1.4)?
> 
> include/uapi/linux/mii.h:
> 
> #define ADVERTISE_1000XFULL     0x0020  /* Try for 1000BASE-X full-duplex */
> 	/* GMAC_ANE_FD */
> #define ADVERTISE_1000XHALF     0x0040  /* Try for 1000BASE-X half-duplex */
> 	/* GMAC_ANE_HD */
> #define ADVERTISE_1000XPAUSE    0x0080  /* Try for 1000BASE-X pause    */
> 	/* GMAC_ANE_PSE bit 0 */
> #define ADVERTISE_1000XPSE_ASYM 0x0100  /* Try for 1000BASE-X asym pause */
> 	/* GMAC_ANE_PSE bit 1 */
> #define ADVERTISE_LPACK         0x4000  /* Ack link partners response  */
> 	/* GMAC_ANE_ACK */
> 
> #define LPA_1000XFULL           0x0020  /* Can do 1000BASE-X full-duplex */
> 	/* GMAC_ANE_FD */
> #define LPA_1000XHALF           0x0040  /* Can do 1000BASE-X half-duplex */
> 	/* GMAC_ANE_HD */
> #define LPA_1000XPAUSE          0x0080  /* Can do 1000BASE-X pause     */
> 	/* GMAC_ANE_PSE bit 0 */
> #define LPA_1000XPAUSE_ASYM     0x0100  /* Can do 1000BASE-X pause asym*/
> 	/* GMAC_ANE_PSE bit 1 */
> #define LPA_RESV                0x1000  /* Unused...                   */
> 	/* GMAC_ANE_RFE bit 0 */
> #define LPA_RFAULT              0x2000  /* Link partner faulted        */
> 	/* GMAC_ANE_RFE bit 1 */
> #define LPA_LPACK               0x4000  /* Link partner acked us       */
> 	/* GMAC_ANE_ACK */

Got it. Thanks.

> 
> > > If TBI/RTBI is ever used, rather than trying to shoe-horn it all into
> > > these functions, please consider splitting them into separate PCSes,
> > > and sharing code between them e.g. using common functions called from
> > > the method functions or shared method functions where appropriate.
> > 
> > Ok. Sounds reasonable.
> > 
> > I guess your message also means that the patchset re-spinning will be
> > on me from now, right?) If so, please note, I can't promise I'll be
> > able to do that soonish. I am quite busy at the moment. I'll be
> > more-or-less free for that in a month or so.
> 
> Not necessarily - some good news today, the high priority issue I was
> working on is lower priority at last, which means I've more time to
> look at mainline again. Bad news... I need a break after about 2.5
> months of frustrations, which could be from this weekend!
> 
> Given the fix for the LNKMOD issue, I suspect that won't be merged
> into net-next until after the weekend, but I'll see whether I can
> sneak a respin of the patch set once that's happened. That said,
> given that we'll be at -rc7, it's likely too late to be thinking
> about getting the PCS changes queued up for this coming merge
> window. In any case, I don't think even if I did post a series, we're
> at the point where we have something that would be ready.

Ok. Let me know what is going to be my part in the next patch set
revision preparation and when my help is needed. I think I'll be able
to allocate some evenings and a few weekend days for that in this
month. I very much hope my work schedule will be less occupied in the
next month.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

