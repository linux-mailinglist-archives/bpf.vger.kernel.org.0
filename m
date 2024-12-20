Return-Path: <bpf+bounces-47398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B929F8C42
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 07:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E04E1896ABD
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 06:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6B199E89;
	Fri, 20 Dec 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5OlrtV/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE85B17C9E8;
	Fri, 20 Dec 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734674411; cv=none; b=t9B+fGAjW+magyi1Z3qKV1hdYT8wjtSknHv+eVzMkEsWnXL0VBhlQNweCLVCzeIpF1Yc+N3fJTox1pOUgU720L+1n9I3GN2F9BKr0xbb4r3b323gEECAfx3uThnjXiQ+o/9QG4v0nurN+R+kAztxaVEmPD1vixeA38n0Wz6a0+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734674411; c=relaxed/simple;
	bh=mWiyR94m75kJ5E5yxS5dfJyxZRiQUNAh3OgSJ0rR1nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grA//u9IMjbqfTeJ6I9+LhYW+S5zm4H7DR11+SNAil84DAQ4DXMznUVM97g2zQDdT50yLOl92fkVgbVuqkyzN+bsRkEmjp+L591NkCgxlJuxmhvRlUb/BKhjP1hPxo7vxrg/0OtvW9+CDnAGKVvZ7gHgK1TCqY8F0kGazp+0khc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5OlrtV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9736CC4CECD;
	Fri, 20 Dec 2024 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734674411;
	bh=mWiyR94m75kJ5E5yxS5dfJyxZRiQUNAh3OgSJ0rR1nE=;
	h=From:To:Cc:Subject:Date:From;
	b=R5OlrtV/VWEF84205jsonTn1PZeqbX9+T2nyVU8fzTK2E5CJSm1wBkRScHQ3uDHpu
	 IwvWEBjiZkq1EDSlmRJv0UTwohY2+9kLGdKomK1eRJGpyRa2I0VN1MI9lAm1zKlnmQ
	 cQepXQ0tdeXV3yseYnm9SnbTgnUV3bzkxm4gyr/qB3q68rI06YhGWF3sgOHKGm8eSl
	 /uIupZQ/uGQF1uWXhYAxildPKMzzRYzw/2gNbzgGMGJ7S9cPuMK9LR+1LSSn7c02O/
	 THuYYkgOY/3pjb0apUh/v1YCyOmoREJLq0vdKDYu/v5J/2rlbRjZo0JzeZfbTx1KZG
	 jem6Tb4M+NLcA==
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
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>
Subject: [PATCH v3 0/4] perf lock contention: Symbolize locks using slab cache names
Date: Thu, 19 Dec 2024 22:00:05 -0800
Message-ID: <20241220060009.507297-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to support symbolization of dynamic locks using slab
allocator's metadata.  The kernel support is merged to v6.13.

It provides the new "kmem_cache" BPF iterator and "bpf_get_kmem_cache"
kfunc to get the information from an address.  The feature detection is
done using BTF type info and it won't have any effect on old kernels.

v3 changes)

 * fix build error with GEN_VMLINUX_H=1  (Arnaldo)
 * update comment to explain slab cache ID  (Vlastimil)
 * add Ian's Acked-by

v2) https://lore.kernel.org/linux-perf-users/20241108061500.2698340-1-namhyung@kernel.org

 * don't use libbpf_get_error()  (Andrii)

v1) https://lore.kernel.org/linux-perf-users/20241105172635.2463800-1-namhyung@kernel.org

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
 --lock-filter option.  (It needs quotes to avoid special handling in
the shell).

    # perf lock con -ab -L '&task_struct' sleep 1
       contended   total wait     max wait     avg wait         type   caller

               1     25.10 us     25.10 us     25.10 us        mutex   perf_event_exit_task+0x39
               1     21.60 us     21.60 us     21.60 us        mutex   futex_exit_release+0x21
               1      5.56 us      5.56 us      5.56 us        mutex   futex_exec_release+0x21

The code is available at 'perf/lock-slab-v3' branch in my tree

git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf lock contention: Add and use LCB_F_TYPE_MASK
  perf lock contention: Run BPF slab cache iterator
  perf lock contention: Resolve slab object name using BPF
  perf lock contention: Handle slab objects in -L/--lock-filter option

 tools/perf/builtin-lock.c                     |  39 ++++-
 tools/perf/util/bpf_lock_contention.c         | 140 +++++++++++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  95 +++++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |  15 +-
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    |   8 +
 tools/perf/util/lock-contention.h             |   2 +
 6 files changed, 292 insertions(+), 7 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


