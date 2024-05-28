Return-Path: <bpf+bounces-30753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224678D2187
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 18:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80484B23C35
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8F5172BDF;
	Tue, 28 May 2024 16:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nugviDo9"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7B172BD4;
	Tue, 28 May 2024 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913335; cv=none; b=vGtOcZJQrNtHbNxGJuPCg+dLbCU1XyVfnwNwoKSCl+g9fCXdlsVGVKCPJ43r68Z8Qv8a6E7kz5io1eF72qkP0bltuym06fD7NuRN6zarat3Tu2rr2hPikhT4i8c+1d7Sgr09lvnHc3zAF4nlOssSlILrkDAEKdlR9421O+Y89oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913335; c=relaxed/simple;
	bh=+Dv/OIUVwB/bLWKYOvm39+kQn98xTFQfu4ccBNpVHB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPvU1u0ACdy4wW8idynl2UqMHAxarEAA2OB6psnPe+DWJ3e4Wd6HGXhtxXFLrEgiXEhT6GzAZt5Ay7jLev/sWQh4Iy8VcpCjGoUwXbgH9RlXKOVH6n5x4sXaLnkLE97zmmr+oXJ+4bcxspmKOy4xTg/lth7g+t4GSURTJU6Z6h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nugviDo9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y+I/pgBvEsE6M3d+cAiMF6HJdA+pDzVg8kUJyR05hAA=; b=nugviDo9mQBrs8VDAnUwlAFfJe
	j5G3o0pc4JLuHIPG51eayzgNKYQ6b7lFeR3UJmXD6eprTJDhbH6wR9ChAmK2yqDq0p6MsCec7vQWn
	5vLoiGeMjUEOj7t8/LSmvRbfoClQxXoPvAyhHn/6zKIbYFhY3hnin7HaP+NK6s+NjkRTEBDX5vUr+
	N8qM1B+zP9nVvLble8kgOQvX1iPz+Yg8nWWGEgHcW/OqzFyUeJyQKAb4N1s0HNcyiEKLOq2DBn9zz
	skJ6Wiu0nHmxNEQ4iqchxkAzsojKWE4aWTPJ3scbvrAGbFzYD5M61dLyYCbMGyBmkwTmxyGhctr+3
	KwUARNag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55592)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBza6-00054s-0o;
	Tue, 28 May 2024 17:21:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBza4-0003O8-Br; Tue, 28 May 2024 17:21:44 +0100
Date: Tue, 28 May 2024 17:21:44 +0100
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
Message-ID: <ZlYEmBSw3bNtf7tJ@shell.armlinux.org.uk>
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
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 28, 2024 at 03:13:32PM +0100, Russell King (Oracle) wrote:
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
> will always have its internal PCS if we're using SGMII mode. Does this
> mean it is true that these cores will never be used with an external
> PCS?

Sorry to go off on a related tangent, but I've just been looking at
hw->ps which is related to this.

As I understand, hw->ps comes from the "snps,ps-speed" property in DT,
which is used for SGMII and MAC2MAC connections. Presumably for the
SGMII case, this is used where the port is made to look like the PHY
end of the SGMII link.

I'm guessing MAC2MAC refers to RGMII, or does that also refer to
SGMII-as-PHY?

I think it would've been nice to have picked SGMII-as-PHY up in the
driver earlier - we don't tend to use the "normal" PHY interface
mode names, instead we have the REVxxx modes, so I think this
_should_ have introduced PHY_INTERFACE_MODE_REVSGMII.

In any case, moving on... in stmmac_hw_setup(), we have:

        /* PS and related bits will be programmed according to the speed */
        if (priv->hw->pcs) {
                int speed = priv->plat->mac_port_sel_speed;

                if ((speed == SPEED_10) || (speed == SPEED_100) ||
                    (speed == SPEED_1000)) {
                        priv->hw->ps = speed;
                } else {
                        dev_warn(priv->device, "invalid port speed\n");
                        priv->hw->ps = 0;
                }
        }

Which means that if we're using the integrated PCS, then we basically
require the "snps,ps-speed" property otherwise we'll issue a warning
at this point... this seems to imply that reverse mode is the only
mode supported, which I'm fairly sure is false. So, maybe this
shouldn't be issuing the warning if mac_port_sel_speed was zero?

Moving on... hw->ps can only be 10M, 100M or 1G speeds and nothing else
- which is fine since RGMII and Cisco SGMII only support these speeds.

dwmac1000 tests for this against these speeds, so it is also fine.

dwmac4 is basically the same as dwmac1000, so is also fine.

The core code as it stands today passes this into the pcs_ctrl_ane
method's rsgmi_ral argument, which sets GMAC_AN_CTRL_SGMRAL. Presumably
this selects "reverse" mode for both SGMII and RGMII?

Persuing this a bit futher, qcom-ethqos always calls this with rsgmi_ral
clear. Presumably, qcom-ethqos never specifies "snps,ps-speed" in DT,
and thus always gets the warning above?

Finally, we get to the core issue, which is dwxgmac2_core.c.
dwxgmac2 tests this member against 10G, 2.5G and "any other non-zero
value". Out of all of these, the only possible path through that code
would be the one which results in:

	tx |= hw->link.speed1000;

Neither of the other two (2.5G and 10G) are possible because those
aren't legal values for hw->ps. Moreover, it doesn't appear to have
any kind of PCS, so I'm wondering whether any of this code gets used.


So, I suspect some of this is "not quite right" either, and I wonder
about the implications of changing how hw->pcs is set - whether we
first need to fix the code above dealing with priv->hw->ps ?

I'm also wondering what impact this has on my PCS conversion.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

