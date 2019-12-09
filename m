Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E61167C6
	for <lists+bpf@lfdr.de>; Mon,  9 Dec 2019 08:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfLIH5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Dec 2019 02:57:17 -0500
Received: from mga05.intel.com ([192.55.52.43]:35353 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIH5Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Dec 2019 02:57:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2019 23:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="362846917"
Received: from mkarlsso-mobl.ger.corp.intel.com (HELO localhost.localdomain) ([10.249.32.126])
  by orsmga004.jf.intel.com with ESMTP; 08 Dec 2019 23:57:01 -0800
From:   Magnus Karlsson <magnus.karlsson@intel.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com
Cc:     bpf@vger.kernel.org, saeedm@mellanox.com,
        jeffrey.t.kirsher@intel.com, maciej.fijalkowski@intel.com,
        maciejromanfijalkowski@gmail.com
Subject: [PATCH bpf-next 06/12] xsk: simplify xskq_nb_avail and xskq_nb_free
Date:   Mon,  9 Dec 2019 08:56:23 +0100
Message-Id: <1575878189-31860-7-git-send-email-magnus.karlsson@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575878189-31860-1-git-send-email-magnus.karlsson@intel.com>
References: <1575878189-31860-1-git-send-email-magnus.karlsson@intel.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

At this point, there are no users of the functions xskq_nb_avail and
xskq_nb_free that take any other number of entries argument than 1, so
let us get rid of the second argument that takes the number of
entries.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
---
 net/xdp/xsk_queue.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index e3ae62d..deda03c 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -89,7 +89,7 @@ static inline u64 xskq_nb_invalid_descs(struct xsk_queue *q)
 	return q ? q->invalid_descs : 0;
 }
 
-static inline u32 xskq_nb_avail(struct xsk_queue *q, u32 dcnt)
+static inline u32 xskq_nb_avail(struct xsk_queue *q)
 {
 	u32 entries = q->cached_prod - q->cons_tail;
 
@@ -99,19 +99,21 @@ static inline u32 xskq_nb_avail(struct xsk_queue *q, u32 dcnt)
 		entries = q->cached_prod - q->cons_tail;
 	}
 
-	return (entries > dcnt) ? dcnt : entries;
+	return entries;
 }
 
-static inline u32 xskq_nb_free(struct xsk_queue *q, u32 dcnt)
+static inline bool xskq_prod_is_full(struct xsk_queue *q)
 {
 	u32 free_entries = q->nentries - (q->cached_prod - q->cons_tail);
 
-	if (free_entries >= dcnt)
-		return free_entries;
+	if (free_entries)
+		return false;
 
 	/* Refresh the local tail pointer */
 	q->cons_tail = READ_ONCE(q->ring->consumer);
-	return q->nentries - (q->cached_prod - q->cons_tail);
+	free_entries = q->nentries - (q->cached_prod - q->cons_tail);
+
+	return !free_entries;
 }
 
 static inline bool xskq_has_addrs(struct xsk_queue *q, u32 cnt)
@@ -200,7 +202,7 @@ static inline u64 *xskq_peek_addr(struct xsk_queue *q, u64 *addr,
 	if (q->cons_tail == q->cons_head) {
 		smp_mb(); /* D, matches A */
 		WRITE_ONCE(q->ring->consumer, q->cons_tail);
-		q->cons_head = q->cons_tail + xskq_nb_avail(q, 1);
+		q->cons_head = q->cons_tail + xskq_nb_avail(q);
 
 		/* Order consumer and data */
 		smp_rmb();
@@ -216,7 +218,7 @@ static inline void xskq_discard_addr(struct xsk_queue *q)
 
 static inline int xskq_prod_reserve(struct xsk_queue *q)
 {
-	if (xskq_nb_free(q, 1) == 0)
+	if (xskq_prod_is_full(q))
 		return -ENOSPC;
 
 	/* A, matches D */
@@ -228,7 +230,7 @@ static inline int xskq_prod_reserve_addr(struct xsk_queue *q, u64 addr)
 {
 	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
 
-	if (xskq_nb_free(q, 1) == 0)
+	if (xskq_prod_is_full(q))
 		return -ENOSPC;
 
 	/* A, matches D */
@@ -318,7 +320,7 @@ static inline struct xdp_desc *xskq_peek_desc(struct xsk_queue *q,
 	if (q->cons_tail == q->cons_head) {
 		smp_mb(); /* D, matches A */
 		WRITE_ONCE(q->ring->consumer, q->cons_tail);
-		q->cons_head = q->cons_tail + xskq_nb_avail(q, 1);
+		q->cons_head = q->cons_tail + xskq_nb_avail(q);
 
 		/* Order consumer and data */
 		smp_rmb(); /* C, matches B */
@@ -338,7 +340,7 @@ static inline int xskq_prod_reserve_desc(struct xsk_queue *q,
 	struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
 	u32 idx;
 
-	if (xskq_nb_free(q, 1) == 0)
+	if (xskq_prod_is_full(q))
 		return -ENOSPC;
 
 	/* A, matches D */
-- 
2.7.4

