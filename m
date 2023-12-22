Return-Path: <bpf+bounces-18592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BBF81C6EB
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 09:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D3E1F26461
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAA5D295;
	Fri, 22 Dec 2023 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UtB45gC5"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715DC8EE;
	Fri, 22 Dec 2023 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=a/icFs/vjCT6R1zos3pJn3NYi+OarKNXzvYLpYsbkHI=; b=UtB45gC5rA9kZM1HFfgnbZ0OY9
	pm9vPzBR6DueD9EgkBgCAbIhczKcVwlysTsAoMYbDrXImgjLkjJSZWSdGPQmmEjMMMj47TrqAAil2
	HNxxpW3DmIqq00x33rNq5xh6OQq4dLgfAUd9l5DjBt65pDLiNvsotF7bJ5fU9HCd9LYUzICoIpcb0
	GZvK8zQPanTosAOTx+91HEh0eLNS4vqcvJVoRX1TGjZFRJ16eQ0OnRI9zK/bKb9/b+BJnR4y9/4kG
	27p4JF2a72YXq2Rn2ZDV+d7uQrciZ5jAf6uQ4xfdCED6X77DKaAVyQJUv7Ytbu5HRmMY77J1KUbKs
	jk5brX7Q==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rGbIP-000JZ9-N8; Fri, 22 Dec 2023 09:54:17 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2023-12-22
Date: Fri, 22 Dec 2023 09:54:16 +0100
Message-Id: <20231222085416.5438-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27130/Thu Dec 21 10:38:20 2023)

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 22 non-merge commits during the last 3 day(s) which contain
a total of 23 files changed, 652 insertions(+), 431 deletions(-).

The main changes are:

1) Add verifier support for annotating user's global BPF subprogram arguments
   with few commonly requested annotations for a better developer experience,
   from Andrii Nakryiko.

   These tags are:
     - Ability to annotate a special PTR_TO_CTX argument
     - Ability to annotate a generic PTR_TO_MEM as non-NULL

2) Support BPF verifier tracking of BPF_JNE which helps cases when the compiler
   transforms (unsigned) "a > 0" into "if a == 0 goto xxx" and the like, from
   Menglong Dong.

3) Fix a warning in bpf_mem_cache's check_obj_size() as reported by LKP, from Hou Tao.

4) Re-support uid/gid options when mounting bpffs which had to be reverted with
   the prior token series revert to avoid conflicts, from Daniel Borkmann.

5) Fix a libbpf NULL pointer dereference in bpf_object__collect_prog_relos() found
   from fuzzing the library with malformed ELF files, from Mingyi Zhang.

6) Skip DWARF sections in libbpf's linker sanity check given compiler options to
   generate compressed debug sections can trigger a rejection due to misalignment,
   from Alyssa Ross.

7) Fix an unnecessary use of the comma operator in BPF verifier, from Simon Horman.

8) Fix format specifier for unsigned long values in cpustat sample, from Colin Ian King.

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot & wishing you all happy holidays!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Andrii Nakryiko, Christian Brauner, Daniel Borkmann, Dave Marchevsky, 
Eduard Zingerman, kernel test robot, Randy Dunlap, Sergei Trofimovich, 
Shung-Hsi Yu

----------------------------------------------------------------

The following changes since commit 1728df7fc11bf09322852ff05e73908244011594:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2023-12-19 18:35:28 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 5abde62465222edd3080b70099bd809f166d5d7d:

  bpf: Avoid unnecessary use of comma operator in verifier (2023-12-21 22:40:25 +0100)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Alexei Starovoitov (3):
      Merge branch 'bpf-support-to-track-bpf_jne'
      Merge branch 'enhance-bpf-global-subprogs-with-argument-tags'
      Merge branch 'bpf-fix-warning-in-check_obj_size'

Alyssa Ross (1):
      libbpf: Skip DWARF sections in linker sanity check

Andrii Nakryiko (10):
      bpf: abstract away global subprog arg preparation logic from reg state setup
      bpf: reuse btf_prepare_func_args() check for main program BTF validation
      bpf: prepare btf_prepare_func_args() for handling static subprogs
      bpf: move subprog call logic back to verifier.c
      bpf: reuse subprog argument parsing logic for subprog call checks
      bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog args
      bpf: add support for passing dynptr pointer to global subprog
      libbpf: add __arg_xxx macros for annotating global func args
      selftests/bpf: add global subprog annotation tests
      selftests/bpf: add freplace of BTF-unreliable main prog test

Colin Ian King (1):
      samples/bpf: Use %lu format specifier for unsigned long values

Daniel Borkmann (1):
      bpf: Re-support uid and gid when mounting bpffs

Hou Tao (3):
      selftests/bpf: Close cgrp fd before calling cleanup_cgroup_environment()
      bpf: Use c->unit_size to select target cache during free
      selftests/bpf: Remove tests for zeroed-array kptr

Menglong Dong (4):
      bpf: make the verifier tracks the "not equal" for regs
      selftests/bpf: remove reduplicated s32 casting in "crafted_cases"
      selftests/bpf: activate the OP_NE logic in range_cond()
      selftests/bpf: add testcase to verifier_bounds.c for BPF_JNE

Mingyi Zhang (1):
      libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos

Simon Horman (1):
      bpf: Avoid unnecessary use of comma operator in verifier

 include/linux/bpf.h                                |   7 +-
 include/linux/bpf_verifier.h                       |  29 ++-
 kernel/bpf/btf.c                                   | 282 ++++++---------------
 kernel/bpf/inode.c                                 |  53 +++-
 kernel/bpf/memalloc.c                              | 105 +-------
 kernel/bpf/verifier.c                              | 224 +++++++++++++---
 samples/bpf/cpustat_user.c                         |   4 +-
 tools/lib/bpf/bpf_helpers.h                        |   3 +
 tools/lib/bpf/libbpf.c                             |   2 +
 tools/lib/bpf/linker.c                             |   3 +
 .../testing/selftests/bpf/benchs/bench_htab_mem.c  |   1 +
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c       |  30 ++-
 tools/testing/selftests/bpf/prog_tests/log_fixup.c |   4 +-
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  |  27 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c       |   2 +-
 .../selftests/bpf/progs/freplace_unreliable_prog.c |  20 ++
 .../selftests/bpf/progs/task_kfunc_failure.c       |   2 +-
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    | 100 ++++----
 .../selftests/bpf/progs/test_global_func5.c        |   2 +-
 .../testing/selftests/bpf/progs/verifier_bounds.c  |  62 +++++
 .../bpf/progs/verifier_btf_unreliable_prog.c       |  20 ++
 .../selftests/bpf/progs/verifier_global_subprogs.c |  99 +++++++-
 23 files changed, 652 insertions(+), 431 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_btf_unreliable_prog.c

