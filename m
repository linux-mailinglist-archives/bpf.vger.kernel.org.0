Return-Path: <bpf+bounces-69230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45EDB91E69
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A323422E4D
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3152E2847;
	Mon, 22 Sep 2025 15:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7Y2j3Tq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB352E3360;
	Mon, 22 Sep 2025 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554795; cv=none; b=dvlyfTdTVF8lyH1QwP7oluVAs2ogIpT1vD7JtoKVDF/NHZ5IxzNVkb3fEe93KBNhOfx2xSb3gKgmz1sVJwzw0COxJdgihvAUkl1HpzXtetbdboLn7oHkbp9vZp+IDuOkVfU0oTrl0U05PsMScSunxM1c97jDV7ev1YSnWajrvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554795; c=relaxed/simple;
	bh=r+U+Xow8gQkcWwszhPh0pl4kZjueOXormgmuZ9qI7MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d5EAjKL9f+QcVqxeTSkNoRtIc3dy3dG841Pk9iXBGBhA+NzfHakRhagkBW15fo0EgjdfouUHyT2RSgH3bcdKa9CzSBYQHhq1l16HvjFSt4TatCKR0vm4aklE1G/9WU5mi9i7fqletFF69ikbIfda0wnJnjXVSgl4ERLqntM2Q+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7Y2j3Tq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758554794; x=1790090794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+U+Xow8gQkcWwszhPh0pl4kZjueOXormgmuZ9qI7MM=;
  b=N7Y2j3Tq42iGEaELk+Uy3Asw4ekszsKbvlRyTKUfLSUanqXBiUBJky1O
   JUPKZ2DXwCepSj/hv+g5sa7EfnL9s/ImpTA/2YfvFLu1Vq7W0DuGrE0Sp
   I4FIOyOraLrA1Fo25aFpn25FIZxZ0om1EE5XpiGeGMYiLoL0FqNq7KXXK
   tzay2MYcauRFP1XAjZGC959r28hNVvHXNH1Zx3DsBQ4TMOTtfpSE5UMSL
   HCfdoj7q/zFlUjZV3CDBTQrQBrWflnCn++E7QyoQgbG8CcSUsfVdafdNK
   0C4YHcPVtPsXEcDi1LgAT/bHEcLSHpKJgQE+WSwwvenc9S9hVq6luOoTw
   A==;
X-CSE-ConnectionGUID: DEZsFGMmSXybQMU99jngiw==
X-CSE-MsgGUID: BdtFtX0RR7mkfhY8vMMpzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="63449220"
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="63449220"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2025 08:26:34 -0700
X-CSE-ConnectionGUID: ZVGq9DsAQhyU7FDbflIfxA==
X-CSE-MsgGUID: qmT8uUzUSv+qk607w/r+ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="207242248"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 22 Sep 2025 08:26:32 -0700
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
Subject: [PATCH bpf-next 3/3] xsk: wrap generic metadata handling onto separate function
Date: Mon, 22 Sep 2025 17:26:00 +0200
Message-Id: <20250922152600.2455136-4-maciej.fijalkowski@intel.com>
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

xsk_build_skb() has gone wild with its size and one of the things we can
do about it is to pull out a branch that takes care of metadata handling
and make it a separate function. Consider this as a good start of
cleanup.

No functional changes here.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 83 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 37 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 064238400036..7121d4f99915 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -723,10 +723,48 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	return skb;
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
 static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				     struct xdp_desc *desc)
 {
-	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
 	int err;
@@ -764,6 +802,13 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			skb->priority = READ_ONCE(xs->sk.sk_priority);
 			skb->mark = READ_ONCE(xs->sk.sk_mark);
 			skb->destructor = xsk_destruct_skb;
+
+			if (desc->options & XDP_TX_METADATA) {
+				err = xsk_skb_metadata(skb, buffer, desc,
+						       xs->pool, hr);
+				if (unlikely(err))
+					goto free_err;
+			}
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct xsk_addr_node *xsk_addr;
@@ -798,42 +843,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			xsk_addr->addr = desc->addr;
 			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 		}
-
-		if (!xsk_get_num_desc(skb) && desc->options & XDP_TX_METADATA) {
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


