Return-Path: <bpf+bounces-67725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09493B495BC
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08CFD7B99C7
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437BE30F7FC;
	Mon,  8 Sep 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbPhmS8x"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7241D6BB
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349412; cv=none; b=eFvp4eDre9zxC2SpAPie/0+q/3x0J3Wy4FGbScp51T+CgDP4ZC0qDeAtEhxV0L1LhvQrWtAhyL8Ftq5VpgcLED/aQFPpDWxhlZUuPYPBfRCeVG4HQy8ZnHiy+ooy+/VbyhFFvTnEpbxLY/zQkpUbkTP6hI1BxYFR9Yz1PBVjjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349412; c=relaxed/simple;
	bh=NLdqzW/YUZBAh2Ze88gnRR2vDiUWU0zBA/V1Iji4KJU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CYL1QA7i0inZ2AvvKFKs6swgerrNr1lBymxdvkml1eFT59ZqFBcw4UtbWNx3/0hITPpavSXkr5x3CVIB2rOANckk7VJl2UatYbB2bFuVvvOd+jrW6ePEki7+6bcjX++VPRkZgpSaj8Xd9o/FK1s7GfZo88DHjCpcpWLXO9yViXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbPhmS8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4292C4CEF1;
	Mon,  8 Sep 2025 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757349412;
	bh=NLdqzW/YUZBAh2Ze88gnRR2vDiUWU0zBA/V1Iji4KJU=;
	h=From:To:Subject:Date:From;
	b=HbPhmS8xU/etWTfr730XSSB90EDy5ySTgdgPZanIQX/sNfwUfuryTj5/CPlOJ16WT
	 zI0k8suhgbvlVA4FdJopNSYr8SDwfJ8P9i8kXjCopM/9rtnaq2eF+ZqTadr6/Go+Oh
	 eF3w80lnQdM4egaoWqq/HXZ1gf0miR9gvXCzDDv9g+WDToqnmQvgLy7r6Dt+diy6Vc
	 oXFpeO5tcvav9UuMV5ViIhINYox1PikdJ8y+pTGWOjvWgz8+aPj2Kyh/+iv/QlwfCu
	 szchTxxmU4qgxzQZpxyMzM9KlFTNJXKMvgguxQYhuYIZkajO43lBYeWVG3Pn0vYzvg
	 Jfh4jpAXaFCAQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v6 0/5] bpf: report arena faults to BPF streams
Date: Mon,  8 Sep 2025 16:36:29 +0000
Message-ID: <20250908163638.23150-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5->v6:
v5: https://lore.kernel.org/all/20250901193730.43543-1-puranjay@kernel.org/
- Introduces __stderr and __stdout for easy testing of bpf streams (Eduard)
- Add more test cases for arena fault reporting (subprog and callback)
- Fix main_prog_aux usage and return main_prog from find_from_stack_cb (Kumar)
- Properly fix the build issue reported by kernel test robot

Changes in v4->v5:
v4: https://lore.kernel.org/all/20250827153728.28115-1-puranjay@kernel.org/
- Added patch 2 to introducing main_prog_aux for easier access to streams.
- Fixed bug in fault handlers when arena_reg == dst_reg
- Updated selftest to check test above edge case.
- Added comments about the usage of barrier_var() in code and commit message.

Changes in v3->v4:
v3: https://lore.kernel.org/all/20250827150113.15763-1-puranjay@kernel.org/
- Fixed a build issue when CONFIG_BPF_JIT=y and # CONFIG_BPF_SYSCALL is not set

Changes in v2->v3:
v2: https://lore.kernel.org/all/20250811111828.13836-1-puranjay@kernel.org/
- Improved the selftest to check the exact fault address
- Dropped BPF_NO_KFUNC_PROTOTYPES and bpf_arena_alloc/free_pages() usage
- Rebased on bpf-next/master

Changes in v1->v2:
v1: https://lore.kernel.org/all/20250806085847.18633-1-puranjay@kernel.org/
- Changed variable and mask names for consistency (Yonghong)
- Added Acked-by: Yonghong Song <yonghong.song@linux.dev> on two patches

This set adds the support of reporting page faults inside arena to BPF
stderr stream. The reported address is the one that a user would expect
to see if they pass it to bpf_printk();

Here is an example output from the stderr stream and bpf_printk()

ERROR: Arena WRITE access at unmapped address 0xdeaddead0000
CPU: 9 UID: 0 PID: 502 Comm: test_progs
Call trace:
bpf_stream_stage_dump_stack+0xc0/0x150
bpf_prog_report_arena_violation+0x98/0xf0
ex_handler_bpf+0x5c/0x78
fixup_exception+0xf8/0x160
__do_kernel_fault+0x40/0x188
do_bad_area+0x70/0x88
do_translation_fault+0x54/0x98
do_mem_abort+0x4c/0xa8
el1_abort+0x44/0x70
el1h_64_sync_handler+0x50/0x108
el1h_64_sync+0x6c/0x70
bpf_prog_a64a9778d31b8e88_stream_arena_write_fault+0x84/0xc8
  *(page) = 1; @ stream.c:100
bpf_prog_test_run_syscall+0x100/0x328
__sys_bpf+0x508/0xb98
__arm64_sys_bpf+0x2c/0x48
invoke_syscall+0x50/0x120
el0_svc_common.constprop.0+0x48/0xf8
do_el0_svc+0x28/0x40
el0_svc+0x48/0xf8
el0t_64_sync_handler+0xa0/0xe8
el0t_64_sync+0x198/0x1a0

Same address is printed by bpf_printk():

1389.078831: bpf_trace_printk: Read Address: 0xdeaddead0000

To make this possible, some extra metadata has to be passed to the bpf
exception handler, so the bpf exception handling mechanism for both
x86-64 and arm64 have been improved in this set.

The streams selftest has been updated to test this new feature.

Puranjay Mohan (5):
  bpf: arm64: simplify exception table handling
  bpf: core: introduce main_prog_aux for stream access
  bpf: Report arena faults to BPF stderr
  selftests: bpf: introduce __stderr and __stdout
  selftests/bpf: Add tests for arena fault reporting

 arch/arm64/net/bpf_jit_comp.c                 |  77 ++++++---
 arch/x86/net/bpf_jit_comp.c                   |  76 ++++++++-
 include/linux/bpf.h                           |   7 +
 kernel/bpf/arena.c                            |  30 ++++
 kernel/bpf/core.c                             |   6 +-
 kernel/bpf/verifier.c                         |   1 +
 .../testing/selftests/bpf/prog_tests/stream.c |  53 ++----
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  10 ++
 tools/testing/selftests/bpf/progs/stream.c    | 158 ++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |  90 ++++++++++
 10 files changed, 443 insertions(+), 65 deletions(-)

-- 
2.47.3


