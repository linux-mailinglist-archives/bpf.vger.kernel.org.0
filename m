Return-Path: <bpf+bounces-36382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBBD9479C0
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB8C1C21260
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA5B158A15;
	Mon,  5 Aug 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eoVXTaPH"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8270156F23;
	Mon,  5 Aug 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853532; cv=none; b=jAxqGzGbCfr494y9p4SeSDtGHnvSjgcz76v9L24LwMoNosXbJSJmsA+jHAubxCrWAXEsV2NGjLkQaHdO2g6JAS4IuPCjeXKNhXl4cG2Tdr4oIjyfcIqhc2ha210FSHycqrElz2HKjVbTaNCvSxm+Lvu5g4htovRIpRKTtj2M5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853532; c=relaxed/simple;
	bh=RXHQDsG+9QVKRz17RYevFY1Rk3JkLAlmb1ywXpLYHLM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=MaT18jdSm4/jqPTPt+0EvE1P+iGURdZsAxO9/DnuodO0Fxw/R3Hf0BokA5eYEDH7X6V5JtrxAtkUpq7dc7N6geozcDCB5Xjur2AZPYaExxhqF+qs7VdpWibYecEdQa+e5El8JvGcbV3Of4peTR1owyrv+O+Zsxfgj9YFYWO0AKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eoVXTaPH; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C9f3sXn5CIBBTPqFMcdW/Yt6tX1XEnjE29jmPpTSSas=; b=eoVXTaPHr1tpPwh5z+uIUdXVlz
	jLMi+jasQ4RJmpIEuoDvXjtD4SXWJrC3gWSQ2X+5YloLCpQAgqWHDnACb+ixI4j+hTi54rGgC/InA
	sZ0ylArVQKymkJzR0dWhbYDjOHlJJW34KtGns0Qz7ZLkeeK62K5UvY8+KMfpODwX1WryT2akJqYhF
	67IfX6dpjAsGWnnA3AIXU/PcdbH705DNRHOIpjqN9U+NNcyZoCxR577+LjSjqLUbbfzXeC8NoeA93
	S6+PPGRUF0vnReVlD/9QeMRDIKqR4mjySOAYQvbXL/8Lq/LjYzvjrHoMnVfO37czLDtSNeq9MOPRs
	N9El0W3A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44308 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sauty-0002dY-0h;
	Mon, 05 Aug 2024 11:25:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sauu2-000tvU-JF; Mon, 05 Aug 2024 11:25:22 +0100
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
Subject: [PATCH RFC net-next v4 09/14] net: stmmac: dwmac4: move PCS interrupt
 control
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sauu2-000tvU-JF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 05 Aug 2024 11:25:22 +0100

Control the PCS interrupt mask from the phylink pcs_enable() and
pcs_disable() methods rather than relying on driver variables.

This assumes that GMAC_INT_RGSMIIS, GMAC_INT_PCS_LINK and
GMAC_INT_PCS_ANE are all relevant to the PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index ec8e94ddf948..0d261709bee6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -56,9 +56,6 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 	/* Enable GMAC interrupts */
 	value = GMAC_INT_DEFAULT_ENABLE;
 
-	if (hw->pcs)
-		value |= GMAC_PCS_IRQ_DEFAULT;
-
 	/* Enable FPE interrupt */
 	if ((GMAC_HW_FEAT_FPESEL & readl(ioaddr + GMAC_HW_FEATURE3)) >> 26)
 		value |= GMAC_INT_FPE_EN;
@@ -759,6 +756,30 @@ static void dwmac4_ctrl_ane(struct stmmac_priv *priv, bool ane, bool srgmi_ral,
 	dwmac_ctrl_ane(priv->ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
+static int dwmac4_mii_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+	void __iomem *ioaddr = spcs->priv->hw->pcsr;
+	u32 intr_enable;
+
+	intr_enable = readl(ioaddr + GMAC_INT_EN);
+	intr_enable |= GMAC_PCS_IRQ_DEFAULT;
+	writel(intr_enable, ioaddr + GMAC_INT_EN);
+
+	return 0;
+}
+
+static void dwmac4_mii_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+	void __iomem *ioaddr = spcs->priv->hw->pcsr;
+	u32 intr_enable;
+
+	intr_enable = readl(ioaddr + GMAC_INT_EN);
+	intr_enable &= ~GMAC_PCS_IRQ_DEFAULT;
+	writel(intr_enable, ioaddr + GMAC_INT_EN);
+}
+
 static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
 				     struct phylink_link_state *state)
 {
@@ -772,11 +793,12 @@ static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
 }
 
 static const struct phylink_pcs_ops dwmac4_mii_pcs_ops = {
+	.pcs_enable = dwmac4_mii_pcs_enable,
+	.pcs_disable = dwmac4_mii_pcs_disable,
 	.pcs_config = dwmac_pcs_config,
 	.pcs_get_state = dwmac4_mii_pcs_get_state,
 };
 
-
 static struct phylink_pcs *
 dwmac4_phylink_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
 {
-- 
2.30.2


