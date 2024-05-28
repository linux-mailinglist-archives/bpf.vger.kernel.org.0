Return-Path: <bpf+bounces-30745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6767E8D1CCA
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 15:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3031C228F7
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B282170855;
	Tue, 28 May 2024 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpVGcXQg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34232170840;
	Tue, 28 May 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902397; cv=none; b=dGTNp++K2zHALQRly8OtNyYclG8NJZ1r0ZJ6aDN7dCOjwMCFaljRnpIwft4kPhv0uhuRRZBbK2mCv5AAp4Ru82S+WRbpADGuvRhiiRm5ytaIq4GjNAnObCshC/FL6ykmRjgr9z33AMUE2vMTF1ulCp5//Yf67wj0P+ouGiOOY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902397; c=relaxed/simple;
	bh=bKuZ5xm3ArcCR8+/y1nP3L+xonKgXzP8+7tYddFCFkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zba3BhdtHYB0Y0hsy124MvnMSI/xJSge0o47kmLCWU4uXr4vKsK/icxgD1UZlXMJ4cY8HmTgeLMcsBqjXH31HKygTmgnhrZnBGs5H0QLO7E5XKMktD6Snca7+PYHHHZL31zQlVThXGvqIIrYWIMt2c/ZqlpBrelZeu1gI7uFmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpVGcXQg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e95b03e0d6so37465951fa.1;
        Tue, 28 May 2024 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716902393; x=1717507193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lsS6UWs3Vq43Zsc//O5k/DxSvkmM/xM5dPhYo3OcQk=;
        b=DpVGcXQgxSkM+JC2lL8TXdBLPuVBLmAw6wvMv/hXUS/YyxvbqlWslDKM2ntm/pEj6R
         eNe8xa89sx336H8quDG056JbmxYOkxdrFXXxYBLwh33mSmsYNfIzFyQe+pxuAd5l2rUI
         megKMJlDahOJIDNHi9eZVOyCJ7uzEH5Qe4Nv93wAsf5p4oZs8ScVaBAW/nGVgayUPDrZ
         AkFKoJh5dwfSDuAuC9MW3FNSuquh/lX/nbsvTbLwmYE4HiRZTdmiP82lOU4BM9cD9Shh
         H4A+ihBjVsR5egy+YgCy9bQ2COyk1Izmm8//O3/s+QvDNb1dTuMNQ49t2lGR/+O9N5pr
         pudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716902393; x=1717507193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lsS6UWs3Vq43Zsc//O5k/DxSvkmM/xM5dPhYo3OcQk=;
        b=deXOI0ZR22QKH89TfbkWJ0SvgAWznsYKh2iTGoROD0zzFoqlszh4fWzstSqe1IcFZs
         UWrSlhueJdzs+lZCi5OgWliaOttNQv7+knJzVenF0DcGcrXaXuUGtKJ8VFUmk/7LJRUi
         LV/jmhhgt7WOLtfpF1rhhMxseHwDtt8rFLV748OL1+i6xw3xa4Q/+OAMCbQMrBsWTP0N
         s6Y4vhzz+wjvOS+PFALs/PjbGBTFAgoBSmLrz8K0rGUQjOElpZdAw1iX6VoYffE4dZnt
         x1DTHlGkq6Yoahs7IobHSUc/rKw6IMQ4Q/BT7cNAqWNVLPdRDDYJZRMJjeIX10c24PQS
         jPUg==
X-Forwarded-Encrypted: i=1; AJvYcCUFN2Jey7gx3Fdw1I1XBt4CUpzZi865i7vAcsAZ8KPWjYA9n9PvrghwL+2Q1ZrMGC9rNtU6eP6Y3fLtYuIk0/JM7HM7lQhhzaXCyk0KHBnRPdw90xLcdmgn5UXUoFWEeLwUVQtaHy19uf82uPUQ6QbLL+hwQq2L8m4w
X-Gm-Message-State: AOJu0Yya4mwKq6B58a237BcP5w0vvLgOKYCzb6lVHKL0LG9EfqOYIE1q
	DHO5+O38JqpAW4bJ41zQ2UgJvsjekIKu5AV4OnjSdEOirnRl65Ci
X-Google-Smtp-Source: AGHT+IHZcnC5BdWmLAQ1pEXAqgf9x+btzizPqon18tqiGfOweOD0mKmJiT+90UQPwurV17XYK8aGGg==
X-Received: by 2002:a2e:a3d2:0:b0:2d4:535a:e7a with SMTP id 38308e7fff4ca-2e95a1058e2mr38060261fa.24.1716902393172;
        Tue, 28 May 2024 06:19:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc4aa9sm22543531fa.9.2024.05.28.06.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 06:19:52 -0700 (PDT)
Date: Tue, 28 May 2024 16:19:49 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Byungho An <bh74.an@samsung.com>, Giuseppe CAVALLARO <peppe.cavallaro@st.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/3] net: stmmac: Activate Inband/PCS flag
 based on the selected iface
Message-ID: <ukszpirecb3pwnz5bbmy7wl44ujh6t2ewrnodmrye5kjmonsz2@pgf5b2oy5n3p>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
 <ZlN4tkY8fNM8/D8p@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlN4tkY8fNM8/D8p@shell.armlinux.org.uk>

On Sun, May 26, 2024 at 07:00:22PM +0100, Russell King (Oracle) wrote:
> On Sun, May 26, 2024 at 05:49:48PM +0100, Russell King (Oracle) wrote:
> > On Sat, May 25, 2024 at 12:02:58AM +0300, Serge Semin wrote:
> > > The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
> > > into the DW GMAC controller. It's always done if the controller supports
> > > at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
> > > interfaces support was activated during the IP-core synthesize the PCS
> > > block won't be activated either and the HWFEATURE.PCSSEL flag won't be
> > > set. Based on that the RGMII in-band status detection procedure
> > > implemented in the driver hasn't been working for the devices with the
> > > RGMII interface support and with none of the SGMII, TBI, RTBI PHY
> > > interfaces available in the device.
> > > 
> > > Fix that just by dropping the dma_cap.pcs flag check from the conditional
> > > statement responsible for the In-band/PCS functionality activation. If the
> > > RGMII interface is supported by the device then the in-band link status
> > > detection will be also supported automatically (it's always embedded into
> > > the RGMII RTL code). If the SGMII interface is supported by the device
> > > then the PCS block will be supported too (it's unconditionally synthesized
> > > into the controller). The later is also correct for the TBI/RTBI PHY
> > > interfaces.
> > > 
> > > Note while at it drop the netdev_dbg() calls since at the moment of the
> > > stmmac_check_pcs_mode() invocation the network device isn't registered. So
> > > the debug prints will be for the unknown/NULL device.
> > 
> > Thanks. As this is a fix, shouldn't it be submitted for the net tree as
> > it seems to be fixing a bug in the driver as it stands today?
> > 
> > Also, a build fix is required here:
> > 
> > > -	if (priv->dma_cap.pcs) {
> > > -		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
> > > -		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
> > > -		    (interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
> > > -		    (interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
> > > -			netdev_dbg(priv->dev, "PCS RGMII support enabled\n");
> > > -			priv->hw->pcs = STMMAC_PCS_RGMII;
> > > -		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
> > > -			netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
> > > -			priv->hw->pcs = STMMAC_PCS_SGMII;
> > > -		}
> > > -	}
> > > +	if (phy_interface_mode_is_rgmii(interface))
> > > +		priv->hw.pcs = STMMAC_PCS_RGMII;
> > > +	else if (interface == PHY_INTERFACE_MODE_SGMII)
> > > +		priv->hw.pcs = STMMAC_PCS_SGMII;
> > 
> > Both of these assignments should be priv->hw->pcs not priv->hw.pcs.
> > 
> > I think there's also another bug that needs fixing along with this.
> > See stmmac_ethtool_set_link_ksettings(). Note that this denies the
> > ability to disable autoneg, which (a) doesn't make sense for RGMII
> > with an attached PHY, and (b) this code should be passing the
> > ethtool op to phylink for it to pass on to phylib so the PHY can
> > be appropriately configured for the users desired autoneg and
> > link mode settings.
> > 
> > I also don't think it makes any sense for the STMMAC_PCS_SGMII case
> > given that it means Cisco SGMII - which implies that there is also
> > a PHY (since Cisco SGMII with inband is designed to be coupled with
> > something that looks like a PHY to send the inband signalling
> > necessary to configure e.g. the SGMII link symbol replication.
> > 
> > In both of these cases, even if the user requests autoneg to be
> > disabled, that _shouldn't_ affect internal network driver links.
> > This ethtool op is about configuring the externally visible media
> > side of the network driver, not the internal links.
> 

> I have a concern about this patch. Have you considered dwmac-intel with
> its XPCS support, where the XPCS is used for Cisco SGMII and 1000base-X
> support. Does the dwmac-intel version of the core set
> priv->dma_cap.pcs? If it doesn't, then removing the test on this will
> cause a regression, since in Cisco SGMII mode, we end up setting
> priv->hw->pcs to SYMMAC_PCS_SGMII where we didn't before. As
> priv->flags will not have STMMAC_FLAG_HAS_INTEGRATED_PCS, this will
> enable all the "integrated PCS" code paths despite XPCS clearly
> intending to be used for Cisco SGMII.
> 
> I'm also wondering whether the same applies to the lynx PCS as well,
> or in the general case if we have any kind of external PCS.
> 
> Hence, I think this probably needs to be:
> 
> 	if (phy_interface_mode_is_rgmii(interface))
> 		priv->hw->pcs = STMMAC_PCS_RGMII;
> 	else if (interface == PHY_INTERFACE_MODE_SGMII && priv->dma_cap.pcs)
> 		priv->hw->pcs = STMMAC_PCS_SGMII;
> 
> At least this is what unpicking the awful stmmac code suggests (and I
> do feel that my point about the shocking state of this driver is proven
> as details like this are extremely difficult to unpick, and not
> unpicking them correctly will lead to regressions.) Therefore, I would
> suggest that it would be wise if you also double-checked this.

Double-checked that part. Indeed this is what I forgot to take into
account. (Just realized I had a glimpse thought about checking the DW
xGMAC/XPCS for supporting the SGMII interface, but the thought got
away from my mind forgotten.) DW XPCS can be synthesized with having
the GMII/MII interface connected to the MAC and SGMII downstream
interface over a single 1000Base-X lane.

In anyway AFAICS that case has nothing to do with the PCS embedded
into the DW GMAC or DW QoS Eth synthesized with the SGMII support. DW
XGMAC has no embedded PCS, but could be attached to the separate DW
XPCS device.

About the correct implementation. Right, priv->dma_cap.pcs indicates
that there is an embedded PCS and the flag can be set for DW GMAC or DW
QoS Eth only. Although I would change the order:

       if (phy_interface_mode_is_rgmii(interface))
               priv->hw->pcs = STMMAC_PCS_RGMII;
       else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
               priv->hw->pcs = STMMAC_PCS_SGMII;

since priv->dma_cap.pcs is a primary flag. If it isn't set the
interface will be irrelevant.

Alternative solution could be to use the has_gmac/has_gmac4 flags
instead. That will emphasize that the embedded PCS is expected to be
specific for the DW GMAC and DW QoS Eth IP-cores:

       if (phy_interface_mode_is_rgmii(interface))
               priv->hw->pcs = STMMAC_PCS_RGMII;
       else if ((priv->plat.has_gmac || priv->plat.has_gmac4) &&
		interface == PHY_INTERFACE_MODE_SGMII)
               priv->hw->pcs = STMMAC_PCS_SGMII;

-Serge(y)

> 
> If my analysis is correct, then my changes to stmmac_mac_select_pcs()
> are also wrong.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

