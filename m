Return-Path: <bpf+bounces-46655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1209ED39B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FEA188C0E2
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82661FF61A;
	Wed, 11 Dec 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXKxvFjR"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCD1FECDB;
	Wed, 11 Dec 2024 17:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938163; cv=none; b=nNjx71mrsIEXWygccqav6cRhrEd5gNL4gi8aE31Y0qz5zGD7yWxOlmCybpsrUhYimcGAD4B8JaKqMX2phTwxlRrnWz7euw3EyU5b2H9+SbJDviPDc/A1XinIHqvAurYg3rRBkk0Uxhr5/PgpmFbUBwNWyIlkneo0WgT4+dIlDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938163; c=relaxed/simple;
	bh=U7GC0Mobi6oqTnzo3KZq64LBwVtU2r6C3y5WZwOf2Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBr7XmX6gBzBJGQn4qrrrYzxqWa+3gqW7kN35EbsA4oE+g1F2DUi5OQkwXhhHPvZtJFKzipe0tKV2RVnevdbcvbos9hH8VTMPQuVojLxsWb3wX53JQuZ31+NdExQmtJYqXbXVZHCEWo78HdBZlM8tRR9qZQxmiOOS8SGEj+eESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXKxvFjR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938162; x=1765474162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7GC0Mobi6oqTnzo3KZq64LBwVtU2r6C3y5WZwOf2Us=;
  b=LXKxvFjRZL3hGn0X+s9WBoOuDfJ4229WNObDgDSQ+abTVILv/pbC9r2c
   /ST2Cd5SO7vxgjemYr85gGxoUyPR9CKYJjXXB9eY7zRvTsmMSFxUCvjCH
   dcRx4dGEVXW+EWPLRnUMeQr+xewoQgYYAlwTDDPznO3jfw5Zelv071Tsv
   mO1zBgqROs1rljEr4wf1fdlYwglgsgvAGyaCsEFhgrkc0N0GXRGhNhYME
   9/SyRbsXSOrpcja3siGac6zvkMgd25EfklIeN4rebJTe6PaaqwCpaNU2N
   7nKD1VTH6S4gR/XAdk6nMTHt+Byg0BlsNoolpiIzcxyQw/B3kcKstBHf5
   A==;
X-CSE-ConnectionGUID: eYS0mebsTlWaB+SkQCbAaA==
X-CSE-MsgGUID: d4onestlQ6SO1D6Z7RSEeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859597"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859597"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:29:11 -0800
X-CSE-ConnectionGUID: XPc9JSjHScSBioVy/Ke5mA==
X-CSE-MsgGUID: GYEeKn08TFeEi3hEgS5ckQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122304"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:29:06 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 07/12] xsk: add generic XSk &xdp_buff -> skb conversion
Date: Wed, 11 Dec 2024 18:26:44 +0100
Message-ID: <20241211172649.761483-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211172649.761483-1-aleksander.lobakin@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
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
index aa24fa78cbe6..6da0e746cf75 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -337,6 +337,7 @@ void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
 struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
+struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index c4d824cf27da..6e319e00ae78 100644
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
@@ -684,6 +686,142 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
 
+/**
+ * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
+ * @skb: skb to copy frags to
+ * @xdp: XSk &xdp_buff from which the frags will be copied
+ * @pp: &page_pool backing page allocation, if available
+ *
+ * Copy all frags from XSk &xdp_buff to the skb to pass it up the stack.
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
+		__skb_fill_netmem_desc(skb, sinfo->nr_frags++,
+				       virt_to_netmem(data),
+				       offset_in_page(data), len);
+	}
+
+	xdp_update_skb_shared_info(skb, nr_frags, xinfo->xdp_frags_size,
+				   ts, false);
+
+	return true;
+}
+
+/**
+ * xdp_build_skb_from_zc - create an skb from XSk &xdp_buff
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
2.47.1


