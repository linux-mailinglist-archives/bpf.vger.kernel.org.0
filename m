Return-Path: <bpf+bounces-50503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C3A2877C
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 11:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993D418896D1
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B744F22B5AD;
	Wed,  5 Feb 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e3xyxNCd"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE322A80B;
	Wed,  5 Feb 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738749977; cv=none; b=HT+VZwQjagrjdajgqOtlZgQeugpNS5cWnRIdQtai15coKGIVajTdHwNfTtD+nSlmY/5WJMS6IKQNOXtAP1pjAmWl/0fW7ZD7QVm/XB7xQL4kSe4H2eM3aMFnSjkaBbTjTybHtPUeXabZVAcifBIyOf/UeBduuI8+ZCNwPUWSX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738749977; c=relaxed/simple;
	bh=m1nIzWs06AanBrJnD4cbNoscp4yRzWZnOCCF13NFqwk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etdgsR1LgaVMaMKoGX6oWGTTMaqUYxBPYZSQ0gVzhDY4IE61epjdv2Yv1OamEmJzxrsd2roJ2VqMzvJ+6UgPcUIjJaAk8tBk1/Il1Yr9LrhMMZzeHLXE1ss5I3vb0vgRSzhaR5sqrz39d5Q6FAwCagmvCqcVzFCdJjYlMHyzIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e3xyxNCd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738749975; x=1770285975;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=m1nIzWs06AanBrJnD4cbNoscp4yRzWZnOCCF13NFqwk=;
  b=e3xyxNCdBr+avHxiUu4R9H/9pJ7FUvLAd3JgHFeaM3eto319unDG3uxf
   meLcJlXie0PD/gtrl5YTI03gP/8mC2NP0Mph1S6Jv7ni+8/kZjZnT22/0
   hK9i95KrnwIKyQSmGhLr3w0YuiMXYu52GsAoUFkGMbzql/X/AiVhxCf+B
   9cdmpq94QENIOor2vS8+h3QeHAD1Aoy1geGSDEcr+5cB+IoBeZRZIjLT1
   F/JU0zyU7XSlxs8c/rHV0FkKH+z534hEo/8qPhEoPGWd87yZvMP4IhTr8
   63bBiDRUE8M5Kftnsd79pwWvqdYJWqjYRpet9tNJr4YV5fYITvjQ2Po6L
   Q==;
X-CSE-ConnectionGUID: Zp/0mVlhTfqwyo9GsJOmqw==
X-CSE-MsgGUID: r5CjyxmpQAG49qMIAYs5TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50699159"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="50699159"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 02:06:14 -0800
X-CSE-ConnectionGUID: xT6a6RyCTPu/RkB2k1KF/Q==
X-CSE-MsgGUID: 1ZMHjD+ATXqAra7YRxBgMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111297741"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 05 Feb 2025 02:06:06 -0800
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
	Russell King <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v2 5/9] igc: Add support for frame preemption verification
Date: Wed,  5 Feb 2025 05:05:20 -0500
Message-Id: <20250205100524.1138523-6-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205100524.1138523-1-faizal.abdul.rahim@linux.intel.com>
References: <20250205100524.1138523-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch implements the "ethtool --set-mm" callback to trigger the
frame preemption verification handshake.

Uses the MAC Merge Software Verification (mmsv) mechanism in ethtool
to perform the verification handshake for igc.
The structure fpe.mmsv is set by mmsv in ethtool and should remain
read-only for the driver.

igc does not use two mmsv callbacks:
a) configure_tx()
   - igc lacks registers to configure FPE in the transmit direction.

b) configure_pmac()
   - this callback dynamically controls pmac_enabled at runtime. For
     example, mmsv calls configure_pmac() and disables pmac_enabled when
     the link partner goes down, even if the user previously enabled it.
     The intention is to save power but it is not feasible in igc
     because it causes an endless adapter reset loop:

	 1) Board A and Board B complete the verification handshake.
            Tx mode register for both boards are in TSN mode.
	 2) Board B link goes down.

         On Board A:
	 3) mmsv calls configure_pmac() with pmac_enabled = false.
	 4) configure_pmac() in igc updates a new field based on
            pmac_enabled. Driver uses this field in igc_tsn_new_flags()
            to indicate that the user enabled/disabled FPE.
	 5) configure_pmac() in igc calls igc_tsn_offload_apply() to check
            whether an adapter reset is needed. Calls existing logic in
            igc_tsn_will_tx_mode_change() and igc_tsn_new_flags().
	 6) Since pmac_enabled is now disabled and no other TSN feature
            is active, igc_tsn_will_tx_mode_change() evaluates to true
            because Tx mode will switch from TSN to Legacy.
	 7) Driver resets the adapter.
	 8) Registers are set, and Tx mode switches to Legacy.
	 9) When link partner is up, steps 3–8 repeat, but this time
            with pmac_enabled = true, reactivating TSN.
            igc_tsn_will_tx_mode_change() evaluates to true again,
            since Tx mode will switch from Legacy to TSN.
	10) Driver resets the adapter.
	11) Rest adapter completes, registers are set, and Tx mode
	    switches to TSN.

        On Board B:
	12) Adapter reset on Board A at step 10 causes it to detect its
            link partner as down.
	13) Repeats steps 3–8.
	14) Once reset adapter on Board A is completed at step 11, it
            detects its link partner as up.
	15) Repeats steps 9–11.

   - this cycle repeats indefinitely. To avoid this issue, IGC only uses
     mmsv.pmac_enabled to track whether FPE is enabled or disabled.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         |  12 +-
 drivers/net/ethernet/intel/igc/igc_defines.h |  10 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  19 +++
 drivers/net/ethernet/intel/igc/igc_main.c    |  50 +++++-
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 160 ++++++++++++++++++-
 drivers/net/ethernet/intel/igc/igc_tsn.h     |  33 ++++
 6 files changed, 279 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 22ecdac26cf4..705bd4739e3b 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -40,6 +40,10 @@ void igc_ethtool_set_ops(struct net_device *);
 
 #define IGC_MAX_TX_TSTAMP_REGS		4
 
+struct fpe_t {
+	struct ethtool_mmsv mmsv;
+};
+
 enum igc_mac_filter_type {
 	IGC_MAC_FILTER_TYPE_DST = 0,
 	IGC_MAC_FILTER_TYPE_SRC
@@ -332,6 +336,8 @@ struct igc_adapter {
 		struct timespec64 period;
 	} perout[IGC_N_PEROUT];
 
+	struct fpe_t fpe;
+
 	/* LEDs */
 	struct mutex led_mutex;
 	struct igc_led_classdev *leds;
@@ -389,10 +395,11 @@ extern char igc_driver_name[];
 #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
 #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
 #define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
+#define IGC_FLAG_TSN_PREEMPT_ENABLED	BIT(20)
 
 #define IGC_FLAG_TSN_ANY_ENABLED				\
 	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
-	 IGC_FLAG_TSN_LEGACY_ENABLED)
+	 IGC_FLAG_TSN_LEGACY_ENABLED | IGC_FLAG_TSN_PREEMPT_ENABLED)
 
 #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
 #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
@@ -736,7 +743,10 @@ struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 				      u32 location);
 int igc_add_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
 void igc_del_nfc_rule(struct igc_adapter *adapter, struct igc_nfc_rule *rule);
+void igc_disable_empty_addr_recv(struct igc_adapter *adapter);
+int igc_enable_empty_addr_recv(struct igc_adapter *adapter);
 struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu);
+void igc_flush_tx_descriptors(struct igc_ring *ring);
 void igc_ptp_init(struct igc_adapter *adapter);
 void igc_ptp_reset(struct igc_adapter *adapter);
 void igc_ptp_suspend(struct igc_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index b19ac6f30dac..563b154c3e94 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -308,6 +308,10 @@
 #define IGC_TXD_DTYP_C		0x00000000 /* Context Descriptor */
 #define IGC_TXD_POPTS_IXSM	0x01       /* Insert IP checksum */
 #define IGC_TXD_POPTS_TXSM	0x02       /* Insert TCP/UDP checksum */
+#define IGC_TXD_POPTS_SMD_V	0x01       /* Transmitted packet is a SMD-Verify */
+#define IGC_TXD_POPTS_SMD_R	0x02       /* Transmitted packet is a SMD-Response */
+#define IGC_TXD_POPTS_SMD_SHIFT	12
+#define IGC_TXD_POPTS_SMD_MASK	0x3000
 #define IGC_TXD_CMD_EOP		0x01000000 /* End of Packet */
 #define IGC_TXD_CMD_IC		0x04000000 /* Insert Checksum */
 #define IGC_TXD_CMD_DEXT	0x20000000 /* Desc extension (0 = legacy) */
@@ -363,6 +367,8 @@
 #define IGC_SRRCTL_TIMER0SEL(timer)	(((timer) & 0x3) << 17)
 
 /* Receive Descriptor bit definitions */
+#define IGC_RXD_STAT_SMD_TYPE_V	0x01	/* SMD-V Packet */
+#define IGC_RXD_STAT_SMD_TYPE_R	0x02	/* SMD-R Packet */
 #define IGC_RXD_STAT_EOP	0x02	/* End of Packet */
 #define IGC_RXD_STAT_IXSM	0x04	/* Ignore checksum */
 #define IGC_RXD_STAT_UDPCS	0x10	/* UDP xsum calculated */
@@ -372,7 +378,8 @@
 #define IGC_RXDEXT_STATERR_LB	0x00040000
 
 /* Advanced Receive Descriptor bit definitions */
-#define IGC_RXDADV_STAT_TSIP	0x08000 /* timestamp in packet */
+#define IGC_RXDADV_STAT_SMD_TYPE_MASK	0x06000
+#define IGC_RXDADV_STAT_TSIP		0x08000 /* timestamp in packet */
 
 #define IGC_RXDEXT_STATERR_L4E		0x20000000
 #define IGC_RXDEXT_STATERR_IPE		0x40000000
@@ -543,6 +550,7 @@
 
 /* Transmit Scheduling */
 #define IGC_TQAVCTRL_TRANSMIT_MODE_TSN	0x00000001
+#define IGC_TQAVCTRL_PREEMPT_ENA	0x00000002
 #define IGC_TQAVCTRL_ENHANCED_QAV	0x00000008
 #define IGC_TQAVCTRL_FUTSCDDIS		0x00000080
 
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 817838677817..41cb03816f92 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -8,6 +8,7 @@
 
 #include "igc.h"
 #include "igc_diag.h"
+#include "igc_tsn.h"
 
 /* forward declaration */
 struct igc_stats {
@@ -1781,6 +1782,23 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 	return 0;
 }
 
+static int igc_ethtool_set_mm(struct net_device *netdev,
+			      struct ethtool_mm_cfg *cmd,
+			      struct netlink_ext_ack *extack)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct fpe_t *fpe = &adapter->fpe;
+
+	ethtool_mmsv_set_mm(&fpe->mmsv, cmd);
+
+	if (fpe->mmsv.pmac_enabled)
+		static_branch_enable(&igc_fpe_enabled);
+	else
+		static_branch_disable(&igc_fpe_enabled);
+
+	return igc_tsn_offload_apply(adapter);
+}
+
 static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 					  struct ethtool_link_ksettings *cmd)
 {
@@ -2068,6 +2086,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.set_rxfh		= igc_ethtool_set_rxfh,
 	.get_ts_info		= igc_ethtool_get_ts_info,
 	.get_channels		= igc_ethtool_get_channels,
+	.set_mm			= igc_ethtool_set_mm,
 	.set_channels		= igc_ethtool_set_channels,
 	.get_priv_flags		= igc_ethtool_get_priv_flags,
 	.set_priv_flags		= igc_ethtool_set_priv_flags,
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 44e4f925491f..396410522e01 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2529,7 +2529,7 @@ static int igc_xdp_run_prog(struct igc_adapter *adapter, struct xdp_buff *xdp)
 }
 
 /* This function assumes __netif_tx_lock is held by the caller. */
-static void igc_flush_tx_descriptors(struct igc_ring *ring)
+void igc_flush_tx_descriptors(struct igc_ring *ring)
 {
 	/* Once tail pointer is updated, hardware can fetch the descriptors
 	 * any time so we issue a write membar here to ensure all memory
@@ -2618,6 +2618,15 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 			size -= IGC_TS_HDR_LEN;
 		}
 
+		if (static_branch_unlikely(&igc_fpe_enabled) &&
+		    igc_fpe_is_verify_or_response(rx_desc, size)) {
+			igc_fpe_lp_event_status(rx_desc, &adapter->fpe.mmsv);
+			/* Advance the ring next-to-clean */
+			igc_is_non_eop(rx_ring, rx_desc);
+			cleaned_count++;
+			continue;
+		}
+
 		if (!skb) {
 			xdp_init_buff(&ctx.xdp, truesize, &rx_ring->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, pktbuf - igc_rx_offset(rx_ring),
@@ -3065,6 +3074,11 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
 		if (!(eop_desc->wb.status & cpu_to_le32(IGC_TXD_STAT_DD)))
 			break;
 
+		if (static_branch_unlikely(&igc_fpe_enabled) &&
+		    igc_fpe_transmitted_smd_v(tx_desc))
+			ethtool_mmsv_event_handle(&adapter->fpe.mmsv,
+						  ETHTOOL_MMSV_LD_SENT_VERIFY_MPACKET);
+
 		/* Hold the completions while there's a pending tx hardware
 		 * timestamp request from XDP Tx metadata.
 		 */
@@ -3956,6 +3970,30 @@ static int igc_uc_unsync(struct net_device *netdev, const unsigned char *addr)
 	return 0;
 }
 
+/**
+ * igc_enable_empty_addr_recv - Enable rx of packets with all-zeroes MAC address
+ * @adapter: Pointer to the igc_adapter structure.
+ *
+ * Frame preemption verification requires that packets with the all-zeroes
+ * MAC address are allowed to be received by IGC. This function adds the
+ * all-zeroes destination address to the list of acceptable addresses.
+ *
+ * Return: 0 on success, negative value otherwise.
+ */
+int igc_enable_empty_addr_recv(struct igc_adapter *adapter)
+{
+	u8 empty[ETH_ALEN] = { };
+
+	return igc_add_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST, empty, -1);
+}
+
+void igc_disable_empty_addr_recv(struct igc_adapter *adapter)
+{
+	u8 empty[ETH_ALEN] = { };
+
+	igc_del_mac_filter(adapter, IGC_MAC_FILTER_TYPE_DST, empty);
+}
+
 /**
  * igc_set_rx_mode - Secondary Unicast, Multicast and Promiscuous mode set
  * @netdev: network interface device structure
@@ -5755,6 +5793,10 @@ static void igc_watchdog_task(struct work_struct *work)
 			 */
 			igc_tsn_adjust_txtime_offset(adapter);
 
+			if (adapter->fpe.mmsv.pmac_enabled)
+				ethtool_mmsv_link_state_handle(&adapter->fpe.mmsv,
+							       true);
+
 			if (adapter->link_speed != SPEED_1000)
 				goto no_wait;
 
@@ -5790,6 +5832,10 @@ static void igc_watchdog_task(struct work_struct *work)
 			netdev_info(netdev, "NIC Link is Down\n");
 			netif_carrier_off(netdev);
 
+			if (adapter->fpe.mmsv.pmac_enabled)
+				ethtool_mmsv_link_state_handle(&adapter->fpe.mmsv,
+							       false);
+
 			/* link state has changed, schedule phy info update */
 			if (!test_bit(__IGC_DOWN, &adapter->state))
 				mod_timer(&adapter->phy_info_timer,
@@ -7110,6 +7156,8 @@ static int igc_probe(struct pci_dev *pdev,
 
 	igc_tsn_clear_schedule(adapter);
 
+	igc_fpe_init(adapter);
+
 	/* reset the hardware with the new settings */
 	igc_reset(adapter);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index f0213cfce07d..52ff6f324d79 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -1,10 +1,153 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c)  2019 Intel Corporation */
 
+#include <linux/kernel.h>
 #include "igc.h"
+#include "igc_base.h"
 #include "igc_hw.h"
 #include "igc_tsn.h"
 
+DEFINE_STATIC_KEY_FALSE(igc_fpe_enabled);
+
+static int igc_fpe_init_smd_frame(struct igc_ring *ring,
+				  struct igc_tx_buffer *buffer,
+				  struct sk_buff *skb)
+{
+	dma_addr_t dma = dma_map_single(ring->dev, skb->data, skb->len,
+					DMA_TO_DEVICE);
+
+	if (dma_mapping_error(ring->dev, dma)) {
+		netdev_err_once(ring->netdev, "Failed to map DMA for TX\n");
+		return -ENOMEM;
+	}
+
+	buffer->skb = skb;
+	buffer->protocol = 0;
+	buffer->bytecount = skb->len;
+	buffer->gso_segs = 1;
+	buffer->time_stamp = jiffies;
+	dma_unmap_len_set(buffer, len, skb->len);
+	dma_unmap_addr_set(buffer, dma, dma);
+
+	return 0;
+}
+
+static int igc_fpe_init_tx_descriptor(struct igc_ring *ring,
+				      struct sk_buff *skb, int type)
+{
+	struct igc_tx_buffer *buffer;
+	union igc_adv_tx_desc *desc;
+	u32 cmd_type, olinfo_status;
+	int err;
+
+	if (!igc_desc_unused(ring))
+		return -EBUSY;
+
+	if (type != IGC_TXD_POPTS_SMD_V && type != IGC_TXD_POPTS_SMD_R)
+		return -EINVAL;
+
+	buffer = &ring->tx_buffer_info[ring->next_to_use];
+	err = igc_fpe_init_smd_frame(ring, buffer, skb);
+	if (err)
+		return err;
+
+	cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
+		   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
+		   buffer->bytecount;
+	olinfo_status = buffer->bytecount << IGC_ADVTXD_PAYLEN_SHIFT;
+
+	switch (type) {
+	case IGC_TXD_POPTS_SMD_V:
+		olinfo_status |= (IGC_TXD_POPTS_SMD_V << IGC_TXD_POPTS_SMD_SHIFT);
+		break;
+	case IGC_TXD_POPTS_SMD_R:
+		olinfo_status |= (IGC_TXD_POPTS_SMD_R << IGC_TXD_POPTS_SMD_SHIFT);
+		break;
+	}
+
+	desc = IGC_TX_DESC(ring, ring->next_to_use);
+	desc->read.cmd_type_len = cpu_to_le32(cmd_type);
+	desc->read.olinfo_status = cpu_to_le32(olinfo_status);
+	desc->read.buffer_addr = cpu_to_le64(dma_unmap_addr(buffer, dma));
+
+	netdev_tx_sent_queue(txring_txq(ring), skb->len);
+
+	buffer->next_to_watch = desc;
+	ring->next_to_use = (ring->next_to_use + 1) % ring->count;
+
+	return 0;
+}
+
+bool igc_fpe_transmitted_smd_v(union igc_adv_tx_desc *tx_desc)
+{
+	u8 smd = FIELD_GET(IGC_TXD_POPTS_SMD_MASK, tx_desc->read.olinfo_status);
+
+	return smd == IGC_TXD_POPTS_SMD_V;
+}
+
+static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter, int type)
+{
+	int cpu = smp_processor_id();
+	struct netdev_queue *nq;
+	struct igc_ring *ring;
+	struct sk_buff *skb;
+	void *data;
+	int err;
+
+	if (!netif_running(adapter->netdev))
+		return -ENOTCONN;
+
+	ring = igc_get_tx_ring(adapter, cpu);
+	nq = txring_txq(ring);
+
+	skb = alloc_skb(SMD_FRAME_SIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	data = skb_put(skb, SMD_FRAME_SIZE);
+	memset(data, 0, SMD_FRAME_SIZE);
+
+	__netif_tx_lock(nq, cpu);
+
+	err = igc_fpe_init_tx_descriptor(ring, skb, type);
+	igc_flush_tx_descriptors(ring);
+
+	__netif_tx_unlock(nq);
+
+	return err;
+}
+
+static void igc_fpe_send_mpacket(struct ethtool_mmsv *mmsv,
+				 enum ethtool_mpacket type)
+{
+	struct fpe_t *fpe = container_of(mmsv, struct fpe_t, mmsv);
+	struct igc_adapter *adapter;
+	int err;
+
+	adapter = container_of(fpe, struct igc_adapter, fpe);
+
+	if (type == ETHTOOL_MPACKET_VERIFY) {
+		err = igc_fpe_xmit_smd_frame(adapter, IGC_TXD_POPTS_SMD_V);
+		if (err)
+			netdev_err(adapter->netdev, "Error sending SMD-V\n");
+	} else if (type == ETHTOOL_MPACKET_RESPONSE) {
+		err = igc_fpe_xmit_smd_frame(adapter, IGC_TXD_POPTS_SMD_R);
+		if (err)
+			netdev_err(adapter->netdev, "Error sending SMD-R frame\n");
+	}
+}
+
+static const struct ethtool_mmsv_ops igc_mmsv_ops = {
+	.send_mpacket = igc_fpe_send_mpacket,
+};
+
+void igc_fpe_init(struct igc_adapter *adapter)
+{
+	struct fpe_t *fpe = &adapter->fpe;
+
+	ethtool_mmsv_init(&adapter->fpe.mmsv, adapter->netdev, &igc_mmsv_ops);
+}
+
 static bool is_any_launchtime(struct igc_adapter *adapter)
 {
 	int i;
@@ -49,6 +192,9 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 	if (adapter->strict_priority_enable)
 		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
 
+	if (adapter->fpe.mmsv.pmac_enabled)
+		new_flags |= IGC_FLAG_TSN_PREEMPT_ENABLED;
+
 	return new_flags;
 }
 
@@ -148,7 +294,8 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 
 	tqavctrl = rd32(IGC_TQAVCTRL);
 	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
-		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS);
+		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS |
+		      IGC_TQAVCTRL_PREEMPT_ENA);
 
 	wr32(IGC_TQAVCTRL, tqavctrl);
 
@@ -370,10 +517,14 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		wr32(IGC_TXQCTL(i), txqctl);
 	}
 
-	tqavctrl = rd32(IGC_TQAVCTRL) & ~IGC_TQAVCTRL_FUTSCDDIS;
+	tqavctrl = rd32(IGC_TQAVCTRL) & ~(IGC_TQAVCTRL_FUTSCDDIS |
+		   IGC_TQAVCTRL_PREEMPT_ENA);
 
 	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
 
+	if (adapter->fpe.mmsv.pmac_enabled)
+		tqavctrl |= IGC_TQAVCTRL_PREEMPT_ENA;
+
 	adapter->qbv_count++;
 
 	cycle = adapter->cycle_time;
@@ -434,6 +585,11 @@ int igc_tsn_reset(struct igc_adapter *adapter)
 	unsigned int new_flags;
 	int err = 0;
 
+	if (adapter->fpe.mmsv.pmac_enabled)
+		igc_enable_empty_addr_recv(adapter);
+	else
+		igc_disable_empty_addr_recv(adapter);
+
 	new_flags = igc_tsn_new_flags(adapter);
 
 	if (!(new_flags & IGC_FLAG_TSN_ANY_ENABLED))
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index 98ec845a86bf..889d70c6d827 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -4,9 +4,42 @@
 #ifndef _IGC_TSN_H_
 #define _IGC_TSN_H_
 
+#define SMD_FRAME_SIZE			60
+
+DECLARE_STATIC_KEY_FALSE(igc_fpe_enabled);
+
+void igc_fpe_init(struct igc_adapter *adapter);
+u32 igc_fpe_get_supported_frag_size(u32 user_frag_size);
+bool igc_fpe_transmitted_smd_v(union igc_adv_tx_desc *tx_desc);
 int igc_tsn_offload_apply(struct igc_adapter *adapter);
 int igc_tsn_reset(struct igc_adapter *adapter);
 void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
 bool igc_tsn_is_taprio_activated_by_user(struct igc_adapter *adapter);
 
+static inline void igc_fpe_lp_event_status(union igc_adv_rx_desc *rx_desc,
+					   struct ethtool_mmsv *mmsv)
+{
+	__le32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
+	int smd;
+
+	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
+
+	if (smd == IGC_RXD_STAT_SMD_TYPE_V)
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_VERIFY_MPACKET);
+	else if (smd == IGC_RXD_STAT_SMD_TYPE_R)
+		ethtool_mmsv_event_handle(mmsv, ETHTOOL_MMSV_LP_SENT_RESPONSE_MPACKET);
+}
+
+static inline bool igc_fpe_is_verify_or_response(union igc_adv_rx_desc *rx_desc,
+						 unsigned int size)
+{
+	__le32 status_error = le32_to_cpu(rx_desc->wb.upper.status_error);
+	int smd;
+
+	smd = FIELD_GET(IGC_RXDADV_STAT_SMD_TYPE_MASK, status_error);
+
+	return ((smd == IGC_RXD_STAT_SMD_TYPE_V || smd == IGC_RXD_STAT_SMD_TYPE_R) &&
+		size == SMD_FRAME_SIZE);
+}
+
 #endif /* _IGC_BASE_H */
-- 
2.34.1


