Return-Path: <bpf+bounces-36253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984939456A7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 05:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2FB286D2B
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 03:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4FF2837A;
	Fri,  2 Aug 2024 03:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MjHM+aMt"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C317984;
	Fri,  2 Aug 2024 03:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722569056; cv=none; b=hYB6pYsnlCGMDjDVPLeq85AUQUOtrYHwu+V+6hACwIiwvlXldh6fb7HtYwE3dY3rMUByB8I+HLxqcoPCbVFBwY1vyBafl10zD/ekG6QiX2fTZoWlytF5bzGwl8ZAn2RfZgOwMb1rlHlk3Tb7E0Mhh4nH7WRXexPmRFu6lbm1WvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722569056; c=relaxed/simple;
	bh=Z2OAuZ9IFuxjnq8oX7tr8assXRon6c+l328aPvNO0xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bqMivfrom23GxrPdMBFarIaeul7EjkXEaLTyWDU1rwwit9gal1BBemO1yGrYtbBYe4s9zcbsGNMGsyYFZ0TjHeLzTiBUz8m0O840UZ0oDOBxQtJsQK/0RZP6ef0z1/a5nDUMpMfN+laqaFvRZ40RrB7maYMlmOaipz32PEFY4SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MjHM+aMt; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E1BCBC0000F3;
	Thu,  1 Aug 2024 20:18:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E1BCBC0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1722568707;
	bh=Z2OAuZ9IFuxjnq8oX7tr8assXRon6c+l328aPvNO0xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MjHM+aMtflzmne2cZnu4D2vprFgpYs5d3ET1LpKSNhgjvqeY8f+j8NnADIjwXV/UV
	 XjRmk63SQ+VAxyIPZbugA6vEUvEJ8Qj44B0eRUU8Zy+ffAfwVPpaEsbJMdxdGND5iI
	 VUcv85PWfJkmaETdhXh6T50SezicFxHK9jWot0/o=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 1997918041CAC6;
	Thu,  1 Aug 2024 20:18:24 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	horms@kernel.org,
	florian.fainelli@broadcom.com
Subject: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support to stmmac core
Date: Thu,  1 Aug 2024 20:18:20 -0700
Message-Id: <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Adds support for DWC_xgmac version 4.00a in stmmac core module.
This version adds enhancements to DMA architecture for virtualization
scalability. This is realized by decoupling physical DMA channels (PDMA)
from Virtual DMA channels (VDMA). The  VDMAs are software abastractions
that map to PDMAs for frame transmission and reception.

The virtualization enhancements are currently not being used and hence
a fixed mapping of VDMA to PDMA is configured in the init functions.
Because of the new init functions, a new instance of struct stmmac_dma_ops
dwxgmac400_dma_ops is added.
Most of the other dma operation functions in existing dwxgamc2_dma.c file
can be reused.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++++
 .../net/ethernet/stmicro/stmmac/dwxgmac4.c    | 142 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwxgmac4.h    |  84 +++++++++++
 4 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h

diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
index c2f0e91f6bf8..2f637612513d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Makefile
+++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
@@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
 	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
 	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
 	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
-	      stmmac_xdp.o stmmac_est.o \
+	      stmmac_xdp.o stmmac_est.o dwxgmac4.o \
 	      $(stmmac-y)
 
 stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index dd2ab6185c40..c15f5247aaa8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -7,6 +7,7 @@
 #include <linux/iopoll.h>
 #include "stmmac.h"
 #include "dwxgmac2.h"
+#include "dwxgmac4.h"
 
 static int dwxgmac2_dma_reset(void __iomem *ioaddr)
 {
@@ -641,3 +642,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
 	.enable_sph = dwxgmac2_enable_sph,
 	.enable_tbs = dwxgmac2_enable_tbs,
 };
+
+const struct stmmac_dma_ops dwxgmac400_dma_ops = {
+	.reset = dwxgmac2_dma_reset,
+	.init = dwxgmac4_dma_init,
+	.init_chan = dwxgmac2_dma_init_chan,
+	.init_rx_chan = dwxgmac4_dma_init_rx_chan,
+	.init_tx_chan = dwxgmac4_dma_init_tx_chan,
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
+	.get_hw_feature = dwxgmac2_get_hw_feature,
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
new file mode 100644
index 000000000000..9c8748122dc6
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Broadcom Corporation
+ */
+#include "dwxgmac2.h"
+#include "dwxgmac4.h"
+
+static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
+{
+	u32 reg_val = 0;
+	u32 val = 0;
+
+	reg_val |= mode << XGMAC4_MSEL_SHIFT & XGMAC4_MODE_SELECT;
+	reg_val |= channel << XGMAC4_AOFF_SHIFT & XGMAC4_ADDR_OFFSET;
+	reg_val |= XGMAC4_CMD_TYPE | XGMAC4_OB;
+	writel(reg_val, ioaddr + XGMAC4_DMA_CH_IND_CONTROL);
+	val = readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
+	return val;
+}
+
+static void wr_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel, u32 val)
+{
+	u32 reg_val = 0;
+
+	writel(val, ioaddr + XGMAC4_DMA_CH_IND_DATA);
+	reg_val |= mode << XGMAC4_MSEL_SHIFT & XGMAC4_MODE_SELECT;
+	reg_val |= channel << XGMAC4_AOFF_SHIFT & XGMAC4_ADDR_OFFSET;
+	reg_val |= XGMAC_OB;
+	writel(reg_val, ioaddr + XGMAC4_DMA_CH_IND_CONTROL);
+}
+
+static void xgmac4_tp2tc_map(void __iomem *ioaddr, u8 pdma_ch, u32 tc_num)
+{
+	u32 val = 0;
+
+	val = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, pdma_ch);
+	val &= ~XGMAC4_TP2TCMP;
+	val |= tc_num << XGMAC4_TP2TCMP_SHIFT & XGMAC4_TP2TCMP;
+	wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, pdma_ch, val);
+}
+
+static void xgmac4_rp2tc_map(void __iomem *ioaddr, u8 pdma_ch, u32 tc_num)
+{
+	u32 val = 0;
+
+	val = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, pdma_ch);
+	val &= ~XGMAC4_RP2TCMP;
+	val |= tc_num << XGMAC4_RP2TCMP_SHIFT & XGMAC4_RP2TCMP;
+	wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, pdma_ch, val);
+}
+
+void dwxgmac4_dma_init(void __iomem *ioaddr,
+		       struct stmmac_dma_cfg *dma_cfg, int atds)
+{
+	u32 value;
+	u32 i;
+
+	value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	if (dma_cfg->aal)
+		value |= XGMAC_AAL;
+
+	if (dma_cfg->eame)
+		value |= XGMAC_EAME;
+
+	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	for (i = 0; i < VDMA_TOTAL_CH_COUNT; i++) {
+		value = rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i);
+		value &= ~XGMAC4_TXDCSZ;
+		value |= 0x3;
+		value &= ~XGMAC4_TDPS;
+		value |= (3 << XGMAC4_TDPS_SHIFT) & XGMAC4_TDPS;
+		wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i, value);
+
+		value = rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i);
+		value &= ~XGMAC4_RXDCSZ;
+		value |= 0x3;
+		value &= ~XGMAC4_RDPS;
+		value |= (3 << XGMAC4_RDPS_SHIFT) & XGMAC4_RDPS;
+		wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i, value);
+	}
+
+	for (i = 0; i < PDMA_TX_CH_COUNT; i++) {
+		value = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
+		value &= ~(XGMAC4_TXPBL | XGMAC4_TPBLX8_MODE);
+		if (dma_cfg->pblx8)
+			value |= XGMAC4_TPBLX8_MODE;
+		value |= (dma_cfg->pbl << XGMAC4_TXPBL_SHIFT) & XGMAC4_TXPBL;
+		wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
+		xgmac4_tp2tc_map(ioaddr, i, i);
+	}
+
+	for (i = 0; i < PDMA_RX_CH_COUNT; i++) {
+		value = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
+		value &= ~(XGMAC4_RXPBL | XGMAC4_RPBLX8_MODE);
+		if (dma_cfg->pblx8)
+			value |= XGMAC4_RPBLX8_MODE;
+		value |= (dma_cfg->pbl << XGMAC4_RXPBL_SHIFT) & XGMAC4_RXPBL;
+		wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
+		if (i < PDMA_MAX_TC_COUNT)
+			xgmac4_rp2tc_map(ioaddr, i, i);
+		else
+			xgmac4_rp2tc_map(ioaddr, i, PDMA_MAX_TC_COUNT - 1);
+	}
+}
+
+void dwxgmac4_dma_init_tx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan)
+{
+	u32 value;
+
+	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+	value &= ~XGMAC4_TVDMA2TCMP;
+	value |= (chan << XGMAC4_TVDMA2TCMP_SHIFT) & XGMAC4_TVDMA2TCMP;
+	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
+
+	writel(upper_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
+	writel(lower_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
+}
+
+void dwxgmac4_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan)
+{
+	u32 value;
+
+	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+	value &= ~XGMAC4_RVDMA2TCMP;
+	value |= (chan << XGMAC4_RVDMA2TCMP_SHIFT) & XGMAC4_RVDMA2TCMP;
+	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
+
+	writel(upper_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
+	writel(lower_32_bits(dma_addr),
+	       ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
+}
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h
new file mode 100644
index 000000000000..0ce1856b0b34
--- /dev/null
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2024 Broadcom Corporation
+ * XGMAC4 definitions.
+ */
+#ifndef __STMMAC_DWXGMAC4_H__
+#define __STMMAC_DWXGMAC4_H__
+
+/* DMA Indirect Registers*/
+#define XGMAC4_DMA_CH_IND_CONTROL	0X00003080
+#define XGMAC4_MODE_SELECT		GENMASK(27, 24)
+#define XGMAC4_MSEL_SHIFT		24
+enum dma_ch_ind_modes {
+	MODE_TXEXTCFG	 = 0x0,	  /* Tx Extended Config */
+	MODE_RXEXTCFG	 = 0x1,	  /* Rx Extended Config */
+	MODE_TXDBGSTS	 = 0x2,	  /* Tx Debug Status */
+	MODE_RXDBGSTS	 = 0x3,	  /* Rx Debug Status */
+	MODE_TXDESCCTRL	 = 0x4,	  /* Tx Descriptor control */
+	MODE_RXDESCCTRL	 = 0x5,	  /* Rx Descriptor control */
+};
+
+#define XGMAC4_ADDR_OFFSET		GENMASK(14, 8)
+#define XGMAC4_AOFF_SHIFT		8
+#define XGMAC4_AUTO_INCR		GENMASK(5, 4)
+#define XGMAC4_AUTO_SHIFT		4
+#define XGMAC4_CMD_TYPE			BIT(1)
+#define XGMAC4_OB			BIT(0)
+#define XGMAC4_DMA_CH_IND_DATA		0X00003084
+
+/* TX Config definitions */
+#define XGMAC4_TXPBL			GENMASK(29, 24)
+#define XGMAC4_TXPBL_SHIFT		24
+#define XGMAC4_TPBLX8_MODE		BIT(19)
+#define XGMAC4_TP2TCMP			GENMASK(18, 16)
+#define XGMAC4_TP2TCMP_SHIFT		16
+#define XGMAC4_ORRQ			GENMASK(13, 8)
+/* RX Config definitions */
+#define XGMAC4_RXPBL			GENMASK(29, 24)
+#define XGMAC4_RXPBL_SHIFT		24
+#define XGMAC4_RPBLX8_MODE		BIT(19)
+#define XGMAC4_RP2TCMP			GENMASK(18, 16)
+#define XGMAC4_RP2TCMP_SHIFT		16
+#define XGMAC4_OWRQ			GENMASK(13, 8)
+/* Tx Descriptor control */
+#define XGMAC4_TXDCSZ			GENMASK(2, 0)
+#define XGMAC4_TDPS			GENMASK(5, 3)
+#define XGMAC4_TDPS_SHIFT		3
+/* Rx Descriptor control */
+#define XGMAC4_RXDCSZ			GENMASK(2, 0)
+#define XGMAC4_RDPS			GENMASK(5, 3)
+#define XGMAC4_RDPS_SHIFT		3
+
+/* DWCXG_DMA_CH(#i) Registers*/
+#define XGMAC4_DSL			GENMASK(20, 18)
+#define XGMAC4_MSS			GENMASK(13, 0)
+#define XGMAC4_TFSEL			GENMASK(30, 29)
+#define XGMAC4_TQOS			GENMASK(27, 24)
+#define XGMAC4_IPBL			BIT(15)
+#define XGMAC4_TVDMA2TCMP		GENMASK(6, 4)
+#define XGMAC4_TVDMA2TCMP_SHIFT		4
+#define XGMAC4_RPF			BIT(31)
+#define XGMAC4_RVDMA2TCMP		GENMASK(30, 28)
+#define XGMAC4_RVDMA2TCMP_SHIFT		28
+#define XGMAC4_RQOS			GENMASK(27, 24)
+
+/* PDMA Channel count */
+#define PDMA_TX_CH_COUNT		8
+#define PDMA_RX_CH_COUNT		10
+#define PDMA_MAX_TC_COUNT		8
+
+/* VDMA channel count */
+#define VDMA_TOTAL_CH_COUNT		32
+
+void dwxgmac4_dma_init(void __iomem *ioaddr,
+		       struct stmmac_dma_cfg *dma_cfg, int atds);
+
+void dwxgmac4_dma_init_tx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan);
+void dwxgmac4_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t dma_addr, u32 chan);
+#endif /* __STMMAC_DWXGMAC4_H__ */
-- 
2.34.1


