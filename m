Return-Path: <bpf+bounces-67690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F97B4834F
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 06:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E66E167618
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 04:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE14921FF3E;
	Mon,  8 Sep 2025 04:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TczFsScU"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B332E21CC63
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757306445; cv=none; b=orO8vz+GFqQnls2ORKXrzVgv0sQB9AXP3f12lj2fzZd9mAHTJrOlpBcomVZb6KR1Zqy4NTuZcqvrIHjqu4FcxnmYX9wsW3GBIWdZluafgkNe3hFTQFbPlf1+vTgNtqQU+wNiu3BiK7vxrV60Tx0R10EI3OcB+rXkA6/xuKOHdKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757306445; c=relaxed/simple;
	bh=i2FTbnZcsbclfK8oQvHXWCme9aX0McUJhuNKqzf5m20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/wjRsa0KLuRsPc53oCFEt/ezSk1kRIEnTD+O28WqeEMdqU47aKt6U0zHsFCcS3aVVU7jJRN0sh6asvPKJ16Sn3FPUZ8XsiGR3sPOY6j+LQBxgxVKblr1S2oxKh163CVBCOk/1CM/MdPQfRNgkn5MGs5/hlNWZs6zOwWn4rq2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TczFsScU; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757306441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTC0GtNdIsMuQMwAUekmbe8MGFdpEa4u90Mx+ZC/LlQ=;
	b=TczFsScUzV1Gcd+DleuLW1vd+6VPYkbIzdcYyS5uObY45vdGfUwkL9pgeZ//NvB9RPFCM3
	8bNoADEWeHjwLPLGBBo3Y0ouNvdBUqQndMOvCToOKBboKP0dRmTxvwzHLIwQubXRONcfh+
	w9b5a4tEwPl8iS0R//PLe+GRMHKocH4=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Skip timer cases when bpf_timer is not supported
Date: Mon,  8 Sep 2025 12:40:25 +0800
Message-ID: <20250908044025.77519-3-leon.hwang@linux.dev>
In-Reply-To: <20250908044025.77519-1-leon.hwang@linux.dev>
References: <20250908044025.77519-1-leon.hwang@linux.dev>
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
459     timer:SKIP
460/1   timer_crash/array:SKIP
460/2   timer_crash/hash:SKIP
460     timer_crash:SKIP
461     timer_interrupt:SKIP
462     timer_lockup:SKIP
463     timer_mim:SKIP
Summary: 6/0 PASSED, 7 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/free_timer.c   | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer.c        | 8 ++++++++
 tools/testing/selftests/bpf/prog_tests/timer_crash.c  | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_lockup.c | 4 ++++
 tools/testing/selftests/bpf/prog_tests/timer_mim.c    | 4 ++++
 5 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/free_timer.c b/tools/testing/selftests/bpf/prog_tests/free_timer.c
index b7b77a6b2979..0de8facca4c5 100644
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
index 049efb5e7823..34f9ccce2602 100644
--- a/tools/testing/selftests/bpf/prog_tests/timer.c
+++ b/tools/testing/selftests/bpf/prog_tests/timer.c
@@ -87,6 +87,10 @@ void serial_test_timer(void)
 	int err;
 
 	timer_skel = timer__open_and_load();
+	if (!timer_skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(timer_skel, "timer_skel_load"))
 		return;
 
@@ -104,6 +108,10 @@ void test_timer_interrupt(void)
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 
 	skel = timer_interrupt__open_and_load();
+	if (!skel && errno == EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
 	if (!ASSERT_OK_PTR(skel, "timer_interrupt__open_and_load"))
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/timer_crash.c b/tools/testing/selftests/bpf/prog_tests/timer_crash.c
index f74b82305da8..b841597c8a3a 100644
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
index 1a2f99596916..eb303fa1e09a 100644
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
index 9ff7843909e7..c930c7d7105b 100644
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


