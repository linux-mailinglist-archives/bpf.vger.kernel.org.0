Return-Path: <bpf+bounces-40767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196898DFDF
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A99D1C23839
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938611D0F64;
	Wed,  2 Oct 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0TIGicL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF52F44;
	Wed,  2 Oct 2024 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884495; cv=none; b=V1ALDLxwSRRN3j6Md7dngqyAFZnvV3SDMNtykX1oGR/xIki4Mnvrp0dv7U1aWm+HlKhI/KwVatWgeuGk806aDjCIDbj50t8JweXarLq8FYmfEG/Uds6a1VylkmoJ8sFl/0kIfK17P9pce3tjyrS/rFu2iZfs73SGhjrql76nBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884495; c=relaxed/simple;
	bh=M0eFzAbeu05wcZyMhDWnHB+XrSuD2ZqGD2u/pgG8+Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0dCP5llq5WHsy8zTavGYcVrWCYyPsrYCSRqnHsBpk10yzXZ33IzHQeFjcttrOPZ/2rQGwcILWsx3EmYeseyZ1hl2RS2mRIXrf0no9k2Pe7+iw8BmeKqQnboTM2kotPX+FnrecWXp3qJ473uCYw16n0To8L/gwR28sFRWX46Hvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0TIGicL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727884494; x=1759420494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0eFzAbeu05wcZyMhDWnHB+XrSuD2ZqGD2u/pgG8+Zs=;
  b=e0TIGicLxV6hEco9t/BQlFMGTCVOM6hhW6r0O43sbTRrLQ2xVIXlt3Y0
   wNVm0BVCyNBLBc7K+u18SNo7YgIQGLFN9v8Al2mL3A5N8W1i03PRB9Dqy
   KBQpmAn6mPeVzwD2kzV6lPjwIh6FGgjSME/0NQ6UR4GKIWAPfFmjUZLES
   xvPciQo2SSR3ZSEiRTFX+BmNmzSLN8dFsAwOoImTQzdbZYbZvkS7T+GdG
   HcCfUYCfPfmeGMZKNyh1scmBCwl63cE6HN5nJ78x0Tej3lSEWnNu+pe1W
   zzcqAa9JqSBBgjqY8v8koEB0YzMWrdHE3pGg3jAmAyhHrpe3xibBfVI4y
   A==;
X-CSE-ConnectionGUID: 6QTQvpD1Qz6bUBogWdiQOA==
X-CSE-MsgGUID: 5huInzpqQ3aMwDlF/QVpEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30762959"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30762959"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:54:50 -0700
X-CSE-ConnectionGUID: PlNfA9XESqWKYicmAW3b3w==
X-CSE-MsgGUID: FTaPft2PR8WGQgD5XPF1tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73628750"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2024 08:54:47 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next 2/6] xsk: s/free_list_node/list_node
Date: Wed,  2 Oct 2024 17:54:37 +0200
Message-Id: <20241002155441.253956-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
References: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
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
index c897fedf259b..40085afd9160 100644
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
 
-	list_del(&xskb->xskb_list_node);
+	list_del(&xskb->list_node);
 }
 
 static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
@@ -172,7 +172,7 @@ static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
 	struct xdp_buff_xsk *frag;
 
 	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
-			       xskb_list_node);
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


