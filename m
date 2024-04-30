Return-Path: <bpf+bounces-28280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308BF8B7F51
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 19:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376631C23188
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 17:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9821181B8D;
	Tue, 30 Apr 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOcbs9VI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A5180A92;
	Tue, 30 Apr 2024 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499935; cv=none; b=DVLuS4G/T1ZLl6qvmf+9t71wLr6JcCb8omu0QGDu2wVlFuwC6guu4keVe/Kbke5Is2+uKloKIZyh8qJM0zxeSm7ZQejf9MGVMs2H58nhTVYgojwHorDSs3vOXn4JQ39UIPJ/39sVnkIrszTRGPo73Btsa9tc/6s/fsyy0lfz3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499935; c=relaxed/simple;
	bh=9GscSuMrdqZRGQiz+g8LzDHMXZexOoafw/dgWylTjf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hpXovEFmyYBcJKadKJzWwgvYbysSRaeF4ta0+qCvR0LKfP6Pp8CD5dq/QXu8JT1QS1judfczYApQ3yzSwaVotlQgHe0WRucTMe/ohYH6lgdzfIdPWhp8NGZSCq27+o9Pm/CB9dhTchJdgqf8TUL4mlK7iuYD4348Ec8/FCmj5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOcbs9VI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0559C2BBFC;
	Tue, 30 Apr 2024 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714499935;
	bh=9GscSuMrdqZRGQiz+g8LzDHMXZexOoafw/dgWylTjf4=;
	h=From:To:Cc:Subject:Date:From;
	b=qOcbs9VICSWN1L4GCro9oYzvMgsVeBcG/Q0+HKQ67mclDI2I0nYhhtFVjHIJIVbYc
	 pPTuoaqDwVTCDdsoM2LFax7yBk0B6c3AWzHHTWv9EqoVuA8AtL4RAygBqfXzvWsSVG
	 FJByHvlxUuD+3h0VNSoS8PBUgbRVn4VJ7CdJU0p6eMks+OmvhZHNI9bEDij6n7dGFS
	 nYgPpRNggyNAoE+2GxUXyRZa+K0ZYktHrD2kxlKehoWx1FGgOtY9VAUvj4zAzNfRSM
	 3PSS6rXRxaOFeRWaDiq3JH2/SmldFkaouq1C9WAN5p8JIMJ5EaG+jsxbkj3RqUaQlp
	 hNYLM1LiXbS7g==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pu Lehui <pulehui@huawei.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v2 0/2] riscv, bpf: Support per-CPU insn and inline bpf_get_smp_processor_id()
Date: Tue, 30 Apr 2024 17:58:32 +0000
Message-Id: <20240430175834.33152-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v1->v2:
v1: https://lore.kernel.org/all/20240405124348.27644-1-puranjay12@gmail.com/
- Use emit_addr() in place of emit_imm() in the first patch.
- Add the second patch to inline bpf_get_smp_processor_id()

The first patch add the support for the internal-only MOV instruction to
resolve per-CPU addrs to absolute addresses.
RISC-V uses generic per-cpu implementation where the offsets for CPUs are
kept in an array called __per_cpu_offset[cpu_number]. RISCV stores the
address of the task_struct in TP register. The first element in task_struct
is struct thread_info, and we can get the cpu number by reading from the TP
register + offsetof(struct thread_info, cpu).

The second patch inlines the calls bpf_get_smp_processor_id() in the JIT
by emitting a load from the TP + offsetof(struct thread_info, cpu).

Benchmark using [1] on Qemu.

  ./benchs/run_bench_trigger.sh glob-arr-inc arr-inc hash-inc

  +---------------+------------------+------------------+--------------+
  |      Name     |     Before       |       After      |   % change   |
  |---------------+------------------+------------------+--------------|
  | glob-arr-inc  | 1.077 ± 0.006M/s | 1.336 ± 0.010M/s |   + 24.04%   |
  | arr-inc       | 1.078 ± 0.002M/s | 1.332 ± 0.015M/s |   + 23.56%   |
  | hash-inc      | 0.494 ± 0.004M/s | 0.653 ± 0.001M/s |   + 32.18%   |
  +---------------+------------------+------------------+--------------+

[1] https://github.com/anakryiko/linux/commit/8dec900975ef

Puranjay Mohan (2):
  riscv, bpf: add internal-only MOV instruction to resolve per-CPU addrs
  riscv, bpf: inline bpf_get_smp_processor_id()

 arch/riscv/net/bpf_jit_comp64.c | 50 +++++++++++++++++++++++++++++++++
 include/linux/filter.h          |  1 +
 kernel/bpf/core.c               | 11 ++++++++
 kernel/bpf/verifier.c           |  2 ++
 4 files changed, 64 insertions(+)

-- 
2.40.1


