Return-Path: <bpf+bounces-44098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F1D9BDC84
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 03:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFAC283BED
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D701E25F8;
	Wed,  6 Nov 2024 02:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRIuiFbD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6DF1D0F56;
	Wed,  6 Nov 2024 02:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859168; cv=none; b=HwqNS0dqfqSNMKvx/PcNnAVnb9/ggsJmqVE7BM5momm3jbIMaWv/+qMKIjR+kL36tunqmA8+l7MFb7wjRgtFuEhOaIbf08d6lwHEA0Qy0cXvojQDdZpyKo3gtUF8H0sXn28v6jYSTyCNLpWi0Eg81sehHQ+DNJnvq/rdFPN/EOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859168; c=relaxed/simple;
	bh=2o1BZqFvRH5tNGMpGOTU38S45OqjdSIjDmHM0nXBnAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhwhLnaZMw5y9xdy7UqSEhTWYw7R538BXnHJ093j24hcG3KEW0zFGW5j1avo92PXcu9q7KaSHhwLkr0/UMxYlAj5woRCKKCG4IxYIExkVWgcyhhAocqf3oLMV3BNLojgFU8pyfe2hensp6U1P41Wx8t6cfr3cVyDYaeCXxfR+rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRIuiFbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3C7C4CECF;
	Wed,  6 Nov 2024 02:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859167;
	bh=2o1BZqFvRH5tNGMpGOTU38S45OqjdSIjDmHM0nXBnAI=;
	h=From:To:Cc:Subject:Date:From;
	b=cRIuiFbDeN2660gQPau2yy94PiSdT+0hkuAli5AZNjZMUqSgxDLBeALvLC2tkc9ds
	 SpwIZ70NLky+z+dzec9In22gfyUDlEgvQ9vdniadIJ4WdEwqPzcCOkRHrneEVgVVdo
	 LAhntl9q4KAFqHUdejqlexexdhUXrvSAxYPFzrhgPGeUjrKypLmMQB5Ki09qd1RaKy
	 cCkuu6q1vmWYRopKfLAxsW+OEWvLBa5nYFrKfpb0V74vBXQbIDBS93cEKETP+RRE1Z
	 5Bf1brwSXVks1WMW2/+fB1B6WZ5ueATKbbXBmOIEIIKyQLKyo0PBwJRuTbcTNF81Ky
	 yb8dFQJTjNsdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	mfleming@cloudflare.com
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: FAILED: Patch "mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves" failed to apply to v5.10-stable tree
Date: Tue,  5 Nov 2024 21:12:44 -0500
Message-ID: <20241106021244.183133-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 281dd25c1a018261a04d1b8bf41a0674000bfe38 Mon Sep 17 00:00:00 2001
From: Matt Fleming <mfleming@cloudflare.com>
Date: Fri, 11 Oct 2024 13:07:37 +0100
Subject: [PATCH] mm/page_alloc: let GFP_ATOMIC order-0 allocs access
 highatomic reserves

Under memory pressure it's possible for GFP_ATOMIC order-0 allocations to
fail even though free pages are available in the highatomic reserves.
GFP_ATOMIC allocations cannot trigger unreserve_highatomic_pageblock()
since it's only run from reclaim.

Given that such allocations will pass the watermarks in
__zone_watermark_unusable_free(), it makes sense to fallback to highatomic
reserves the same way that ALLOC_OOM can.

This fixes order-0 page allocation failures observed on Cloudflare's fleet
when handling network packets:

  kswapd1: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
  nodemask=(null),cpuset=/,mems_allowed=0-7
  CPU: 10 PID: 696 Comm: kswapd1 Kdump: loaded Tainted: G           O 6.6.43-CUSTOM #1
  Hardware name: MACHINE
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x3c/0x50
   warn_alloc+0x13a/0x1c0
   __alloc_pages_slowpath.constprop.0+0xc9d/0xd10
   __alloc_pages+0x327/0x340
   __napi_alloc_skb+0x16d/0x1f0
   bnxt_rx_page_skb+0x96/0x1b0 [bnxt_en]
   bnxt_rx_pkt+0x201/0x15e0 [bnxt_en]
   __bnxt_poll_work+0x156/0x2b0 [bnxt_en]
   bnxt_poll+0xd9/0x1c0 [bnxt_en]
   __napi_poll+0x2b/0x1b0
   bpf_trampoline_6442524138+0x7d/0x1000
   __napi_poll+0x5/0x1b0
   net_rx_action+0x342/0x740
   handle_softirqs+0xcf/0x2b0
   irq_exit_rcu+0x6c/0x90
   sysvec_apic_timer_interrupt+0x72/0x90
   </IRQ>

[mfleming@cloudflare.com: update comment]
  Link: https://lkml.kernel.org/r/20241015125158.3597702-1-matt@readmodwrite.com
Link: https://lkml.kernel.org/r/20241011120737.3300370-1-matt@readmodwrite.com
Link: https://lore.kernel.org/all/CAGis_TWzSu=P7QJmjD58WWiu3zjMTVKSzdOwWE8ORaGytzWJwQ@mail.gmail.com/
Fixes: 1d91df85f399 ("mm/page_alloc: handle a missing case for memalloc_nocma_{save/restore} APIs")
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/page_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc4..94a2ffe280089 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2893,12 +2893,12 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
 
 			/*
-			 * If the allocation fails, allow OOM handling access
-			 * to HIGHATOMIC reserves as failing now is worse than
-			 * failing a high-order atomic allocation in the
-			 * future.
+			 * If the allocation fails, allow OOM handling and
+			 * order-0 (atomic) allocs access to HIGHATOMIC
+			 * reserves as failing now is worse than failing a
+			 * high-order atomic allocation in the future.
 			 */
-			if (!page && (alloc_flags & ALLOC_OOM))
+			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 
 			if (!page) {
-- 
2.43.0





