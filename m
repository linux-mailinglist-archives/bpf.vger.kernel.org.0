Return-Path: <bpf+bounces-38863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA5D96B0CE
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 07:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AF21C2475F
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 05:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A613C697;
	Wed,  4 Sep 2024 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="rgpqpmjS"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D346450;
	Wed,  4 Sep 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429448; cv=none; b=kGJLI0WEumMJT7Xg0PJJjqDf2rHb06oKszNtqQp8eU9aOTZqiyF1BiGbV7Cm1zzqZVDo6Rt2g1FWHJxgh5o+AhnU47rQfGArfqGaXPIB06ILqfQ/+j6BiOCazPqEDySoCKhOxrgzli8jAhPbRhxpf2ve84GTXJX0oWFddl83lYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429448; c=relaxed/simple;
	bh=50w6/RH3XOXjkapDrDTzYIqvKxCuJmVWrUDMpCPVuH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tRF/QzVmSmqNGQKvoHcNmMa9x/8BpAzpTOsab+9mu+T87o3hubAI8CZECzy1sO5lMXHNIkPNHr1/16AiyKd5pxCGWI5Oe4i7im2N9Q+YsuZ2blYr2yK4xWhn47R4Et0PuaRPKsAcfH+RyPKF8jxOD/ZW0tQHm8+dqC6H4huQY80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=rgpqpmjS; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D1C21C0042F1;
	Tue,  3 Sep 2024 22:48:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D1C21C0042F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1725428909;
	bh=50w6/RH3XOXjkapDrDTzYIqvKxCuJmVWrUDMpCPVuH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgpqpmjSOCTbdu+k5BC4nHodfMhlj/uza7J1VaBeF6q2+VkVnlK4SPpLIBLgj9r5g
	 BlcOddAMrKn0M/EYNmTVDqWgPbGgbpKKMyOGX1kflIlcZesL2dC3/peZhNuJMSvWeh
	 f3HV/lsnOnJgMapsWtf2VRtyc/RAeYNu6TgPuVGs=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 2CA8B18041D1E4;
	Tue,  3 Sep 2024 22:48:28 -0700 (PDT)
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
	florian.fainelli@broadcom.com
Subject: [PATCH net-next v5 1/5] net: stmmac: Add HDMA mapping for dw25gmac support
Date: Tue,  3 Sep 2024 22:48:11 -0700
Message-Id: <20240904054815.1341712-2-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>

Add hdma configuration support in include/linux/stmmac.h file.
The hdma configuration includes mapping of virtual DMAs to physical DMAs.
Define a new data structure stmmac_hdma_cfg to provide the mapping.

Introduce new plat_stmmacenet_data::snps_id,snps_dev_id to allow glue
drivers to specify synopsys ID and device id respectively.
These values take precedence over reading from HW register. This facility
provides a mechanism to use setup function from stmmac core module and yet
override MAC.VERSION CSR if the glue driver chooses to do so.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 include/linux/stmmac.h | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 338991c08f00..eb8136680a7b 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -89,6 +89,51 @@ struct stmmac_mdio_bus_data {
 	bool needs_reset;
 };
 
+/* DW25GMAC Hyper-DMA Overview
+ * Hyper-DMA allows support for large number of Virtual DMA(VDMA)
+ * channels using a smaller set of physical DMA channels(PDMA).
+ * This is supported by the mapping of VDMAs to Traffic Class(TC)
+ * and PDMA to TC in each traffic direction as shown below.
+ *
+ *        VDMAs            Traffic Class      PDMA
+ *       +--------+          +------+         +-----------+
+ *       |VDMA0   |--------->| TC0  |-------->|PDMA0/TXQ0 |
+ *TX     +--------+   |----->+------+         +-----------+
+ *Host=> +--------+   |      +------+         +-----------+ => MAC
+ *SW     |VDMA1   |---+      | TC1  |    +--->|PDMA1/TXQ1 |
+ *       +--------+          +------+    |    +-----------+
+ *       +--------+          +------+----+    +-----------+
+ *       |VDMA2   |--------->| TC2  |-------->|PDMA2/TXQ1 |
+ *       +--------+          +------+         +-----------+
+ *            .                 .                 .
+ *       +--------+          +------+         +-----------+
+ *       |VDMAn-1 |--------->| TCx-1|-------->|PDMAm/TXQm |
+ *       +--------+          +------+         +-----------+
+ *
+ *       +------+          +------+         +------+
+ *       |PDMA0 |--------->| TC0  |-------->|VDMA0 |
+ *       +------+   |----->+------+         +------+
+ *MAC => +------+   |      +------+         +------+
+ *RXQs   |PDMA1 |---+      | TC1  |    +--->|VDMA1 |  => Host
+ *       +------+          +------+    |    +------+
+ *            .                 .                 .
+ */
+
+/* Hyper-DMA mapping configuration
+ * Traffic Class associated with each VDMA/PDMA mapping
+ * is stored in corresponding array entry.
+ */
+struct stmmac_hdma_cfg {
+	u32 tx_vdmas;	/* TX VDMA count */
+	u32 rx_vdmas;	/* RX VDMA count */
+	u32 tx_pdmas;	/* TX PDMA count */
+	u32 rx_pdmas;	/* RX PDMA count */
+	u8 *tvdma_tc;	/* Tx VDMA to TC mapping array */
+	u8 *rvdma_tc;	/* Rx VDMA to TC mapping array */
+	u8 *tpdma_tc;	/* Tx PDMA to TC mapping array */
+	u8 *rpdma_tc;	/* Rx PDMA to TC mapping array */
+};
+
 struct stmmac_dma_cfg {
 	int pbl;
 	int txpbl;
@@ -101,6 +146,7 @@ struct stmmac_dma_cfg {
 	bool multi_msi_en;
 	bool dche;
 	bool atds;
+	struct stmmac_hdma_cfg *hdma_cfg;
 };
 
 #define AXI_BLEN	7
@@ -303,5 +349,7 @@ struct plat_stmmacenet_data {
 	int msi_tx_base_vec;
 	const struct dwmac4_addrs *dwmac4_addrs;
 	unsigned int flags;
+	u32 snps_id;
+	u32 snps_dev_id;
 };
 #endif
-- 
2.34.1


