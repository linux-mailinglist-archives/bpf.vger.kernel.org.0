Return-Path: <bpf+bounces-69229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C5B91E60
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E1742292A
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B502E2F09;
	Mon, 22 Sep 2025 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0Numu2v"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC012E2EF3;
	Mon, 22 Sep 2025 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554792; cv=none; b=Bz94RuYge/7PQvMddj1V4cFEXfsSAjlshlsDpQA6qMgSNELmdQjPtRb5RHxQ8b9jtp8UDmm4Ms2mylPtw9HJ248cdttzvJlSLuQt98WVdZksram9cqQxFPmBe0WKkgg08sEiojEX4vOGvwrwtsKRMpw0QX8RNyLLEEvY98DWvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554792; c=relaxed/simple;
	bh=Y4fnleyqyoss5s3md/xjL2CyA4kvaa4yNTBzeIKaYE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kciY5wI60uFmCRQ5Vr4r6yEQhj4yvXtJmN24maqYCB+DgFirJXnfrmtaAY5rn//QZ+rbQIXcoui2pnQNA9tnnaulXFc22TPJsQYdOddoZ+qNadK011A0bo4QU0fdwIBEshxAGeda8zlrV1AY7KUX2r/JwyM1Txu1nVwY8LJYX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N0Numu2v; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758554791; x=1790090791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y4fnleyqyoss5s3md/xjL2CyA4kvaa4yNTBzeIKaYE8=;
  b=N0Numu2vvun2JkHeNbf5oChvqD0o7KIf3/9tTdTVBU27DeSLpEogDVFp
   jn9rGSkFuVVR5jaVpvPkqdPuq52jipEqLqR9ogqTc+5b10hWaoVBcHzwP
   /rW5ZMP/JUCx35SlVk2eSF95WqTPtkh4JhCy9uiq3Mub8/VL8MMRUDqnb
   864PIm8a7sGWY4846ZNpv5gfFxRQ3psR+ZUegALA9wtmn2YZ4IlNed6/e
   ufGxQmx5bVKI3eVVe7IGWSa3sCwAorzYMypjZPZ5roct/dlnAdXetkt6g
   N+E5wXjj41lwD7HWuKa2Zfgs5WrWKr0FELI0d1WZcaNwjAzw3oxs4iIj/
   A==;
X-CSE-ConnectionGUID: ZLAcn+2eR22tBlS4KF69XA==
X-CSE-MsgGUID: cFaGar8cTtGOB9PG963FCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63449214"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="63449214"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:26:31 -0700
X-CSE-ConnectionGUID: PVXFiifhSPiRHnmTtk37bQ==
X-CSE-MsgGUID: KyDR+kg0R9WK9bn7HBEtIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207242236"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 22 Sep 2025 08:26:29 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
Date: Mon, 22 Sep 2025 17:25:59 +0200
Message-Id: <20250922152600.2455136-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that set IFF_TX_SKB_NO_LINEAR will not execute branch that
handles metadata, as we set @first_frag only for !IFF_TX_SKB_NO_LINEAR
code in xsk_build_skb().

Same functionality can be achieved with checking if xsk_get_num_desc()
returns 0. To replace current usage of @first_frag with
XSKCB(skb)->num_descs check, pull out the code from
xsk_set_destructor_arg() that initializes sk_buff::cb and call it before
skb_store_bits() in branch that creates skb against first processed
frag. This so error path has the XSKCB(skb)->num_descs initialized and
can free skb in case skb_store_bits() failed.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72194f0a3fc0..064238400036 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -605,6 +605,13 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
 	return XSKCB(skb)->num_descs;
 }
 
+static void xsk_init_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
+	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
+	XSKCB(skb)->num_descs = 0;
+}
+
 static void xsk_destruct_skb(struct sk_buff *skb)
 {
 	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
@@ -620,9 +627,6 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 
 static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
 {
-	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
-	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
-	XSKCB(skb)->num_descs = 0;
 	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
 }
 
@@ -672,7 +676,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
-
+		xsk_init_cb(skb);
 		xsk_set_destructor_arg(skb, desc->addr);
 	} else {
 		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
@@ -725,7 +729,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
-	bool first_frag = false;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
@@ -742,8 +745,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		len = desc->len;
 
 		if (!skb) {
-			first_frag = true;
-
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
 			tr = dev->needed_tailroom;
 			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
@@ -752,6 +753,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_reserve(skb, hr);
 			skb_put(skb, len);
+			xsk_init_cb(skb);
 
 			err = skb_store_bits(skb, 0, buffer, len);
 			if (unlikely(err))
@@ -797,7 +799,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 		}
 
-		if (first_frag && desc->options & XDP_TX_METADATA) {
+		if (!xsk_get_num_desc(skb) && desc->options & XDP_TX_METADATA) {
 			if (unlikely(xs->pool->tx_metadata_len == 0)) {
 				err = -EINVAL;
 				goto free_err;
@@ -839,7 +841,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (first_frag && skb)
+	if (skb && !xsk_get_num_desc(skb))
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.43.0


