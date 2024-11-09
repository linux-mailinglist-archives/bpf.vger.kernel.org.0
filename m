Return-Path: <bpf+bounces-44411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE39C2991
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 03:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB131C2152A
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 02:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1D126C1D;
	Sat,  9 Nov 2024 02:53:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E6126BFC
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731120807; cv=none; b=CWk2jEu1VoOQIEorWH9W3whLKgC9sb6icxN89mwba8PziXus4C6BhsXED2EiVewIoJM11i3zsQnX9PuYN9ExDpjuwGl+f0YGvuJyi6HRU/xYOPAhsQGY+SzE3X+4vtgQaTRN2CVFHNarMKL/gePwCzqRW3jXjNBB5dzZ1WSkmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731120807; c=relaxed/simple;
	bh=YQweArDHFc/ZwoZnORdASNUirKzE322N0t6ehfIuyuY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKEE8MQ4Riia7KICXrYFL4PDYH8FGNL/ESaUK6WnZE559hLXmGsK4v11RTdqPbjI0mRnyCMRGE7E+00AzM0VbN6Hd35nnlyhmA0G3wl3A1DcZkglpOu7JnL3wL1zLl1xGctDWE6gZxKPPUfgF593G3A/v/4sv0I1RvOE09i2Vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 410BDAE0753A; Fri,  8 Nov 2024 18:53:12 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v11 0/7] bpf: Support private stack for bpf progs
Date: Fri,  8 Nov 2024 18:53:12 -0800
Message-ID: <20241109025312.148539-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The main motivation for private stack comes from nested scheduler in
sched-ext from Tejun. The basic idea is that
 - each cgroup will its own associated bpf program,
 - bpf program with parent cgroup will call bpf programs
   in immediate child cgroups.

Let us say we have the following cgroup hierarchy:
  root_cg (prog0):
    cg1 (prog1):
      cg11 (prog11):
        cg111 (prog111)
        cg112 (prog112)
      cg12 (prog12):
        cg121 (prog121)
        cg122 (prog122)
    cg2 (prog2):
      cg21 (prog21)
      cg22 (prog22)
      cg23 (prog23)

In the above example, prog0 will call a kfunc which will call prog1 and
prog2 to get sched info for cg1 and cg2 and then the information is
summarized and sent back to prog0. Similarly, prog11 and prog12 will be
invoked in the kfunc and the result will be summarized and sent back to
prog1, etc. The following illustrates a possible call sequence:
   ... -> bpf prog A -> kfunc -> ops.<callback_fn> (bpf prog B) ...

Currently, for each thread, the x86 kernel allocate 16KB stack. Each
bpf program (including its subprograms) has maximum 512B stack size to
avoid potential stack overflow. Nested bpf programs further increase the
risk of stack overflow. To avoid potential stack overflow caused by bpf
programs, this patch set supported private stack and bpf program stack
space is allocated during jit time. Using private stack for bpf progs
can reduce or avoid potential kernel stack overflow.

Currently private stack is applied to tracing programs like kprobe/uprobe=
,
perf_event, tracepoint, raw tracepoint and struct_ops progs.
Tracing progs enable private stack if any subprog stack size is more
than a threshold (i.e. 64B). Struct-ops progs enable private stack
based on particular struct op implementation which can enable private
stack before verification at per-insn level. Struct-ops progs have
the same treatment as tracing progs w.r.t when to enable private stack.

For all these progs, the kernel will do recursion check (no nesting for
per prog per cpu) to ensure that private stack won't be overwritten.
The bpf_prog_aux struct has a callback func recursion_detected() which
can be implemented by kernel subsystem to synchronously detect recursion,
report error, etc.

Only x86_64 arch supports private stack now. It can be extended to other
archs later. Please see each individual patch for details.

Change logs:
  v10 -> v11:
    - v10 link: https://lore.kernel.org/bpf/20241107024138.3355687-1-yong=
hong.song@linux.dev/
    - Use two bool variables, priv_stack_requested (used by struct-ops on=
ly) and
      jits_use_priv_stack, in order to make code cleaner.
    - Set env->prog->aux->jits_use_priv_stack to true if any subprog uses=
 private stack.
      This is for struct-ops use case to kick in recursion protection.
  v9 -> v10:
    - v9 link: https://lore.kernel.org/bpf/20241104193455.3241859-1-yongh=
ong.song@linux.dev/
    - Simplify handling async cbs by making those async cb related progs =
using normal
      kernel stack.
    - Do percpu allocation in jit instead of verifier.
  v8 -> v9:
    - v8 link: https://lore.kernel.org/bpf/20241101030950.2677215-1-yongh=
ong.song@linux.dev/
    - Use enum to express priv stack mode.
    - Use bits in bpf_subprog_info struct to do subprog recursion check b=
etween
      main/async and async subprogs.
    - Fix potential memory leak.
    - Rename recursion detection func from recursion_skipped() to recursi=
on_detected().
  v7 -> v8:
    - v7 link: https://lore.kernel.org/bpf/20241029221637.264348-1-yongho=
ng.song@linux.dev/
    - Add recursion_skipped() callback func to bpf_prog->aux structure su=
ch that if
      a recursion miss happened and bpf_prog->aux->recursion_skipped is n=
ot NULL, the
      callback fn will be called so the subsystem can do proper action ba=
sed on their
      respective design.
  v6 -> v7:
    - v6 link: https://lore.kernel.org/bpf/20241020191341.2104841-1-yongh=
ong.song@linux.dev/
    - Going back to do private stack allocation per prog instead per subt=
ree. This can
      simplify implementation and avoid verifier complexity.
    - Handle potential nested subprog run if async callback exists.
    - Use struct_ops->check_member() callback to set whether a particular=
 struct-ops
      prog wants private stack or not.
  v5 -> v6:
    - v5 link: https://lore.kernel.org/bpf/20241017223138.3175885-1-yongh=
ong.song@linux.dev/
    - Instead of using (or not using) private stack at struct_ops level,
      each prog in struct_ops can decide whether to use private stack or =
not.
  v4 -> v5:
    - v4 link: https://lore.kernel.org/bpf/20241010175552.1895980-1-yongh=
ong.song@linux.dev/
    - Remove bpf_prog_call() related implementation.
    - Allow (opt-in) private stack for sched-ext progs.
  v3 -> v4:
    - v3 link: https://lore.kernel.org/bpf/20240926234506.1769256-1-yongh=
ong.song@linux.dev/
      There is a long discussion in the above v3 link trying to allow pri=
vate
      stack to be used by kernel functions in order to simplify implement=
ation.
      But unfortunately we didn't find a workable solution yet, so we ret=
urn
      to the approach where private stack is only used by bpf programs.
    - Add bpf_prog_call() kfunc.
  v2 -> v3:
    - Instead of per-subprog private stack allocation, allocate private
      stacks at main prog or callback entry prog. Subprogs not main or ca=
llback
      progs will increment the inherited stack pointer to be their
      frame pointer.
    - Private stack allows each prog max stack size to be 512 bytes, inte=
ad
      of the whole prog hierarchy to be 512 bytes.
    - Add some tests.

Yonghong Song (7):
  bpf: Find eligible subprogs for private stack support
  bpf: Enable private stack for eligible subprogs
  bpf, x86: Avoid repeated usage of bpf_prog->aux->stack_depth
  bpf, x86: Support private stack in jit
  selftests/bpf: Add tracing prog private stack tests
  bpf: Support private stack for struct_ops progs
  selftests/bpf: Add struct_ops prog private stack tests

 arch/x86/net/bpf_jit_comp.c                   |  88 +++++-
 include/linux/bpf.h                           |   4 +
 include/linux/bpf_verifier.h                  |   8 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/trampoline.c                       |   4 +
 kernel/bpf/verifier.c                         | 112 +++++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 104 +++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/struct_ops_private_stack.c | 106 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/struct_ops_private_stack.c      |  62 ++++
 .../bpf/progs/struct_ops_private_stack_fail.c |  62 ++++
 .../progs/struct_ops_private_stack_recur.c    |  50 ++++
 .../bpf/progs/verifier_private_stack.c        | 272 ++++++++++++++++++
 15 files changed, 871 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_pri=
vate_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_=
stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_=
stack_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_=
stack_recur.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_private_st=
ack.c

--=20
2.43.5


