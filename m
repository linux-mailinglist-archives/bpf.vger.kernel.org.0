Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EFB99033
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbfHVKAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Aug 2019 06:00:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:1799 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbfHVKAg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Aug 2019 06:00:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 03:00:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,416,1559545200"; 
   d="scan'208";a="180336757"
Received: from silpixa00399838.ir.intel.com (HELO silpixa00399838.ger.corp.intel.com) ([10.237.223.140])
  by fmsmga007.fm.intel.com with ESMTP; 22 Aug 2019 03:00:33 -0700
From:   Kevin Laatz <kevin.laatz@intel.com>
To:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bjorn.topel@intel.com, magnus.karlsson@intel.com,
        jakub.kicinski@netronome.com, jonathan.lemon@gmail.com,
        saeedm@mellanox.com, maximmi@mellanox.com,
        stephen@networkplumber.org
Cc:     bruce.richardson@intel.com, ciara.loftus@intel.com,
        bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Kevin Laatz <kevin.laatz@intel.com>
Subject: [PATCH bpf-next v5 05/11] ixgbe: modify driver for handling offsets
Date:   Thu, 22 Aug 2019 01:44:21 +0000
Message-Id: <20190822014427.49800-6-kevin.laatz@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822014427.49800-1-kevin.laatz@intel.com>
References: <20190730085400.10376-1-kevin.laatz@intel.com>
 <20190822014427.49800-1-kevin.laatz@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With the addition of the unaligned chunks option, we need to make sure we
handle the offsets accordingly based on the mode we are currently running
in. This patch modifies the driver to appropriately mask the address for
each case.

Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>

---
v3:
  - Use new helper function to handle offset
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index e1f743470ae9..17061c799f72 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -143,7 +143,9 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 			    struct ixgbe_ring *rx_ring,
 			    struct xdp_buff *xdp)
 {
+	struct xdp_umem *umem = rx_ring->xsk_umem;
 	int err, result = IXGBE_XDP_PASS;
+	u64 offset = umem->headroom;
 	struct bpf_prog *xdp_prog;
 	struct xdp_frame *xdpf;
 	u32 act;
@@ -151,7 +153,10 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
 	rcu_read_lock();
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
-	xdp->handle += xdp->data - xdp->data_hard_start;
+	offset += xdp->data - xdp->data_hard_start;
+
+	xdp->handle = xsk_umem_adjust_offset(umem, xdp->handle, offset);
+
 	switch (act) {
 	case XDP_PASS:
 		break;
@@ -243,7 +248,7 @@ void ixgbe_zca_free(struct zero_copy_allocator *alloc, unsigned long handle)
 	bi->addr = xdp_umem_get_data(rx_ring->xsk_umem, handle);
 	bi->addr += hr;
 
-	bi->handle = (u64)handle + rx_ring->xsk_umem->headroom;
+	bi->handle = (u64)handle;
 }
 
 static bool ixgbe_alloc_buffer_zc(struct ixgbe_ring *rx_ring,
@@ -269,7 +274,7 @@ static bool ixgbe_alloc_buffer_zc(struct ixgbe_ring *rx_ring,
 	bi->addr = xdp_umem_get_data(umem, handle);
 	bi->addr += hr;
 
-	bi->handle = handle + umem->headroom;
+	bi->handle = handle;
 
 	xsk_umem_discard_addr(umem);
 	return true;
@@ -296,7 +301,7 @@ static bool ixgbe_alloc_buffer_slow_zc(struct ixgbe_ring *rx_ring,
 	bi->addr = xdp_umem_get_data(umem, handle);
 	bi->addr += hr;
 
-	bi->handle = handle + umem->headroom;
+	bi->handle = handle;
 
 	xsk_umem_discard_addr_rq(umem);
 	return true;
-- 
2.17.1

