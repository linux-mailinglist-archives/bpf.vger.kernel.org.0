Return-Path: <bpf+bounces-69034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3BCB8BB7B
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 02:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC97C1C218D8
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429341DD543;
	Sat, 20 Sep 2025 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQsK3vz8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4691189;
	Sat, 20 Sep 2025 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329974; cv=none; b=udJdpm3cUgtclpAk/SvHAplJLd4GEvYleq2NIgPxjsLQrN7daTguqTg+IM3rtfmeRJ/Vr1Mm0BOBiEFkWpqPXfU7zDKv5B1UiNbUrhT9YImgNl48B4Vg1nMOoKkiv3a0NTNLPremfx5ZZ1NskI/ytasoNemrX4o58p5wYnw4Dac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329974; c=relaxed/simple;
	bh=7f3fbvQTyEsq18CdpsqT2qA5MjINTgb5ovRcNITX7Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xl3EFU2rxrft6mDTPVeWVdGepL8kFSEdzmTDUOZIjvqnMVkSG7HWIiPiIEsKC11ATWi0Tm2YAJVQJK4cVJyc4OXganc6D/B71NL1tu5nSSH2esby/ZsyW1q2L9ziiK/WNqB0POwczw6a/SVNsYOggvVKhltapGQxZ6pUkupjPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQsK3vz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190A8C4CEF0;
	Sat, 20 Sep 2025 00:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329974;
	bh=7f3fbvQTyEsq18CdpsqT2qA5MjINTgb5ovRcNITX7Nk=;
	h=From:To:Cc:Subject:Date:From;
	b=AQsK3vz8IPO8dvtJ4YpLrCer74PXijKhmPig9lsu1Cz/P22QlVSIXbZ9snZ95/N+c
	 TpVVXmtVFmEBCHg3T2IVY+jxijRNo48rpbI1u/ic4ISnCSyNEPHXJTrHYR0ZnediYt
	 +mrpS3igGZC5hgB37IYr3YuB3z6p4yrBiBpyAGNq4YPzyFRlLJ3LAbU6EtvRZZzLw7
	 7Ug847JdZCrrqlzVTRzlB9F7MqZLjmL0fqm9CriAMxcKs+Y4NF7ldcs7g96U6Xsc0D
	 HRXWgE3ZDtU/LeWuducDWD8Pn8d/LqfB5GjHboBAumrUJ9oG8LmHc7mGjJimLj1neO
	 NlYOiuD+hbIzw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCHSET RFC] sched_ext: Implement cgroup sub-scheduler support
Date: Fri, 19 Sep 2025 14:58:23 -1000
Message-ID: <20250920005931.2753828-1-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset implements cgroup sub-scheduler support for sched_ext,
enabling multiple schedulers to operate hierarchically within the cgroup
tree. This capability supports multi-tenant server environments and other
scenarios where systems must be partitioned to serve distinct workloads,
each requiring specialized scheduling policies.

Traditional approaches rely on hard partitioning via cpuset, but this
approach lacks the dynamism required by modern workloads. Users typically
care less about specific CPU assignments and more about optimizations
available on larger machines: opportunistic over-commit, improved latency
for critical workloads while preserving bandwidth fairness, control
mechanisms beyond simple CPU time (such as memory bandwidth isolation),
and intelligent placement to optimize cache locality.

The cgroup sub-scheduler approach enables schedulers to attach anywhere
in the cgroup hierarchy, with parent schedulers dynamically controlling
CPU allocation to their children. This design provides BPF-driven
flexibility while eliminating the constraints of hard partitioning.

This early-stage implementation demonstrates the fundamental building
blocks for hierarchical scheduler operation. While the enqueue path and
other components require further development, this patchset establishes
the core mechanisms for nested scheduler operation and is developed
enough to showcase all essential components.

The framework supports scheduling hierarchies up to SCX_SUB_MAX_DEPTH
levels (currently set to 4). Enable and disable operations selectively
bypass only tasks within the affected subtree, minimizing system-wide
disruptions while providing reasonable isolation for child scheduler
failures.

To see how this looks from the BPF scheduler perspective, examine the
scx_qmap.bpf.c changes in the final patch, which demonstrate simple
nested dispatch implementation.

Patch Organization:

Standalone fixes (01-07):
 01 sched_ext: Use rhashtable_lookup() instead of rhashtable_lookup_fast()
 02 sched_ext: Improve SCX_KF_DISPATCH comment
 03 sched_ext: Fix stray scx_root usage in task_can_run_on()
 04 sched_ext: Use bitfields for boolean warning flags
 05 sched_ext: Add SCX_EFLAG_INITIALIZED to indicate successful initialization
 06 sched_ext: Make qmap dump operation non-destructive
 07 tools/sched_ext: scx_qmap: Make debug output quieter by default

Preparation patches (08-22):
 08 sched_ext: Separate out scx_kick_cpu() and add sch to its name
 09 sched_ext: Add the sch parameter to __bstr_format()
 10 sched_ext: Add the sch parameter to ext_idle helpers
 11 sched_ext: Drop kf_cpu_valid
 12 sched_ext: Add the sch parameter to scx_dsq_insert_preamble()
 13 sched_ext: Drop scx_kf_exit() and scx_kf_error()
 14 sched_ext: Misc updates around scx_sched instance pointer handling
 15 sched_ext: Keep dying tasks on a separate list
 16 sched_ext: Implement cgroup subtree iteration for scx_task_iter
 17 sched_ext: Add kargs to scx_fork()
 18 sched/core: Swap the order between sched_post_fork() and wake_up_new_task()
 19 cgroup: Expose some cgroup helpers
 20 sched_ext: Update p->scx.disallow warning in scx_init_task()
 21 sched_ext: Minor reorganization of enable/disable paths
 22 sched_ext: Factor out scx_claim_exit() from scx_disable()

Core sub-scheduler implementation (23-40):
 23 sched_ext: Introduce cgroup sub-sched support
 24 HACK_NOT_FOR_UPSTREAM: BPF: Implement prog grouping hack
 25 sched_ext: Introduce scx_task_sched()/_rcu()
 26 sched_ext: Introduce scx_prog_sched()
 27 sched_ext: Ignore insertions of not owned tasks into sub-sched DSQs
 28 sched_ext: scx_dsq_move() should validate the task belongs to the dsq
 29 sched_ext: Refactor task init/exit helpers
 30 sched_ext: Make scx_prio_less() handle multiple schedulers
 31 sched_ext: Move bypass_depth into scx_sched
 32 sched_ext: Make bypass mode sub-sched aware
 33 sched_ext: Factor out scx_dispatch_sched()
 34 sched_ext: When calling ops.dispatch(), prev must be on the correct sched
 35 sched_ext: Dispatch from all scx_sched instances
 36 sched_ext: Move scx_dsp_ctx and scx_dsp_max_batch into scx_sched
 37 sched_ext: Make watchdog sub-sched aware
 38 sched_ext: Convert scx_dump_state() spinlock to raw spinlock
 39 sched_ext: Support dumping multiple schedulers and add scheduler identification
 40 sched_ext: Implement cgroup sub-sched enabling and disabling

Nested dispatch implementation (41-46):
 41 HACK_NOT_FOR_UPSTREAM: sched_ext: Work around @aux__prog prototype mismatch
 42 sched_ext: Wrap global DSQs in per-node structure
 43 sched_ext: Add bypass DSQ for sub-schedulers
 44 sched_ext: Factor out scx_link_sched() and scx_unlink_sched()
 45 sched_ext: Add rhashtable lookup for sub-schedulers
 46 sched_ext: Add basic building blocks for nested sub-scheduler dispatching

Implementation Notes:
- Patches 01-07: Independent fixes to be separated after merge window
- Patches 08-22: Infrastructure preparation (mostly sched_ext, one cgroup change)
- Patch 23: Skeletal sub-scheduler support (create/destroy only)
- Patches 24,41: Temporary BPF hacks requiring proper upstream solution
- Patches 25-39: Task migration and multi-scheduler operation mechanisms
- Patch 40: Full sub-scheduler enable/disable with ops.dispatch() support
  (enqueue path not yet implemented)
- Patches 42-46: Nested dispatch infrastructure and scx_bpf_dispatch_sched()

The patches are available in the git repository:
git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-sub-sched

 include/linux/bpf.h                      |    5
 include/linux/cgroup-defs.h              |    4
 include/linux/cgroup.h                   |   65
 include/linux/sched.h                    |    2
 include/linux/sched/ext.h                |   21
 init/Kconfig                             |    4
 kernel/bpf/syscall.c                     |   23
 kernel/cgroup/cgroup-internal.h          |    6
 kernel/cgroup/cgroup.c                   |   55
 kernel/exit.c                            |    1
 kernel/fork.c                            |    6
 kernel/sched/core.c                      |    2
 kernel/sched/ext.c                       | 2362 ++++++++++++++++++++++++-------
 kernel/sched/ext.h                       |    4
 kernel/sched/ext_idle.c                  |  197 ++
 kernel/sched/ext_internal.h              |  223 ++
 kernel/sched/sched.h                     |    7
 tools/sched_ext/include/scx/common.bpf.h |   90 -
 tools/sched_ext/include/scx/compat.bpf.h |    7
 tools/sched_ext/scx_qmap.bpf.c           |  146 +
 tools/sched_ext/scx_qmap.c               |   36
 21 files changed, 2556 insertions(+), 710 deletions(-)

