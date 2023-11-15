Return-Path: <bpf+bounces-15108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD31E7EC9FD
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4D81C20BC9
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D8433DA;
	Wed, 15 Nov 2023 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBmjA44F"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D551AC;
	Wed, 15 Nov 2023 09:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070889; x=1731606889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nWeTNGX5Hwp2CmJrb0XPXgUOacw/oHzu8SciobexI7I=;
  b=FBmjA44FzZUU9uWMYxG1P7fozbHlfvVoL2jPesl1o//8YQHQYBjXS9nv
   mC1A9nrnhV47gOEUhfGfqq6tQL+fhno9frsmgrqlcvi/UKo22PkcpncOk
   413hDzY+DCDNRD2qLjDYxWtOipTKnMhay3pGhc+DjBteYpCu17SWuG5lJ
   xJUmnSxkAzgcagT7D4q0UZyLoo2I+sldbyWjbJmGsGgLTBttXfdDseHPm
   BFLQasVP4ZDGGwR7PSqgLEVOoGhpWxMywMUDF42UgLVQYHLyJLXOSp2C4
   gJ6KEGuW3UYHdOG/lgcrSdIJrJu5ZYU4t/8w65b9kkZb7wyLF9Oion1f2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422020547"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="422020547"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:54:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12842640"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 15 Nov 2023 09:54:43 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4C7FB3581D;
	Wed, 15 Nov 2023 17:54:40 +0000 (GMT)
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
Subject: [PATCH bpf-next v7 08/18] ice: Support XDP hints in AF_XDP ZC mode
Date: Wed, 15 Nov 2023 18:52:50 +0100
Message-ID: <20231115175301.534113-9-larysa.zaremba@intel.com>
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

In AF_XDP ZC, xdp_buff is not stored on ring,
instead it is provided by xsk_buff_pool.
Space for metadata sources right after such buffers was already reserved
in commit 94ecc5ca4dbf ("xsk: Add cb area to struct xdp_buff_xsk").

Some things (such as pointer to packet context) do not change on a
per-packet basis, so they can be set at the same time as RX queue info.
On the other hand, RX descriptor is unique for each packet, but is already
known when setting DMA addresses. This minimizes performance impact of
hints on regular packet processing.

Update AF_XDP ZC packet processing to support XDP hints.

Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 13 +++++++++++++
 drivers/net/ethernet/intel/ice/ice_xsk.c  | 17 +++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 2d83f3c029e7..d3396c1c87a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -519,6 +519,18 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	return 0;
 }
 
+static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
+{
+	void *ctx_ptr = &ring->pkt_ctx;
+	struct xsk_cb_desc desc = {};
+
+	desc.src = &ctx_ptr;
+	desc.off = offsetof(struct ice_xdp_buff, pkt_ctx) -
+		   sizeof(struct xdp_buff);
+	desc.bytes = sizeof(ctx_ptr);
+	xsk_pool_fill_cb(ring->xsk_pool, &desc);
+}
+
 /**
  * ice_vsi_cfg_rxq - Configure an Rx queue
  * @ring: the ring being configured
@@ -553,6 +565,7 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			if (err)
 				return err;
 			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
+			ice_xsk_pool_fill_cb(ring);
 
 			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 				 ring->q_index);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 906e383e864a..a690e34ea8ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -433,7 +433,7 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 
 /**
  * ice_fill_rx_descs - pick buffers from XSK buffer pool and use it
- * @pool: XSK Buffer pool to pull the buffers from
+ * @rx_ring: rx ring
  * @xdp: SW ring of xdp_buff that will hold the buffers
  * @rx_desc: Pointer to Rx descriptors that will be filled
  * @count: The number of buffers to allocate
@@ -445,19 +445,24 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
  *
  * Returns the amount of allocated Rx descriptors
  */
-static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
+static u16 ice_fill_rx_descs(struct ice_rx_ring *rx_ring, struct xdp_buff **xdp,
 			     union ice_32b_rx_flex_desc *rx_desc, u16 count)
 {
 	dma_addr_t dma;
 	u16 buffs;
 	int i;
 
-	buffs = xsk_buff_alloc_batch(pool, xdp, count);
+	buffs = xsk_buff_alloc_batch(rx_ring->xsk_pool, xdp, count);
 	for (i = 0; i < buffs; i++) {
 		dma = xsk_buff_xdp_get_dma(*xdp);
 		rx_desc->read.pkt_addr = cpu_to_le64(dma);
 		rx_desc->wb.status_error0 = 0;
 
+		/* Put private info that changes on a per-packet basis
+		 * into xdp_buff_xsk->cb.
+		 */
+		ice_xdp_meta_set_desc(*xdp, rx_desc);
+
 		rx_desc++;
 		xdp++;
 	}
@@ -488,8 +493,7 @@ static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
 	xdp = ice_xdp_buf(rx_ring, ntu);
 
 	if (ntu + count >= rx_ring->count) {
-		nb_buffs_extra = ice_fill_rx_descs(rx_ring->xsk_pool, xdp,
-						   rx_desc,
+		nb_buffs_extra = ice_fill_rx_descs(rx_ring, xdp, rx_desc,
 						   rx_ring->count - ntu);
 		if (nb_buffs_extra != rx_ring->count - ntu) {
 			ntu += nb_buffs_extra;
@@ -502,7 +506,7 @@ static bool __ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring, u16 count)
 		ice_release_rx_desc(rx_ring, 0);
 	}
 
-	nb_buffs = ice_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
+	nb_buffs = ice_fill_rx_descs(rx_ring, xdp, rx_desc, count);
 
 	ntu += nb_buffs;
 	if (ntu == rx_ring->count)
@@ -752,6 +756,7 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
  * @xdp: xdp_buff used as input to the XDP program
  * @xdp_prog: XDP program to run
  * @xdp_ring: ring to be used for XDP_TX action
+ * @rx_desc: packet descriptor
  *
  * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
  */
-- 
2.41.0


