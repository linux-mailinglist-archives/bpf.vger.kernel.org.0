Return-Path: <bpf+bounces-65326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA3B2075A
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0553AF197
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEC2BE7C3;
	Mon, 11 Aug 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdXtKn8d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D6B2853EE
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911114; cv=none; b=dZP/F0pQliHOOkeblNXVdV1SqFKORFedLoFIckJ3AYiyIF97VIPpKjwhh0xZRjNxNQBJDA0iQAJPTctWVCQ4/UPJax9f3DyM7TnFM6GDV1pjiW1Ze3AXi8gqHpkCcFz/nwAu45G75FBePoK7h/xCsVZKcL6GCl3soqP0C8t9WgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911114; c=relaxed/simple;
	bh=dnfPf0I/kAUZ5P3BCy9pd2N8Yeyuty2F1fjd8KgAOgc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rWcb0WvVUAUc0qFiENCdvSwX2Be4M5iRwLfTeNevPYPk/P+VPFg7SVDZ61t+41D/gRwU8MuPmOTPLzsxxB6CDf61849oKv7AaeDp3f6VM1v4uhjfA5z7hK5EuXk5kzqfQFPnar/dGX9Gawv9IlpMXb6n3sDUdL0w29sI6rcWI8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdXtKn8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C7AC4CEED;
	Mon, 11 Aug 2025 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754911113;
	bh=dnfPf0I/kAUZ5P3BCy9pd2N8Yeyuty2F1fjd8KgAOgc=;
	h=From:To:Subject:Date:From;
	b=LdXtKn8dWPljfB2e+iE7tsRb/SbPaY5ovqftEVNLW5eQcF4YbBRcwbLWD3wIicX0G
	 i9TBZjH6Yc3hHnTrysrZhfTPttvhqJK3pUo16d01/oiPWe/1bhLUk35PqM7kgMYW5P
	 j0oh70rgCNjzYid3PDxBfruWX0oGwRAjo4+pWkmhUDomqamovLSfHMhIzz06UCdR9u
	 /VZ7wc7VZR7b5Lc+podgeLtQVDgljNXgdxg/rFwx+mDR7ibSR7+zqy2aXPzvZNWuh/
	 Yr4Q086GHrweUS3xy9cF7jl4arbllBowO0GfYfAWtN9IQPDkJVcrag11epvIZnrjWe
	 xW8j67lohXHMA==
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
Subject: [PATCH bpf-next v2 0/3] bpf: Report arena faults to BPF streams
Date: Mon, 11 Aug 2025 11:18:21 +0000
Message-ID: <20250811111828.13836-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 arch/arm64/net/bpf_jit_comp.c                 | 56 +++++++------
 arch/x86/net/bpf_jit_comp.c                   | 79 ++++++++++++++++++-
 include/linux/bpf.h                           |  1 +
 kernel/bpf/arena.c                            | 20 +++++
 .../testing/selftests/bpf/prog_tests/stream.c | 24 ++++++
 tools/testing/selftests/bpf/progs/stream.c    | 37 +++++++++
 6 files changed, 191 insertions(+), 26 deletions(-)

-- 
2.47.3


