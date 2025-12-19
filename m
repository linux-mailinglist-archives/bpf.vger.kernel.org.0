Return-Path: <bpf+bounces-77196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A1CD176D
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B35302DA65
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984E934A774;
	Fri, 19 Dec 2025 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s07KTV3/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95F34A3D0
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169913; cv=none; b=WhhoXj+036zkq0/rAIibEJsN7+/d4LEGbH+2jsXQV+1gEMSb218E+PqwWpi7G81zqKoTjFHv1P9P8ZGJ4PcfD5ylF7eptxdee4F0UO1ybcbReqORN8N9A6/nLicCl9UovEj+B956byx0+YcfALhxrmdrOSm3koRwhdyLPNeqV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169913; c=relaxed/simple;
	bh=fdA4SOinV6miSZMqEmQwwi0gHc728+lALNs8BrpnCfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWTk7huBv+0GR/6NwFQAPza/EVd7sRg1g3nxG3tR0Ss6vMSlMG80s6iOxAS0E5xzdxI9qaEVDtpGdI9hYoeOhBEYF1xofJK0dBlMjheenYn0OXgvYgy3ZoLJn6p6Ye3n5mlyAo/Zva5wMgatZREDDwZicngRXDm9lgs3lqHx0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s07KTV3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817A3C4CEF1;
	Fri, 19 Dec 2025 18:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766169912;
	bh=fdA4SOinV6miSZMqEmQwwi0gHc728+lALNs8BrpnCfU=;
	h=From:To:Cc:Subject:Date:From;
	b=s07KTV3/t/3VWmRiphv+Bn5MBtMCTbr8s6G6GAMkPXiuQSfuDQqKfqutVHPs1HA4B
	 /HRuExZNbYLsnH+fCr3CuEHnaCPMK1TWHo6dmUvTzV+OsMEPacltUQz/GCRDFev+FN
	 cPITfAkVQw1Z18rvAPOYfwu/v7cdbRf4XnslIwcLkC3SQVS9pPhkwF6lpFGim5VWKP
	 WUXHF710AUTVV9za5TcX/lKaut0YOL6fkmlsrTgq2Y0f1M8pRf9EGIOTKvqu0gktVm
	 uoOBDGt/AYfE0uplvQLEWKX86wK9dhOcjg1nfpVvfzkiKvGzYc2qFp7D2K4kNNRVx0
	 e7zKdqCeTguNA==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next v3 0/2] bpf: Optimize recursion detection on arm64
Date: Fri, 19 Dec 2025 10:44:16 -0800
Message-ID: <20251219184422.2899902-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

V2: https://lore.kernel.org/all/20251217233608.2374187-1-puranjay@kernel.org/
Changes in v2->v3:
- Added acked by Yonghong
- Patch 2:
        - Change alignment of active from 8 to 4
        - Use le32_to_cpu in place of get_unaligned_le32()

V1: https://lore.kernel.org/all/20251217162830.2597286-1-puranjay@kernel.org/
Changes in V1->V2:
- Patch 2:
        - Put preempt_enable()/disable() around RMW accesses to mitigate
          race conditions. Because on CONFIG_PREEMPT_RCU and sleepable
	  bpf programs, preemption can cause no bpf prog to execute in
	  case of recursion.

BPF programs detect recursion using a per-CPU 'active' flag in struct
bpf_prog. The trampoline currently sets/clears this flag with atomic
operations.

On some arm64 platforms (e.g., Neoverse V2 with LSE), per-CPU atomic
operations are relatively slow. Unlike x86_64 - where per-CPU updates
can avoid cross-core atomicity, arm64 LSE atomics are always atomic
across all cores, which is unnecessary overhead for strictly per-CPU
state.

This patch removes atomics from the recursion detection path on arm64.

It was discovered in [1] that per-CPU atomics that don't return a value
were extremely slow on some arm64 platforms, Catalin added a fix in
commit 535fdfc5a228 ("arm64: Use load LSE atomics for the non-return
per-CPU atomic operations") to solve this issue, but it seems to have
caused a regression on the fentry benchmark.

Using the fentry benchmark from the bpf selftests shows the following:

  ./tools/testing/selftests/bpf/bench trig-fentry

 +---------------------------------------------+------------------------+
 |               Configuration                 | Total Operations (M/s) |
 +---------------------------------------------+------------------------+
 | bpf-next/master with Catalin’s fix reverted |         51.770         |
 |---------------------------------------------|------------------------|
 | bpf-next/master                             |         43.271         |
 | bpf-next/master with this change            |         43.271         |
 +---------------------------------------------+------------------------+

All benchmarks were run on a KVM based vm with Neoverse-V2 and 8 cpus.

This patch yields a 25% improvement in this benchmark compared to
bpf-next. Notably, reverting Catalin's fix also results in a performance
gain for this benchmark, which is interesting but expected.

For completeness, this benchmark was also run with the change enabled on
x86-64, which resulted in a 30% regression in the fentry benchmark. So,
it is only enabled on arm64.

P.S. - Here is more data with other program types:

 +-----------------+-----------+-----------+----------+
 |     Metric      |  Before   |   After   | % Diff   |
 +-----------------+-----------+-----------+----------+
 | fentry          |   43.149  |   53.948  | +25.03%  |
 | fentry.s        |   41.831  |   50.937  | +21.76%  |
 | rawtp           |   50.834  |   58.731  | +15.53%  |
 | fexit           |   31.118  |   34.360  | +10.42%  |
 | tp              |   39.536  |   41.632  |  +5.30%  |
 | syscall-count   |    8.053  |    8.305  |  +3.13%  |
 | fmodret         |   33.940  |   34.769  |  +2.44%  |
 | kprobe          |    9.970  |    9.998  |  +0.28%  |
 | usermode-count  |  224.886  |  224.839  |  -0.02%  |
 | kernel-count    |  154.229  |  153.043  |  -0.77%  |
 +-----------------+-----------+-----------+----------+

[1] https://lore.kernel.org/all/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop/

Puranjay Mohan (2):
  bpf: move recursion detection logic to helpers
  bpf: arm64: Optimize recursion detection by not using atomics

 include/linux/bpf.h      | 38 +++++++++++++++++++++++++++++++++++++-
 kernel/bpf/core.c        |  3 ++-
 kernel/bpf/trampoline.c  |  8 ++++----
 kernel/trace/bpf_trace.c |  4 ++--
 4 files changed, 45 insertions(+), 8 deletions(-)


base-commit: ec439c38013550420aecc15988ae6acb670838c1
-- 
2.47.3


