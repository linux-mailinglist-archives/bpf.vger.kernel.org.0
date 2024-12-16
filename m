Return-Path: <bpf+bounces-47019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DCD9F2A66
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965B9188883F
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF74C1CDFCE;
	Mon, 16 Dec 2024 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1zubPyl"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2F01D516A;
	Mon, 16 Dec 2024 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331746; cv=none; b=lC/jZ9QpI9APouFiCD4xPwcGYGSMlF9iLprvC1ltsOiLhhQ9KzVC+5np2KhcQZ7Mp/GWjD2nbWoeJemLeLxzbNC16AVOzdG2urEaE0+w6ys9RpBpwf7UA/6OCBkkKhF1zfY3r9p7aJC5kHG7GK1q0573XEmI1nBGXAXtlEHitQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331746; c=relaxed/simple;
	bh=wnUDCgOMDokraxchjWXWE2o8xToDxF2pNqrcc5fKKH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K5wi/4VjcQ0AU3x1DSlRYS8BeVcIqugJ61+ysjeCzTpiF+9wC2XfN8erp5o/mgUWz56t843fNAoQzlsr89FbkRFnfc+QIyLM6N15qNxd2XfFn5NFx6SRdt+AylfGsBX4Wz1XdrIoOuIImsr6oEctGwiukr8QyoBOy111/OFjKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1zubPyl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734331745; x=1765867745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wnUDCgOMDokraxchjWXWE2o8xToDxF2pNqrcc5fKKH8=;
  b=j1zubPylajWRY3KxIYzkOUixrUNRkhpSBU4Zqf/6kt/VY43fPA8+uvAQ
   fW0itonj4OY/b0ZURW2UAjMH31koBpIVO2EajbH02jwSVOuUwF6rAbhEU
   FgpoitIZeUWnNz/DRCiY+CT8prJaKMGcrdZ1iI4xHL9CqPkWAlcIfKfa6
   sWDfpIi7Ft2Oh/+9//aiOZc//iPGog0pO/4avm98mdYgazlNe6ahoa4j2
   maqFZtQAwvkqZR9TN738E5w9LNd9gFRvSA5JOOMRBTVadx7u/eXbq8qD8
   a0LGWhPtAm4ufxo0HDm44MTO0PzrVhZlue+QxKWc5fG+LnCWFFz2zcUUv
   g==;
X-CSE-ConnectionGUID: Z8kzisMBQMeJWC3b1QZJcA==
X-CSE-MsgGUID: zrwLGMRnQ+eDSXKakkEBXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34848230"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34848230"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 22:49:04 -0800
X-CSE-ConnectionGUID: T161Qh0tQYqV8RmugmQOOA==
X-CSE-MsgGUID: xojFAmqRTXCEM0A13ihfyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128101875"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by fmviesa001.fm.intel.com with ESMTP; 15 Dec 2024 22:49:00 -0800
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
Subject: [PATCH iwl-next 5/9] igc: Add support to set MAC Merge data via ethtool
Date: Mon, 16 Dec 2024 01:47:16 -0500
Message-Id: <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
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

Created fpe_t struct to store MAC Merge data and implement the
"ethtool --set-mm" callback. The fpe_t struct will host other frame
preemption related data in future patches.

The following fields are used to set IGC register:
a) pmac_enabled -> TQAVCTRL.PREEMPT_ENA
   This global register sets the preemption scheme, controlling
   preemption capabilities in transmit and receive directions, as well as
   the verification handshake capability.
b) tx_min_frag_size -> TQAVCTRL.MIN_FRAG
   Global register to set minimum fragments.

The fields below don't set any register but will be utilized in the
upcoming patches:
a) verify_time
b) verify_enabled
c) tx_enabled
   Note that IGC doesn't have any register to enforce "tx_enabled"
   (preemption in transmit direction) like some other NIC. This field
   will be used in driver level to control verification procedure and
   managing preemption capability in transmit direction.

At this point, verify response handshake is not enabled yet.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h         | 24 ++++++++++++-
 drivers/net/ethernet/intel/igc/igc_defines.h |  3 ++
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 30 ++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_main.c    |  2 ++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 37 ++++++++++++++++++--
 drivers/net/ethernet/intel/igc/igc_tsn.h     |  9 +++++
 6 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 480b54573d60..5a14e9101723 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -40,6 +40,25 @@ void igc_ethtool_set_ops(struct net_device *);
 
 #define IGC_MAX_TX_TSTAMP_REGS		4
 
+/**
+ * @verify_time: see struct ethtool_mm_state
+ * @verify_enabled: see struct ethtool_mm_state
+ * @tx_enabled:
+ * Note that IGC NIC does not have the capability to enable preemption in
+ * "transmit direction". This field is used to manage transmit preemption in
+ * driver level.
+ * @pmac_enabled:
+ * Enable the capability to receive preemptible frames.
+ * @tx_min_frag_size: see struct ethtool_mm_state
+ */
+struct fpe_t {
+	u32 verify_time;
+	bool verify_enabled;
+	bool tx_enabled;
+	bool pmac_enabled;
+	u32 tx_min_frag_size;
+};
+
 enum igc_mac_filter_type {
 	IGC_MAC_FILTER_TYPE_DST = 0,
 	IGC_MAC_FILTER_TYPE_SRC
@@ -332,6 +351,8 @@ struct igc_adapter {
 		struct timespec64 period;
 	} perout[IGC_N_PEROUT];
 
+	struct fpe_t fpe;
+
 	/* LEDs */
 	struct mutex led_mutex;
 	struct igc_led_classdev *leds;
@@ -387,10 +408,11 @@ extern char igc_driver_name[];
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
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 3a78753ab050..3088cdd08f35 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -544,6 +544,9 @@
 #define IGC_TQAVCTRL_TRANSMIT_MODE_TSN	0x00000001
 #define IGC_TQAVCTRL_ENHANCED_QAV	0x00000008
 #define IGC_TQAVCTRL_FUTSCDDIS		0x00000080
+#define IGC_TQAVCTRL_PREEMPT_ENA	0x00000002
+#define IGC_TQAVCTRL_MIN_FRAG_MASK	0x0000C000
+#define IGC_TQAVCTRL_MIN_FRAG_SHIFT	14
 
 #define IGC_TXQCTL_QUEUE_MODE_LAUNCHT	0x00000001
 #define IGC_TXQCTL_STRICT_CYCLE		0x00000002
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 817838677817..1954561ec4aa 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -8,6 +8,7 @@
 
 #include "igc.h"
 #include "igc_diag.h"
+#include "igc_tsn.h"
 
 /* forward declaration */
 struct igc_stats {
@@ -1781,6 +1782,34 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
 	return 0;
 }
 
+static int igc_ethtool_set_mm(struct net_device *netdev,
+			      struct ethtool_mm_cfg *cmd,
+			      struct netlink_ext_ack *extack)
+{
+	struct igc_adapter *adapter = netdev_priv(netdev);
+	struct fpe_t *fpe = &adapter->fpe;
+
+	if (cmd->tx_min_frag_size < IGC_TX_MIN_FRAG_SIZE ||
+	    cmd->tx_min_frag_size > IGC_TX_MAX_FRAG_SIZE)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid value for tx-min-frag-size");
+	else
+		fpe->tx_min_frag_size = cmd->tx_min_frag_size;
+
+	if (cmd->verify_time < MIN_VERIFY_TIME ||
+	    cmd->verify_time > MAX_VERIFY_TIME)
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Invalid value for verify-time");
+	else
+		fpe->verify_time = cmd->verify_time;
+
+	fpe->tx_enabled = cmd->tx_enabled;
+	fpe->pmac_enabled = cmd->pmac_enabled;
+	fpe->verify_enabled = cmd->verify_enabled;
+
+	return igc_tsn_offload_apply(adapter);
+}
+
 static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 					  struct ethtool_link_ksettings *cmd)
 {
@@ -2068,6 +2097,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.set_rxfh		= igc_ethtool_set_rxfh,
 	.get_ts_info		= igc_ethtool_get_ts_info,
 	.get_channels		= igc_ethtool_get_channels,
+	.set_mm			= igc_ethtool_set_mm,
 	.set_channels		= igc_ethtool_set_channels,
 	.get_priv_flags		= igc_ethtool_get_priv_flags,
 	.set_priv_flags		= igc_ethtool_set_priv_flags,
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 3f0751a9530c..b85eaf34d07b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7144,6 +7144,8 @@ static int igc_probe(struct pci_dev *pdev,
 
 	igc_tsn_clear_schedule(adapter);
 
+	igc_fpe_init(&adapter->fpe);
+
 	/* reset the hardware with the new settings */
 	igc_reset(adapter);
 
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 5cd54ce435b9..b968c02f5fee 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -5,6 +5,18 @@
 #include "igc_hw.h"
 #include "igc_tsn.h"
 
+#define DEFAULT_VERIFY_TIME		10
+#define IGC_MIN_FOR_TX_MIN_FRAG		0
+#define IGC_MAX_FOR_TX_MIN_FRAG		3
+
+void igc_fpe_init(struct fpe_t *fpe)
+{
+	fpe->verify_enabled = false;
+	fpe->verify_time = DEFAULT_VERIFY_TIME;
+	fpe->pmac_enabled = false;
+	fpe->tx_min_frag_size = IGC_TX_MIN_FRAG_SIZE;
+}
+
 static bool is_any_launchtime(struct igc_adapter *adapter)
 {
 	int i;
@@ -49,6 +61,9 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 	if (adapter->strict_priority_enable)
 		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
 
+	if (adapter->fpe.pmac_enabled)
+		new_flags |= IGC_FLAG_TSN_PREEMPT_ENABLED;
+
 	return new_flags;
 }
 
@@ -148,7 +163,8 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 
 	tqavctrl = rd32(IGC_TQAVCTRL);
 	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
-		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS);
+		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS |
+		      IGC_TQAVCTRL_PREEMPT_ENA | IGC_TQAVCTRL_MIN_FRAG_MASK);
 
 	wr32(IGC_TQAVCTRL, tqavctrl);
 
@@ -194,12 +210,22 @@ static void igc_tsn_set_retx_qbvfullthreshold(struct igc_adapter *adapter)
 	wr32(IGC_RETX_CTL, retxctl);
 }
 
+static u8 igc_fpe_get_frag_size_mult(const struct fpe_t *fpe)
+{
+	u32 tx_min_frag_size = fpe->tx_min_frag_size;
+	u8 mult = (tx_min_frag_size / 64) - 1;
+
+	return clamp_t(u8, mult, IGC_MIN_FOR_TX_MIN_FRAG,
+		       IGC_MAX_FOR_TX_MIN_FRAG);
+}
+
 static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
 	u32 tqavctrl, baset_l, baset_h;
 	u32 sec, nsec, cycle, rxpbs;
 	ktime_t base_time, systim;
+	u32 frag_size_mult;
 	int i;
 
 	wr32(IGC_TSAUXC, 0);
@@ -370,10 +396,17 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 		wr32(IGC_TXQCTL(i), txqctl);
 	}
 
-	tqavctrl = rd32(IGC_TQAVCTRL) & ~IGC_TQAVCTRL_FUTSCDDIS;
+	tqavctrl = rd32(IGC_TQAVCTRL) & ~(IGC_TQAVCTRL_FUTSCDDIS |
+		   IGC_TQAVCTRL_MIN_FRAG_MASK | IGC_TQAVCTRL_PREEMPT_ENA);
 
 	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
 
+	if (adapter->fpe.pmac_enabled)
+		tqavctrl |= IGC_TQAVCTRL_PREEMPT_ENA;
+
+	frag_size_mult = igc_fpe_get_frag_size_mult(&adapter->fpe);
+	tqavctrl |= frag_size_mult << IGC_TQAVCTRL_MIN_FRAG_SHIFT;
+
 	adapter->qbv_count++;
 
 	cycle = adapter->cycle_time;
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
index 98ec845a86bf..08e7582f257e 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.h
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
@@ -4,6 +4,15 @@
 #ifndef _IGC_TSN_H_
 #define _IGC_TSN_H_
 
+/* IGC_TX_MIN_FRAG_SIZE is based on the MIN_FRAG field in Section 8.12.2 of the
+ * SW User Manual.
+ */
+#define IGC_TX_MIN_FRAG_SIZE		68
+#define IGC_TX_MAX_FRAG_SIZE		260
+#define MIN_VERIFY_TIME			1
+#define MAX_VERIFY_TIME			128
+
+void igc_fpe_init(struct fpe_t *fpe);
 int igc_tsn_offload_apply(struct igc_adapter *adapter);
 int igc_tsn_reset(struct igc_adapter *adapter);
 void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
-- 
2.25.1


