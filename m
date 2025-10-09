Return-Path: <bpf+bounces-70677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15213BCA08E
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1631188349E
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFE92FB08F;
	Thu,  9 Oct 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2klmbNO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7DB2F39A5;
	Thu,  9 Oct 2025 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025580; cv=none; b=jwUi8L3xh0b7fFL/5HLEGSN3OC2nGd8ZenUcswYj4NrFcxbpArhcT48oReUQQhIQNelAGoJMOFLDCHXN3SABlyviKxdgHguAVRSl5KKaQiyJZUlnqywcOA+YCSJs34gSk8y8w5JiclKLQBXlGCT7243HpK9uwTLGC1E8KHj2m7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025580; c=relaxed/simple;
	bh=7vflYb0Tp3hdHkbkwb0Yn0MilZJJ5l31bW5Qvd+w75I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbknUdsM4iS3rr9hnLNEGHhqbNe19WU5XSNyHbWXvVnncO3Encw0X7YQDnbHhA2s5Lmxmz0igZKhuJMcc9NAOawC0Uv54fFKhShNPZ/8xQ/l7sWeJc/ZbOg8GUPTn/ta6RQ2cDVTP3M3rukpQ+DqnjHqCImGm7J+nQTKEx5cDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2klmbNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E609C4CEF8;
	Thu,  9 Oct 2025 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025578;
	bh=7vflYb0Tp3hdHkbkwb0Yn0MilZJJ5l31bW5Qvd+w75I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2klmbNOqnmAhlfk1lCXHPBbCQ1vRUc8yS3JK03ZhIcrzS/8V3Jo96pJPaCG+HNLx
	 KEA7Utt7j5yL2pKCiVc90QfCAL7nwhQlHZ5s2LQKJ+thr3fOaU06uZrcXBTHVOSIvN
	 qxTmTLRWDVuLdANamSSR3AK++oUwhoE+ti/JBt93kd34ctbZ1hxouZLVAiF4bfkqho
	 /LKTeanRtfHfY9nqFt+eHTrN/LfqDB6EFR4MM9YMOINfmE6OGXKHSJcquskbqN5ZZn
	 wwp+Aq91PdHVwrPg7wdYiZOJBRyYj7Wrjf30fYyGdUq1XVlauaxTfj66tI7UzsDxbi
	 DgYI+SalRp78Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jolsa@kernel.org,
	chen.dylane@linux.dev,
	memxor@gmail.com,
	ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] selftests/bpf: Fix flaky bpf_cookie selftest
Date: Thu,  9 Oct 2025 11:55:22 -0400
Message-ID: <20251009155752.773732-56-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

[ Upstream commit 105eb5dc74109a9f53c2f26c9a918d9347a73595 ]

bpf_cookie can fail on perf_event_open(), when it runs after the task_work
selftest. The task_work test causes perf to lower
sysctl_perf_event_sample_rate, and bpf_cookie uses sample_freq,
which is validated against that sysctl. As a result,
perf_event_open() rejects the attr if the (now tighter) limit is
exceeded.

>From perf_event_open():
if (attr.freq) {
	if (attr.sample_freq > sysctl_perf_event_sample_rate)
		return -EINVAL;
} else {
	if (attr.sample_period & (1ULL << 63))
		return -EINVAL;
}

Switch bpf_cookie to use sample_period, which is not checked against
sysctl_perf_event_sample_rate.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250925215230.265501-1-mykyta.yatsenko5@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes and why it matters
  - The perf-event subtest in bpf_cookie can fail with -EINVAL when run
    after tests that cause perf to throttle sampling (e.g., task_work
    stress), because the test uses frequency mode and sets
    `attr.sample_freq` above the current global limit. The kernel
    validates frequency mode against `sysctl_perf_event_sample_rate` and
    rejects it when exceeded (kernel/events/core.c:13403). In contrast,
    period mode only rejects if the high bit is set
    (kernel/events/core.c:13406), so it avoids this global-throttling
    pitfall.
  - Perf can dynamically lower `sysctl_perf_event_sample_rate` under
    high overhead (see assignment in kernel/events/core.c:654), so this
    flakiness can affect real test runs on slower systems or after heavy
    tests.

- Specific code change
  - In `tools/testing/selftests/bpf/prog_tests/bpf_cookie.c:453-454`,
    the test currently sets:
    - `attr.freq = 1;`
    - `attr.sample_freq = 10000;`
  - The commit switches to period mode by replacing those with:
    - `attr.sample_period = 100000;`
  - This removes reliance on `sysctl_perf_event_sample_rate` entirely
    for this test, eliminating the spurious -EINVAL from
    `perf_event_open()` and making the selftest deterministic.

- Scope, risk, and stable criteria
  - Selftests-only change; no kernel runtime code touched.
  - Minimal and contained (1 insertion, 2 deletions in a single file).
  - No API or architectural changes; uses long-supported perf_event_attr
    fields.
  - Purpose is purely to fix test flakiness, not to add features.
  - Low regression risk: switching from frequency to period mode is
    semantically equivalent for this test’s goal (ensuring perf samples
    fire to trigger the attached BPF program during `burn_cpu()`), while
    avoiding global sysctl dependency.
  - The issue exists in this stable tree: the local file still uses
    `attr.freq`/`attr.sample_freq` at
    `tools/testing/selftests/bpf/prog_tests/bpf_cookie.c:453-454`.

- Additional context
  - The upstream kernel already contains this exact fix (commit
    105eb5dc74109 “selftests/bpf: Fix flaky bpf_cookie selftest”).
  - Earlier attempts at hardening tests by lowering frequency (e.g., to
    1000) still risk hitting the dynamic throttle; period mode is the
    robust approach.

Given this is a small, targeted selftest flakiness fix with negligible
risk and clear benefit to stable testing reliability, it is suitable for
backporting.

 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 4a0670c056bad..75f4dff7d0422 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -450,8 +450,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	attr.size = sizeof(attr);
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
-	attr.freq = 1;
-	attr.sample_freq = 10000;
+	attr.sample_period = 100000;
 	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
-- 
2.51.0


