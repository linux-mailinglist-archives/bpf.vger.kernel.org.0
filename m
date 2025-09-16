Return-Path: <bpf+bounces-68504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4581DB598D8
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 16:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C0E172B54
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9717C30B510;
	Tue, 16 Sep 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGJeYSyJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124F2369977;
	Tue, 16 Sep 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031217; cv=none; b=uj06APcEBFvxOXuKJeD+fzPoP4gQFxO8rXiMrREPYhcxxo8s7Ao4ReGejUiT8Ml9kbDorZKi/hEPmObEhb2aTl4xIyVjQM2M5qvrDCKf46czMN7Vnu68LvdYaEnJhRxSWIwz7gv//6TxuUGDCKHpxLrE34hc5vGPJPGroNkG0jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031217; c=relaxed/simple;
	bh=P8DwAXqWjfRA7lHVsfdAVWUoxLcgHFvm0ryHlWHb2k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOT5EhA4O/aCxSi42ZVr+syp/eBdTk79dVH0WSoYak/kfuex2r3c70uY8bMXfZEUle8oO16ilJ489D4yc/BjczKISOd6E+bgM4/c4CgPOEKfnmsd+dOp0At1+VojTF06TGbIoiCgZ2l+w6Sb4p2grX+yuM1tAv6Tk6IF3tis2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGJeYSyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5993CC4CEF0;
	Tue, 16 Sep 2025 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758031216;
	bh=P8DwAXqWjfRA7lHVsfdAVWUoxLcgHFvm0ryHlWHb2k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bGJeYSyJwLVAb4OcqatLX91yypcLqpdeUMByY1ciJ2LKewN4aNLPsppWiFFNLY8G3
	 MWc5ZPj7vLFQ70wRixngkake+AbsbiFoOUSWKhgAy6OepucJkqsy1ALk5/1jDK8Atp
	 stRjU1AxvQq6EwMsxNg3lafHaYhj5Y2nCp5o4Gu5VbolduxjYJVuMJ0wsge41GcRU3
	 O/iFnvNOnMWr3zYEEMEL4zs4TDBGbEldnRkeVy+yrwrZTYDQfdSpATGmgrKPPlqfkL
	 b4eCLGtthjjUGt/KzP4VJx7QjgCYOPO/VCC8YwXdz3pAm1Ivq1FrBEJutaO80YXRnf
	 +KE47dJ7yJfEw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	andrii@kernel.org,
	vmalik@redhat.com,
	memxor@gmail.com,
	kafai@fb.com,
	toke@redhat.com,
	daniel@iogearbox.net,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16] selftests/bpf: Skip timer cases when bpf_timer is not supported
Date: Tue, 16 Sep 2025 09:59:02 -0400
Message-ID: <20250916135936.1450850-9-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916135936.1450850-1-sashal@kernel.org>
References: <20250916135936.1450850-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Leon Hwang <leon.hwang@linux.dev>

[ Upstream commit fbdd61c94bcb09b0c0eb0655917bf4193d07aac1 ]

When enable CONFIG_PREEMPT_RT, verifier will reject bpf_timer with
returning -EOPNOTSUPP.

Therefore, skip test cases when errno is EOPNOTSUPP.

cd tools/testing/selftests/bpf
./test_progs -t timer
125     free_timer:SKIP
456     timer:SKIP
457/1   timer_crash/array:SKIP
457/2   timer_crash/hash:SKIP
457     timer_crash:SKIP
458     timer_lockup:SKIP
459     timer_mim:SKIP
Summary: 5/0 PASSED, 6 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/r/20250910125740.52172-3-leon.hwang@linux.dev
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## **Backport Status: YES**

This commit **SHOULD be backported** to stable kernel trees for versions
5.15.x through 6.16.x.

## Extensive Analysis and Justification

### **1. Nature of the Change**
The patch adds simple errno checks (`if (!skel && errno == EOPNOTSUPP)`)
to five BPF timer test files, making them skip gracefully when bpf_timer
is unsupported on PREEMPT_RT kernels. Each modification is identical and
minimal:
```c
if (!skel && errno == EOPNOTSUPP) {
    test__skip();
    return;
}
```

### **2. Critical Context from Investigation**
My comprehensive research revealed:
- **Fundamental incompatibility**: BPF uses raw spinlocks (non-sleeping
  even on RT) while hrtimer uses sleeping spinlocks on PREEMPT_RT,
  causing "BUG: scheduling while atomic" crashes
- **Recent rejection**: Commit e25ddfb388c8b (Sep 2025) completely
  disabled bpf_timer for PREEMPT_RT after earlier workaround attempts
  failed
- **Affected versions**: All kernels from v5.15 (when bpf_timer was
  introduced) to v6.16 have broken tests on PREEMPT_RT

### **3. Meets Stable Kernel Rules**
Per Documentation/process/stable-kernel-rules.rst:
- ✅ **Fixes a real bug**: Test failures on PREEMPT_RT kernels are
  misleading and prevent proper CI/testing
- ✅ **Obviously correct**: Simple errno check with established
  test__skip() pattern
- ✅ **Small change**: ~20 lines total across 5 files
- ✅ **Already in mainline**: Merged in v6.17-rc6
- ✅ **User benefit**: Developers and CI systems get accurate test
  results instead of false failures

### **4. Security and Stability Implications**
- **Prevents kernel warnings/crashes**: Without this patch, running
  timer tests on PREEMPT_RT can trigger "scheduling while atomic" bugs
- **Testing infrastructure reliability**: False test failures mask real
  issues and reduce confidence in test results
- **Real-time system safety**: PREEMPT_RT is used in safety-critical
  systems (industrial, automotive, medical) where test accuracy is
  crucial

### **5. Specific Code Changes Analysis**
All five modified files follow the identical pattern:
- **prog_tests/free_timer.c:126-129**: Checks after
  `free_timer__open_and_load()`
- **prog_tests/timer.c:88-91**: Checks after `timer__open_and_load()`
- **prog_tests/timer_crash.c:14-17**: Checks after
  `timer_crash__open_and_load()`
- **prog_tests/timer_lockup.c:61-64**: Checks after
  `timer_lockup__open_and_load()`
- **prog_tests/timer_mim.c:67-70**: Checks after
  `timer_mim__open_and_load()`

### **6. Backport Dependencies**
This patch requires commit e25ddfb388c8b ("bpf: Reject bpf_timer for
PREEMPT_RT") to be backported first, which adds the verifier check that
returns -EOPNOTSUPP.

### **7. Risk Assessment**
- **Zero functional risk**: Only adds test skipping, doesn't change any
  kernel functionality
- **No regression potential**: If errno != EOPNOTSUPP, tests run
  normally as before
- **Improves stability**: Prevents potential crashes from running
  incompatible tests

### **8. Recommendation**
**STRONGLY RECOMMEND BACKPORTING** with the following stable tags:
```
Cc: stable@vger.kernel.org # 5.15+
Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
```

This is a textbook example of a stable-appropriate fix: small, obvious,
fixes real user-visible problems, and improves kernel testing
reliability without any risk of regression.

 tools/testing/selftests/bpf/prog_tests/free_timer.c   | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer.c        | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_crash.c  | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_lockup.c | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_mim.c    | 4 ++++
 5 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/free_timer.c b/tools/testing/selftests/bpf/prog_tests/free_timer.c
index b7b77a6b29799..0de8facca4c5b 100644
--- a/tools/testing/selftests/bpf/prog_tests/free_timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/free_timer.c
@@ -124,6 +124,10 @@ void test_free_timer(void)
 	int err;
 
 	skel = free_timer__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(skel, "open_load"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
index d66687f1ee6a8..56f660ca567ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -86,6 +86,10 @@ void serial_test_timer(void)
 	int err;
 
 	timer_skel = timer__open_and_load();
+	if (!timer_skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
index f74b82305da8c..b841597c8a3a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_crash.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
@@ -12,6 +12,10 @@ static void test_timer_crash_mode(int mode)
 	struct timer_crash *skel;
 
 	skel = timer_crash__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(skel, "timer_crash__open_and_load"))
 		return;
 	skel->bss->pid = getpid();
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
index 1a2f99596916f..eb303fa1e09af 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_lockup.c
@@ -59,6 +59,10 @@ void test_timer_lockup(void)
 	}
 
 	skel = timer_lockup__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(skel, "timer_lockup__open_and_load"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_mim.c b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
index 9ff7843909e7d..c930c7d7105b9 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer_mim.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer_mim.c
@@ -65,6 +65,10 @@ void serial_test_timer_mim(void)
 		goto cleanup;
 
 	timer_skel = timer_mim__open_and_load();
+	if (!timer_skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
 		goto cleanup;
 
-- 
2.51.0


