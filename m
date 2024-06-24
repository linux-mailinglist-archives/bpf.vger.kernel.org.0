Return-Path: <bpf+bounces-32910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DF3914E93
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5479F1F221D6
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707813E05B;
	Mon, 24 Jun 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz2fAfbo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5E1428E5;
	Mon, 24 Jun 2024 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235728; cv=none; b=Xg737ZfKka9OHPKrm1pAUfsyy2xpJbEmTvcm2/MRkX0kaV+ROxeLJUw3mhiWEFftiaH2T1V6NO8aMC04BJ45THF9MZ3lWf0PYG8mFwJo3flP29CBzyhnG2WzVjI3taRRUoOvnoGYFEJ3URD+M5Kvlty1ok3qvMEVl3ybzNFxJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235728; c=relaxed/simple;
	bh=H/nRiRhNGNJ+A+zOcP60AClklxPQ/DRXk8bhOo1X1GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvThw0PASavEy7/fQUDmCKw5fAkV3gnPqrHgft2GNA1k/6GM4NenJwEGL6JC2a+9WUEpu46VAPK2LcH0/Mofv8ikz7czpACY9OXnQCQ460guOJ/HyPwfeYmhXi14khsLzbhkOYlNg8+u/lbTuFaUK7PbXmYQUtmmyPnRag8JPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz2fAfbo; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ce0140416so1847183e87.0;
        Mon, 24 Jun 2024 06:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235725; x=1719840525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SJ6K00RddygxsRAx5gvfJ+FOJjztoTh+Z/C1WD5C9E=;
        b=Oz2fAfboLN1fDckGL6kW1UNCdsK+RRrXWqg91I2QCTB6xlnZC+1+GxDRlJ4CAqhTId
         OiFPGR4geiXv10MW9hXHeYmDeQu9SWx24BNXZ6EYEuQqn6qmBTg3yBLMsgFIw9WpjZnW
         DGTuQjqbjVhL6vobWlFPWt0yFpwKgn2Few3ft89g4AMnPFD8KUq9D4SmS3qbT67ExVSD
         KuHXZltYJBRKdGsKOb0GZrS91S4BKmdF5I+K+RFythCrfs9fCkXm9jc73b7Xb7rHc6pD
         wwUKqwBmNQ0S0fJla+JDWOM3Gwy4JyNryWrPxa+29sROG7qsrcROcPiLYUDYu3cLx9yO
         gcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235725; x=1719840525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SJ6K00RddygxsRAx5gvfJ+FOJjztoTh+Z/C1WD5C9E=;
        b=UM0LSgNq8V4ltpuXgOKXsyZFO4VjccmzH6xNerOb9Nqex4Ry3FtTHcRb2Tnbcyt2Xq
         gx5niTdI4wERfuo5kTKNums3YShfd5jEL0/NzQojDHNsZoJq0BmtaPRgBFghCgp1sLhk
         X5dYSeAttcg71pohC8qL4J5FV1Tf2pG4bUxKlWYvCsb8W6ys+bTI02IQ59LF1RkcTHzx
         XcfCWdYSpEbxjGEe9ddIe6WKUQe8PByxjuow8DpThUQ0/DWzjhLznGT105pKXMJ0pAIQ
         lBkLMh1qmKL5eDFY5XxQG8dYj5KOL5K8B68Ag5FvmpaK3Yk3E6NbNg3hF/SjnnVTX1Mf
         a5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW7eijgdSKLduyYH8CRZ2TSsTXUPSKve+O/jT5cF5d5/2UshpGKEp6vC1OwpQcDL7f92QUMNtdMEAzbx8yPxLSnJJNhwCR1sjanGv01InaA4r3d2QpcL72xhf5bH+8yg1WO3vuMcsGsU95BJ0coAKDmlSYYxWin3H5p
X-Gm-Message-State: AOJu0YxYJW7/CJxc0auCPc2uOqLaobNNrQEjICQBAqDJLPL5Iwl1AxcL
	HawJfzEb3OWwiCRNGwijfcSWr/TwiYkrxxr+0ZAQN1sJrM3fsdrJ
X-Google-Smtp-Source: AGHT+IH0GO4PBGc5Gd3PGuDIANu9HTgigG+8VkYo1wUOWDrul73npApHt9lg7dmWYbZTxCAcThzWtg==
X-Received: by 2002:a2e:6a02:0:b0:2e1:2169:a5cc with SMTP id 38308e7fff4ca-2ec5931d8c3mr36751081fa.15.1719235724924;
        Mon, 24 Jun 2024 06:28:44 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d602703sm9729211fa.4.2024.06.24.06.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:44 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 15/17] net: stmmac: Move internal PCS ISR to stmmac_pcs.c
Date: Mon, 24 Jun 2024 16:26:32 +0300
Message-ID: <20240624132802.14238-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to the PHYLINK PCS ops, the STMMAC PCS ISR can be now fully
implemented in the stmmac_pcs.c file. As before this change the resultant
method will be called from the DW GMAC and DW QoS Eth core interrupt
handlers.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note the AN Complete and Link state changes now cause the PHYLINK PCS
state update.
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  9 +----
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  9 +----
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 33 +++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 31 ++---------------
 4 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 332018ecd624..2d77ffd16f0a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -296,14 +296,7 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 			x->irq_rx_path_exit_lpi_mode_n++;
 	}
 
-	dwmac_pcs_isr(hw->priv->pcsaddr, intr_status, x);
-
-	if (intr_status & PCS_RGSMIIIS_IRQ) {
-		/* TODO Dummy-read to clear the IRQ status */
-		readl(ioaddr + GMAC_RGSMIIIS);
-		phylink_pcs_change(&hw->mac_pcs, false);
-		x->irq_rgmii_n++;
-	}
+	dwmac_pcs_isr(hw, intr_status, x);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 1487f5cc5249..c58dc20eddeb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -860,14 +860,7 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 			x->irq_rx_path_exit_lpi_mode_n++;
 	}
 
-	dwmac_pcs_isr(hw->priv->pcsaddr, intr_status, x);
-
-	if (intr_status & PCS_RGSMIIIS_IRQ) {
-		/* TODO Dummy-read to clear the IRQ status */
-		readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
-		phylink_pcs_change(&hw->mac_pcs, false);
-		x->irq_rgmii_n++;
-	}
+	dwmac_pcs_isr(hw, intr_status, x);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 24b95d1fdb64..aac49f6472f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -134,3 +134,36 @@ const struct phylink_pcs_ops dwmac_pcs_ops = {
 	.pcs_get_state = dwmac_pcs_get_state,
 
 };
+
+void dwmac_pcs_isr(struct mac_device_info *hw, unsigned int intr_status,
+		   struct stmmac_extra_stats *x)
+{
+	struct stmmac_priv *priv = hw->priv;
+	bool an_status = false, sr_status = false;
+
+	if (intr_status & PCS_ANE_IRQ) {
+		x->irq_pcs_ane_n++;
+		an_status = true;
+	}
+
+	if (intr_status & PCS_LINK_IRQ) {
+		x->irq_pcs_link_n++;
+		an_status = true;
+	}
+
+	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		x->irq_rgmii_n++;
+		sr_status = true;
+	}
+
+	/* Read the AN and SGMII/RGMII/SMII status regs to clear IRQ */
+	if (an_status)
+		readl(priv->pcsaddr + PCS_AN_STATUS);
+
+	if (sr_status)
+		readl(priv->pcsaddr + PCS_SRGMII_CSR);
+
+	/* Any PCS event shall trigger the PHYLINK PCS state update */
+	if (an_status || sr_status)
+		phylink_pcs_change(&hw->mac_pcs, false);
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 2baebb92bea7..6e364285a4ef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -23,6 +23,7 @@
 #define PCS_ANE_LPA		0x0c		/* ANE link partener ability */
 #define PCS_ANE_EXP		0x10		/* ANE expansion */
 #define PCS_TBI_EXT		0x14		/* TBI extended status */
+#define PCS_SRGMII_CSR		0x18		/* SGMII/RGMII/SMII CSR */
 
 /* AN Configuration defines */
 #define PCS_AN_CTRL_RAN		BIT(9)		/* Restart Auto-Negotiation */
@@ -57,33 +58,7 @@
 #define PCS_CFG_JABTO		BIT(4)		/* Jabber Timeout (SMII only) */
 #define PCS_CFG_FALSCARDET	BIT(5)		/* False Carrier (SMII only) */
 
-/**
- * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
- * @ioaddr: IO registers pointer
- * @intr_status: GMAC core interrupt status
- * @x: pointer to log these events as stats
- * Description: it is the ISR for PCS events: Auto-Negotiation Completed and
- * Link status.
- */
-static inline void dwmac_pcs_isr(void __iomem *pcsaddr,
-				 unsigned int intr_status,
-				 struct stmmac_extra_stats *x)
-{
-	u32 val = readl(pcsaddr + PCS_AN_STATUS);
-
-	if (intr_status & PCS_ANE_IRQ) {
-		x->irq_pcs_ane_n++;
-		if (val & PCS_AN_STATUS_ANC)
-			pr_info("stmmac_pcs: ANE process completed\n");
-	}
-
-	if (intr_status & PCS_LINK_IRQ) {
-		x->irq_pcs_link_n++;
-		if (val & PCS_AN_STATUS_LS)
-			pr_info("stmmac_pcs: Link Up\n");
-		else
-			pr_info("stmmac_pcs: Link Down\n");
-	}
-}
+void dwmac_pcs_isr(struct mac_device_info *hw, unsigned int intr_status,
+		   struct stmmac_extra_stats *x);
 
 #endif /* __STMMAC_PCS_H__ */
-- 
2.43.0


