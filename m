Return-Path: <bpf+bounces-44265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C739C0B48
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 17:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDA1284D57
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF8321A4BB;
	Thu,  7 Nov 2024 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXAPyQZW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493F216A3C;
	Thu,  7 Nov 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996075; cv=none; b=X83yKroIQRNl/M634YC8eQFG11G+Fh92sh4KFUbgY9sgaQ2vvB5B/Osnt857eblRCCK5CFpc1qMbPG5ogQG/fcXIfKZxLNy+QzKraM9OiArt9TojZkwChbZvI5nvvYriw71fWLG2LrS6+NSm9XrowzVAsndLMmEmwgikLZwDCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996075; c=relaxed/simple;
	bh=YhZ3TfA4ACoplc7R0bWF7mIt9LBHnjrIy4K9m4cZqy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMFyUfFB6Ggfl9g8JJBCcVtpganm7wBTh69OiGAln+jdptwIWyUHK3UZ7a3qY1ydZUlDm3ocGlQfo+jWYTtKfMrWub+usAR2yz4+PifCkfdt8ajDC2llUG79nXdZ4u14M7SAoqWlnP2zncE9Asv8BWpwJlDTFs9GOIU4mc4llgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXAPyQZW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730996073; x=1762532073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YhZ3TfA4ACoplc7R0bWF7mIt9LBHnjrIy4K9m4cZqy4=;
  b=BXAPyQZWLXBWfXHgx92P57EtPe4asje4UPwAx12IkTd0gK4AxwqSK+aA
   CnfVsOSsbP3YHdYayZv6d4SUOWeg9fhF7YZbPUfFfeat4ojCK2eTP/wgw
   kG2l/paj3f20GXlahyD8Pe/XeukRjlqayP0AYa43SePvZDQObo3sPlILH
   1eHiUgD1dvWsTRseh+PD9lDNUCbRNTVbcr0JJ8HCX18YpWNWYOtKkHXoA
   eLTbSakHqiubf/neuA/W9bs9fjtFCbIdHjxdnyGwJKIL8X6mPL3AY3hGT
   dHK59ny2iL8JwqrLw7MbRlqehO/NkSzNTGshyBhK+sUPg2KT/2xqjxOAd
   g==;
X-CSE-ConnectionGUID: i878ptbESUy6mFMCxUuMUw==
X-CSE-MsgGUID: /f8dUQM+Qqqkq9iGbHbEXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41956004"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41956004"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 08:14:32 -0800
X-CSE-ConnectionGUID: 3Ln6dSAERnqhHk4hCjw1Jw==
X-CSE-MsgGUID: mZBI4+kZS1WR7kmBuAdfSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,135,1728975600"; 
   d="scan'208";a="90258229"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 08:14:29 -0800
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
Subject: [PATCH net-next v4 12/19] xdp: add generic xdp_build_skb_from_buff()
Date: Thu,  7 Nov 2024 17:10:19 +0100
Message-ID: <20241107161026.2903044-13-aleksander.lobakin@intel.com>
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

The code which builds an skb from an &xdp_buff keeps multiplying itself
around the drivers with almost no changes. Let's try to stop that by
adding a generic function.
Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
using napi_build_skb() and make use of the available xdp_rxq pointer to
assign the Rx queue index. In case of PP-backed buffer, mark the skb to
be recycled, as every PP user's been switched to recycle skbs.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |  1 +
 net/core/xdp.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 4c19042adf80..b0a25b7060ff 100644
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
index b1b426a9b146..3a9a3c14b080 100644
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
+		u32 tsize;
+
+		tsize = sinfo->xdp_frags_truesize ? : nr_frags * xdp->frame_sz;
+		xdp_update_skb_shared_info(skb, nr_frags,
+					   sinfo->xdp_frags_size, tsize,
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
2.47.0


