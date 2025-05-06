Return-Path: <bpf+bounces-57495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C324BAABD7F
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 10:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C231C23608
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5CD24A073;
	Tue,  6 May 2025 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CdpldXB/"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD70182B4;
	Tue,  6 May 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520810; cv=none; b=IsjJhFu80BUOIPWsM1hBDq6Ijuwn8GoWDIqXO7LjaIEcXQsA7vo5XLOxIt9+YUxq9bXfPWYR6bP4nV0wI2z5SX08Rojf59JiZCRhaTi4ARm/acbqxYu3QUnkedc03ULVLYGOTxSrdAmlYDPadJ+CqM5EEDwCdriRdnhYQtRUyPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520810; c=relaxed/simple;
	bh=V4iD4it7AtwDDWIlFWPxjAYr1MD/RRa8TIyOgKTxOOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIk/KGoH/Ceg0C25NN/PjW0t8CWXtMjhrkD83tJ8hwYm9aCh2Llt/81RsYiCMTB2ecMMgBdQmCZFsUi1Ew2Wc7DCgD/GMFoaynU4c6fhMgvxvwdezc9ZErHWY9ipTwf1yk9o75Te87rR7vl+Qyw/mO2lCFua0llYkzjPDl8mEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CdpldXB/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7erJ6D4MscaX/8GMAkhh6echRQy7e9Y89tGL2kE8J0M=; b=CdpldXB/2Q0l2OTVLNV2gpkRAG
	XfccCdj2iux3quft5JVSSqw/idGG0Gm3/pQmtQp+6Hxod0KxkK+jVhfPGlNxUlMgmzKD+/mTvSCyh
	3jFMecGeHePRWEUYRWLPW74q7X75hCp91jo2htDud9PBzTe6JBlhxP5dsw0py85278EQgpAMD75ls
	cILdpReGXz2MKvgcOg9y93V1fbZsXZTVRau9wVlujcMsPvjfUXXwzkvoCQmwvc1KqNKIi4JzGK8U8
	FRLpbI+nsHfh2Q9vEushCtnSQs8O0y+EpDjIkKDdDAIhCp87s70N3IfL4MlIFeFcYRQrYJdOXembm
	H3GAXrdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33184)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uCDqO-0005V2-1K;
	Tue, 06 May 2025 09:40:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uCDqM-0004f5-0o;
	Tue, 06 May 2025 09:40:02 +0100
Date: Tue, 6 May 2025 09:40:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <aBnK4i52tEHs3jm_@shell.armlinux.org.uk>
References: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
 <E1uAqYC-002D3p-UO@rmk-PC.armlinux.org.uk>
 <ed54d4e5-ecc3-4327-8739-3d41ca41211e@lunn.ch>
 <aBUG6Z_Crs31W45x@shell.armlinux.org.uk>
 <aBnKKafHHjkL5iP-@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBnKKafHHjkL5iP-@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 06, 2025 at 09:36:57AM +0100, Russell King (Oracle) wrote:
> On Fri, May 02, 2025 at 06:54:49PM +0100, Russell King (Oracle) wrote:
> > On Fri, May 02, 2025 at 05:29:21PM +0200, Andrew Lunn wrote:
> > > On Fri, May 02, 2025 at 02:35:36PM +0100, Russell King (Oracle) wrote:
> > > > Phylink does not permit drivers to mess with the netif carrier, as
> > > > this will de-synchronise phylink with the MAC driver. Moreover,
> > > > setting and clearing the TE and RE bits via stmmac_mac_set() in this
> > > > path is also wrong as the link may not be up.
> > > > 
> > > > Replace the netif_carrier_on(), netif_carrier_off() and
> > > > stmmac_mac_set() calls with the appropriate phylink_carrier_block() and
> > > > phylink_carrier_unblock() calls, thereby allowing phylink to manage the
> > > > netif carrier and TE/RE bits through the .mac_link_up() and
> > > > .mac_link_down() methods.
> > > > 
> > > > This change will have the side effect of printing link messages to
> > > > the kernel log, even though the physical link hasn't changed state.
> > > > This matches the carrier state that userspace sees, which has always
> > > > "bounced".
> > > > 
> > > > Note that RE should only be set after the DMA is ready to avoid the
> > > > receive FIFO between the MAC and DMA blocks overflowing, so
> > > > phylink_start() needs to be placed after DMA has been started.
> > > > 
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > ---
> > > >  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++++--------
> > > >  1 file changed, 12 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index f59a2363f150..ac27ea679b23 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -6922,6 +6922,11 @@ void stmmac_xdp_release(struct net_device *dev)
> > > >  	/* Ensure tx function is not running */
> > > >  	netif_tx_disable(dev);
> > > >  
> > > > +	/* Take down the software link. stmmac_xdp_open() must be called after
> > > > +	 * this function to release this block.
> > > > +	 */
> > > > +	phylink_carrier_block(priv->phylink);
> > > > +
> > > >  	/* Disable NAPI process */
> > > >  	stmmac_disable_all_queues(priv);
> > > >  
> > > > @@ -6937,14 +6942,10 @@ void stmmac_xdp_release(struct net_device *dev)
> > > >  	/* Release and free the Rx/Tx resources */
> > > >  	free_dma_desc_resources(priv, &priv->dma_conf);
> > > >  
> > > > -	/* Disable the MAC Rx/Tx */
> > > > -	stmmac_mac_set(priv, priv->ioaddr, false);
> > > > -
> > > >  	/* set trans_start so we don't get spurious
> > > >  	 * watchdogs during reset
> > > >  	 */
> > > >  	netif_trans_update(dev);
> > > > -	netif_carrier_off(dev);
> > > >  }
> > > >  
> > > 
> > > >  int stmmac_xdp_open(struct net_device *dev)
> > > > @@ -7026,25 +7027,28 @@ int stmmac_xdp_open(struct net_device *dev)
> > > >  		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > > >  	}
> > > >  
> > > > -	/* Enable the MAC Rx/Tx */
> > > > -	stmmac_mac_set(priv, priv->ioaddr, true);
> > > > -
> > > >  	/* Start Rx & Tx DMA Channels */
> > > >  	stmmac_start_all_dma(priv);
> > > >  
> > > > +	/* Allow phylink to bring the software link back up.
> > > > +	 * stmmac_xdp_release() must have been called prior to this.
> > > > +	 */
> > > 
> > > This is counter intuitive. Why is release called before open?
> > 
> > Indeed - and that should've been caught in the review where XDP was
> > being added.
> > 
> > > Looking into stmmac_xdp_set_prog() i think i get it. Even if there is
> > > not a running XDP prog, stmmac_xdp_release() is called, and then
> > > stmmac_xdp_open().
> > 
> > If there is a change of "do we have an XDP prog" state, then
> > stmmac_xdp_release() is called to free all the current contexts to
> > do with queue/descriptor management, and then stmmac_xdp_open() is
> > called thereafter. These are doing a subset of .ndo_open/.ndo_release
> > and I think that's where they're getting their naming from.
> > 
> > The only possible sequence is:
> > 
> > 	stmmac_open()
> > then, on each XDP prog addition or removal, but not replacement:
> > 		stmmac_xdp_release()
> > 		stmmac_xdp_open()
> > finally,
> > 	stmmac_release()
> > 
> > > Maybe these two functions need better names? prepare and commit?
> > 
> > Yes, it's all counter intuitive, and there are various things about the
> > XDP code that make it hard to follow.
> > 
> > For example, stmmac_xdp_set_prog() leads you to think, because of the
> > way the need_update variable is set, that looking for references to
> > xdp_prog would show one where all the dependents are, but no, there's
> > stmmac_xdp_is_enabled(), which is nice and readable, but could've
> > been used in stmmac_xdp_set_prog() to make it more obvious what to
> > grep for.
> > 
> > Incidentally, if stmmac_xdp_open() fails to re-grab the interrupts,
> > then it calls phylink_stop(), stmmac_hw_teardown(), and
> > free_dma_desc_resources().
> > 
> > If one then set the interface administratively down, stmmac_release()
> > gets called, which again calls phylink_stop(), free_dma_desc_resources()
> > and stmmac_release_ptp().
> > 
> > stmmac_release_ptp() disables/unprepares clk_ptp_ref, and unregisters
> > the PTP stuff. stmmac_hw_teardown() also disables/unprepares
> > clk_ptp_ref, so we probably unbalance the clk API in this case...
> > and probably much other stuff.
> > 
> > Calling free_dma_desc_resources() twice calls functios such as 
> > free_dma_tx_desc_resources() twice, and it looks like that's not going
> > to be healthy, calling dma_free_coherent() with the same arguments,
> > double-releasing memory. Same for kfree(). Probably same for the RX
> > stuff.
> > 
> > Basically, if one messes with XDP in this driver, expect things to go
> > bang and kill the kernel if something goes wrong with the whole
> > xdp_release+xdp_open dance.
> > 
> > Honestly, this needs a rewrite, but I currently know nowt about XDP.
> > 
> > So, I'd suggest that the names of these functions is the least of the
> > problems here.
> 
> Well, this series has been discarded from patchwork. Shrug. I won't be
> posting another version, stmmac can remain broken. I don't have a
> suggestion on better names for these functions.

... and in any case, Andrew's comment would be a *separate* change to
the subject of this series, so is not appropriate to be part of this
series.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

