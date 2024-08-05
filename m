Return-Path: <bpf+bounces-36386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD79479CC
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1696D1C21181
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F31591F0;
	Mon,  5 Aug 2024 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lbf1Wlhn"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5CE155A47;
	Mon,  5 Aug 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853553; cv=none; b=aUZgUQeBkd3gRR2CRYm98Cyr1JjOFi4OMb3tUSJpbz9KhRvAVYn8219plvsEAuyd2cWInlvkc4e0EewlUj0kBAPoqt4XO+EbQTgUAZuos1Lr6WsNmUf6uFXjdgM9URWnRgproE77vwIzZvXEeNnPYMWljTEptsCBlvK5l+mdQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853553; c=relaxed/simple;
	bh=35DOUAoRG/beyCXjV5PEATLnCfxkKOw/Es+TxXkvDic=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TzpeKvPD4p7PTJPp3GYE0TzU6L7wXx844oYfDyXuvSXED8LajKQFkKaH2A1uXE1wL0VWHxCxX7pCefch+eO3NYhbb1yp+rmEAlBxQo2RqGtB1FOgLMbCFpgyq+vD9aSIoV9xdJmrCVzVwcuwSIrZwYHi8BEW/27eW0viZHaCihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lbf1Wlhn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=35mqFERgEDVV+qbp2znDr/4FKTDPJ1KGwKk1hewnljU=; b=lbf1WlhnubeOcFCPQZVAIDZuzo
	8UeETb6zPJKN8G6a4gSf/u3lclU5dS0EHyJ2FIjIAFfVbtDKXJXgMH7BXyoUqWuqVfnzhRaMnTBk0
	dUqv1RJ3qThnMMeTaF6EZzM0WdaweOkfZ5hUjLh/SJ4BNp//7oLnsfkYd2EelS0s+m5t5Q3QDpKtJ
	XyqQ19eJG7KDs0axSZ3w0mIQStQJOWjaiS00w1UBXS5odxmQMf5h2x/zxZAzc090oqeTLSdCAj4SY
	1whXgERo9y2l/c3RuIh2FQXS1+jmYAbM60xQ28dqfJeZXzIMhtHHd02UcVVjfH65MV/sdBqAFfACU
	GvLnDvUg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49724 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sauuI-0002f9-2g;
	Mon, 05 Aug 2024 11:25:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sauuN-000tvs-2N; Mon, 05 Aug 2024 11:25:43 +0100
In-Reply-To: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Sneh Shah <quic_snehshah@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH RFC net-next v4 13/14] net: stmmac: remove obsolete pcs
 methods and associated code
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sauuN-000tvs-2N@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 05 Aug 2024 11:25:43 +0100

The pcs_ctrl_ane() method is no longer required as this will be handled
by the mac_pcs phylink_pcs instance. Remove these methods, their common
implementation, the pcs_link, pcs_duplex and pcs_speed members of
struct stmmac_extra_stats, and stmmac_has_mac_phylink_select_pcs().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  | 10 ---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  4 --
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 70 +------------------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 13 ----
 4 files changed, 2 insertions(+), 95 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 9e8f1659377e..5a49d8db30fe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -191,9 +191,6 @@ struct stmmac_extra_stats {
 	unsigned long irq_pcs_ane_n;
 	unsigned long irq_pcs_link_n;
 	unsigned long irq_rgmii_n;
-	unsigned long pcs_link;
-	unsigned long pcs_duplex;
-	unsigned long pcs_speed;
 	/* debug register */
 	unsigned long mtl_tx_status_fifo_full;
 	unsigned long mtl_tx_fifo_not_empty;
@@ -394,13 +391,6 @@ enum request_irq_err {
 #define CORE_IRQ_MTL_RX_OVERFLOW	BIT(8)
 
 /* Physical Coding Sublayer */
-struct rgmii_adv {
-	unsigned int pause;
-	unsigned int duplex;
-	unsigned int lp_pause;
-	unsigned int lp_duplex;
-};
-
 #define STMMAC_PCS_PAUSE	1
 #define STMMAC_PCS_ASYM_PAUSE	2
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 06284aee4088..3553e8a767cb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -303,7 +303,6 @@ struct stmmac_dma_ops {
 
 struct mac_device_info;
 struct net_device;
-struct rgmii_adv;
 struct stmmac_tc_entry;
 struct stmmac_pps_cfg;
 struct stmmac_rss;
@@ -539,9 +538,6 @@ struct stmmac_ops {
 #define stmmac_fpe_irq_status(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, fpe_irq_status, __args)
 
-#define stmmac_has_mac_phylink_select_pcs(__priv) \
-	((__priv)->hw->mac->phylink_select_pcs != NULL)
-
 /* PTP and HW Timer helpers */
 struct stmmac_hwtimestamp {
 	void (*config_hw_tstamping) (void __iomem *ioaddr, u32 data);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index b9135e00cf3a..799af80024d2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -321,48 +321,6 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
-	    (priv->hw->pcs & STMMAC_PCS_RGMII ||
-	     priv->hw->pcs & STMMAC_PCS_SGMII) &&
-	    !stmmac_has_mac_phylink_select_pcs(priv)) {
-		u32 supported, advertising, lp_advertising;
-
-		if (!priv->xstats.pcs_link) {
-			cmd->base.speed = SPEED_UNKNOWN;
-			cmd->base.duplex = DUPLEX_UNKNOWN;
-			return 0;
-		}
-		cmd->base.duplex = priv->xstats.pcs_duplex;
-
-		cmd->base.speed = priv->xstats.pcs_speed;
-
-		/* Encoding of PSE bits is defined in 802.3z, 37.2.1.4 */
-
-		ethtool_convert_link_mode_to_legacy_u32(
-			&supported, cmd->link_modes.supported);
-		ethtool_convert_link_mode_to_legacy_u32(
-			&advertising, cmd->link_modes.advertising);
-		ethtool_convert_link_mode_to_legacy_u32(
-			&lp_advertising, cmd->link_modes.lp_advertising);
-
-		/* Reg49[3] always set because ANE is always supported */
-		cmd->base.autoneg = ADVERTISED_Autoneg;
-		supported |= SUPPORTED_Autoneg;
-		advertising |= ADVERTISED_Autoneg;
-		lp_advertising |= ADVERTISED_Autoneg;
-
-		cmd->base.port = PORT_OTHER;
-
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.supported, supported);
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.advertising, advertising);
-		ethtool_convert_legacy_u32_to_link_mode(
-			cmd->link_modes.lp_advertising, lp_advertising);
-
-		return 0;
-	}
-
 	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
 }
 
@@ -372,21 +330,6 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
-	    (priv->hw->pcs & STMMAC_PCS_RGMII ||
-	     priv->hw->pcs & STMMAC_PCS_SGMII) &&
-	    !stmmac_has_mac_phylink_select_pcs(priv)) {
-		/* Only support ANE */
-		if (cmd->base.autoneg != AUTONEG_ENABLE)
-			return -EINVAL;
-
-		mutex_lock(&priv->lock);
-		stmmac_pcs_ctrl_ane(priv, 1, priv->hw->ps, 0);
-		mutex_unlock(&priv->lock);
-
-		return 0;
-	}
-
 	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
 }
 
@@ -487,11 +430,7 @@ stmmac_get_pauseparam(struct net_device *netdev,
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
 
-	if (priv->hw->pcs && !stmmac_has_mac_phylink_select_pcs(priv)) {
-		pause->autoneg = 1;
-	} else {
-		phylink_ethtool_get_pauseparam(priv->phylink, pause);
-	}
+	phylink_ethtool_get_pauseparam(priv->phylink, pause);
 }
 
 static int
@@ -500,12 +439,7 @@ stmmac_set_pauseparam(struct net_device *netdev,
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
 
-	if (priv->hw->pcs && !stmmac_has_mac_phylink_select_pcs(priv)) {
-		pause->autoneg = 1;
-		return 0;
-	} else {
-		return phylink_ethtool_set_pauseparam(priv->phylink, pause);
-	}
+	return phylink_ethtool_set_pauseparam(priv->phylink, pause);
 }
 
 static u64 stmmac_get_rx_normal_irq_n(struct stmmac_priv *priv, int q)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b8b368926708..a57f5028d8aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3486,9 +3486,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 		}
 	}
 
-	if (priv->hw->pcs && !stmmac_has_mac_phylink_select_pcs(priv))
-		stmmac_pcs_ctrl_ane(priv, 1, priv->hw->ps, 0);
-
 	/* set TX and RX rings length */
 	stmmac_set_rings_length(priv);
 
@@ -6062,16 +6059,6 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		for (queue = 0; queue < queues_count; queue++)
 			stmmac_host_mtl_irq_status(priv, priv->hw, queue);
 
-		/* PCS link status */
-		if (priv->hw->pcs &&
-		    !(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
-		    !stmmac_has_mac_phylink_select_pcs(priv)) {
-			if (priv->xstats.pcs_link)
-				netif_carrier_on(priv->dev);
-			else
-				netif_carrier_off(priv->dev);
-		}
-
 		stmmac_timestamp_interrupt(priv, priv);
 	}
 }
-- 
2.30.2


