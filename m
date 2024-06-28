Return-Path: <bpf+bounces-33365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DF691C218
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B15283623
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 15:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DAE1C232B;
	Fri, 28 Jun 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="grvZHTLM"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23715884B;
	Fri, 28 Jun 2024 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587288; cv=none; b=PFO4cxQka4sQMLMjCnjHIFQIRexN2y0ugs1hnScC1txhU3lEdRQkWsZ6tUrhY026FzoxJYK0jelZ0tJ/0Qxn+W4/o+/vrsMHtqo10EAqgt4+lwYvF954721+1SEVIh5eqY1WtJ/U40Pxz6sd+VIOEh6yzKfWB81TRYY8dxb7Pek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587288; c=relaxed/simple;
	bh=1hgI+rCZQWIqOF+m5AgAV+Lg3Mb2So8JWjgU+Urw7PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYSV3FL+afKoTgFc7Q5KDwt1uNEQuyHQFCERIeLSQE1Rmts2Rl5SBE9kOudXlJAj/nqcM9Rk2Z+O3JF0/CuOhCZBjsqX1v3TAZoRHZd4ELbjXHPJzL4nkrAd6FZBbwS0lJGGRZ8yuy1s5wJy6b9Vj+uQejNK+AtfIgxdeYjI3TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=grvZHTLM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YKeNupwsPSrvE04qYcLHS5Qf0hnRaatid61rEYfWQaA=; b=grvZHTLMNbz8IGpB8IsDq8tVaB
	O8Kdrj1Wm5knEHgfNK5PVm7zmHg5aOBb0W2yALLnd9JAxHZPlVV7+SWSG7goEQeSLhA8eCZ6PluMG
	p+pgQxnqsxpUITKYfbPoZYOXhddo1ADVfTU+tHn2B939ipP/pM1cM7dX5/SdhBIKJnPVLg1EmDgAh
	OKJumBhYWd2F94Veoeyfo2mWJDTJ9nXeyL7OUm69tRKjXtTBGAgbPzaIZKO6TuWsYTBHhq/nAerhD
	qM4VHUw6Ex4bmKX4n29ir43HdS8MGMOKFsyRxTCY37pVyD6NEd1f91hGv4gLQiISeZo7Zx2zT3JGd
	wIoqSNfw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sNDCT-0006oN-1m;
	Fri, 28 Jun 2024 16:07:45 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sNDCV-0006as-1Z; Fri, 28 Jun 2024 16:07:47 +0100
Date: Fri, 28 Jun 2024 16:07:46 +0100
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
Subject: Re: [PATCH RFC net-next v2 14/17] net: stmmac: Move internal PCS
 PHYLINK ops to stmmac_pcs.c
Message-ID: <Zn7Rwt9KNac2mMah@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-6-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624132802.14238-6-fancer.lancer@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 24, 2024 at 04:26:31PM +0300, Serge Semin wrote:
> @@ -621,7 +548,6 @@ int dwmac1000_setup(struct stmmac_priv *priv)
>  	mac->mii.clk_csr_shift = 2;
>  	mac->mii.clk_csr_mask = GENMASK(5, 2);
>  
> -	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
>  	mac->mac_pcs.neg_mode = true;

"mac->mac_pcs.neg_mode = true;" is a property of the "ops" so should
move with it.

> @@ -1475,7 +1396,6 @@ int dwmac4_setup(struct stmmac_priv *priv)
>  	mac->mii.clk_csr_mask = GENMASK(11, 8);
>  	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
>  
> -	mac->mac_pcs.ops = &dwmac4_mii_pcs_ops;
>  	mac->mac_pcs.neg_mode = true;

Also applies here.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> index 3666893acb69..c42fb2437948 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> @@ -363,6 +363,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
>  		mac->tc = mac->tc ? : entry->tc;
>  		mac->mmc = mac->mmc ? : entry->mmc;
>  		mac->est = mac->est ? : entry->est;
> +		mac->mac_pcs.ops = mac->mac_pcs.ops ?: entry->pcs;

Removing both of the above means that mac->mac_pcs.ops won't ever be set
prior to this, so this whole thing should just be:

		mac->mac_pcs.ops = entry->pcs;
		mac->mac_pcs.neg_mode = true;

> +static void dwmac_pcs_get_state(struct phylink_pcs *pcs,
> +				struct phylink_link_state *state)
>  {
> +	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
>  	struct stmmac_priv *priv = hw->priv;
>  	u32 val;
>  
> +	val = stmmac_pcs_get_config_reg(priv, hw);
> +
> +	/* TODO The next is SGMII/RGMII/SMII-specific */
> +	state->link = !!(val & PCS_CFG_LNKSTS);
> +	if (!state->link)
> +		return;
> +
> +	switch (FIELD_GET(PCS_CFG_LNKSPEED, val)) {
> +	case PCS_CFG_LNKSPEED_2_5:
> +		state->speed = SPEED_10;
> +		break;
> +	case PCS_CFG_LNKSPEED_25:
> +		state->speed = SPEED_100;
> +		break;
> +	case PCS_CFG_LNKSPEED_250:
> +		state->speed = SPEED_1000;
> +		break;
> +	default:
> +		netdev_err(priv->dev, "Unknown speed detected\n");
> +		break;
> +	}
> +
> +	state->duplex = val & PCS_CFG_LNKMOD ? DUPLEX_FULL : DUPLEX_HALF;
> +
> +	/* TODO Check the PCS_AN_STATUS.Link status here?.. Note the flag is latched-low */
> +
> +	/* TODO The next is the TBI/RTBI-specific and seems to be valid if PCS_AN_STATUS.ANC */
>  	val = readl(priv->pcsaddr + PCS_ANE_LPA);

I thought these registers only existed of dma_cap.pcs is true ? If we
start checking PCS_AN_STATUS.Link here, and this register reads as
zeros, doesn't it mean that RMGII inband mode won't ever signal link
up?

>  
> -	/* TODO Make sure that STMMAC_PCS_PAUSE STMMAC_PCS_ASYM_PAUSE usage is legitimate */
> +	/* TODO The databook says the encoding is defined in IEEE 802.3z,
> +	 * Section 37.2.1.4. Do we need the STMMAC_PCS_PAUSE and
> +	 * STMMAC_PCS_ASYM_PAUSE mask here?
> +	 */
>  	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
>  			 state->lp_advertising,
>  			 FIELD_GET(PCS_ANE_PSE, val) & STMMAC_PCS_PAUSE);

If it's 802.3z aka 1000base-X format, then yes, we should be using
these bits if we are getting state from this register.

If TBI/RTBI is ever used, rather than trying to shoe-horn it all into
these functions, please consider splitting them into separate PCSes,
and sharing code between them e.g. using common functions called from
the method functions or shared method functions where appropriate.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

