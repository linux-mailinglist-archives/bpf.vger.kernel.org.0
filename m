Return-Path: <bpf+bounces-5356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8923B759DAB
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5D41C2111C
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F0F275C5;
	Wed, 19 Jul 2023 18:41:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FED1BB25;
	Wed, 19 Jul 2023 18:41:52 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957D2B6;
	Wed, 19 Jul 2023 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792110; x=1721328110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oRWaHeKyMy0HLP6hrFxpMlfbsfXSLhA5EqRrgnquuU4=;
  b=bAQjup0pfwauC+3ou3GeuafcjtFoVb1ICPDhgcZqB2qo4YQxkO3zdA7s
   Xd7QRHzc0BXiJxVE1RAE6Mu+ezC5Qr8O2Q4mZqIEuwAlfyiO0Q5vGv+fn
   U2yyTlb6v9DCiJsVglFG3cTO0wDQCburGrdj320ARbkiKmU+2nswRcOie
   JNfOYJMiwODoZ4lmHz+nrUAJm6/JnA6NZbU2opaQxATrszUUGQE1ojbEk
   TrxZMTy6zwW4mlrGKwpLQKSgolv6+nlcgBxn/tA0oFnUNaoIi+SGFBxLT
   iTMRXUjCzDAOKmcK8R6GJncmItBcFdReV4TQYA38IG6xok7/xSGHxRHEZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356504699"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356504699"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674405643"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674405643"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 11:41:45 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 604A634F04;
	Wed, 19 Jul 2023 19:41:43 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 02/21] ice: make RX HW timestamp reading code more reusable
Date: Wed, 19 Jul 2023 20:37:15 +0200
Message-ID: <20230719183734.21681-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183734.21681-1-larysa.zaremba@intel.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Previously, we only needed RX HW timestamp in skb path,
hence all related code was written with skb in mind.
But with the addition of XDP hints via kfuncs to the ice driver,
the same logic will be needed in .xmo_() callbacks.

Put generic process of reading RX HW timestamp from a descriptor
into a separate function.
Move skb-related code into another source file.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 24 ++++++------------
 drivers/net/ethernet/intel/ice/ice_ptp.h      | 15 ++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 25 ++++++++++++++++++-
 3 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 81d96a40d5a7..a31333972c68 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2147,30 +2147,24 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 }
 
 /**
- * ice_ptp_rx_hwtstamp - Check for an Rx timestamp
- * @rx_ring: Ring to get the VSI info
+ * ice_ptp_get_rx_hwts - Get packet Rx timestamp
  * @rx_desc: Receive descriptor
- * @skb: Particular skb to send timestamp with
+ * @cached_time: Cached PHC time
  *
  * The driver receives a notification in the receive descriptor with timestamp.
- * The timestamp is in ns, so we must convert the result first.
  */
-void
-ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
-		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb)
+u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
+			u64 cached_time)
 {
-	struct skb_shared_hwtstamps *hwtstamps;
-	u64 ts_ns, cached_time;
 	u32 ts_high;
+	u64 ts_ns;
 
 	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
-		return;
-
-	cached_time = READ_ONCE(rx_ring->cached_phctime);
+		return 0;
 
 	/* Do not report a timestamp if we don't have a cached PHC time */
 	if (!cached_time)
-		return;
+		return 0;
 
 	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
 	 * PHC value, rather than accessing the PF. This also allows us to
@@ -2181,9 +2175,7 @@ ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
 	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
 	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
 
-	hwtstamps = skb_hwtstamps(skb);
-	memset(hwtstamps, 0, sizeof(*hwtstamps));
-	hwtstamps->hwtstamp = ns_to_ktime(ts_ns);
+	return ts_ns;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 995a57019ba7..523eefbfdf95 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -268,9 +268,8 @@ void ice_ptp_extts_event(struct ice_pf *pf);
 s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
 enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
 
-void
-ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
-		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb);
+u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
+			u64 cached_time);
 void ice_ptp_reset(struct ice_pf *pf);
 void ice_ptp_prepare_for_reset(struct ice_pf *pf);
 void ice_ptp_init(struct ice_pf *pf);
@@ -304,9 +303,13 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
 {
 	return true;
 }
-static inline void
-ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
-		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb) { }
+
+static inline u64
+ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc, u64 cached_time)
+{
+	return 0;
+}
+
 static inline void ice_ptp_reset(struct ice_pf *pf) { }
 static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf) { }
 static inline void ice_ptp_init(struct ice_pf *pf) { }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 8f7f6d78f7bf..b2f241b73934 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -185,6 +185,29 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
 	ring->vsi->back->hw_csum_rx_error++;
 }
 
+/**
+ * ice_ptp_rx_hwts_to_skb - Put RX timestamp into skb
+ * @rx_ring: Ring to get the VSI info
+ * @rx_desc: Receive descriptor
+ * @skb: Particular skb to send timestamp with
+ *
+ * The timestamp is in ns, so we must convert the result first.
+ */
+static void
+ice_ptp_rx_hwts_to_skb(struct ice_rx_ring *rx_ring,
+		       const union ice_32b_rx_flex_desc *rx_desc,
+		       struct sk_buff *skb)
+{
+	u64 ts_ns, cached_time;
+
+	cached_time = READ_ONCE(rx_ring->cached_phctime);
+	ts_ns = ice_ptp_get_rx_hwts(rx_desc, cached_time);
+
+	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
+		.hwtstamp	= ns_to_ktime(ts_ns),
+	};
+}
+
 /**
  * ice_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: Rx descriptor ring packet is being transacted on
@@ -209,7 +232,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
 
 	if (rx_ring->ptp_rx)
-		ice_ptp_rx_hwtstamp(rx_ring, rx_desc, skb);
+		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
 }
 
 /**
-- 
2.41.0


