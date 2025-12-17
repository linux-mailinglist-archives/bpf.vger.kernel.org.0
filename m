Return-Path: <bpf+bounces-76879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E7CC8DA8
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A97030C9EEC
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3903F3587C8;
	Wed, 17 Dec 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0kIgPqP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E273587D0
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988929; cv=none; b=gcoL5Tf7Xp/LHsWIkUP9w1zC6y/rRklvV3ZjIObsgL9uUqC01vHOoaRILBkfT6Jmsayb5YOVEVt9EtMk/iZlGSlXdThGpYmxqjGHUY3qr+SxCCB6lpY26urvIJe/kx3VisAZXwV16xxdCKq7tFNRpH7XNk51qbWBF475xnS93Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988929; c=relaxed/simple;
	bh=wW2WX9bXMy21iLr94pepHPoiTdQS77qviWjUVKa89d8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JXbWqdvOlvTM8ZYzDZ7wj4apLlwsJz6caKK5KAHWI0adHbm2bCum6Dyk0QG/3EBkrmLwhgzS6IqGFWdip5wd6cQ/Gflkxw3rBVz/m8ISFhBIwmwcHm/sqWIxwSn7f1P33V4X5wo/kn4L1RnSeUR9Vw3vp3v85ui4uaIXRkN71J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0kIgPqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19034C4CEF5;
	Wed, 17 Dec 2025 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765988928;
	bh=wW2WX9bXMy21iLr94pepHPoiTdQS77qviWjUVKa89d8=;
	h=From:To:Cc:Subject:Date:From;
	b=K0kIgPqP3Uguea91P1XJVdtjDsuNURZSx4kUgWYhCOsx5yF9X5+11isYQrmfx1PPg
	 Fh4llRDPvOxBUOyvkQut8q9WKOiSotqqAkW68/c9YbD6Wu8ujE+U6Vwjm5lhC19utL
	 iMnyBEOjSxOjkWY7aoUv933Qk1s58OnjkWpflPbXe8jkRgYavjWRNnw7efK62R+apD
	 udTOwURPmUN4EYDxbZ5I6lJwRqlmO62uRGKIcEdrnw+RuSWsJaCr/jG4sRIYhOh+2Q
	 kiZvmDwNlh35dYgBmvnHYIHB6qjjEr7YN6ewPRvQla5M2hSlvQgjrE8RQ4jQgA+uzC
	 /1V8G0MxndxvA==
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
Subject: [PATCH bpf-next 0/2] bpf: Optimize recursion detection on arm64
Date: Wed, 17 Dec 2025 08:28:25 -0800
Message-ID: <20251217162830.2597286-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 | bpf-next/master with Catalin’s fix reverted |    40.033 ± 0.090      |
 |---------------------------------------------|------------------------|
 | bpf-next/master                             |    34.617 ± 0.018      |
 | bpf-next/master with this change            |    46.122 ± 0.020      |
 +---------------------------------------------+------------------------+

All benchmarks were run on a KVM based vm with Neoverse-V2 and 8 cpus.

This patch yields a 33% improvement in this benchmark compared to
bpf-next. Notably, reverting Catalin's fix also results in a performance
gain for this benchmark, which is interesting but expected.

For completeness, this benchmark was also run with the change enabled on
x86-64, which resulted in a 30% regression in the fentry benchmark. So,
it is only enabled on arm64.

[1] https://lore.kernel.org/all/e7d539ed-ced0-4b96-8ecd-048a5b803b85@paulmck-laptop/

Puranjay Mohan (2):
  bpf: move recursion detection logic to helpers
  bpf: arm64: Optimize recursion detection by not using atomics

 include/linux/bpf.h      | 35 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/core.c        |  3 ++-
 kernel/bpf/trampoline.c  |  8 ++++----
 kernel/trace/bpf_trace.c |  4 ++--
 4 files changed, 42 insertions(+), 8 deletions(-)


base-commit: ec439c38013550420aecc15988ae6acb670838c1
-- 
2.47.3


