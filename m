Return-Path: <bpf+bounces-36312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CE59463D7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D589B1F217C7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0106166F37;
	Fri,  2 Aug 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V5bTjSRz"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D676166F22;
	Fri,  2 Aug 2024 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626583; cv=none; b=RYiUkIClpkrmUop94Jek57J73Z/EPXwgRj54yyn9n2IFdFRRxezvSnBnIkeKfqdGHId4PDdTMEOO24G5n4FQ287dNn/rRb6PnxDlAdbM5MickCq0qM1POor7uKADafqTxv8cx3xVTNzC9AiIEvzECdjIrCN9HrOem7ymXx5TFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626583; c=relaxed/simple;
	bh=Rs5mDBJ57qvWlyT29WCL7n58Pir93sTQtF59nUjTzLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epH+x4zN3YsgVSWhWgf7XZOrMuWw2my4+4FjC8zUkAcQGz7+0IHXKDFTzftMsNN0tKdyuC/mFK8IIoo5hB3F/B4oO+J8+TpfJ7GfImTUDVXpBQn1X48HOta+OiouBdFKNUNtYH9tSycm7MZf9Hav52E49ZHCP7xwijnGqLWnUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V5bTjSRz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4bmxVMwcC7El7dkuub8GoTScaOOhQldmD5XLu9UZMmo=; b=V5bTjSRzYRz9FuEfIMzCZKHn/i
	QfusxZXY+z2IYAkons/wyW9sPeUz/VNX61lejxEflqnirN9QF/XFyp2xXAqLaKdmPe9sIN4IeLBDP
	xUjpE1Moc65cC1Myz2zs9cySn5ncCT1lkGMifudtfB8+DymqZs5w+Pw54MKAYRXCnvTwev5kvye4j
	6qPCubd0uVB0uFEXHKI8KV4cCxrL+RSOaz17W0B8cfd0n4pmqE26Sl4e3KwgsEXON08Qjxo6a/7Sf
	EV+XmU7MojDFm3jWoqoQLDxKMgRkOYoTMrhZQyQU6u0x56aZAT9a+NnRWn5s9v6+MciqlIofoeOJ+
	XIlPDlaw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53074)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZxrN-0007Xh-0r;
	Fri, 02 Aug 2024 20:22:41 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZxrP-0008GY-2W; Fri, 02 Aug 2024 20:22:43 +0100
Date: Fri, 2 Aug 2024 20:22:42 +0100
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
Subject: Re: [PATCH net-next 13/14] net: stmmac: remove obsolete pcs methods
 and associated code
Message-ID: <Zq0yAjzrpIEhcHBZ@shell.armlinux.org.uk>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpoq-000eHy-GR@rmk-PC.armlinux.org.uk>
 <ij562xfhvgxmvpgh2l6rhsvcpi43yvvkvef4wgpjupwusi6uwy@cpnkopeu7cpc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ij562xfhvgxmvpgh2l6rhsvcpi43yvvkvef4wgpjupwusi6uwy@cpnkopeu7cpc>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 02, 2024 at 02:02:25PM -0500, Andrew Halaney wrote:
> On Fri, Aug 02, 2024 at 11:47:32AM GMT, Russell King (Oracle) wrote:
> > The pcs_ctrl_ane() method is no longer required as this will be handled
> > by the mac_pcs phylink_pcs instance. Remove these methods, their common
> > implementation, the pcs_link, pcs_duplex and pcs_speed members of
> > struct stmmac_extra_stats, and stmmac_has_mac_phylink_select_pcs().
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > index 3c8ae3753205..799af80024d2 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > @@ -321,48 +321,6 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
> >  {
> >  	struct stmmac_priv *priv = netdev_priv(dev);
> >  
> > -	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
> 
> This change effectively makes the INTEGRATED_PCS flag useless, I think
> we should remove it entirely.

I'm hoping the ethqos folk are going to test this patch series and tell
me whether it works for them - specifically Sneh Shah who added

	net: stmmac: dwmac-qcom-ethqos: Add support for 2.5G SGMII

which directly configures the PCS bypassing phylink. Specifically,
if this in stmmac_check_pcs_mode():

	priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII

is true for this device, then we may be in for problems. Since
priv->dma_cap.pcs comes from hardware, it's impossible to tell
unless one has that hardware.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

