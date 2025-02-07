Return-Path: <bpf+bounces-50792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE37A2C9A0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 18:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967A516CDB6
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E11A8F6D;
	Fri,  7 Feb 2025 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FrAUFRWl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B6193409;
	Fri,  7 Feb 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738947498; cv=none; b=Pc9JMGMW8EvBBnnhFu2bMBsEM7KPtL/864tzooreKUkdR+QeUrtJULLs3ELZBkKjeflspoKFmfgJpgCopz6J5uWz9+cgPUCjVHVK5V6LIdDP9X4kqFeMZ1okf70W3gbv/jNE8hVbP+RULyEwRiJhyg3aZH3j5a4FI4cgQLGixPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738947498; c=relaxed/simple;
	bh=yLXa2yaR9NgwmMapus7AuHWRbw/3UQlE2Bja3/Bf6S4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yf9XyilrKWZyNZGqCYopvM5lcb04pJkNtTsVmc5EMWvDjBE0cAzeyBMqNWzstwoaouJlxiCRrD4lqeASRg7AXLkCempP67H7nFGSWv7EoqcuAFIiMjU4BSYTqv1Hxt+X9VxH8DS3fLGR9Kl19zdQ1V1q8EuEMijcVtJMMO4J7m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FrAUFRWl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738947497; x=1770483497;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yLXa2yaR9NgwmMapus7AuHWRbw/3UQlE2Bja3/Bf6S4=;
  b=FrAUFRWl8TdByrqtIXUprVHZ8eCAUBHYo/0Gjl3FqSN0AH0QppLoDGPs
   9Z59pWni4Qy7vGYrzb+ftElBCAz5Zy49HlXCkjNwre520m7WNu0+DjBml
   hzuEHYTNz0eNslW0y7032tEkhTo2pG9VYkQa8Bd6ea0Jjw7ps4TeKOlgc
   D+dFqtetfuu4hQ30V/lpg1Y1EeRff4nC2F68SdRTpNvmkvkkMZAbW4ROR
   hFUU1AzlNWeO50HKxa73Odg22VfqF+y74pHb4tuwIS8K83DgC7pvZjyKB
   XGLD6pBgRul4k55GDXxoGNSoQZXNaS3+mkNGYBTbC6RqP3K5NvVmzbR8S
   A==;
X-CSE-ConnectionGUID: pSr15YRySCmu6LxYd5dx8Q==
X-CSE-MsgGUID: n8Bf/QvxQ0C2pAICsuyaOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39723087"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39723087"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 08:58:17 -0800
X-CSE-ConnectionGUID: 3dCaZTDKQAO3v8G6d9C7rQ==
X-CSE-MsgGUID: 6QgvxFLLT/+mTQr13Bgo4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="111534667"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa006.jf.intel.com with ESMTP; 07 Feb 2025 08:58:08 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v3 9/9] igc: Add support to get frame preemption statistics via ethtool
Date: Fri,  7 Feb 2025 11:56:49 -0500
Message-Id: <20250207165649.2245320-10-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207165649.2245320-1-faizal.abdul.rahim@linux.intel.com>
References: <20250207165649.2245320-1-faizal.abdul.rahim@linux.intel.com>
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
      num_tc 4 map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
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
     TX minimum fragment size: 64
     RX minimum fragment size: 60
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
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 36 ++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_main.c    |  1 +
 drivers/net/ethernet/intel/igc/igc_regs.h    | 16 +++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 7f0052e0d50c..97a1194399b1 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1819,6 +1819,41 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
 	return igc_tsn_offload_apply(adapter);
 }
 
+/**
+ * igc_ethtool_get_frame_ass_error - Get the frame assembly error count.
+ * @dev: Pointer to the net_device structure.
+ * Return: The count of frame assembly errors.
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
+	ooo_smdc = FIELD_GET(IGC_PRMEXPRCNT_OOO_SMDC, reg_value);
+	ooo_frame_cnt = FIELD_GET(IGC_PRMEXPRCNT_OOO_FRAME_CNT, reg_value);
+	ooo_frag_cnt = FIELD_GET(IGC_PRMEXPRCNT_OOO_FRAG_CNT, reg_value);
+	miss_frame_frag_cnt = FIELD_GET(IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT,
+					reg_value);
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
+	stats->MACMergeFrameAssOkCount = rd32(IGC_PRMPTDRCNT);
+	stats->MACMergeFragCountRx =  rd32(IGC_PRMEVNTRCNT);
+	stats->MACMergeFragCountTx = rd32(IGC_PRMEVNTTCNT);
+}
+
 static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 					  struct ethtool_link_ksettings *cmd)
 {
@@ -2108,6 +2143,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.get_channels		= igc_ethtool_get_channels,
 	.get_mm			= igc_ethtool_get_mm,
 	.set_mm			= igc_ethtool_set_mm,
+	.get_mm_stats		= igc_ethtool_get_mm_stats,
 	.set_channels		= igc_ethtool_set_channels,
 	.get_priv_flags		= igc_ethtool_get_priv_flags,
 	.set_priv_flags		= igc_ethtool_set_priv_flags,
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f15ac7565fbd..cd5160315993 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3076,6 +3076,7 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 			break;
 
 		if (static_branch_unlikely(&igc_fpe_enabled) &&
+		    adapter->fpe.mmsv.pmac_enabled &&
 		    igc_fpe_transmitted_smd_v(tx_desc))
 			ethtool_mmsv_event_handle(&adapter->fpe.mmsv,
 						  ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET);
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 12ddc5793651..41dbfb07eb2f 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -222,6 +222,22 @@
 
 #define IGC_FTQF(_n)	(0x059E0 + (4 * (_n)))  /* 5-tuple Queue Fltr */
 
+/* Time sync registers - preemption statistics */
+#define IGC_PRMPTDRCNT		0x04284	/* Good RX Preempted Packets */
+#define IGC_PRMEVNTTCNT		0x04298	/* TX Preemption event counter */
+#define IGC_PRMEVNTRCNT		0x0429C	/* RX Preemption event counter */
+
+ /* Preemption Exception Counter */
+#define IGC_PRMEXPRCNT					0x42A0
+/* Received out of order packets with SMD-C */
+#define IGC_PRMEXPRCNT_OOO_SMDC				0x000000FF
+/* Received out of order packets with SMD-C and wrong Frame CNT */
+#define IGC_PRMEXPRCNT_OOO_FRAME_CNT			0x0000FF00
+/* Received out of order packets with SMD-C and wrong Frag CNT */
+#define IGC_PRMEXPRCNT_OOO_FRAG_CNT			0x00FF0000
+/* Received packets with SMD-S and wrong Frag CNT and Frame CNT */
+#define IGC_PRMEXPRCNT_MISS_FRAME_FRAG_CNT		0xFF000000
+
 /* Transmit Scheduling Registers */
 #define IGC_TQAVCTRL		0x3570
 #define IGC_TXQCTL(_n)		(0x3344 + 0x4 * (_n))
-- 
2.34.1


