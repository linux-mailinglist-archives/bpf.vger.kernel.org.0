Return-Path: <bpf+bounces-74236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B19C4F104
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 17:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 499F64F7E00
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 16:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC73730C9;
	Tue, 11 Nov 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd4zi/2r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD583730C4
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878879; cv=none; b=QRYlQ6N7X5mxcFy9mTMvrDEnLztVd59FlsceXMNoetf8jlACfw59SzXFZQd/sdFJxWApjgLIAnrMXAsjspezF8+pIuYBR9QCjA82MXNY/4xVaZkGPAh7zvnpaRxmLbAipx+pXJhcMep4AGOenl06yeE5gVmbcMjyNupA+NBDWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878879; c=relaxed/simple;
	bh=oeJBKPnv+juHhlTpRN9o20JDAoZBM62CNi03e68TYUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFJo4pHlbB0ip8P+n6bLUMr1IueeQRlIzpLJ/iDLwWDMGsd3Uw5vC7mnU1ZzJANCEPqiwhItEY5xbA1j2XtjRISHBGjj1W+jeimxT/vvpSABuBlMMkVmBfqra83RZyjpkyLdA4crXYXP23Xp965ZxK4DErzJN/yWlWodR/l0rMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd4zi/2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619BFC4CEF5;
	Tue, 11 Nov 2025 16:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762878878;
	bh=oeJBKPnv+juHhlTpRN9o20JDAoZBM62CNi03e68TYUI=;
	h=From:To:Cc:Subject:Date:From;
	b=Dd4zi/2raCKKtsdtyTIJ8+Z+CZ+73D3d+RIhSDw/VPtOn0GD1dnzoWK86YSq3ElRU
	 uHGuSDa7PyoTPTyAq8zRhbgaWNp9sDQiZbuNXxEemhAm06ysDot9SJF4RQIvZBX8h0
	 MYV4UhJ5W9xIxy5A/LI14dev73QQlDLOLUQMkj1UJzcgPnD0IG1fV2KrxkHmTD5idv
	 64g+iGUmgYZhyoM2kqRbLU7bwmWk7oGotcdsByNdDLKRnUc1DEiGUhZ73usV+2udCb
	 Agsi9AjaemNanc/xwDTYPMCEhStUe1xYh67VyKDkAm9n84C4cDXCl97DVdyWAnpYH5
	 5KTUzWAUcHYmw==
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
Subject: [PATCH bpf-next 0/4] Remove KF_SLEEPABLE from arena kfuncs
Date: Tue, 11 Nov 2025 16:34:18 +0000
Message-ID: <20251111163424.16471-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
   vm_area_map_pages() may allocate memory while inserting pages into bpf
   arena's vm_area. Now, at arena creation time populate all page table
   levels except the last level when new pages need to be inserted call
   apply_to_page_range() again which will only set_pte_at() those pages and
   will not allocate memory.

The above four changes make bpf_arena_alloc_pages() any context safe.

bpf_arena_free_pages() has to do the following steps:

1. Update the range_tree
2. vm_area_unmap_pages(): to unmap pages from kernel vm_area
3. flush the tlb: done by 2, already.
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
this trade-off for frees done from non-sleepable context.

arena_free_pages() then raises an irq_work whose handler in turn schedules
work that iterate this list and clears ptes, flushes tlbs, zap pages, and
frees pages for the queued uaddr and page cnts.

apply_range_clear_cb() with apply_to_existing_page_range() is used to
clear PTEs and collect pages to be freed, struct llist_node pcp_llist;
in the struct page is used to do this.

The arena selftest fails to load on s390x, this is due to an unrelated
bug in the verifier that is being exposed by the selftest that I here. I
have already sent a patch[1] to fix this.


[1] https://lore.kernel.org/all/20251111160949.45623-1-puranjay@kernel.org/

Puranjay Mohan (4):
  bpf: arena: populate vm_area without allocating memory
  bpf: arena: use kmalloc_nolock() in place of kvcalloc()
  bpf: arena: make arena kfuncs any context safe
  selftests: bpf: test non-sleepable arena allocations

 include/linux/bpf.h                           |   2 +
 kernel/bpf/arena.c                            | 290 +++++++++++++++---
 kernel/bpf/verifier.c                         |   5 +
 .../selftests/bpf/prog_tests/arena_list.c     |  20 +-
 .../testing/selftests/bpf/progs/arena_list.c  |  11 +
 .../selftests/bpf/progs/verifier_arena.c      | 185 +++++++++++
 6 files changed, 472 insertions(+), 41 deletions(-)

-- 
2.47.3


