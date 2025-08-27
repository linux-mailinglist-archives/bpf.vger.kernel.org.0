Return-Path: <bpf+bounces-66666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B13B38599
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62533B8D97
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0321C84D0;
	Wed, 27 Aug 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5st4gnf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB591B0420
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306883; cv=none; b=cFpQJIAkXVKN+qp31iqmdU2N/UHt2Keph/NzixP+bV4PONVustBcmtWtK46wwywiQLP5IARXUAcx/3dn+bHoUww07QeMddCQN9cUOIoeZQWayd0FO0lyTU1ZCjExVkt0Oj4TjpFWEcziSPDKbOIvaUhyCeIKau2sEnRrns17FSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306883; c=relaxed/simple;
	bh=rZvIGPKud/dLc11DJBp72uZjKgirYDoc5gx/mJQhqwI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=m1w1imZrHnm7xTb8fArPls8vFXo/dK5+sQZJv7aj0LoNX76jmcFLT6diXiK6GouwZcpTt9icF7PLLVA0M8YVqkUpTTvV04H5ezND89Pv3GjcgrFVtysO5s5ThqU/diu9eIMdl03zbA0AghsxZkGMjRbzTZZpvzMs0aSghVqI4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5st4gnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0F9C4CEEB;
	Wed, 27 Aug 2025 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756306883;
	bh=rZvIGPKud/dLc11DJBp72uZjKgirYDoc5gx/mJQhqwI=;
	h=From:To:Subject:Date:From;
	b=T5st4gnfY72Hel+jzUAViXYdGWjLvXLyLmGAiZ8vwqbAM90G8ALz+10riCE794Bp5
	 VZ6/Njy0t6H4LhdpbmWtBLItVoIMqXIRi6lMgeXfwIGvvASDJfUceiojK4+vm8ue2v
	 FtlGypoDJNvj7ESB0l9BlX+DUJO2wAX1ONhYtO2BPxmLxG13gIEuRTPJNKVycynI7L
	 BrsZUg2XeRWNJNigbhkSIx4RZNF1CYxMPWTpc7OrswYDrih6sDczju3pP+ksp8YFU4
	 H4hvdYkWjq555q4fgVB8QuGLc7s+vdMrr3GQLCch8SEdkHk/Q1jPlsS2WLXmqOlVqq
	 5R0SO+VZ9c4kA==
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
Subject: [PATCH bpf-next v3 0/3] bpf: Report arena faults to BPF streams
Date: Wed, 27 Aug 2025 15:00:36 +0000
Message-ID: <20250827150113.15763-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 include/linux/bpf.h                           |  1 +
 kernel/bpf/arena.c                            | 20 +++++
 .../testing/selftests/bpf/prog_tests/stream.c | 33 +++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 39 +++++++++
 6 files changed, 222 insertions(+), 27 deletions(-)

-- 
2.47.3


