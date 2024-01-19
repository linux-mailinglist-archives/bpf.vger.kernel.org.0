Return-Path: <bpf+bounces-19947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6817783318F
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1300A1F213EB
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601C45A7A5;
	Fri, 19 Jan 2024 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUqkAxEW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4F5917B;
	Fri, 19 Jan 2024 23:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707082; cv=none; b=oD/6yAs0lcVPbgALeiHNJ7thszUy1NsvV0cc0rd/ZhMwdco6FXYBUx045FKa+f/t5jdY6PdxjJFOPjajO6kNCUOUHCZOAUGUsPnigTwGhUCW/OSLBtXSuftymsWQvHTsYB+1DF/1kT0kv9mtIIwz74FtfROwAv7XhFD8JLF+FLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707082; c=relaxed/simple;
	bh=ouiUw1Og57gJUKW0muhBoN/tkTfX1k+7XtoJrznP63Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9HAn4jU+W/QD8z1chL/M9jhq1CZq3zNDtSJvyiMzcToM1zBiENGc4mPDf7zkIwWfWfK2tF0HAcVK6yefgtUZePfOaX2GXXqtEik8674qBRJieDOMQJD4mz8u/I2qJBsQgBLBCQtOMRLbCwoIDjzaMmOKA5bnY9ARMtmNWDQAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUqkAxEW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707081; x=1737243081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ouiUw1Og57gJUKW0muhBoN/tkTfX1k+7XtoJrznP63Y=;
  b=WUqkAxEWv0BFMHqaerDBVsANMbxjWzY6JoE3jh+y1aZDcABjq2xEQGev
   xxS4ApoEltU/44Di8PF6OdJTLVJdAiBgMl0aCq/4VH60ZOyY4ebwQiAZi
   hUcBRlV/APMXAk3/yAD6GV/bCZwueixiN6Sr9YlgftcNxa8SmZ2SfrqAW
   Nx3bptH9mFJGhZktuKYAYrWokXozB0rOFfXc14OUaGh+dMXOGp5dKb7fo
   4EjSdcrK/gWSgTTen2/7v9vKVX98KieMC3K6Cm+NdWT895ZUSZsiDfIWG
   152aNthH+K/BgUbqGZYbkZQH+WFofF1Zlm7DWt+W5Z4QR21q8gui0Qvf3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="771679"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="771679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:31:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904277458"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="904277458"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga002.fm.intel.com with ESMTP; 19 Jan 2024 15:31:18 -0800
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
	john.fastabend@gmail.com
Subject: [PATCH v4 bpf 10/11] i40e: set xdp_rxq_info::frag_size
Date: Sat, 20 Jan 2024 00:30:36 +0100
Message-Id: <20240119233037.537084-11-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
References: <20240119233037.537084-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i40e supports XDP multi-buffer so it is supposed to use
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
index b098ca2c11af..c98bc48cfd7b 100644
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


