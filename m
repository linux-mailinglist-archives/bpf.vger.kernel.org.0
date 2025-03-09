Return-Path: <bpf+bounces-53674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77368A58375
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 11:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117E916E265
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 10:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D42D1DED43;
	Sun,  9 Mar 2025 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1QU4bpq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3141CACF3;
	Sun,  9 Mar 2025 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741517318; cv=none; b=RI7pGfmKlaZJ9KyRLR9/oUm916bn/4huV1Ls9YvM9HQN7OOfhza1ZkhWk7v+L372uM5pZoStycYbsdC0pD7DXkmzfIX/Sb4CzCf2qmIULLhaXXQi62qsfnbWIpM5MKzikNZ+IfB2c6m/83xV5gi68sAk8VXC2ppwokZle4O7jq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741517318; c=relaxed/simple;
	bh=SSg48PFLu9MLb8qoAQr7IacJyhQASfev4zsoNzSKWZg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZAESePZbRPU/wvbINxnXiO/qcjRbEx7bWKwva7IVtLHEx/8ulxuyCGMdoasRQBGYEbDj/kNGICfqkwPzT7qaxbsN1pdAiAUERqZ8/I1G771+zA69WJCp9FoPKsm86Q4hMwTsm0o6IymvUd4yP0L65Vmqd+/zHIU1IHe7Ee4nyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1QU4bpq; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741517317; x=1773053317;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=SSg48PFLu9MLb8qoAQr7IacJyhQASfev4zsoNzSKWZg=;
  b=a1QU4bpqW408hByTTAi8lZ772HBWXG6DIhDB5j2RmrO0u2bkTTO+TKlT
   7g4wNCyphInfrdXfDWKdNXwpT17eh5Izadl5j0O6vibAoe+u+ugy3/UI3
   cMan7tZXJX/nnkumfsCLOE/Fwl7oyiZyeTQ0v1gEjH8vVu+umgQpjfR3l
   paTqGRbXEJqCsCNjk/Q1YJq/bXXzin2a3jqv2o1k+3u0hgG7O3Y3KmGoX
   h90ZwFVw81Vq8yMlVH6qH5KYlofFAxJS6HECZQ4QJjAyysfOr6prlN05R
   8A0DYGFUCyfIyXR7F8tdUokJbn1IpMfgWAOn62raCjrYMRQQyODGdyBDf
   g==;
X-CSE-ConnectionGUID: ZYX8DAahT9mRh+wlhkItjA==
X-CSE-MsgGUID: 7EY2/63uSzW3U6WbdguDPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42636152"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42636152"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 03:48:37 -0700
X-CSE-ConnectionGUID: RhbiQyynTVa0T2lQaHKf/A==
X-CSE-MsgGUID: LnBMitNIRTKKk1tdoV/hWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="124655128"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa003.jf.intel.com with ESMTP; 09 Mar 2025 03:48:29 -0700
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-next v9 09/14] igc: set the RX packet buffer size for TSN mode
Date: Sun,  9 Mar 2025 06:46:43 -0400
Message-Id: <20250309104648.3895551-10-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for supporting frame preemption, when entering TSN mode,
set the receive packet buffer to 15KB for the Express MAC, 15KB for
the Preemptible MAC and 2KB for the BMC.

References:
I225/I226 SW User Manual, Section 4.7.9, Section 7.1.3.2, Section 8.3.1

The newly introduced macros follow the naming from the i226 SW User Manual
for easy reference.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h |  5 ++++
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 25 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 3564d15df57b..d753a8ec36ae 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -399,17 +399,22 @@
 /* Mask for RX packet buffer size */
 #define IGC_RXPBSIZE_EXP_MASK		GENMASK(5, 0)
 #define IGC_BMC2OSPBSIZE_MASK		GENMASK(11, 6)
+#define IGC_RXPBSIZE_BE_MASK		GENMASK(17, 12)
 /* Mask for timestamp in RX buffer */
 #define IGC_RXPBS_CFG_TS_EN_MASK	GENMASK(31, 31)
 /* High-priority RX packet buffer size (KB). Used for Express traffic when preemption is enabled */
 #define IGC_RXPBSIZE_EXP(x)		FIELD_PREP(IGC_RXPBSIZE_EXP_MASK, (x))
 /* BMC to OS packet buffer size in KB */
 #define IGC_BMC2OSPBSIZE(x)		FIELD_PREP(IGC_BMC2OSPBSIZE_MASK, (x))
+/* Low-priority RX packet buffer size (KB). Used for BE traffic when preemption is enabled */
+#define IGC_RXPBSIZE_BE(x)		FIELD_PREP(IGC_RXPBSIZE_BE_MASK, (x))
 /* Enable RX packet buffer for timestamp descriptor, saving 16 bytes per packet if set */
 #define IGC_RXPBS_CFG_TS_EN		FIELD_PREP(IGC_RXPBS_CFG_TS_EN_MASK, 1)
 /* Default value following I225/I226 SW User Manual Section 8.3.1 */
 #define IGC_RXPBSIZE_EXP_BMC_DEFAULT ( \
 	IGC_RXPBSIZE_EXP(34) | IGC_BMC2OSPBSIZE(2))
+#define IGC_RXPBSIZE_EXP_BMC_BE_TSN ( \
+	IGC_RXPBSIZE_EXP(15) | IGC_BMC2OSPBSIZE(2) | IGC_RXPBSIZE_BE(15))
 
 /* Mask for TX packet buffer size */
 #define IGC_TXPB0SIZE_MASK		GENMASK(5, 0)
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 498741d83ca6..5b3b1bc0b64a 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -125,6 +125,27 @@ static void igc_tsn_tx_arb(struct igc_adapter *adapter, u16 *queue_per_tc)
 	wr32(IGC_TXARB, txarb);
 }
 
+/**
+ * igc_tsn_set_rxpbsize - Set the receive packet buffer size
+ * @adapter: Pointer to the igc_adapter structure
+ * @rxpbs_exp_bmc_be: Value to set the receive packet buffer size, including
+ *                    express buffer, BMC buffer, and Best Effort buffer
+ *
+ * The IGC_RXPBS register value may include allocations for the Express buffer,
+ * BMC buffer, Best Effort buffer, and the timestamp descriptor buffer (IGC_RXPBS_CFG_TS_EN).
+ */
+static void igc_tsn_set_rxpbsize(struct igc_adapter *adapter, u32 rxpbs_exp_bmc_be)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 rxpbs = rd32(IGC_RXPBS);
+
+	rxpbs &= ~(IGC_RXPBSIZE_EXP_MASK | IGC_BMC2OSPBSIZE_MASK |
+		   IGC_RXPBSIZE_BE_MASK);
+	rxpbs |= rxpbs_exp_bmc_be;
+
+	wr32(IGC_RXPBS, rxpbs);
+}
+
 /* Returns the TSN specific registers to their default values after
  * the adapter is reset.
  */
@@ -139,6 +160,8 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
 
+	igc_tsn_set_rxpbsize(adapter, IGC_RXPBSIZE_EXP_BMC_DEFAULT);
+
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_restore_retx_default(adapter);
 
@@ -202,6 +225,8 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
 
+	igc_tsn_set_rxpbsize(adapter, IGC_RXPBSIZE_EXP_BMC_BE_TSN);
+
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_set_retx_qbvfullthreshold(adapter);
 
-- 
2.34.1


