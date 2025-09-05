Return-Path: <bpf+bounces-67568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB8BB45A4B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 16:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A761A485E1
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515ED371EA3;
	Fri,  5 Sep 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTexy/XI"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04613728A5
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082152; cv=none; b=AGCm7yXTPaBvese77PwMpodykQq3pGN+B2ItFrs7u7uuqSke6GNE9XY4sHNxo38brB/Sht8DaB8+xfO6Lla1Nx8GZ6Blw3WGeew42HguvW+qdN2HlWeq1ynXXqziBkJIx5TrL2uK3WGtFHDM5N/QIcTQwzNgKNJsZA1fNhvIky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082152; c=relaxed/simple;
	bh=+JHvm/f286mrzR6lZJliESappouZWuH+qnV0fTWBK+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPRpuF9eW0xFfAeVw8aUzQwgRbpAxoc1weWuE6vKG+jDscZekbhlQu9WMtirdeQZPIWh6svMGYaXz2d1JwYHx1RElu5AwgxKGKnQeD05zR7mg0xsf+EpaxtwS1LF5JFF7GmNWqMsUXaNQqPfLfH1YPTgAEHbnVqt44soyA3dgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTexy/XI; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757082147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IYVDD398/wEaZ46wMVSBDcyAKwWMjoJv+qiyanGpY/Q=;
	b=VTexy/XISFIpjD1Q+Mcz89ODM+wZQmwSnIJd7TWGFYNg/xMbhGgtnhzuhPAStZ7LfJ6trv
	+v+ivT2Geciv83Ie3bs4G3BddCDKk8zaQOB5QpPhEsVhyD+47uXisyr8Qg2WMh6Dh1UaeV
	jdlyOi/8i0cxzwjSPUMJfMcFB7jVz+Q=
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Skip timer cases when bpf_timer is not supported
Date: Fri,  5 Sep 2025 22:22:05 +0800
Message-ID: <20250905142206.88132-3-leon.hwang@linux.dev>
In-Reply-To: <20250905142206.88132-1-leon.hwang@linux.dev>
References: <20250905142206.88132-1-leon.hwang@linux.dev>
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
461     timer_lockup:SKIP
462     timer_mim:SKIP
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
index 049efb5e78239..86425939527c8 100644
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


