Return-Path: <bpf+bounces-69743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E290BBA086C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD0238820A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B3305E2F;
	Thu, 25 Sep 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCXCiHEO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25E2F2611;
	Thu, 25 Sep 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816055; cv=none; b=nl4gOwZUVzfOEy8zIqOI/x8UV4uCpE8oGq3kJ6nLlUJDHXKN3aFKi3ETL5ARiLkI8G9E5ziExEeYtKKugHRY0zoKrO8yFs5hp9FyeEzg30t+y3j8dtTp0bl4HczlChQZVBjhdumAx11mGUYLeRQCKbvuuH7cLC5dx17o4iLuGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816055; c=relaxed/simple;
	bh=fMZ9pDkVKjK47hn36tt0DCxnyx57G4AESffknPyF/hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dnN6rG+AjYzpYpuD9coRLxKgjHUvHPFOIi6oewfV7mflN7NhndJRfVzwqfZF+QfunhiMwZchD21l558Oh/0qbcTESShLbdldkUVjTX1TnbqRj2oViLKOw34SC+1vW65gBrnPn0biVOGJefopUTuxPRKQMRUiqt4YW6VfD8ZHpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCXCiHEO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758816051; x=1790352051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fMZ9pDkVKjK47hn36tt0DCxnyx57G4AESffknPyF/hM=;
  b=jCXCiHEOIm3+/wb+8MXHEopB3HYBZo6vMC240XBF1CppwiQnytAF2csM
   SYz4IiH5qXbT6vsyak3Lh4hG4MYxyl/IG4qrgcGHn1lXv10sMUD7YYcWr
   MvXHjAHQ4uUPt0gCsUV9To73L1lq+2VrVrLfhFSt+G9f1jMeLKAMsohZ+
   +P492U//exzVLqoNIwq7X/Pb3m1O1vNJvyPuIDTtWWXwt4b2YamwhwLPC
   1ySgvfcqln5VeYlWd3oFl1N1adNkhdHiFiMBFionTHDq8KskCrP5tGocf
   yENS5B7LnlObLCpisIRl7PfQeHTzg9fxEX0lNaFPw/vIQ0DPrOYrFgArk
   g==;
X-CSE-ConnectionGUID: itok4C2LS9iYgv5dRarDyw==
X-CSE-MsgGUID: M6hm33jKQS67Ui6HHXRZNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71759865"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="71759865"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 09:00:50 -0700
X-CSE-ConnectionGUID: kiEikI7NQGqYwPS+mDtTmQ==
X-CSE-MsgGUID: qkQNymMYRWOUtVSqi/Y+UA==
X-ExtLoop1: 1
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 25 Sep 2025 09:00:48 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v2 bpf-next 3/3] xsk: wrap generic metadata handling onto separate function
Date: Thu, 25 Sep 2025 18:00:09 +0200
Message-Id: <20250925160009.2474816-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
References: <20250925160009.2474816-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xsk_build_skb() has gone wild with its size and one of the things we can
do about it is to pull out a branch that takes care of metadata handling
and make it a separate function.

While at it, let us add metadata SW support for devices supporting
IFF_TX_SKB_NO_LINEAR flag, that happen to have separate logic for
building skb in xsk's generic xmit path.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 92 +++++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 39 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f7e0d254a723..7b0c68a70888 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -657,6 +657,45 @@ static void xsk_drop_skb(struct sk_buff *skb)
 	xsk_consume_skb(skb);
 }
 
+static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
+			    struct xdp_desc *desc, struct xsk_buff_pool *pool,
+			    u32 hr)
+{
+	struct xsk_tx_metadata *meta = NULL;
+
+	if (unlikely(pool->tx_metadata_len == 0))
+		return -EINVAL;
+
+	meta = buffer - pool->tx_metadata_len;
+	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
+		return -EINVAL;
+
+	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
+		if (unlikely(meta->request.csum_start +
+			     meta->request.csum_offset +
+			     sizeof(__sum16) > desc->len))
+			return -EINVAL;
+
+		skb->csum_start = hr + meta->request.csum_start;
+		skb->csum_offset = meta->request.csum_offset;
+		skb->ip_summed = CHECKSUM_PARTIAL;
+
+		if (unlikely(pool->tx_sw_csum)) {
+			int err;
+
+			err = skb_checksum_help(skb);
+			if (err)
+				return err;
+		}
+	}
+
+	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+		skb->skb_mstamp_ns = meta->request.launch_time;
+	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
+
+	return 0;
+}
+
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 					      struct xdp_desc *desc)
 {
@@ -669,6 +708,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	int err, i;
 	u64 addr;
 
+	addr = desc->addr;
+	buffer = xsk_buff_raw_get_data(pool, addr);
+
 	if (!skb) {
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
@@ -679,6 +721,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		skb_reserve(skb, hr);
 
 		xsk_skb_init_misc(skb, xs, desc->addr);
+		if (desc->options & XDP_TX_METADATA) {
+			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
+			if (unlikely(err))
+				return ERR_PTR(err);
+		}
 	} else {
 		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
 		if (!xsk_addr)
@@ -692,11 +739,9 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 	}
 
-	addr = desc->addr;
 	len = desc->len;
 	ts = pool->unaligned ? len : pool->chunk_size;
 
-	buffer = xsk_buff_raw_get_data(pool, addr);
 	offset = offset_in_page(buffer);
 	addr = buffer - pool->addrs;
 
@@ -727,7 +772,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				     struct xdp_desc *desc)
 {
-	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
 	int err;
@@ -761,6 +805,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				goto free_err;
 
 			xsk_skb_init_misc(skb, xs, desc->addr);
+			if (desc->options & XDP_TX_METADATA) {
+				err = xsk_skb_metadata(skb, buffer, desc,
+						       xs->pool, hr);
+				if (unlikely(err))
+					goto free_err;
+			}
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct xsk_addr_node *xsk_addr;
@@ -795,42 +845,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			xsk_addr->addr = desc->addr;
 			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 		}
-
-		if (!skb_shinfo(skb)->nr_frags && desc->options & XDP_TX_METADATA) {
-			if (unlikely(xs->pool->tx_metadata_len == 0)) {
-				err = -EINVAL;
-				goto free_err;
-			}
-
-			meta = buffer - xs->pool->tx_metadata_len;
-			if (unlikely(!xsk_buff_valid_tx_metadata(meta))) {
-				err = -EINVAL;
-				goto free_err;
-			}
-
-			if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
-				if (unlikely(meta->request.csum_start +
-					     meta->request.csum_offset +
-					     sizeof(__sum16) > len)) {
-					err = -EINVAL;
-					goto free_err;
-				}
-
-				skb->csum_start = hr + meta->request.csum_start;
-				skb->csum_offset = meta->request.csum_offset;
-				skb->ip_summed = CHECKSUM_PARTIAL;
-
-				if (unlikely(xs->pool->tx_sw_csum)) {
-					err = skb_checksum_help(skb);
-					if (err)
-						goto free_err;
-				}
-			}
-
-			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
-				skb->skb_mstamp_ns = meta->request.launch_time;
-			xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
-		}
 	}
 
 	xsk_inc_num_desc(skb);
-- 
2.43.0


