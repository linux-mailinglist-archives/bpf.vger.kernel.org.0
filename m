Return-Path: <bpf+bounces-52748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517BA480AE
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 15:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B064189C75F
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2025 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39E23F40D;
	Thu, 27 Feb 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bEoyghUE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A723F266;
	Thu, 27 Feb 2025 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665017; cv=none; b=hRkS49yJTQNUmtIEN55ScngcAR7VBP5diCFmo4Kb3cCVJraP8uS9aRbtxuMOSn37iPxNq5I9v3A82e97lQeQk0P5LaIlEG5unMjT9whgJtQELLXQje1zIU0VICjKSfBfzyPMpV+dVU9DgPDGjJiKC5eZYI2MnotmSC3X3Xrv1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665017; c=relaxed/simple;
	bh=xhzXchOUSV8qoEw0td6GaGAwIOTup1QP7sni5ZbXwDA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HMEF62D9/jE00uU7I5ywVih9sCTLjIPPx5kUreViehN605H8tr8JY8MONx5W1WJ1Xye30ZTCMPl/xH/zegXGojyKMme+W6efOgKy39GpR9n6B7g4wWSgWTqCzIxfLqNyMwutAB8DEhCDUj+P2Oez6CqEnjFCdIO1/GGilphF1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bEoyghUE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665015; x=1772201015;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xhzXchOUSV8qoEw0td6GaGAwIOTup1QP7sni5ZbXwDA=;
  b=bEoyghUEhJuiaL4+56jW/CyMe6+RH/1guNbmdZNLudflYG8uqf1TRXyz
   raQF1CIJAHcJ76XArdFZ2rXicmn2TAeTOJjHRCpZ/8jr41uVIOLzyeF9D
   9xJ28EezauXcPT7VAoSyG9QzKP0+HLVfiCo52zSQoNb3VUe85vSWWLN/r
   Yam1789YH0eZT9421aDAGJtW5dhuY3Toev1jXt8BY72qlE4xlgk57Bp6y
   Jl1S+ZdPSuUoZXmf3zfvujUiPBK1Geru5yeNygW4sxfmPz/GNKr3hKZCI
   Uyex5beB5xJqOjEgc5sJyM9E62LRIKNyx/7bJFOyvAnoJtwKHhDns/NH9
   w==;
X-CSE-ConnectionGUID: Wg+EJLbyTKeaPB+mlov3RA==
X-CSE-MsgGUID: KOe/x1UOT5e9F5idrbchNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41752519"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41752519"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:03:35 -0800
X-CSE-ConnectionGUID: s24tQ372SEe0RYZoJGH60Q==
X-CSE-MsgGUID: HC/3ZfJ9SQ6jWL6UwSpX1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="122149858"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2025 06:03:27 -0800
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
Subject: [PATCH iwl-next v6 9/9] igc: Add support to get frame preemption statistics via ethtool
Date: Thu, 27 Feb 2025 09:01:57 -0500
Message-Id: <20250227140158.2129988-10-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227140158.2129988-1-faizal.abdul.rahim@linux.intel.com>
References: <20250227140158.2129988-1-faizal.abdul.rahim@linux.intel.com>
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
 drivers/net/ethernet/intel/igc/igc_regs.h    | 16 +++++++++
 2 files changed, 52 insertions(+)

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


