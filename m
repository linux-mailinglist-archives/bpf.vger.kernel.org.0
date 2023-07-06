Return-Path: <bpf+bounces-4321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7CA74A556
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8A31C20E85
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B0A17AB4;
	Thu,  6 Jul 2023 20:48:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F517AAB;
	Thu,  6 Jul 2023 20:48:05 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840341992;
	Thu,  6 Jul 2023 13:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676484; x=1720212484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9jPj1tlSPDvoa8YzPnRzOInKiDR1izQPHyzBSOi990k=;
  b=D3ra0Tz8hY35JPReJxeJopzqIQlwlNLYu06zqwg5LoexZBxMgznsPjFs
   /HAxcbOcjB3HpQkvfXZt5jeU49lZxivD2W+RAqa6wblUVYQhmfU3bpSji
   Z4c8kVZTdeBvrwBF3rHmQ7DZJ3B5JJx9+01iEV59Ql/GFdutGmT87z7lw
   dvXeuLfYgB2oQg6nBJPUfvOI28azYtstRXUWrq2CjcDHL9SREysZ6gpa9
   GEgEVrZoyd3xPM/QaxLzj3m4TaurqdymnMN0UxqJsAQWYrjy5aCZvFawa
   U14HLu7KbY+O5JRlQEJbTxj+4aNzEsFsgKbDo1sS3iD8KL4hujtmBHx7X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195524"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195524"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:48:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059675"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059675"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:48:01 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	tirthendu.sarkar@intel.com,
	maciej.fijalkowski@intel.com,
	simon.horman@corigine.com,
	toke@kernel.org
Subject: [PATCH v5 bpf-next 16/24] i40e: xsk: add TX multi-buffer support
Date: Thu,  6 Jul 2023 22:46:42 +0200
Message-Id: <20230706204650.469087-17-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

Set eop bit in TX desc command only for the last descriptor of the
packet and do not set for all preceding descriptors.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  1 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1bd72cdedc8a..982ae70c51e8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13817,6 +13817,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 				       NETDEV_XDP_ACT_REDIRECT |
 				       NETDEV_XDP_ACT_XSK_ZEROCOPY |
 				       NETDEV_XDP_ACT_RX_SG;
+		netdev->xdp_zc_max_segs = I40E_MAX_BUFFER_TXD;
 	} else {
 		/* Relate the VSI_VMDQ name to the VSI_MAIN name. Note that we
 		 * are still limited by IFNAMSIZ, but we're adding 'v%d\0' to
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 89a8aca1153e..37f41c8a682f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -535,6 +535,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 static void i40e_xmit_pkt(struct i40e_ring *xdp_ring, struct xdp_desc *desc,
 			  unsigned int *total_bytes)
 {
+	u32 cmd = I40E_TX_DESC_CMD_ICRC | xsk_is_eop_desc(desc);
 	struct i40e_tx_desc *tx_desc;
 	dma_addr_t dma;
 
@@ -543,8 +544,7 @@ static void i40e_xmit_pkt(struct i40e_ring *xdp_ring, struct xdp_desc *desc,
 
 	tx_desc = I40E_TX_DESC(xdp_ring, xdp_ring->next_to_use++);
 	tx_desc->buffer_addr = cpu_to_le64(dma);
-	tx_desc->cmd_type_offset_bsz = build_ctob(I40E_TX_DESC_CMD_ICRC | I40E_TX_DESC_CMD_EOP,
-						  0, desc->len, 0);
+	tx_desc->cmd_type_offset_bsz = build_ctob(cmd, 0, desc->len, 0);
 
 	*total_bytes += desc->len;
 }
@@ -558,14 +558,14 @@ static void i40e_xmit_pkt_batch(struct i40e_ring *xdp_ring, struct xdp_desc *des
 	u32 i;
 
 	loop_unrolled_for(i = 0; i < PKTS_PER_BATCH; i++) {
+		u32 cmd = I40E_TX_DESC_CMD_ICRC | xsk_is_eop_desc(&desc[i]);
+
 		dma = xsk_buff_raw_get_dma(xdp_ring->xsk_pool, desc[i].addr);
 		xsk_buff_raw_dma_sync_for_device(xdp_ring->xsk_pool, dma, desc[i].len);
 
 		tx_desc = I40E_TX_DESC(xdp_ring, ntu++);
 		tx_desc->buffer_addr = cpu_to_le64(dma);
-		tx_desc->cmd_type_offset_bsz = build_ctob(I40E_TX_DESC_CMD_ICRC |
-							  I40E_TX_DESC_CMD_EOP,
-							  0, desc[i].len, 0);
+		tx_desc->cmd_type_offset_bsz = build_ctob(cmd, 0, desc[i].len, 0);
 
 		*total_bytes += desc[i].len;
 	}
-- 
2.34.1


