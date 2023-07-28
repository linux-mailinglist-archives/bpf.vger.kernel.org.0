Return-Path: <bpf+bounces-6238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ED97673C6
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF081C203BC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DF31BB5F;
	Fri, 28 Jul 2023 17:44:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378431BB4B;
	Fri, 28 Jul 2023 17:44:36 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A623A81;
	Fri, 28 Jul 2023 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690566274; x=1722102274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQ+/fAd0tXHZeUD23nalG1uAFHTWEEKfJMVb6zDMB2Q=;
  b=jgKLuZti08tIhp3LJs3DG3V6wDdGspjp4WUiB57k5cDgU+f5Ih5FLcci
   qUuF8odUHJbjZYsKZO8gnpwOHTVYhgltAfAVmI4j4OCQLeG7128JYiTGz
   XXPH+6v1Qxag03b+aWDgzsixNnt+VrnRuljYT57folh20n7Zd1He3rxBz
   7jftiA9GJag8fHGMNwkLhwsOqigGC755OSXqNMkOolBMz/ZMJNcIAwive
   OjMl19mi7oSSHxBaHeT+BXoQPjaw0OiRCpi231ARrrJWyo1tnwzF6aIzs
   m9i7fgloc2oitkGWxyrihDGeMqSnu77Z1f8F7z/tSnX9E1WcNwcvmk36T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="366117319"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="366117319"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="851294602"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851294602"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 10:44:11 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BAD6237F71;
	Fri, 28 Jul 2023 18:44:09 +0100 (IST)
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
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH bpf-next v4 05/21] ice: Introduce ice_xdp_buff
Date: Fri, 28 Jul 2023 19:39:07 +0200
Message-ID: <20230728173923.1318596-6-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728173923.1318596-1-larysa.zaremba@intel.com>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In order to use XDP hints via kfuncs we need to put
RX descriptor and ring pointers just next to xdp_buff.
Same as in hints implementations in other drivers, we achieve
this through putting xdp_buff into a child structure.

Currently, xdp_buff is stored in the ring structure,
so replace it with union that includes child structure.
This way enough memory is available while existing XDP code
remains isolated from hints.

Minimum size of the new child structure (ice_xdp_buff) is exactly
64 bytes (single cache line). To place it at the start of a cache line,
move 'next' field from CL1 to CL3, as it isn't used often. This still
leaves 128 bits available in CL3 for packet context extensions.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 ++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
 3 files changed, 38 insertions(+), 5 deletions(-)

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
index 166413fc33f4..d0ab2c4c0c91 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -257,6 +257,18 @@ enum ice_rx_dtype {
 	ICE_RX_DTYPE_SPLIT_ALWAYS	= 2,
 };
 
+struct ice_pkt_ctx {
+	const union ice_32b_rx_flex_desc *eop_desc;
+};
+
+struct ice_xdp_buff {
+	struct xdp_buff xdp_buff;
+	struct ice_pkt_ctx pkt_ctx;
+};
+
+/* Required for compatibility with xdp_buffs from xsk_pool */
+static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);
+
 /* indices into GLINT_ITR registers */
 #define ICE_RX_ITR	ICE_IDX_ITR0
 #define ICE_TX_ITR	ICE_IDX_ITR1
@@ -298,7 +310,6 @@ enum ice_dynamic_itr {
 /* descriptor ring, associated with a VSI */
 struct ice_rx_ring {
 	/* CL1 - 1st cacheline starts here */
-	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	void *desc;			/* Descriptor ring memory */
 	struct device *dev;		/* Used for DMA mapping */
 	struct net_device *netdev;	/* netdev ring maps to */
@@ -310,12 +321,19 @@ struct ice_rx_ring {
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
+		struct {
+			struct xdp_buff xdp;
+			struct ice_pkt_ctx pkt_ctx;
+		};
+	};
 	/* CL3 - 3rd cacheline starts here */
 	struct bpf_prog *xdp_prog;
 	u16 rx_offset;
@@ -325,6 +343,8 @@ struct ice_rx_ring {
 	u16 next_to_clean;
 	u16 first_desc;
 
+	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
+
 	/* stats structs */
 	struct ice_ring_stats *ring_stats;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index e1d49e1235b3..145883eec129 100644
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
+	xdp_ext->pkt_ctx.eop_desc = eop_desc;
+}
 #endif /* !_ICE_TXRX_LIB_H_ */
-- 
2.41.0


