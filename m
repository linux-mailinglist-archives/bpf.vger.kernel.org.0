Return-Path: <bpf+bounces-73625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B440C35BF4
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 14:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D5324F83B6
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0779F3164C1;
	Wed,  5 Nov 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lo6PWFFo"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9F73161BC;
	Wed,  5 Nov 2025 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347588; cv=none; b=eH4aV4SRQsVRdwaKWYFkfFuX6KIrpKc0zImu8RD5tfggw4g+XdtKIZzGtlmukhulBiG6RwEsYFfWlzYEMouwf+kSnHYYn1Qa6w1VBHGnc7XGor4si5Dj++2467Q9Kl2CUnfE1DphHBjU90/uXppwm/x/YRRcSAzsf+PE+DzZKsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347588; c=relaxed/simple;
	bh=pYdcHxsRXCEZFJBLVGty+ksLBg504S9Nj7797A0+RDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuzI5r1SFsrvvthO9Koyjl3XtbrAu+HJjTcv0rv/MQ6CPvGtN2QDfuYH/6YT5qNHUp4ba049Mgw520Wn+GA0GqjWTAV46dGEw0IGqCjn80mAO+sOHUI+oHVZLNwdrfbwHZ9yImxGp9niU4zNQyXKbbsESxyfkEhklI2R0yEU0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lo6PWFFo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E96C4CEF8;
	Wed,  5 Nov 2025 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762347588;
	bh=pYdcHxsRXCEZFJBLVGty+ksLBg504S9Nj7797A0+RDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lo6PWFFomtjkMPv9RA6+wNc5mPpF9LdKXUl4uGjIockxE58Bo3dfCp+m7aVZkrxVa
	 qSHEIK+CmAFYbUKQ5qFuaFjCoLHSvcAnH7fr/jsAQ/ddBCM7szS9Vd6OISh+o/+kpz
	 yFh43T6Ne8ErIXehYOjWn412WMvKeMLGdKPs764oiZ0WYnxBq3DGSVcNmtbgjEd9/U
	 76ltNZgtGyCjjTXm0qUADIxuK1aeR0xfE1JjtcHIpeENxkSb5FPJM5IBRsFmfIitGG
	 tzfqpv11GccEVaYFnvxCgWw5S3xVY9WrwgoslXARgAjqjzvafPBypOnHRVcDkSvMW0
	 iAcJQJ013PXYw==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH 2/2] selftests/bpf: Add test for bpf_override_return helper
Date: Wed,  5 Nov 2025 13:59:24 +0100
Message-ID: <20251105125924.365205-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105125924.365205-1-jolsa@kernel.org>
References: <20251105125924.365205-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not actualy test the bpf_override_return helper functionality
itself at the moment, only the bpf program being able to attach it.

Adding test that override prctl syscall return value on top of
kprobe and kprobe.multi.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 61 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_override.c         | 15 +++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 6cfaa978bc9a..b5e5cc54b89a 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <sys/prctl.h>
 #include <test_progs.h>
 #include "kprobe_multi.skel.h"
 #include "trace_helpers.h"
@@ -540,6 +542,63 @@ static void test_attach_override(void)
 	kprobe_multi_override__destroy(skel);
 }
 
+/* XXX I'll move this to common place and share with
+ * SYS_NANOSLEEP_KPROBE_NAME macro on repost.
+ */
+#ifdef __x86_64__
+#define SYS_PREFIX "__x64_"
+#elif defined(__s390x__)
+#define SYS_PREFIX "__s390x_"
+#elif defined(__aarch64__)
+#define SYS_PREFIX "__arm64_"
+#elif defined(__riscv)
+#define SYS_PREFIX "__riscv_"
+#else
+#define SYS_PREFIX ""
+#endif
+
+static void test_override(void)
+{
+	struct kprobe_multi_override *skel = NULL;
+	int err;
+
+	skel = kprobe_multi_override__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_empty__open_and_load"))
+		goto cleanup;
+
+	skel->bss->pid = getpid();
+
+	/* no override */
+	err = prctl(0xffff, 0);
+	ASSERT_EQ(err, -1, "err");
+
+	/* kprobe.multi override */
+	skel->links.test_override = bpf_program__attach_kprobe_multi_opts(skel->progs.test_override,
+						SYS_PREFIX "sys_prctl", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_override, "bpf_program__attach_kprobe_multi_opts")) {
+		goto cleanup;
+	}
+
+	err = prctl(0xffff, 0);
+	ASSERT_EQ(err, 123, "err");
+
+	bpf_link__destroy(skel->links.test_override);
+	skel->links.test_override = NULL;
+
+	/* kprobe override */
+	skel->links.test_kprobe_override = bpf_program__attach_kprobe(skel->progs.test_kprobe_override,
+							false, SYS_PREFIX "sys_prctl");
+	if (!ASSERT_OK_PTR(skel->links.test_kprobe_override, "bpf_program__attach_kprobe")) {
+		goto cleanup;
+	}
+
+	err = prctl(0xffff, 0);
+	ASSERT_EQ(err, 123, "err");
+
+cleanup:
+	kprobe_multi_override__destroy(skel);
+}
+
 #ifdef __x86_64__
 static void test_attach_write_ctx(void)
 {
@@ -597,6 +656,8 @@ void test_kprobe_multi_test(void)
 		test_attach_api_fails();
 	if (test__start_subtest("attach_override"))
 		test_attach_override();
+	if (test__start_subtest("override"))
+		test_override();
 	if (test__start_subtest("session"))
 		test_session_skel_api();
 	if (test__start_subtest("session_cookie"))
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_override.c b/tools/testing/selftests/bpf/progs/kprobe_multi_override.c
index 28f8487c9059..14f39fa6d515 100644
--- a/tools/testing/selftests/bpf/progs/kprobe_multi_override.c
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_override.c
@@ -5,9 +5,24 @@
 
 char _license[] SEC("license") = "GPL";
 
+int pid = 0;
+
 SEC("kprobe.multi")
 int test_override(struct pt_regs *ctx)
 {
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	bpf_override_return(ctx, 123);
+	return 0;
+}
+
+SEC("kprobe")
+int test_kprobe_override(struct pt_regs *ctx)
+{
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
 	bpf_override_return(ctx, 123);
 	return 0;
 }
-- 
2.51.1


