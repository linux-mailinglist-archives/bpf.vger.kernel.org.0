Return-Path: <bpf+bounces-36279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6418945C93
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84121C218B4
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC21DF661;
	Fri,  2 Aug 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DxKFsnXp"
X-Original-To: bpf@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4109114AD38;
	Fri,  2 Aug 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596181; cv=none; b=VHVz4hzYUjwp29cBE0PzNqOOtg1hht0+eMKODrFho4XXEoxQtHBxbKc7Ykhiae4uKWEznZQUUp+e14OmxczaJMGdCFJUjIzp1jPCgax3RUNjw8e6M54GFqqMfUTSgxEDfYQXaKRh5wlcBb8e90KVfy697Z1LrK9MXbc/LhrwvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596181; c=relaxed/simple;
	bh=NYFmOBdL9vyraCrXQYEEaZJ1lcQe7GYvJDQALMCBfng=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lqhzaRQUsfN1VV4HTuvQygoSfkic/6Xb1SLKduAaXszUJwQqEN4dK5hyN+Y14U/QSz3+Mhq+haLZFp/aoesuWKiwlHskMkFh5whaYi8oUrcadFYodxY90oxVBkeO1jF2VVFj9qw0RJ3eEBwSrOCjss5j/uCsIiIQ24h1YwH/ZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DxKFsnXp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BCL9SgQ/g7nSh4Zd8wOmWQ96bng4Q8TSEK3rpU47Mi0=; b=DxKFsnXp8sGTTutqn2Bi5W0BRf
	cbvSDj3tM0SE4DLz4cnIS1t6tYwzG6HJuOKHCZ0w9lmJU5To3WszLye/J1MexcXczZSh7Ts83QBC7
	XvNbWdU2FGf6Gmh7fppZuSwiBJzlXI9p43UETfEge0wsDtNcI3JxbFLpXqF1ZfU+goCI8C6v9rbCd
	oNJHmT/GjkogfPtpPJPcZNOxi9CzJ6mCRgxSCMub8M+57QDVCksLwKqlRjqEqraepaQZeohS9HI9M
	sMAKxSurY5vTE5xZRXr/rI6RH/pbKq0dUUppi5jFQw42gdvqlTwj8SlpLKk5+ebIbwH+JINKkRCJW
	4hWCcdrA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59784 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sZpom-0006Fd-1u;
	Fri, 02 Aug 2024 11:47:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sZpog-000eHn-8r; Fri, 02 Aug 2024 11:47:22 +0100
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
Subject: [PATCH net-next 11/14] net: stmmac: pass stmmac_pcs into
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
Message-Id: <E1sZpog-000eHn-8r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 02 Aug 2024 11:47:22 +0100

Pass the stmmac_pcs into dwmac_pcs_isr() so that we have the base
address of the PCS block available.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h     | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

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
index 083128e0013c..c73a08dab7b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -61,18 +61,18 @@
 
 /**
  * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
- * @ioaddr: IO registers pointer
+ * @spcs: pointer to &struct stmmac_pcs
  * @reg: Base address of the AN Control Register.
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


