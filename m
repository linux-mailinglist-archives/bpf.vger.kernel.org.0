Return-Path: <bpf+bounces-41596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DAF998EFA
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7784F1F259F1
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B2D19D07E;
	Thu, 10 Oct 2024 17:56:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8C19D078
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582971; cv=none; b=GkZaJIOirBTfA+Q2yQPRVZs/L8o941G9ERMsMYvLE8p/fGlo3BYCDMlOGhuAEhCKC4+bRwH8IKc5h+H7qlQU/KeRmqx2RDuivNBR6qdNBGfqn7YsPeTfC2JED+5INTaCTn6dt3vY3ORtbzUFVShsWLojXCos7Gvi7ftQ7RSfQJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582971; c=relaxed/simple;
	bh=JJIrc4CqXHoeAdfE3Yzyqt/M6vT0ypXwR+O8jiYILOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Er8klLejCNDU6Hco8ZjYmyqYGopa+qYRooxND+9ulU7qzUL+vdfZIBo5dWcJw0mi6JOzy2UQw8/1m24qN5HeiLHxbMZ8/smU+gxlqfZ35eFHYZ5FeTz8zLezWZgTRqlBmmt7H+fG8EsIKvXYtPwDHOVe+n38OJyQfKlElo+DJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 7DDEC9F27B13; Thu, 10 Oct 2024 10:55:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 00/10] bpf: Support private stack for bpf progs
Date: Thu, 10 Oct 2024 10:55:52 -0700
Message-ID: <20241010175552.1895980-1-yonghong.song@linux.dev>
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
prog1, etc.

Currently, for each thread, the x86 kernel allocate 8KB stack. The each
bpf program (including its subprograms) has maximum 512B stack size to
avoid potential stack overflow. And nested bpf programs increase the risk
of stack overflow. To avoid potential stack overflow caused by bpf
programs, this patch implemented a private stack so bpf program stack
space is allocated dynamically when the program is jited. Such private
stack is applied to tracing programs like kprobe/uprobe, perf_event,
tracepoint, raw tracepoint and tracing.

But more than one instance of the same bpf program may run in the system.
To make things simple, percpu private stack is allocated for each program=
,
so if the same program is running on different cpus concurrently, we won'=
t
have any issue. Note that the kernel already have logic to prevent the
recursion for the same bpf program on the same cpu (kprobe, fentry, etc.)=
.

The patch implemented a percpu private stack based approach for x86 arch.
A new kfunc bpf_prog_call() is introduced for the above nested scheduler =
use
case. If bpf_prog_call() is used in the program and bpf_tail_call() is no=
t
used in the same program, then private stack will be used. Internally,
private stack allows certain number of recursions by allocating more
space. Please see each individual patch for details.

Change logs:
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

Yonghong Song (10):
  bpf: Allow each subprog having stack size of 512 bytes
  bpf: Mark each subprog with proper private stack modes
  bpf, x86: Refactor func emit_prologue
  bpf, x86: Create a helper for certain "reg <op>=3D imm" operations
  bpf, x86: Add jit support for private stack
  selftests/bpf: Add private stack tests
  bpf: Support calling non-tailcall bpf prog
  bpf, x86: Create two helpers for some arith operations
  bpf, x86: Jit support for nested bpf_prog_call
  selftests/bpf: Add tests for bpf_prog_call()

 arch/x86/net/bpf_jit_comp.c                   | 318 ++++++++++++++----
 include/linux/bpf.h                           |  14 +
 include/linux/bpf_verifier.h                  |   3 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |  27 ++
 kernel/bpf/helpers.c                          |  20 ++
 kernel/bpf/trampoline.c                       |  16 +
 kernel/bpf/verifier.c                         | 145 +++++++-
 .../selftests/bpf/prog_tests/prog_call.c      |  78 +++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 tools/testing/selftests/bpf/progs/prog_call.c |  92 +++++
 .../bpf/progs/verifier_private_stack.c        | 216 ++++++++++++
 12 files changed, 856 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_call.c
 create mode 100644 tools/testing/selftests/bpf/progs/prog_call.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_private_st=
ack.c

--=20
2.43.5


