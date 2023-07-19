Return-Path: <bpf+bounces-5291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D457596C4
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040031C20F98
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76E174FD;
	Wed, 19 Jul 2023 13:25:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C653174C2;
	Wed, 19 Jul 2023 13:25:16 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAA910FE;
	Wed, 19 Jul 2023 06:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773114; x=1721309114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=to5ha/MYfi2WsHwloP5q5eXqgLxUFpWOieseUIZNXa0=;
  b=NOeamX86KcrFuWqD7HMpNFF9jpaWK5HkxrzsPRUDVVdSTkvCnovi+g64
   JpuEBaBeAMMuUsAD/vkO6qBr6egwjEIGndVZmhLKFPzdut3VW7L6Rkdck
   xqlCJRO1Xg+p6fXe4044YWamF3GgwOUsoXlB6SfyVzjg/wAEvbfxOjfb8
   40i51NiYhGWJCgjHZURQOd+xgQpW01UZGOL+vFv64nJPFBQlTeSyBx140
   fkLBTi2qZ5/+kZTsiFVPogplmlW4BqF5L9rL/mulPoaxxV8X90KNy9OTa
   u7FTnd+1ZSVdb8s2fbVbXSmkFO1wjGyOPot2lha4U/t7OQ0ke2pLnrFjP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920550"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920550"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717978040"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717978040"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:24:50 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com
Subject: [PATCH v7 bpf-next 06/24] xsk: introduce wrappers and helpers for supporting multi-buffer in Tx path
Date: Wed, 19 Jul 2023 15:24:03 +0200
Message-Id: <20230719132421.584801-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tirthendu Sarkar <tirthendu.sarkar@intel.com>

In Tx path, xsk core reserves space for each desc to be transmitted in
the completion queue and it's address contained in it is stored in the
skb destructor arg. After successful transmission the skb destructor
submits the addr marking completion.

To handle multiple descriptors per packet, now along with reserving
space for each descriptor, the corresponding address is also stored in
completion queue. The number of pending descriptors are stored in skb
destructor arg and is used by the skb destructor to update completions.

Introduce 'skb' in xdp_sock to store a partially built packet when
__xsk_generic_xmit() must return before it sees the EOP descriptor for
the current packet so that packet building can resume in next call of
__xsk_generic_xmit().

Helper functions are introduced to set and get the pending descriptors
in the skb destructor arg. Also, wrappers are introduced for storing
descriptor addresses, submitting and cancelling (for unsuccessful
transmissions) the number of completions.

Signed-off-by: Tirthendu Sarkar <tirthendu.sarkar@intel.com>
---
 include/net/xdp_sock.h |  6 ++++
 net/xdp/xsk.c          | 74 ++++++++++++++++++++++++++++++------------
 net/xdp/xsk_queue.h    | 19 ++++-------
 3 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 36b0411a0d1b..1617af380162 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -68,6 +68,12 @@ struct xdp_sock {
 	u64 rx_dropped;
 	u64 rx_queue_full;
 
+	/* When __xsk_generic_xmit() must return before it sees the EOP descriptor for the current
+	 * packet, the partially built skb is saved here so that packet building can resume in next
+	 * call of __xsk_generic_xmit().
+	 */
+	struct sk_buff *skb;
+
 	struct list_head map_list;
 	/* Protects map_list */
 	spinlock_t map_list_lock;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 01c134b1186e..ed7f86300087 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -480,19 +480,65 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static void xsk_destruct_skb(struct sk_buff *skb)
+static int xsk_cq_reserve_addr_locked(struct xdp_sock *xs, u64 addr)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&xs->pool->cq_lock, flags);
+	ret = xskq_prod_reserve_addr(xs->pool->cq, addr);
+	spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
+
+	return ret;
+}
+
+static void xsk_cq_submit_locked(struct xdp_sock *xs, u32 n)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&xs->pool->cq_lock, flags);
+	xskq_prod_submit_n(xs->pool->cq, n);
+	spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
+}
+
+static void xsk_cq_cancel_locked(struct xdp_sock *xs, u32 n)
 {
-	u64 addr = (u64)(long)skb_shinfo(skb)->destructor_arg;
-	struct xdp_sock *xs = xdp_sk(skb->sk);
 	unsigned long flags;
 
 	spin_lock_irqsave(&xs->pool->cq_lock, flags);
-	xskq_prod_submit_addr(xs->pool->cq, addr);
+	xskq_prod_cancel_n(xs->pool->cq, n);
 	spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
+}
+
+static u32 xsk_get_num_desc(struct sk_buff *skb)
+{
+	return skb ? (long)skb_shinfo(skb)->destructor_arg : 0;
+}
 
+static void xsk_destruct_skb(struct sk_buff *skb)
+{
+	xsk_cq_submit_locked(xdp_sk(skb->sk), xsk_get_num_desc(skb));
 	sock_wfree(skb);
 }
 
+static void xsk_set_destructor_arg(struct sk_buff *skb)
+{
+	long num = xsk_get_num_desc(xdp_sk(skb->sk)->skb) + 1;
+
+	skb_shinfo(skb)->destructor_arg = (void *)num;
+}
+
+static void xsk_consume_skb(struct sk_buff *skb)
+{
+	struct xdp_sock *xs = xdp_sk(skb->sk);
+
+	skb->destructor = sock_wfree;
+	xsk_cq_cancel_locked(xs, xsk_get_num_desc(skb));
+	/* Free skb without triggering the perf drop trace */
+	consume_skb(skb);
+	xs->skb = NULL;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -578,8 +624,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	skb->dev = dev;
 	skb->priority = xs->sk.sk_priority;
 	skb->mark = xs->sk.sk_mark;
-	skb_shinfo(skb)->destructor_arg = (void *)(long)desc->addr;
 	skb->destructor = xsk_destruct_skb;
+	xsk_set_destructor_arg(skb);
 
 	return skb;
 }
@@ -591,7 +637,6 @@ static int __xsk_generic_xmit(struct sock *sk)
 	bool sent_frame = false;
 	struct xdp_desc desc;
 	struct sk_buff *skb;
-	unsigned long flags;
 	int err = 0;
 
 	mutex_lock(&xs->mutex);
@@ -616,31 +661,20 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		spin_lock_irqsave(&xs->pool->cq_lock, flags);
-		if (xskq_prod_reserve(xs->pool->cq)) {
-			spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
+		if (xsk_cq_reserve_addr_locked(xs, desc.addr))
 			goto out;
-		}
-		spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
 
 		skb = xsk_build_skb(xs, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
-			spin_lock_irqsave(&xs->pool->cq_lock, flags);
-			xskq_prod_cancel(xs->pool->cq);
-			spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
+			xsk_cq_cancel_locked(xs, 1);
 			goto out;
 		}
 
 		err = __dev_direct_xmit(skb, xs->queue_id);
 		if  (err == NETDEV_TX_BUSY) {
 			/* Tell user-space to retry the send */
-			skb->destructor = sock_wfree;
-			spin_lock_irqsave(&xs->pool->cq_lock, flags);
-			xskq_prod_cancel(xs->pool->cq);
-			spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
-			/* Free skb without triggering the perf drop trace */
-			consume_skb(skb);
+			xsk_consume_skb(skb);
 			err = -EAGAIN;
 			goto out;
 		}
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 2f1aacae81af..423ad7368fa2 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -297,6 +297,11 @@ static inline void xskq_cons_release(struct xsk_queue *q)
 	q->cached_cons++;
 }
 
+static inline void xskq_cons_cancel_n(struct xsk_queue *q, u32 cnt)
+{
+	q->cached_cons -= cnt;
+}
+
 static inline u32 xskq_cons_present_entries(struct xsk_queue *q)
 {
 	/* No barriers needed since data is not accessed */
@@ -324,9 +329,9 @@ static inline bool xskq_prod_is_full(struct xsk_queue *q)
 	return xskq_prod_nb_free(q, 1) ? false : true;
 }
 
-static inline void xskq_prod_cancel(struct xsk_queue *q)
+static inline void xskq_prod_cancel_n(struct xsk_queue *q, u32 cnt)
 {
-	q->cached_prod--;
+	q->cached_prod -= cnt;
 }
 
 static inline int xskq_prod_reserve(struct xsk_queue *q)
@@ -392,16 +397,6 @@ static inline void xskq_prod_submit(struct xsk_queue *q)
 	__xskq_prod_submit(q, q->cached_prod);
 }
 
-static inline void xskq_prod_submit_addr(struct xsk_queue *q, u64 addr)
-{
-	struct xdp_umem_ring *ring = (struct xdp_umem_ring *)q->ring;
-	u32 idx = q->ring->producer;
-
-	ring->desc[idx++ & q->ring_mask] = addr;
-
-	__xskq_prod_submit(q, idx);
-}
-
 static inline void xskq_prod_submit_n(struct xsk_queue *q, u32 nb_entries)
 {
 	__xskq_prod_submit(q, q->ring->producer + nb_entries);
-- 
2.34.1


