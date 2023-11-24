Return-Path: <bpf+bounces-15803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3D77F712E
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 11:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266571F20EF1
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 10:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99FC199B8;
	Fri, 24 Nov 2023 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJyJbOmO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5E18026;
	Fri, 24 Nov 2023 10:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F46FC433C8;
	Fri, 24 Nov 2023 10:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700821017;
	bh=uKHj27pgxPKnUs9P/LiD5S+Q9YM+KGgU4rETYT0qdng=;
	h=Subject:From:To:Cc:Date:From;
	b=uJyJbOmOBAibq3lA951l5hET3O2sE8fzfV75AQYGk3H2bxqGz7Xv2SxHJ/DI4YNm/
	 wNTq1fggFPjfN2hAdKJnMdsvYY27z5uRUlJbKAB19E9N6t8lc/pgjede+HuFQcGAbi
	 uu04iISyY1d3wEEvV9n5EuHN94Vgv3q08U2fYdJIBuZnbQ7ncb4rrUY/zG0yoggeZ2
	 9h9s6MFcDBq4EjJ8QRCphmPnrUnSyhKBLfrjL2NExugpifkB3J8oCgeiMSIboO3oh0
	 j+aPZoaJh86dQC5FJiYPzCzCjhiktBWxW0uCxz0hh4KNQebiN7ROVJrws3+0FwrKBH
	 MHNOug/BVDNDA==
Subject: [PATCH net-next] mm/page_pool: catch page_pool memory leaks
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, vbabka@suse.cz
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@techsingularity.net>,
 Matthew Wilcox <willy@infradead.org>, kernel-team@cloudflare.com
Date: Fri, 24 Nov 2023 11:16:52 +0100
Message-ID: <170082101266.1085481.12199867179160710331.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Pages belonging to a page_pool (PP) instance must be freed through the
PP APIs in-order to correctly release any DMA mappings and release
refcnt on the DMA device when freeing PP instance. When PP release a
page (page_pool_release_page) the page->pp_magic value is cleared.

This patch detect a leaked PP page in free_page_is_bad() via
unexpected state of page->pp_magic value being PP_SIGNATURE.

We choose to report and treat it as a bad page. It would be possible
to release the page via returning it to the PP instance as the
page->pp pointer is likely still valid.

Notice this code is only activated when either compiled with
CONFIG_DEBUG_VM or boot cmdline debug_pagealloc=on, and
CONFIG_PAGE_POOL.

Reduced example output of leak with PP_SIGNATURE = dead000000000040:

 BUG: Bad page state in process swapper/4  pfn:141fa6
 page:000000006dbf8062 refcount:0 mapcount:0 mapping:0000000000000000 index:0x141fa6000 pfn:0x141fa6
 flags: 0x2fffff80000000(node=0|zone=2|lastcpupid=0x1fffff)
 page_type: 0xffffffff()
 raw: 002fffff80000000 dead000000000040 ffff88814888a000 0000000000000000
 raw: 0000000141fa6000 0000000000000001 00000000ffffffff 0000000000000000
 page dumped because: page_pool leak
 [...]
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x32/0x50
  bad_page+0x70/0xf0
  free_unref_page_prepare+0x263/0x430
  free_unref_page+0x34/0x130
  mlx5e_free_rx_mpwqe+0x190/0x1c0 [mlx5_core]
  mlx5e_post_rx_mpwqes+0x1ac/0x280 [mlx5_core]
  mlx5e_napi_poll+0x12b/0x710 [mlx5_core]
  ? skb_free_head+0x4f/0x90
  __napi_poll+0x2b/0x1c0
  net_rx_action+0x27b/0x360

The advantage is the Call Trace directly points to the function
leaking the PP page, which in this case is an on purpose bug
introduced into the mlx5 driver to test this code change.

Currently PP will periodically in page_pool_release_retry()
printk warning "stalled pool shutdown" which cannot be directly
corrolated to leaking and might as well be a false positive
due to SKBs being stuck on a socket for an extended period.
After this patch we should be able to remove this printk.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 mm/page_alloc.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..37ca4f4b62bf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -915,6 +915,9 @@ static inline bool page_expected_state(struct page *page,
 			page_ref_count(page) |
 #ifdef CONFIG_MEMCG
 			page->memcg_data |
+#endif
+#ifdef CONFIG_PAGE_POOL
+			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
 #endif
 			(page->flags & check_flags)))
 		return false;
@@ -941,6 +944,10 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
 #ifdef CONFIG_MEMCG
 	if (unlikely(page->memcg_data))
 		bad_reason = "page still charged to cgroup";
+#endif
+#ifdef CONFIG_PAGE_POOL
+	if (unlikely((page->pp_magic & ~0x3UL) == PP_SIGNATURE))
+		bad_reason = "page_pool leak";
 #endif
 	return bad_reason;
 }



