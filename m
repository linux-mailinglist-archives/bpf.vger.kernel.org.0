Return-Path: <bpf+bounces-30617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF9C8CF632
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 23:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D78B3281D27
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 21:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3F13A25E;
	Sun, 26 May 2024 21:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dONSCuLl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98377947A;
	Sun, 26 May 2024 21:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716760629; cv=none; b=jUr1In3+xzb7b+BkOAC+4bcyz0jqF+ENcqRxMeCz/YBqJU1IjAz1MLCoWmtbm6Gu3J5k9nLE63a6/qVoIj3C+luvhNG5mydcYGO4mxLVvzrOgPUpOmUgqeHHaeir58VvFNncS0gRW2RDliSmQqWCnqlvrCLuRIcvmmCDoap5vkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716760629; c=relaxed/simple;
	bh=rXNP52xbCZ0tCH3EdYxEARpJusTg48r23ZLGQwMYmrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr+kLQmiO9qi6IsjSXmP67aTwhrcHf3kDY93WZimnj3EaMRZhiWXIImxe3RwE5Wrx/ZX3OdKosZTfswSqDKQnkQ5HI4QRMIn3hs8ATOnwO5jCVmPB92iHEckOPnsiWsNIUUY+WT6NntNPVImBoHJ9v6Xk8Iw4W6k22Rm9qRF6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dONSCuLl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e964acff1aso24392611fa.0;
        Sun, 26 May 2024 14:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716760626; x=1717365426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wSLYbNOc0WXKT9eTO9El1tEl9xgGnuLjqap+6tcHEXk=;
        b=dONSCuLlwAOif18HIS8aEeFPtW1Zdv/jVEOoxbqq6Ry9zFd25S6CNKUuNUh3848NQs
         ARV96MoIAAXpmxeHzcx1dmYnBTAmqqinJMmR0aY2MERg6d1mToKlQ6JHyeZDhHRmLA4Y
         weu5w4+L7i0jqZMcr2PWYdaT0uepaKYBFTRbBIyB2CphrTyX2ok7udc+HQNFFuneY2fJ
         9EVrqF29rzHy+unsivNWv5g0nDPTOYTMlZDGU5N7edWwp16mxIQMQWWurdYlhQgypfbp
         I/KtdcGG4K3MBxgzLgbFA+7gaJDUdMn3YlvUACE5irEpo/TxLrF56dMW1oBycNUzpXUj
         XPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716760626; x=1717365426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSLYbNOc0WXKT9eTO9El1tEl9xgGnuLjqap+6tcHEXk=;
        b=vcP1pYGrjdzIh8jDdhn21q9uyTdAEsnDA13iPmpRQnmTUQS/y21xYS8zMiCHEAQykZ
         qg1eEQtCvov/sZQfuSPkzpIDP7RPUHGOl7fSOGbayfEn49O17d1Dcg9WWczTHnUHUXlF
         Q1qRpKtC1be63W6G33lkPm+/59qqX0k3MM9sBIKoCHlYdhk7eR4RHWN3RHOs6946EhjE
         OQFihkokOAm8XQHmAermUHkAOpyGARzdJnuTVXDJYrYUrpTh6WgzpccoKIXtWoSt4KYk
         3GNjAtY2mC5p7L0H43Zyp5dfQMEDEoU5xdM/A9dD2L8M7kq4DwFxHVSdOauAt00evSpJ
         gJUA==
X-Forwarded-Encrypted: i=1; AJvYcCU97CRsOgB4VFYeGYVzV3IU1BYLXtVl5UaZOuemzsFeE/X4M6nQVHIEgfdjzBmONoBVwyGtTtKIAd/KPDV1t9VHWvhdFvvy6ZSjw2NL3a9kOwiMnze/xqmKTF7hmSwH9TJWhKfTi62b0odKQoXNyXusmd57GTkd/4jp
X-Gm-Message-State: AOJu0Yy3YRR/mXwgBNypkEIBEHbxzeaiv7hTv/Lo1RRlWHPLChQQY2hJ
	bxUUZHQm6GijEE+O0hT3UeSkllvB3+HlD4M2Lp1TubUnJHpUvE3+
X-Google-Smtp-Source: AGHT+IELJz1bfY7qab9MN0pLBVMuQ7fP28zkZOcK3TiIbIg7HQ+RVmpy5KdYhCO/w//q2oL5AJ01vQ==
X-Received: by 2002:ac2:5dca:0:b0:51e:150e:2c45 with SMTP id 2adb3069b0e04-52966e9ac88mr4682197e87.63.1716760625412;
        Sun, 26 May 2024 14:57:05 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529716dd12fsm453116e87.305.2024.05.26.14.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:57:04 -0700 (PDT)
Date: Mon, 27 May 2024 00:57:02 +0300
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
Message-ID: <fvjrnunu4lriegq3z7xkefsts6ybn2vkxmve6xzi73krjgvcj6@bhf4b4xx3x72>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>

On Sun, May 26, 2024 at 05:49:48PM +0100, Russell King (Oracle) wrote:
> On Sat, May 25, 2024 at 12:02:58AM +0300, Serge Semin wrote:
> > The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
> > into the DW GMAC controller. It's always done if the controller supports
> > at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
> > interfaces support was activated during the IP-core synthesize the PCS
> > block won't be activated either and the HWFEATURE.PCSSEL flag won't be
> > set. Based on that the RGMII in-band status detection procedure
> > implemented in the driver hasn't been working for the devices with the
> > RGMII interface support and with none of the SGMII, TBI, RTBI PHY
> > interfaces available in the device.
> > 
> > Fix that just by dropping the dma_cap.pcs flag check from the conditional
> > statement responsible for the In-band/PCS functionality activation. If the
> > RGMII interface is supported by the device then the in-band link status
> > detection will be also supported automatically (it's always embedded into
> > the RGMII RTL code). If the SGMII interface is supported by the device
> > then the PCS block will be supported too (it's unconditionally synthesized
> > into the controller). The later is also correct for the TBI/RTBI PHY
> > interfaces.
> > 
> > Note while at it drop the netdev_dbg() calls since at the moment of the
> > stmmac_check_pcs_mode() invocation the network device isn't registered. So
> > the debug prints will be for the unknown/NULL device.
> 

> Thanks. As this is a fix, shouldn't it be submitted for the net tree as
> it seems to be fixing a bug in the driver as it stands today?

From one point of view it could be submitted for the net tree indeed,
but on the second thought are you sure we should be doing that seeing
it will activate the RGMII-inband detection and the code with the
netif-carrier toggling behind the phylink back? Who knows what new
regressions the activated PCS-code can cause?..

> 
> Also, a build fix is required here:
> 
> > -	if (priv->dma_cap.pcs) {
> > -		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
> > -		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
> > -		    (interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
> > -		    (interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
> > -			netdev_dbg(priv->dev, "PCS RGMII support enabled\n");
> > -			priv->hw->pcs = STMMAC_PCS_RGMII;
> > -		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
> > -			netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
> > -			priv->hw->pcs = STMMAC_PCS_SGMII;
> > -		}
> > -	}
> > +	if (phy_interface_mode_is_rgmii(interface))
> > +		priv->hw.pcs = STMMAC_PCS_RGMII;
> > +	else if (interface == PHY_INTERFACE_MODE_SGMII)
> > +		priv->hw.pcs = STMMAC_PCS_SGMII;
> 
> Both of these assignments should be priv->hw->pcs not priv->hw.pcs.

Ah, right. Originally I applied your patchset on top of my fixes,
cleanups and platform glue-driver patchsets. One of the cleanups
implied the mac_device_info instance movement to the stmmac_priv
structure. When I was moving my changes onto your original series I
just missed that part of the patch. Sorry about that. The rest of my
patches seems free from such problem.

> 
> I think there's also another bug that needs fixing along with this.
> See stmmac_ethtool_set_link_ksettings(). Note that this denies the
> ability to disable autoneg, which (a) doesn't make sense for RGMII
> with an attached PHY, and 

This doesn't make sense for RGMII also due to DW GMAC/QoS Eth not having
anything AN-related for the RGMII PHY interface. RGMII mode permits
the Link status detection via the in-band signal retrieved from the
PHY and nothing else. AN, if enabled, is performed on the PHY side.

> (b) this code should be passing the
> ethtool op to phylink for it to pass on to phylib so the PHY can
> be appropriately configured for the users desired autoneg and
> link mode settings.

I am not that well aware of the phylink internals to be saying for
100% sure, but thinking logically it would be indeed better if phylink
was aware of the PCS state changes. But in case of the STMMAC PCS
implementation I guess that the original PCS-code was designed to work
with no PHY being involved:
e58bb43f5e43 ("stmmac: initial support to manage pcs modes")
See that commit prevented the MDIO-bus registration and PHY
initialization in case of the PCS/RGMII-inband being available. But in
practice the implementation turned to be not that well thought
through. So eventually, commit-by-commit, the implementation was
effectively converted to the no longer used code. At least for the
MACs with just RGMII interface and no additional SGMII/TBI/RTBI
interfaces, which I guess is the vast majority of the real devices
with RGMII.

> 
> I also don't think it makes any sense for the STMMAC_PCS_SGMII case
> given that it means Cisco SGMII - which implies that there is also
> a PHY (since Cisco SGMII with inband is designed to be coupled with
> something that looks like a PHY to send the inband signalling
> necessary to configure e.g. the SGMII link symbol replication.

AFAICS the STMMAC driver supports the MAC2MAC case connected over
SGMII with no intermediate PHY. In that case the speed will be just
fixed to what was set in the "snps,ps-speed" property. The RAL (Rate
Adapter Layer) is configured to do that by having the SGMRAL flag set
(see your dwmac_pcs_config() and what is done if hw->ps is non-zero).

> 
> In both of these cases, even if the user requests autoneg to be
> disabled, that _shouldn't_ affect internal network driver links.
> This ethtool op is about configuring the externally visible media
> side of the network driver, not the internal links.

IMO considering all the driver over-complexity (that's the most polite
definition I managed to come up to.)) it would be much easier and
likely safer not to try to fix the PCS-code and just convert it to
something sane. At least the RGMII/In-band functionality we'll be able
to test on my device. If the PCS SGMII part is still utilized by
anybody, then if there are problems there the new kernel RCs will get
to reveal them.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

