Return-Path: <bpf+bounces-42056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979CF99F06F
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 17:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA21F25BE1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA501F76C2;
	Tue, 15 Oct 2024 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOHbwFgf"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B861F76A3;
	Tue, 15 Oct 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004117; cv=none; b=q6yON6Nx0qEWhN3U7vlJea8V+Jw4HEzkYWEn8gZN42+yJikl57ZdDQBLPRqX371Ep7fTYc1+TvnBER+J7Esl6f6ENDtZ2JUnXMnKWQmy6npylPUKU2vpzmpvwUQqffyzn9vwJsrTMSHKSRxB9n5uW5CafiS1yyuW2IuDXQeO1fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004117; c=relaxed/simple;
	bh=BorV1Brv0my44N5PQ+B8MmLZhQivYvRrdWmcvwcHk7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR2okRd2b7FI8VBeka9wSZ/xyHcWO2YlEirZkRgMqgFRSh6dxV96anu5mlXIH6iuKok4aSZZ4JRsgceXE1WB8tL4YKzJ8sIIr55vq2DxQRmFduYE7PqjSkFUmby5rT0xGhii0xhv37nBDq8yStjZgy1TuSpFgzIpnmOpGbQxOgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOHbwFgf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004116; x=1760540116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BorV1Brv0my44N5PQ+B8MmLZhQivYvRrdWmcvwcHk7k=;
  b=QOHbwFgfF0ZNsgtfu6qXU52jwPLg07Kb25+zT/3Q/7/D38f9j1ENfv6W
   uLLqhWD6+uKcyR+bCGbfhk5rNyNPjX59ZQVLXaHDHsoFcxA5fAArU8m/u
   yIZL6Y/dtk0Jf5Is1y9Boq+MUFwmSoBg3guCvVJXU9flNRUu3TFOzHLp0
   iSWsbXK+aAE3l2ElzAuADMxt103stD9qSwiqMZfCnl9q8OHlZ/HWrHFPB
   QITL/Bwd+pzY3OeC5qbev87ykliw/WSimL+3x0AW14q3DLR6VgNFSWsVl
   MWY9aczFjqHfIzlZxUIdOWBLlWhqfs0pCGlS+dXxhSNHton5yXP34O4+u
   w==;
X-CSE-ConnectionGUID: YefBOIAMScGIe9/kyHAhNQ==
X-CSE-MsgGUID: BJ/ZUgGyQ9evuwATSHIang==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277675"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277675"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:55:16 -0700
X-CSE-ConnectionGUID: 1SbrzFkWRlS06lLwPiVoDA==
X-CSE-MsgGUID: BExLO5LbRMSRqJPhaVDrPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723156"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:55:12 -0700
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 15/18] xsk: add generic XSk &xdp_buff -> skb conversion
Date: Tue, 15 Oct 2024 16:53:47 +0200
Message-ID: <20241015145350.4077765-16-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
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

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |   1 +
 net/core/xdp.c    | 138 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 83e3f4648caa..69728b2d75d5 100644
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
index 371c26c203b2..116153b88d26 100644
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
2.46.2


