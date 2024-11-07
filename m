Return-Path: <bpf+bounces-44264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E0E9C0B45
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36035284BEE
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3344219CBE;
	Thu,  7 Nov 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqpvUjsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C8219C9C;
	Thu,  7 Nov 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996073; cv=none; b=RfHkDQ55YfmCn5BEMK2IE6athb4eGFlYYDwZ47B0LFdGEyLgcepYE8ZkETDYabaHffXIHj2OrpMJUHlAGM3EeDPtg6n5U5YgKt3kTezUqfoS+x0qY45izNpOmx7Y7Yu8o6KmXtoH1t4O0MxbP+0vEcPWwwVO0sm6gbdrayE+9L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996073; c=relaxed/simple;
	bh=gE1Z3BLQSCdCqry/fy5Ufe5cNavHxq8XalIlY63IyKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VC+1dL9Os+Un2hP6OkKxFb80fAk+8driKeRlF9lidI6pbX9AaSUm4NqVn4RdDBoa7m+AuqBoXPY365MAWnATaK0OQx+67aAnk37KSRD2J8BHUFShgIzww9zvETSaVOojHiIs+8jA2GZtEUiitSuxO9wPhwH4eIMcpD2HX4kcZa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqpvUjsZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996072; x=1762532072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gE1Z3BLQSCdCqry/fy5Ufe5cNavHxq8XalIlY63IyKo=;
  b=jqpvUjsZMIy6f9wALF7VAgM6i6E2O09qynS/WhGhoR77sIwl7CSDabdB
   cJQm+JT8YIGlKYpkqcvUcMISnENmquauEyy3dcdnN7o/UrXKjw1SgENXD
   KZXDCgpDbRAXI9FnbquKnEfksT0P4VhwFhOr4tDNZfswoI2x0lp80CI9W
   QjND9XfcpF1SWYTSmvyxdyLeHixqIg7q972RbUv31XpqahYCDXV4NBC8X
   rLSb/AWlFcp1vDWq2/daMW6edbXVlCcqc+JIrDGjxZtL6uxNd/xNQKXzo
   Jyl5PN9v2BBKki2pfU+xi8ZH9uyxQ3HEn/YSJIWx6UJ+LBgjDzAaPckqL
   Q==;
X-CSE-ConnectionGUID: AVh/VSP4TLWe7KTf7NX4Aw==
X-CSE-MsgGUID: IXxymi6EROKbrK94DB54UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41955987"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41955987"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:28 -0800
X-CSE-ConnectionGUID: vcWgzRf5Td+B0iVzvwIMjA==
X-CSE-MsgGUID: i3RBgNg6Q6WSbgQ15OCcGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258225"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:14:25 -0800
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
Subject: [PATCH net-next v4 11/19] xdp: add generic xdp_buff_add_frag()
Date: Thu,  7 Nov 2024 17:10:18 +0100
Message-ID: <20241107161026.2903044-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
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
index d6920df9b620..0d7e987a4fdd 100644
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
index d33d73e798fe..4c19042adf80 100644
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


