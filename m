Return-Path: <bpf+bounces-36314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF82D9463ED
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D22D1C21970
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 19:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B65E49647;
	Fri,  2 Aug 2024 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="emIzjfgP"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5794437F;
	Fri,  2 Aug 2024 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627085; cv=none; b=fNWh+lQrRhRZniuxefJlKJ2As4g2iOGXe7ZMV7C/WpzGtpMIntaCoEcGsI4AEzEGHPdLt4M0lhXtHfturK+Opf/feGoI6ypA3Ro3fr8InAIUBXln+VuDZFLLN8Cigzc0wdJ06KsJ57fcxOTH+InMT1aFP85UDUgqiZwN15ILiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627085; c=relaxed/simple;
	bh=Y0YuSEAoLEiTFCPeX4MIMP0hiAGI5bqdI1DTWsA0t5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFCkWMFHmh+xDchpmQqs3Ez+tT7q4tDBoTr0y7IGdVEDQy5MoEJ7KuWo/tEevcS8+oCfIjsI8XTroOjxScWyhSjzof2tGfz28D5oiABomioN6s6/juOdSg0STHEuAseIO/PS31IqUpS68MU3KLjCCF2Fqhgg9nzBgmh8aEirIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=emIzjfgP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L8yGVigUwxCpMZ3AuN24rxXST45mTmYKN/sz00lc3v4=; b=emIzjfgPLi8S+NGYphJZGB/JFk
	T65EZI6VANfu1dvTbaXE3J/H/2Pn51hcLESCg732O2vQiZ+9E/yuKCsfnGd9u308vuCdpUIZzWgP/
	/9UBqrHtRqdN2gQhfBMb2hAeTpnUso7NtTDV0js4if4hU7L0a3spQM6pW7o66KsqyTh45nXdqaAmr
	FMcfFkvfct0xS8QlQBq7fIPUkW+DtbCSnPKQxgnd9MgrP36hX4AgY4gsTTBgDizQAKMzg4qdGHvST
	4NZLfWklPibYAvebMOAvQTWcq3uTOSDNsKL1mbPZk5WoeHTfjcZolia2ibZNtMY8o9GLxixAWNcDX
	Nelo5iIQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43218)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZxzb-0007Zb-18;
	Fri, 02 Aug 2024 20:31:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZxze-0008Go-Bm; Fri, 02 Aug 2024 20:31:14 +0100
Date: Fri, 2 Aug 2024 20:31:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 14/14] net: stmmac: Activate Inband/PCS flag
 based on the selected iface
Message-ID: <Zq00Ai0HFqP4yPRD@shell.armlinux.org.uk>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpov-000eI5-KP@rmk-PC.armlinux.org.uk>
 <yma4bknen5jc6om56eorr44uuoqtziqvk4phds6cpkrubrs5dy@esxfxtz22egh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yma4bknen5jc6om56eorr44uuoqtziqvk4phds6cpkrubrs5dy@esxfxtz22egh>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 02, 2024 at 02:12:08PM -0500, Andrew Halaney wrote:
> On Fri, Aug 02, 2024 at 11:47:37AM GMT, Russell King wrote:
> > From: Serge Semin <fancer.lancer@gmail.com>
> > 
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
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > [rmk: fix build errors, only use PCS for SGMII if priv->dma_cap.pcs is set]
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Russell, did you add in the priv->dma_cap.pcs check with SGMII just
> because it *is* expected to be set unconditionally when SGMII support is
> there?
> 
> Always fan of less conditionals, so just curious as to your motivation
> since Serge's message makes it seem like SGMII && dma_cap.pcs is a
> redundant check.

I don't think that is correct. As I understand it from several
exchanges with Serge, priv->dma_cap.pcs indicates whether or not the
PCS hardware is present in the instantiated hardware. The PCS hardware
is specific to SGMII, TBI, RTBI but *not* RGMII, so testing
priv->dma_cap.pcs in conjunction with RGMII has been wrong for quite
some time.

We have dropped TBI and RTBI support, so those aren't relevant anymore.

For SGMII, however, stmmac also supports XPCS, and XPCS supports SGMII.
So, one can have the situation where XPCS support is present, the
stmmac PCS is not present, and SGMII mode has been set.

In that case, we must not set priv->hw->pcs to STMMAC_PCS_SGMII even
if we are in SGMII mode, but priv->dma_cap.pcs indicates that the PCS
hardware is not present.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

