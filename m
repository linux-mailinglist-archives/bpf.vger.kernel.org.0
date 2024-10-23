Return-Path: <bpf+bounces-42968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E0C9AD899
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274AD2841C8
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 23:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2501A7265;
	Wed, 23 Oct 2024 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UowA++Vs"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBA19F43B
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 23:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727308; cv=none; b=e7IP8GEJ5/vmcHkxOr6ywz0Hf7H6p/nnaXzL+wZX9cVqkMDWCFQUe0qwxnmwIa0rYRZQWEOIhDTXtH0uLWLMcBTleFMzkN9a1ZVM55mcKq0s1GpDjC2mOW42mqFpsae4aZ6E6BcLPDppn3jFQYH1V9UnkjxRNz7XDYgzV2ss4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727308; c=relaxed/simple;
	bh=43jGlvJEWYx4MNrKsSkFAljdsNf/e6Fh2yt+c+PoUow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tk67dZvlOZzlw3UCjh29OSG3oPYk15kkFpVNvNc1KS6HqR4Mv0s+mDAue8Vl1VEL5SMgiwJ97CM7UFPs8vIKiF5kgTPKz6OprnRw9YNjac25z38c3lmm3DHlmBlqFGCKUxLjC9K/ZaXbNxi90vfiNplY/MwWUz1USDFL9X5bCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UowA++Vs; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729727302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F4XbLdez416VM0dNBGezeehupchvQbkTZdjkI4ccTo0=;
	b=UowA++Vs+1Df+ouaaiOh08pgrI4OCH0ciFbMGn9HfAB0Or1Ugo9KKSMcCSyOAzNi2Eabh+
	EumUKyWYrCWX70ftnpEwiqyw11B+x6Dhlpi0OwG4krigdA63rj5dVoVwnBpkM8kFLFZULA
	K5fPNhmc4+xD3rIcCD9PUTpXLXgF3lc=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v6 bpf-next 00/12] Share user memory to BPF program through task storage map
Date: Wed, 23 Oct 2024 16:47:47 -0700
Message-ID: <20241023234759.860539-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

It is the v6 of this series. Starting from v5, it is a continuation work
of the RFC v4.

Changes in v6:
1. In patch 1, reject t->size == 0 in btf_check_and_fixup_fields.
   Reject a uptr pointing to an empty struct.

   A test is added to patch 12 to test this case.

2. In patch 6, when checking if the uptr struct spans across
   pages, there was an off by one error in calculating the "end" such
   that the uptr will be rejected by error if the object is located
   exactly at the end of a page.

   This is fixed by adding t->size "- 1" to "start".

   A test is added to patch 9 to test this case.

3. In patch 6, check for PageHighMem(page) and return -EOPNOTSUPP.
   The 32 bit arch jit is missing other crucial bpf features (e.g. kfunc).
   Patch 6 commit message has been updated to include this change.

4. The selftests are cleaned up such that  "struct user_data *dummy_data"
   global ptr is used instead of the whole "struct user_data  dummy_data"
   object. Still a hack to avoid generating fwd btf type for the
   uptr struct but somewhat lighter than a full blown global object.
	      
Changes in v5:
1. The original patch 1 and patch 2 are combined.
2. Patch 3, 4, and 5 are new. They get the bpf_local_storage
   ready to handle the __uptr in the map_value.
3. Patch 6 is mostly new, so I reset the sob.
4. There are some changes in the carry over patch 1 and 2 also. They
   are mentioned at the individual patch.
5. More tests are added.

The following is the original cover letter and the earlier change log.
The bpf prog example has been removed. Please find a similar
example in the selftests task_ls_uptr.c.

~~~~~~~~

Some of BPF schedulers (sched_ext) need hints from user programs to do
a better job. For example, a scheduler can handle a task in a
different way if it knows a task is doing GC. So, we need an efficient
way to share the information between user programs and BPF
programs. Sharing memory between user programs and BPF programs is
what this patchset does.

== REQUIREMENT ==

This patchset enables every task in every process to share a small
chunk of memory of it's own with a BPF scheduler. So, they can update
the hints without expensive overhead of syscalls. It also wants every
task sees only the data/memory belong to the task/or the task's
process.

== DESIGN ==

This patchset enables BPF prorams to embed __uptr; uptr in the values
of task storage maps. A uptr field can only be set by user programs by
updating map element value through a syscall. A uptr points to a block
of memory allocated by the user program updating the element
value. The memory will be pinned to ensure it staying in the core
memory and to avoid a page fault when the BPF program accesses it.

Please see the selftests task_ls_uptr.c for an example.

== MEMORY ==

In order to use memory efficiently, we don't want to pin a large
number of pages. To archieve that, user programs should collect the
memory blocks pointed by uptrs together to share memory pages if
possible. It avoid the situation that pin one page for each thread in
a process.  Instead, we can have several threads pointing their uptrs
to the same page but with different offsets.

Although it is not necessary, avoiding the memory pointed by an uptr
crossing the boundary of a page can prevent an additional mapping in
the kernel address space.

== RESTRICT ==

The memory pointed by a uptr should reside in one memory
page. Crossing multi-pages is not supported at the moment.

Only task storage map have been supported at the moment.

The values of uptrs can only be updated by user programs through
syscalls.

bpf_map_lookup_elem() from userspace returns zeroed values for uptrs
to prevent leaking information of the kernel.

---

Changes from v3:

 - Merge part 4 and 5 as the new part 4 in order to cease the warning
    of unused functions from CI.

Changes from v1:

 - Rename BPF_KPTR_USER to BPF_UPTR.

 - Restrict uptr to one page.

 - Mark uptr with PTR_TO_MEM | PTR_MAY_BE_NULL and with the size of
    the target type.

 - Move uptr away from bpf_obj_memcpy() by introducing
    bpf_obj_uptrcpy() and copy_map_uptr_locked().

 - Remove the BPF_FROM_USER flag.

 - Align the meory pointed by an uptr in the test case. Remove the
    uptr of mmapped memory.

Kui-Feng Lee (4):
  bpf: Support __uptr type tag in BTF
  bpf: Handle BPF_UPTR in verifier
  libbpf: define __uptr.
  selftests/bpf: Some basic __uptr tests

Martin KaFai Lau (8):
  bpf: Add "bool swap_uptrs" arg to bpf_local_storage_update() and
    bpf_selem_alloc()
  bpf: Postpone bpf_selem_free() in bpf_selem_unlink_storage_nolock()
  bpf: Postpone bpf_obj_free_fields to the rcu callback
  bpf: Add uptr support in the map_value of the task local storage.
  selftests/bpf: Test a uptr struct spanning across pages.
  selftests/bpf: Add update_elem failure test for task storage uptr
  selftests/bpf: Add uptr failure verifier tests
  selftests/bpf: Create task_local_storage map with invalid uptr's
    struct

 include/linux/bpf.h                           |  25 ++
 include/linux/bpf_local_storage.h             |  12 +-
 kernel/bpf/bpf_cgrp_storage.c                 |   4 +-
 kernel/bpf/bpf_inode_storage.c                |   4 +-
 kernel/bpf/bpf_local_storage.c                |  79 ++++-
 kernel/bpf/bpf_task_storage.c                 |   7 +-
 kernel/bpf/btf.c                              |  34 ++-
 kernel/bpf/syscall.c                          | 108 ++++++-
 kernel/bpf/verifier.c                         |  39 ++-
 net/core/bpf_sk_storage.c                     |   6 +-
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 .../bpf/prog_tests/task_local_storage.c       | 278 ++++++++++++++++++
 .../selftests/bpf/progs/task_ls_uptr.c        |  63 ++++
 .../selftests/bpf/progs/uptr_failure.c        | 105 +++++++
 .../selftests/bpf/progs/uptr_map_failure.c    |  27 ++
 .../selftests/bpf/progs/uptr_update_failure.c |  42 +++
 tools/testing/selftests/bpf/test_progs.h      |   8 +
 .../testing/selftests/bpf/uptr_test_common.h  |  63 ++++
 18 files changed, 862 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_uptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_map_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_update_failure.c
 create mode 100644 tools/testing/selftests/bpf/uptr_test_common.h

-- 
2.43.5


