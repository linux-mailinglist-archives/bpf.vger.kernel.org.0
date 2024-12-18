Return-Path: <bpf+bounces-47265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055139F6C99
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605DC1894F6F
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BF81FCFF9;
	Wed, 18 Dec 2024 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJ64FSSg"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8D1FCFDF;
	Wed, 18 Dec 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543945; cv=none; b=uTacMzF8fAmrfM1nUrqssFpb4XN5Mq86hqDA75dGinvliojZ8t/tctd8RhqvLUAkoFyKNX9ZsyNm6PzjcHV42B5m+qC8+8H5/NEzaVUl7X2W84WHhFAvh37ROYIb5lJUAYZnD2JTaJEL0UQry+JnXjCwPSg8ziYakvhGjQLN/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543945; c=relaxed/simple;
	bh=UtjIF/wbgjshAf2TwNr1ultKmXzydmXIKsXndRJgA6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsXA0e4p5zq+1VVfha/EbvhaJbOOVa/tphoZHfzl5nDyndTeGmdsOdWh0ls5Jb5SH4IGKvyKz5qnsTFHh9YvBXbTLfSuOpvW48E0KRM81AALmHItQYmIeM+PK2AMh8csGHdAFYrxg16YtknjGpxTnqJnYFBoUJFDOV2VZ5oHnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJ64FSSg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734543944; x=1766079944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UtjIF/wbgjshAf2TwNr1ultKmXzydmXIKsXndRJgA6E=;
  b=EJ64FSSg5FGMR1tV2rNG46gjB5zsJA146ds4cdNP+aj47UJeY0ARpNzs
   B/BGPYAaE5dh4RLMXYrqFsh+HdvmvKiBlR3lfPqMuSknePuj7xvgYrknT
   mhLRBPxc7d5UmzjRo4Yexyvb5rEcu7Hani2+d6usw+Y9u76s0zFvO/Oxf
   m/dlgAivuEugpz5r2+LAGH9KzBcrZwPm4jJwszNlkudg6R/m+8pOatkWl
   QYUlJxFF9SFAXDsIpVenXVNNeY+fS7N3cB/aQTP60FB4LrrZIhvaNnnkC
   dK+kifEwf0b+wRzzRlOMSJZ8QG1l5/fIuqb3uYnWygdDfmHd7esbQvjYr
   g==;
X-CSE-ConnectionGUID: etUz3dfIQKmgwNY7Sd5dcQ==
X-CSE-MsgGUID: Lg1akL4OTZi2PIPIbJnpjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22621014"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="22621014"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:45:43 -0800
X-CSE-ConnectionGUID: HsMGSaDiTv2VWeV9mGVZdQ==
X-CSE-MsgGUID: tuy+IzwrRIWvtdQI2Q/IqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121192319"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 18 Dec 2024 09:45:39 -0800
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
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] xsk: add generic XSk &xdp_buff -> skb conversion
Date: Wed, 18 Dec 2024 18:44:33 +0100
Message-ID: <20241218174435.1445282-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
References: <20241218174435.1445282-1-aleksander.lobakin@intel.com>
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
System percpu page_pools greatly improve XDP_PASS performance on XSk:
instead of page_alloc() + page_free(), the net core recycles the same
pages, so the only overhead left is memcpy()s. When the Page Pool is
not compiled in, the whole function is a return-NULL (but it always
gets selected when eBPF is enabled).
Note that the passed buff gets freed if the conversion is done w/o any
error, assuming you don't need this buffer after you convert it to an
skb.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |   1 +
 net/core/xdp.c    | 112 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

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
index 704203a15a18..67b53fc7191e 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -684,6 +684,118 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
 
+/**
+ * xdp_copy_frags_from_zc - copy frags from XSk buff to skb
+ * @skb: skb to copy frags to
+ * @xdp: XSk &xdp_buff from which the frags will be copied
+ * @pp: &page_pool backing page allocation, if available
+ *
+ * Copy all frags from XSk &xdp_buff to the skb to pass it up the stack.
+ * Allocate a new buffer for each frag, copy it and attach to the skb.
+ *
+ * Return: true on success, false on netmem allocation fail.
+ */
+static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
+					    const struct xdp_buff *xdp,
+					    struct page_pool *pp)
+{
+	struct skb_shared_info *sinfo = skb_shinfo(skb);
+	const struct skb_shared_info *xinfo;
+	u32 nr_frags, tsize = 0;
+	bool pfmemalloc = false;
+
+	xinfo = xdp_get_shared_info_from_buff(xdp);
+	nr_frags = xinfo->nr_frags;
+
+	for (u32 i = 0; i < nr_frags; i++) {
+		u32 len = skb_frag_size(&xinfo->frags[i]);
+		u32 offset, truesize = len;
+		netmem_ref netmem;
+
+		netmem = page_pool_dev_alloc_netmem(pp, &offset, &truesize);
+		if (unlikely(!netmem)) {
+			sinfo->nr_frags = i;
+			return false;
+		}
+
+		memcpy(__netmem_address(netmem),
+		       __netmem_address(xinfo->frags[i].netmem),
+		       LARGEST_ALIGN(len));
+		__skb_fill_netmem_desc_noacc(sinfo, i, netmem, offset, len);
+
+		tsize += truesize;
+		pfmemalloc |= netmem_is_pfmemalloc(netmem);
+	}
+
+	xdp_update_skb_shared_info(skb, nr_frags, xinfo->xdp_frags_size,
+				   tsize, pfmemalloc);
+
+	return true;
+}
+
+/**
+ * xdp_build_skb_from_zc - create an skb from XSk &xdp_buff
+ * @xdp: source XSk buff
+ *
+ * Similar to xdp_build_skb_from_buff(), but for XSk frames. Allocate an skb
+ * head, new buffer for the head, copy the data and initialize the skb fields.
+ * If there are frags, allocate new buffers for them and copy.
+ * Buffers are allocated from the system percpu pools to try recycling them.
+ * If new skb was built successfully, @xdp is returned to XSk pool's freelist.
+ * On error, it remains untouched and the caller must take care of this.
+ *
+ * Return: new &sk_buff on success, %NULL on error.
+ */
+struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
+{
+	struct page_pool *pp = this_cpu_read(system_page_pool);
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	u32 len = xdp->data_end - xdp->data_meta;
+	u32 truesize = xdp->frame_sz;
+	struct sk_buff *skb;
+	int metalen;
+	void *data;
+
+	if (!IS_ENABLED(CONFIG_PAGE_POOL))
+		return NULL;
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


