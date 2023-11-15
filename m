Return-Path: <bpf+bounces-15105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD4D7EC9F7
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7464A1F2758D
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1696364D0;
	Wed, 15 Nov 2023 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UWMDKXYW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A401B6;
	Wed, 15 Nov 2023 09:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070879; x=1731606879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9nBrZBrfv59sCGQ3q1CP/EiozFpJm6e509WFCARFk0I=;
  b=UWMDKXYWFbze0/2xQ92gQNluWC7pJ5DGnfqpd2+ORu/ruQ/zetnZQEMi
   RavniMexi5Jx1GAPWLdygM0wMxky7Zl3fLgMjXk9qIdtpnJubKf2XQn2C
   MX6pLvd110mFnL074MDijkfT6ftIL2edTZoHos/kej9trY5br4LhudNJY
   TUOwZX7Z5zsOiu92coNwDn8e6K9GML2QJzgBnGYnEVxICMvvOIlDzGcms
   kf8kN0B4frzJGKusCZ4rkiD+TUfAIadooTEK+LeGSVSW8o8RolQSQTXHT
   /xXFX6jEA8VwG4JqTrzmDM2OBOG4ltdEjAqJPwbqQvLJLkpcsnuYgKo7e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422020476"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="422020476"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:54:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12842600"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 15 Nov 2023 09:54:32 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1751836C3F;
	Wed, 15 Nov 2023 17:54:29 +0000 (GMT)
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
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v7 04/18] ice: Introduce ice_xdp_buff
Date: Wed, 15 Nov 2023 18:52:46 +0100
Message-ID: <20231115175301.534113-5-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115175301.534113-1-larysa.zaremba@intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to use XDP hints via kfuncs we need to put
RX descriptor and miscellaneous data next to xdp_buff.
Same as in hints implementations in other drivers, we achieve
this through putting xdp_buff into a child structure.

Currently, xdp_buff is stored in the ring structure,
so replace it with union that includes child structure.
This way enough memory is available while existing XDP code
remains isolated from hints.

Minimum size of the new child structure (ice_xdp_buff) is exactly
64 bytes (single cache line). To place it at the start of a cache line,
move 'next' field from CL1 to CL4, as it isn't used often. This still
leaves 192 bits available in CL3 for packet context extensions.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++++--
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 18 +++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 ++++++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 40f2f6dabb81..4e6546d9cf85 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
  * @xdp_prog: XDP program to run
  * @xdp_ring: ring to be used for XDP_TX action
  * @rx_buf: Rx buffer to store the XDP action
+ * @eop_desc: Last descriptor in packet to read metadata from
  *
  * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
  */
 static void
 ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
-	    struct ice_rx_buf *rx_buf)
+	    struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
 {
 	unsigned int ret = ICE_XDP_PASS;
 	u32 act;
@@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	if (!xdp_prog)
 		goto exit;
 
+	ice_xdp_meta_set_desc(xdp, eop_desc);
+
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -1240,7 +1243,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc))
 			continue;
 
-		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf);
+		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
 		if (rx_buf->act == ICE_XDP_PASS)
 			goto construct_skb;
 		total_rx_bytes += xdp_get_buff_len(xdp);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 166413fc33f4..9efb42f99415 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -257,6 +257,14 @@ enum ice_rx_dtype {
 	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
 };
 
+struct ice_xdp_buff {
+	struct xdp_buff xdp_buff;
+	const union ice_32b_rx_flex_desc *eop_desc;
+};
+
+/* Required for compatibility with xdp_buffs from xsk_pool */
+static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);
+
 /* indices into GLINT_ITR registers */
 #define ICE_RX_ITR	ICE_IDX_ITR0
 #define ICE_TX_ITR	ICE_IDX_ITR1
@@ -298,7 +306,6 @@ enum ice_dynamic_itr {
 /* descriptor ring, associated with a VSI */
 struct ice_rx_ring {
 	/* CL1 - 1st cacheline starts here */
-	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	void *desc;			/* Descriptor ring memory */
 	struct device *dev;		/* Used for DMA mapping */
 	struct net_device *netdev;	/* netdev ring maps to */
@@ -310,12 +317,16 @@ struct ice_rx_ring {
 	u16 count;			/* Number of descriptors */
 	u16 reg_idx;			/* HW register index of the ring */
 	u16 next_to_alloc;
-	/* CL2 - 2nd cacheline starts here */
+
 	union {
 		struct ice_rx_buf *rx_buf;
 		struct xdp_buff **xdp_buf;
 	};
-	struct xdp_buff xdp;
+	/* CL2 - 2nd cacheline starts here */
+	union {
+		struct ice_xdp_buff xdp_ext;
+		struct xdp_buff xdp;
+	};
 	/* CL3 - 3rd cacheline starts here */
 	struct bpf_prog *xdp_prog;
 	u16 rx_offset;
@@ -332,6 +343,7 @@ struct ice_rx_ring {
 	/* CL4 - 4th cacheline starts here */
 	struct ice_channel *ch;
 	struct ice_tx_ring *xdp_ring;
+	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
 	dma_addr_t dma;			/* physical address of ring */
 	u64 cached_phctime;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index e1d49e1235b3..81b8856d8e13 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -151,4 +151,14 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 		       struct sk_buff *skb);
 void
 ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag);
+
+static inline void
+ice_xdp_meta_set_desc(struct xdp_buff *xdp,
+		      union ice_32b_rx_flex_desc *eop_desc)
+{
+	struct ice_xdp_buff *xdp_ext = container_of(xdp, struct ice_xdp_buff,
+						    xdp_buff);
+
+	xdp_ext->eop_desc = eop_desc;
+}
 #endif /* !_ICE_TXRX_LIB_H_ */
-- 
2.41.0


