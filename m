Return-Path: <bpf+bounces-40370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D5F987BFD
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A42281E35
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752001B07A6;
	Thu, 26 Sep 2024 23:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727BE15B99D
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727394322; cv=none; b=IdZ8itU9JUSPhjHK3hFSjW41Dv22EnhCAZ5JFurXSeI/pqBcaKJ/rI2eMrpdJs+uNR9CdTr2Xm4RGPGsFxXcepwfWQ18jgLmQF4FYE2kq0lcXmVEhofepPK0m9rcLlKubPZ1Kq5G6Dz4Urz1+Gri2NOCSWSKZZ28cvOcxr9QUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727394322; c=relaxed/simple;
	bh=EEvmGPSB+cylfXZ8tZFGr9TtzG5RZqMjPGCMbnp9Pmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GndmOc1CamhNWymJGhPAxdE9RL5LpVHTEdZJRGYwnfVbVfs+bamnH1rJIkM5hjpXCG4jhSklSPoOph//lMYDQd5UwvwaZXXn/exQ8sJnviA9HNMbOI1aKv9bQOXw34YmeOA5FOHuvKJ5khANo/hJ1BPkRhzFqyEDu6DEn81RxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 0A35A967C71D; Thu, 26 Sep 2024 16:45:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/5] bpf: Support private stack for bpf progs
Date: Thu, 26 Sep 2024 16:45:06 -0700
Message-ID: <20240926234506.1769256-1-yonghong.song@linux.dev>
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
Patch 1 allows each subprog having stack size of 512 bytes and overall pr=
og
stack depth (at the boundary of callback functions) can be as much as 64K=
B.
Patch 2 collects actual stack depth information in order to allocate per-=
cpu
buffer properly for each prog who is either the main prog or the callback
entry prog. Patch 3 marks each subprog with proper private stack states s=
o
jit can emit proper native code properly. Patch 4 implemented private sta=
ck
support for x86_64. Patch 5 added some test cases.

Change logs:
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

Yonghong Song (5):
  bpf: Allow each subprog having stack size of 512 bytes
  bpf: Collect stack depth information
  bpf: Mark each subprog with proper pstack states
  bpf, x86: Add jit support for private stack
  selftests/bpf: Add private stack tests

 arch/x86/net/bpf_jit_comp.c                   |  87 ++++++-
 include/linux/bpf.h                           |  13 +-
 include/linux/bpf_verifier.h                  |   3 +
 include/linux/filter.h                        |   1 +
 kernel/bpf/core.c                             |  24 ++
 kernel/bpf/verifier.c                         | 160 ++++++++++++-
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_private_stack.c        | 215 ++++++++++++++++++
 8 files changed, 493 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_private_st=
ack.c

--=20
2.43.5


