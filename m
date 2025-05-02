Return-Path: <bpf+bounces-57226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE33AA73E2
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C26916AEA1
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1787D255F58;
	Fri,  2 May 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zbaFBOL6"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD740255F43;
	Fri,  2 May 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192980; cv=none; b=NctEss9frxmTKz+IsjfOVM8UmGy/yDTT/cPgISi4kjmQOwff1tcz1IaFEuPFVeqyE6LmaxXw1sfBywwD+g2wJ3LFPC95nzOH4ACjip2bz/1ghvlIBsvSUG6ZdlEM2aS7d9cfdOn8DDgnjA999LbKP1+pYl+7g+jKGFOObsoJ004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192980; c=relaxed/simple;
	bh=CZaKM3X0cNv8z4GZAOEtMbF6p9Kmbvu94yH8NDR/UJc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qbscrFiNg66p0WXIWe74RrK9ETL4MSd6dP89HyyWlKg2bPUx14ocv1v5jR2b4XiLs+wGvVwWovYnAc5WQqOyokZKsWGwAVCwlhN65T3rny0657AjtlLfc1PBlF6Mz8TUz09S5Cm+GcmK7pNuKjJNSSpEbR5tTqqn0JPKsuir8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zbaFBOL6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6p7FzJFuTWjhApkXkaBe3vnMqSM26dhrzv+NNxeJ9sU=; b=zbaFBOL65qPw5GLWJJUsTqfVBn
	T6HAHFEUriTtfx7qhMafYcuEkSWmYeO0kKb9Q8AIFxhKbyvezbytU37OHy5UaFpJCaBh32zKXR/NL
	lb9cvOXSFoX47z61f4lbgcJU0PfXFKSD9YhwEZnQWHSQn8BbYcMOdmuMVQ9vG/thUnpKE6sutTsJB
	0w7bZr5c8ztWlLVx2E3cd2Ynu8SrMiigoaHDa2VtkehFtCI3CiyDDrTt6qPFiGLsJ9L9vHGLjE/5r
	LD3jwK36Fp8au96H7sIlF4/N0NsUEDsrlVNJ6hdR9cwxnIWJnA9xSPwRagMpgH5tPfjYcj94CeLpj
	ZoNckERg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44044 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uAqYp-0001Oi-0B;
	Fri, 02 May 2025 14:36:15 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uAqYC-002D3p-UO; Fri, 02 May 2025 14:35:36 +0100
In-Reply-To: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
References: <aBTKOBKnhoz3rrlQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next v2 2/4] net: stmmac: call phylink_carrier_*() in XDP
 functions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uAqYC-002D3p-UO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 May 2025 14:35:36 +0100

Phylink does not permit drivers to mess with the netif carrier, as
this will de-synchronise phylink with the MAC driver. Moreover,
setting and clearing the TE and RE bits via stmmac_mac_set() in this
path is also wrong as the link may not be up.

Replace the netif_carrier_on(), netif_carrier_off() and
stmmac_mac_set() calls with the appropriate phylink_carrier_block() and
phylink_carrier_unblock() calls, thereby allowing phylink to manage the
netif carrier and TE/RE bits through the .mac_link_up() and
.mac_link_down() methods.

This change will have the side effect of printing link messages to
the kernel log, even though the physical link hasn't changed state.
This matches the carrier state that userspace sees, which has always
"bounced".

Note that RE should only be set after the DMA is ready to avoid the
receive FIFO between the MAC and DMA blocks overflowing, so
phylink_start() needs to be placed after DMA has been started.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f59a2363f150..ac27ea679b23 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6922,6 +6922,11 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Ensure tx function is not running */
 	netif_tx_disable(dev);
 
+	/* Take down the software link. stmmac_xdp_open() must be called after
+	 * this function to release this block.
+	 */
+	phylink_carrier_block(priv->phylink);
+
 	/* Disable NAPI process */
 	stmmac_disable_all_queues(priv);
 
@@ -6937,14 +6942,10 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
-	/* Disable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, false);
-
 	/* set trans_start so we don't get spurious
 	 * watchdogs during reset
 	 */
 	netif_trans_update(dev);
-	netif_carrier_off(dev);
 }
 
 int stmmac_xdp_open(struct net_device *dev)
@@ -7026,25 +7027,28 @@ int stmmac_xdp_open(struct net_device *dev)
 		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Start Rx & Tx DMA Channels */
 	stmmac_start_all_dma(priv);
 
+	/* Allow phylink to bring the software link back up.
+	 * stmmac_xdp_release() must have been called prior to this.
+	 */
+	phylink_carrier_unblock(priv->phylink);
+
 	ret = stmmac_request_irq(dev);
 	if (ret)
 		goto irq_error;
 
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
-	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	stmmac_enable_all_dma_irq(priv);
 
 	return 0;
 
 irq_error:
+	phylink_stop(priv->phylink);
+
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-- 
2.30.2


