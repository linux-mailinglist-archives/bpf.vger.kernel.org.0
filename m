Return-Path: <bpf+bounces-44767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095CB9C7737
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8072813B1
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BAA2123D9;
	Wed, 13 Nov 2024 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfhfw912"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB0120F5D3;
	Wed, 13 Nov 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511551; cv=none; b=dXHUdmXTbXURV7xj4d9CiZHTH6LTvc2HTiiiejYupvOM4YkB8FjGhsV+iVaE1n6D9DmffSeINVwd6sHmIN8EIQf+doq8pMoA1PDXJeegsLbkupUwnbOHALUrHoWfVCz5nH9jSkiHfJwfUmcNzbRmGFxjR1ymmMKZzJXRth2mVBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511551; c=relaxed/simple;
	bh=0bxtNMeTjBtWsf3OXWlcIoRP5wE9plodK8FqBilBLYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdRpoJPZs4kQr3Z0weC+F0ii67p+kYsJh4mp7Y/AUZFrIMD2m9t+GVf+4j355dOjlHkhI2rHJcJg0VM8O31FWCh2VACfnOzui3NDz2Z/i7dH+2QqaeFYQn9xkryuwEUtO8P0ZkuMMm2r1otElGztlQRkx8mMUTNhyhJ3Gqhu1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfhfw912; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511549; x=1763047549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0bxtNMeTjBtWsf3OXWlcIoRP5wE9plodK8FqBilBLYs=;
  b=cfhfw912OoCsYFt9Qi/nchsj/S8W/sinRBeZAGpsoeHb3d27LUTYJg63
   Ll7w5/eVLFDDzlEUdHZl8V683wPgdF6MI3/4OFvye2adffO3FG+7ZOVBg
   AKInSafFtNKvsPJn9zQSjOPQDBmcsVHzChoT18XFEf/P3gw1kvj9HLw8k
   +O8lCDVinuw/9h54rxfPXQUTDbxxcLYrLAi624w8fzm9iyfYtF4gLh0vQ
   3gmltsZx1C4YukAWsiBcQBJKCMgMdaUHk42EDasw7B2+iEv39TMb3n6s2
   e81R9VvzSKGd2W5GSPF4rcAhpvHhErMim5zh8vEX72GJ559DXe252gpC3
   w==;
X-CSE-ConnectionGUID: cP6RWc9qQg6sBvxFMiHEWQ==
X-CSE-MsgGUID: WLtmal1MQEmUdsphocn+gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799367"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799367"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:49 -0800
X-CSE-ConnectionGUID: K7AHCZdBSm+D0rf7Sphu8w==
X-CSE-MsgGUID: Rtg/y6x1T7apmnbRRivURQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726970"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:45 -0800
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
Subject: [PATCH net-next v5 12/19] xdp: add generic xdp_build_skb_from_buff()
Date: Wed, 13 Nov 2024 16:24:35 +0100
Message-ID: <20241113152442.4000468-13-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The code which builds an skb from an &xdp_buff keeps multiplying itself
around the drivers with almost no changes. Let's try to stop that by
adding a generic function.
Unlike __xdp_build_skb_from_frame(), always allocate an skbuff head
using napi_build_skb() and make use of the available xdp_rxq pointer to
assign the Rx queue index. In case of PP-backed buffer, mark the skb to
be recycled, as every PP user's been switched to recycle skbs.

Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
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


