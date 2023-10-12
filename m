Return-Path: <bpf+bounces-12053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76827C73CC
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEEA282CD7
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829813714B;
	Thu, 12 Oct 2023 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JP45wi8/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3274347A0;
	Thu, 12 Oct 2023 17:12:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02933B7;
	Thu, 12 Oct 2023 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697130768; x=1728666768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=njlWHUXIkn2npwUEImFBXtkRxvmC/r2O/x2Uptie094=;
  b=JP45wi8/93HyxhzWL54b+3LqZo9FLjNrB6eIou74C9gQWwG28CdFQji5
   doLj4Qt1dGOIWv48xQnwU4H489rjA4p9U9oNM6z6SucUVxgkgDeGQY2zf
   DqU2WLHh+nYDU2cUhBBaIlbr2LX53gKDMOqesF2hRJp1a6hB+iS+n65eM
   YAVPOqaGcLMk9vJ6S3SXQ6GNmfCImDYqsk5E4mfq1vt8DKGzPGbyPiaOQ
   KHQ5bVsf/jY0y3UPj3e2Vhfxz78sxyB4Alk8Fi9/ECNcnz3NRYyhiPUdv
   kVKqX4DL2RGUkFw1jJI4At5Sc7tT6YX0O+fulACiY6XHL0vGVbEM/fPKG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416027588"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="416027588"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783773940"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783773940"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2023 10:11:53 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7017533E93;
	Thu, 12 Oct 2023 18:11:51 +0100 (IST)
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
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v6 02/18] ice: make RX HW timestamp reading code more reusable
Date: Thu, 12 Oct 2023 19:05:08 +0200
Message-ID: <20231012170524.21085-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012170524.21085-1-larysa.zaremba@intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 20 ++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp.h      | 16 +++++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 22 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 05f922d3b316..e24c17789cf5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2168,30 +2168,26 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 }
 
 /**
- * ice_ptp_rx_hwtstamp - Check for an Rx timestamp
- * @rx_ring: Ring to get the VSI info
+ * ice_ptp_get_rx_hwts - Get packet Rx timestamp in ns
  * @rx_desc: Receive descriptor
- * @skb: Particular skb to send timestamp with
+ * @rx_ring: Ring to get the cached time
  *
  * The driver receives a notification in the receive descriptor with timestamp.
- * The timestamp is in ns, so we must convert the result first.
  */
-void
-ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
-		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb)
+u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
+			struct ice_rx_ring *rx_ring)
 {
-	struct skb_shared_hwtstamps *hwtstamps;
 	u64 ts_ns, cached_time;
 	u32 ts_high;
 
 	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
-		return;
+		return 0;
 
 	cached_time = READ_ONCE(rx_ring->cached_phctime);
 
 	/* Do not report a timestamp if we don't have a cached PHC time */
 	if (!cached_time)
-		return;
+		return 0;
 
 	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
 	 * PHC value, rather than accessing the PF. This also allows us to
@@ -2202,9 +2198,7 @@ ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
 	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
 	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
 
-	hwtstamps = skb_hwtstamps(skb);
-	memset(hwtstamps, 0, sizeof(*hwtstamps));
-	hwtstamps->hwtstamp = ns_to_ktime(ts_ns);
+	return ts_ns;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 995a57019ba7..8ebdf422752a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -268,9 +268,8 @@ void ice_ptp_extts_event(struct ice_pf *pf);
 s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb);
 enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
 
-void
-ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
-		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb);
+u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
+			struct ice_rx_ring *rx_ring);
 void ice_ptp_reset(struct ice_pf *pf);
 void ice_ptp_prepare_for_reset(struct ice_pf *pf);
 void ice_ptp_init(struct ice_pf *pf);
@@ -304,9 +303,14 @@ static inline bool ice_ptp_process_ts(struct ice_pf *pf)
 {
 	return true;
 }
-static inline void
-ice_ptp_rx_hwtstamp(struct ice_rx_ring *rx_ring,
-		    union ice_32b_rx_flex_desc *rx_desc, struct sk_buff *skb) { }
+
+static inline u64
+ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
+		    struct ice_rx_ring *rx_ring)
+{
+	return 0;
+}
+
 static inline void ice_ptp_reset(struct ice_pf *pf) { }
 static inline void ice_ptp_prepare_for_reset(struct ice_pf *pf) { }
 static inline void ice_ptp_init(struct ice_pf *pf) { }
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 987050dacead..95c29181301b 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -184,6 +184,26 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
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
+	u64 ts_ns = ice_ptp_get_rx_hwts(rx_desc, rx_ring);
+
+	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps){
+		.hwtstamp	= ns_to_ktime(ts_ns),
+	};
+}
+
 /**
  * ice_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: Rx descriptor ring packet is being transacted on
@@ -208,7 +228,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
 
 	if (rx_ring->ptp_rx)
-		ice_ptp_rx_hwtstamp(rx_ring, rx_desc, skb);
+		ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
 }
 
 /**
-- 
2.41.0


