Return-Path: <bpf+bounces-74505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A73C5CD6D
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 12:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CD8D4E2F97
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 11:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106E30F7F7;
	Fri, 14 Nov 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz9waKKf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C8BE49
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119025; cv=none; b=okk2OB3vNjSeW7ppb1ZRryRLhrvpd0QoFZ8akedcHj+If8hF45rc2t08OMYNfXxsLG0vk5yatze1hOepxWieDWjjBo6EQIon3DNR61wYH53uUv0yV3knkeqTM2aDZXoVdgHYLbO6iyEk7+65tBQsjxxmtCzSdyUaywaqlLIpbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119025; c=relaxed/simple;
	bh=KmE44iO9fS6JPWsjJtOSw2bko77bzEZcH2chNUVsq1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rhn8zlXFOnssqoR2NWYao8CY13cPyulfDJ8nR/YaJTjHk2oZQ6Csh4TB6zP4gBYdx0qhCtSfTCCDglt4M8YNSbYmmxKOJaiYpWAicHgiU7CWiOI9ZMOxkiweDEzbDZ5Oc26R/jVhsIyITQr2x3jVg4wbrqFX1FUcCj4Vx3oNid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz9waKKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E563DC113D0;
	Fri, 14 Nov 2025 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763119025;
	bh=KmE44iO9fS6JPWsjJtOSw2bko77bzEZcH2chNUVsq1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=cz9waKKfTsbRagRmp2FNP8h59iK05lkxY+lcXE6Uz6VfK4W+aSbrrrK0AXPITcwwQ
	 58ddyLGBbG/eO2ch+JzWuDulV+ZcQz7dsO4l5F7ju2syuHlaKSzXVcp2CgRVFpo2r2
	 skOAT+lqaQXHbY1ssNMnuPasPUXXNZOHhSZO3HSZKxnBR3fMUlTE0tM/CL1JX/HBO1
	 SnXdyQ4QuInmEjHiaooKgXhk1mZdIJUkTE2egtyy1I2kArJJfP7POg5gHhSFjaVBuo
	 k3JQn9Blvaef/Ur0BKVuzVhY6M9FbaUAOVJQqkLNB4zSm/zkcW0gOM+Zk4/Dg7R5Cf
	 Jcrl+AaIvd1rw==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/4] Remove KF_SLEEPABLE from arena kfuncs
Date: Fri, 14 Nov 2025 11:16:55 +0000
Message-ID: <20251114111700.43292-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/all/20251111163424.16471-1-puranjay@kernel.org/
Changes in v1->v2:
Patch 1:
	- Import tlbflush.h to fix build issue in loongarch. (kernel
	  test robot)
	- Fix unused variable error in apply_range_clear_cb() (kernel
	  test robot)
	- Call bpf_map_area_free() on error path of
	  populate_pgtable_except_pte() (AI)
	- Use PAGE_SIZE in apply_to_existing_page_range() (AI)
Patch 2:
	- Cap allocation made by kmalloc_nolock() for pages array to
	  KMALLOC_MAX_CACHE_SIZE and reuse the array in an explicit loop
	  to overcome this limit. (AI)
Patch 3:
	- Do page_ref_add(page, 1); under the spinlock to mitigate a
	  race (AI)
Patch 4:
	- Add a new testcase big_alloc3() verifier_arena_large.c that
	  tries to allocate a large number of pages at once, this is to
	  trigger the kmalloc_nolock() limit in Patch 2 and see if the
	  loop logic works correctly.

This set allows arena kfuncs to be called from non-sleepable contexts.
It is acheived by the following changes:

The range_tree is now protected with a rqspinlock and not a mutex,
this change is enough to make bpf_arena_reserve_pages() any context
safe.

bpf_arena_alloc_pages() had four points where it could sleep:

1. Mutex to protect range_tree: now replaced with rqspinlock

2. kvcalloc() for allocations: now replaced with kmalloc_nolock()

3. Allocating pages with bpf_map_alloc_pages(): this already calls
   alloc_pages_nolock() in non-sleepable contexts and therefore is safe.

4. Setting up kernel page tables with vm_area_map_pages():
   vm_area_map_pages() may allocate memory while inserting pages into
   bpf arena's vm_area. Now, at arena creation time populate all page
   table levels except the last level and when new pages need to be
   inserted call apply_to_page_range() again which will only do
   set_pte_at() for those pages and will not allocate memory.

The above four changes make bpf_arena_alloc_pages() any context safe.

bpf_arena_free_pages() has to do the following steps:

1. Update the range_tree
2. vm_area_unmap_pages(): to unmap pages from kernel vm_area
3. flush the tlb: done in step 2, already.
4. zap_pages(): to unmap pages from user page tables
5. free pages.

The third patch in this set makes bpf_arena_free_pages() polymorphic using
the specialize_kfunc() mechanism. When called from a sleepable context,
arena_free_pages() remains mostly unchanged except the following:
1. rqspinlock is taken now instead of the mutex for the range tree
2. Instead of using vm_area_unmap_pages() that can free intermediate page
   table levels, apply_to_existing_page_range() with a callback is used
   that only does pte_clear() on the last level and leaves the intermediate
   page table levels intact. This is needed to make sure that
   bpf_arena_alloc_pages() can safely do set_pte_at() without allocating
   intermediate page tables.

When arena_free_pages() is called from a non-sleepable context or it fails to
acquire the rqspinlock in the sleepable case, a lock-less list of struct
arena_free_span is used to queue the uaddr and page cnt. kmalloc_nolock()
is used to allocate this arena_free_span, this can fail but we need to make
this trade-off for frees done from non-sleepable contexts.

arena_free_pages() then raises an irq_work whose handler in turn schedules
work that iterate this list and clears ptes, flushes tlbs, zap pages, and
frees pages for the queued uaddr and page cnts.

apply_range_clear_cb() with apply_to_existing_page_range() is used to
clear PTEs and collect pages to be freed, struct llist_node pcp_llist;
in the struct page is used to do this.

NOTE: The arena list selftest fails to load on s390x, this is due to an
unrelated bug in the verifier that is being exposed by the selftest that
I add in this set. I have already sent a patch[1] to fix this.

[1] https://lore.kernel.org/all/20251111160949.45623-1-puranjay@kernel.org/

Puranjay Mohan (4):
  bpf: arena: populate vm_area without allocating memory
  bpf: arena: use kmalloc_nolock() in place of kvcalloc()
  bpf: arena: make arena kfuncs any context safe
  selftests: bpf: test non-sleepable arena allocations

 include/linux/bpf.h                           |   2 +
 kernel/bpf/arena.c                            | 350 +++++++++++++++---
 kernel/bpf/verifier.c                         |   5 +
 .../selftests/bpf/prog_tests/arena_list.c     |  20 +-
 .../testing/selftests/bpf/progs/arena_list.c  |  11 +
 .../selftests/bpf/progs/verifier_arena.c      | 185 +++++++++
 .../bpf/progs/verifier_arena_large.c          |  24 ++
 7 files changed, 541 insertions(+), 56 deletions(-)

-- 
2.47.1


