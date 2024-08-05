Return-Path: <bpf+bounces-36384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA46C9479C6
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CC71C210B1
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8411B158D97;
	Mon,  5 Aug 2024 10:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nrAi9T3K"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816ED156F23;
	Mon,  5 Aug 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853542; cv=none; b=Rwza13gcgY0ik+iQEWQ33vl/VI8lfMirNf97opgQ2t75lNLwCXC+XMeJ6+jDXbmCHAoq6PRfzPf3z6NMHl1WYYp8m4Z2zdkk3TqDg9GynKOuZzsmWXgABp1ESUGjSdn0ejp6rkQ7tpHTdOA5KxTdhwmwoW9lKelFGwiC/B5AGNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853542; c=relaxed/simple;
	bh=3lMVKDG5oDXH8k929ws0Rs+RV9/H63yrH6hjGORBH38=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ANiYvrdtUZkpUwLmaz8+OGqpv4Zw3HjcKgsrQLgVptPsVibHP+Swv5H1gv4cNFc/wwHGDHcQE2/dJ7DY27sxCuSb3WmJUe0BP6wjbZHTeGC8OpMxXBiyuXFJvCsJQx1o/Dv2+Jea7Ik6v3l5rRsUJ5GXM4taWN5R8oaZooseCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nrAi9T3K; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WhtL3qsk9axj1Gl0RxMkRfi5RHBB6BIw22kNaTI9fyM=; b=nrAi9T3Kj+WOCwJl4nHVgRml/1
	uOLRp17iBfyjWGXG5+AhfuDvEIoZRy/069qtUfd5LMZadDOF3JwQKyIIReo9USztLqbvLFa4YSwbr
	iA2NRIN0tLh8huwQ3/a3Wi4VNMQpyi85eEw07dELPZl2ORZWdLs0wrF2OxurIcV2IKg0DwNNfCdT5
	OZnv0rCpuoW1CMwzCUXxriRjcJNlD76qeUGLHYqfty98pQ1p4nlguaDndJ56swNaM53yeHYXO55ut
	AQncFcza4HPc3YcGKCmajVLzKACHJbKxCb/ViTKawft0R6nXAWPfuFvEyKjSjPBF6VE9NgQtS5xz/
	0sr4xzfg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47334 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sauu8-0002eK-0R;
	Mon, 05 Aug 2024 11:25:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sauuC-000tvg-R6; Mon, 05 Aug 2024 11:25:32 +0100
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
Subject: [PATCH RFC net-next v4 11/14] net: stmmac: pass stmmac_pcs into
 dwmac_pcs_isr()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sauuC-000tvg-R6@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 05 Aug 2024 11:25:32 +0100

As the stmmac_pcs has the base address of the PCS registers, pass
this into dwmac_pcs_isr() to avoid recalculating the base address.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h     | 7 +++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index d2defa2e4996..2bed04403baa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -296,7 +296,7 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 			x->irq_rx_path_exit_lpi_mode_n++;
 	}
 
-	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
+	dwmac_pcs_isr(&hw->mac_pcs, intr_status, x);
 
 	if (intr_status & PCS_RGSMIIIS_IRQ) {
 		/* TODO Dummy-read to clear the IRQ status */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 2f02bb47c952..12b7b93ce71e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -873,7 +873,8 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 			x->irq_rx_path_exit_lpi_mode_n++;
 	}
 
-	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
+	dwmac_pcs_isr(&hw->mac_pcs, intr_status, x);
+
 	if (intr_status & PCS_RGSMIIIS_IRQ) {
 		/* TODO Dummy-read to clear the IRQ status */
 		readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 083128e0013c..48b635139fa5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -61,18 +61,17 @@
 
 /**
  * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
- * @ioaddr: IO registers pointer
- * @reg: Base address of the AN Control Register.
+ * @spcs: pointer to &struct stmmac_pcs
  * @intr_status: GMAC core interrupt status
  * @x: pointer to log these events as stats
  * Description: it is the ISR for PCS events: Auto-Negotiation Completed and
  * Link status.
  */
-static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
+static inline void dwmac_pcs_isr(struct stmmac_pcs *spcs,
 				 unsigned int intr_status,
 				 struct stmmac_extra_stats *x)
 {
-	u32 val = readl(ioaddr + GMAC_AN_STATUS(reg));
+	u32 val = readl(spcs->pcs_base + GMAC_AN_STATUS(0));
 
 	if (intr_status & PCS_ANE_IRQ) {
 		x->irq_pcs_ane_n++;
-- 
2.30.2


