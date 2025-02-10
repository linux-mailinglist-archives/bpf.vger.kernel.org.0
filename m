Return-Path: <bpf+bounces-50924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FADA2E517
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82478188D207
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C31AF0C8;
	Mon, 10 Feb 2025 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e4s0c5fu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983F1A8F74;
	Mon, 10 Feb 2025 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739171006; cv=none; b=ujEN4G5/6I05reyK2tpdeJ/29iMKjrpP+KoCcx2VmGVbXEjXFeGYqRnoddRMRy7DgQ7VTXbS8a8GIkzERcG1DfjVWn9vzGWz/62V0DcDkC8PLjEYzwWeCJwhg6IGUe8OX27+haHqMxq3jl+e2X+pZOkhCrJbz0ndwD9APshNgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739171006; c=relaxed/simple;
	bh=yfoLftM53gEBi2NtetlmUHZ2y4RL0eOCMwT4QgPa3hU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfxxC8euC/jqw1rplqeG2HNCxYvA7A8PCbFTqknh7vOqnAbdyzX8kG2tvtiQ4KEHIum3iTjq/v8LZh4IejYldlgfbZjS6oSUXWePGQu2sHveG9VTvS9itzGe+FSU+/JDxQOkzOi6VsOzJZ0J4Kg6hiJT4ZcA0Nl5dDXwUM17XsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e4s0c5fu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739171005; x=1770707005;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yfoLftM53gEBi2NtetlmUHZ2y4RL0eOCMwT4QgPa3hU=;
  b=e4s0c5fu94w5sphYsny8EtERawsDCECzvPcFtTO9usRRLodQyfz9mQX4
   dtAThm5RdAjHYJFjCpu5Q3Wn11lsyV7i4E9LXwmYid6gWR8E2DpCDeeYZ
   4hPrlD4kM4QtHJDtcZ4jCUEZxzGyRIuRVTzr9EhXjtM75Prwj3QcNfI//
   EQdjAFNfmhGYamJS3+mBiKkSGordgzImNsz6JfFHq3U0u98qUHKvaEfr5
   t3qX6yRBngnLXxKj95UyhR0V2BtYaKPN4HCtuT/RlxUYHS79mIgQZ9i4k
   5Ceg8SJjZxMFfbj36Uh5zhNIBfe/yEc7ACF8zpNOmt92woVj7/QM/1GG7
   A==;
X-CSE-ConnectionGUID: b/hm1pOST0CrGjOzWc5Efg==
X-CSE-MsgGUID: P/e7lRs/SNauXHoDXQshpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="38938072"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="38938072"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 23:03:17 -0800
X-CSE-ConnectionGUID: 5kEUVA6ETeeEFntjn+A8yA==
X-CSE-MsgGUID: spbKkz/MS/i6LoG0V1zWAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112622698"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa010.fm.intel.com with ESMTP; 09 Feb 2025 23:03:09 -0800
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
Subject: [PATCH iwl-next v4 7/9] igc: Add support for preemptible traffic class in taprio
Date: Mon, 10 Feb 2025 02:02:05 -0500
Message-Id: <20250210070207.2615418-8-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
References: <20250210070207.2615418-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set queue as preemptible or express via taprio.
This will eventually set queue-specific preemptible field in TXQCTL
register.

Implement configure_tx(), a callback triggered by mmsv, to set tx_enabled
and update preemptible queue settings. tx_enabled is a new field that
serves as a condition in igc_tsn_enable_offload() before configuring the
preemptible queue. This provides some control over FPE in TX, despite
lacking a dedicated register.

Verified that the correct preemptible hardware queue is set using the
following commands:

a) 1:1 TC-to-Queue Mapping
   $ sudo tc qdisc replace dev enp1s0 parent root handle 100 \
     taprio num_tc 4 map 3 2 1 0 3 3 3 3 3 3 3 3 3 3 3 3 \
     queues 1@0 1@1 1@2 1@3 base-time 0 sched-entry S F 100000 \
     fp E E P P

b) Non-1:1 TC-to-Queue Mapping
   $ sudo tc qdisc replace  dev enp1s0 parent root handle 100 \
     taprio num_tc 3 map 2 1 0 2 2 2 2 2 2 2 2 2 2 2 2 2
     queues 2@0 1@2 1@3
     fp E E P

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  3 +-
 drivers/net/ethernet/intel/igc/igc_defines.h |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c    | 36 ++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 17 +++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 2f3662143589..59e6fca808e4 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -43,6 +43,7 @@ void igc_ethtool_set_ops(struct net_device *);
 struct fpe_t {
 	struct ethtool_mmsv mmsv;
 	u32 tx_min_frag_size;
+	bool tx_enabled;
 };
 
 enum igc_mac_filter_type {
@@ -163,7 +164,7 @@ struct igc_ring {
 	bool launchtime_enable;         /* true if LaunchTime is enabled */
 	ktime_t last_tx_cycle;          /* end of the cycle with a launchtime transmission */
 	ktime_t last_ff_cycle;          /* Last cycle with an active first flag */
-
+	bool preemptible;               /* True if not express */
 	u32 start_time;
 	u32 end_time;
 	u32 max_sdu;
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 038ee89f1e08..208899e67308 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -556,6 +556,7 @@
 #define IGC_TXQCTL_QUEUE_MODE_LAUNCHT	0x00000001
 #define IGC_TXQCTL_STRICT_CYCLE		0x00000002
 #define IGC_TXQCTL_STRICT_END		0x00000004
+#define IGC_TXQCTL_PREEMPTIBLE		0x00000008
 #define IGC_TXQCTL_QAV_SEL_MASK		0x000000C0
 #define IGC_TXQCTL_QAV_SEL_CBS0		0x00000080
 #define IGC_TXQCTL_QAV_SEL_CBS1		0x000000C0
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7fe6875d7bf7..f15ac7565fbd 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6258,6 +6258,39 @@ static bool is_base_time_past(ktime_t base_time, const struct timespec64 *now)
 	return timespec64_compare(now, &b) > 0;
 }
 
+static u32 igc_map_tc_to_queue(const struct igc_adapter *adapter,
+			       unsigned long preemptible_tcs)
+{
+	struct net_device *dev = adapter->netdev;
+	u32 i, queue = 0;
+
+	for (i = 0; i < dev->num_tc; i++) {
+		u32 offset, count;
+
+		if (!(preemptible_tcs & BIT(i)))
+			continue;
+
+		offset = dev->tc_to_txq[i].offset;
+		count = dev->tc_to_txq[i].count;
+		queue |= GENMASK(offset + count - 1, offset);
+	}
+
+	return queue;
+}
+
+static void igc_save_preempt_queue(struct igc_adapter *adapter,
+				   const struct tc_mqprio_qopt_offload *mqprio)
+{
+	u32 preemptible_queue = igc_map_tc_to_queue(adapter,
+						    mqprio->preemptible_tcs);
+
+	for (int i = 0; i < adapter->num_tx_queues; i++) {
+		struct igc_ring *tx_ring = adapter->tx_ring[i];
+
+		tx_ring->preemptible = preemptible_queue & BIT(i);
+	}
+}
+
 static bool validate_schedule(struct igc_adapter *adapter,
 			      const struct tc_taprio_qopt_offload *qopt)
 {
@@ -6344,6 +6377,7 @@ static int igc_qbv_clear_schedule(struct igc_adapter *adapter)
 		ring->start_time = 0;
 		ring->end_time = NSEC_PER_SEC;
 		ring->max_sdu = 0;
+		ring->preemptible = false;
 	}
 
 	spin_lock_irqsave(&adapter->qbv_tx_lock, flags);
@@ -6500,6 +6534,8 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 			ring->max_sdu = 0;
 	}
 
+	igc_save_preempt_queue(adapter, &qopt->mqprio);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 57fc4a876304..f077ab6e0d6e 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -121,6 +121,18 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
 	return err;
 }
 
+static void igc_fpe_configure_tx(struct ethtool_mmsv *mmsv, bool tx_enable)
+{
+	struct fpe_t *fpe = container_of(mmsv, struct fpe_t, mmsv);
+	struct igc_adapter *adapter;
+
+	adapter = container_of(fpe, struct igc_adapter, fpe);
+	adapter->fpe.tx_enabled = tx_enable;
+
+	/* Update config since tx_enabled affects preemptible queue configuration */
+	igc_tsn_offload_apply(adapter);
+}
+
 static void igc_fpe_send_mpacket(struct ethtool_mmsv *mmsv,
 				 enum ethtool_mpacket type)
 {
@@ -142,12 +154,14 @@ static void igc_fpe_send_mpacket(struct ethtool_mmsv *mmsv,
 }
 
 static const struct ethtool_mmsv_ops igc_mmsv_ops = {
+	.configure_tx = igc_fpe_configure_tx,
 	.send_mpacket = igc_fpe_send_mpacket,
 };
 
 void igc_fpe_init(struct igc_adapter *adapter)
 {
 	adapter->fpe.tx_min_frag_size = TX_MIN_FRAG_SIZE;
+	adapter->fpe.tx_enabled = false;
 	ethtool_mmsv_init(&adapter->fpe.mmsv, adapter->netdev, &igc_mmsv_ops);
 }
 
@@ -455,6 +469,9 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		if (ring->launchtime_enable)
 			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
 
+		if (adapter->fpe.tx_enabled && ring->preemptible)
+			txqctl |= IGC_TXQCTL_PREEMPTIBLE;
+
 		/* Skip configuring CBS for Q2 and Q3 */
 		if (i > 1)
 			goto skip_cbs;
-- 
2.34.1


