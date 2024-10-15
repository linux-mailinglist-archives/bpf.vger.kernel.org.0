Return-Path: <bpf+bounces-42053-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B340799F060
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4341C22623
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548CC1B3930;
	Tue, 15 Oct 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ak65/AX0"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205371DD0F6;
	Tue, 15 Oct 2024 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004105; cv=none; b=LZwhLiwl5uzKFsq35C9MGjXoZ72zPrjaF5BXthPFsiLaAwgcD88JX29JZPqGuFM1bI4w87+w6FiBHq7ptsleiDmzckBHoIe0TcKo7p4WgABiUr4m58HI8+E5GNSzqWmSQG5ZuXdtwXmv9Tj/CKKXI6VEB93kMO0rEjvOQk263cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004105; c=relaxed/simple;
	bh=3w6pGT6HjvyAE4uKGtTGhiOP+mU9GIV3EXcH81Vbr2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXWj9xPOJYg0oUQOFBR7tt7HfUtdsDigkM6P53hMPUydNuPgVWLaNOr8QjLwWENOvUEyWFdPSqqAoXR55NMUN2bSl+6P/yA/XjQSqv02fxBrk2pTIyzikJgAsrBeRcjawGWlmLbxm2uf9gpeggRQ1aVJiOc5IzyZbR+NJZJVeRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ak65/AX0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004104; x=1760540104;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3w6pGT6HjvyAE4uKGtTGhiOP+mU9GIV3EXcH81Vbr2E=;
  b=ak65/AX0oQN47x+nN0H6wvGBhPFCsYb2l31kMLjUfIg/NrUPCPyaCwrx
   zx8ZV7Qpa/LgQ2odAdkSh3ZlpqJPQyP8SPMv5NXlcO19qLLkcbQToPtSp
   O6E43wJuSD+DMJJlX1GRS0uOo8yQD4GLP5MM0rQv4gR8j3XDKpO9dlAz+
   bJAqiOyup0F+eQyoepTJs+UV/ROIOBcMlh8XrNFXdJMfza8zFbvsnXO8N
   aiqdwGpml349jW5FxsmjWP5SAFShp2Vye08/096PqXtuqD1ZslR6ms+JW
   P6/ifMVHr5SHEBAv9n1zephYPYPz0L0EpELcuIhxAf+GkGh8j2gGbq2s+
   g==;
X-CSE-ConnectionGUID: NcFDaaFYSemySs8OZhCrQQ==
X-CSE-MsgGUID: jeg8O8IsRme6hy3WX4EF8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277585"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277585"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:55:03 -0700
X-CSE-ConnectionGUID: S10Iyr1+SD6+G/8oZoRNSg==
X-CSE-MsgGUID: WogZZ23eQKWrse++d27+uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723124"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:55:00 -0700
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
Subject: [PATCH net-next v2 12/18] xdp: add generic xdp_build_skb_from_buff()
Date: Tue, 15 Oct 2024 16:53:44 +0200
Message-ID: <20241015145350.4077765-13-aleksander.lobakin@intel.com>
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

The code which builds an skb from an &xdp_buff keeps multiplying itself
around the drivers with almost no changes. Let's try to stop that by
adding a generic function.
There's __xdp_build_skb_from_frame() already, so just convert it to take
&xdp_buff instead, while making the original one a wrapper. The original
one always took an already allocated skb, allow both variants here -- if
no skb passed, which is expected when calling from a driver, pick one via
napi_build_skb().

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |  1 +
 net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 19d2b283b845..83e3f4648caa 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -330,6 +330,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
+struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index b1b426a9b146..9dc103a09b5c 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -624,6 +624,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
 
+/**
+ * xdp_build_skb_from_buff - create an skb from an &xdp_buff
+ * @xdp: &xdp_buff to convert to an skb
+ *
+ * Perform common operations to create a new skb to pass up the stack from
+ * an &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
+ * skb data pointers and offsets, set the recycle bit if the buff is PP-backed,
+ * Rx queue index, protocol and update frags info.
+ *
+ * Return: new &sk_buff on success, %NULL on error.
+ */
+struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
+{
+	const struct xdp_rxq_info *rxq = xdp->rxq;
+	const struct skb_shared_info *sinfo;
+	struct sk_buff *skb;
+	u32 nr_frags = 0;
+	int metalen;
+
+	if (unlikely(xdp_buff_has_frags(xdp))) {
+		sinfo = xdp_get_shared_info_from_buff(xdp);
+		nr_frags = sinfo->nr_frags;
+	}
+
+	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, xdp->data - xdp->data_hard_start);
+	__skb_put(skb, xdp->data_end - xdp->data);
+
+	metalen = xdp->data - xdp->data_meta;
+	if (metalen > 0)
+		skb_metadata_set(skb, metalen);
+
+	if (is_page_pool_compiled_in() && rxq->mem.type == MEM_TYPE_PAGE_POOL)
+		skb_mark_for_recycle(skb);
+
+	skb_record_rx_queue(skb, rxq->queue_index);
+
+	if (unlikely(nr_frags)) {
+		u32 ts;
+
+		ts = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
+		xdp_update_skb_shared_info(skb, nr_frags,
+					   sinfo->xdp_frags_size, ts,
+					   xdp_buff_is_frag_pfmemalloc(xdp));
+	}
+
+	skb->protocol = eth_type_trans(skb, rxq->dev);
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(xdp_build_skb_from_buff);
+
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
 					   struct net_device *dev)
-- 
2.46.2


