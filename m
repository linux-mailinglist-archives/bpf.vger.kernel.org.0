Return-Path: <bpf+bounces-66674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD0B386C4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F70207A9F
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7B428488D;
	Wed, 27 Aug 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTAqskAn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591F1EDA1B
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309053; cv=none; b=Z73Aas54UfeExXMFpO4Vrgp+euL1DieYVKsQtISxWVE4oFf7Gv5YMM+rfFp5VhbMCVrFBkvze9jG3bJjxuwdFDdHxizGr/86obZ0QMJ02fseRLk8GxT6SL+MlHqQapkM6T8wTLUpHrFv94utQFAArz9Tq/i4CGN1O/ZTE6su2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309053; c=relaxed/simple;
	bh=QjKn5RMRFJiSm7PXBn6TlolTMs7pHtEY127f1Edw9oM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Kk0G320MHCNc8+f9WPN2a0s0X36S2CPRazc0Dj305Zm+6S0gA7pAprZqT+uSWs6ffG6SKA03vMOc8BpvxDEP0FQCpK2+fv53mL8ijeDZEgDQnxyaTqQ3u0TnRZDBkiN4KMOyl8E3aBPUtDUD3yBUSPCLdu0Nq3leZjreJccynaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTAqskAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713E4C4CEEB;
	Wed, 27 Aug 2025 15:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756309052;
	bh=QjKn5RMRFJiSm7PXBn6TlolTMs7pHtEY127f1Edw9oM=;
	h=From:To:Subject:Date:From;
	b=VTAqskAn9x4cHzb9M+tr9EHPvzl4OajA3N6+l71t+rDpVQDjKIxkKhiv533ZCSwOV
	 xEtAN7O4tZFhkv0XOBPwvlc/zCk7X4dwbN5psrS2evCYzDIshBopARlSK/bVnIzpkc
	 fxUic7IS6q5IehLGyMcRI2rh7JMt5lmdEAgtFvhiDvQi89V+DHxCUGq4TUQrvXESle
	 6OXcnMSHdPZAQId0DUC5abbUcS/BPQGRk/2fK3rg1KwEcKDMNx2hztbtzKtq7xf6sh
	 RQkdOZ57I/+6feG9Xnqu21RJhdy3YKxOBxqdY2IBr/0DA7qNVUUrSO4c+pORvWbUiu
	 uuK/L7Tndf6fg==
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
Subject: [PATCH bpf-next v4 0/3] bpf: Report arena faults to BPF streams
Date: Wed, 27 Aug 2025 15:37:23 +0000
Message-ID: <20250827153728.28115-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Puranjay Mohan (3):
  bpf: arm64: simplify exception table handling
  bpf: Report arena faults to BPF stderr
  selftests/bpf: Add tests for arena fault reporting

 arch/arm64/net/bpf_jit_comp.c                 | 77 ++++++++++++------
 arch/x86/net/bpf_jit_comp.c                   | 79 ++++++++++++++++++-
 include/linux/bpf.h                           |  5 ++
 kernel/bpf/arena.c                            | 20 +++++
 .../testing/selftests/bpf/prog_tests/stream.c | 33 +++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 39 +++++++++
 6 files changed, 226 insertions(+), 27 deletions(-)

-- 
2.47.3


