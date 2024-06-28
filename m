Return-Path: <bpf+bounces-33360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2281B91C129
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC50B24F67
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2DF1C2302;
	Fri, 28 Jun 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Cqv4ThO5"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB501C0059;
	Fri, 28 Jun 2024 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585411; cv=none; b=lpJHI3tN4ru0jwFMivFRM6Z9iiVeByqZahUeA+296gU2/yPo87eiGti4aj8DS423n0K81Nyy7IsgTjPT6rqEsg2t+F4N8rbWkMuTZBH1C+ygpdc3ma7mo2qfvhRb/W4Q1Q9gbxvxBqmCIVCwDHeJMcw0svRDGttaQaYLwhlAClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585411; c=relaxed/simple;
	bh=JiZfq3gwz1YV7mDlLny5qXHSDcF//x9Y1YtC1MMYgLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bx/g81DwUk/vm17679BRUC2S1tnPK6Ifdmo7T0aF4Cdcd6qM4En28DGQpn4sflHA51eG4Rgj1xoSDzOwj26GF6hcvK3NfZHUXmG+G2WzjGqJibvte2lXjhegJn5gnT7F93Fw2q0fFu36FkWIhG2nUwUHQmRF9BFffiFRCKBHRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Cqv4ThO5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dn8dd9XofEX3Uhxe0baYs+HlRiMw0xmll7rakGvzy50=; b=Cqv4ThO5K430oyZ2P6/0xKye2t
	dcVwpn/gglUa0CJqhAN+opJSD6fX3NJv+GbcL5k/c4EwzwND43nPnDy+bpoIqtGo+vLKI2FOubIqs
	Fvk74xjycJ9/p6rbCTdrQngllERV7m92ztiQsm0d5x2t2e3LC6gMsCLiGO/ckIZnQ2AprJa5/Ve1x
	7nVuXuVCk1Eck2s+1es8VUVhYFZ/5YC8VxXfqplKesv5yRcQRzKkv9urI632OyjgKKQdtyERinlCZ
	hOSoxViS6lcjxxxu6qSstM5r1CijGBQv3xhaYtMKdyTxvuyOVdXATGeQwcfbbru1AsdTgVxxnG0YD
	DgriEQQw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57500)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sNCi4-0006kX-1r;
	Fri, 28 Jun 2024 15:36:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sNCi4-0006Zb-BR; Fri, 28 Jun 2024 15:36:20 +0100
Date: Fri, 28 Jun 2024 15:36:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 16/17] net: stmmac: Move internal PCS
 init method to stmmac_pcs.c
Message-ID: <Zn7KZG+KDU01APar@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-8-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624132802.14238-8-fancer.lancer@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 24, 2024 at 04:26:33PM +0300, Serge Semin wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 72c2d3e2c121..743d356f6d12 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -950,13 +950,16 @@ static struct phylink_pcs *stmmac_mac_select_pcs(struct phylink_config *config,
>  {
>  	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
>  
> +	if (priv->hw->pcs)
> +		return &priv->hw->mac_pcs;
> +
>  	if (priv->hw->xpcs)
>  		return &priv->hw->xpcs->pcs;
>  
>  	if (priv->hw->phylink_pcs)
>  		return priv->hw->phylink_pcs;
>  
> -	return stmmac_mac_phylink_select_pcs(priv, interface);
> +	return NULL;

I really really don't like this due to:

1. I spent a long time working out what the priority here should be, and
you've just thrown all that work away by changing it - to something that
I believe is incorrect.

2. I want to eventually see this function checking the interface type
before just handing out a random PCS, and it was my intention to
eventually that into the MACs own select_pcs() methods. Getting rid of
those methods means that the MACs themselves now can't make the
decision which is where that should be.

3. When operating in RGMII "inband" mode, the .pcs_config etc doesn't
make much sense (we're probably accessing registers that don't exist)
and I had plans to split this into a RGMII "PCS" which was just a PCS
that implemented .pcs_get_state(), a stub .pcs_config(), and a separate
fully-featured "SGMII PCS".

So, I would like to eventually see here something like:

	if (priv->hw->xpcs)
		return &priv->hw->xpcs->pcs;

	if (priv->hw->phylink_pcs)
		return priv->hw->phylink_pcs;

	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS)) {
		if (phy_interface_mode_is_rgmii(priv->plat->mac_interface))
			return &priv->hw->mac_rgmii_pcs;

		if (priv->dma_cap.pcs &&
		    priv->plat->mac_interface == PHY_INTERFACE_MODE_SGMII)
			return &priv->hw->mac_sgmii_pcs;
	}

	return NULL;

> +void dwmac_pcs_init(struct mac_device_info *hw)
> +{
> +	struct stmmac_priv *priv = hw->priv;
> +	int interface = priv->plat->mac_interface;
> +
> +	if (priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS)
> +		return;
> +	else if (phy_interface_mode_is_rgmii(interface))
> +		hw->pcs = STMMAC_PCS_RGMII;
> +	else if (priv->dma_cap.pcs && interface == PHY_INTERFACE_MODE_SGMII)
> +		hw->pcs = STMMAC_PCS_SGMII;
> +
> +	hw->mac_pcs.neg_mode = true;
> +}

Please move "hw->mac_pcs.neg_mode = true;" to where the PCS method
functions are implemented - it determines whether the PCS method
functions take the AN mode or the neg mode, and this is a property of
their implementations. It should not be split away from them.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

