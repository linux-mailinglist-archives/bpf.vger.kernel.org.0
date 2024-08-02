Return-Path: <bpf+bounces-36278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55435945C63
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C051F22115
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B901E2104;
	Fri,  2 Aug 2024 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YA+HABMm"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81971E2105;
	Fri,  2 Aug 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722595668; cv=none; b=GLydLsiVwjAHSp9pGZPnlYMrrO/NR4qlhyMZyzUHEJ/Z5l7YpdROMojrBS6cChTUPC5PAckt/E9bRrQbr7ZrN/rSXgoydLyEfMrVBl9nuzcN1n+Nlo3smgUdBmMHFGwjjZNZNgowwRGbN+QBM2f+tLfeg0BWEmJcrquhNzbw6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722595668; c=relaxed/simple;
	bh=RXHQDsG+9QVKRz17RYevFY1Rk3JkLAlmb1ywXpLYHLM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bp2m62I1xDPi5Tbn3IuJ2IHF8r5K2kEOUxfSKgUL6ag6C7eEPFpIfcI75ps2m7rUMaVXEWRD+CEg6wUoQkbQJkM1ENY6K9wHcTzYjzUZCHc96LCLlZBezN6Nz6LoJmU5C6itczho2Wv8HwS1b3yxpXzIzNXzwaVKDMSmEa45HDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YA+HABMm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C9f3sXn5CIBBTPqFMcdW/Yt6tX1XEnjE29jmPpTSSas=; b=YA+HABMmrD1CP6n7MpAGJNEF2W
	8BpQW2jlqXHH4Y8kj0gXiXH7YELvpvvtd+u5DTKHjTDoIw5J6s4SJvcWL6WtYnWzpRv0sMZr6s2MQ
	0tJzH+nOxbp4d5vWfOKWAIKAdWylM+ONzeAoi8jD0Bhm2VkyZ6q2Rof7y9nQ9HWiZH9yDpKi/BGV9
	P/ZHh0PgKhGL1xkmSeD6QW9MKmfEL+wB97S9uYSj8UVKIq70HqplQDMoqRP1+FrpYkEWQAQ8swHDI
	SF9NAqqJkIsVP7HapXELkl9VTe6o0xG5XT24axc6DtTR2NySKiWb34HoHLp21EbyHoFodEG8l+i5z
	bJx/HR7Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48622 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sZpoY-0006F1-0F;
	Fri, 02 Aug 2024 11:47:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sZpoW-000eHZ-0d; Fri, 02 Aug 2024 11:47:12 +0100
In-Reply-To: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Halaney <ahalaney@redhat.com>,
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
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH net-next 09/14] net: stmmac: dwmac4: move PCS interrupt
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
Message-Id: <E1sZpoW-000eHZ-0d@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Aug 2024 11:47:12 +0100

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


