Return-Path: <bpf+bounces-70683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC18BCA176
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0121D541196
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECBD2FC02B;
	Thu,  9 Oct 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENp15NjW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEEC235045;
	Thu,  9 Oct 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025646; cv=none; b=DGc6YQ7DutHDPGKxnLhJRpvm+ygAYYc/+M6T77y0RMdDw9zPhwBy31c94CSbVVtLDlF9tDlaRSP/b+Q0f7FYHqKea7sc8RNRYzuxo3UK8JFXtAD2l3YtqJaHvQ0eHSoxaHiNsyZjA5JDGLygnM2ust4rwKQGxLTMP05yylfBKz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025646; c=relaxed/simple;
	bh=3ddmq0SpXLemPFO6TxFKmdptKIsO1mwPG/RIEq8UZao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I75Kct7+IWzFpNym27fIwwk9UE1TGaUtwHff0gbgZ7JpVUcHhbEgY7s9Bf0d1teq4CitrY75n5FafYQoKWrHe+vhNxu59SHt64lceyJV8lV5mFRnkqtGT8qw9LT9kQJAc7dgUsq/v+1dEJNZsK9snPkMIflwIdgLmYGVXj8Ofsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENp15NjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1954C4CEF7;
	Thu,  9 Oct 2025 16:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025645;
	bh=3ddmq0SpXLemPFO6TxFKmdptKIsO1mwPG/RIEq8UZao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENp15NjWZ7c3r/ooTpZPWuysh+hJs9E5LY+4KDecmDTRISkEmDS9GFPv/SMFD9kZg
	 J4ZxI23GW9yhQVB5jJwPPp692oWZ7InwoDv2NwyPCgjaTscyw2k3kWLD8wwrVnjKk8
	 7OdPY7ZwGwvLbD7U+URS7AlZFMn37Guh/1nhbBaC1iABRrAWkuC0eGcU1odgq9zVNg
	 6e05ex80CAIYjQCMhA8N6it/iB4aTX5qjB2Skyijgy4XSF9sSCeunSHaaf3OK6JwyG
	 7eeWGZ3ZugK21CJXYknXzVdcVO0vVBov3FXyM9dAjoWxhrj6g5ycCmakE85EczSf/e
	 62TJenjaLC3jw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	memxor@gmail.com,
	iii@linux.ibm.com,
	andrii@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.16] selftests/bpf: Fix arena_spin_lock selftest failure
Date: Thu,  9 Oct 2025 11:55:58 -0400
Message-ID: <20251009155752.773732-92-sashal@kernel.org>
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

From: Saket Kumar Bhaskar <skb99@linux.ibm.com>

[ Upstream commit a9d4e9f0e871352a48a82da11a50df7196fe567a ]

For systems having CONFIG_NR_CPUS set to > 1024 in kernel config
the selftest fails as arena_spin_lock_irqsave() returns EOPNOTSUPP.
(eg - incase of powerpc default value for CONFIG_NR_CPUS is 8192)

The selftest is skipped incase bpf program returns EOPNOTSUPP,
with a descriptive message logged.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Link: https://lore.kernel.org/r/20250913091337.1841916-1-skb99@linux.ibm.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- `arena_spin_lock` returns `-EOPNOTSUPP` once `CONFIG_NR_CPUS` exceeds
  1024 (`tools/testing/selftests/bpf/progs/bpf_arena_spin_lock.h:497`),
  so on platforms like powerpc (default 8192 CPUs) every test run exits
  early and the user space harness currently asserts that the retval
  must be zero
  (`tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c:41-47`
  before this change), causing the subtests to fail outright.
- The patch teaches the harness to recognize that specific failure mode:
  `spin_lock_thread()` now short‑circuits when it sees `-EOPNOTSUPP`
  instead of tripping the ASSERT
  (`tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c:44-50`),
  and the BPF program annotates the condition by setting `test_skip = 3`
  before returning
  (`tools/testing/selftests/bpf/progs/arena_spin_lock.c:40-44`).
- After all worker threads complete, the host test checks that flag,
  prints an explicit skip message, and marks the subtest as skipped
  instead of comparing the counter and failing
  (`tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c:94-101`).
  This lets kselftest succeed on high-NR_CPUS systems while still
  reporting the unsupported configuration.
- The change is entirely confined to selftests, has no runtime or ABI
  impact, and aligns the tests with the documented hardware limitation,
  making it a low-risk fix for a real, reproducible failure on existing
  platforms.

 .../selftests/bpf/prog_tests/arena_spin_lock.c      | 13 +++++++++++++
 tools/testing/selftests/bpf/progs/arena_spin_lock.c |  5 ++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
index 0223fce4db2bc..693fd86fbde62 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -40,8 +40,13 @@ static void *spin_lock_thread(void *arg)
 
 	err = bpf_prog_test_run_opts(prog_fd, &topts);
 	ASSERT_OK(err, "test_run err");
+
+	if (topts.retval == -EOPNOTSUPP)
+		goto end;
+
 	ASSERT_EQ((int)topts.retval, 0, "test_run retval");
 
+end:
 	pthread_exit(arg);
 }
 
@@ -63,6 +68,7 @@ static void test_arena_spin_lock_size(int size)
 	skel = arena_spin_lock__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "arena_spin_lock__open_and_load"))
 		return;
+
 	if (skel->data->test_skip == 2) {
 		test__skip();
 		goto end;
@@ -86,6 +92,13 @@ static void test_arena_spin_lock_size(int size)
 			goto end_barrier;
 	}
 
+	if (skel->data->test_skip == 3) {
+		printf("%s:SKIP: CONFIG_NR_CPUS exceed the maximum supported by arena spinlock\n",
+		       __func__);
+		test__skip();
+		goto end_barrier;
+	}
+
 	ASSERT_EQ(skel->bss->counter, repeat * nthreads, "check counter value");
 
 end_barrier:
diff --git a/tools/testing/selftests/bpf/progs/arena_spin_lock.c b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
index c4500c37f85e0..086b57a426cf5 100644
--- a/tools/testing/selftests/bpf/progs/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/arena_spin_lock.c
@@ -37,8 +37,11 @@ int prog(void *ctx)
 #if defined(ENABLE_ATOMICS_TESTS) && defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	unsigned long flags;
 
-	if ((ret = arena_spin_lock_irqsave(&lock, flags)))
+	if ((ret = arena_spin_lock_irqsave(&lock, flags))) {
+		if (ret == -EOPNOTSUPP)
+			test_skip = 3;
 		return ret;
+	}
 	if (counter != limit)
 		counter++;
 	bpf_repeat(cs_count);
-- 
2.51.0


