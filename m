Return-Path: <bpf+bounces-69742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C9BA0863
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35A6F4E3AD4
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32364306B25;
	Thu, 25 Sep 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5JcU1cy"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C6301718;
	Thu, 25 Sep 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816049; cv=none; b=ocK5LSec4aTTN1wInt0bvbZu5L7c9IaQKNgKdv1FXGpl87kg+cqbbCRBsSQlBzZXSfkRepqILRtPIo3TjPBfPGjEQQ8uQD6Z9ajPT2xgvcQ5nPuwWb4f6ufL6hlTmd74cyH6jJUrUWJAC51pWeHANI1iN7nfXeOsr+iyoStfd9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816049; c=relaxed/simple;
	bh=emKiJre1SB0bU3VzKGjv3l7j7tMDozvrFPkiC1cRjTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3/nJWdLzodQ8ySmznpyQyskiR7GmqS0wDMLaiUa/QUCkI6xRsGcUgUOSnnTYf4dcqwiY2abRjm7kTd3ZlwduUV6gjR64v/6saueV2HXJqacRFmrpOu6yjkW3CTtiIeXzCmq9eJVCmwZNjfqNxWlSRQHA6SSkfmYlGgte5NK5as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5JcU1cy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758816048; x=1790352048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=emKiJre1SB0bU3VzKGjv3l7j7tMDozvrFPkiC1cRjTc=;
  b=U5JcU1cyFkHsarFi+eCYFtwgPLpP+PM/VXGuyKViyvwcDKgzLVev7pgw
   krtFvNpXcYR7DTcmmZSiGkIUw3zq1DAPkYxEv/VFj7Ka1W/HkAXDeAPwz
   h/P64PzY6LXou960boMj+55AMZOeux2yLDPDTV+JIaDzBN1L0ECV9dW21
   MOaGxd6Z9NyibsnKsK/U6AlvrX3pkvgO6+JP0rq5Oi5lSVYfjLBSvDNKz
   6BDOBmU5SuuBElP9i6FN3qeVvZbiF594e6qAa+9AtCzRLjBWe+xHIbRP1
   wrIAQQu+zw2rtQcfTFJ2J++q2/cFW8hPf/wN8jQFIZvfzVADlf/cCGTJ6
   w==;
X-CSE-ConnectionGUID: FIVnH7SNT16JrRZ37S9l2g==
X-CSE-MsgGUID: 1oZLLPlJQYaHQ3JBNtnR6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71759849"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="71759849"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 09:00:48 -0700
X-CSE-ConnectionGUID: vqVTVy0gS2WX/6Db1+Uv0g==
X-CSE-MsgGUID: LKN9CM0AT+OX0QJB7cxByQ==
X-ExtLoop1: 1
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 25 Sep 2025 09:00:45 -0700
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
Subject: [PATCH v2 bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
Date: Thu, 25 Sep 2025 18:00:08 +0200
Message-Id: <20250925160009.2474816-3-maciej.fijalkowski@intel.com>
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

Instead of using auxiliary boolean that tracks if we are at first frag
when gathering all elements of skb, same functionality can be achieved
with checking if skb_shared_info::nr_frags is 0.

Remove @first_frag but be careful around xsk_build_skb_zerocopy() and
NULL the skb pointer when it failed so that common error path does not
incorrectly interpret it during decision whether to call kfree_skb().

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 01f258894fae..f7e0d254a723 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -730,13 +730,13 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
-	bool first_frag = false;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
 		skb = xsk_build_skb_zerocopy(xs, desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
+			skb = NULL;
 			goto free_err;
 		}
 	} else {
@@ -747,8 +747,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		len = desc->len;
 
 		if (!skb) {
-			first_frag = true;
-
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
 			tr = dev->needed_tailroom;
 			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
@@ -798,7 +796,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
 		}
 
-		if (first_frag && desc->options & XDP_TX_METADATA) {
+		if (!skb_shinfo(skb)->nr_frags && desc->options & XDP_TX_METADATA) {
 			if (unlikely(xs->pool->tx_metadata_len == 0)) {
 				err = -EINVAL;
 				goto free_err;
@@ -840,7 +838,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (first_frag && skb)
+	if (skb && !skb_shinfo(skb)->nr_frags)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.43.0


