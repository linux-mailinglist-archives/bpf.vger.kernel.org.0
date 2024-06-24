Return-Path: <bpf+bounces-32905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2A0914E80
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 15:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530871C2094C
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D013FD66;
	Mon, 24 Jun 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDZGdJx2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3313EFE3;
	Mon, 24 Jun 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235717; cv=none; b=W1tZXlvolzLR92rerQO7OmAtPwamBSL2kyELGAmqTwidtziDdEokFIZ73fAYwMiLVBVhqx/XKr27SuosDDnjV9XjAD/U7KBkHT1y5vll6YoYjWxZcQ6zaVCFoKZ2oH0mCGLfZNYSv2sBOz3i2BS8WH9epscdIEELRKMHVDVciGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235717; c=relaxed/simple;
	bh=m+ybhBYefVRdgGupMoNJhaFAMLZk7REyA7vo4OfMHq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5X7Qj1lPhhcQAli3gRgsycHY/r9Upyb4lC0ZQzmDF3euVLBGq6/Es6cRXSqLB0tqkD9lQrylu/q5iKKgSEGuWZTXw6fGT5+6Ih+ibb4GbbdPe9IP5/Bt201EDObF0fOSv8bTEbtNjExBtmM3PIGkI72qbJeQAaDsQgpUhOsMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDZGdJx2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5295eb47b48so5099726e87.1;
        Mon, 24 Jun 2024 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719235713; x=1719840513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBRZg7O8NUfGqtDS+Z7CLeIhfmvXkPJ6rvrljuz9exI=;
        b=BDZGdJx2wVnezRfvuu0FDOGlohUiK6LT36BYaUXwAudJv+Te0yhpDwbBS1AieWVGky
         BdOjqHNyAmZyehczBw5naKMu/P6y2Eb5rJA2QWXGqR27FI1hMkykCMbbw3GSnbxjtdtD
         gYE5SDiLekT5FQ9EXxjHJIm6V7meuKbwHRqoJgknykrHpDzsP2vm2//3i5j/kmawHN0L
         BuBO4sPB/dN9W35exrlu6JLWKUltw2ewkycj/INbJShdm3ESvzmjvu3KeT8H5Zh2cEC0
         19BK9fPeq9Wn2kyzhHcRUOejBzwfsjsecmlH2BHpMKHXTY70PeTt08EQlmOyJKYhzD2s
         8reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235713; x=1719840513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBRZg7O8NUfGqtDS+Z7CLeIhfmvXkPJ6rvrljuz9exI=;
        b=UG6SAVS8pzqTUJsS3mdQtXj8wI56hFU8mq1NziiweV3cAqF2iRftQFN7xOOAGPukWP
         ygGo+eI/r+99lXW/1ggo4RH/BeSVKQSKiLvgAZj2LALrZl9PBBrHuD5W/qrU5cGo2WME
         7bzZ5oNlS6Gt5BTze/GWCda9Y2l8hS2IJPC+32RsIDOtrEPjouLQ0rfU90U9cKEk4htr
         bSbIOjpqlcZz1EM63ywSH2rlACp0a3BZ7Qy5ikORX2c+3E30EXz6GV7C/uCRwIXuWjny
         rdHmtB1iF4OHyooUzFYOSuGkSL95h5RbEI5p0d5tN5tfTOe9z2QqgjE5rxVnIgDEHL0z
         5tlg==
X-Forwarded-Encrypted: i=1; AJvYcCWGpDFuUTozfokiElVfwquA9UTRY1E30ZlzYFpAalOyRkLSl2B0fHOKR9StrYAHeusAKOXWzepzC09Q67D09mBSOpXgBqofXGK5IBLUeJBlg2c5sfIO3KR6Y7vjqr8T4tnbqy0gkM25jFehc1CVJgYeRrqpVt0OrwwNFzimy6aGiY13ZPqDBdo7yJIVuNaYoFIIge3Pq81nnw==
X-Gm-Message-State: AOJu0YxwEU8wDJkcz6yoPKdP8Cuyi01Lqfww1LAGyaf2kAKfeaqR5abn
	45NG6krCyxhl/z7Y8FkgUKzA9oa3WuLXu+fbSZYFcJfO8yBbtkMV
X-Google-Smtp-Source: AGHT+IFJL5eRR4dwLd0ix3322JrLNkioz2/OwTWkrVNV55ws/qhEikb0xuP3NZJAldpr5iiFrBu+Lg==
X-Received: by 2002:a05:6512:114c:b0:52c:ebd0:609 with SMTP id 2adb3069b0e04-52cebd006bdmr749138e87.7.1719235713165;
        Mon, 24 Jun 2024 06:28:33 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63bd28dsm989026e87.92.2024.06.24.06.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:28:32 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Halaney <ahalaney@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
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
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next v2 10/17] net: stmmac: Introduce internal PCS offset-based CSR access
Date: Mon, 24 Jun 2024 16:26:27 +0300
Message-ID: <20240624132802.14238-2-fancer.lancer@gmail.com>
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

Internal PCS module can be found on the DW GMAC v3.x and DW QoS Eth
IP-cores. The register space is almost identical except the base address
and the SGMII/RGMII/SMII Control and Status Register layout. Thus the
common PCS code could be set free from passing the PCS CSRs base address
by using the base calcultaed on the MAC-device info init stage. The same
approach has been utilized in the STMMAC MMC, PTP and EST modules.

Let's convert the PCS module to using it too by adding the PCS CSRs offset
declarations and the CSRs base address calculation for the detected
IP-core.

While at it replace the GMAC_ prefix with PCS_ to mark the common STMMAC
PCS macros in the same way as it's done in the mmc.h, stmmac_ptp.h and
stmmac_est.h for the respective common modules.

Note the phylink_pcs_ops instance has been defined empty for now. It will
be populated later upon the rest of the PCS-code movement to the
stmmac_pcs.c module.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  8 +-
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 11 ++-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 12 +--
 drivers/net/ethernet/stmicro/stmmac/hwif.c    | 14 ++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 30 ++++---
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 79 +++++++++----------
 8 files changed, 89 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 80eb72bc6311..d0bcebe87ee8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -633,7 +633,7 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
 			      RGMII_IO_MACRO_CONFIG2);
 		ethqos_set_serdes_speed(ethqos, SPEED_2500);
-		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 0, 0, 0);
+		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 0, 0, 0);
 		break;
 	case SPEED_1000:
 		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
@@ -641,12 +641,12 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
 			      RGMII_IO_MACRO_CONFIG2);
 		ethqos_set_serdes_speed(ethqos, SPEED_1000);
-		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
+		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
 		break;
 	case SPEED_100:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
 		ethqos_set_serdes_speed(ethqos, SPEED_1000);
-		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
+		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
 		break;
 	case SPEED_10:
 		val |= ETHQOS_MAC_CTRL_PORT_SEL;
@@ -656,7 +656,7 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 					 SGMII_10M_RX_CLK_DVDR),
 			      RGMII_IO_MACRO_CONFIG);
 		ethqos_set_serdes_speed(ethqos, SPEED_1000);
-		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, 0, 0);
+		stmmac_pcs_ctrl_ane(priv, priv->pcsaddr, 1, 0, 0);
 		break;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 3ba65ea3e46f..e525b92955b4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -296,7 +296,7 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 			x->irq_rx_path_exit_lpi_mode_n++;
 	}
 
-	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
+	dwmac_pcs_isr(hw->priv->pcsaddr, intr_status, x);
 
 	if (intr_status & PCS_RGSMIIIS_IRQ) {
 		/* TODO Dummy-read to clear the IRQ status */
@@ -365,10 +365,10 @@ static void dwmac1000_set_eee_timer(struct mac_device_info *hw, int ls, int tw)
 	writel(value, ioaddr + LPI_TIMER_CTRL);
 }
 
-static void dwmac1000_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
+static void dwmac1000_ctrl_ane(void __iomem *pcsaddr, bool ane, bool srgmi_ral,
 			       bool loopback)
 {
-	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
+	dwmac_ctrl_ane(pcsaddr, ane, srgmi_ral, loopback);
 }
 
 static int dwmac1000_mii_pcs_validate(struct phylink_pcs *pcs,
@@ -414,8 +414,7 @@ static int dwmac1000_mii_pcs_config(struct phylink_pcs *pcs,
 {
 	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
 
-	return dwmac_pcs_config(hw, neg_mode, interface, advertising,
-				GMAC_PCS_BASE);
+	return dwmac_pcs_config(hw, neg_mode, advertising, advertising);
 }
 
 static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
@@ -442,7 +441,7 @@ static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
 	state->duplex = status & GMAC_RGSMIIIS_LNKMOD_MASK ?
 			DUPLEX_FULL : DUPLEX_HALF;
 
-	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
+	dwmac_pcs_get_state(hw, state);
 }
 
 static const struct phylink_pcs_ops dwmac1000_mii_pcs_ops = {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 5cf2a6cb8f66..e51c95732bad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -750,10 +750,10 @@ static void dwmac4_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 	}
 }
 
-static void dwmac4_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
+static void dwmac4_ctrl_ane(void __iomem *pcsaddr, bool ane, bool srgmi_ral,
 			    bool loopback)
 {
-	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
+	dwmac_ctrl_ane(pcsaddr, ane, srgmi_ral, loopback);
 }
 
 static int dwmac4_mii_pcs_validate(struct phylink_pcs *pcs,
@@ -798,8 +798,7 @@ static int dwmac4_mii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 {
 	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
 
-	return dwmac_pcs_config(hw, neg_mode, interface, advertising,
-				GMAC_PCS_BASE);
+	return dwmac_pcs_config(hw, advertising, interface, advertising);
 }
 
 static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
@@ -833,7 +832,7 @@ static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
 	state->duplex = status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK ?
 			DUPLEX_FULL : DUPLEX_HALF;
 
-	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
+	dwmac_pcs_get_state(hw, state);
 }
 
 static const struct phylink_pcs_ops dwmac4_mii_pcs_ops = {
@@ -924,7 +923,8 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 			x->irq_rx_path_exit_lpi_mode_n++;
 	}
 
-	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
+	dwmac_pcs_isr(hw->priv->pcsaddr, intr_status, x);
+
 	if (intr_status & PCS_RGSMIIIS_IRQ) {
 		/* TODO Dummy-read to clear the IRQ status */
 		readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 84fd57b76fad..3666893acb69 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -6,6 +6,7 @@
 
 #include "common.h"
 #include "stmmac.h"
+#include "stmmac_pcs.h"
 #include "stmmac_ptp.h"
 #include "stmmac_est.h"
 
@@ -116,6 +117,7 @@ static const struct stmmac_hwif_entry {
 	const void *tc;
 	const void *mmc;
 	const void *est;
+	const void *pcs;
 	int (*setup)(struct stmmac_priv *priv);
 	int (*quirks)(struct stmmac_priv *priv);
 } stmmac_hw[] = {
@@ -144,12 +146,14 @@ static const struct stmmac_hwif_entry {
 		.xgmac = false,
 		.min_id = 0,
 		.regs = {
+			.pcs_off = PCS_GMAC3_X_OFFSET,
 			.ptp_off = PTP_GMAC3_X_OFFSET,
 			.mmc_off = MMC_GMAC3_X_OFFSET,
 		},
 		.desc = NULL,
 		.dma = &dwmac1000_dma_ops,
 		.mac = &dwmac1000_ops,
+		.pcs = &dwmac_pcs_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.mode = NULL,
 		.tc = NULL,
@@ -162,6 +166,7 @@ static const struct stmmac_hwif_entry {
 		.xgmac = false,
 		.min_id = 0,
 		.regs = {
+			.pcs_off = PCS_GMAC4_OFFSET,
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
@@ -169,6 +174,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac4_ops,
+		.pcs = &dwmac_pcs_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.mode = NULL,
 		.tc = &dwmac510_tc_ops,
@@ -182,6 +188,7 @@ static const struct stmmac_hwif_entry {
 		.xgmac = false,
 		.min_id = DWMAC_CORE_4_00,
 		.regs = {
+			.pcs_off = PCS_GMAC4_OFFSET,
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
@@ -189,6 +196,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac4_dma_ops,
 		.mac = &dwmac410_ops,
+		.pcs = &dwmac_pcs_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
@@ -202,6 +210,7 @@ static const struct stmmac_hwif_entry {
 		.xgmac = false,
 		.min_id = DWMAC_CORE_4_10,
 		.regs = {
+			.pcs_off = PCS_GMAC4_OFFSET,
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
@@ -209,6 +218,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac410_ops,
+		.pcs = &dwmac_pcs_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
@@ -222,6 +232,7 @@ static const struct stmmac_hwif_entry {
 		.xgmac = false,
 		.min_id = DWMAC_CORE_5_10,
 		.regs = {
+			.pcs_off = PCS_GMAC4_OFFSET,
 			.ptp_off = PTP_GMAC4_OFFSET,
 			.mmc_off = MMC_GMAC4_OFFSET,
 			.est_off = EST_GMAC4_OFFSET,
@@ -229,6 +240,7 @@ static const struct stmmac_hwif_entry {
 		.desc = &dwmac4_desc_ops,
 		.dma = &dwmac410_dma_ops,
 		.mac = &dwmac510_ops,
+		.pcs = &dwmac_pcs_ops,
 		.hwtimestamp = &stmmac_ptp,
 		.mode = &dwmac4_ring_mode_ops,
 		.tc = &dwmac510_tc_ops,
@@ -356,6 +368,8 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		priv->hw = mac;
 		priv->ptpaddr = priv->ioaddr + entry->regs.ptp_off;
 		priv->mmcaddr = priv->ioaddr + entry->regs.mmc_off;
+		if (entry->pcs)
+			priv->pcsaddr = priv->ioaddr + entry->regs.pcs_off;
 		if (entry->est)
 			priv->estaddr = priv->ioaddr + entry->regs.est_off;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 8a17e7d6e37d..ba930a87b71a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -376,7 +376,7 @@ struct stmmac_ops {
 		      struct stmmac_extra_stats *x, u32 rx_queues,
 		      u32 tx_queues);
 	/* PCS calls */
-	void (*pcs_ctrl_ane)(void __iomem *ioaddr, bool ane, bool srgmi_ral,
+	void (*pcs_ctrl_ane)(void __iomem *pcsaddr, bool ane, bool srgmi_ral,
 			     bool loopback);
 	/* Safety Features */
 	int (*safety_feat_config)(void __iomem *ioaddr, unsigned int asp,
@@ -670,6 +670,7 @@ struct stmmac_est_ops {
 	stmmac_do_void_callback(__priv, est, irq_status, __args)
 
 struct stmmac_regs_off {
+	u32 pcs_off;
 	u32 ptp_off;
 	u32 mmc_off;
 	u32 est_off;
@@ -692,6 +693,7 @@ extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 extern const struct stmmac_mmc_ops dwmac_mmc_ops;
 extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
 extern const struct stmmac_est_ops dwmac510_est_ops;
+extern const struct phylink_pcs_ops dwmac_pcs_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b23b920eedb1..8091d162545a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -312,6 +312,7 @@ struct stmmac_priv {
 	struct mutex aux_ts_lock;
 	wait_queue_head_t tstamp_busy_wait;
 
+	void __iomem *pcsaddr;
 	void __iomem *mmcaddr;
 	void __iomem *ptpaddr;
 	void __iomem *estaddr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 849e6f121505..41b99f7e36e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -3,35 +3,35 @@
 
 int dwmac_pcs_config(struct mac_device_info *hw, unsigned int neg_mode,
 		     phy_interface_t interface,
-		     const unsigned long *advertising,
-		     unsigned int reg_base)
+		     const unsigned long *advertising)
 {
+	struct stmmac_priv *priv = hw->priv;
 	u32 val;
 
-	val = readl(hw->pcsr + GMAC_AN_CTRL(reg_base));
+	val = readl(priv->pcsaddr + PCS_AN_CTRL);
 
-	val |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
+	val |= PCS_AN_CTRL_ANE | PCS_AN_CTRL_RAN;
 
 	if (hw->ps)
-		val |= GMAC_AN_CTRL_SGMRAL;
+		val |= PCS_AN_CTRL_SGMRAL;
 
-	writel(val, hw->pcsr + GMAC_AN_CTRL(reg_base));
+	writel(val, priv->pcsaddr + PCS_AN_CTRL);
 
 	return 0;
 }
 
 void dwmac_pcs_get_state(struct mac_device_info *hw,
-			 struct phylink_link_state *state,
-			 unsigned int reg_base)
+			 struct phylink_link_state *state)
 {
+	struct stmmac_priv *priv = hw->priv;
 	u32 val;
 
-	val = readl(hw->pcsr + GMAC_ANE_LPA(reg_base));
+	val = readl(priv->pcsaddr + PCS_ANE_LPA);
 
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 			 state->lp_advertising);
 
-	if (val & GMAC_ANE_FD) {
+	if (val & PCS_ANE_FD) {
 		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
 				 state->lp_advertising);
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
@@ -40,7 +40,7 @@ void dwmac_pcs_get_state(struct mac_device_info *hw,
 				 state->lp_advertising);
 	}
 
-	if (val & GMAC_ANE_HD) {
+	if (val & PCS_ANE_HD) {
 		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
 				 state->lp_advertising);
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
@@ -49,10 +49,14 @@ void dwmac_pcs_get_state(struct mac_device_info *hw,
 				 state->lp_advertising);
 	}
 
+	/* TODO Make sure that STMMAC_PCS_PAUSE STMMAC_PCS_ASYM_PAUSE usage is legitimate */
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
 			 state->lp_advertising,
-			 FIELD_GET(GMAC_ANE_PSE, val) & STMMAC_PCS_PAUSE);
+			 FIELD_GET(PCS_ANE_PSE, val) & STMMAC_PCS_PAUSE);
 	linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
 			 state->lp_advertising,
-			 FIELD_GET(GMAC_ANE_PSE, val) & STMMAC_PCS_ASYM_PAUSE);
+			 FIELD_GET(PCS_ANE_PSE, val) & STMMAC_PCS_ASYM_PAUSE);
 }
+
+const struct phylink_pcs_ops dwmac_pcs_ops = {
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 27ea7f4d789d..62be3921ac91 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -13,61 +13,63 @@
 #include <linux/io.h>
 #include "common.h"
 
+#define PCS_GMAC4_OFFSET		0x000000e0
+#define PCS_GMAC3_X_OFFSET		0x000000c0
+
 /* PCS registers (AN/TBI/SGMII/RGMII) offsets */
-#define GMAC_AN_CTRL(x)		(x)		/* AN control */
-#define GMAC_AN_STATUS(x)	(x + 0x4)	/* AN status */
-#define GMAC_ANE_ADV(x)		(x + 0x8)	/* ANE Advertisement */
-#define GMAC_ANE_LPA(x)		(x + 0xc)	/* ANE link partener ability */
-#define GMAC_ANE_EXP(x)		(x + 0x10)	/* ANE expansion */
-#define GMAC_TBI(x)		(x + 0x14)	/* TBI extend status */
+#define PCS_AN_CTRL		0x00		/* AN control */
+#define PCS_AN_STATUS		0x04		/* AN status */
+#define PCS_ANE_ADV		0x08		/* ANE Advertisement */
+#define PCS_ANE_LPA		0x0c		/* ANE link partener ability */
+#define PCS_ANE_EXP		0x10		/* ANE expansion */
+#define PCS_TBI_EXT		0x14		/* TBI extended status */
 
 /* AN Configuration defines */
-#define GMAC_AN_CTRL_RAN	BIT(9)	/* Restart Auto-Negotiation */
-#define GMAC_AN_CTRL_ANE	BIT(12)	/* Auto-Negotiation Enable */
-#define GMAC_AN_CTRL_ELE	BIT(14)	/* External Loopback Enable */
-#define GMAC_AN_CTRL_ECD	BIT(16)	/* Enable Comma Detect */
-#define GMAC_AN_CTRL_LR		BIT(17)	/* Lock to Reference */
-#define GMAC_AN_CTRL_SGMRAL	BIT(18)	/* SGMII RAL Control */
+#define PCS_AN_CTRL_RAN		BIT(9)		/* Restart Auto-Negotiation */
+#define PCS_AN_CTRL_ANE		BIT(12)		/* Auto-Negotiation Enable */
+#define PCS_AN_CTRL_ELE		BIT(14)		/* External Loopback Enable */
+#define PCS_AN_CTRL_ECD		BIT(16)		/* Enable Comma Detect */
+#define PCS_AN_CTRL_LR		BIT(17)		/* Lock to Reference */
+#define PCS_AN_CTRL_SGMRAL	BIT(18)		/* SGMII RAL Control */
 
 /* AN Status defines */
-#define GMAC_AN_STATUS_LS	BIT(2)	/* Link Status 0:down 1:up */
-#define GMAC_AN_STATUS_ANA	BIT(3)	/* Auto-Negotiation Ability */
-#define GMAC_AN_STATUS_ANC	BIT(5)	/* Auto-Negotiation Complete */
-#define GMAC_AN_STATUS_ES	BIT(8)	/* Extended Status */
+#define PCS_AN_STATUS_LS	BIT(2)		/* Link Status 0:down 1:up */
+#define PCS_AN_STATUS_ANA	BIT(3)		/* Auto-Negotiation Ability */
+#define PCS_AN_STATUS_ANC	BIT(5)		/* Auto-Negotiation Complete */
+#define PCS_AN_STATUS_ES	BIT(8)		/* Extended Status Ability */
 
 /* ADV and LPA defines */
-#define GMAC_ANE_FD		BIT(5)
-#define GMAC_ANE_HD		BIT(6)
-#define GMAC_ANE_PSE		GENMASK(8, 7)
-#define GMAC_ANE_PSE_SHIFT	7
-#define GMAC_ANE_RFE		GENMASK(13, 12)
-#define GMAC_ANE_RFE_SHIFT	12
-#define GMAC_ANE_ACK		BIT(14)
+#define PCS_ANE_FD		BIT(5)		/* AN Full-duplex flag */
+#define PCS_ANE_HD		BIT(6)		/* AN Half-duplex flag */
+#define PCS_ANE_PSE		GENMASK(8, 7)	/* AN Pause Encoding */
+#define PCS_ANE_PSE_SHIFT	7
+#define PCS_ANE_RFE		GENMASK(13, 12)	/* AN Remote Fault Encoding */
+#define PCS_ANE_RFE_SHIFT	12
+#define PCS_ANE_ACK		BIT(14)		/* AN Base-page acknowledge */
 
 /**
  * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
  * @ioaddr: IO registers pointer
- * @reg: Base address of the AN Control Register.
  * @intr_status: GMAC core interrupt status
  * @x: pointer to log these events as stats
  * Description: it is the ISR for PCS events: Auto-Negotiation Completed and
  * Link status.
  */
-static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
+static inline void dwmac_pcs_isr(void __iomem *pcsaddr,
 				 unsigned int intr_status,
 				 struct stmmac_extra_stats *x)
 {
-	u32 val = readl(ioaddr + GMAC_AN_STATUS(reg));
+	u32 val = readl(pcsaddr + PCS_AN_STATUS);
 
 	if (intr_status & PCS_ANE_IRQ) {
 		x->irq_pcs_ane_n++;
-		if (val & GMAC_AN_STATUS_ANC)
+		if (val & PCS_AN_STATUS_ANC)
 			pr_info("stmmac_pcs: ANE process completed\n");
 	}
 
 	if (intr_status & PCS_LINK_IRQ) {
 		x->irq_pcs_link_n++;
-		if (val & GMAC_AN_STATUS_LS)
+		if (val & PCS_AN_STATUS_LS)
 			pr_info("stmmac_pcs: Link Up\n");
 		else
 			pr_info("stmmac_pcs: Link Down\n");
@@ -77,7 +79,6 @@ static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
 /**
  * dwmac_ctrl_ane - To program the AN Control Register.
  * @ioaddr: IO registers pointer
- * @reg: Base address of the AN Control Register.
  * @ane: to enable the auto-negotiation
  * @srgmi_ral: to manage MAC-2-MAC SGMII connections.
  * @loopback: to cause the PHY to loopback tx data into rx path.
@@ -85,36 +86,34 @@ static inline void dwmac_pcs_isr(void __iomem *ioaddr, u32 reg,
  * and init the ANE, select loopback (usually for debugging purpose) and
  * configure SGMII RAL.
  */
-static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
+static inline void dwmac_ctrl_ane(void __iomem *pcsaddr, bool ane,
 				  bool srgmi_ral, bool loopback)
 {
-	u32 value = readl(ioaddr + GMAC_AN_CTRL(reg));
+	u32 value = readl(pcsaddr + PCS_AN_CTRL);
 
 	/* Enable and restart the Auto-Negotiation */
 	if (ane)
-		value |= GMAC_AN_CTRL_ANE | GMAC_AN_CTRL_RAN;
+		value |= PCS_AN_CTRL_ANE | PCS_AN_CTRL_RAN;
 	else
-		value &= ~GMAC_AN_CTRL_ANE;
+		value &= ~PCS_AN_CTRL_ANE;
 
 	/* In case of MAC-2-MAC connection, block is configured to operate
 	 * according to MAC conf register.
 	 */
 	if (srgmi_ral)
-		value |= GMAC_AN_CTRL_SGMRAL;
+		value |= PCS_AN_CTRL_SGMRAL;
 
 	if (loopback)
-		value |= GMAC_AN_CTRL_ELE;
+		value |= PCS_AN_CTRL_ELE;
 
-	writel(value, ioaddr + GMAC_AN_CTRL(reg));
+	writel(value, pcsaddr + PCS_AN_CTRL);
 }
 
 int dwmac_pcs_config(struct mac_device_info *hw, unsigned int neg_mode,
 		     phy_interface_t interface,
-		     const unsigned long *advertising,
-		     unsigned int reg_base);
+		     const unsigned long *advertising);
 
 void dwmac_pcs_get_state(struct mac_device_info *hw,
-			 struct phylink_link_state *state,
-			 unsigned int reg_base);
+			 struct phylink_link_state *state);
 
 #endif /* __STMMAC_PCS_H__ */
-- 
2.43.0


