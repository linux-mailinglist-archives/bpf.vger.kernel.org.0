Return-Path: <bpf+bounces-43427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEFD9B55A2
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 23:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A2A283FF5
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4444520ADD4;
	Tue, 29 Oct 2024 22:16:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32517B402
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730240215; cv=none; b=u0nQ726ufpn+QRAexhrmydU1M3blhVQO/ldynmddzGLYYG5ok/p++Q75pIgS9op7hCwJoUP+OwCzmCR/dXtgkXSiUdhncs6qQdnwxFMin1AtflYVFUC4SXYaMMtGgA+YDw2JCgCJnNCYR1oxFk7nJAfIOpWJWFO768pT+K/5HCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730240215; c=relaxed/simple;
	bh=mZQ8UKIkXWiXTeQQfEbZaRKDynzZe2+22llPIQiyRQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXJkAFghdNRnA2wrh1IYF/qP9ufVmJS2ixJp+uUngpTTRie1MBmsKJbLVUO0JKSY203hJfc+Hzx6HFgvKUgnQfJGp6B4HFGjlT892OddyGDBQgOhT/L2epMw0D0EL7X0dyarlptSAWGz7e4bgMfyp/KAuS2WolJU5b4618tz2Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 41C6BA91CF0E; Tue, 29 Oct 2024 15:16:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v7 0/9] bpf: Support private stack for bpf progs
Date: Tue, 29 Oct 2024 15:16:37 -0700
Message-ID: <20241029221637.264348-1-yonghong.song@linux.dev>
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
space is allocated during verification time. Using private stack for
bpf progs can reduce or avoid potential kernel stack overflow.

Currently private stack is applied to tracing programs like kprobe/uprobe=
,
perf_event, tracepoint, raw tracepoint and struct_ops progs. For all
these progs, the kernel will do recursion check (no nesting for per prog
per cpu) to ensure that private stack won't be overwritten.

Tracing progs enable private stack if any subprog stack size is more
than a threshold (i.e. 64B). Struct-ops progs enable private stack
based on particular struct op implementation which can enable private
stack before verification at per-insn level.

Only x86_64 arch supports private stack now. It can be extended to other
archs later. Please see each individual patch for details.

Change logs:
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

Yonghong Song (9):
  bpf: Check stack depth limit after visiting all subprogs
  bpf: Allow private stack to have each subprog having stack size of 512
    bytes
  bpf: Check potential private stack recursion for progs with async
    callback
  bpf: Allocate private stack for eligible main prog or subprogs
  bpf, x86: Avoid repeated usage of bpf_prog->aux->stack_depth
  bpf, x86: Support private stack in jit
  selftests/bpf: Add tracing prog private stack tests
  bpf: Support private stack for struct_ops progs
  selftests/bpf: Add struct_ops prog private stack tests

 arch/x86/net/bpf_jit_comp.c                   |  73 ++++-
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |   2 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |  15 +
 kernel/bpf/verifier.c                         | 163 ++++++++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  94 ++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   5 +
 .../bpf/prog_tests/struct_ops_private_stack.c | 106 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/struct_ops_private_stack.c      |  62 ++++
 .../bpf/progs/struct_ops_private_stack_fail.c |  62 ++++
 .../progs/struct_ops_private_stack_recur.c    |  50 ++++
 .../bpf/progs/verifier_private_stack.c        | 272 ++++++++++++++++++
 14 files changed, 893 insertions(+), 16 deletions(-)
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


