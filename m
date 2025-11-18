Return-Path: <bpf+bounces-74964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CCC69822
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A25E53818BA
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ED8257AEC;
	Tue, 18 Nov 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pOFemZRT"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88525743D;
	Tue, 18 Nov 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763470760; cv=none; b=Y3niXQTz1kZ2V1GHGuIa0tiiOVb5Rgt3ekCDFRgIe/0r7xgKtnd+R6gm7kf4+JuyEYZAWfpTJow8WMToKOHjDBEVy56y+NDWizIp2i21MY3vjqStuCR5GWyrYpQDOlF90KM5m3GvSlFD6ONZCjXl096X8LmcMziA3ZM4oP18+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763470760; c=relaxed/simple;
	bh=qOgl1fiIunAohbrmTWcIWvaOKXsMC7k+mnALoNDYY8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K17fz8mNKg9OQ4iSWPPni34w0vprA/SAN6uGytVKdtbwBIFWLCFY/H2UL4sZ4K/QdR4pMFIzj/Oj0s8oa1sPma1fAUCOauhn8uJ6HXiu6cQ+05zpniFx/X3VuHolqb7IwglEB9yinBYjuMm6jpgNykpdGCn+gcMUEuLeDgcC7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pOFemZRT; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763470755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6E2UNdn2tzAwp/0JtLmgN7RTjX6PfzmkTfK6J+H5U4=;
	b=pOFemZRT7RnQa7L6Jtj+JtJnH+eyZHbm/YAoA0lIl9HVJPwxaM0XS845/5tEhCb2fZoho0
	tFuBySwAg3ZYFi/ia5fz6yqgCvHsArNmd0ywlJpvsB4xHz0P27TbeWGG0K1dbar4WL+bHx
	qnCyJx58yoDBcQ5RLBR+tdUVW41ZVNs=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add bpf_get_task_cmdline test case
Date: Tue, 18 Nov 2025 20:58:02 +0800
Message-ID: <20251118125802.385503-2-chen.dylane@linux.dev>
In-Reply-To: <20251118125802.385503-1-chen.dylane@linux.dev>
References: <20251118125802.385503-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Create a task, call bpf_get_task_cmdline to retrieve
the cmdline, and check if it succeeds.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/testing/selftests/bpf/prog_tests/task_kfunc.c | 11 +++++++++++
 .../selftests/bpf/progs/task_kfunc_success.c        | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index 83b90335967..c23c0be357d 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -156,6 +156,10 @@ static const char * const vpid_success_tests[] = {
 	"test_task_from_vpid_invalid",
 };
 
+static const char * const cmdline_success_tests[] = {
+	"test_get_task_cmdline",
+};
+
 void test_task_kfunc(void)
 {
 	int i;
@@ -174,5 +178,12 @@ void test_task_kfunc(void)
 		run_vpid_success_test(vpid_success_tests[i]);
 	}
 
+	for (i = 0; i < ARRAY_SIZE(cmdline_success_tests); i++) {
+		if (!test__start_subtest(cmdline_success_tests[i]))
+			continue;
+
+		run_success_test(cmdline_success_tests[i]);
+	}
+
 	RUN_TESTS(task_kfunc_failure);
 }
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 5fb4fc19d26..a7c42e693da 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -367,6 +367,19 @@ int BPF_PROG(task_kfunc_acquire_trusted_walked, struct task_struct *task, u64 cl
 	return 0;
 }
 
+SEC("lsm.s/task_alloc")
+int BPF_PROG(test_get_task_cmdline, struct task_struct *task)
+{
+	char buf[64];
+	int ret;
+
+	ret = bpf_get_task_cmdline(task, buf, sizeof(buf));
+	if (ret < 0)
+		err = 1;
+
+	return 0;
+}
+
 SEC("syscall")
 int test_task_from_vpid_current(const void *ctx)
 {
-- 
2.48.1


