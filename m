Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54499E5DB
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2019 12:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfH0KlY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Aug 2019 06:41:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:38490 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfH0KlY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Aug 2019 06:41:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 03:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="scan'208";a="174509534"
Received: from silpixa00399838.ir.intel.com (HELO silpixa00399838.ger.corp.intel.com) ([10.237.223.140])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2019 03:41:20 -0700
From:   Kevin Laatz <kevin.laatz@intel.com>
To:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bjorn.topel@intel.com, magnus.karlsson@intel.com,
        jakub.kicinski@netronome.com, jonathan.lemon@gmail.com,
        saeedm@mellanox.com, maximmi@mellanox.com,
        stephen@networkplumber.org
Cc:     bruce.richardson@intel.com, ciara.loftus@intel.com,
        bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH bpf-next v6 02/12] ixgbe: simplify Rx buffer recycle
Date:   Tue, 27 Aug 2019 02:25:21 +0000
Message-Id: <20190827022531.15060-3-kevin.laatz@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827022531.15060-1-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, the dma, addr and handle are modified when we reuse Rx buffers
in zero-copy mode. However, this is not required as the inputs to the
function are copies, not the original values themselves. As we use the
copies within the function, we can use the original 'obi' values
directly without having to mask and add the headroom.

Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 9a28d98a1484..e1f743470ae9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -201,8 +201,6 @@ ixgbe_rx_buffer *ixgbe_get_rx_buffer_zc(struct ixgbe_ring *rx_ring,
 static void ixgbe_reuse_rx_buffer_zc(struct ixgbe_ring *rx_ring,
 				     struct ixgbe_rx_buffer *obi)
 {
-	unsigned long mask = (unsigned long)rx_ring->xsk_umem->chunk_mask;
-	u64 hr = rx_ring->xsk_umem->headroom + XDP_PACKET_HEADROOM;
 	u16 nta = rx_ring->next_to_alloc;
 	struct ixgbe_rx_buffer *nbi;
 
@@ -212,14 +210,9 @@ static void ixgbe_reuse_rx_buffer_zc(struct ixgbe_ring *rx_ring,
 	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
 
 	/* transfer page from old buffer to new buffer */
-	nbi->dma = obi->dma & mask;
-	nbi->dma += hr;
-
-	nbi->addr = (void *)((unsigned long)obi->addr & mask);
-	nbi->addr += hr;
-
-	nbi->handle = obi->handle & mask;
-	nbi->handle += rx_ring->xsk_umem->headroom;
+	nbi->dma = obi->dma;
+	nbi->addr = obi->addr;
+	nbi->handle = obi->handle;
 
 	obi->addr = NULL;
 	obi->skb = NULL;
-- 
2.17.1

