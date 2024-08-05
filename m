Return-Path: <bpf+bounces-36379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524989479B7
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08282281578
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064BB157E84;
	Mon,  5 Aug 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KJRgsVES"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971F14B947;
	Mon,  5 Aug 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853519; cv=none; b=JT9fmdaEdTE2yWldVPZ1+CQeyE03S4IhVH0Kc7lnFPLIjMC7ijALuh/n7041Dt0ooonxfM4hQVNq5kbz/Eohpcd8REgT/6nm2G+qQXGT6eX2PXxo5BJdKl9eeuAg8qUZt+ObLoVn7EMSc5pSS+lBCxHIHOt2g7bLTP3sGvkAw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853519; c=relaxed/simple;
	bh=gtgH77rT/B2VpoYW5MV4UdVAP772I8yDiyIzidWebr0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CaDhXdcXqC2+0ReCb1+EJ0TEUyf2R5lwvKdzmUHV4oIksRyuuzooxLmCaiXSEz7uIxpkx1CkzWRrxab+cXYd4X/LSoisCkxEBSL18mjt+E/0ZcBQujefmj1dGOdHMREFkQlmQSIZKqEV5f/6IZwOKSDh04Ouh2nxq8rERIWPpTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KJRgsVES; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WrkoatYWq64VBcokQEdFjC44CkyN1bduVYDNhV5nBuE=; b=KJRgsVESeZ2FbdMIhsVLjsdxm5
	Q0AXPlzkBHFprAHIIRMBuJlziJUwb7O+aiyiQqYaiFaT5dap6LQd1wypE6RxvUCg3Q75Ix/9ch5om
	Hbh6t3A0WxBDjaQqkdgOfRnxjKKKLvWKRzynm7OeepY2MRBHDaqWv3zE3tlEMqnn0Mygz7sjqgot9
	zz+poFR7rOeB3UGAUdeLZBgW+7BwJHOyVwI3wj6Kr9aIUvl8AYZRz6QMkg4yXwYo0NclWZsv+r65N
	Y7OTbPG7cfuGL6MSECsmXfD571IDtZRZv6U3yNM70rcVRCD75ChVmDcIaI4pPDBW0cHF8hNJRkfxt
	DMGIlG3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55598 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sautj-0002cO-0u;
	Mon, 05 Aug 2024 11:25:03 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sautn-000tvC-7w; Mon, 05 Aug 2024 11:25:07 +0100
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
Subject: [PATCH RFC net-next v4 06/14] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sautn-000tvC-7w@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 05 Aug 2024 11:25:07 +0100

Convert dwmac1000 sgmii/rgmii "pcs" implementation to use a phylink_pcs
so we can eventually get rid of the exceptional paths that conflict
with phylink.

We do not provide a validate method to enforce auto-negotiation,
because the ethtool autonegotiation is a property of the media facing
link, not of the internal network device links.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   | 13 +---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 73 ++++++++++---------
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 4296ddda8aaa..50a73bf1c6f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -86,19 +86,8 @@ enum power_event {
 #define GMAC_RGSMIIIS		0x000000d8	/* RGMII/SMII status */
 
 /* SGMII/RGMII status register */
-#define GMAC_RGSMIIIS_LNKMODE		BIT(0)
-#define GMAC_RGSMIIIS_SPEED		GENMASK(2, 1)
-#define GMAC_RGSMIIIS_SPEED_SHIFT	1
-#define GMAC_RGSMIIIS_LNKSTS		BIT(3)
-#define GMAC_RGSMIIIS_JABTO		BIT(4)
-#define GMAC_RGSMIIIS_FALSECARDET	BIT(5)
+#define GMAC_RGSMIIIS_RS_STAT		GENMASK(15, 0)
 #define GMAC_RGSMIIIS_SMIDRXS		BIT(16)
-/* LNKMOD */
-#define GMAC_RGSMIIIS_LNKMOD_MASK	0x1
-/* LNKSPEED */
-#define GMAC_RGSMIIIS_SPEED_125		0x2
-#define GMAC_RGSMIIIS_SPEED_25		0x1
-#define GMAC_RGSMIIIS_SPEED_2_5		0x0
 
 /* GMAC Configuration defines */
 #define GMAC_CONTROL_2K 0x08000000	/* IEEE 802.3as 2K packets */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 8af51ddef3e8..66c17be79dec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/phylink.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
@@ -261,39 +262,6 @@ static void dwmac1000_pmt(struct mac_device_info *hw, unsigned long mode)
 	writel(pmt, ioaddr + GMAC_PMT);
 }
 
-/* RGMII or SMII interface */
-static void dwmac1000_rgsmii(void __iomem *ioaddr, struct stmmac_extra_stats *x)
-{
-	u32 status;
-
-	status = readl(ioaddr + GMAC_RGSMIIIS);
-	x->irq_rgmii_n++;
-
-	/* Check the link status */
-	if (status & GMAC_RGSMIIIS_LNKSTS) {
-		int speed_value;
-
-		x->pcs_link = 1;
-
-		speed_value = ((status & GMAC_RGSMIIIS_SPEED) >>
-			       GMAC_RGSMIIIS_SPEED_SHIFT);
-		if (speed_value == GMAC_RGSMIIIS_SPEED_125)
-			x->pcs_speed = SPEED_1000;
-		else if (speed_value == GMAC_RGSMIIIS_SPEED_25)
-			x->pcs_speed = SPEED_100;
-		else
-			x->pcs_speed = SPEED_10;
-
-		x->pcs_duplex = (status & GMAC_RGSMIIIS_LNKMOD_MASK);
-
-		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
-			x->pcs_duplex ? "Full" : "Half");
-	} else {
-		x->pcs_link = 0;
-		pr_info("Link is Down\n");
-	}
-}
-
 static int dwmac1000_irq_status(struct mac_device_info *hw,
 				struct stmmac_extra_stats *x)
 {
@@ -335,8 +303,12 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
 
-	if (intr_status & PCS_RGSMIIIS_IRQ)
-		dwmac1000_rgsmii(ioaddr, x);
+	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		/* TODO Dummy-read to clear the IRQ status */
+		readl(ioaddr + GMAC_RGSMIIIS);
+		phylink_pcs_change(&hw->mac_pcs.pcs, false);
+		x->irq_rgmii_n++;
+	}
 
 	return ret;
 }
@@ -404,6 +376,31 @@ static void dwmac1000_ctrl_ane(struct stmmac_priv *priv, bool ane,
 	dwmac_ctrl_ane(priv->ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
+static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
+					struct phylink_link_state *state)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+	u32 status = readl(spcs->priv->ioaddr + GMAC_RGSMIIIS);
+
+	dwmac_rs_decode_stat(state, FIELD_GET(GMAC_RGSMIIIS_RS_STAT, status));
+}
+
+static const struct phylink_pcs_ops dwmac1000_mii_pcs_ops = {
+	.pcs_config = dwmac_pcs_config,
+	.pcs_get_state = dwmac1000_mii_pcs_get_state,
+};
+
+static struct phylink_pcs *
+dwmac1000_phylink_select_pcs(struct stmmac_priv *priv,
+			     phy_interface_t interface)
+{
+	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
+	    priv->hw->pcs & STMMAC_PCS_SGMII)
+		return &priv->hw->mac_pcs.pcs;
+
+	return NULL;
+}
+
 static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    struct stmmac_extra_stats *x,
 			    u32 rx_queues, u32 tx_queues)
@@ -494,6 +491,7 @@ static void dwmac1000_set_mac_loopback(void __iomem *ioaddr, bool enable)
 
 const struct stmmac_ops dwmac1000_ops = {
 	.core_init = dwmac1000_core_init,
+	.phylink_select_pcs = dwmac1000_phylink_select_pcs,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac1000_rx_ipc_enable,
 	.dump_regs = dwmac1000_dump_regs,
@@ -543,5 +541,10 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_shift = 2;
 	mac->mii.clk_csr_mask = GENMASK(5, 2);
 
+	mac->mac_pcs.priv = priv;
+	mac->mac_pcs.pcs_base = priv->ioaddr + GMAC_PCS_BASE;
+	mac->mac_pcs.pcs.ops = &dwmac1000_mii_pcs_ops;
+	mac->mac_pcs.pcs.neg_mode = true;
+
 	return 0;
 }
-- 
2.30.2


