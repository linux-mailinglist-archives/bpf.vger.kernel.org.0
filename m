Return-Path: <bpf+bounces-44058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD309BD354
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F61C283F78
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4FB1E2009;
	Tue,  5 Nov 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmlHde+T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE114A09A;
	Tue,  5 Nov 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827599; cv=none; b=m1VsZTQm+L5SsV39FdlwDtflqvr2aHDW5oEwaDnjBZVS8k23sbd07v6uk8+Hjav1vaMoqADM7jf5g5lLbdX4VLmKs/Z/iL9pUCn+zOcR2+w442Axb5wQzW0c+iRlT3EphoKrnjruB/F95g6b9O3x/img40m/bAuFhVLsCtGwXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827599; c=relaxed/simple;
	bh=ZL4Tzr/v6B3DvJYY2gHXZM8i7IVG7FX5tJlbCr+Y/hQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eFZWn6YBEXmSPB3G51zihHeLjUEKQnaI6mER+Sx6s0BD/HgWxtI4+uN0dUKj0dcBMECVkrh5lMcUR3jlF4pC6ur7dMfnc+B6ZBotqRKDaR8GdnoS6vuejS8QuWrXPbiDL/L4A2nT1PYMZlA4PuuCRopSEN4PI+ylsMbf9Wfh+Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmlHde+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB89C4CECF;
	Tue,  5 Nov 2024 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730827599;
	bh=ZL4Tzr/v6B3DvJYY2gHXZM8i7IVG7FX5tJlbCr+Y/hQ=;
	h=From:To:Cc:Subject:Date:From;
	b=dmlHde+TJ/R1N514E4YJ4gkxhmIJLRR7MLNTo9REKBTpw5XYgKqEWWyq1bUeR7Te5
	 On7kpqO/tiyGjqscmTn+KqaEup8QXn1KD9ENGBfacVKMjuNY4DkVZkuvnkD9LQk24w
	 Go2bwli4jB+MIzFgori6Oa1qkBqPdlQZPF0NJQv8XIgWo7fFp4MfkVBrjZvl/mZUQA
	 rE454EBdFDRncaaVCHh/QbFfT6gEsSC5/tl+n+LgEZMVuIqWHM5RYaq9LWN4fJZul+
	 Qf96UL99bZjbx7fLR+gIrhntEp1dx44Cd35nn2zXjYGnyQB/5oJQkmSHpknpXU0IUM
	 ki5DzbnDEDwnQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 0/4] perf lock contention: Symbolize locks using slab cache names (v1)
Date: Tue,  5 Nov 2024 09:26:31 -0800
Message-ID: <20241105172635.2463800-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to support symbolization of dynamic locks using slab
allocator's metadata.  The kernel support is in the bpf-next tree now.

It provides the new "kmem_cache" BPF iterator and "bpf_get_kmem_cache"
kfunc to get the information from an address.  The feature detection is
done using BTF type info and it won't have any effect on old kernels.

With this change, it can show locks in a slab object like below.  I
added "&" sign to distinguish them from global locks.

    # perf lock con -abl sleep 1
     contended   total wait     max wait     avg wait            address   symbol
  
             2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498   &task_struct (mutex)
             1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538   &task_struct (mutex)
             4      1.12 us       354 ns       279 ns   ffff9d5e841ca800   &kmalloc-cg-512 (mutex)
             2       859 ns       617 ns       429 ns   ffffffffa41c3620   delayed_uprobe_lock (mutex)
             3       691 ns       388 ns       230 ns   ffffffffa41c0940   pack_mutex (mutex)
             3       421 ns       164 ns       140 ns   ffffffffa3a8b3a0   text_mutex (mutex)
             1       409 ns       409 ns       409 ns   ffffffffa41b4cf8   tracepoint_srcu_srcu_usage (mutex)
             2       362 ns       239 ns       181 ns   ffffffffa41cf840   pcpu_alloc_mutex (mutex)
             1       220 ns       220 ns       220 ns   ffff9d5e82b534d8   &signal_cache (mutex)
             1       215 ns       215 ns       215 ns   ffffffffa41b4c28   tracepoint_srcu_srcu_usage (mutex)

The first two were from "task_struct" slab cache.  It happened to
match with the type name of object but there's no guarantee.  We need
to add type info to slab cache to resolve the lock inside the object.
Anyway, the third one has no dedicated slab cache and was allocated by
kmalloc.

Those slab objects can be used to filter specific locks using -L or
 --lock-filter option.

  # perf lock con -ab -L '&task_struct' sleep 1
     contended   total wait     max wait     avg wait         type   caller
  
             1     25.10 us     25.10 us     25.10 us        mutex   perf_event_exit_task+0x39
             1     21.60 us     21.60 us     21.60 us        mutex   futex_exit_release+0x21
             1      5.56 us      5.56 us      5.56 us        mutex   futex_exec_release+0x21

The code is available at 'perf/lock-slab-v1' branch in my tree

git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf lock contention: Add and use LCB_F_TYPE_MASK
  perf lock contention: Run BPF slab cache iterator
  perf lock contention: Resolve slab object name using BPF
  perf lock contention: Handle slab objects in -L/--lock-filter option

 tools/perf/builtin-lock.c                     |  39 ++++-
 tools/perf/util/bpf_lock_contention.c         | 141 +++++++++++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  70 ++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |  15 +-
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   8 +
 tools/perf/util/lock-contention.h             |   2 +
 6 files changed, 268 insertions(+), 7 deletions(-)

-- 
2.47.0.199.ga7371fff76-goog


