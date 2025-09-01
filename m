Return-Path: <bpf+bounces-67124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38450B3EE77
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 21:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ED8483966
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A496830649B;
	Mon,  1 Sep 2025 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp56dmJM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF6F2405ED
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756755456; cv=none; b=fcvTWnETVh6ucWWtibBPJa90ioxHCA8Pr6glz0CMheuwCFxncG4ayIWv2m1mG/t/3fh70Sq9RExKtPWBrmTGAaV4DQVbsMdrXDxZsJgy1j+ieDRRifSGUeUaxi3yl/kdYpwoiatv8DNoTRhTf14UP7t4HJlFdgQDUqc64EUHcTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756755456; c=relaxed/simple;
	bh=saymX6OF7IpEYtarKrCDIeYJ6dz2Pd0Fen1hodtF7H4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=adCmTF1W7ILpg4Xs2oIt8ICRKBWfh9upJrNaZqa8BMO7x1VVXjasmTb2TVLexTTJataBEj4kSCsXhSV59uGRUcmqABZ5GmUijHjPyBc/D6+oBameMfU48BFpvLN7DJ8wyhJWNPekpPdZVWGOW2UTmzJ7aKU+bpVgEI/B9f/iriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp56dmJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35025C4CEF0;
	Mon,  1 Sep 2025 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756755455;
	bh=saymX6OF7IpEYtarKrCDIeYJ6dz2Pd0Fen1hodtF7H4=;
	h=From:To:Subject:Date:From;
	b=dp56dmJMg4ufSQ9BI2KjwlIy3T6VMWtDHlYWgT68ezWbTN3Ls7UZTHWJMapS1Wves
	 vBP6aCmz3qFJdD/2V+lHNstjd9RRD4iym8ka1+2s+HaYJ7P7Rns97USN7IrY7AmUdc
	 kFlzYmuAWDEccwbjaNkhVa/VViA6H4z6P6XQ0L6N4w1QP1QUlDWiNL1R/FZ3vjNu0F
	 yj//YfOm99TXmaLHCzibGzFLWLUiEeVoFXkGH/crA2WfAnza4b2mGaCHIH9aaoI7Es
	 RX8Wt79+7rCX4QBLw8xMO8lgm6p9ULTamTbt7qFgHznA+c7q+sg8CinlLUy0XIHXdH
	 SOKMaCiMtYUWA==
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
Subject: [PATCH bpf-next v5 0/4] bpf: report arena faults to BPF streams
Date: Mon,  1 Sep 2025 19:37:22 +0000
Message-ID: <20250901193730.43543-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Here is an example output from a stream and bpf_printk()

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

Same address is seen by using bpf_printk():

1389.078831: bpf_trace_printk: Read Address: 0xdeaddead0000

To make this possible, some extra metadata has to be passed to the bpf
exception handler, so the bpf exception handling mechanism for both
x86-64 and arm64 have been improved in this set.

The streams selftest has been updated to also test this new feature.

Puranjay Mohan (4):
  bpf: arm64: simplify exception table handling
  bpf: core: introduce main_prog_aux for stream access
  bpf: Report arena faults to BPF stderr
  selftests/bpf: Add tests for arena fault reporting

 arch/arm64/net/bpf_jit_comp.c                 | 77 ++++++++++++------
 arch/x86/net/bpf_jit_comp.c                   | 79 ++++++++++++++++++-
 include/linux/bpf.h                           |  7 ++
 kernel/bpf/arena.c                            | 27 +++++++
 kernel/bpf/core.c                             |  3 +-
 kernel/bpf/stream.c                           |  6 +-
 kernel/bpf/verifier.c                         |  1 +
 .../testing/selftests/bpf/prog_tests/stream.c | 34 +++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 61 ++++++++++++++
 9 files changed, 263 insertions(+), 32 deletions(-)

-- 
2.47.3


