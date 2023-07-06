Return-Path: <bpf+bounces-4316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0B174A540
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D251C20E4F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 20:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C2C171D4;
	Thu,  6 Jul 2023 20:47:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14053171C8;
	Thu,  6 Jul 2023 20:47:52 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB861992;
	Thu,  6 Jul 2023 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688676470; x=1720212470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FC7vck7L+k5J7iXeW3sOff04Enx9sRy7w+AaEUy8HMk=;
  b=Gpqho5If8Ft+tGuNzfp+ab4kC3afi9d8V9ZKmPwlmD6YN+lNEmDS6/bw
   EfY87DubyALAXtl9NWR3arqudHdhs82I3sG6lJLtY+mzDgo+BioeZOkmO
   CWOdDuH1RhAFTTjOxEfOB3pFmFvQ6HrTJ6a4erW0pw/ZU6EzuAtREjYbw
   RJbTEteIN75rZmT5rgQX4jDDnIiGFR/bnvKsbxxDb3pVioKMIdhMp55VT
   ZtP22oBA7F2m1UDjVl4NsKs06YgK2uPsKs69IKyzsMxe1Rp3OEzP6KBVQ
   fUQ9vrXBSWKKFMXDEbLLonZdfWZ13F2ZilHNjG1MCmMmFponI2XcvE1MZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361195421"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="361195421"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 13:47:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="785059583"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="785059583"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 13:47:47 -0700
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
Subject: [PATCH v5 bpf-next 11/24] xsk: support mbuf on ZC RX
Date: Thu,  6 Jul 2023 22:46:37 +0200
Message-Id: <20230706204650.469087-12-maciej.fijalkowski@intel.com>
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

Given that skb_shared_info relies on skb_frag_t, in order to support
xskb chaining, introduce xdp_buff_xsk::xskb_list_node and
xsk_buff_pool::xskb_list.

This is needed so ZC drivers can add frags as xskb nodes which will make
it possible to handle it both when producing AF_XDP Rx descriptors as
well as freeing/recycling all the frags that a single frame carries.

Speaking of latter, update xsk_buff_free() to take care of list nodes.
For the former (adding as frags), introduce xsk_buff_add_frag() for ZC
drivers usage that is going to be used to add a frag to xskb list from
pool.

xsk_buff_get_frag() will be utilized by XDP_TX and, on contrary, will
return xdp_buff.

One of the previous patches added a wrapper for ZC Rx so implement xskb
list walk and production of Rx descriptors there.

On bind() path, bail out if socket wants to use ZC multi-buffer but
underlying netdev does not support it.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h  | 44 +++++++++++++++++++++++++++++++++++++
 include/net/xsk_buff_pool.h |  2 ++
 net/xdp/xsk.c               | 26 +++++++++++++++++++++-
 net/xdp/xsk_buff_pool.c     |  7 ++++++
 4 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 0d34cdb5567d..1f6fc8c7a84c 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -108,10 +108,45 @@ static inline bool xsk_buff_can_alloc(struct xsk_buff_pool *pool, u32 count)
 static inline void xsk_buff_free(struct xdp_buff *xdp)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
+	struct list_head *xskb_list = &xskb->pool->xskb_list;
+	struct xdp_buff_xsk *pos, *tmp;
 
+	if (likely(!xdp_buff_has_frags(xdp)))
+		goto out;
+
+	list_for_each_entry_safe(pos, tmp, xskb_list, xskb_list_node) {
+		list_del(&pos->xskb_list_node);
+		xp_free(pos);
+	}
+
+	xdp_get_shared_info_from_buff(xdp)->nr_frags = 0;
+out:
 	xp_free(xskb);
 }
 
+static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
+{
+	struct xdp_buff_xsk *frag = container_of(xdp, struct xdp_buff_xsk, xdp);
+
+	list_add_tail(&frag->xskb_list_node, &frag->pool->xskb_list);
+}
+
+static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
+{
+	struct xdp_buff_xsk *xskb = container_of(first, struct xdp_buff_xsk, xdp);
+	struct xdp_buff *ret = NULL;
+	struct xdp_buff_xsk *frag;
+
+	frag = list_first_entry_or_null(&xskb->pool->xskb_list,
+					struct xdp_buff_xsk, xskb_list_node);
+	if (frag) {
+		list_del(&frag->xskb_list_node);
+		ret = &frag->xdp;
+	}
+
+	return ret;
+}
+
 static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 {
 	xdp->data = xdp->data_hard_start + XDP_PACKET_HEADROOM;
@@ -265,6 +300,15 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 {
 }
 
+static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
+{
+}
+
+static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
+{
+	return NULL;
+}
+
 static inline void xsk_buff_set_size(struct xdp_buff *xdp, u32 size)
 {
 }
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 4dcca163e076..b0bdff26fc88 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -29,6 +29,7 @@ struct xdp_buff_xsk {
 	struct xsk_buff_pool *pool;
 	u64 orig_addr;
 	struct list_head free_list_node;
+	struct list_head xskb_list_node;
 };
 
 #define XSK_CHECK_PRIV_TYPE(t) BUILD_BUG_ON(sizeof(t) > offsetofend(struct xdp_buff_xsk, cb))
@@ -54,6 +55,7 @@ struct xsk_buff_pool {
 	struct xdp_umem *umem;
 	struct work_struct work;
 	struct list_head free_list;
+	struct list_head xskb_list;
 	u32 heads_cnt;
 	u16 queue_id;
 
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index e761e16cc3b4..18daaf30ee3d 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -155,8 +155,32 @@ static int __xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff_xsk *xskb, u32 len,
 static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
+	u32 frags = xdp_buff_has_frags(xdp);
+	struct xdp_buff_xsk *pos, *tmp;
+	struct list_head *xskb_list;
+	u32 contd = 0;
+	int err;
+
+	if (frags)
+		contd = XDP_PKT_CONTD;
 
-	return __xsk_rcv_zc(xs, xskb, len, 0);
+	err = __xsk_rcv_zc(xs, xskb, len, contd);
+	if (err || likely(!frags))
+		goto out;
+
+	xskb_list = &xskb->pool->xskb_list;
+	list_for_each_entry_safe(pos, tmp, xskb_list, xskb_list_node) {
+		if (list_is_singular(xskb_list))
+			contd = 0;
+		len = pos->xdp.data_end - pos->xdp.data;
+		err = __xsk_rcv_zc(xs, pos, len, contd);
+		if (err)
+			return err;
+		list_del(&pos->xskb_list_node);
+	}
+
+out:
+	return err;
 }
 
 static void *xsk_copy_xdp_start(struct xdp_buff *from)
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 26f6d304451e..b3f7b310811e 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -86,6 +86,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 	pool->umem = umem;
 	pool->addrs = umem->addrs;
 	INIT_LIST_HEAD(&pool->free_list);
+	INIT_LIST_HEAD(&pool->xskb_list);
 	INIT_LIST_HEAD(&pool->xsk_tx_list);
 	spin_lock_init(&pool->xsk_tx_list_lock);
 	spin_lock_init(&pool->cq_lock);
@@ -99,6 +100,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		xskb->pool = pool;
 		xskb->xdp.frame_sz = umem->chunk_size - umem->headroom;
 		INIT_LIST_HEAD(&xskb->free_list_node);
+		INIT_LIST_HEAD(&xskb->xskb_list_node);
 		if (pool->unaligned)
 			pool->free_heads[i] = xskb;
 		else
@@ -187,6 +189,11 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 		goto err_unreg_pool;
 	}
 
+	if (netdev->xdp_zc_max_segs == 1 && (flags & XDP_USE_SG)) {
+		err = -EOPNOTSUPP;
+		goto err_unreg_pool;
+	}
+
 	bpf.command = XDP_SETUP_XSK_POOL;
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
-- 
2.34.1


