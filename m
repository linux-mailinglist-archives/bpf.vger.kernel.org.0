Return-Path: <bpf+bounces-43583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B509B69FC
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2881F22186
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC20322A4AE;
	Wed, 30 Oct 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3NZVkad"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2072296F5;
	Wed, 30 Oct 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307257; cv=none; b=rPqxz6T4DAhGToePza3L3QLUazqsMjdI9yOWT6eDCObEqMncrWvTtVl8SLDGLh5ROONKyKTEPsLkczTZZFyKMnYR2ervmpCtw5o6bI/olHjlj7JdO/Dc6l+vxzx7RSTuIOjYyX2xKQydWQVbFw8zPjUzweiql4RDl7bM4QiFV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307257; c=relaxed/simple;
	bh=DXKV5tHRVERPeEsblP/yRrq3CP6BqLAgt7hogDsb0wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNQixfbbcbAuAcIsTT2df3zzIQAH/XOK+RBfnkOZN23yyD4czik3ZoqVPGVlQ3wywoYmYZEYcd1xZ7keKsltZHy1Sa3O69wMSJWD3pj1YhT0Xk7GLMRKFbDPqtzEe7/d4o+Y9WTYzgDJ+IyK/ShfSRG+mxFo3bb1BumKq9gkKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3NZVkad; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730307255; x=1761843255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DXKV5tHRVERPeEsblP/yRrq3CP6BqLAgt7hogDsb0wQ=;
  b=Z3NZVkad9oFjvEKtu9U4M76cylizYxnSaqMWI5OLMMrmrAPELPK7Mimr
   G3ezBQwGAiWxsVcJr8E2yD5Yscb1O6gMkfl+1ATxeJNLy7dLcpSNO5OYb
   BpH/8ly7w5XzCLk7GwdD6h/SzRwMbelHm73p9EUMCABoeJsrBpuZe8kS+
   NB3hy71XP0Tjg/r85e1SvEXOR5ioT4O62WLinajlZAU3AXnrPf/mL+hxt
   wVtJnwp34mzcirppBfbE1OD4ohVhyaT4Kc709pW51N2nmNKD8IZU2tJq3
   VKzDooftfKaiplk+gXYgm6BueHercp+oxvZqUzEIU3XxIod1buRYH9gID
   A==;
X-CSE-ConnectionGUID: WPG6WRi/SZ2X+cFvUWw1Yw==
X-CSE-MsgGUID: 8fIO26XzRN2HmoP5NK8lTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41389776"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41389776"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:54:15 -0700
X-CSE-ConnectionGUID: hR28saU+SueVV0sGawFcpA==
X-CSE-MsgGUID: GOOt05PJTsGNbB7T0d5Cjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87524519"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 09:54:11 -0700
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
Subject: [PATCH net-next v3 11/18] xdp: add generic xdp_buff_add_frag()
Date: Wed, 30 Oct 2024 17:51:54 +0100
Message-ID: <20241030165201.442301-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030165201.442301-1-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code piece which would attach a frag to &xdp_buff is almost
identical across the drivers supporting XDP multi-buffer on Rx.
Make it a generic elegant "oneliner".
Also, I see lots of drivers calculating frags_truesize as
`xdp->frame_sz * nr_frags`. I can't say this is fully correct, since
frags might be backed by chunks of different sizes, especially with
stuff like the header split. Even page_pool_alloc() can give you two
different truesizes on two subsequent requests to allocate the same
buffer size. Add a field to &skb_shared_info (unionized as there's no
free slot currently on x86_64) to track the "true" truesize. It can
be used later when updating an skb.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h | 16 ++++++--
 include/net/xdp.h      | 90 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c867df5b1051..6ec78c1598fe 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -607,11 +607,19 @@ struct skb_shared_info {
 	 * Warning : all fields before dataref are cleared in __alloc_skb()
 	 */
 	atomic_t	dataref;
-	unsigned int	xdp_frags_size;
 
-	/* Intermediate layers must ensure that destructor_arg
-	 * remains valid until skb destructor */
-	void *		destructor_arg;
+	union {
+		struct {
+			u32		xdp_frags_size;
+			u32		xdp_frags_truesize;
+		};
+
+		/*
+		 * Intermediate layers must ensure that destructor_arg
+		 * remains valid until skb destructor.
+		 */
+		void		*destructor_arg;
+	};
 
 	/* must be last field, see pskb_expand_head() */
 	skb_frag_t	frags[MAX_SKB_FRAGS];
diff --git a/include/net/xdp.h b/include/net/xdp.h
index c4b408d22669..19d2b283b845 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -167,6 +167,88 @@ xdp_get_buff_len(const struct xdp_buff *xdp)
 	return len;
 }
 
+/**
+ * __xdp_buff_add_frag - attach a frag to an &xdp_buff
+ * @xdp: XDP buffer to attach the frag to
+ * @page: page containing the frag
+ * @offset: page offset at which the frag starts
+ * @size: size of the frag
+ * @truesize: truesize (page / page frag size) of the frag
+ * @try_coalesce: whether to try coalescing the frags
+ *
+ * Attach a frag to an XDP buffer. If it currently has no frags attached,
+ * initialize the related fields, otherwise check that the frag number
+ * didn't reach the limit of ``MAX_SKB_FRAGS``. If possible, try coalescing
+ * the frag with the previous one.
+ * The function doesn't check/update the pfmemalloc bit. Please use the
+ * non-underscored wrapper in drivers.
+ *
+ * Return: true on success, false if there's no space for the frag in
+ * the shared info struct.
+ */
+static inline bool __xdp_buff_add_frag(struct xdp_buff *xdp, struct page *page,
+				       u32 offset, u32 size, u32 truesize,
+				       bool try_coalesce)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	skb_frag_t *prev;
+	u32 nr_frags;
+
+	if (!xdp_buff_has_frags(xdp)) {
+		xdp_buff_set_frags_flag(xdp);
+
+		nr_frags = 0;
+		sinfo->xdp_frags_size = 0;
+		sinfo->xdp_frags_truesize = 0;
+
+		goto fill;
+	}
+
+	nr_frags = sinfo->nr_frags;
+	if (unlikely(nr_frags == MAX_SKB_FRAGS))
+		return false;
+
+	prev = &sinfo->frags[nr_frags - 1];
+	if (try_coalesce && page == skb_frag_page(prev) &&
+	    offset == skb_frag_off(prev) + skb_frag_size(prev))
+		skb_frag_size_add(prev, size);
+	else
+fill:
+		__skb_fill_page_desc_noacc(sinfo, nr_frags++, page,
+					   offset, size);
+
+	sinfo->nr_frags = nr_frags;
+	sinfo->xdp_frags_size += size;
+	sinfo->xdp_frags_truesize += truesize;
+
+	return true;
+}
+
+/**
+ * xdp_buff_add_frag - attach a frag to an &xdp_buff
+ * @xdp: XDP buffer to attach the frag to
+ * @page: page containing the frag
+ * @offset: page offset at which the frag starts
+ * @size: size of the frag
+ * @truesize: truesize (page / page frag size) of the frag
+ *
+ * Version of __xdp_buff_add_frag() which takes care of the pfmemalloc bit.
+ *
+ * Return: true on success, false if there's no space for the frag in
+ * the shared info struct.
+ */
+static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, struct page *page,
+				     u32 offset, u32 size, u32 truesize)
+{
+	if (!__xdp_buff_add_frag(xdp, page, offset, size, truesize, true))
+		return false;
+
+	if (unlikely(page_is_pfmemalloc(page)))
+		xdp_buff_set_frag_pfmemalloc(xdp);
+
+	return true;
+}
+
 struct xdp_frame {
 	void *data;
 	u32 len;
@@ -230,7 +312,13 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 			   unsigned int size, unsigned int truesize,
 			   bool pfmemalloc)
 {
-	skb_shinfo(skb)->nr_frags = nr_frags;
+	struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+	sinfo->nr_frags = nr_frags;
+	/* ``destructor_arg`` is unionized with ``xdp_frags_{,true}size``,
+	 * reset it after that these fields aren't used anymore.
+	 */
+	sinfo->destructor_arg = NULL;
 
 	skb->len += size;
 	skb->data_len += size;
-- 
2.47.0


