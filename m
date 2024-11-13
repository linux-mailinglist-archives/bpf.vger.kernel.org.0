Return-Path: <bpf+bounces-44771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C989C7744
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DE1281F1A
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C238215F72;
	Wed, 13 Nov 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnU+PlTm"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9133F6;
	Wed, 13 Nov 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511567; cv=none; b=A90Tv/VakXVIsnOYaV2fwQbZLld6KGVaP+u50uyLBs3+n3t4DZDpLQU5N1dejgBREMS9bIakElPSHjR++E6528SR9OLVimLKZeLGP+AxxW5snLDjPoHvkvZ3mvcddf91cozk5+2Ca0cR5+VlrVL9XUOvxP72T2vc52qK7FD+HsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511567; c=relaxed/simple;
	bh=9eaTcW1714p0ZpDya9uUHH5o6/Xj9bBorsMBheyZWQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haYqao76WZoNyZPdHWNmfbKEww3gDgrk7KijCI8G5Use9PMxJLTIVnVFG8q4CIGCMWDH22uloOeMjakz/ZduJt4Tdfk90yMgPZ9VeUgWr/9t7Ae8Y1bv2UFjHkTbcKKCCmFmIYVio8wIWhIRdqCgS4cbmg+kxeAPbsdjZRQArJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnU+PlTm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511565; x=1763047565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eaTcW1714p0ZpDya9uUHH5o6/Xj9bBorsMBheyZWQk=;
  b=lnU+PlTm9rw2xim0CpVs4f93OZ23csy6n6c1a26UIaqDsQwRArNrj6uW
   77c8l9tTO4Hi2prJyengz8qGR+d8sV3ii7J6iPvcWIKRns6XzhURbGqSH
   qZjGPwUQxt4w/8pYgkcG3BshvzEfbY1jv3QqTOUpN9HcnnIgmzWkJI93X
   3PMt6afLzvh75Qqpc1aP9b3eReyx2Z/eKRvQFi2ho6Nj5luYy4DaApp9A
   xFLZNdJD9uJDEY3+LVhRbaXpCpWvsvo1EUB1mk4lkUwaANd34iT9CNtj+
   H8ar3xbKMpZv5n2DXtgbiscSgdWX4mGJwDJbG8uvS+T41skM8c4vtMuI0
   Q==;
X-CSE-ConnectionGUID: K4Xz/A1SRNat6m/Xi+BN/w==
X-CSE-MsgGUID: eFxhuC/JRV+c7RRn2sD7ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799448"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799448"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:26:05 -0800
X-CSE-ConnectionGUID: Xl7k8sZ1T+ORL9jYfz3FEw==
X-CSE-MsgGUID: Nq8+4Ls8RViYekWOdsoIkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118727013"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:26:01 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 16/19] xsk: add generic XSk &xdp_buff -> skb conversion
Date: Wed, 13 Nov 2024 16:24:39 +0100
Message-ID: <20241113152442.4000468-17-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same as with converting &xdp_buff to skb on Rx, the code which allocates
a new skb and copies the XSk frame there is identical across the
drivers, so make it generic. This includes copying all the frags if they
are present in the original buff.
System percpu Page Pools help here a lot: when available, allocate pages
from there instead of the MM layer. This greatly improves XDP_PASS
performance on XSk: instead of page_alloc() + page_free(), the net core
recycles the same pages, so the only overhead left is memcpy()s.
Note that the passed buff gets freed if the conversion is done w/o any
error, assuming you don't need this buffer after you convert it to an
skb.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |   1 +
 net/core/xdp.c    | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index b0a25b7060ff..accff7de46d6 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -331,6 +331,7 @@ void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
 struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f046b93faaa0..40c8acde7e3f 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -22,6 +22,8 @@
 #include <trace/events/xdp.h>
 #include <net/xdp_sock_drv.h>
 
+#include "dev.h"
+
 #define REG_STATE_NEW		0x0
 #define REG_STATE_REGISTERED	0x1
 #define REG_STATE_UNREGISTERED	0x2
@@ -682,6 +684,142 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
 
+/**
+ * xdp_copy_frags_from_zc - copy the frags from an XSk buff to an skb
+ * @skb: skb to copy frags to
+ * @xdp: XSk &xdp_buff from which the frags will be copied
+ * @pp: &page_pool backing page allocation, if available
+ *
+ * Copy all frags from an XSk &xdp_buff to an skb to pass it up the stack.
+ * Allocate a new page / page frag for each frag, copy it and attach to
+ * the skb.
+ *
+ * Return: true on success, false on page allocation fail.
+ */
+static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
+					    const struct xdp_buff *xdp,
+					    struct page_pool *pp)
+{
+	const struct skb_shared_info *xinfo;
+	struct skb_shared_info *sinfo;
+	u32 nr_frags, ts;
+
+	xinfo = xdp_get_shared_info_from_buff(xdp);
+	nr_frags = xinfo->nr_frags;
+	sinfo = skb_shinfo(skb);
+
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	ts = 0;
+#else
+	ts = xinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
+#endif
+
+	for (u32 i = 0; i < nr_frags; i++) {
+		u32 len = skb_frag_size(&xinfo->frags[i]);
+		void *data;
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+		u32 truesize = len;
+
+		data = page_pool_dev_alloc_va(pp, &truesize);
+		ts += truesize;
+#else
+		data = napi_alloc_frag(len);
+#endif
+		if (unlikely(!data))
+			return false;
+
+		memcpy(data, skb_frag_address(&xinfo->frags[i]),
+		       LARGEST_ALIGN(len));
+		__skb_fill_page_desc(skb, sinfo->nr_frags++,
+				     virt_to_page(data),
+				     offset_in_page(data), len);
+	}
+
+	xdp_update_skb_shared_info(skb, nr_frags, xinfo->xdp_frags_size,
+				   ts, false);
+
+	return true;
+}
+
+/**
+ * xdp_build_skb_from_zc - create an skb from an XSk &xdp_buff
+ * @xdp: source XSk buff
+ *
+ * Similar to xdp_build_skb_from_buff(), but for XSk frames. Allocate an skb
+ * head, new page for the head, copy the data and initialize the skb fields.
+ * If there are frags, allocate new pages for them and copy.
+ * If Page Pool is available, the function allocates memory from the system
+ * percpu pools to try recycling the pages, otherwise it uses the NAPI page
+ * frag caches.
+ * If new skb was built successfully, @xdp is returned to XSk pool's freelist.
+ * On error, it remains untouched and the caller must take care of this.
+ *
+ * Return: new &sk_buff on success, %NULL on error.
+ */
+struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
+{
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	u32 len = xdp->data_end - xdp->data_meta;
+	struct page_pool *pp;
+	struct sk_buff *skb;
+	int metalen;
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	u32 truesize;
+	void *data;
+
+	pp = this_cpu_read(system_page_pool);
+	truesize = xdp->frame_sz;
+
+	data = page_pool_dev_alloc_va(pp, &truesize);
+	if (unlikely(!data))
+		return NULL;
+
+	skb = napi_build_skb(data, truesize);
+	if (unlikely(!skb)) {
+		page_pool_free_va(pp, data, true);
+		return NULL;
+	}
+
+	skb_mark_for_recycle(skb);
+	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
+#else /* !CONFIG_PAGE_POOL */
+	struct napi_struct *napi;
+
+	pp = NULL;
+	napi = napi_by_id(rxq->napi_id);
+	if (likely(napi))
+		skb = napi_alloc_skb(napi, len);
+	else
+		skb = __netdev_alloc_skb_ip_align(rxq->dev, len,
+						  GFP_ATOMIC | __GFP_NOWARN);
+	if (unlikely(!skb))
+		return NULL;
+#endif /* !CONFIG_PAGE_POOL */
+
+	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
+
+	metalen = xdp->data - xdp->data_meta;
+	if (metalen > 0) {
+		skb_metadata_set(skb, metalen);
+		__skb_pull(skb, metalen);
+	}
+
+	skb_record_rx_queue(skb, rxq->queue_index);
+
+	if (unlikely(xdp_buff_has_frags(xdp)) &&
+	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
+		napi_consume_skb(skb, true);
+		return NULL;
+	}
+
+	xsk_buff_free(xdp);
+
+	skb->protocol = eth_type_trans(skb, rxq->dev);
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
+
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
-- 
2.47.0


