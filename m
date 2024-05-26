Return-Path: <bpf+bounces-30614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE9A8CF4EA
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A3A1C20B02
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743D11B95E;
	Sun, 26 May 2024 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="w2wVi6XE"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B931168B9;
	Sun, 26 May 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716742214; cv=none; b=orHU5NAg/rI45/tFhaeuZsH2zqcakFCK2ytI5MRb50SJxzmf3vK/mDU5BPNaNSDA3K3XnK1jCJ+2/+fhyn4MjWtgnifb74AZT/TsahwBP6iS20Fj2soj6h+g//ixYZB1jKp9QynsQKwppMjRRduXkwJpDRkcof9vcFVHpsuUNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716742214; c=relaxed/simple;
	bh=ETjA3dGIbrqGmMPuDEM7g9G8PK00mOnqw3j6bdPx5Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGbcOHKqyzwjT4u16cWrndqwKPYvwx14Eftl3Gyr5rFTi836pUXYzDK12qBj9txExPngQKo6x3/gtaAtnNc3TqIGQ7dcbdAPuMis7OVA8P4g1XqHU6gpCvtrkRBDi4SyCmzyo1IwUZQ267zAEL9gNU+itLuPofJUbtAU5ZkpgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=w2wVi6XE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Se3l6VfrArDiw2sv7ishS59ORjDk+6CLWOFsd5rBSlk=; b=w2wVi6XEWBHXj27s1jxicTfKm7
	EyjyocygWLXY7RgaPeE84Eo0aLHKkIFEEk1p05hwhlc4WsoBTZ4bLyUjQku7N/VqqwpB6pdlJp65T
	Q0YqBcLapNOFqn7YaizyhRkoK63NxKl9Q4Du/3tVlDYYWr4il7fbD1FHeBnKNu8AmbVKmJTB6geF2
	AOtHE/AejxFoXoRA6fQ8R8Drtjbob8M8UKUrR9PFJd45aWnv9S5DqRcumz1vGu/UZzzSJwEfyo/4S
	JC3lAFUb0byd7XTZnEsWoXXYyFziyZmWPkYy8Y7jm4GypTINxQNi9Px/0hkJ87R+JcRbab57XP2Jo
	EC9xRU8g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49196)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBH4A-0002pc-2v;
	Sun, 26 May 2024 17:49:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBH48-0001Wp-8T; Sun, 26 May 2024 17:49:48 +0100
Date: Sun, 26 May 2024 17:49:48 +0100
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
Message-ID: <ZlNoLHoHjt3BsFde@shell.armlinux.org.uk>
References: <ZkDuJAx7atDXjf5m@shell.armlinux.org.uk>
 <20240524210304.9164-1-fancer.lancer@gmail.com>
 <20240524210304.9164-2-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524210304.9164-2-fancer.lancer@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, May 25, 2024 at 12:02:58AM +0300, Serge Semin wrote:
> The HWFEATURE.PCSSEL flag is set if the PCS block has been synthesized
> into the DW GMAC controller. It's always done if the controller supports
> at least one of the SGMII, TBI, RTBI PHY interfaces. If none of these
> interfaces support was activated during the IP-core synthesize the PCS
> block won't be activated either and the HWFEATURE.PCSSEL flag won't be
> set. Based on that the RGMII in-band status detection procedure
> implemented in the driver hasn't been working for the devices with the
> RGMII interface support and with none of the SGMII, TBI, RTBI PHY
> interfaces available in the device.
> 
> Fix that just by dropping the dma_cap.pcs flag check from the conditional
> statement responsible for the In-band/PCS functionality activation. If the
> RGMII interface is supported by the device then the in-band link status
> detection will be also supported automatically (it's always embedded into
> the RGMII RTL code). If the SGMII interface is supported by the device
> then the PCS block will be supported too (it's unconditionally synthesized
> into the controller). The later is also correct for the TBI/RTBI PHY
> interfaces.
> 
> Note while at it drop the netdev_dbg() calls since at the moment of the
> stmmac_check_pcs_mode() invocation the network device isn't registered. So
> the debug prints will be for the unknown/NULL device.

Thanks. As this is a fix, shouldn't it be submitted for the net tree as
it seems to be fixing a bug in the driver as it stands today?

Also, a build fix is required here:

> -	if (priv->dma_cap.pcs) {
> -		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
> -		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
> -		    (interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
> -		    (interface == PHY_INTERFACE_MODE_RGMII_TXID)) {
> -			netdev_dbg(priv->dev, "PCS RGMII support enabled\n");
> -			priv->hw->pcs = STMMAC_PCS_RGMII;
> -		} else if (interface == PHY_INTERFACE_MODE_SGMII) {
> -			netdev_dbg(priv->dev, "PCS SGMII support enabled\n");
> -			priv->hw->pcs = STMMAC_PCS_SGMII;
> -		}
> -	}
> +	if (phy_interface_mode_is_rgmii(interface))
> +		priv->hw.pcs = STMMAC_PCS_RGMII;
> +	else if (interface == PHY_INTERFACE_MODE_SGMII)
> +		priv->hw.pcs = STMMAC_PCS_SGMII;

Both of these assignments should be priv->hw->pcs not priv->hw.pcs.

I think there's also another bug that needs fixing along with this.
See stmmac_ethtool_set_link_ksettings(). Note that this denies the
ability to disable autoneg, which (a) doesn't make sense for RGMII
with an attached PHY, and (b) this code should be passing the
ethtool op to phylink for it to pass on to phylib so the PHY can
be appropriately configured for the users desired autoneg and
link mode settings.

I also don't think it makes any sense for the STMMAC_PCS_SGMII case
given that it means Cisco SGMII - which implies that there is also
a PHY (since Cisco SGMII with inband is designed to be coupled with
something that looks like a PHY to send the inband signalling
necessary to configure e.g. the SGMII link symbol replication.

In both of these cases, even if the user requests autoneg to be
disabled, that _shouldn't_ affect internal network driver links.
This ethtool op is about configuring the externally visible media
side of the network driver, not the internal links.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

