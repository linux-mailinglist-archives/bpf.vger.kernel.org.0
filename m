Return-Path: <bpf+bounces-54271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA708A66719
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 04:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31EA73B2230
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687F1C5F10;
	Tue, 18 Mar 2025 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TwJ5F5Rf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62719341F;
	Tue, 18 Mar 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742267418; cv=none; b=YFkHv4TQWs+DSOSUdnEiBy5eIosWwG5qookhv94zXb+gY78dbL+OAtZ2Bvj9VaaGIeiHEBYtCS6tG0gzH3pISod7bYyxVj+nOpBv6KL8Yy/wYTezzJHX4P+OmWTljJg8nXURiZWrMRPdiuFp4Mx+AMLNXCxL+WdAvr+vvyOYQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742267418; c=relaxed/simple;
	bh=3IZ4KIMokVKhdTfXCW+naj0KUzLIZ662FdCXfyXBtyQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sGsGYednHs1eOSVkLb3/edNK2hGkZ6TZoUqElzwGQ5VjOyfW/WgkeN1Qw23YLYv8m0a08kVfYQgrCdUIbKU5Sj64h/r8LzaXrBKibf65URY/dp+ZZR1FYDDJMT4EwrTfCWArS3OQ79OxTx2RH6Gnzc84ZU5BHtCwmaAnUfvgs20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TwJ5F5Rf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742267417; x=1773803417;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=3IZ4KIMokVKhdTfXCW+naj0KUzLIZ662FdCXfyXBtyQ=;
  b=TwJ5F5RfOieMEmLI+vX4XZCxsRyDeXDMSLyeG+Z2VCBil7Vs+gwne2as
   FfL7PoXBffOLrklW8qxm+31EaHj/nRFfzkw3rAdVuUInVxrCcaYhhl7XZ
   lj8IuWUpHi65OoYHRlqP6xbEVEjEN0d/GQmC0lJLa6TpsXU9yiEUkJ02d
   Ua62iSDiNQv1Bbxp4kgg/8IYqDnchDARUPOGA+pHN3qf6tKvm/FvJLq15
   LPfp0msaKVCoLkp+oGDSXUXnilY7q1nd+r9SN6UiA3eLiAiLsTfoNHacn
   Vm6efZJwUMugFTWHHhcOn0OTMT6CuFMnXBr6axoFQMbhqxcLXfFmlJKKz
   g==;
X-CSE-ConnectionGUID: a0uokgXvRRWfWEsJpmveWA==
X-CSE-MsgGUID: V1ZypqNCRaKr0jv3DHSE3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54383290"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="54383290"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:10:13 -0700
X-CSE-ConnectionGUID: oRlpz5nWTyqIvBViMP3UAA==
X-CSE-MsgGUID: 4BSoNZ57Qz6hE25r114VvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; 
   d="scan'208";a="126313976"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa003.fm.intel.com with ESMTP; 17 Mar 2025 20:10:05 -0700
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
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH iwl-next v10 14/14] igc: add support to get frame preemption statistics via ethtool
Date: Mon, 17 Mar 2025 23:07:42 -0400
Message-Id: <20250318030742.2567080-15-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
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
Co-developed-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 40 ++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    | 16 ++++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index fd4b4b332309..324a27a5bef9 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1819,6 +1819,45 @@ static int igc_ethtool_set_mm(struct net_device *netdev,
 	return igc_tsn_offload_apply(adapter);
 }
 
+/**
+ * igc_ethtool_get_frame_ass_error - Get the frame assembly error count.
+ * @reg_value: Register value for IGC_PRMEXCPRCNT
+ * Return: The count of frame assembly errors.
+ */
+static u64 igc_ethtool_get_frame_ass_error(u32 reg_value)
+{
+	/* Out of order statistics */
+	u32 ooo_frame_cnt, ooo_frag_cnt;
+	u32 miss_frame_frag_cnt;
+
+	ooo_frame_cnt = FIELD_GET(IGC_PRMEXCPRCNT_OOO_FRAME_CNT, reg_value);
+	ooo_frag_cnt = FIELD_GET(IGC_PRMEXCPRCNT_OOO_FRAG_CNT, reg_value);
+	miss_frame_frag_cnt = FIELD_GET(IGC_PRMEXCPRCNT_MISS_FRAME_FRAG_CNT, reg_value);
+
+	return ooo_frame_cnt + ooo_frag_cnt + miss_frame_frag_cnt;
+}
+
+static u64 igc_ethtool_get_frame_smd_error(u32 reg_value)
+{
+	return FIELD_GET(IGC_PRMEXCPRCNT_OOO_SMDC, reg_value);
+}
+
+static void igc_ethtool_get_mm_stats(struct net_device *dev,
+				     struct ethtool_mm_stats *stats)
+{
+	struct igc_adapter *adapter = netdev_priv(dev);
+	struct igc_hw *hw = &adapter->hw;
+	u32 reg_value;
+
+	reg_value = rd32(IGC_PRMEXCPRCNT);
+
+	stats->MACMergeFrameAssErrorCount = igc_ethtool_get_frame_ass_error(reg_value);
+	stats->MACMergeFrameSmdErrorCount = igc_ethtool_get_frame_smd_error(reg_value);
+	stats->MACMergeFrameAssOkCount = rd32(IGC_PRMPTDRCNT);
+	stats->MACMergeFragCountRx = rd32(IGC_PRMEVNTRCNT);
+	stats->MACMergeFragCountTx = rd32(IGC_PRMEVNTTCNT);
+}
+
 static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 					  struct ethtool_link_ksettings *cmd)
 {
@@ -2115,6 +2154,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.set_link_ksettings	= igc_ethtool_set_link_ksettings,
 	.self_test		= igc_ethtool_diag_test,
 	.get_mm			= igc_ethtool_get_mm,
+	.get_mm_stats		= igc_ethtool_get_mm_stats,
 	.set_mm			= igc_ethtool_set_mm,
 };
 
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index 12ddc5793651..f343c6bfc6be 100644
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
+ #define IGC_PRMEXCPRCNT				0x42A0
+/* Received out of order packets with SMD-C */
+#define IGC_PRMEXCPRCNT_OOO_SMDC			0x000000FF
+/* Received out of order packets with SMD-C and wrong Frame CNT */
+#define IGC_PRMEXCPRCNT_OOO_FRAME_CNT			0x0000FF00
+/* Received out of order packets with SMD-C and wrong Frag CNT */
+#define IGC_PRMEXCPRCNT_OOO_FRAG_CNT			0x00FF0000
+/* Received packets with SMD-S and wrong Frag CNT and Frame CNT */
+#define IGC_PRMEXCPRCNT_MISS_FRAME_FRAG_CNT		0xFF000000
+
 /* Transmit Scheduling Registers */
 #define IGC_TQAVCTRL		0x3570
 #define IGC_TXQCTL(_n)		(0x3344 + 0x4 * (_n))
-- 
2.34.1


