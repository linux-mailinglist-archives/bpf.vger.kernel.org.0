Return-Path: <bpf+bounces-78072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF83CFCE50
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 10:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A201F30A88A4
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D52F6900;
	Wed,  7 Jan 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljRT/CaQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8649659;
	Wed,  7 Jan 2026 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778399; cv=none; b=ChA90Bn7J+TAUVIqqr6NJ3PbJK2DipNc1el+/qhIBXSFJL/8LKwcknuXc2JdLZ2HTA3kdQXRIyiJXu1xDh896ppUoZGMCp7nP85nFudz9bdTNQUXodQrbNz/KkyB2p4gXfeI2qIGSvN6m5IHLEcN92XktN7fPdxB+bVpCaSlS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778399; c=relaxed/simple;
	bh=fcHHOaQzVIpjZZVBB6MbIxlqagyeNtB33hqQC3c9Nms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICXQ1/5k6vjfs370R48xz2s17ipdUJOUkH0zuymsyJlqltsL50QY/SyDhekmuHoqzWsVh+VzT0CbbB31t7LXHzmFnHR9rQ4gGKV3D7qqEfiZh+WWBQLdvEXk431jr5HRxGMK21b4vAU5aMb+HJZQN1L8Pwv1TyMBiELtUXQqxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljRT/CaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6BFC4CEF7;
	Wed,  7 Jan 2026 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767778398;
	bh=fcHHOaQzVIpjZZVBB6MbIxlqagyeNtB33hqQC3c9Nms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ljRT/CaQGA0P+r1we4XG2EBhSLwD/70pG9mVCQocq4lTaLvK5dV/WoqudiHL/fUKo
	 PyQDybJatQ+49AEZFiD/ZTHnR0ijLrHZnHtqG+15hiVn9Dls5C+bdKjMtLbfczLr/I
	 ch9J7EX9AR7eV4IfAPjU5R0XdCUcdqx8zU4tKFCmsoExPDCn1FM5SneKSmE2CbzOE8
	 XindnCRTfJJ/ku7cWHmV8ssyVHv9qx8yJxQ/SbyXllDTjaRqZhvvwuQJ9OcOYtpQ0T
	 krpBHPZw4ZJbSCgS0kQrUk9U62AcDAZv3K8yyn7uVHsOoWNeDAHiAeswkyxWAYVE8H
	 I+DdHdAzkwYgA==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>
Cc: Song Liu <song@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	Yonghong Song <yhs@fb.com>,
	Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add test for bpf_override_return helper
Date: Wed,  7 Jan 2026 10:32:56 +0100
Message-ID: <20260107093256.54616-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107093256.54616-1-jolsa@kernel.org>
References: <20260107093256.54616-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not actually test the bpf_override_return helper functionality
itself at the moment, only the bpf program being able to attach it.

Adding test that override prctl syscall return value on top of
kprobe and kprobe.multi.

Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
v1 changes:
- added ack from Song
- moved SYS_PREFIX to trace_helpers.h

 .../bpf/prog_tests/kprobe_multi_test.c        | 44 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_override.c         | 15 +++++++
 tools/testing/selftests/bpf/trace_helpers.h   | 12 +++++
 3 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 6cfaa978bc9a..9caef222e528 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <sys/prctl.h>
 #include <test_progs.h>
 #include "kprobe_multi.skel.h"
 #include "trace_helpers.h"
@@ -540,6 +542,46 @@ static void test_attach_override(void)
 	kprobe_multi_override__destroy(skel);
 }
 
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
+	if (!ASSERT_OK_PTR(skel->links.test_override, "bpf_program__attach_kprobe_multi_opts"))
+		goto cleanup;
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
+	if (!ASSERT_OK_PTR(skel->links.test_kprobe_override, "bpf_program__attach_kprobe"))
+		goto cleanup;
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
@@ -597,6 +639,8 @@ void test_kprobe_multi_test(void)
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
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 9437bdd4afa5..a5576b2dfc26 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -4,6 +4,18 @@
 
 #include <bpf/libbpf.h>
 
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
 #define __ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
 #define ALIGN(x, a)		__ALIGN_MASK(x, (typeof(x))(a)-1)
 
-- 
2.52.0


