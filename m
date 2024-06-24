Return-Path: <bpf+bounces-32907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDC914E88
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6C71F23158
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B961411CF;
	Mon, 24 Jun 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAdybOxs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81E914037D;
	Mon, 24 Jun 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235721; cv=none; b=otmRCx6RCDx8Bfld2e5CB25ebppZI8DCenQiqA86N/dwR2dRRbPgud2P0b8XzcIn2Q8Scq7+VkweTZSbBFQshmp0qDlw2eD0eR/Fuw5ZHjcv6tA2QjsWT2yfs/cA0hOKXsjkMXe98bkXCz8JYPGIZyzMP7+3Mc5vGKFhbNNOeFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235721; c=relaxed/simple;
	bh=vI3cfKqKf1N8tTHvEKRxUuZwgu8WSPzXmooGPm1f6zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/m6Dcjnu3htyk61u4EHlYaSMtsKnw+dAK9Nr1FFOr8evJq4WSZYK3Z5bjxOWL8aJoUDek5sjkFT/6odqDR4S5kQlNV7ibjD//zOMsAAHoifOu9AH5mXTDuy1InGpy7uyp1H6p7G39FM6d1paw3Q9oG72vL276RFDFvLcfDtmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAdybOxs; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ce0140416so1846993e87.0;
        Mon, 24 Jun 2024 06:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235718; x=1719840518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7Ol19BJCD3Qqon4hRuLkjL5PVBIRDIZpTfM6qDSNSQ=;
        b=FAdybOxsZ7H+svXGAGu0707p40gUA3vjtvEqgjhXirp0DhgBSl4UXL01dA2CMdrIFu
         NU1UXkgSM/Od6qOXu327pMfJq69xQ5eI24rmmHmzZLaxWv8Q1yzqtQ5Gqu/dH32+2Rw2
         t2bVNAhi2guK1EbaitGGjEdb8tLGfaNR5s47ZEBHTV87ygRbiDgfLmN3vx9Z5UnOtEpN
         HcO37RCvOnbdZqHJo/UUeXkhgTYXT/Zdc87uhmAsD8yEM/FHqUwPK1xFaTLXFf75mL0J
         p0HA5+CM/p+N6rNZT0DZ8JvYOzgSWkyhihapWySrybREMs8hjN2ZqMz7Kr5DNVzmVMUs
         rCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235718; x=1719840518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7Ol19BJCD3Qqon4hRuLkjL5PVBIRDIZpTfM6qDSNSQ=;
        b=CprZSNdmD4StfBfmBIJhbMq19JbrrHGWqLtnxW1L3v7aGMt/LVem2XMIUQ88XFs7eN
         IbR3NG+UF8zkpTRMhWznslyHw731FF5Lb3YXM20zzuQRLhHbCqBQ8BklbmyyVlz/aLK+
         OwsQYAzGt1iM05tlXXNbo+0qDQbttrQPBY++h7KogtVOhl/zYBij9NZgBQ3vsgSBsYjm
         j6bSU4i3+F2DWQSDwTinC8DXWPto/amXjfiOfkbVTGeq5XQw3z8INENny4MGBMAqB5Il
         nwjOGTPZ0te4tzL01RzL870yPEt/zgSsVNf2bJy71rnfiQSyGYu/iphhTXkJ7a9HuFxY
         TTjg==
X-Forwarded-Encrypted: i=1; AJvYcCXnbIvdrFbtltrWYWpySSVWgz6WnKBmbOXPVae83VNCSBQhu3SLYvgG6odmqs4hGghDoQjCfJGbuGTgqMRESArvQBgSbDfE/da6Vim3xDZQzuhqM8mQn9E2AAdG40q9DJSAExS1vAHpGj25hLw4X6veLaif9Guylyoo
X-Gm-Message-State: AOJu0Yzpaf4179J/sKVhYJpO+m9OphSkfazYDS1csVVbhd8lJRgwwXvo
	9BeGcqrM6Y0/j7eVNlSLwf5QbiBybcPlbRXI/2Q0+yJK8Po7oPOh
X-Google-Smtp-Source: AGHT+IFCP0Abnl0ON1YlKTZpmLSz+wWOfdf3+G3qM0oG3CK0Ou7QI39akcE1gEBgfNlx61R5C1552w==
X-Received: by 2002:a05:6512:3d10:b0:52c:e326:f4cf with SMTP id 2adb3069b0e04-52ce326f5e4mr3905981e87.3.1719235717804;
        Mon, 24 Jun 2024 06:28:37 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cebd0985fsm48965e87.258.2024.06.24.06.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:37 -0700 (PDT)
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
Subject: [PATCH RFC net-next v2 12/17] net: stmmac: Introduce internal PCS IRQ enable/disable methods
Date: Mon, 24 Jun 2024 16:26:29 +0300
Message-ID: <20240624132802.14238-4-fancer.lancer@gmail.com>
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

The PCS IRQ enable/disable procedures have been utilized in the framework
of the PHYLINK PCS enable/disable callbacks. Since a generic STMMAC
PHYLINK PCS implementation is about to be introduced let's move the
procedures into the dedicated DW GMAC and DW QoS Eth HW-abstraction
methods. These methods will be called from the PCS enable/disable
functions defined in the stmmac_pcs.c in the DW MAC-independent manner.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 34 ++++++++++++-----
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 38 ++++++++++++++-----
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  6 +++
 3 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 1e50cc573407..99f0bbb318ec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -365,6 +365,26 @@ static void dwmac1000_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + LPI_TIMER_CTRL);
 }
 
+static void dwmac1000_pcs_enable_irq(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 intr_mask;
+
+	intr_mask = readl(ioaddr + GMAC_INT_MASK);
+	intr_mask &= ~GMAC_INT_DISABLE_PCS;
+	writel(intr_mask, ioaddr + GMAC_INT_MASK);
+}
+
+static void dwmac1000_pcs_disable_irq(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 intr_mask;
+
+	intr_mask = readl(ioaddr + GMAC_INT_MASK);
+	intr_mask |= GMAC_INT_DISABLE_PCS;
+	writel(intr_mask, ioaddr + GMAC_INT_MASK);
+}
+
 static u16 dwmac1000_pcs_get_config_reg(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -395,12 +415,8 @@ static int dwmac1000_mii_pcs_validate(struct phylink_pcs *pcs,
 static int dwmac1000_mii_pcs_enable(struct phylink_pcs *pcs)
 {
 	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-	void __iomem *ioaddr = hw->pcsr;
-	u32 intr_mask;
 
-	intr_mask = readl(ioaddr + GMAC_INT_MASK);
-	intr_mask &= ~GMAC_INT_DISABLE_PCS;
-	writel(intr_mask, ioaddr + GMAC_INT_MASK);
+	dwmac1000_pcs_enable_irq(hw);
 
 	return 0;
 }
@@ -408,12 +424,8 @@ static int dwmac1000_mii_pcs_enable(struct phylink_pcs *pcs)
 static void dwmac1000_mii_pcs_disable(struct phylink_pcs *pcs)
 {
 	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-	void __iomem *ioaddr = hw->pcsr;
-	u32 intr_mask;
 
-	intr_mask = readl(ioaddr + GMAC_INT_MASK);
-	intr_mask |= GMAC_INT_DISABLE_PCS;
-	writel(intr_mask, ioaddr + GMAC_INT_MASK);
+	dwmac1000_pcs_disable_irq(hw);
 }
 
 static int dwmac1000_mii_pcs_config(struct phylink_pcs *pcs,
@@ -578,6 +590,8 @@ const struct stmmac_ops dwmac1000_ops = {
 	.set_eee_timer = dwmac1000_set_eee_timer,
 	.set_eee_pls = dwmac1000_set_eee_pls,
 	.debug = dwmac1000_debug,
+	.pcs_enable_irq = dwmac1000_pcs_enable_irq,
+	.pcs_disable_irq = dwmac1000_pcs_disable_irq,
 	.pcs_get_config_reg = dwmac1000_pcs_get_config_reg,
 	.pcs_ctrl_ane = dwmac1000_ctrl_ane,
 	.set_mac_loopback = dwmac1000_set_mac_loopback,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index b7db076b4214..5dc8d59d3a8f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -456,6 +456,26 @@ static void dwmac4_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + GMAC4_LPI_TIMER_CTRL);
 }
 
+static void dwmac4_pcs_enable_irq(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 intr_enable;
+
+	intr_enable = readl(ioaddr + GMAC_INT_EN);
+	intr_enable |= GMAC_PCS_IRQ_DEFAULT;
+	writel(intr_enable, ioaddr + GMAC_INT_EN);
+}
+
+static void dwmac4_pcs_disable_irq(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 intr_enable;
+
+	intr_enable = readl(ioaddr + GMAC_INT_EN);
+	intr_enable &= ~GMAC_PCS_IRQ_DEFAULT;
+	writel(intr_enable, ioaddr + GMAC_INT_EN);
+}
+
 static u16 dwmac4_pcs_get_config_reg(struct mac_device_info *hw)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -780,12 +800,8 @@ static int dwmac4_mii_pcs_validate(struct phylink_pcs *pcs,
 static int dwmac4_mii_pcs_enable(struct phylink_pcs *pcs)
 {
 	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-	void __iomem *ioaddr = hw->pcsr;
-	u32 intr_enable;
 
-	intr_enable = readl(ioaddr + GMAC_INT_EN);
-	intr_enable |= GMAC_PCS_IRQ_DEFAULT;
-	writel(intr_enable, ioaddr + GMAC_INT_EN);
+	dwmac4_pcs_enable_irq(hw);
 
 	return 0;
 }
@@ -793,12 +809,8 @@ static int dwmac4_mii_pcs_enable(struct phylink_pcs *pcs)
 static void dwmac4_mii_pcs_disable(struct phylink_pcs *pcs)
 {
 	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
-	void __iomem *ioaddr = hw->pcsr;
-	u32 intr_enable;
 
-	intr_enable = readl(ioaddr + GMAC_INT_EN);
-	intr_enable &= ~GMAC_PCS_IRQ_DEFAULT;
-	writel(intr_enable, ioaddr + GMAC_INT_EN);
+	dwmac4_pcs_disable_irq(hw);
 }
 
 static int dwmac4_mii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
@@ -1284,6 +1296,8 @@ const struct stmmac_ops dwmac4_ops = {
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
 	.debug = dwmac4_debug,
+	.pcs_enable_irq = dwmac4_pcs_enable_irq,
+	.pcs_disable_irq = dwmac4_pcs_disable_irq,
 	.pcs_get_config_reg = dwmac4_pcs_get_config_reg,
 	.set_filter = dwmac4_set_filter,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
@@ -1329,6 +1343,8 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
 	.debug = dwmac4_debug,
+	.pcs_enable_irq = dwmac4_pcs_enable_irq,
+	.pcs_disable_irq = dwmac4_pcs_disable_irq,
 	.pcs_get_config_reg = dwmac4_pcs_get_config_reg,
 	.set_filter = dwmac4_set_filter,
 	.flex_pps_config = dwmac5_flex_pps_config,
@@ -1378,6 +1394,8 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
 	.debug = dwmac4_debug,
+	.pcs_enable_irq = dwmac4_pcs_enable_irq,
+	.pcs_disable_irq = dwmac4_pcs_disable_irq,
 	.pcs_get_config_reg = dwmac4_pcs_get_config_reg,
 	.set_filter = dwmac4_set_filter,
 	.safety_feat_config = dwmac5_safety_feat_config,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 00995a0c9813..2caa946a92f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -376,6 +376,8 @@ struct stmmac_ops {
 		      struct stmmac_extra_stats *x, u32 rx_queues,
 		      u32 tx_queues);
 	/* PCS calls */
+	void (*pcs_enable_irq)(struct mac_device_info *hw);
+	void (*pcs_disable_irq)(struct mac_device_info *hw);
 	u16 (*pcs_get_config_reg)(struct mac_device_info *hw);
 	void (*pcs_ctrl_ane)(void __iomem *pcsaddr, bool ane, bool srgmi_ral,
 			     bool loopback);
@@ -493,6 +495,10 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, set_eee_pls, __args)
 #define stmmac_mac_debug(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, debug, __priv, __args)
+#define stmmac_pcs_enable_irq(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, pcs_enable_irq, __args)
+#define stmmac_pcs_disable_irq(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, pcs_disable_irq, __args)
 #define stmmac_pcs_get_config_reg(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, pcs_get_config_reg, __args)
 #define stmmac_pcs_ctrl_ane(__priv, __args...) \
-- 
2.43.0


