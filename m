Return-Path: <bpf+bounces-37220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA92952574
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 00:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A81F289866
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 22:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20180149C79;
	Wed, 14 Aug 2024 22:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="solAN2rM"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18372143C5D;
	Wed, 14 Aug 2024 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673912; cv=none; b=nyHJ/Zx5/eMInWapObSCEpXX0+Z93E5DObG9bhV8bziJgz/wWZQhCXFNhiRZlLr2780qfXwNzbZaGEv+HcmO0u0bBDIz2BzNZc4j0Kgxk7pNo8HXahtG/+GKuFjDE7bKStQ4D6IyvzfG3WplkSdYUhYar5kbL4jFb5d5w2ooVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673912; c=relaxed/simple;
	bh=N86+3UAimerDcct0v3/T9AdIwM8FyDpuc+NgjovY1DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWOehkWs7k6xY2bGkesd/Yn1gIFyS0XpkO9Tmi95BF3sqxp9XZ02Qm4YRCzESQwueoHWLU66d1jOffsRq/a327rInS36glZR2eva/oeRABBK42Ev456FJLC9koLHtJQ04dEdVQZfKCRHWM0wRfhmst21wta903cwGfZ+002kh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=solAN2rM; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6A0C1C0000F5;
	Wed, 14 Aug 2024 15:18:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6A0C1C0000F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723673902;
	bh=N86+3UAimerDcct0v3/T9AdIwM8FyDpuc+NgjovY1DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=solAN2rMTW71YOUW5e033JQMzR1nt0dzjQwKshh1Tr8/+Jfg/XlXf5kkT1lQ/zd0N
	 ylL5lCiVBmKP3+dKSj9B1Ec2YmftjludaPcEIjzXBDgvNQYQVga0Mnv4upsexAD1A7
	 xFYs695TUKmrsjLKCMS70aLUeJ2dsE9f40RDNIs0=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 5059518041CAC9;
	Wed, 14 Aug 2024 15:18:19 -0700 (PDT)
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
	leong.ching.swee@intel.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	andrew@lunn.ch,
	linux@armlinux.org.uk,
	horms@kernel.org,
	florian.fainelli@broadcom.com
Subject: [net-next v4 1/5] net: stmmac: Add HDMA mapping for dw25gmac support
Date: Wed, 14 Aug 2024 15:18:14 -0700
Message-Id: <20240814221818.2612484-2-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
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

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 include/linux/stmmac.h | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 338991c08f00..1775bd2b7c14 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -89,6 +89,55 @@ struct stmmac_mdio_bus_data {
 	bool needs_reset;
 };
 
+/* DW25GMAC Hyper-DMA Overview
+ * Hyper-DMA allows support for large number of Virtual DMA(VDMA)
+ * channels using a smaller set of physical DMA channels(PDMA).
+ * This is supported by the  mapping of VDMAs to Traffic Class (TC)
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
+#define STMMAC_DW25GMAC_MAX_NUM_TX_VDMA		128
+#define STMMAC_DW25GMAC_MAX_NUM_RX_VDMA		128
+
+#define STMMAC_DW25GMAC_MAX_NUM_TX_PDMA		8
+#define STMMAC_DW25GMAC_MAX_NUM_RX_PDMA		10
+
+#define STMMAC_DW25GMAC_MAX_TC			8
+
+/* Hyper-DMA mapping configuration
+ * Traffic Class associated with each VDMA/PDMA mapping
+ * is stored in corresponding array entry.
+ */
+struct stmmac_hdma_cfg {
+	u8 tvdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_VDMA];
+	u8 rvdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_VDMA];
+	u8 tpdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_PDMA];
+	u8 rpdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_PDMA];
+};
+
 struct stmmac_dma_cfg {
 	int pbl;
 	int txpbl;
@@ -101,6 +150,7 @@ struct stmmac_dma_cfg {
 	bool multi_msi_en;
 	bool dche;
 	bool atds;
+	struct stmmac_hdma_cfg *hdma_cfg;
 };
 
 #define AXI_BLEN	7
-- 
2.34.1


