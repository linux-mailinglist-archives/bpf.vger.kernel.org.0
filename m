Return-Path: <bpf+bounces-43260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BB9B21D1
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 02:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D8B1C20E7D
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 01:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7245513B286;
	Mon, 28 Oct 2024 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gErwT3Bo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD4A8BEC;
	Mon, 28 Oct 2024 01:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730077747; cv=none; b=KhrgK31D2h6YgbCPXolp3TSE9H1AHncEPLnD1rxEa820pWqMp3UiYbzifauN78t0Oj9OjU+qX8pUR+ZJHdBUN7bk2/EdnPZgVU+ogkWFg16RTN2Yn9L6w4C02vRwMitDtBRHjW9CNI1wR3XdMz4xfF1M1aM5NcfnysRFQ69T3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730077747; c=relaxed/simple;
	bh=cLHlFgsTefJ/63cMxsPXUMnfpmoCzVWJwou//7LsYNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WAKIAP6wsHuXWcBM67eHpyMIqL/XCr5TOVeXiarlyYjVN6ZRqL36ZSL+IoEXjPo1uoWPC13s4p+riZ/PgMdNcGxX+mEsiPfLdTaxeUKOiI+Z0Z7M9fEJu3Ph6NE3KlIjaTR1D1vdcswi9U/aYYPiXb07GuccmTGFonwcufIgOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gErwT3Bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5625EC4CEC3;
	Mon, 28 Oct 2024 01:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730077746;
	bh=cLHlFgsTefJ/63cMxsPXUMnfpmoCzVWJwou//7LsYNw=;
	h=From:To:Cc:Subject:Date:From;
	b=gErwT3Bohbwn/Qs4nZQrC6/plN8hPUAEzZyFdUnMgUIUqTUPjxWcD7YB9PKdeAWeF
	 /aFgyBgP+3e+NJOOCxJsRO31EIHGiT3QtU7SY6/n3vwkWJsViVAW6tBUXvD3teHE4g
	 QSvSYRP0xW1MkYuxGpJ/SJSQzvh5+U7IoVNmIhTPNwbvH9nMjaDpD852M5smDN+8XT
	 z4higS6hVwHgvS8dIpOtc5Gn7gx0X2xHLVA0q72y5WY7wtsvlo9cfRrsUd+fbKdrNg
	 gI6Ifdd54lkGARG2BRQ1cCrPQyEcQXaUSm7OWgBLItuJcymqg4vPaXa0mwX4d03DfR
	 YKvLOq6xH89rA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	peterz@infradead.org
Cc: oleg@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	mjguzik@gmail.com,
	brauner@kernel.org,
	jannh@google.com,
	mhocko@kernel.org,
	vbabka@suse.cz,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	arnd@arndb.de,
	richard.weiyang@gmail.com,
	zhangpeng.00@bytedance.com,
	linmiaohe@huawei.com,
	viro@zeniv.linux.org.uk,
	hca@linux.ibm.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 tip/perf/core 0/4] uprobes,mm: speculative lockless VMA-to-uprobe lookup
Date: Sun, 27 Oct 2024 18:08:14 -0700
Message-ID: <20241028010818.2487581-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement speculative (lockless) resolution of VMA to inode to uprobe,
bypassing the need to take mmap_lock for reads, if possible. First two patches
by Suren adds mm_struct helpers that help detect whether mm_struct was
changed, which is used by uprobe logic to validate that speculative results
can be trusted after all the lookup logic results in a valid uprobe instance.

Patch #3 is a simplification to uprobe VMA flag checking, suggested by Oleg.

And, finally, patch #4 is the speculative VMA-to-uprobe resolution logic
itself, and is the focal point of this patch set. It makes entry uprobes in
common case scale very well with number of CPUs, as we avoid any locking or
cache line bouncing between CPUs. See corresponding patch for details and
benchmarking results.

Note, this patch set assumes that FMODE_BACKING files were switched to have
SLAB_TYPE_SAFE_BY_RCU semantics, which was recently done by Christian Brauner
in [0]. This change can be pulled into perf/core through stable
tags/vfs-6.13.for-bpf.file tag from [1].

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.13.for-bpf.file&id=8b1bc2590af61129b82a189e9dc7c2804c34400e
  [1] git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git

v3->v4:
- rebased and dropped data_race(), given mm_struct uses real seqcount (Peter);
v2->v3:
- dropped kfree_rcu() patch (Christian);
- added data_race() annotations for fields of vma and vma->vm_file which could
  be modified during speculative lookup (Oleg);
- fixed int->long problem in stubs for mmap_lock_speculation_{start,end}(),
  caught by Kernel test robot;
v1->v2:
- adjusted vma_end_write_all() comment to point out it should never be called
  manually now, but I wasn't sure how ACQUIRE/RELEASE comments should be
  reworded (previously requested by Jann), so I'd appreciate some help there
  (Jann);
- int -> long change for mm_lock_seq, as agreed at LPC2024 (Jann, Suren, Liam);
- kfree_rcu_mightsleep() for FMODE_BACKING (Suren, Christian);
- vm_flags simplification in find_active_uprobe_rcu() and
  find_active_uprobe_speculative() (Oleg);
- guard(rcu)() simplified find_active_uprobe_speculative() implementation.

Andrii Nakryiko (2):
  uprobes: simplify find_active_uprobe_rcu() VMA checks
  uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution

Suren Baghdasaryan (2):
  mm: Convert mm_lock_seq to a proper seqcount
  mm: Introduce mmap_lock_speculation_{begin|end}

 include/linux/mm.h               | 12 ++---
 include/linux/mm_types.h         |  7 ++-
 include/linux/mmap_lock.h        | 87 ++++++++++++++++++++++++--------
 kernel/events/uprobes.c          | 47 ++++++++++++++++-
 kernel/fork.c                    |  5 +-
 mm/init-mm.c                     |  2 +-
 tools/testing/vma/vma.c          |  4 +-
 tools/testing/vma/vma_internal.h |  4 +-
 8 files changed, 129 insertions(+), 39 deletions(-)

-- 
2.43.5


