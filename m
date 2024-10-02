Return-Path: <bpf+bounces-40771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D757D98DFEA
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792BB1F279F7
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACCA1D0F7C;
	Wed,  2 Oct 2024 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOeRx1gJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19C1D0E02;
	Wed,  2 Oct 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884499; cv=none; b=tkYSlenX2yIH8df1KbB1Nzjpayu8M6hDENjb94rBXM5Md1OkpHjoRHIwsGSOlun3CF8DBroqURzou4ekKyR6EHHveVh/cpigfH9ITe6ec4jrsF42EPWFOP9TLEtX27ZLUHC0u8We/nNjIWo/MK6lIEB+ZFCJ32mH3seHat/pHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884499; c=relaxed/simple;
	bh=U7tNzbhI7z63cKaK1ajHEzbuxNm1oQWVdEKIsF+aYdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aU+3+TulL5bW9pDdLqfKgbP6y/1U0FhzX7veeNwnzRy5zvocxX6ajR4MebZN5uwjirYerBXVd5IphKzmdQHd5Y2z+xcDuWzvQz9YLHfFLT9MUZeOp6ztcmXdsL02VJTHIUeiUKfwljhcWc+OTrnm2P7W0lVuTGAME3+ZBdOeaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOeRx1gJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727884499; x=1759420499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7tNzbhI7z63cKaK1ajHEzbuxNm1oQWVdEKIsF+aYdk=;
  b=LOeRx1gJqjesDoS5My8raloUBaTcVwskzx4PxFhQlKMGMFV8uG/TTy/Q
   HNJ0fHZzUkPjJalEBQqraUEzl5lipPik8NpJps46xQqs6T8ATBXLPLHVJ
   9cdctkgwr8Aozn2DMrului3spHkDTVmqL/dDMZHR2x12XtdjhD/Oza0mB
   7soz1zeYJ7pnZN5UnB8cC8wTivX3At2or4C5sVLfH+TJr5t/ftQrfN29t
   pReo6Qosf3thCUJkTZ2akVXMpQAw2PDTTNEJqVPBrK7/LG/EazBlfzhA2
   WHEXNBDcqBDuE9Sf+jW5cRG39iM5Amh2083c+V5AEsC/iHt9aTax+zj/d
   w==;
X-CSE-ConnectionGUID: 13NMpBgkQA2eyCZWAGCpLQ==
X-CSE-MsgGUID: iNqNeRkzRVCSYUDsz0+9vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30762991"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30762991"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 08:54:58 -0700
X-CSE-ConnectionGUID: RFIfentOSj+Ezfut3WZc2Q==
X-CSE-MsgGUID: rjBVhJSHTcGwJIXFDhWGpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="73628798"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 02 Oct 2024 08:54:55 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next 6/6] xsk: use xsk_buff_pool directly for cq functions
Date: Wed,  2 Oct 2024 17:54:41 +0200
Message-Id: <20241002155441.253956-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
References: <20241002155441.253956-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently xsk_cq_{reserve_addr,submit,cancel}_locked() take xdp_sock as
an input argument but it is only used for pulling out xsk_buff_pool
pointer from it.

Change mentioned functions to take pool pointer as an input argument to
avoid unnecessary dereferences.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6c31c1de1619..7d7e37f53708 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -527,34 +527,34 @@ static int xsk_wakeup(struct xdp_sock *xs, u8 flags)
 	return dev->netdev_ops->ndo_xsk_wakeup(dev, xs->queue_id, flags);
 }
 
-static int xsk_cq_reserve_addr_locked(struct xdp_sock *xs, u64 addr)
+static int xsk_cq_reserve_addr_locked(struct xsk_buff_pool *pool, u64 addr)
 {
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&xs->pool->cq_lock, flags);
-	ret = xskq_prod_reserve_addr(xs->pool->cq, addr);
-	spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
+	spin_lock_irqsave(&pool->cq_lock, flags);
+	ret = xskq_prod_reserve_addr(pool->cq, addr);
+	spin_unlock_irqrestore(&pool->cq_lock, flags);
 
 	return ret;
 }
 
-static void xsk_cq_submit_locked(struct xdp_sock *xs, u32 n)
+static void xsk_cq_submit_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&xs->pool->cq_lock, flags);
-	xskq_prod_submit_n(xs->pool->cq, n);
-	spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
+	spin_lock_irqsave(&pool->cq_lock, flags);
+	xskq_prod_submit_n(pool->cq, n);
+	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
-static void xsk_cq_cancel_locked(struct xdp_sock *xs, u32 n)
+static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&xs->pool->cq_lock, flags);
-	xskq_prod_cancel_n(xs->pool->cq, n);
-	spin_unlock_irqrestore(&xs->pool->cq_lock, flags);
+	spin_lock_irqsave(&pool->cq_lock, flags);
+	xskq_prod_cancel_n(pool->cq, n);
+	spin_unlock_irqrestore(&pool->cq_lock, flags);
 }
 
 static u32 xsk_get_num_desc(struct sk_buff *skb)
@@ -571,7 +571,7 @@ static void xsk_destruct_skb(struct sk_buff *skb)
 		*compl->tx_timestamp = ktime_get_tai_fast_ns();
 	}
 
-	xsk_cq_submit_locked(xdp_sk(skb->sk), xsk_get_num_desc(skb));
+	xsk_cq_submit_locked(xdp_sk(skb->sk)->pool, xsk_get_num_desc(skb));
 	sock_wfree(skb);
 }
 
@@ -587,7 +587,7 @@ static void xsk_consume_skb(struct sk_buff *skb)
 	struct xdp_sock *xs = xdp_sk(skb->sk);
 
 	skb->destructor = sock_wfree;
-	xsk_cq_cancel_locked(xs, xsk_get_num_desc(skb));
+	xsk_cq_cancel_locked(xs->pool, xsk_get_num_desc(skb));
 	/* Free skb without triggering the perf drop trace */
 	consume_skb(skb);
 	xs->skb = NULL;
@@ -765,7 +765,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		xskq_cons_release(xs->tx);
 	} else {
 		/* Let application retry */
-		xsk_cq_cancel_locked(xs, 1);
+		xsk_cq_cancel_locked(xs->pool, 1);
 	}
 
 	return ERR_PTR(err);
@@ -802,7 +802,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 		 * if there is space in it. This avoids having to implement
 		 * any buffering in the Tx path.
 		 */
-		if (xsk_cq_reserve_addr_locked(xs, desc.addr))
+		if (xsk_cq_reserve_addr_locked(xs->pool, desc.addr))
 			goto out;
 
 		skb = xsk_build_skb(xs, &desc);
-- 
2.34.1


