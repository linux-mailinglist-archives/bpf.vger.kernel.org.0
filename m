Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFA14D4E7
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2019 19:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfFTRYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jun 2019 13:24:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:64663 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732148AbfFTRYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jun 2019 13:24:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 10:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,397,1557212400"; 
   d="scan'208";a="359020344"
Received: from silpixa00399838.ir.intel.com (HELO silpixa00399838.ger.corp.intel.com) ([10.237.223.110])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jun 2019 10:24:41 -0700
From:   Kevin Laatz <kevin.laatz@intel.com>
To:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bjorn.topel@intel.com, magnus.karlsson@intel.com
Cc:     bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        bruce.richardson@intel.com, ciara.loftus@intel.com,
        Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH 04/11] i40e: add offset to zca_free
Date:   Thu, 20 Jun 2019 09:09:51 +0000
Message-Id: <20190620090958.2135-5-kevin.laatz@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190620090958.2135-1-kevin.laatz@intel.com>
References: <20190620090958.2135-1-kevin.laatz@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds the offset param to for zero_copy_allocator to
i40e_zca_free. This change is required to calculate the handle, otherwise,
this function will not work in unaligned chunk mode since we can't easily mask
back to the original handle in unaligned chunk mode.

Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 8 ++++----
 drivers/net/ethernet/intel/i40e/i40e_xsk.h | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index c89e692e8663..8c281f356293 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -438,16 +438,16 @@ static void i40e_reuse_rx_buffer_zc(struct i40e_ring *rx_ring,
  * @alloc: Zero-copy allocator
  * @handle: Buffer handle
  **/
-void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
+void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle,
+		off_t off)
 {
 	struct i40e_rx_buffer *bi;
 	struct i40e_ring *rx_ring;
-	u64 hr, mask;
+	u64 hr;
 	u16 nta;
 
 	rx_ring = container_of(alloc, struct i40e_ring, zca);
 	hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
-	mask = rx_ring->xsk_umem->chunk_mask;
 
 	nta = rx_ring->next_to_alloc;
 	bi = &rx_ring->rx_bi[nta];
@@ -455,7 +455,7 @@ void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
 	nta++;
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
-	handle &= mask;
+	handle -= off;
 
 	bi->dma = xdp_umem_get_dma(rx_ring->xsk_umem, handle);
 	bi->dma += hr;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
index 8cc0a2e7d9a2..85691dc9ac42 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
@@ -12,7 +12,8 @@ int i40e_queue_pair_disable(struct i40e_vsi *vsi, int queue_pair);
 int i40e_queue_pair_enable(struct i40e_vsi *vsi, int queue_pair);
 int i40e_xsk_umem_setup(struct i40e_vsi *vsi, struct xdp_umem *umem,
 			u16 qid);
-void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle);
+void i40e_zca_free(struct zero_copy_allocator *alloc, unsigned long handle,
+		off_t off);
 bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 cleaned_count);
 int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget);
 
-- 
2.17.1

