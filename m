Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710D35EB224
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 22:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIZUcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiIZUc0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 16:32:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A4A4B04;
        Mon, 26 Sep 2022 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664224344; x=1695760344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TzPe4jqGal47mHevLwP6Ki+CykWh9W87O1C8hiHCbgk=;
  b=XBpw+hWx8P+BVuHhppfaiGDtqoAAKO1kHioqTgm5NNBXTUbpvHg8d4mC
   Wp9ihg5/S0t+vZqPo0IYRM3C1U02Lk3OIsjibko1OoQie/l1u1TBIe6YO
   bXJLG3bPoEUrRn8GJaGnGogL2MffZcN/fdeX7B8CBuIWIVlrBZ5hqHZxE
   6LQCLBl+oN9lmrHSMgknfl2coWWHSP2hqQJi8Ymw/p+ZYeMU4yaFyoPJ0
   h2nSdoHWH4dtKQVzBeyzj+CuYL41jzKXHgYEei4FpGay3iYHPqhg+tPwr
   BKzY97dYTcom9B24CxG2lXssN+JhmFatBHcTYRzvbKv0WcNAg6NywNRl3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="281508587"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="281508587"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 13:32:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="616547452"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="616547452"
Received: from anguy11-desk2.jf.intel.com ([10.166.244.147])
  by orsmga007.jf.intel.com with ESMTP; 26 Sep 2022 13:32:20 -0700
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
To:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com
Cc:     Jan Sokolowski <jan.sokolowski@intel.com>, netdev@vger.kernel.org,
        anthony.l.nguyen@intel.com, bjorn@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        Chandan <chandanx.rout@intel.com>
Subject: [PATCH net 3/3] i40e: Fix DMA mappings leak
Date:   Mon, 26 Sep 2022 13:32:14 -0700
Message-Id: <20220926203214.3678419-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220926203214.3678419-1-anthony.l.nguyen@intel.com>
References: <20220926203214.3678419-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jan Sokolowski <jan.sokolowski@intel.com>

During reallocation of RX buffers, new DMA mappings are created for
those buffers. New buffers with different RX ring count should
substitute older ones, but those buffers were freed in
i40e_configure_rx_ring and reallocated again with i40e_alloc_rx_bi,
thus kfree on rx_bi caused leak of already mapped DMA.

In case of non XDP ring, do not free rx_bi and reuse already existing
buffer, move kfree to XDP rings only, remove unused i40e_alloc_rx_bi
function.

steps for reproduction:
while :
do
for ((i=0; i<=8160; i=i+32))
do
ethtool -G enp130s0f0 rx $i tx $i
sleep 0.5
ethtool -g enp130s0f0
done
done

Fixes: be1222b585fd ("i40e: Separate kernel allocated rx_bi rings from AF_XDP rings")
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Tested-by: Chandan <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 -
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 13 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 13 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 67 ++++++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  2 +-
 6 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index e518aaa2c0ca..0f2042f1597c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2181,9 +2181,6 @@ static int i40e_set_ringparam(struct net_device *netdev,
 			 */
 			rx_rings[i].tail = hw->hw_addr + I40E_PRTGEN_STATUS;
 			err = i40e_setup_rx_descriptors(&rx_rings[i]);
-			if (err)
-				goto rx_unwind;
-			err = i40e_alloc_rx_bi(&rx_rings[i]);
 			if (err)
 				goto rx_unwind;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 452ed104766e..e8d1fb8a966b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3565,12 +3565,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	if (ring->vsi->type == I40E_VSI_MAIN)
 		xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
 
-	kfree(ring->rx_bi);
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
-		ret = i40e_alloc_rx_bi_zc(ring);
-		if (ret)
-			return ret;
 		ring->rx_buf_len =
 		  xsk_pool_get_rx_frame_size(ring->xsk_pool);
 		/* For AF_XDP ZC, we disallow packets to span on
@@ -3588,9 +3584,6 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 			 ring->queue_index);
 
 	} else {
-		ret = i40e_alloc_rx_bi(ring);
-		if (ret)
-			return ret;
 		ring->rx_buf_len = vsi->rx_buf_len;
 		if (ring->vsi->type == I40E_VSI_MAIN) {
 			ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -13413,6 +13406,11 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
 		i40e_reset_and_rebuild(pf, true, true);
 	}
 
+	if (!i40e_enabled_xdp_vsi(vsi) && prog)
+		i40e_realloc_rx_bi_zc(vsi, true);
+	else if (i40e_enabled_xdp_vsi(vsi) && !prog)
+		i40e_realloc_rx_bi_zc(vsi, false);
+
 	for (i = 0; i < vsi->num_queue_pairs; i++)
 		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
 
@@ -13645,6 +13643,7 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair)
 
 	i40e_queue_pair_disable_irq(vsi, queue_pair);
 	err = i40e_queue_pair_toggle_rings(vsi, queue_pair, false /* off */);
+	i40e_clean_rx_ring(vsi->rx_rings[queue_pair]);
 	i40e_queue_pair_toggle_napi(vsi, queue_pair, false /* off */);
 	i40e_queue_pair_clean_rings(vsi, queue_pair);
 	i40e_queue_pair_reset_stats(vsi, queue_pair);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 69e67eb6aea7..b97c95f89fa0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1457,14 +1457,6 @@ int i40e_setup_tx_descriptors(struct i40e_ring *tx_ring)
 	return -ENOMEM;
 }
 
-int i40e_alloc_rx_bi(struct i40e_ring *rx_ring)
-{
-	unsigned long sz = sizeof(*rx_ring->rx_bi) * rx_ring->count;
-
-	rx_ring->rx_bi = kzalloc(sz, GFP_KERNEL);
-	return rx_ring->rx_bi ? 0 : -ENOMEM;
-}
-
 static void i40e_clear_rx_bi(struct i40e_ring *rx_ring)
 {
 	memset(rx_ring->rx_bi, 0, sizeof(*rx_ring->rx_bi) * rx_ring->count);
@@ -1593,6 +1585,11 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 
 	rx_ring->xdp_prog = rx_ring->vsi->xdp_prog;
 
+	rx_ring->rx_bi =
+		kcalloc(rx_ring->count, sizeof(*rx_ring->rx_bi), GFP_KERNEL);
+	if (!rx_ring->rx_bi)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 41f86e9535a0..768290dc6f48 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -469,7 +469,6 @@ int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
 bool __i40e_chk_linearize(struct sk_buff *skb);
 int i40e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 		  u32 flags);
-int i40e_alloc_rx_bi(struct i40e_ring *rx_ring);
 
 /**
  * i40e_get_head - Retrieve head from head writeback
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 6d4009e0cbd6..790aaeff1b47 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -10,14 +10,6 @@
 #include "i40e_txrx_common.h"
 #include "i40e_xsk.h"
 
-int i40e_alloc_rx_bi_zc(struct i40e_ring *rx_ring)
-{
-	unsigned long sz = sizeof(*rx_ring->rx_bi_zc) * rx_ring->count;
-
-	rx_ring->rx_bi_zc = kzalloc(sz, GFP_KERNEL);
-	return rx_ring->rx_bi_zc ? 0 : -ENOMEM;
-}
-
 void i40e_clear_rx_bi_zc(struct i40e_ring *rx_ring)
 {
 	memset(rx_ring->rx_bi_zc, 0,
@@ -29,6 +21,58 @@ static struct xdp_buff **i40e_rx_bi(struct i40e_ring *rx_ring, u32 idx)
 	return &rx_ring->rx_bi_zc[idx];
 }
 
+/**
+ * i40e_realloc_rx_xdp_bi - reallocate for either XSK or normal buffer
+ * @rx_ring: Current rx ring
+ * @pool_present: is pool for XSK present
+ *
+ * Try allocating memory and return ENOMEM, if failed to allocate.
+ * If allocation was successful, substitute buffer with allocated one.
+ * Returns 0 on success, negative on failure
+ */
+static int i40e_realloc_rx_xdp_bi(struct i40e_ring *rx_ring, bool pool_present)
+{
+	size_t elem_size = pool_present ? sizeof(*rx_ring->rx_bi_zc) :
+					  sizeof(*rx_ring->rx_bi);
+	void *sw_ring = kcalloc(rx_ring->count, elem_size, GFP_KERNEL);
+
+	if (!sw_ring)
+		return -ENOMEM;
+
+	if (pool_present) {
+		kfree(rx_ring->rx_bi);
+		rx_ring->rx_bi = NULL;
+		rx_ring->rx_bi_zc = sw_ring;
+	} else {
+		kfree(rx_ring->rx_bi_zc);
+		rx_ring->rx_bi_zc = NULL;
+		rx_ring->rx_bi = sw_ring;
+	}
+	return 0;
+}
+
+/**
+ * i40e_realloc_rx_bi_zc - reallocate xdp queue pairs
+ * @vsi: Current VSI
+ * @zc: is zero copy set
+ *
+ * Reallocate buffer for rx_rings that might be used by XSK.
+ * XDP requires more memory, than rx_buf provides.
+ * Returns 0 on success, negative on failure
+ */
+int i40e_realloc_rx_bi_zc(struct i40e_vsi *vsi, bool zc)
+{
+	struct i40e_ring *rx_ring;
+	unsigned long q;
+
+	for_each_set_bit(q, vsi->af_xdp_zc_qps, vsi->alloc_queue_pairs) {
+		rx_ring = vsi->rx_rings[q];
+		if (i40e_realloc_rx_xdp_bi(rx_ring, zc))
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 /**
  * i40e_xsk_pool_enable - Enable/associate an AF_XDP buffer pool to a
  * certain ring/qid
@@ -69,6 +113,10 @@ static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
 		if (err)
 			return err;
 
+		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
+		if (err)
+			return err;
+
 		err = i40e_queue_pair_enable(vsi, qid);
 		if (err)
 			return err;
@@ -113,6 +161,9 @@ static int i40e_xsk_pool_disable(struct i40e_vsi *vsi, u16 qid)
 	xsk_pool_dma_unmap(pool, I40E_RX_DMA_ATTR);
 
 	if (if_running) {
+		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], false);
+		if (err)
+			return err;
 		err = i40e_queue_pair_enable(vsi, qid);
 		if (err)
 			return err;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
index bb962987f300..821df248f8be 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
@@ -32,7 +32,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget);
 
 bool i40e_clean_xdp_tx_irq(struct i40e_vsi *vsi, struct i40e_ring *tx_ring);
 int i40e_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
-int i40e_alloc_rx_bi_zc(struct i40e_ring *rx_ring);
+int i40e_realloc_rx_bi_zc(struct i40e_vsi *vsi, bool zc);
 void i40e_clear_rx_bi_zc(struct i40e_ring *rx_ring);
 
 #endif /* _I40E_XSK_H_ */
-- 
2.35.1

