Return-Path: <bpf+bounces-64282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18487B10E71
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 17:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE115689C7
	for <lists+bpf@lfdr.de>; Thu, 24 Jul 2025 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649282EA493;
	Thu, 24 Jul 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="insiUJUl"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABAD2E9EB0
	for <bpf@vger.kernel.org>; Thu, 24 Jul 2025 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370147; cv=none; b=OdLWWzikVm0DHclpcLWPDZsjyYHti+b91gO9ECGI4Cqo9BZjQLsTSMcXugPvzrpxUOUfwJPQD5dNswvK+iF5WgBAI+NgXRU/GkfStgXSaVmaQ2RbnftLxcldmU9ivoB2ycgSuD1hDs+Fuf/Yvaw7F6uv74gRLsvI8cCd334WYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370147; c=relaxed/simple;
	bh=/NIRHWCCXgHb6aCTb4kYm2MLzgHd2qEAvK78b5KJlcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnnbW/9VzC6Vedu5f+EYvF+InadetvcWlpjzuIkjb7afQHX8J9Zm3owZsStLc2pWmopOr0xWDo5/iyaP1uQqF+gskmlFcGdzWKgwLFtb7YlEmLqvQ5tdTMBeTOnlkCevEuJOIyBtkPzH4qzd8OkqG8AcIqhDsOKg6UwMDmxoW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=insiUJUl; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753370143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQOXoKnEuHVbdjAAxYfHbNY7Gd7B6m6xthVMZFBbn+E=;
	b=insiUJUlANvhT46WT0RRVZjCoIp6wtsl6wok61NrYqCzlurvQrIn5iy+w1JHkY+ZZ+S/T6
	3XNGEgNVmJUCXUo6Pi9tBucr7grNcVthaE6jWqsRUsIHMctKwI8RYgQiPTousymUhdkFba
	P9LW3y+kJsgJFhwKejF80kVVD9WrWUY=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v4 4/4] selftests/bpf: Migrate fexit_noreturns case into tracing_failure test suite
Date: Thu, 24 Jul 2025 23:14:54 +0800
Message-ID: <20250724151454.499040-5-kafai.wan@linux.dev>
In-Reply-To: <20250724151454.499040-1-kafai.wan@linux.dev>
References: <20250724151454.499040-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Delete fexit_noreturns.c files and migrate the cases into
tracing_failure.c files.

The result:

 $ tools/testing/selftests/bpf/test_progs -t tracing_failure/fexit_noreturns
 #467/4   tracing_failure/fexit_noreturns:OK
 #467     tracing_failure:OK
 Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../bpf/prog_tests/fexit_noreturns.c          |  9 ----
 .../bpf/prog_tests/tracing_failure.c          | 47 +++++++++++++------
 .../selftests/bpf/progs/fexit_noreturns.c     | 15 ------
 .../selftests/bpf/progs/tracing_failure.c     |  6 +++
 4 files changed, 39 insertions(+), 38 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 delete mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
deleted file mode 100644
index 568d3aa48a78..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <test_progs.h>
-#include "fexit_noreturns.skel.h"
-
-void test_fexit_noreturns(void)
-{
-	RUN_TESTS(fexit_noreturns);
-}
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index 39b59276884a..10e231965589 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -28,37 +28,54 @@ static void test_bpf_spin_lock(bool is_spin_lock)
 	tracing_failure__destroy(skel);
 }
 
-static void test_tracing_deny(void)
+static void test_tracing_fail_prog(const char *prog_name, const char *exp_msg)
 {
 	struct tracing_failure *skel;
+	struct bpf_program *prog;
 	char log_buf[256];
-	int btf_id, err;
-
-	/* __rcu_read_lock depends on CONFIG_PREEMPT_RCU */
-	btf_id = libbpf_find_vmlinux_btf_id("__rcu_read_lock", BPF_TRACE_FENTRY);
-	if (btf_id <= 0) {
-		test__skip();
-		return;
-	}
+	int err;
 
 	skel = tracing_failure__open();
 	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
 		return;
 
-	bpf_program__set_autoload(skel->progs.tracing_deny, true);
-	bpf_program__set_log_buf(skel->progs.tracing_deny, log_buf, sizeof(log_buf));
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto out;
+
+	bpf_program__set_autoload(prog, true);
+	bpf_program__set_log_buf(prog, log_buf, sizeof(log_buf));
 
 	err = tracing_failure__load(skel);
 	if (!ASSERT_ERR(err, "tracing_failure__load"))
 		goto out;
 
-	ASSERT_HAS_SUBSTR(log_buf,
-			  "Attaching tracing programs to function '__rcu_read_lock' is rejected.",
-			  "log_buf");
+	ASSERT_HAS_SUBSTR(log_buf, exp_msg, "log_buf");
 out:
 	tracing_failure__destroy(skel);
 }
 
+static void test_tracing_deny(void)
+{
+	int btf_id;
+
+	/* __rcu_read_lock depends on CONFIG_PREEMPT_RCU */
+	btf_id = libbpf_find_vmlinux_btf_id("__rcu_read_lock", BPF_TRACE_FENTRY);
+	if (btf_id <= 0) {
+		test__skip();
+		return;
+	}
+
+	test_tracing_fail_prog("tracing_deny",
+			       "Attaching tracing programs to function '__rcu_read_lock' is rejected.");
+}
+
+static void test_fexit_noreturns(void)
+{
+	test_tracing_fail_prog("fexit_noreturns",
+			       "Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.");
+}
+
 void test_tracing_failure(void)
 {
 	if (test__start_subtest("bpf_spin_lock"))
@@ -67,4 +84,6 @@ void test_tracing_failure(void)
 		test_bpf_spin_lock(false);
 	if (test__start_subtest("tracing_deny"))
 		test_tracing_deny();
+	if (test__start_subtest("fexit_noreturns"))
+		test_fexit_noreturns();
 }
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
deleted file mode 100644
index b1c33d958ae2..000000000000
--- a/tools/testing/selftests/bpf/progs/fexit_noreturns.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include "bpf_misc.h"
-
-char _license[] SEC("license") = "GPL";
-
-SEC("fexit/do_exit")
-__failure __msg("Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.")
-int BPF_PROG(noreturns)
-{
-	return 0;
-}
diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
index 58d2777014e1..65e485c4468c 100644
--- a/tools/testing/selftests/bpf/progs/tracing_failure.c
+++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
@@ -24,3 +24,9 @@ int BPF_PROG(tracing_deny)
 {
 	return 0;
 }
+
+SEC("?fexit/do_exit")
+int BPF_PROG(fexit_noreturns)
+{
+	return 0;
+}
-- 
2.43.0


