Return-Path: <bpf+bounces-41430-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FCB997007
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53889281403
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525A41E7C36;
	Wed,  9 Oct 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPiBafNo"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446881E7C18;
	Wed,  9 Oct 2024 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487760; cv=none; b=cdfOAKERM0rSeFqbbFMyhJzbgoQZsWM0Ghxs3XMx1V4P3Glr+qn61sXQytr9yZm7pzAP8zgl5clapFlKUpbr/nWmrWV50Rjg4iyZ3is8CRFJq+Jre+yIb6HF8ccsvn4mrowaPWGDhfvrQvQHvLLzOGKSESq3hMTNbwbj0QFf2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487760; c=relaxed/simple;
	bh=6+0LCjXDQi34G/Xi89YQW0OtUb8pjFLGiOBHBVjRG0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOHzIyhoCioBclYacBP6HJwqjM1sH5BcTH/JLgCv5J6jxTc+3kDJeAxGM6jtDwUwYhka9LB0PZBNpqpn2q+YOVaXdT9vMIIR6NY0rmZSkhPP8X1iWAUp2zfT1Anq0u7ONNhIPC3oODo2L/h7z3s0ML1uk2lotnpNWUqthZcV8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPiBafNo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487759; x=1760023759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+0LCjXDQi34G/Xi89YQW0OtUb8pjFLGiOBHBVjRG0k=;
  b=hPiBafNoAcFlRTLwzFvLpFceUQltP6SasPW5G9E3BMs7y7y61iffXhBI
   l6VQZu4yHPps3dMxHjSISTWjfDxVb4GZgwRj4FCZBoHUET1KGd9Lbjx0W
   BbDTfERnf76L17mB6tvLy/BmB11+gNFQWz3+43w49LyRoCvSAMtw/X4C8
   wQu2NJcJbJVm0LV3RER5/oD1v0jxXt5dAfIOls8k057+ksbZ7YjLZ2h8Y
   66TCAyAitpXaTrrsbPZaPBdElyJKntBe6Gso9E4OxVt3rZxcPxmWzulLG
   2TJI2wKMMIlCDUBvlGq5lLnCTehXZbam3l1lTqY+5NiqBykmQYElXdL95
   A==;
X-CSE-ConnectionGUID: IJZOqRbbSSWHHJ5Z+0AyOg==
X-CSE-MsgGUID: jmi7oRcpTnOlpVGitD8Ovg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675806"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675806"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:29:19 -0700
X-CSE-ConnectionGUID: iOu66YabQr2SFH093K+gug==
X-CSE-MsgGUID: cieGurHJRbm2icDwAATy2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81306000"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:29:15 -0700
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
Subject: [PATCH net-next 11/18] xdp: add generic xdp_buff_add_frag()
Date: Wed,  9 Oct 2024 17:27:49 +0200
Message-ID: <20241009152756.3113697-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code piece which would attach a frag to &xdp_buff is almost
identical across the drivers supporting XDP multi-buffer on Rx.
Make it a generic elegant onelner.
Also, I see lots of drivers calculating frags_truesize as
`xdp->frame_sz * nr_frags`. I can't say this is fully correct, since
frags might be backed by chunks of different sizes, especially with
stuff like the header split. Even page_pool_alloc() can give you two
different truesizes on two subsequent requests to allocate the same
buffer size. Add a field to &skb_shared_info (unionized as there's no
free slot currently on x6_64) to track the "true" truesize. It can be
used later when updating an skb.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h | 16 ++++++--
 include/net/xdp.h      | 90 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0f0266183d3e..696b267ce15b 100644
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
index 334814d377eb..ae92af8b782d 100644
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
2.46.2


