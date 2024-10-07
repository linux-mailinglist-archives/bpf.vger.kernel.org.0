Return-Path: <bpf+bounces-41108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA84992BAB
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AD1284F70
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C691D2F72;
	Mon,  7 Oct 2024 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfFGTv7e"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C291D2F48;
	Mon,  7 Oct 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303910; cv=none; b=QMaY+8FjwI+QjepxEH9q32SfU583mbHKXRlsisx+80ZI8P/BP0BiVOSpqkpmwZcdS23DwZDo1Wjs2In0adInTOTBvmgttw3wWp8tfzaEpnbB1cWdevcgqSwomnIQJJAlWDtQIot8GPFOX36B75C65FK9hBJrJcHfJYIzVODxukY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303910; c=relaxed/simple;
	bh=5Zf1Q5qMfX8Y5qhSagKmeAR1/2EBNg9LrUHAC9EC+Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UuLqomTo96BmCpgEct4ewg/l/iEYjYsDkKnZJKS5EEUCuw4fdocV3YjrZGQfTxT0yUWXk/4JnCrRoKD0mht9UV24GGY7ETShRvH8flX/wiKe3IORxK+kJIcsbXuRO1ap6uhVwCs4LuqSvRlSnqSose3OuIAS92wkBKatNZwgQRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfFGTv7e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303908; x=1759839908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Zf1Q5qMfX8Y5qhSagKmeAR1/2EBNg9LrUHAC9EC+Zo=;
  b=UfFGTv7exgvT03VheY+BK2rm6Rnm/C+2llWoz/fFwXQQ+auh6uIaP8l5
   9m6A3EptDQQK0IYfbiKtUEqrhQ9k82pNI25zwBZHHHVvkMLPAzdmGcmov
   9GcN+lClQ+l7zCFan0hjLFialmRqQulFwGI7q6NxEo9dabSEvhFrro3Cz
   WF6vgqn6QIpvAwf5MHFutVlb/55R5nuFw4b0n08m1MiNt3bEwfY+NdBMO
   F7lvqxN7Bupwjb1yIHRDb5bD/Leq0ViVWJYNf0RrtymnW8b3GgL1gUWPn
   eP1XzlbdY1uMFGxoCoj6dAc6bfWSPkka5qIea48tWBADfh/cyvsLN5k9V
   g==;
X-CSE-ConnectionGUID: ENGq5XQGRpCgiw+uGHu2UQ==
X-CSE-MsgGUID: FrZFiVDWQ6a8YIWOjdaaug==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15066336"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15066336"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:25:08 -0700
X-CSE-ConnectionGUID: 14397OHKSwGATwjN/3NTsw==
X-CSE-MsgGUID: MJARXhSOSDKCU2eSIuV9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80250877"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa005.jf.intel.com with ESMTP; 07 Oct 2024 05:25:06 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	vadfed@meta.com
Subject: [PATCH v2 bpf-next 2/6] xsk: s/free_list_node/list_node
Date: Mon,  7 Oct 2024 14:24:54 +0200
Message-Id: <20241007122458.282590-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
References: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that free_list_node's purpose is two-folded, make it just a
'list_node'.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h  | 14 +++++++-------
 include/net/xsk_buff_pool.h |  2 +-
 net/xdp/xsk.c               |  4 ++--
 net/xdp/xsk_buff_pool.c     | 14 +++++++-------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 360bc1244c6a..40085afd9160 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -126,8 +126,8 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 	if (likely(!xdp_buff_has_frags(xdp)))
 		goto out;
 
-	list_for_each_entry_safe(pos, tmp, xskb_list, free_list_node) {
-		list_del(&pos->free_list_node);
+	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
+		list_del(&pos->list_node);
 		xp_free(pos);
 	}
 
@@ -140,7 +140,7 @@ static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
 {
 	struct xdp_buff_xsk *frag = container_of(xdp, struct xdp_buff_xsk, xdp);
 
-	list_add_tail(&frag->free_list_node, &frag->pool->xskb_list);
+	list_add_tail(&frag->list_node, &frag->pool->xskb_list);
 }
 
 static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
@@ -150,9 +150,9 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
 	struct xdp_buff_xsk *frag;
 
 	frag = list_first_entry_or_null(&xskb->pool->xskb_list,
-					struct xdp_buff_xsk, free_list_node);
+					struct xdp_buff_xsk, list_node);
 	if (frag) {
-		list_del(&frag->free_list_node);
+		list_del(&frag->list_node);
 		ret = &frag->xdp;
 	}
 
@@ -163,7 +163,7 @@ static inline void xsk_buff_del_tail(struct xdp_buff *tail)
 {
 	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
 
-	list_del(&xskb->free_list_node);
+	list_del(&xskb->list_node);
 }
 
 static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
@@ -172,7 +172,7 @@ static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
 	struct xdp_buff_xsk *frag;
 
 	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
-			       free_list_node);
+			       list_node);
 	return &frag->xdp;
 }
 
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index aa7f1d0b3a5e..af8b6f776f86 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -29,7 +29,7 @@ struct xdp_buff_xsk {
 	dma_addr_t frame_dma;
 	struct xsk_buff_pool *pool;
 	u64 orig_addr;
-	struct list_head free_list_node;
+	struct list_head list_node;
 };
 
 #define XSK_CHECK_PRIV_TYPE(t) BUILD_BUG_ON(sizeof(t) > offsetofend(struct xdp_buff_xsk, cb))
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 9c93064349a8..520023405908 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -171,14 +171,14 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		return 0;
 
 	xskb_list = &xskb->pool->xskb_list;
-	list_for_each_entry_safe(pos, tmp, xskb_list, free_list_node) {
+	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
 		err = __xsk_rcv_zc(xs, pos, len, contd);
 		if (err)
 			goto err;
-		list_del(&pos->free_list_node);
+		list_del(&pos->list_node);
 	}
 
 	return 0;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index e5368db7d18e..973557d5e4f7 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -101,7 +101,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		xskb = &pool->heads[i];
 		xskb->pool = pool;
 		xskb->xdp.frame_sz = umem->chunk_size - umem->headroom;
-		INIT_LIST_HEAD(&xskb->free_list_node);
+		INIT_LIST_HEAD(&xskb->list_node);
 		if (pool->unaligned)
 			pool->free_heads[i] = xskb;
 		else
@@ -549,8 +549,8 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
 	} else {
 		pool->free_list_cnt--;
 		xskb = list_first_entry(&pool->free_list, struct xdp_buff_xsk,
-					free_list_node);
-		list_del_init(&xskb->free_list_node);
+					list_node);
+		list_del_init(&xskb->list_node);
 	}
 
 	xskb->xdp.data = xskb->xdp.data_hard_start + XDP_PACKET_HEADROOM;
@@ -616,8 +616,8 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
 
 	i = nb_entries;
 	while (i--) {
-		xskb = list_first_entry(&pool->free_list, struct xdp_buff_xsk, free_list_node);
-		list_del_init(&xskb->free_list_node);
+		xskb = list_first_entry(&pool->free_list, struct xdp_buff_xsk, list_node);
+		list_del_init(&xskb->list_node);
 
 		*xdp = &xskb->xdp;
 		xdp++;
@@ -687,11 +687,11 @@ EXPORT_SYMBOL(xp_can_alloc);
 
 void xp_free(struct xdp_buff_xsk *xskb)
 {
-	if (!list_empty(&xskb->free_list_node))
+	if (!list_empty(&xskb->list_node))
 		return;
 
 	xskb->pool->free_list_cnt++;
-	list_add(&xskb->free_list_node, &xskb->pool->free_list);
+	list_add(&xskb->list_node, &xskb->pool->free_list);
 }
 EXPORT_SYMBOL(xp_free);
 
-- 
2.34.1


