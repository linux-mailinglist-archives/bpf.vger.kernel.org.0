Return-Path: <bpf+bounces-29779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979248C6A3A
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 18:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEF11F2351F
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86364156869;
	Wed, 15 May 2024 16:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FH1bWrhx"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B813EFE5;
	Wed, 15 May 2024 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789365; cv=none; b=rcnx37Z6gzQT8jsJT6BdUEyjbVZViMavqm9J0Eg3EofY5V7grS6ODYWXDG5wfSwj+515Inde/mvjW7d8CyrCnyBli7WtxZOVc3giIUyagbCMkLClbjvHAmwq+VvJLdvYTNePI1AfZE8bShF1sMtICUCF8bjmj+lYowLCRWThc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789365; c=relaxed/simple;
	bh=O+tfDMoXmeRpSYY+cqgQrvesO5RmeB3V1Oxo9Zb/W7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmPatMdLhNqglQqYY4Sq4umlkrY1frsBIrFqaNxJExRpRpu9Fuvb8AiIqeZr8HYFv3tJGZrlgDm878fteA2AZopMk0O56giztINxCEIXxkU8W9j0McXrYN9X2eRAufiqbqKk8edbns/Irx9rRaaDizw83TF3zVj1uDYFWU8VY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FH1bWrhx; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715789363; x=1747325363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O+tfDMoXmeRpSYY+cqgQrvesO5RmeB3V1Oxo9Zb/W7w=;
  b=FH1bWrhxpmoBI2/aRf6Mk8OAqr7hUDT9Bk4Js4sZoXlXEwLynp6Rgq43
   Lv+FNMn1KKyrhC6ZJLnwZ6v9cBGihF+dmF0C3TPrjaYdw3d3Q76rZsKgQ
   BlgzZ0DpPmEzrQ3fqn1FH8UBlqaz4JrNoXFdfwysUNUQo3aEs5coQXr+p
   GxLKXCwFpebzZK0lIOw/Ki0JUknchgqO8cIK3qE4kf/lK7dg6bu47oQz9
   YFXUYNvnm+WSVRJeKVQV0R8GABNxfIf5EqWmiVZsEbrr2IHAW85apTiLY
   rik9Emf8gOlkHnX5JrROdaVKZXLHQmVfLqY/Ow5z341uvTWmN+GO1xqQe
   A==;
X-CSE-ConnectionGUID: PYAkIso+TjqfJaBuX3kN2g==
X-CSE-MsgGUID: RBpb5PxvTBW3s7VYYBRLhw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11666378"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11666378"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:09:22 -0700
X-CSE-ConnectionGUID: 5lqvZ+JqTWmpf2WdtEdxJQ==
X-CSE-MsgGUID: c4+sj1fMRVGbWkrrr0RDvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="62297336"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 15 May 2024 09:09:17 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 73EB72878E;
	Wed, 15 May 2024 17:09:11 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	maciej.fijalkowski@intel.com,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	igor.bagnucki@intel.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH iwl-net 1/3] ice: remove af_xdp_zc_qps bitmap
Date: Wed, 15 May 2024 18:02:14 +0200
Message-ID: <20240515160246.5181-2-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515160246.5181-1-larysa.zaremba@intel.com>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Referenced commit has introduced a bitmap to distinguish between ZC and
copy-mode AF_XDP queues, because xsk_get_pool_from_qid() does not do this
for us.

The bitmap would be especially useful when restoring previous state after
rebuild, if only it was not reallocated in the process. This leads to e.g.
xdpsock dying after changing number of queues.

Instead of preserving the bitmap during the rebuild, remove it completely
and distinguish between ZC and copy-mode queues based on the presence of
a device associated with the pool.

Fixes: e102db780e1c ("ice: track AF_XDP ZC enabled queues in bitmap")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     | 32 ++++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_lib.c |  8 ------
 drivers/net/ethernet/intel/ice/ice_xsk.c | 13 +++++-----
 3 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6ad8002b22e1..d4d840729bda 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -409,7 +409,6 @@ struct ice_vsi {
 	struct ice_tc_cfg tc_cfg;
 	struct bpf_prog *xdp_prog;
 	struct ice_tx_ring **xdp_rings;	 /* XDP ring array */
-	unsigned long *af_xdp_zc_qps;	 /* tracks AF_XDP ZC enabled qps */
 	u16 num_xdp_txq;		 /* Used XDP queues */
 	u8 xdp_mapping_mode;		 /* ICE_MAP_MODE_[CONTIG|SCATTER] */
 
@@ -746,6 +745,25 @@ static inline void ice_set_ring_xdp(struct ice_tx_ring *ring)
 	ring->flags |= ICE_TX_FLAGS_RING_XDP;
 }
 
+/**
+ * ice_get_xp_from_qid - get ZC XSK buffer pool bound to a queue ID
+ * @vsi: pointer to VSI
+ * @qid: index of a queue to look at XSK buff pool presence
+ *
+ * Returns a pointer to xsk_buff_pool structure if there is a buffer pool
+ * attached and configured as zero-copy, NULL otherwise.
+ */
+static inline struct xsk_buff_pool *ice_get_xp_from_qid(struct ice_vsi *vsi,
+							u16 qid)
+{
+	struct xsk_buff_pool *pool = xsk_get_pool_from_qid(vsi->netdev, qid);
+
+	if (!ice_is_xdp_ena_vsi(vsi))
+		return NULL;
+
+	return (pool && pool->dev) ? pool : NULL;
+}
+
 /**
  * ice_xsk_pool - get XSK buffer pool bound to a ring
  * @ring: Rx ring to use
@@ -758,10 +776,7 @@ static inline struct xsk_buff_pool *ice_xsk_pool(struct ice_rx_ring *ring)
 	struct ice_vsi *vsi = ring->vsi;
 	u16 qid = ring->q_index;
 
-	if (!ice_is_xdp_ena_vsi(vsi) || !test_bit(qid, vsi->af_xdp_zc_qps))
-		return NULL;
-
-	return xsk_get_pool_from_qid(vsi->netdev, qid);
+	return ice_get_xp_from_qid(vsi, qid);
 }
 
 /**
@@ -786,12 +801,7 @@ static inline void ice_tx_xsk_pool(struct ice_vsi *vsi, u16 qid)
 	if (!ring)
 		return;
 
-	if (!ice_is_xdp_ena_vsi(vsi) || !test_bit(qid, vsi->af_xdp_zc_qps)) {
-		ring->xsk_pool = NULL;
-		return;
-	}
-
-	ring->xsk_pool = xsk_get_pool_from_qid(vsi->netdev, qid);
+	ring->xsk_pool = ice_get_xp_from_qid(vsi, qid);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 5371e91f6bbb..c0a7ff6c7e87 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -114,14 +114,8 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi)
 	if (!vsi->q_vectors)
 		goto err_vectors;
 
-	vsi->af_xdp_zc_qps = bitmap_zalloc(max_t(int, vsi->alloc_txq, vsi->alloc_rxq), GFP_KERNEL);
-	if (!vsi->af_xdp_zc_qps)
-		goto err_zc_qps;
-
 	return 0;
 
-err_zc_qps:
-	devm_kfree(dev, vsi->q_vectors);
 err_vectors:
 	devm_kfree(dev, vsi->rxq_map);
 err_rxq_map:
@@ -309,8 +303,6 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
 
 	dev = ice_pf_to_dev(pf);
 
-	bitmap_free(vsi->af_xdp_zc_qps);
-	vsi->af_xdp_zc_qps = NULL;
 	/* free the ring and vector containers */
 	devm_kfree(dev, vsi->q_vectors);
 	vsi->q_vectors = NULL;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index aa81d1162b81..2015f66b0cf9 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -269,7 +269,6 @@ static int ice_xsk_pool_disable(struct ice_vsi *vsi, u16 qid)
 	if (!pool)
 		return -EINVAL;
 
-	clear_bit(qid, vsi->af_xdp_zc_qps);
 	xsk_pool_dma_unmap(pool, ICE_RX_DMA_ATTR);
 
 	return 0;
@@ -300,8 +299,6 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 	if (err)
 		return err;
 
-	set_bit(qid, vsi->af_xdp_zc_qps);
-
 	return 0;
 }
 
@@ -349,11 +346,13 @@ ice_realloc_rx_xdp_bufs(struct ice_rx_ring *rx_ring, bool pool_present)
 int ice_realloc_zc_buf(struct ice_vsi *vsi, bool zc)
 {
 	struct ice_rx_ring *rx_ring;
-	unsigned long q;
+	uint i;
+
+	ice_for_each_rxq(vsi, i) {
+		rx_ring = vsi->rx_rings[i];
+		if (!rx_ring->xsk_pool)
+			continue;
 
-	for_each_set_bit(q, vsi->af_xdp_zc_qps,
-			 max_t(int, vsi->alloc_txq, vsi->alloc_rxq)) {
-		rx_ring = vsi->rx_rings[q];
 		if (ice_realloc_rx_xdp_bufs(rx_ring, zc))
 			return -ENOMEM;
 	}
-- 
2.43.0


