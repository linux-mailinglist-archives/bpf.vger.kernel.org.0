Return-Path: <bpf+bounces-47023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2099F2A74
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3271889B15
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 06:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14B1D8E1E;
	Mon, 16 Dec 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLU6U5tj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A91D8A0D;
	Mon, 16 Dec 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331762; cv=none; b=rW0UfMZlTYavcRn3hYMibpbtgYkNb7faIcriR/XjgLuaETEPFgXjUUbfOO1nif+zdSFAuZ3251UXXvn4jk4wOqX8e/fL9k+4ydwOL58H9rTiT0p44xHcWW+b8f5IR8tIS785FC5XjzswdnZI3algXQ9+EFP4yBMc32/HaUEuoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331762; c=relaxed/simple;
	bh=GmF50IpDra1dgYb/XdxHNOCwP4kOlp3rid6eI8frReo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dnVXXIILdN7mBUF1QrSqJnUJclejjCc2urP/xvYQHqNn8x2DcyEhL8OiGXBEA5Wk9unpoBzXOf85+0V34om60B/c7nu2VDWcK7SZW8g6jnKcwsbn0xQME8vYCWC0N12ZIyTFi1vHOTD/NRiQOWNOsB0sYWuAh/IKde+UQfU8s4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLU6U5tj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331761; x=1765867761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GmF50IpDra1dgYb/XdxHNOCwP4kOlp3rid6eI8frReo=;
  b=DLU6U5tjK6XWp4yMg0hfsR7g3ieq7swdkDIG5GY1yxDkcyaO7dNKT9hC
   hmakq1N7I6T/FZQFdpgJ/dWziptAfhABQGW5UyGFuruE9R1lL7gWdoOui
   3h0agItNEfuVTb27u6bOBTJGJiMRCyR1XcC78mTCbjXDbDpof4g4Be6Mj
   zXrMBYc86B2hJm6YLrqe/AEQ8Q3ZLEEyraFa1qZV8xJUpE0HAyGNctTjq
   JEU2iWSsqJ/KtjIUjUS+tp29lROJuYE2HT4X0jYMKd4aGLgRQEtl45g9C
   9rkrhkIetrosZ0DL/MT/cPM91686/naRixCZ3CmQzlsOcQ/fkUZhuaFea
   A==;
X-CSE-ConnectionGUID: juEgZ7myRpqdBhtf4DbLgQ==
X-CSE-MsgGUID: ZPt03ujwQGW+Li7qQ77L8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34848276"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34848276"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:49:21 -0800
X-CSE-ConnectionGUID: q9eNcpKNR8q0nYi2da+eBQ==
X-CSE-MsgGUID: CKt6U1j/TfWPRTe6NB0olw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128101929"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 22:49:17 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next 9/9] igc: Add support to get frame preemption statistics via ethtool
Date: Mon, 16 Dec 2024 01:47:20 -0500
Message-Id: <20241216064720.931522-10-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implemented "ethtool --include-statistics --show-mm" callback for IGC.

Tested preemption scenario to check preemption statistics:
1) Trigger verification handshake on both boards:
    $ sudo ethtool --set-mm enp1s0 pmac-enabled on
    $ sudo ethtool --set-mm enp1s0 tx-enabled on
    $ sudo ethtool --set-mm enp1s0 verify-enabled on
2) Set preemptible or express queue in taprio for tx board:
    $ sudo tc qdisc replace dev enp1s0 parent root handle 100 taprio \
      num_tc 4 map 0 1 2 3 0 0 0 0 0 0 0 0 0 0 0 0 \
      queues 1@0 1@1 1@2 1@3 base-time 0 sched-entry S F 100000 \
      fp E E P P
3) Send large size packets on preemptible queue
4) Send small size packets on express queue to preempt packets in
   preemptible queue
5) Show preemption statistics on the receiving board:
   $ ethtool --include-statistics --show-mm enp1s0
     MAC Merge layer state for enp1s0:
     pMAC enabled: on
     TX enabled: on
     TX active: on
     TX minimum fragment size: 252
     RX minimum fragment size: 252
     Verify enabled: on
     Verify time: 128
     Max verify time: 128
     Verification status: SUCCEEDED
     Statistics:
     	MACMergeFrameAssErrorCount: 0
	MACMergeFrameSmdErrorCount: 0
	MACMergeFrameAssOkCount: 511
	MACMergeFragCountRx: 764
	MACMergeFragCountTx: 0
	MACMergeHoldCount: 0

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 40 ++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    | 19 ++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 16aa6e4e1727..90a9dbb0d901 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1835,6 +1835,45 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
 	return igc_tsn_offload_apply(adapter);
 }
 
+/**
+ * igc_ethtool_get_frame_ass_error - Get the frame assembly error count.
+ * @dev: Pointer to the net_device structure.
+ * @return: The count of frame assembly errors.
+ */
+static u64 igc_ethtool_get_frame_ass_error(struct net_device *dev)
+{
+	struct igc_adapter *adapter = netdev_priv(dev);
+	u32 ooo_smdc, ooo_frame_cnt, ooo_frag_cnt; /* Out of order statistics */
+	struct igc_hw *hw = &adapter->hw;
+	u32 miss_frame_frag_cnt;
+	u32 reg_value;
+
+	reg_value = rd32(IGC_PRMEXPRCNT);
+	ooo_smdc = reg_value & IGC_PRMEXPRCNT_OOO_SMDC;
+	ooo_frame_cnt = (reg_value & IGC_PRMEXPRCNT_OOO_FRAME_CNT)
+			 >> IGC_PRMEXPRCNT_OOO_FRAME_CNT_SHIFT;
+	ooo_frag_cnt = (reg_value & IGC_PRMEXPRCNT_OOO_FRAG_CNT)
+			>> IGC_PRMEXPRCNT_OOO_FRAG_CNT_SHIFT;
+	miss_frame_frag_cnt = (reg_value & IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT)
+			      >> IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT_SHIFT;
+
+	return ooo_smdc + ooo_frame_cnt + ooo_frag_cnt + miss_frame_frag_cnt;
+}
+
+static void igc_ethtool_get_mm_stats(struct net_device *dev,
+				     struct ethtool_mm_stats *stats)
+{
+	struct igc_adapter *adapter = netdev_priv(dev);
+	struct igc_hw *hw = &adapter->hw;
+
+	stats->MACMergeFrameAssErrorCount = igc_ethtool_get_frame_ass_error(dev);
+	stats->MACMergeFrameSmdErrorCount = 0; /* Not available in IGC */
+	stats->MACMergeFrameAssOkCount = rd32(IGC_PRMPTDRCNT);
+	stats->MACMergeFragCountRx =  rd32(IGC_PRMEVNTRCNT);
+	stats->MACMergeFragCountTx = rd32(IGC_PRMEVNTTCNT);
+	stats->MACMergeHoldCount = 0; /* Not available in IGC */
+}
+
 static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 					  struct ethtool_link_ksettings *cmd)
 {
@@ -2124,6 +2163,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_channels		= igc_ethtool_get_channels,
 	.get_mm			= igc_ethtool_get_mm,
 	.set_mm			= igc_ethtool_set_mm,
+	.get_mm_stats		= igc_ethtool_get_mm_stats,
 	.set_channels		= igc_ethtool_set_channels,
 	.get_priv_flags		= igc_ethtool_get_priv_flags,
 	.set_priv_flags		= igc_ethtool_set_priv_flags,
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 12ddc5793651..f40946cce35a 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -222,6 +222,25 @@
 
 #define IGC_FTQF(_n)	(0x059E0 + (4 * (_n)))  /* 5-tuple Queue Fltr */
 
+/* Time sync registers - preemption statistics */
+#define IGC_PRMEVNTTCNT		0x04298	/* TX Preemption event counter */
+#define IGC_PRMEVNTRCNT		0x0429C	/* RX Preemption event counter */
+#define IGC_PRMPTDRCNT		0x04284	/* Good RX Preempted Packets */
+
+ /* Preemption Exception Counter */
+#define IGC_PRMEXPRCNT					0x042A0
+/* Received out of order packets with SMD-C and NOT ReumeRx */
+#define IGC_PRMEXPRCNT_OOO_SMDC 0x000000FF
+/* Received out of order packets with SMD-C and wrong Frame CNT */
+#define IGC_PRMEXPRCNT_OOO_FRAME_CNT			0x0000FF00
+#define IGC_PRMEXPRCNT_OOO_FRAME_CNT_SHIFT		8
+/* Received out of order packets with SMD-C and wrong Frag CNT */
+#define IGC_PRMEXPRCNT_OOO_FRAG_CNT			0x00FF0000
+#define IGC_PRMEXPRCNT_OOO_FRAG_CNT_SHIFT		16
+/* Received packets with SMD-S and ReumeRx */
+#define IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT		0xFF000000
+#define IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT_SHIFT	24
+
 /* Transmit Scheduling Registers */
 #define IGC_TQAVCTRL		0x3570
 #define IGC_TXQCTL(_n)		(0x3344 + 0x4 * (_n))
-- 
2.25.1


