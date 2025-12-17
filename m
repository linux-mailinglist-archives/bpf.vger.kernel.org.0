Return-Path: <bpf+bounces-76930-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C040CC9CF2
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 00:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E32830341F6
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC532ED40;
	Wed, 17 Dec 2025 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy4N9mLh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F266212552
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766014589; cv=none; b=qSJs4o1/lmnETtIbDQ4CI7bAwL2hUkasAWMS/S1f1qTwzLynj7/JFLwTCqEXyRpB69sncx6T+5P82xFPdbZptq0/zrxsIhrZuot81+1u4D35Pr+AXmwzxL23nakr1E6BLv1nVZPxRN+D5+6sxxwR1/ZjnRuVoxx3h+VOughPFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766014589; c=relaxed/simple;
	bh=SGIgG4Fzu5neo1DU3KtFJ8RmjhgyPOCK3g8RAmcJLdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1vHPeXBbh2m8E7y6loJrYpGpclczORN0+1muKqNTMZystRwL7S8ojzkB332RndNmnKGZ1PGmb70bg1BwbtrEWQgYCWZeesd9y5Zrl6QTW5AYYw0R4+AL7ptf/T4neaAl1l/Fle51a6S28PQ4sD2MMMbs0aQRxtqtIoVGa5Sl4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy4N9mLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D125CC4CEF5;
	Wed, 17 Dec 2025 23:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766014587;
	bh=SGIgG4Fzu5neo1DU3KtFJ8RmjhgyPOCK3g8RAmcJLdY=;
	h=From:To:Cc:Subject:Date:From;
	b=sy4N9mLhnipMZoq+ci8VC14qgdHpfnp6loKUGDMIhL3IEGASC0bl947yZsHabKmra
	 qf1peZdPw5vMhwfYK/xRmxf1A9At/z8C2wKR2X6hMtT1R+U6HzzhEGKGL8w3htWcBn
	 CqhksKvOCuYvxNqJdOrjvYx9cGtlPg2NaBVf5wyytdWKkkStvrnwYlqpAOGSp2ZrdX
	 nXMx9INOyZYHH64cDCSHStUPLQusmoSafyDwkYe313HNqKhdONI/LAsZp6nMo8OOmt
	 FBHF59fFOr7N8k4UxDG1vfbylSGh2ip1Uyqqh0dULoU82wHYQKlhQmObWK2wZ0ZYfy
	 iZLGevQ+oKHlA==
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
Subject: [PATCH bpf-next v2 0/2] bpf: Optimize recursion detection on arm64
Date: Wed, 17 Dec 2025 15:35:55 -0800
Message-ID: <20251217233608.2374187-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

V1: https://lore.kernel.org/all/20251217162830.2597286-1-puranjay@kernel.org/
Changes in V1->V2:
- Patch 2:
	- Put preempt_enable()/disable() around RMW accesses to mitigate
	  race conditions. Because on CONFIG_PREEMPT_RCU and sleepable
	  bpf programs, preemption can cause no prog to execute.

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
 | bpf-next/master with Catalin’s fix reverted |         51.862         |
 |---------------------------------------------|------------------------|
 | bpf-next/master                             |         43.067         |
 | bpf-next/master with this change            |         53.856         |
 +---------------------------------------------+------------------------+

All benchmarks were run on a KVM based vm with Neoverse-V2 and 8 cpus.

This patch yields a 25% improvement in this benchmark compared to
bpf-next. Notably, reverting Catalin's fix also results in a performance
gain for this benchmark, which is interesting but expected.

For completeness, this benchmark was also run with the change enabled on
x86-64, which resulted in a 30% regression in the fentry benchmark. So,
it is only enabled on arm64.

[1] https://lore.kernel.org/all/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop/

Puranjay Mohan (2):
  bpf: move recursion detection logic to helpers
  bpf: arm64: Optimize recursion detection by not using atomics

 include/linux/bpf.h      | 39 ++++++++++++++++++++++++++++++++++++++-
 kernel/bpf/core.c        |  3 ++-
 kernel/bpf/trampoline.c  |  8 ++++----
 kernel/trace/bpf_trace.c |  4 ++--
 4 files changed, 46 insertions(+), 8 deletions(-)


base-commit: ec439c38013550420aecc15988ae6acb670838c1
-- 
2.47.3


