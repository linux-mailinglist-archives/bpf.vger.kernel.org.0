Return-Path: <bpf+bounces-69741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C0BA085A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33814385985
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B2E2F617E;
	Thu, 25 Sep 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SJ58sd7+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4732F5321;
	Thu, 25 Sep 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816047; cv=none; b=vA7T3cFh+iLJpYHMap/KHJYiwiZccenQe54klK4vIr/59eY8vcTgL2IfKIz4tPfNYyEZAotZdZXbdEjNNEj8Kv3EnjQz4KCqRBb3M4bbmOCVr4BaXsUc6zdE0J49/EI6hB/GOC30W45MfKyIkskCg9JqvNEtRU1faxxqdCvMBt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816047; c=relaxed/simple;
	bh=hSsDTsoW1iVF7ntSuXo0WUGIdRtLyRSFiTUNOt/aTTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tQcWxbB1jT8MZ0t5ro37WtXJyUSR5uYF8MgegmmXw8a0Rtdg42QU9awcA5F2xcqqBK1N03ilbW843W941eE9Eb1MnfZkzWNtk8k/VYtiCvW6VET5Ae9dFjIZEdjkAvvs+fNkFUcX0Z1on/MhIsYzGhrfweFDXv/v6+MkRCBAjYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SJ58sd7+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758816046; x=1790352046;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSsDTsoW1iVF7ntSuXo0WUGIdRtLyRSFiTUNOt/aTTQ=;
  b=SJ58sd7+Ma0GQMinWsf8QEXpFumWl+lGhO9yWqjuxC8OCZ/LYUgceymk
   pGYE+lwIuzz3MDTH2790wh0Qoqdr/DvaucpezxEoIvwb6xUjkfIUlONd5
   0s1RXXpF8Kut+yNlt0K627+TUqtF8RTjgV2294Stv7HLzUFZerUS15TcO
   zEVHYuxoPhaT/BBKtqUbWLRWdZCQrclVRRQsE/t+OsPKCamWg0ZInqHua
   Nq0rWiucgVKjCCvAWqFqNM1db0T3qOfdXoN0B06xvjQJk1Ek/GYhdZtVj
   61R4GaNw07/xt3Xb3/14JeQCk9wJDquv0fR7I2SsbTNuzQki2f6ERjmde
   Q==;
X-CSE-ConnectionGUID: wPL7SaElTa60xnH7V19AAw==
X-CSE-MsgGUID: MkDWLjXrSmaOEPrCv7HE1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71759836"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="71759836"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 09:00:46 -0700
X-CSE-ConnectionGUID: PvX2astRSNynvuxcTo5Qqg==
X-CSE-MsgGUID: AJqZHiA2TlyrRO6Z9r5BLQ==
X-ExtLoop1: 1
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa003.fm.intel.com with ESMTP; 25 Sep 2025 09:00:43 -0700
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
Subject: [PATCH v2 bpf-next 1/3] xsk: avoid overwriting skb fields for multi-buffer traffic
Date: Thu, 25 Sep 2025 18:00:07 +0200
Message-Id: <20250925160009.2474816-2-maciej.fijalkowski@intel.com>
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

We are unnecessarily setting a bunch of skb fields per each processed
descriptor, which is redundant for fragmented frames.

Let us set these respective members for first fragment only. To address
both paths that we have within xsk_build_skb(), move assignments onto
xsk_set_destructor_arg() and rename it to xsk_skb_init_misc().

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72e34bd2d925..01f258894fae 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -618,11 +618,16 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 	sock_wfree(skb);
 }
 
-static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
+static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
+			      u64 addr)
 {
 	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
 	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
+	skb->dev = xs->dev;
+	skb->priority = READ_ONCE(xs->sk.sk_priority);
+	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	XSKCB(skb)->num_descs = 0;
+	skb->destructor = xsk_destruct_skb;
 	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
 }
 
@@ -673,7 +678,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 
 		skb_reserve(skb, hr);
 
-		xsk_set_destructor_arg(skb, desc->addr);
+		xsk_skb_init_misc(skb, xs, desc->addr);
 	} else {
 		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
 		if (!xsk_addr)
@@ -757,7 +762,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_set_destructor_arg(skb, desc->addr);
+			xsk_skb_init_misc(skb, xs, desc->addr);
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct xsk_addr_node *xsk_addr;
@@ -826,14 +831,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
 				skb->skb_mstamp_ns = meta->request.launch_time;
+			xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 		}
 	}
 
-	skb->dev = dev;
-	skb->priority = READ_ONCE(xs->sk.sk_priority);
-	skb->mark = READ_ONCE(xs->sk.sk_mark);
-	skb->destructor = xsk_destruct_skb;
-	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.43.0


