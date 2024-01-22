Return-Path: <bpf+bounces-20051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE2837604
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 23:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49800B24C4D
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 22:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8524B5B3;
	Mon, 22 Jan 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLovOCwO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6448798;
	Mon, 22 Jan 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705961811; cv=none; b=XB1CwqsEAjcFFuFZfyogPgDqZoOQvtDz+SMKmA5mi6JQmWVngr4p4OUR67vPrG5fmmwlXrw0mEWrqbpzmCnKo27Ba7Xwb4H7OJNFOnBds3377kThmWbpkiK6hbS0WF5JbZQI1NsvYrE7Q1C2OqKhMeNBBrWKEGFw8YrMw7A9Y60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705961811; c=relaxed/simple;
	bh=NXeuN9tXj00jmdXDpj7xd33Nuv+O/wpI6p/DaN+fR8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UCZhoNqTj5gkMlWbk99UCmu0KzT02CYWRDrKco1jUKjkmRMR/eggIYWLWXHUftSVwr0xoZex5RFo3w2Ev4qRlTx67GO0kWrnSCC8a9WorDdozqS07EECs/zTevpO7SW1/DnYSa2GoEbYPUof5M7iL0Qy26t9ZDLxg+Gh0MQNugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLovOCwO; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705961811; x=1737497811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXeuN9tXj00jmdXDpj7xd33Nuv+O/wpI6p/DaN+fR8M=;
  b=VLovOCwOb6jE0JNQMR+7Xdu+mUZSyvSoAXH2Nv/q7xZUAIuVISk9Av9m
   Sh2LHW5B0yDQnPnHS2y6TIgpD7d9rMiLypEElQqY4XvUqhU64KTZD7yIQ
   XmCN+7ZgeU7yNk9JkG/pk3J8SKEmI7WbveX2Lho92hglg2z1Fpbg48vUg
   kXYzHQ4GF569f3n6ALRYSBcuiMqvuWXc7YB/ZBWDzJke99EC+GtLSNoga
   4g0ephnlFWA+gvvI9V9HTJz0MFPL57mDdLzXZVIgkCpTiPFLj3qrzdrZb
   TPbl4t/rYDG+yps5wllUXcpvdD1FwPYYl4mww+FV9KCAWxIs4Lc2VJIzR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="7995665"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="7995665"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="1360864"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jan 2024 14:16:47 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	echaudro@redhat.com,
	lorenzo@kernel.org,
	martin.lau@linux.dev,
	tirthendu.sarkar@intel.com,
	john.fastabend@gmail.com,
	horms@kernel.org
Subject: [PATCH v5 bpf 10/11] i40e: set xdp_rxq_info::frag_size
Date: Mon, 22 Jan 2024 23:16:09 +0100
Message-Id: <20240122221610.556746-11-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
References: <20240122221610.556746-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i40e support XDP multi-buffer so it is supposed to use
__xdp_rxq_info_reg() instead of xdp_rxq_info_reg() and set the
frag_size. It can not be simply converted at existing callsite because
rx_buf_len could be un-initialized, so let us register xdp_rxq_info
within i40e_configure_rx_ring(), which happen to be called with already
initialized rx_buf_len value.

Commit 5180ff1364bc ("i40e: use int for i40e_status") converted 'err' to
int, so two variables to deal with return codes are not needed within
i40e_configure_rx_ring(). Remove 'ret' and use 'err' to handle status
from xdp_rxq_info registration.

Fixes: e213ced19bef ("i40e: add support for XDP multi-buffer Rx")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 40 ++++++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  9 -----
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index dc642efe1cfa..f8d513499607 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3586,40 +3586,48 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	struct i40e_hmc_obj_rxq rx_ctx;
 	int err = 0;
 	bool ok;
-	int ret;
 
 	bitmap_zero(ring->state, __I40E_RING_STATE_NBITS);
 
 	/* clear the context structure first */
 	memset(&rx_ctx, 0, sizeof(rx_ctx));
 
-	if (ring->vsi->type == I40E_VSI_MAIN)
-		xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
+	ring->rx_buf_len = vsi->rx_buf_len;
+
+	/* XDP RX-queue info only needed for RX rings exposed to XDP */
+	if (ring->vsi->type != I40E_VSI_MAIN)
+		goto skip;
+
+	if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
+		err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
+					 ring->queue_index,
+					 ring->q_vector->napi.napi_id,
+					 ring->rx_buf_len);
+		if (err)
+			return err;
+	}
 
 	ring->xsk_pool = i40e_xsk_pool(ring);
 	if (ring->xsk_pool) {
-		ring->rx_buf_len =
-		  xsk_pool_get_rx_frame_size(ring->xsk_pool);
-		ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+		ring->rx_buf_len = xsk_pool_get_rx_frame_size(ring->xsk_pool);
+		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL,
 						 NULL);
-		if (ret)
-			return ret;
+		if (err)
+			return err;
 		dev_info(&vsi->back->pdev->dev,
 			 "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 			 ring->queue_index);
 
 	} else {
-		ring->rx_buf_len = vsi->rx_buf_len;
-		if (ring->vsi->type == I40E_VSI_MAIN) {
-			ret = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-							 MEM_TYPE_PAGE_SHARED,
-							 NULL);
-			if (ret)
-				return ret;
-		}
+		err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
+						 MEM_TYPE_PAGE_SHARED,
+						 NULL);
+		if (err)
+			return err;
 	}
 
+skip:
 	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 377e05dc0c68..f0a44e6d4884 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1555,7 +1555,6 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 {
 	struct device *dev = rx_ring->dev;
-	int err;
 
 	u64_stats_init(&rx_ring->syncp);
 
@@ -1576,14 +1575,6 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 	rx_ring->next_to_process = 0;
 	rx_ring->next_to_use = 0;
 
-	/* XDP RX-queue info only needed for RX rings exposed to XDP */
-	if (rx_ring->vsi->type == I40E_VSI_MAIN) {
-		err = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
-				       rx_ring->queue_index, rx_ring->q_vector->napi.napi_id);
-		if (err < 0)
-			return err;
-	}
-
 	rx_ring->xdp_prog = rx_ring->vsi->xdp_prog;
 
 	rx_ring->rx_bi =
-- 
2.34.1


