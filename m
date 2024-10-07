Return-Path: <bpf+bounces-41112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DB0992BB5
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 14:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB4D1C22D43
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC31B1D4325;
	Mon,  7 Oct 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jx9OVtQe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8A1D3640;
	Mon,  7 Oct 2024 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303923; cv=none; b=S4LmnReN7FGJz0xXv41tJg88wBiw2FRWGk5BpqSHkvBg7uPbFldZZKgMF308rZhY+lkJgG6RKh/RHpufr2/XatfvNG9ziKLBGuAP9ZsEOU2YHYqf+El51e1Cw6+OhlgWQP2bXZeIUn5M2wZ8ICCJFiAvgW8jRmcfOmdawBdoeYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303923; c=relaxed/simple;
	bh=U7tNzbhI7z63cKaK1ajHEzbuxNm1oQWVdEKIsF+aYdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcNCfpncwJ6wAjyEnzSHwpNyBAUiVL3uifJR7YD2UYwgTu2zCU4NULU1LljA6/pm1lWFj1szS/TKbMBZPLhFwAfxWVqp2/DzgMecIOkKNFwxKJ+keJPdRpR04rZsv301lxgqg0G48Y+tq7MnF/Hc7s+kcq57dfd0vjKYbexOKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jx9OVtQe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303921; x=1759839921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U7tNzbhI7z63cKaK1ajHEzbuxNm1oQWVdEKIsF+aYdk=;
  b=jx9OVtQePP5UNUViKFbACYG+dVmSsopAzEPWf5E2LHceZNg0ia+62C7M
   zaMFbH7UYdL5yv0C44uviSFfxpW/Nwu5mn1yx61w6trsnaWg99ezwgK+y
   bV+RLh/QBJBnK8YERp1r3LWA63Ftm06LibJMrzxRGQclXA6KPIy4YYfPU
   SUmDy8J1c5dNAU4+A22ZfLe7SbrQAS6OtV3/cDi9jnfB1b0LpEttmBz/C
   +dJ+Gnd1yS0Dp6Y2iG3U0jowVp0FcNC6uWOkB8eiX0r6JWQauzyj/2NXx
   zzJF3C5Kbz5utPS0+h/AertA9r0adVFnAcp48lUH7VhNkJr1w5cK6O89s
   w==;
X-CSE-ConnectionGUID: UN18zyioTYSg1JqIbgtZVw==
X-CSE-MsgGUID: qMoABDiQTMytbr3pCJPArw==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15066387"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15066387"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:25:19 -0700
X-CSE-ConnectionGUID: 5nVVT1qIQpeBWndU+QPwDw==
X-CSE-MsgGUID: wR5s/M/gTea3YTXkBYlW2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80251019"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa005.jf.intel.com with ESMTP; 07 Oct 2024 05:25:16 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	vadfed@meta.com
Subject: [PATCH v2 bpf-next 6/6] xsk: use xsk_buff_pool directly for cq functions
Date: Mon,  7 Oct 2024 14:24:58 +0200
Message-Id: <20241007122458.282590-7-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
References: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
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


