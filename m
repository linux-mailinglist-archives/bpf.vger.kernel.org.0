Return-Path: <bpf+bounces-20271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280583B21A
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 20:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EB428BB7C
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB9B134739;
	Wed, 24 Jan 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eP/AU058"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B540133401;
	Wed, 24 Jan 2024 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123813; cv=none; b=OPgFbv4bb7qLvRKfr9nIkGVIt5bw4TAFPk1GQG8dPDcw7TIooyfmQJo+WogSc49hF0H55IFJ0/LslqZoIw7fIo1LB0qWRIMJHzdf3vZrd86uYK04FSPaKCn0Vdm1RYCyKi9mn8ZbHb5UxxCDoyr5yY9aWFNoCRIcEksGke/iJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123813; c=relaxed/simple;
	bh=EhF80B6ptJFcUFkUc94KutRlKlLNu7ZyCmH972IXHzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4JBEHfrcExUQr7IScXbIEygzdK193I8vauBNmCIBe1ktoIxHVvezCvz2yykzMX0EAn3vceOu6XuEdsRWwh8cYGwf5HokVq71+1+wr9y1J9M4iEbhOpoC2w1+I+yjbKIHh0PzWhzESTfzRc65ZNQeufi3qcIDQwpA7ZXIKRJCns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eP/AU058; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706123810; x=1737659810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhF80B6ptJFcUFkUc94KutRlKlLNu7ZyCmH972IXHzM=;
  b=eP/AU058eWKkgnRe0Axazv0EEXUZH9F1oV6nA1yqicKytF8Ar69Avqb6
   iUweYBXRY9bW1c1itmT+8c90rIYaTUOHc9USxoo+dJv2zJO+bo8Cs28yZ
   VF8/m/Kvp89PiqYNBIZp7EFeV7M4N/FrDCh7SoHiA+l9C3y5oy3ke2A5l
   2OMOHifPPCgyAYECKTqwe463Z5DswtaV48JOVROWFN8v9xPMRV0mm2bt0
   CsuKPUOX6v7qNnx5nt258vkrMWIoYJ4KdJuIOlA0+FzsKEY7Ey9LXDbm2
   Il5B/V54YK8f3GwTfl9ogj8V+0AWTLPGIUs3UojfXfdrHyEc/iYQI/vd0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1823232"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1823232"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 11:16:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="820553513"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="820553513"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2024 11:16:45 -0800
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
	horms@kernel.org,
	kuba@kernel.org
Subject: [PATCH v6 bpf 10/11] i40e: set xdp_rxq_info::frag_size
Date: Wed, 24 Jan 2024 20:16:01 +0100
Message-Id: <20240124191602.566724-11-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
References: <20240124191602.566724-1-maciej.fijalkowski@intel.com>
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
index ae8f9f135725..d3b00d8ed39a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3588,40 +3588,48 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
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
index 1f0a0f13a334..0d7177083708 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1548,7 +1548,6 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
 int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 {
 	struct device *dev = rx_ring->dev;
-	int err;
 
 	u64_stats_init(&rx_ring->syncp);
 
@@ -1569,14 +1568,6 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
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


