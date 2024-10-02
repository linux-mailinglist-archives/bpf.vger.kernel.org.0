Return-Path: <bpf+bounces-40766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4E98E015
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC899B2CB5A
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB321D0DF7;
	Wed,  2 Oct 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsDOOv8h"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828901D0BAD;
	Wed,  2 Oct 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884489; cv=none; b=t2zHTdrbIb+zf/RKzj/JWvKjG0qhyZuWa+ys/dlBV4nOTVWzvrSKZqwlKbT2ilyGiQ/iJNgQBHECbJyBdAoPyymjgB6cYm6QKuoUg+U66vwD/huBOamZ3EdWmYUr3Q7YHBFo0s52cjS1VI2tQFWSExGEfNQipZoWnG8NPESxeVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884489; c=relaxed/simple;
	bh=obBhSU2HYXyWhL21yT3Ru6aHpPMWza8+J5dvEGvJgAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GzlA+9nawDQQo7DL6euIIuZqPoqrskf2QZF0tpLxtqLjRfpU/C7yW3Uv0jD0++FIzPKAQwKL42FROIMHcawCAa3tpFgoMk1DLrLjdGClH+qp2mx40Etv70OfqcCAAKBWvJ7b8ZM8FaOGuz4YJTP7ztVx4+YYfCx+IbM8IiTxlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsDOOv8h; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727884488; x=1759420488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obBhSU2HYXyWhL21yT3Ru6aHpPMWza8+J5dvEGvJgAE=;
  b=dsDOOv8hwWZOiQblXHkpTdCf9dSunkvbMDNNvwnZjzMY/6ucYznJN9of
   SQhnbLfbWZlUsGk346tPWC/B6UL8su7/ld+NFeZkO1InTrE4D79L/aFFG
   Ap/fawHk73hKWQ5UwJTfylonJHS91reX1anATDVCxGGf8CwxFVarcDqD7
   UAvT8gKHeJ0jRr+AIKV+8URJ8AsEeZPg3lgcWWcE+JTLnt3d/8aA8zgWg
   17MgFBtLqWWbVTUASCufdP7YeW5EkPRxtcGMo1mn9oEeShs+6v6LTi8UA
   IyBm9fOPQYA56PywoDQuEMA6XR8TShTConIqt0JUWDd4NIRy6zTRLHJAd
   A==;
X-CSE-ConnectionGUID: JjDABtAuSsaQrzeTCTcbTQ==
X-CSE-MsgGUID: DOVxEi86SHKc2AoYvlAhRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30762952"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30762952"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:54:48 -0700
X-CSE-ConnectionGUID: VIw7IIAGT2yU/ABi1TPEjQ==
X-CSE-MsgGUID: yWagtZVoSkyWNlv7E3qu+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73628732"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2024 08:54:45 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next 1/6] xsk: get rid of xdp_buff_xsk::xskb_list_node
Date: Wed,  2 Oct 2024 17:54:36 +0200
Message-Id: <20241002155441.253956-2-maciej.fijalkowski@intel.com>
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

Let's bring xdp_buff_xsk back to occupying 2 cachelines by removing
xskb_list_node - for the purpose of gathering the xskb frags
free_list_node can be used, head of the list (xsk_buff_pool::xskb_list)
stays as-is, just reuse the node ptr.

It is safe to do as a single xdp_buff_xsk can never reside in two
pool's lists simultaneously.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h  | 10 +++++-----
 include/net/xsk_buff_pool.h |  1 -
 net/xdp/xsk.c               |  4 ++--
 net/xdp/xsk_buff_pool.c     |  1 -
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 0a5dca2b2b3f..c897fedf259b 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -126,8 +126,8 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 	if (likely(!xdp_buff_has_frags(xdp)))
 		goto out;
 
-	list_for_each_entry_safe(pos, tmp, xskb_list, xskb_list_node) {
-		list_del(&pos->xskb_list_node);
+	list_for_each_entry_safe(pos, tmp, xskb_list, free_list_node) {
+		list_del(&pos->free_list_node);
 		xp_free(pos);
 	}
 
@@ -140,7 +140,7 @@ static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
 {
 	struct xdp_buff_xsk *frag = container_of(xdp, struct xdp_buff_xsk, xdp);
 
-	list_add_tail(&frag->xskb_list_node, &frag->pool->xskb_list);
+	list_add_tail(&frag->free_list_node, &frag->pool->xskb_list);
 }
 
 static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
@@ -150,9 +150,9 @@ static inline struct xdp_buff *xsk_buff_get_frag(struct xdp_buff *first)
 	struct xdp_buff_xsk *frag;
 
 	frag = list_first_entry_or_null(&xskb->pool->xskb_list,
-					struct xdp_buff_xsk, xskb_list_node);
+					struct xdp_buff_xsk, free_list_node);
 	if (frag) {
-		list_del(&frag->xskb_list_node);
+		list_del(&frag->free_list_node);
 		ret = &frag->xdp;
 	}
 
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index bacb33f1e3e5..aa7f1d0b3a5e 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -30,7 +30,6 @@ struct xdp_buff_xsk {
 	struct xsk_buff_pool *pool;
 	u64 orig_addr;
 	struct list_head free_list_node;
-	struct list_head xskb_list_node;
 };
 
 #define XSK_CHECK_PRIV_TYPE(t) BUILD_BUG_ON(sizeof(t) > offsetofend(struct xdp_buff_xsk, cb))
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1140b2a120ca..9c93064349a8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -171,14 +171,14 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
 		return 0;
 
 	xskb_list = &xskb->pool->xskb_list;
-	list_for_each_entry_safe(pos, tmp, xskb_list, xskb_list_node) {
+	list_for_each_entry_safe(pos, tmp, xskb_list, free_list_node) {
 		if (list_is_singular(xskb_list))
 			contd = 0;
 		len = pos->xdp.data_end - pos->xdp.data;
 		err = __xsk_rcv_zc(xs, pos, len, contd);
 		if (err)
 			goto err;
-		list_del(&pos->xskb_list_node);
+		list_del(&pos->free_list_node);
 	}
 
 	return 0;
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 521a2938e50a..e5368db7d18e 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -102,7 +102,6 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		xskb->pool = pool;
 		xskb->xdp.frame_sz = umem->chunk_size - umem->headroom;
 		INIT_LIST_HEAD(&xskb->free_list_node);
-		INIT_LIST_HEAD(&xskb->xskb_list_node);
 		if (pool->unaligned)
 			pool->free_heads[i] = xskb;
 		else
-- 
2.34.1


