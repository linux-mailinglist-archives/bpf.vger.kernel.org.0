Return-Path: <bpf+bounces-41107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77623992BA6
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FA61C22F64
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72521D2B35;
	Mon,  7 Oct 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Svf4OJ7H"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722E1D279B;
	Mon,  7 Oct 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303907; cv=none; b=e23z7Ja7dwW5ec8SIyMCnfhM999e/n0w80p2veML6LVSVFmriidMUhFXBHSlinqRkLM+Mnshb4DsevuEQykxgYihclafs5bCA2+pOrx+ayBaMa/g10LEBeYiuHmIAPMVHGI0lCuTb51uH3Dj5cVyXuEdRZh0UasKjBquXn0fL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303907; c=relaxed/simple;
	bh=BhsGaH2BzRzfXaoCiDbov/l7oJfV/m+tDw1BtszQDUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RIEPrWGz1SyyZsZmAMyYkxXwcOOZjzP4v7ofsZ1ZJ8lUTOxcTgQTHBtB7RKyGqxa35RjHsFqMKQujI+tG40MsLlU/XFRDUBY3o69yiGqQV+b10nohc8qR9vFaO2goJvdUDSRcutBCyQLhiA9+1CTOBxIh7yXD7rt/5hc7s//xFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Svf4OJ7H; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303905; x=1759839905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BhsGaH2BzRzfXaoCiDbov/l7oJfV/m+tDw1BtszQDUc=;
  b=Svf4OJ7HAkDAP74QYzgYdel8zZ+QCPHm+AOrzYLWIs7kMDhThWOs3nXn
   9xpT1nia/hfeBBBBKytg/d2OvAXM4IrkYkZhvdMmAENCPbwA8SgVc1M5m
   kC83b3esM5FJrQRJ0pnmSLmot4rH1o3a3D6VYCAh6kgvk6WoNCJv5pk5E
   qBE/FlmWkIzyKKS75fBHZaEXK9ee581tROjbqty1nmSy/JJkAEAG/MYig
   88gk2wbKOPDakP1RxUdCOopfQAzTsMXNVTgjD2LBQ3TEz2dybqv8p0f7z
   29cSg6cKcmK1mtfvbFzID4E5prT94fQHulJs1XWPE/etovyzQpcIeiEE3
   w==;
X-CSE-ConnectionGUID: 30KqeQ1KTbG3M9SkoGA7Ww==
X-CSE-MsgGUID: Qu7Z1VUzTu+W4mhrrjSfgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15066330"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15066330"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:25:05 -0700
X-CSE-ConnectionGUID: rJAgGhlpTgGSKvF9NcH98Q==
X-CSE-MsgGUID: QayY8+jBSRW3hD/LM2iVWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80250841"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa005.jf.intel.com with ESMTP; 07 Oct 2024 05:25:04 -0700
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
Subject: [PATCH v2 bpf-next 1/6] xsk: get rid of xdp_buff_xsk::xskb_list_node
Date: Mon,  7 Oct 2024 14:24:53 +0200
Message-Id: <20241007122458.282590-2-maciej.fijalkowski@intel.com>
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

Let's bring xdp_buff_xsk back to occupying 2 cachelines by removing
xskb_list_node - for the purpose of gathering the xskb frags
free_list_node can be used, head of the list (xsk_buff_pool::xskb_list)
stays as-is, just reuse the node ptr.

It is safe to do as a single xdp_buff_xsk can never reside in two
pool's lists simultaneously.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 include/net/xdp_sock_drv.h  | 14 +++++++-------
 include/net/xsk_buff_pool.h |  1 -
 net/xdp/xsk.c               |  4 ++--
 net/xdp/xsk_buff_pool.c     |  1 -
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 0a5dca2b2b3f..360bc1244c6a 100644
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
 
@@ -163,7 +163,7 @@ static inline void xsk_buff_del_tail(struct xdp_buff *tail)
 {
 	struct xdp_buff_xsk *xskb = container_of(tail, struct xdp_buff_xsk, xdp);
 
-	list_del(&xskb->xskb_list_node);
+	list_del(&xskb->free_list_node);
 }
 
 static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
@@ -172,7 +172,7 @@ static inline struct xdp_buff *xsk_buff_get_tail(struct xdp_buff *first)
 	struct xdp_buff_xsk *frag;
 
 	frag = list_last_entry(&xskb->pool->xskb_list, struct xdp_buff_xsk,
-			       xskb_list_node);
+			       free_list_node);
 	return &frag->xdp;
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


