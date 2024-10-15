Return-Path: <bpf+bounces-41899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E72BB99DAD1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F71F22AE9
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5531F931;
	Tue, 15 Oct 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tlcw6XFX"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1B1CF96
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953422; cv=none; b=cjj/qD0W5+5ybhRcQwnMeKEgYlK49xELFwLviBA+2F5e5F9x3sYFT2TfQDliuZ6cxpRwNBM1uOh36NExmNCk1k8ZU1Y1kz8QH6NTS9ZGlT6zCt5pKNOQSO2uxMaFROlpSu6IeTH5Tvf3sBOUqaWx+SKmlRmAGveteUxJCcu3sqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953422; c=relaxed/simple;
	bh=uy4oSYMtbLquBsveXWUJNJb8ACMVpKAuI+TB/25eLWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F+HG33QA2+DMBYKZUyGkL8Yss1+q4TgskM656n85ymaZ/pOTMY847J6db0AcfhCztSTGtQetMHsJpVqy+tqbDEXtwlPXWSnkS1wgCIlwinkwRijLWzNU5fJ8sKSBzhyv5MAs1JSGqUZotmL3B2vkLKYn8qAtBK8vKSoziyFjmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tlcw6XFX; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DUjqB5nvTxVDH3tgLlCXUELaNJgU5gbccBeU7BehdfY=;
	b=tlcw6XFXo7Mn2+/BoDgh0rdRvpv+Nt1yFdZEjG2KXQuwfLdmdCLQirudVO1SzenhzPVT9c
	hvwIlO0+dt6ZAaE62sPXAwP6Bk9NTnvDkr+cu2La7HIfYh2z28Hgy6f0N5ZM8SMi4CuR8a
	5qYd51ydvITCDdXvVTdPgBr1Ka/ge2s=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 00/12] Share user memory to BPF program through task storage map
Date: Mon, 14 Oct 2024 17:49:50 -0700
Message-ID: <20241015005008.767267-1-martin.lau@linux.dev>
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

This v5 series is a continuation work of the RFC v4. Some major changes:

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
 kernel/bpf/bpf_local_storage.c                |  79 +++--
 kernel/bpf/bpf_task_storage.c                 |   7 +-
 kernel/bpf/btf.c                              |  32 ++-
 kernel/bpf/syscall.c                          | 101 ++++++-
 kernel/bpf/verifier.c                         |  39 ++-
 net/core/bpf_sk_storage.c                     |   6 +-
 tools/lib/bpf/bpf_helpers.h                   |   1 +
 .../bpf/prog_tests/task_local_storage.c       | 272 ++++++++++++++++++
 .../selftests/bpf/progs/task_ls_uptr.c        |  69 +++++
 .../selftests/bpf/progs/uptr_failure.c        | 121 ++++++++
 .../selftests/bpf/progs/uptr_map_failure.c    |  49 ++++
 .../selftests/bpf/progs/uptr_update_failure.c |  44 +++
 tools/testing/selftests/bpf/test_progs.h      |   8 +
 .../testing/selftests/bpf/uptr_test_common.h  |  53 ++++
 18 files changed, 883 insertions(+), 43 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_uptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_map_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/uptr_update_failure.c
 create mode 100644 tools/testing/selftests/bpf/uptr_test_common.h

-- 
2.43.5


