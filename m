Return-Path: <bpf+bounces-38440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC82964DC8
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929D2284AA7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690F21B86FC;
	Thu, 29 Aug 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyHk0/X4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E091A148FF0;
	Thu, 29 Aug 2024 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956667; cv=none; b=kxLQ1LxivXjRfFEvwixLgZpwhCe6IJXPrpgIfpzATKolmkCFB3iDQlmgBLScJn7uA7WNUisuk0JYiwovva3m4DhP/hcsvalghm+I2ustxYEXZp5EZ9IxG17DDaDADbi7Oi+tOfr2gHtPs8ZlOs5tkRUj5ty3m1XmChRNtcR042s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956667; c=relaxed/simple;
	bh=Ptv8OhE5/Lgppev6KTOjJasYNP2CXH6imyCq3lrAJcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CuztlNS3CRgw84G3syMp47qXCrhuM2vwRSNV1Df9U0D0D8aMSC70c1gIBXWGbsmiXosoTae/9xIBfpWIBA9dJuKOO/i3yIgRL4OzAHGTB5M32zHvoSFHdDJdUWf+7XE+EZiRKTbn8kNKouNOyO3jWyKXugy7r4WAkykZe77kYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyHk0/X4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32115C4CEC1;
	Thu, 29 Aug 2024 18:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956666;
	bh=Ptv8OhE5/Lgppev6KTOjJasYNP2CXH6imyCq3lrAJcQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XyHk0/X47yMTdNNOaqpO+rVmtaaHZiv6P7uTdB1DnK9xXkcgfwl3ZMUJcjuafCC+V
	 hRJeOaR+Bu/Vb1pqo86R7CGk03TWtc4djU2OdvQO+YHLGzIjP3a5pGx7GPbhva8H/F
	 LSSf2XUl3XZK8STCMnZywqWvldtbWQ8NJvtZpCfjjP1o6dbx+HzTX/DMHXKIJzlIic
	 N8NCMi90UMSQJWaV1026XybPOU9h+ZZjf5dyuq83EWXA4HsDmgJLl8KQ4cBrU4wNS3
	 LBWmeOvZuCLPEa9JG9YlranFoUuxrOzxdhlHl9GhDspxIloJuOZCZsCLJVl/3geaq5
	 SBsz3R15nfN6Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v4 0/8] uprobes: RCU-protected hot path optimizations
Date: Thu, 29 Aug 2024 11:37:33 -0700
Message-ID: <20240829183741.3331213-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch set is heavily inspired by Peter Zijlstra's uprobe optimization
patches ([0]) and continues that work, albeit trying to keep complexity to the
minimum, and attepting to reuse existing primitives as much as possible. The
goal here is to optimize common uprobe triggering hot path, while keeping the
rest of locking mostly intact.

I've added uprobe_unregister_sync() into the error handling code path inside
uprobe_unregister(). This is due to recent refactorings from Oleg Nesterov
([1]), which necessitates this addition.

Except for refcounting change patch (which I stongly believe is a good
improvement we should do and forget about quasi-refcounting schema of
uprobe->consumers list), the rest of the changes are similar to Peter's
initial changes in [0].

Main differences would be:
  - no special RCU protection for mmap and fork handling, we just stick to
    refcounts there, as those are infrequent and not a performance-sensitive
    code path, while being complex and thus benefiting from proper locking;
  - the above means we don't need to do any custom SRCU additions to handle
    forking code path;
  - I handled UPROBE_HANDLER_REMOVE problem in handler_chain() differently,
    again, leveraging existing locking scheam;
  - I kept refcount usage for uretprobe and single-stepping uprobes, I plan to
    address that in a separate follow up patches. The plan is to avoid
    task_work with a lockless atomic xchg()/cmpxchg()-based solution;
  - finally, I dutifully was using SRCU throughout all the changes, and only
    last patch switches SRCU to RCU Tasks Trace and demonstrates significant
    performance and scalability gains from this.

The changes in this patch set were tested using BPF selftests and using
uprobe-stress ([2]) tool.

Now, for the benchmarking results. I've used the following script (which
utilizes BPF selftests-based bench tool). The CPU used was 80-core Intel Xeon
Gold 6138 CPU @ 2.00GHz running kernel with production-like config. I minimized
background noise by stopping any service I could identify and stop, so results
are pretty stable and variability is pretty small, overall.

Benchmark script:

#!/bin/bash

set -eufo pipefail

for i in uprobe-nop uretprobe-nop; do
    for p in 1 2 4 8 16 32 64; do
        summary=$(sudo ./bench -w3 -d5 -p$p -a trig-$i | tail -n1)
        total=$(echo "$summary" | cut -d'(' -f1 | cut -d' ' -f3-)
        percpu=$(echo "$summary" | cut -d'(' -f2 | cut -d')' -f1 | cut -d'/' -f1)
        printf "%-15s (%2d cpus): %s (%s/s/cpu)\n" $i $p "$total" "$percpu"
    done
    echo
done

With all the lock-avoiding changes done in this patch set, we get a pretty
decent improvement in performance and scalability of uprobes with number of
CPUs, even though we are still nowhere near linear scalability. This is due to
the remaining mmap_lock, which is currently taken to resolve interrupt address
to inode+offset and then uprobe instance. And, of course, uretprobes still need
similar RCU to avoid refcount in the hot path, which will be addressed in the
follow up patches.

BASELINE (on top of Oleg's clean up patches)
============================================
uprobe-nop      ( 1 cpus):    3.032 ± 0.023M/s  (  3.032M/s/cpu)
uprobe-nop      ( 2 cpus):    3.452 ± 0.005M/s  (  1.726M/s/cpu)
uprobe-nop      ( 4 cpus):    3.663 ± 0.005M/s  (  0.916M/s/cpu)
uprobe-nop      ( 8 cpus):    3.718 ± 0.038M/s  (  0.465M/s/cpu)
uprobe-nop      (16 cpus):    3.344 ± 0.008M/s  (  0.209M/s/cpu)
uprobe-nop      (32 cpus):    2.288 ± 0.021M/s  (  0.071M/s/cpu)
uprobe-nop      (64 cpus):    3.205 ± 0.004M/s  (  0.050M/s/cpu)

uretprobe-nop   ( 1 cpus):    1.979 ± 0.005M/s  (  1.979M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.361 ± 0.005M/s  (  1.180M/s/cpu)
uretprobe-nop   ( 4 cpus):    2.309 ± 0.002M/s  (  0.577M/s/cpu)
uretprobe-nop   ( 8 cpus):    2.253 ± 0.001M/s  (  0.282M/s/cpu)
uretprobe-nop   (16 cpus):    2.007 ± 0.000M/s  (  0.125M/s/cpu)
uretprobe-nop   (32 cpus):    1.624 ± 0.003M/s  (  0.051M/s/cpu)
uretprobe-nop   (64 cpus):    2.149 ± 0.001M/s  (  0.034M/s/cpu)

Up to second-to-last patch (i.e., SRCU-based optimizations)
===========================================================
uprobe-nop      ( 1 cpus):    3.276 ± 0.005M/s  (  3.276M/s/cpu)
uprobe-nop      ( 2 cpus):    4.125 ± 0.002M/s  (  2.063M/s/cpu)
uprobe-nop      ( 4 cpus):    7.713 ± 0.002M/s  (  1.928M/s/cpu)
uprobe-nop      ( 8 cpus):    8.097 ± 0.006M/s  (  1.012M/s/cpu)
uprobe-nop      (16 cpus):    6.501 ± 0.056M/s  (  0.406M/s/cpu)
uprobe-nop      (32 cpus):    4.398 ± 0.084M/s  (  0.137M/s/cpu)
uprobe-nop      (64 cpus):    6.452 ± 0.000M/s  (  0.101M/s/cpu)

uretprobe-nop   ( 1 cpus):    2.055 ± 0.001M/s  (  2.055M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.677 ± 0.000M/s  (  1.339M/s/cpu)
uretprobe-nop   ( 4 cpus):    4.561 ± 0.003M/s  (  1.140M/s/cpu)
uretprobe-nop   ( 8 cpus):    5.291 ± 0.002M/s  (  0.661M/s/cpu)
uretprobe-nop   (16 cpus):    5.065 ± 0.019M/s  (  0.317M/s/cpu)
uretprobe-nop   (32 cpus):    3.622 ± 0.003M/s  (  0.113M/s/cpu)
uretprobe-nop   (64 cpus):    3.723 ± 0.002M/s  (  0.058M/s/cpu)

RCU Tasks Trace
===============
uprobe-nop      ( 1 cpus):    3.396 ± 0.002M/s  (  3.396M/s/cpu)
uprobe-nop      ( 2 cpus):    4.271 ± 0.006M/s  (  2.135M/s/cpu)
uprobe-nop      ( 4 cpus):    8.499 ± 0.015M/s  (  2.125M/s/cpu)
uprobe-nop      ( 8 cpus):   10.355 ± 0.028M/s  (  1.294M/s/cpu)
uprobe-nop      (16 cpus):    7.615 ± 0.099M/s  (  0.476M/s/cpu)
uprobe-nop      (32 cpus):    4.430 ± 0.007M/s  (  0.138M/s/cpu)
uprobe-nop      (64 cpus):    6.887 ± 0.020M/s  (  0.108M/s/cpu)

uretprobe-nop   ( 1 cpus):    2.174 ± 0.001M/s  (  2.174M/s/cpu)
uretprobe-nop   ( 2 cpus):    2.853 ± 0.001M/s  (  1.426M/s/cpu)
uretprobe-nop   ( 4 cpus):    4.913 ± 0.002M/s  (  1.228M/s/cpu)
uretprobe-nop   ( 8 cpus):    5.883 ± 0.002M/s  (  0.735M/s/cpu)
uretprobe-nop   (16 cpus):    5.147 ± 0.001M/s  (  0.322M/s/cpu)
uretprobe-nop   (32 cpus):    3.738 ± 0.008M/s  (  0.117M/s/cpu)
uretprobe-nop   (64 cpus):    4.397 ± 0.002M/s  (  0.069M/s/cpu)

For baseline vs SRCU, peak througput increased from 3.7 M/s (million uprobe
triggerings per second) up to about 8 M/s. For uretprobes it's a bit more
modest with bump from 2.4 M/s to 5 M/s.

For SRCU vs RCU Tasks Trace, peak throughput for uprobes increases further from
8 M/s to 10.3 M/s (+28%!), and for uretprobes from 5.3 M/s to 5.8 M/s (+11%),
as we have more work to do on uretprobes side.

Even single-thread (no contention) performance is slightly better: 3.276 M/s to
3.396 M/s (+3.5%) for uprobes, and 2.055 M/s to 2.174 M/s (+5.8%)
for uretprobes.

  [0] https://lore.kernel.org/linux-trace-kernel/20240711110235.098009979@infradead.org/
  [1] https://lore.kernel.org/linux-trace-kernel/20240729134444.GA12293@redhat.com/
  [2] https://github.com/libbpf/libbpf-bootstrap/tree/uprobe-stress

v3->v4:
  - added back consumer_rwsem into consumer_del(), which was accidentally
    omitted earlier (Jiri);
  - left out RFC patches, we can continue discussion on v3 patch set, if
    necessary;
v2->v3:
  - undid rcu and rb_node fields colocation which were causing crashes (Oleg);
  - ensure synchronize_srcu() on registration failure in patch #4 (Oleg);
v1->v2:
  - added back missed kfree() in patch #1 (Oleg);
  - forgot the rest, but there were a few small things here and there.

Andrii Nakryiko (6):
  uprobes: revamp uprobe refcounting and lifetime management
  uprobes: protected uprobe lifetime with SRCU
  uprobes: get rid of enum uprobe_filter_ctx in uprobe filter callbacks
  uprobes: travers uprobe's consumer list locklessly under SRCU
    protection
  uprobes: perform lockless SRCU-protected uprobes_tree lookup
  uprobes: switch to RCU Tasks Trace flavor for better performance

Peter Zijlstra (2):
  perf/uprobe: split uprobe_unregister()
  rbtree: provide rb_find_rcu() / rb_find_add_rcu()

 include/linux/rbtree.h                        |  67 +++
 include/linux/uprobes.h                       |  20 +-
 kernel/events/uprobes.c                       | 391 +++++++++++-------
 kernel/trace/bpf_trace.c                      |   8 +-
 kernel/trace/trace_uprobe.c                   |  15 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   3 +-
 6 files changed, 321 insertions(+), 183 deletions(-)

-- 
2.43.5


