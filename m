Return-Path: <bpf+bounces-68015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF01B51771
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 14:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294617A6DD3
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A4D31C57E;
	Wed, 10 Sep 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qlLhM9zU"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27831CA4A
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509089; cv=none; b=uVmGlEf0dDwoLOW1FzuL9IOhk4lIsCVwlmfmeU5B+RWYyZdGi6LEroCc2iIuRl9jhvYEqqddcRbj4OENbNtK9nbbw6vuiIn7k7rL/CXfwnamKjCUlS/IOTAmggljM3tndOFO9OhNbw6+6uGKMDRFG2tn5dii5yYtWtw9NKGKS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509089; c=relaxed/simple;
	bh=wFB6V9yzRueCAJCAshvUNvIjYqvqXJ/0JCzd3x7ChaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRzK96l9EWFQWs8LEhBVfUj+C2wCd5G7SGvq/rLYCm3cghHKiDmy4aXVXgpwELPPBQKxy5LeGMUR4Sgku4Hc7NkSV83JCw5H2AVOC31MdVIoljd9zgUo+vR/McI0guEP0v7Ji/vqUWmJ8QEl4mNTDmpY7GOgh+Q+ZfM44cg6btc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qlLhM9zU; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757509083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WimVFSpBxO9pJQZgRW4nxjm6YnLxcucVglVU1dcom8A=;
	b=qlLhM9zU0rrnzZfYCm2Arjk3NSxsDHV+lez4RHC2o0LK0QOysOixrKgcnmy7rQRrNarVP4
	G6gQiRiiESddzXbOiQOmhLLNNpJifspLDwZQSl0h1FFGlcieRJ8qmLOdraL5AGWqgGgif9
	BAnTDNaffNfNw6uF+nkYGffSgupnuUo=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	yepeilin@google.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: Skip timer cases when bpf_timer is not supported
Date: Wed, 10 Sep 2025 20:57:40 +0800
Message-ID: <20250910125740.52172-3-leon.hwang@linux.dev>
In-Reply-To: <20250910125740.52172-1-leon.hwang@linux.dev>
References: <20250910125740.52172-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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
---
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
2.50.1


