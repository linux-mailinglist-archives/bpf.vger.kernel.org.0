Return-Path: <bpf+bounces-47262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DF89F6C8C
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A6F1894D37
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 17:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26231FBEB0;
	Wed, 18 Dec 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQz0U024"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2646F1FC104;
	Wed, 18 Dec 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734543932; cv=none; b=epGqmc98qxxzwA5bkKo9Oen1rulvG3QdC/tHIcl7EspBE0o35PdbdzizhPmF6H3RToGs3J3+bxhBwpq5cO6pIreVEFVxi7gJTOHV+cMD1oO/bvrLfAjMoFk3TRym2n7yfzBy2wi8JtTm6jou1AbThQHEWOdGFKiBjx4Wdyt6DVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734543932; c=relaxed/simple;
	bh=0fkuGfERK31RraoOz/GHRBw+3DAbMUUR5spgKUXYTDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJJZ5HqLXPIL9PS225BzhtuYBhJmx2qeo3eWZSNg7xWk+MpeKV+s5WSLonxvDlbiAcOexpBGn46xukXv2aEnOtNTugw+11Qo9PZCCWjRg6/9IIwxc8OSfpJUduffrWQnCieD27/DDPLdSBfOqMnmDq5SncQlMoCQBiAoK3TgLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQz0U024; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734543930; x=1766079930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0fkuGfERK31RraoOz/GHRBw+3DAbMUUR5spgKUXYTDM=;
  b=RQz0U024gZQs5sfrceoC04iB0lpe0H9bk3NuQjmvWRlCsB9pOhp+Faac
   Q2UgYHbKBXhD2WXfNn/RzD3LXywZf9VhiYB3huzsxxWZ8bnn2obEw0cWz
   wZ6JmXiFsHxoXr7l/1Umh9TT6ZWSxQuhNNwTe+PBmuP+8HJ8huquJJ63X
   jMOg/ZQtLKWZ2CYy7mZfYDfhcyNtrg9oHCzBSfjbWjJQKcH8qPCkFVDfN
   KOqyPB9ij5gp6Q/2UnK0HIJPr61zC9k2+lcJn95kraZSBOCRByfwFDbEC
   NaSa48BDBn6oQTefK+V/DhwYVJqAw/DNipe7JVxXjK3xuW+Sqzpqyijjw
   w==;
X-CSE-ConnectionGUID: z6fdWhNTT0SW3lwKT+E6ng==
X-CSE-MsgGUID: rvQ4h3JFSCKNzrG8BNvjSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22620974"
X-IronPort-AV: E=Sophos;i="6.12,245,1728975600"; 
   d="scan'208";a="22620974"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 09:45:30 -0800
X-CSE-ConnectionGUID: V2OUz32HSfGnOKUwQO2mpA==
X-CSE-MsgGUID: HKEuh6AJRTi8sPUhLG+PAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121192233"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 18 Dec 2024 09:45:25 -0800
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
Subject: [PATCH net-next 2/7] xdp: add generic xdp_buff_add_frag()
Date: Wed, 18 Dec 2024 18:44:30 +0100
Message-ID: <20241218174435.1445282-3-aleksander.lobakin@intel.com>
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
be used later when updating the skb.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h | 16 +++++--
 include/net/xdp.h      | 96 +++++++++++++++++++++++++++++++++++++++++-
 net/core/xdp.c         | 11 +++++
 3 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index b2509cd0b930..bb2b751d274a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -608,11 +608,19 @@ struct skb_shared_info {
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
index d2089cfecefd..11139c210b49 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -167,6 +167,93 @@ xdp_get_buff_len(const struct xdp_buff *xdp)
 	return len;
 }
 
+void xdp_return_frag(netmem_ref netmem, const struct xdp_buff *xdp);
+
+/**
+ * __xdp_buff_add_frag - attach frag to &xdp_buff
+ * @xdp: XDP buffer to attach the frag to
+ * @netmem: network memory containing the frag
+ * @offset: offset at which the frag starts
+ * @size: size of the frag
+ * @truesize: total memory size occupied by the frag
+ * @try_coalesce: whether to try coalescing the frags (not valid for XSk)
+ *
+ * Attach frag to the XDP buffer. If it currently has no frags attached,
+ * initialize the related fields, otherwise check that the frag number
+ * didn't reach the limit of ``MAX_SKB_FRAGS``. If possible, try coalescing
+ * the frag with the previous one.
+ * The function doesn't check/update the pfmemalloc bit. Please use the
+ * non-underscored wrapper in drivers.
+ *
+ * Return: true on success, false if there's no space for the frag in
+ * the shared info struct.
+ */
+static inline bool __xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
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
+	prev = &sinfo->frags[nr_frags - 1];
+
+	if (try_coalesce && netmem == skb_frag_netmem(prev) &&
+	    offset == skb_frag_off(prev) + skb_frag_size(prev)) {
+		skb_frag_size_add(prev, size);
+		/* Guaranteed to only decrement the refcount */
+		xdp_return_frag(netmem, xdp);
+	} else if (unlikely(nr_frags == MAX_SKB_FRAGS)) {
+		return false;
+	} else {
+fill:
+		__skb_fill_netmem_desc_noacc(sinfo, nr_frags++, netmem,
+					     offset, size);
+	}
+
+	sinfo->nr_frags = nr_frags;
+	sinfo->xdp_frags_size += size;
+	sinfo->xdp_frags_truesize += truesize;
+
+	return true;
+}
+
+/**
+ * xdp_buff_add_frag - attach frag to &xdp_buff
+ * @xdp: XDP buffer to attach the frag to
+ * @netmem: network memory containing the frag
+ * @offset: offset at which the frag starts
+ * @size: size of the frag
+ * @truesize: total memory size occupied by the frag
+ *
+ * Version of __xdp_buff_add_frag() which takes care of the pfmemalloc bit.
+ *
+ * Return: true on success, false if there's no space for the frag in
+ * the shared info struct.
+ */
+static inline bool xdp_buff_add_frag(struct xdp_buff *xdp, netmem_ref netmem,
+				     u32 offset, u32 size, u32 truesize)
+{
+	if (!__xdp_buff_add_frag(xdp, netmem, offset, size, truesize, true))
+		return false;
+
+	if (unlikely(netmem_is_pfmemalloc(netmem)))
+		xdp_buff_set_frag_pfmemalloc(xdp);
+
+	return true;
+}
+
 struct xdp_frame {
 	void *data;
 	u32 len;
@@ -230,7 +317,14 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 			   unsigned int size, unsigned int truesize,
 			   bool pfmemalloc)
 {
-	skb_shinfo(skb)->nr_frags = nr_frags;
+	struct skb_shared_info *sinfo = skb_shinfo(skb);
+
+	sinfo->nr_frags = nr_frags;
+	/*
+	 * ``destructor_arg`` is unionized with ``xdp_frags_{,true}size``,
+	 * reset it after that these fields aren't used anymore.
+	 */
+	sinfo->destructor_arg = NULL;
 
 	skb->len += size;
 	skb->data_len += size;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f1165a35411b..a66a4e036f53 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -535,6 +535,17 @@ void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
 
+/**
+ * xdp_return_frag -- free one XDP frag or decrement its refcount
+ * @netmem: network memory reference to release
+ * @xdp: &xdp_buff to release the frag for
+ */
+void xdp_return_frag(netmem_ref netmem, const struct xdp_buff *xdp)
+{
+	__xdp_return(netmem, xdp->rxq->mem.type, true, NULL);
+}
+EXPORT_SYMBOL_GPL(xdp_return_frag);
+
 void xdp_return_buff(struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo;
-- 
2.47.1


