Return-Path: <bpf+bounces-76492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F550CB7778
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 01:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE2BB30194C5
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 00:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56122D785;
	Fri, 12 Dec 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJRbWnwN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A011DE4FB
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765500235; cv=none; b=aCkiLWjuQDVn1vEf60dOwflCf2J3Pj6A7YvzpTDrIZv5xMWItSoRE+fKiL6OA87XzrXp5TIExwX380xDShGxENmGyBMPbTR2AOZQmggg6+GG/TkGo+cDhE+cICu/+wirJK4cK4S6aRfPvw3RTRwTyLXhp+HnrujMM2skbQJ5UHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765500235; c=relaxed/simple;
	bh=4NthjeN47qyK4uSizVby4hU29PipYClYZYbKugdFdLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLLH1vdKiyr15A9ypO6nuqcvDYWGVC0LHIT5XfqENH5AfqnxHjUra41/efkhdwq54g3QceNfyHg7cFzPjToICBZK/dqhLA70c8q7n6K27/k0yfw2CNhFAvgDtPSgS2TqAst6ZTf1nLg7w5AFEQUFdYt2PRXPR3UaGdbGyC9b6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJRbWnwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD634C4CEF7;
	Fri, 12 Dec 2025 00:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765500235;
	bh=4NthjeN47qyK4uSizVby4hU29PipYClYZYbKugdFdLU=;
	h=From:To:Cc:Subject:Date:From;
	b=TJRbWnwNmwbpqbUd3ODwS/1iOKlY2rQj5U2JK4nfBLc0oH5XyRKiqOm6THU6kdJhL
	 q/+MdwRBZUKwLVSAPEvFaR+Inc8oGjUUgKMVmlrEs21M1r9J7EfVrbgype1rxHSpxy
	 i5TMK5n3iaN4Qc0vIEueBsEPNsKiKLQJXTijvRiA5I8XMo4pzl87Tpu7WTSsTc/OVn
	 sgta4cqlvB4PyD1+CfxTKl3VINj7A8UHjj1AuiFajnG07P07QC/2ZfN4jjtOAXMkAz
	 9PcNMSq7Nv6+9q+zpvHPgSOue4upOQc7vifzgtjv16rrh4BccolhFggMd/WOh9Y/ui
	 sthcOBchMBIjQ==
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
Subject: [PATCH bpf-next v4 0/4] Remove KF_SLEEPABLE from arena kfuncs
Date: Fri, 12 Dec 2025 09:43:45 +0900
Message-ID: <20251212004350.6520-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: https://lore.kernel.org/all/20251117160150.62183-1-puranjay@kernel.org/
Changes in v3->v4:
	- Coding style changes related to comments in Patch 2/3 (Alexei)

v2: https://lore.kernel.org/all/20251114111700.43292-1-puranjay@kernel.org/
Changes in v2->v3:
Patch 1:
        - Call range_tree_destroy() in error path of
          populate_pgtable_except_pte() in arena_map_alloc() (AI)
Patch 2:
        - Fix double mutex_unlock() in the error path of
          arena_alloc_pages() (AI)
        - Fix coding style issues (Alexei)
Patch 3:
        - Unlock spinlock before returning from arena_vm_fault() in case
          BPF_F_SEGV_ON_FAULT is set by user. (AI)
        - Use __llist_del_all() in place of llist_del_all for on-stack
          llist (free_pages) (Alexei)
        - Fix build issues on 32-bit systems where arena.c is not compiled.
          (kernel test robot)
        - Make bpf_arena_alloc_pages() polymorphic so it knows if it has
          been called in sleepable or non-sleepable context. This
          information is passed to arena_free_pages() in the error path.
Patch 4:
        - Add a better comment for the big_alloc3() test that triggers
          kmalloc_nolock()'s limit and if bpf_arena_alloc_pages() works
          correctly above this limit.

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

Puranjay Mohan (4):
  bpf: arena: populate vm_area without allocating memory
  bpf: arena: use kmalloc_nolock() in place of kvcalloc()
  bpf: arena: make arena kfuncs any context safe
  selftests: bpf: test non-sleepable arena allocations

 include/linux/bpf.h                           |  15 +
 kernel/bpf/arena.c                            | 365 +++++++++++++++---
 kernel/bpf/verifier.c                         |  10 +
 .../selftests/bpf/prog_tests/arena_list.c     |  20 +-
 .../testing/selftests/bpf/progs/arena_list.c  |  11 +
 .../selftests/bpf/progs/verifier_arena.c      | 185 +++++++++
 .../bpf/progs/verifier_arena_large.c          |  29 ++
 7 files changed, 576 insertions(+), 59 deletions(-)


base-commit: 759377dab35e404fc4f013e3f853d6e9450b4633
-- 
2.50.1


