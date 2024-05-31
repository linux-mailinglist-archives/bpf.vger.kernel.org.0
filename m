Return-Path: <bpf+bounces-31057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DEC8D67E7
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6978028778C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE79C176AA5;
	Fri, 31 May 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+W3Tnsl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D5B158200;
	Fri, 31 May 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175637; cv=none; b=iOzM48LBr82rErQpUf09v8+tuJ4VBPC1/mBBipHVy5ud+HyEkH81zJz0YdnmG+NtOaH0LKhKgjJVWqXv3ONoaKI92JKo4WaRsrMeBw1tPT68YsNBvGhMeDSepJNY68dxm0M00p7rXKhgF9A/HUXo+uGRnfNAGwn5lYUjCrmiRO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175637; c=relaxed/simple;
	bh=b3OTtA1uUcvUZdMy/yJERBKgSS9GfcTsUhNRSWuLzc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSDPKSAM6dfqEbeeY5KmeMVT2+L8l/VrNAXgUPfekRy+pKD7+R4rabj9MZnSBNN7vsxNPUc7xT+1s+anEqgp04P4oJSPqKNB4JDgw6tPWyrHxqV+Px/vf7lE+SY6bkKjGvfLh5oP9zbW2xw0tc3dafs2iU4oHmVVwWPiXGJXbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+W3Tnsl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b8f5d811aso50572e87.3;
        Fri, 31 May 2024 10:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717175633; x=1717780433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKnCKOq41+4Rgep7k6ZlqSUDk6qvg8UE0gxKceBb9wA=;
        b=G+W3Tnsl2jhfp1n1hmb7r66kYgbFOdePZjAyhV0ovW7JNxpwYmryEcDLei8j+XRAb7
         45m0ArWTWlaL6sfRUdDCmFY4wxgJG8n/c3kn2xAu8eGB5+LQo0EF7cipScZbsNem16Zj
         FmqJmORKei9ibCVACjDQtRNW5TcFDlpriQCi2NVtNyBUJo/UX3SEQusaDP5uUCmkvgZs
         gtZCIuXT22KfsNH1Z09KiiO6fvC/GpHBq3p/LsjX60vHm25ym3AGY5YdNl4UI1C1hiWa
         Vu4c+lx62Hs8BknnoYdfD0iMuP+yEdODL/R01gCsqUWMgihYrHY+xGAJZipq11EQAP21
         s39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717175633; x=1717780433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKnCKOq41+4Rgep7k6ZlqSUDk6qvg8UE0gxKceBb9wA=;
        b=t1PzC03uqNCzuAe5/QwmPH5SVWOVRM8GvIKcat0AeLuVMnmNmzM/dxieehs9tEe9gD
         AqCKbLmSpvh9n+R0r2ES7pCHyWu2VC8egns1IF55zTLPFcUwGYRRMvij5PRVkuo7VUxL
         a+tzG7untXUtGDAxrICt3RyIDNsnMAoInBCFdFp9jP9QXbI6JVe+RwhJVvrex5vHVmZV
         jCTNOksRCO/BGijUm9mzjNWByziWBay9dJ8rDLGAq8y5STFdF9z46jRCbxST0WeYFEbV
         RamZBuUjAynpD1JBCuhiqMmmz9uRkdIsOIphKP9OP9JL4yg6hujcR6n773U3MbiMpCDt
         u88Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjfye9ZHk6kn9TPOVYYtmewQuowVzYD9B/1FHGPEdio42KhPF9gpWerhnj0k8yUstbopG4D6fLX0YunAVjMg3dHWCNfllVYWg4bfySCGQ25WB9YN3UPp251feP2lLF1miROe0gbw0iXlifvXafNdpcdBrTD8+3JEOb
X-Gm-Message-State: AOJu0YxZqgLviU3W/H6WHxNlLmUM+zMGdmGesYtUR2gaqtpMCm7gz4JE
	icS9zmxo+kyg9sJeHZESA6TuXDrQ1B4emHSTxuZcxpfvV7qT9PCr
X-Google-Smtp-Source: AGHT+IFSX4Q204TIKiPy9JBxeg7HqrlKpaAcPlTccwsvTwZ0lQyR9wwiSSD42wfWa0YTfhryqepqjQ==
X-Received: by 2002:a05:6512:2085:b0:516:d219:3779 with SMTP id 2adb3069b0e04-52b896cd558mr1497227e87.58.1717175633108;
        Fri, 31 May 2024 10:13:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d8e81asm380854e87.304.2024.05.31.10.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 10:13:52 -0700 (PDT)
Date: Fri, 31 May 2024 20:13:49 +0300
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
Message-ID: <x4snwm24lqebfcu3xqipwnxcexxbxhfijw7ldsukk23tn5k3rc@g3tfmynhvm26>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
 <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
 <ZlN4tkY8fNM8/D8p@shell.armlinux.org.uk>
 <ukszpirecb3pwnz5bbmy7wl44ujh6t2ewrnodmrye5kjmonsz2@pgf5b2oy5n3p>
 <ZlXmjKtKozXThPFv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlXmjKtKozXThPFv@shell.armlinux.org.uk>

On Tue, May 28, 2024 at 03:13:32PM +0100, Russell King (Oracle) wrote:
> On Tue, May 28, 2024 at 04:19:49PM +0300, Serge Semin wrote:
> > On Sun, May 26, 2024 at 07:00:22PM +0100, Russell King (Oracle) wrote:
> > > On Sun, May 26, 2024 at 05:49:48PM +0100, Russell King (Oracle) wrote:
> > > > On Sat, May 25, 2024 at 12:02:58AM +0300, Serge Semin wrote:
> > > > > The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
> > > > > into the DW GMAC controller. It's always done if the controller supports
> > > > > at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
> > > > > interfaces support was activated during the IP-core synthesize the PCS
> > > > > block won't be activated either and the HWFEATURE.PCSSEL flag won't be
> > > > > set. Based on that the RGMII in-band status detection procedure
> > > > > implemented in the driver hasn't been working for the devices with the
> > > > > RGMII interface support and with none of the SGMII, TBI, RTBI PHY
> > > > > interfaces available in the device.
> > > > > 
> > > > > Fix that just by dropping the dma_cap.pcs flag check from the conditional
> > > > > statement responsible for the In-band/PCS functionality activation. If the
> > > > > RGMII interface is supported by the device then the in-band link status
> > > > > detection will be also supported automatically (it's always embedded into
> > > > > the RGMII RTL code). If the SGMII interface is supported by the device
> > > > > then the PCS block will be supported too (it's unconditionally synthesized
> > > > > into the controller). The later is also correct for the TBI/RTBI PHY
> > > > > interfaces.
> > > > > 
> > > > > Note while at it drop the netdev_dbg() calls since at the moment of the
> > > > > stmmac_check_pcs_mode() invocation the network device isn't registered. So
> > > > > the debug prints will be for the unknown/NULL device.
> > > > 
> > > > Thanks. As this is a fix, shouldn't it be submitted for the net tree as
> > > > it seems to be fixing a bug in the driver as it stands today?
> > > > 
> > > > Also, a build fix is required here:
> > > > 
> > > > > -	if (priv->dma_cap.pcs) {
> > > > > -		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
> > > > > -		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
> > > > > -		    (interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
> > > > > -		    (interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
> > > > > -			netdev_dbg(priv->dev, "PCS RGMII support enabled\n");
> > > > > -			priv->hw->pcs = STMMAC_PCS_RGMII;
> > > > > -		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
> > > > > -			netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
> > > > > -			priv->hw->pcs = STMMAC_PCS_SGMII;
> > > > > -		}
> > > > > -	}
> > > > > +	if (phy_interface_mode_is_rgmii(interface))
> > > > > +		priv->hw.pcs = STMMAC_PCS_RGMII;
> > > > > +	else if (interface == PHY_INTERFACE_MODE_SGMII)
> > > > > +		priv->hw.pcs = STMMAC_PCS_SGMII;
> > > > 
> > > > Both of these assignments should be priv->hw->pcs not priv->hw.pcs.
> > > > 
> > > > I think there's also another bug that needs fixing along with this.
> > > > See stmmac_ethtool_set_link_ksettings(). Note that this denies the
> > > > ability to disable autoneg, which (a) doesn't make sense for RGMII
> > > > with an attached PHY, and (b) this code should be passing the
> > > > ethtool op to phylink for it to pass on to phylib so the PHY can
> > > > be appropriately configured for the users desired autoneg and
> > > > link mode settings.
> > > > 
> > > > I also don't think it makes any sense for the STMMAC_PCS_SGMII case
> > > > given that it means Cisco SGMII - which implies that there is also
> > > > a PHY (since Cisco SGMII with inband is designed to be coupled with
> > > > something that looks like a PHY to send the inband signalling
> > > > necessary to configure e.g. the SGMII link symbol replication.
> > > > 
> > > > In both of these cases, even if the user requests autoneg to be
> > > > disabled, that _shouldn't_ affect internal network driver links.
> > > > This ethtool op is about configuring the externally visible media
> > > > side of the network driver, not the internal links.
> > > 
> > 
> > > I have a concern about this patch. Have you considered dwmac-intel with
> > > its XPCS support, where the XPCS is used for Cisco SGMII and 1000base-X
> > > support. Does the dwmac-intel version of the core set
> > > priv->dma_cap.pcs? If it doesn't, then removing the test on this will
> > > cause a regression, since in Cisco SGMII mode, we end up setting
> > > priv->hw->pcs to SYMMAC_PCS_SGMII where we didn't before. As
> > > priv->flags will not have STMMAC_FLAG_HAS_INTEGRATED_PCS, this will
> > > enable all the "integrated PCS" code paths despite XPCS clearly
> > > intending to be used for Cisco SGMII.
> > > 
> > > I'm also wondering whether the same applies to the lynx PCS as well,
> > > or in the general case if we have any kind of external PCS.
> > > 
> > > Hence, I think this probably needs to be:
> > > 
> > > 	if (phy_interface_mode_is_rgmii(interface))
> > > 		priv->hw->pcs = STMMAC_PCS_RGMII;
> > > 	else if (interface == PHY_INTERFACE_MODE_SGMII && priv->dma_cap.pcs)
> > > 		priv->hw->pcs = STMMAC_PCS_SGMII;
> > > 
> > > At least this is what unpicking the awful stmmac code suggests (and I
> > > do feel that my point about the shocking state of this driver is proven
> > > as details like this are extremely difficult to unpick, and not
> > > unpicking them correctly will lead to regressions.) Therefore, I would
> > > suggest that it would be wise if you also double-checked this.
> > 
> > Double-checked that part. Indeed this is what I forgot to take into
> > account.
> 
> Thanks for double-checking it.
> 
> > (Just realized I had a glimpse thought about checking the DW
> > xGMAC/XPCS for supporting the SGMII interface, but the thought got
> > away from my mind forgotten.) DW XPCS can be synthesized with having
> > the GMII/MII interface connected to the MAC and SGMII downstream
> > interface over a single 1000Base-X lane.
> > 
> > In anyway AFAICS that case has nothing to do with the PCS embedded
> > into the DW GMAC or DW QoS Eth synthesized with the SGMII support. DW
> > XGMAC has no embedded PCS, but could be attached to the separate DW
> > XPCS device.
> 

> This is where my head starts spinning, because identifying what
> "DW GMAC" and "DW QoS Eth" refer to is difficult unless one, I guess,
> has the documentation.
> 
> The only references to QoS that I can find in the driver refer to
> per-DMA channel interrupts, dwmac5* and one mention for a platform
> driver in the Kconfig.
> 
> Grepping for "DW GMAC" doesn't give anything.
> 
> Conversely, I know from the code that only dwmac4 and dwmac1000
> have support for the integrated PCS. So trying to put this together
> doesn't make much sense to me. :/
> 
> Maybe "DW QoS Eth" refers to dwmac-dwc-qos-eth.c?

DW QoS Eth is the new generation of the Synopsys Gigabit Ethernet
IP-cores. Old ones are considered of version 3.74a and older:
https://www.synopsys.com/dw/ipdir.php?ds=dwc_ether_mac10_100_1000_unive
The new ones are of the version 4.0 and higher (the most modern
DW QoS Eth IP-core is of v5.40a):
https://www.synopsys.com/dw/ipdir.php?ds=dwc_ether_qos

This is better summarised in the driver doc:

Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst

which has outdated a bit, but the summary table looks correct anyway:

+-------------------------------+--------------+--------------+--------------+
| Controller Name               | Min. Version | Max. Version | Abbrev. Name |
+===============================+==============+==============+==============+
| Ethernet MAC Universal        | N/A          | 3.73a        | GMAC         |
+-------------------------------+--------------+--------------+--------------+
| Ethernet Quality-of-Service   | 4.00a        | N/A          | GMAC4+       |
+-------------------------------+--------------+--------------+--------------+
| XGMAC - 10G Ethernet MAC      | 2.10a        | N/A          | XGMAC2+      |
+-------------------------------+--------------+--------------+--------------+
| XLGMAC - 100G Ethernet MAC    | 2.00a        | N/A          | XLGMAC2+     |
+-------------------------------+--------------+--------------+--------------+

See the abbreviation and controller names. When I say just DW GMAC
then it means DW Ether MAC 10/100/1000 Universal, which driver is
implemented in the dwmac1000* files. If you see DW GMAC4/GMAC5 or DW
GAC4+ or DW QoE Eth, then it means DW Ethernet Quality-of-Service
IP-core, which driver could be found in dwmac4*/dwmac5* files.

As it inferable from the IP-core names the main difference between DW
Ether MAC 10/100/1000 Universal and DW Ethernet Quality-of-Service is
that the later one supports multiple queues and channels with a
comprehensive list of the optional traffic scheduling features (FPE,
TBS, DCB, AV-bridging, etc). DW GMAC doesn't have as many such
features. The only way to have DW GMAC synthesized with the multiple
DMA channels support is to enable a singly available traffic
scheduling feature - AV-bridging. Note AV-bridging enabled on the DW
GMAC v3.73a is the case of the Loongson GNET controller, which support
is implemented in the Yanteng Si patchset recently submitted for v13
review:
https://lore.kernel.org/netdev/cover.1716973237.git.siyanteng@loongson.cn/

In some extent the CSRs mapping is also different in DW GMAC v3.x and
GMAC v4.x/v5.x, but the main part is in the QoS features.

> 
> > About the correct implementation. Right, priv->dma_cap.pcs indicates
> > that there is an embedded PCS and the flag can be set for DW GMAC or DW
> > QoS Eth only. Although I would change the order:
> > 
> >        if (phy_interface_mode_is_rgmii(interface))
> >                priv->hw->pcs = STMMAC_PCS_RGMII;
> >        else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
> >                priv->hw->pcs = STMMAC_PCS_SGMII;
> > 
> > since priv->dma_cap.pcs is a primary flag. If it isn't set the
> > interface will be irrelevant.
> 

> As this is generic code, it probably makes sense to go with that, since
> priv->dma_cap.pcs indicates whether the internal PCS for SGMII is
> present or not rather than...

Right.

> 
> > Alternative solution could be to use the has_gmac/has_gmac4 flags
> > instead. That will emphasize that the embedded PCS is expected to be
> > specific for the DW GMAC and DW QoS Eth IP-cores:
> > 
> >        if (phy_interface_mode_is_rgmii(interface))
> >                priv->hw->pcs = STMMAC_PCS_RGMII;
> >        else if ((priv->plat.has_gmac || priv->plat.has_gmac4) &&
> > 		interface == PHY_INTERFACE_MODE_SGMII)
> >                priv->hw->pcs = STMMAC_PCS_SGMII;
> 

> which implies that gmac (dwgmac1000_core.c) and gmac4 (dwgmac4_core.c)
> will always have its internal PCS if we're using SGMII mode.

Right. If the DW GMAC/QoS Eth IP-core is synthesized with the
SGMII/RTBI/RBI PHY interface then the internal PCS will always be
available and the HWFEATURE.PCSSEL flag will be set. Here is the
PCSSEL flag value definition:
DW QoS Eth: DWC_EQOS_PCS_EN = DWC_EQOS_TBI_EN || DWC_EQOS_SGMII_EN || DWC_EQOS_RTBI_EN
DW GMAC: if TBI, SGMII, or RTBI PHY interface is enabled.

> Does this
> mean it is true that these cores will never be used with an external
> PCS?

Sorry, I was wrong to suggest the (priv->plat.has_gmac ||
priv->plat.has_gmac4)-based statement. Indeed there is a case of having DW
QoS Eth and DW XPCS synthesized together with the SGMII/1000Base-X
downstream interface. Not sure why it was needed to implement that way
seeing DW QoS Eth IP-core supports optional SGMII PHY interface out of
box, but AFAICS Intel mGBE is that case. Anyway the correct way to
detect the internal PCS support is to check the PCSSEL flag set in the
HWFEATURE register (preserved in the stmmac_priv::dma_cap::pcs field).

> 
> If there is a hardware flag that indicates the PCS is implemented, then
> I think using that to gate whether SGMII uses the internal PCS is
> better rather than using the core type.

Right.

> 
> Please can you confirm that if an external PCS (e.g. xpcs, lynx PCS)
> is being used, the internal PCS will not have been synthesized, and
> thus priv->dma_cap.pcs will be false?

Alas I can't confirm that. priv->dma_cap.pcs only indicates the
internal PCS availability. External PCS is an independent entity from
the DW *MAC IP-core point of view. So the DW GMAC/QoS Eth/XGMAC
controllers aren't aware of its existence. It's the low-level platform
driver/code responsibility to somehow detect it being available
("pcs-handle" property, plat->mdio_bus_data->has_xpcs flag, etc).

Regarding the internal PCS, as long as the DW GMAC or DW QoS Eth is
synthesized with the SGMII/TBI/RTBI PHY interface support
priv->dma_cap.pcs will get to be true. Note the device can be
synthesized with several PHY interfaces supported. As long as
SGMII/TBI/RTBI PHY interface is any of them, the flag will be set
irrespective from the PHY interface activated at runtime. 

> The reason I'd like to know
> this is because in the future, I'd like to eliminate priv->hw->pcs,
> and just have dwmac1000/dwmac4's phylink_select_pcs() method make
> the decisions.

You can extend the priv->dma_cap.pcs flag semantics. So it could
be indicating three types of the PCS'es:
RGMII, SGMII, XPCS (or TBI/RTBI in future).

> 
> If not, then we need to think about the behaviour that
> stmmac_mac_select_pcs(0 should have. Should it give priority to the
> internal PCS over external PCS, or external PCS first (in which case
> what do we need to do with the internal PCS.)

I guess the DW XPCS implementation might be more preferable. From one
side DW XPCS SGMII can support up to 2.5Gbps speed, while the DW
GMAC/QoS Eth SGMII can work with up to 1Gbps speed only. On the other
hand the DW XPCS might be available over the MDIO-bus, which is slower
to access than the internal PCS CSRs available in the DW GMAC/QoS Eth
CSRs space. So the more performant link speed seems more useful
feature over the faster device setup process.

One thing I am not sure about is that there is a real case of having
the DW GMAC/QoS Eth synthesized with the native SGMII/TBI/RTBI PHY
interface support and being attached to the DW XPCS controller, which
would have the SGMII downstream PHY interface. DW XPCS has only the
XGMII or GMII/MII upstream interfaces over which the MAC can be
attached. So DW GMAC/QoS Eth and DW XPCS can be connected via the
GMII/MII interface only. Regarding Intel mGBE, it likely is having a
setup like this:

+------------+          +---------+
|            | GMII/MII |         |   SGMII
| DW QoS Eth +----------+ DW XPCS +------------
|            |          |         | 1000Base-X
+------------+          +---------+

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

