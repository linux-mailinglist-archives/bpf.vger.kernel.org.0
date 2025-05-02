Return-Path: <bpf+bounces-57236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD305AA7606
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 17:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060F33AC9C4
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01759257AE4;
	Fri,  2 May 2025 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p6NGLdFP"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2617A2ED;
	Fri,  2 May 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199779; cv=none; b=WSoTOZhA5nSU2VlY9VYTiqMuEL63y//hKirm0IaL1vL0K+cBQpRjozAr3rqSSzHfMlkqpj+aZM5ao5TLw3i0o3rg+CkEdPQfW5V8llbuK0EkCpQW5MusN1xrszo/y/ad/H4goyEmLlBRegU4Uingvde1gNgA0gHoy2hvNcSorwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199779; c=relaxed/simple;
	bh=+k/prdyt7XpxkLmp3ByAG2eKIeUdBVBeyW2YyID4bTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9JBBzSMxPtAHXxiRHTv3PaWyFULhJzJgQtlOL3RCKoJPRCjVUats73QKWxw7AdxwJYq+2OSiMqkSDPELiJjbs4OJUfVnxeUnvjW7TD40J4gsX1v3Lyh1NHVkfgnPh13EcI/jWisC9DZthHjDUqLWRZmvchq670Ba1OkIxCocjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p6NGLdFP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UfHSthQhcUGUYPAqAokpW8M9XQiGqY8eZUIZb5WDYjI=; b=p6NGLdFPU5vD+ggKs/3gbgFczg
	ARE+G6P1/RTbibIEYqrFuAo2kpWtO3AAaAJNjJ5B5RdEDv0EwyDiu4Lgtl7i/XKAYdMl0kmdedgNo
	kIYuOx7CSgcrd0+WnS59vnplpO2Pg+zBkuc+wxx64SDmqpe4HvgRoxcqEBZZ8ZVwozG0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uAsKH-00BQnu-1r; Fri, 02 May 2025 17:29:21 +0200
Date: Fri, 2 May 2025 17:29:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: call phylink_carrier_*() in
 XDP functions
Message-ID: <ed54d4e5-ecc3-4327-8739-3d41ca41211e@lunn.ch>
References: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
 <E1uAqYC-002D3p-UO@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uAqYC-002D3p-UO@rmk-PC.armlinux.org.uk>

On Fri, May 02, 2025 at 02:35:36PM +0100, Russell King (Oracle) wrote:
> Phylink does not permit drivers to mess with the netif carrier, as
> this will de-synchronise phylink with the MAC driver. Moreover,
> setting and clearing the TE and RE bits via stmmac_mac_set() in this
> path is also wrong as the link may not be up.
> 
> Replace the netif_carrier_on(), netif_carrier_off() and
> stmmac_mac_set() calls with the appropriate phylink_carrier_block() and
> phylink_carrier_unblock() calls, thereby allowing phylink to manage the
> netif carrier and TE/RE bits through the .mac_link_up() and
> .mac_link_down() methods.
> 
> This change will have the side effect of printing link messages to
> the kernel log, even though the physical link hasn't changed state.
> This matches the carrier state that userspace sees, which has always
> "bounced".
> 
> Note that RE should only be set after the DMA is ready to avoid the
> receive FIFO between the MAC and DMA blocks overflowing, so
> phylink_start() needs to be placed after DMA has been started.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f59a2363f150..ac27ea679b23 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6922,6 +6922,11 @@ void stmmac_xdp_release(struct net_device *dev)
>  	/* Ensure tx function is not running */
>  	netif_tx_disable(dev);
>  
> +	/* Take down the software link. stmmac_xdp_open() must be called after
> +	 * this function to release this block.
> +	 */
> +	phylink_carrier_block(priv->phylink);
> +
>  	/* Disable NAPI process */
>  	stmmac_disable_all_queues(priv);
>  
> @@ -6937,14 +6942,10 @@ void stmmac_xdp_release(struct net_device *dev)
>  	/* Release and free the Rx/Tx resources */
>  	free_dma_desc_resources(priv, &priv->dma_conf);
>  
> -	/* Disable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, false);
> -
>  	/* set trans_start so we don't get spurious
>  	 * watchdogs during reset
>  	 */
>  	netif_trans_update(dev);
> -	netif_carrier_off(dev);
>  }
>  

>  int stmmac_xdp_open(struct net_device *dev)
> @@ -7026,25 +7027,28 @@ int stmmac_xdp_open(struct net_device *dev)
>  		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Start Rx & Tx DMA Channels */
>  	stmmac_start_all_dma(priv);
>  
> +	/* Allow phylink to bring the software link back up.
> +	 * stmmac_xdp_release() must have been called prior to this.
> +	 */

This is counter intuitive. Why is release called before open?

Looking into stmmac_xdp_set_prog() i think i get it. Even if there is
not a running XDP prog, stmmac_xdp_release() is called, and then
stmmac_xdp_open().

Maybe these two functions need better names? prepare and commit?

      Andrew

