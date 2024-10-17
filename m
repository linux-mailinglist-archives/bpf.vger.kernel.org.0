Return-Path: <bpf+bounces-42337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315CC9A30BE
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 00:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635D91C21990
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 22:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6891D79A4;
	Thu, 17 Oct 2024 22:31:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AE1C1AC4
	for <bpf@vger.kernel.org>; Thu, 17 Oct 2024 22:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729204315; cv=none; b=NfzVTvk+J3Z30JUcP4W+lXJIZ7nRtWfD4Rzs7sW9p3Zg5J6vn5pFwumR+SnU47YFXZbAQpgEWIMd+ZG6Ut6tBl1Ykn0u8FhaPxCQ3QcxaW4+xM5WFFR33YuqOgUwhJjMTppK9o4tenuaMhIk8q59Pkw6hytEOfquJ4YZRtDX1T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729204315; c=relaxed/simple;
	bh=mjlZYIztDJM7S69pL6ROc0YrsDz1+UNIoT1Pdsw2v8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S6m1QDoTex9Sei29NeuWu+tDoT0/bUfkwZ1V4y8D3Ig7c0Ls2ACuaLC84+Sy+1UXzGIGE0tTO/MLI1xwfHpO0LeBf0xiQ0jSsg4jSRzuOQ5Gy9XoNK3Gp9AlY7dhhYNmatdfCKGXMIw6e1gwnC8wIPsqc81PM2Pb1a03o455PtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 965A8A2F077A; Thu, 17 Oct 2024 15:31:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v5 0/9] bpf: Support private stack for bpf progs
Date: Thu, 17 Oct 2024 15:31:38 -0700
Message-ID: <20241017223138.3175885-1-yonghong.song@linux.dev>
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
programs, this patch implemented a private stack so bpf program stack
space is allocated dynamically when the program is jited. Such private
stack is applied to tracing programs like kprobe/uprobe, perf_event,
tracepoint, raw tracepoint and sched-ext struct_ops progs.

But more than one instance of the same bpf program may run in the system.
To make things simple, percpu private stack is allocated for each program=
,
so if the same program is running on different cpus concurrently, we won'=
t
have any issue. Note that the kernel already have logic to prevent the
recursion for the same bpf program on the same cpu (kprobe, fentry, etc.)=
.

This patch set implemented a percpu private stack based approach for x86
arch. Please see each individual patch for details.

Change logs:
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
  bpf: Allow each subprog having stack size of 512 bytes
  bpf: Support private stack for struct_ops programs
  sched-ext: Allow sched-ext progs to use private stack
  bpf: Mark each subprog with proper private stack modes
  bpf, x86: Refactor func emit_prologue
  bpf, x86: Create a helper for certain "reg <op>=3D imm" operations
  bpf, x86: Add jit support for private stack
  selftests/bpf: Add tracing prog private stack tests
  selftests/bpf: Add struct_ops prog private stack tests

 arch/x86/net/bpf_jit_comp.c                   | 187 +++++++++++----
 include/linux/bpf.h                           |  11 +
 include/linux/bpf_verifier.h                  |   4 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |  24 ++
 kernel/bpf/verifier.c                         | 125 ++++++++--
 kernel/sched/ext.c                            |   6 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  83 +++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   6 +
 .../bpf/prog_tests/struct_ops_private_stack.c |  80 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/struct_ops_private_stack.c      |  62 +++++
 .../progs/struct_ops_private_stack_recur.c    |  50 ++++
 .../bpf/progs/verifier_private_stack.c        | 216 ++++++++++++++++++
 14 files changed, 799 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_pri=
vate_stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_=
stack.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_private_=
stack_recur.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_private_st=
ack.c

--=20
2.43.5


