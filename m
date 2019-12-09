Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA7081167BB
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2019 08:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLIH4w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Dec 2019 02:56:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:35290 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfLIH4v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Dec 2019 02:56:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 23:56:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="362846866"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.32.126])
  by orsmga004.jf.intel.com with ESMTP; 08 Dec 2019 23:56:44 -0800
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com
Cc:     bpf@vger.kernel.org, saeedm@mellanox.com,
        jeffrey.t.kirsher@intel.com, maciej.fijalkowski@intel.com,
        maciejromanfijalkowski@gmail.com
Subject: [PATCH bpf-next 01/12] xsk: eliminate the lazy update threshold
Date:   Mon,  9 Dec 2019 08:56:18 +0100
Message-Id: <1575878189-31860-2-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575878189-31860-1-git-send-email-magnus.karlsson@intel.com>
References: <1575878189-31860-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The lazy update threshold was introduced to keep the producer and
consumer some distance apart in the completion ring. This was
important in the beginning of the development of AF_XDP as the ring
format as that point in time was very sensitive to the producer and
consumer being on the same cache line. This is not the case
anymore as the current ring format does not degrade in any noticeable
way when this happens. Moreover, this threshold makes it impossible
to run the system with rings that have less than 128 entries.

So let us remove this threshold and just get one entry from the ring
as in all other functions. This will enable us to remove this function
in a later commit. Note that xskq_produce_addr_lazy followed by
xskq_produce_flush_addr_n are still not the same function as
xskq_produce_addr() as it operates on another cached pointer.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk_queue.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index eddae46..a2f0ba6 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -11,7 +11,6 @@
 #include <net/xdp_sock.h>
 
 #define RX_BATCH_SIZE 16
-#define LAZY_UPDATE_THRESHOLD 128
 
 struct xdp_ring {
 	u32 producer ____cacheline_aligned_in_smp;
@@ -239,7 +238,7 @@ static inline int xskq_produce_addr_lazy(struct xsk_queue *q, u64 addr)
 {
 	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
 
-	if (xskq_nb_free(q, q->prod_head, LAZY_UPDATE_THRESHOLD) == 0)
+	if (xskq_nb_free(q, q->prod_head, 1) == 0)
 		return -ENOSPC;
 
 	/* A, matches D */
-- 
2.7.4

