Return-Path: <bpf+bounces-42487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C769A48A1
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 22:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262FEB22C3F
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 20:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F144A206066;
	Fri, 18 Oct 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iwJt2u76"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67318D63A;
	Fri, 18 Oct 2024 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729285169; cv=none; b=hdgQVK5TPWxgWOP/YJCPRwce3He6z+MI+Ysh8dw0fp4x1EUpg5DP/ozW3659SUVgdv+cTJbE3LOFwliZ4zokR8ouAE8hhmM5o9LA5LLlfmJH8ZK4R8xR4pAiiNY9m7qWvukQIGJ3sYyARs2alZ1OWjFPNmsXMmg8VyP4lKKIFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729285169; c=relaxed/simple;
	bh=GkQT8mwzUI+JJua/Chm0C8V76c7cOuqD0w/Rn/98ITY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J0RhbNDs2276eOU/IaAUYjmZL0SIPaIfEu8FpXstLHQNRiCwcNajKYHKjTumUlpcnyIVwn9RyAt8wd3ZBkNpelSOYwZx/A6ZT+TRl+ra1JuEf6rcKmv8AZOrNb5xpXuPJVhg9hpqSeC8Svcr8SXaFI2yWNjFHdPLGAO4cbJX0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iwJt2u76; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B91DEC003ADD;
	Fri, 18 Oct 2024 13:53:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B91DEC003ADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1729284818;
	bh=GkQT8mwzUI+JJua/Chm0C8V76c7cOuqD0w/Rn/98ITY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwJt2u76RpTlB1d6qFAyi1L+mrhjy5Y3NNzL21zN1JUWj1kknipH+1ON9OSwP/Fng
	 Oq9iVQGAZgoTHjdgYxue/LtVRk6nvnBHrIBPM4Vs7p1DwTg16sQJTSHn+N/Zi6UpJf
	 mT9akCvQvhP+f9KdlBg+USRU7UWYZ7fBMztZRPKk=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 0E73118041CAC6;
	Fri, 18 Oct 2024 13:53:37 -0700 (PDT)
From: jitendra.vegiraju@broadcom.com
To: netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	jitendra.vegiraju@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	richardcochran@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	fancer.lancer@gmail.com,
	rmk+kernel@armlinux.org.uk,
	ahalaney@redhat.com,
	xiaolei.wang@windriver.com,
	rohan.g.thomas@intel.com,
	Jianheng.Zhang@synopsys.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	quic_abchauha@quicinc.com
Subject: [PATCH net-next v6 2/5] net: stmmac: Add basic dw25gmac support in stmmac core
Date: Fri, 18 Oct 2024 13:53:29 -0700
Message-Id: <20241018205332.525595-3-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

The BCM8958x uses early adopter version of DWC_xgmac version 4.00a for
Ethernet MAC. The DW25GMAC introduced in this version adds new DMA
architecture called Hyper-DMA (HDMA) for virtualization scalability.
This is realized by decoupling physical DMA channels(PDMA) from potentially
large number of virtual DMA channels (VDMA). The VDMAs are software
abstractions that map to PDMAs for frame transmission and reception.

Define new macros DW25GMAC_CORE_4_00 and DW25GMAC_ID to identify DW25GMAC
device.
To support the new HDMA architecture, a new instance of stmmac_dma_ops
dw25gmac400_dma_ops is added.
To support the current needs, a simple one-to-one mapping of dw25gmac's
logical VDMA (channel) to TC to PDMAs is used.
Most of the other dma operation functions in existing dwxgamc2_dma.c file
are reused where applicable.
Added setup function for DW25GMAC's stmmac_hwif_entry in stmmac core.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
 .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 161 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  92 ++++++++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   1 +
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  42 +++++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  52 ++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
 8 files changed, 354 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..967e8a9aa432 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o \
+	      stmmac_xdp.o stmmac_est.o dw25gmac.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 684489156dce..9a747b89ba51 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -38,9 +38,11 @@
 #define DWXGMAC_CORE_2_10	0x21
 #define DWXGMAC_CORE_2_20	0x22
 #define DWXLGMAC_CORE_2_00	0x20
+#define DW25GMAC_CORE_4_00	0x40
 
 /* Device ID */
 #define DWXGMAC_ID		0x76
+#define DW25GMAC_ID		0x55
 #define DWXLGMAC_ID		0x27
 
 #define STMMAC_CHAN0	0	/* Always supported and default for all chips */
@@ -563,6 +565,7 @@ struct mac_link {
 		u32 speed2500;
 		u32 speed5000;
 		u32 speed10000;
+		u32 speed25000;
 	} xgmii;
 	struct {
 		u32 speed25000;
@@ -621,6 +624,7 @@ int dwmac100_setup(struct stmmac_priv *priv);
 int dwmac1000_setup(struct stmmac_priv *priv);
 int dwmac4_setup(struct stmmac_priv *priv);
 int dwxgmac2_setup(struct stmmac_priv *priv);
+int dw25gmac_setup(struct stmmac_priv *priv);
 int dwxlgmac2_setup(struct stmmac_priv *priv);
 
 void stmmac_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
new file mode 100644
index 000000000000..8d0b45a7607a
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Broadcom Corporation
+ */
+#include "stmmac.h"
+#include "dwxgmac2.h"
+#include "dw25gmac.h"
+
+u32 dw25gmac_decode_vdma_count(u32 regval)
+{
+	/* compressed encoding for vdma count */
+	if (regval < 16) /* Direct mapping */
+		return regval + 1;
+	else if (regval < 20) /* 20, 24, 28, 32 */
+		return 20 + (regval - 16) * 4;
+	else if (regval < 24) /* 40, 48, 56, 64 */
+		return 40 + (regval - 20) * 8;
+	else if (regval < 28) /* 80, 96, 112, 128 */
+		return 80 + (regval - 24) * 16;
+	else  /* not defined */
+		return 0;
+}
+
+static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
+{
+	u32 reg_val = 0;
+
+	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
+	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
+	reg_val |= XXVGMAC_CMD_TYPE | XXVGMAC_OB;
+	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
+	return readl(ioaddr + XXVGMAC_DMA_CH_IND_DATA);
+}
+
+static void wr_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel, u32 val)
+{
+	u32 reg_val = 0;
+
+	writel(val, ioaddr + XXVGMAC_DMA_CH_IND_DATA);
+	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
+	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
+	reg_val |= XGMAC_OB;
+	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
+}
+
+void dw25gmac_dma_init(void __iomem *ioaddr,
+		       struct stmmac_dma_cfg *dma_cfg)
+{
+	u32 tx_pdmas, rx_pdmas;
+	u32 hw_cap;
+	u32 value;
+	u32 i;
+
+	value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
+	value &= ~(XGMAC_AAL | XGMAC_EAME);
+	if (dma_cfg->aal)
+		value |= XGMAC_AAL;
+	if (dma_cfg->eame)
+		value |= XGMAC_EAME;
+	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	/* Get PDMA counts from HW */
+	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
+	tx_pdmas = FIELD_GET(XGMAC_HWFEAT_TXQCNT, hw_cap) + 1;
+	rx_pdmas = FIELD_GET(XGMAC_HWFEAT_RXQCNT, hw_cap) + 1;
+
+	/* Intialize all PDMAs with burst length fields */
+	for (i = 0; i < tx_pdmas; i++) {
+		value = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
+		value &= ~(XXVGMAC_TXPBL | XXVGMAC_TPBLX8_MODE);
+		if (dma_cfg->pblx8)
+			value |= XXVGMAC_TPBLX8_MODE;
+		value |= FIELD_PREP(XXVGMAC_TXPBL, dma_cfg->pbl);
+		wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
+	}
+
+	for (i = 0; i < rx_pdmas; i++) {
+		value = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
+		value &= ~(XXVGMAC_RXPBL | XXVGMAC_RPBLX8_MODE);
+		if (dma_cfg->pblx8)
+			value |= XXVGMAC_RPBLX8_MODE;
+		value |= FIELD_PREP(XXVGMAC_RXPBL, dma_cfg->pbl);
+		wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
+	}
+}
+
+void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan)
+{
+	u32 value;
+	u32 tc;
+
+	/* Descriptor cache size and prefetch threshold size */
+	value = rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, chan);
+	value &= ~XXVGMAC_TXDCSZ;
+	value |= FIELD_PREP(XXVGMAC_TXDCSZ,
+			    XXVGMAC_TXDCSZ_256BYTES);
+	value &= ~XXVGMAC_TDPS;
+	value |= FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_TDPS_HALF);
+	wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, chan, value);
+
+	/* Use one-to-one mapping between VDMA, TC, and PDMA. */
+	tc = chan;
+
+	/* 1-to-1 PDMA to TC mapping */
+	value = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, chan);
+	value &= ~XXVGMAC_TP2TCMP;
+	value |= FIELD_PREP(XXVGMAC_TP2TCMP, tc);
+	wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, chan, value);
+
+	/* 1-to-1 VDMA to TC mapping */
+	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	value &= ~XXVGMAC_TVDMA2TCMP;
+	value |= FIELD_PREP(XXVGMAC_TVDMA2TCMP, tc);
+	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+
+	writel(upper_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
+	writel(lower_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
+}
+
+void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan)
+{
+	u32 value;
+	u32 tc;
+
+	/* Descriptor cache size and prefetch threshold size */
+	value = rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, chan);
+	value &= ~XXVGMAC_RXDCSZ;
+	value |= FIELD_PREP(XXVGMAC_RXDCSZ,
+			    XXVGMAC_RXDCSZ_256BYTES);
+	value &= ~XXVGMAC_RDPS;
+	value |= FIELD_PREP(XXVGMAC_RDPS, XXVGMAC_RDPS_HALF);
+	wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, chan, value);
+
+	/* Use one-to-one mapping between VDMA, TC, and PDMA. */
+	tc = chan;
+
+	/* 1-to-1 PDMA to TC mapping */
+	value = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, chan);
+	value &= ~XXVGMAC_RP2TCMP;
+	value |= FIELD_PREP(XXVGMAC_RP2TCMP, tc);
+	wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, chan, value);
+
+	/* 1-to-1 VDMA to TC mapping */
+	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	value &= ~XXVGMAC_RVDMA2TCMP;
+	value |= FIELD_PREP(XXVGMAC_RVDMA2TCMP, tc);
+	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+
+	writel(upper_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
+	writel(lower_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
new file mode 100644
index 000000000000..44f9601331d5
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2024 Broadcom Corporation
+ * DW25GMAC definitions.
+ */
+#ifndef __STMMAC_DW25GMAC_H__
+#define __STMMAC_DW25GMAC_H__
+
+/* Hardware features */
+#define XXVGMAC_HWFEAT_VDMA_RXCNT	GENMASK(16, 12)
+#define XXVGMAC_HWFEAT_VDMA_TXCNT	GENMASK(22, 18)
+
+/* DMA Indirect Registers*/
+#define XXVGMAC_DMA_CH_IND_CONTROL	0x00003080
+#define XXVGMAC_MODE_SELECT		GENMASK(27, 24)
+enum dma_ch_ind_modes {
+	MODE_TXEXTCFG	 = 0x0,	  /* Tx Extended Config */
+	MODE_RXEXTCFG	 = 0x1,	  /* Rx Extended Config */
+	MODE_TXDBGSTS	 = 0x2,	  /* Tx Debug Status */
+	MODE_RXDBGSTS	 = 0x3,	  /* Rx Debug Status */
+	MODE_TXDESCCTRL	 = 0x4,	  /* Tx Descriptor control */
+	MODE_RXDESCCTRL	 = 0x5,	  /* Rx Descriptor control */
+};
+
+#define XXVGMAC_ADDR_OFFSET		GENMASK(14, 8)
+#define XXVGMAC_AUTO_INCR		GENMASK(5, 4)
+#define XXVGMAC_CMD_TYPE		BIT(1)
+#define XXVGMAC_OB			BIT(0)
+#define XXVGMAC_DMA_CH_IND_DATA		0x00003084
+
+/* TX Config definitions */
+#define XXVGMAC_TXPBL			GENMASK(29, 24)
+#define XXVGMAC_TPBLX8_MODE		BIT(19)
+#define XXVGMAC_TP2TCMP			GENMASK(18, 16)
+#define XXVGMAC_ORRQ			GENMASK(13, 8)
+
+/* RX Config definitions */
+#define XXVGMAC_RXPBL			GENMASK(29, 24)
+#define XXVGMAC_RPBLX8_MODE		BIT(19)
+#define XXVGMAC_RP2TCMP			GENMASK(18, 16)
+#define XXVGMAC_OWRQ			GENMASK(13, 8)
+
+/* Tx Descriptor control */
+#define XXVGMAC_TXDCSZ			GENMASK(2, 0)
+#define XXVGMAC_TXDCSZ_0BYTES		0
+#define XXVGMAC_TXDCSZ_64BYTES		1
+#define XXVGMAC_TXDCSZ_128BYTES		2
+#define XXVGMAC_TXDCSZ_256BYTES		3
+#define XXVGMAC_TDPS			GENMASK(5, 3)
+#define XXVGMAC_TDPS_ZERO		0
+#define XXVGMAC_TDPS_1_8TH		1
+#define XXVGMAC_TDPS_1_4TH		2
+#define XXVGMAC_TDPS_HALF		3
+#define XXVGMAC_TDPS_3_4TH		4
+
+/* Rx Descriptor control */
+#define XXVGMAC_RXDCSZ			GENMASK(2, 0)
+#define XXVGMAC_RXDCSZ_0BYTES		0
+#define XXVGMAC_RXDCSZ_64BYTES		1
+#define XXVGMAC_RXDCSZ_128BYTES		2
+#define XXVGMAC_RXDCSZ_256BYTES		3
+#define XXVGMAC_RDPS			GENMASK(5, 3)
+#define XXVGMAC_RDPS_ZERO		0
+#define XXVGMAC_RDPS_1_8TH		1
+#define XXVGMAC_RDPS_1_4TH		2
+#define XXVGMAC_RDPS_HALF		3
+#define XXVGMAC_RDPS_3_4TH		4
+
+/* DWCXG_DMA_CH(#i) Registers*/
+#define XXVGMAC_DSL			GENMASK(20, 18)
+#define XXVGMAC_MSS			GENMASK(13, 0)
+#define XXVGMAC_TFSEL			GENMASK(30, 29)
+#define XXVGMAC_TQOS			GENMASK(27, 24)
+#define XXVGMAC_IPBL			BIT(15)
+#define XXVGMAC_TVDMA2TCMP		GENMASK(6, 4)
+#define XXVGMAC_RPF			BIT(31)
+#define XXVGMAC_RVDMA2TCMP		GENMASK(30, 28)
+#define XXVGMAC_RQOS			GENMASK(27, 24)
+
+u32 dw25gmac_decode_vdma_count(u32 regval);
+
+void dw25gmac_dma_init(void __iomem *ioaddr,
+		       struct stmmac_dma_cfg *dma_cfg);
+
+void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan);
+void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan);
+#endif /* __STMMAC_DW25GMAC_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 6a2c7d22df1e..c9424c5a6ce5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -17,6 +17,7 @@
 #define XGMAC_CONFIG_SS_OFF		29
 #define XGMAC_CONFIG_SS_MASK		GENMASK(31, 29)
 #define XGMAC_CONFIG_SS_10000		(0x0 << XGMAC_CONFIG_SS_OFF)
+#define XGMAC_CONFIG_SS_25000		(0x1 << XGMAC_CONFIG_SS_OFF)
 #define XGMAC_CONFIG_SS_2500_GMII	(0x2 << XGMAC_CONFIG_SS_OFF)
 #define XGMAC_CONFIG_SS_1000_GMII	(0x3 << XGMAC_CONFIG_SS_OFF)
 #define XGMAC_CONFIG_SS_100_MII		(0x4 << XGMAC_CONFIG_SS_OFF)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f519d43738b0..96013b489af6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -11,6 +11,7 @@
 #include "stmmac_ptp.h"
 #include "dwxlgmac2.h"
 #include "dwxgmac2.h"
+#include "dw25gmac.h"
 
 static void dwxgmac2_core_init(struct mac_device_info *hw,
 			       struct net_device *dev)
@@ -1670,6 +1671,47 @@ int dwxgmac2_setup(struct stmmac_priv *priv)
 	return 0;
 }
 
+int dw25gmac_setup(struct stmmac_priv *priv)
+{
+	struct mac_device_info *mac = priv->hw;
+
+	dev_info(priv->device, "\tDW25GMAC\n");
+
+	priv->dev->priv_flags |= IFF_UNICAST_FLT;
+	mac->pcsr = priv->ioaddr;
+	mac->multicast_filter_bins = priv->plat->multicast_filter_bins;
+	mac->unicast_filter_entries = priv->plat->unicast_filter_entries;
+	mac->mcast_bits_log2 = 0;
+
+	if (mac->multicast_filter_bins)
+		mac->mcast_bits_log2 = ilog2(mac->multicast_filter_bins);
+
+	mac->link.caps = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+			 MAC_1000FD | MAC_2500FD | MAC_5000FD |
+			 MAC_10000FD | MAC_25000FD;
+	mac->link.duplex = 0;
+	mac->link.speed10 = XGMAC_CONFIG_SS_10_MII;
+	mac->link.speed100 = XGMAC_CONFIG_SS_100_MII;
+	mac->link.speed1000 = XGMAC_CONFIG_SS_1000_GMII;
+	mac->link.speed2500 = XGMAC_CONFIG_SS_2500_GMII;
+	mac->link.xgmii.speed2500 = XGMAC_CONFIG_SS_2500;
+	mac->link.xgmii.speed5000 = XGMAC_CONFIG_SS_5000;
+	mac->link.xgmii.speed10000 = XGMAC_CONFIG_SS_10000;
+	mac->link.xgmii.speed25000 = XGMAC_CONFIG_SS_25000;
+	mac->link.speed_mask = XGMAC_CONFIG_SS_MASK;
+
+	mac->mii.addr = XGMAC_MDIO_ADDR;
+	mac->mii.data = XGMAC_MDIO_DATA;
+	mac->mii.addr_shift = 16;
+	mac->mii.addr_mask = GENMASK(20, 16);
+	mac->mii.reg_shift = 0;
+	mac->mii.reg_mask = GENMASK(15, 0);
+	mac->mii.clk_csr_shift = 19;
+	mac->mii.clk_csr_mask = GENMASK(21, 19);
+
+	return 0;
+}
+
 int dwxlgmac2_setup(struct stmmac_priv *priv)
 {
 	struct mac_device_info *mac = priv->hw;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 7840bc403788..2e86eaafd16e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -7,6 +7,7 @@
 #include <linux/iopoll.h>
 #include "stmmac.h"
 #include "dwxgmac2.h"
+#include "dw25gmac.h"
 
 static int dwxgmac2_dma_reset(void __iomem *ioaddr)
 {
@@ -500,6 +501,27 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	return 0;
 }
 
+static int dw25gmac_get_hw_feature(void __iomem *ioaddr,
+				   struct dma_features *dma_cap)
+
+{
+	u32 hw_cap;
+	int ret;
+
+	ret = dwxgmac2_get_hw_feature(ioaddr, dma_cap);
+
+	/* For DW25GMAC VDMA channel count is channel count */
+	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
+	dma_cap->number_tx_channel =
+		dw25gmac_decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
+					    hw_cap));
+	dma_cap->number_rx_channel =
+		dw25gmac_decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
+					    hw_cap));
+
+	return ret;
+}
+
 static void dwxgmac2_rx_watchdog(struct stmmac_priv *priv, void __iomem *ioaddr,
 				 u32 riwt, u32 queue)
 {
@@ -641,3 +663,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
 	.enable_sph = dwxgmac2_enable_sph,
 	.enable_tbs = dwxgmac2_enable_tbs,
 };
+
+const struct stmmac_dma_ops dw25gmac400_dma_ops = {
+	.reset = dwxgmac2_dma_reset,
+	.init = dw25gmac_dma_init,
+	.init_chan = dwxgmac2_dma_init_chan,
+	.init_rx_chan = dw25gmac_dma_init_rx_chan,
+	.init_tx_chan = dw25gmac_dma_init_tx_chan,
+	.axi = dwxgmac2_dma_axi,
+	.dump_regs = dwxgmac2_dma_dump_regs,
+	.dma_rx_mode = dwxgmac2_dma_rx_mode,
+	.dma_tx_mode = dwxgmac2_dma_tx_mode,
+	.enable_dma_irq = dwxgmac2_enable_dma_irq,
+	.disable_dma_irq = dwxgmac2_disable_dma_irq,
+	.start_tx = dwxgmac2_dma_start_tx,
+	.stop_tx = dwxgmac2_dma_stop_tx,
+	.start_rx = dwxgmac2_dma_start_rx,
+	.stop_rx = dwxgmac2_dma_stop_rx,
+	.dma_interrupt = dwxgmac2_dma_interrupt,
+	.get_hw_feature = dw25gmac_get_hw_feature,
+	.rx_watchdog = dwxgmac2_rx_watchdog,
+	.set_rx_ring_len = dwxgmac2_set_rx_ring_len,
+	.set_tx_ring_len = dwxgmac2_set_tx_ring_len,
+	.set_rx_tail_ptr = dwxgmac2_set_rx_tail_ptr,
+	.set_tx_tail_ptr = dwxgmac2_set_tx_tail_ptr,
+	.enable_tso = dwxgmac2_enable_tso,
+	.qmode = dwxgmac2_qmode,
+	.set_bfsize = dwxgmac2_set_bfsize,
+	.enable_sph = dwxgmac2_enable_sph,
+	.enable_tbs = dwxgmac2_enable_tbs,
+};
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index d5a9f01ecac5..774ea8cd5ae9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -702,6 +702,7 @@ extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
 extern const struct stmmac_mmc_ops dwmac_mmc_ops;
 extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
 extern const struct stmmac_est_ops dwmac510_est_ops;
+extern const struct stmmac_dma_ops dw25gmac400_dma_ops;
 
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
-- 
2.34.1


