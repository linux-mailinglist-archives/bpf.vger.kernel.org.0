Return-Path: <bpf+bounces-46653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5029ED390
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FDA1686FC
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA852040BF;
	Wed, 11 Dec 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcNIKRIv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215F1FECC2;
	Wed, 11 Dec 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938142; cv=none; b=UfDVt4le421WE5NbzgtfB26Xr0MF/INJTKMLUIUqkGSPYbBg4m+JicGcLbk13lfhzVN/8k+3aIcqwLssWp33q4e1Cl7lk/05nRm0lwnbcaW2GxzQVGWQztSmyTJGT+vXgLEiIvN+hXAK0mKJypWg1KJ8MPf/Pwx9zmdHmvf/EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938142; c=relaxed/simple;
	bh=/uKo+WrFDGA87vIgprblCzqKpeygMRpaco2uSgh/wIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8fvXue/qRaWSfsFjtIPbv6X3Gnjwab0Y2Fii6RxX/H51RljTV5DoXILM1neuzMew2cxUjjo0oXLTZ8wfvkCyLzH2Jt/anMVil2EYBUdBZAl27bNXJZBcBXuGGnJirnZK0Lh32yDLHRStpe2eCXvvWRl4mgBXKuZPRT5FhDQtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcNIKRIv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938141; x=1765474141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/uKo+WrFDGA87vIgprblCzqKpeygMRpaco2uSgh/wIc=;
  b=OcNIKRIvX4HB/WAbkTsK/YvPUUty/f+PiGOVfuTdFZKWwRgVyeUAWRaH
   oP+TFJYW2dDDzWshqKMZQPXuzDWlG+XrqRsV4bk33li3w2hWxcEPDebpu
   U7me+pHas/6m1ogwxEgeTTezrhXXVUhOem5mQNFQVF2jyE8ehBxuSyhTv
   bXPWZ0Cua1CQ4lzUASq7M8bbkZiO+EgQ/by632PaQcm2HohYVSliGf4U5
   SemFYYT/hPNUWolZrfpa23bdoBOXXWSzLs0U3PH2aEQEQEu2tKqdM+qnq
   5yzTUc5GETwsO7tjg2pQptC7RY6Le426xhnlp5ItfHapT5jbk36OClEfV
   w==;
X-CSE-ConnectionGUID: 14yzc4WmRGCTDhJKsMyC6w==
X-CSE-MsgGUID: tPsDryEFQxm15+Xabw432g==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859539"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:29:01 -0800
X-CSE-ConnectionGUID: t0juJqVGT6uwaHMaehvdjA==
X-CSE-MsgGUID: +n/kNm+bR/ee1+5d9HQ11g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122192"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:28:56 -0800
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
Subject: [PATCH net-next 05/12] xdp: add generic xdp_build_skb_from_buff()
Date: Wed, 11 Dec 2024 18:26:42 +0100
Message-ID: <20241211172649.761483-6-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211172649.761483-1-aleksander.lobakin@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
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
index 11139c210b49..aa24fa78cbe6 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -336,6 +336,7 @@ xdp_update_skb_shared_info(struct sk_buff *skb, u8 nr_frags,
 void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
+struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
 struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					   struct sk_buff *skb,
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a66a4e036f53..c4d824cf27da 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -629,6 +629,61 @@ int xdp_alloc_skb_bulk(void **skbs, int n_skb, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(xdp_alloc_skb_bulk);
 
+/**
+ * xdp_build_skb_from_buff - create an skb from &xdp_buff
+ * @xdp: &xdp_buff to convert to an skb
+ *
+ * Perform common operations to create a new skb to pass up the stack from
+ * &xdp_buff: allocate an skb head from the NAPI percpu cache, initialize
+ * skb data pointers and offsets, set the recycle bit if the buff is
+ * PP-backed, Rx queue index, protocol and update frags info.
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
+	if (rxq->mem.type == MEM_TYPE_PAGE_POOL && is_page_pool_compiled_in())
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
2.47.1


