Return-Path: <bpf+bounces-37223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46995257C
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 00:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B477287C8A
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 22:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47D14D457;
	Wed, 14 Aug 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X/F53WIf"
X-Original-To: bpf@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A16714900E;
	Wed, 14 Aug 2024 22:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673913; cv=none; b=m27vjw+irSTZiDZU41ZcXQJ6e9j0+L9WAW1ML4TgNNWIlZsFY7AnqYlbVwR7wlKppo90gt6btxROhme8y5a7DCWVtYzMxdACIRSI2K1vuwq7v6F0XSAcBpercxmducsZacUtRn1iRLT0+GVUCBbLZWknKQpDzxH6lVOL4D0Ja4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673913; c=relaxed/simple;
	bh=UloX+ivKiJ6oahpxYurB+nrONffprqk8e3KUnWuOOGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n55fiJ0yvX9EmDM5nA29ZDCJoSNWobIUcbQ3IK88M4g3jAiff/ZntX5Bie1etQ5DTzxsgH9g+TA+Fusuddg698RBrTblEtl0L+p8C9Z0GGcyUI+ZwBtG9qLwC/dfD4vIgxbK/sIPdyQXba6dSKoDWRivT0fbGebsXDHtDOowGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=X/F53WIf; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5F8F2C003DF8;
	Wed, 14 Aug 2024 15:18:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5F8F2C003DF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1723673903;
	bh=UloX+ivKiJ6oahpxYurB+nrONffprqk8e3KUnWuOOGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/F53WIfhHAC5Qe4Cuw1Nv8ZmG6uwjoLSRvtwNBkUB6VT+Ih2NjTMTImOBjlupJ/8
	 1YEpUJ4B9Z6IiQrFtcSwGePdx4oH5KCIBPE72ftoDTXfScHGCk7uKPFP7dQpQfrX92
	 vILskLRJqIGUBHKTsfNJMThUMxTXq/u7m7hsH0/U=
Received: from pcie-dev03.dhcp.broadcom.net (pcie-dev03.dhcp.broadcom.net [10.59.171.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4514B18041CAC9;
	Wed, 14 Aug 2024 15:18:20 -0700 (PDT)
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
Subject: [net-next v4 3/5] net: stmmac: Integrate dw25gmac into stmmac hwif handling
Date: Wed, 14 Aug 2024 15:18:16 -0700
Message-Id: <20240814221818.2612484-4-jitendra.vegiraju@broadcom.com>
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

Integrate dw25gmac support into stmmac hardware interface handling.
Added a new entry to the stmmac_hw table in hwif.c.
Define new macros DW25GMAC_CORE_4_00 and DW25GMAC_ID to identify 25GMAC
device.
Since BCM8958x is an early adaptor device, the synopsis_id reported in HW
is 0x32 and device_id is DWXGMAC_ID. Provide override support by defining
synopsys_dev_id member in struct stmmac_priv so that driver specific setup
functions can override the hardware reported values.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h |  2 ++
 drivers/net/ethernet/stmicro/stmmac/hwif.c   | 25 ++++++++++++++++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac.h |  1 +
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 684489156dce..46edbe73a124 100644
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 29367105df54..97e5594ddcda 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -278,6 +278,27 @@ static const struct stmmac_hwif_entry {
 		.est = &dwmac510_est_ops,
 		.setup = dwxlgmac2_setup,
 		.quirks = stmmac_dwxlgmac_quirks,
+	}, {
+		.gmac = false,
+		.gmac4 = false,
+		.xgmac = true,
+		.min_id = DW25GMAC_CORE_4_00,
+		.dev_id = DW25GMAC_ID,
+		.regs = {
+			.ptp_off = PTP_XGMAC_OFFSET,
+			.mmc_off = MMC_XGMAC_OFFSET,
+			.est_off = EST_XGMAC_OFFSET,
+		},
+		.desc = &dwxgmac210_desc_ops,
+		.dma = &dw25gmac400_dma_ops,
+		.mac = &dwxgmac210_ops,
+		.hwtimestamp = &stmmac_ptp,
+		.mode = NULL,
+		.tc = &dwmac510_tc_ops,
+		.mmc = &dwxgmac_mmc_ops,
+		.est = &dwmac510_est_ops,
+		.setup = dwxgmac2_setup,
+		.quirks = NULL,
 	},
 };
 
@@ -304,7 +325,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 
 	/* Save ID for later use */
 	priv->synopsys_id = id;
-
+	priv->synopsys_dev_id = dev_id;
 	/* Lets assume some safe values first */
 	priv->ptpaddr = priv->ioaddr +
 		(needs_gmac4 ? PTP_GMAC4_OFFSET : PTP_GMAC3_X_OFFSET);
@@ -339,7 +360,7 @@ int stmmac_hwif_init(struct stmmac_priv *priv)
 		/* Use synopsys_id var because some setups can override this */
 		if (priv->synopsys_id < entry->min_id)
 			continue;
-		if (needs_xgmac && (dev_id ^ entry->dev_id))
+		if (needs_xgmac && (priv->synopsys_dev_id ^ entry->dev_id))
 			continue;
 
 		/* Only use generic HW helpers if needed */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b23b920eedb1..9784bbaf9a51 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -282,6 +282,7 @@ struct stmmac_priv {
 	struct stmmac_counters mmc;
 	int hw_cap_support;
 	int synopsys_id;
+	int synopsys_dev_id;
 	u32 msg_enable;
 	int wolopts;
 	int wol_irq;
-- 
2.34.1


