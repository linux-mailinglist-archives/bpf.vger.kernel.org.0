Return-Path: <bpf+bounces-54460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2752A6A54F
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1DB16A542
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D120221F30;
	Thu, 20 Mar 2025 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0c8nFXR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C0C22068D;
	Thu, 20 Mar 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471138; cv=none; b=WGaCnNyVzl5j+CiXUHRE1rLzJXHjpDnO+0O/6s8L88aSU9HkdgbwDHDKnTNJvJDlvcOdZ1ab3YvCweqlxkMcGiXcbLji7Ew4bLrKBHnfmULJejB6kU+MLJ7JfyDc8y6Mh0kj6mBmvm6iXCSAai1yocpuJezDPOv/XbwuBazNHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471138; c=relaxed/simple;
	bh=uXGPOiOOdsppE2rXpARjq1zblWUgfa+EtwPmNGuQXvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLGoL16oJHg3pc557FQ5vHSOXCMyXGvtsYq5agU1zIj2PiDtsM36M/gWFbPimKA7GDxdJG1SHr4LShE2gxPRB2yCOCb3eOdlphHFoUGa/QwdpsPIE153U6wuM7t6z52UYMAWANyVxs2RuHpho7Lcn7+RGng91Nm4zDZ1wWUAfmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0c8nFXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3631C4CEDD;
	Thu, 20 Mar 2025 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471138;
	bh=uXGPOiOOdsppE2rXpARjq1zblWUgfa+EtwPmNGuQXvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L0c8nFXRdyRq+0X2yD+lfta7R/MhEa5H4wWnXSRxwupLbASLRSEovJo8jNUidvRQi
	 upVjI1wA+HzPZA/K7bqiV5zl2NhfU5yHPBLXmzbEoBKtlS3nHIivifReYKJ9v3PUf5
	 H/+FR9qgylclk/tqAlrTaK0ccjzoBJZ9YpBbY9v8tr3C4IGjqbcjax6/anGEetC06/
	 MXHdGJjmJpB+oh8LO4xeX3zOMujPsiJCun9DpdHIcxg1PHnjTmEoyT2K18nMlwBUFp
	 EALlkVv2QDRoz7UdTtumIJGbsjp/c5DQwBIABUsSP40k0wp/dN/oBsiRY7YDEYc4C+
	 MxxSMPviCppEg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH RFCv3 19/23] selftests/bpf: Add uprobe_regs_equal test
Date: Thu, 20 Mar 2025 12:41:54 +0100
Message-ID: <20250320114200.14377-20-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320114200.14377-1-jolsa@kernel.org>
References: <20250320114200.14377-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing uretprobe_regs_trigger to allow the test for both
uprobe and uretprobe and renaming it to uprobe_regs_equal.

We check that both uprobe and uretprobe probes (bpf programs)
see expected registers with few exceptions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 57 ++++++++++++++-----
 .../selftests/bpf/progs/uprobe_syscall.c      |  4 +-
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index b3518f48329c..f1c297a9bb03 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -18,15 +18,17 @@
 
 #pragma GCC diagnostic ignored "-Wattributes"
 
-__naked unsigned long uretprobe_regs_trigger(void)
+__attribute__((aligned(16)))
+__nocf_check __weak __naked unsigned long uprobe_regs_trigger(void)
 {
 	asm volatile (
-		"movq $0xdeadbeef, %rax\n"
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00	\n"
+		"movq $0xdeadbeef, %rax			\n"
 		"ret\n"
 	);
 }
 
-__naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *after)
+__naked void uprobe_regs(struct pt_regs *before, struct pt_regs *after)
 {
 	asm volatile (
 		"movq %r15,   0(%rdi)\n"
@@ -47,15 +49,17 @@ __naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *after)
 		"movq   $0, 120(%rdi)\n" /* orig_rax */
 		"movq   $0, 128(%rdi)\n" /* rip      */
 		"movq   $0, 136(%rdi)\n" /* cs       */
+		"pushq %rax\n"
 		"pushf\n"
 		"pop %rax\n"
 		"movq %rax, 144(%rdi)\n" /* eflags   */
+		"pop %rax\n"
 		"movq %rsp, 152(%rdi)\n" /* rsp      */
 		"movq   $0, 160(%rdi)\n" /* ss       */
 
 		/* save 2nd argument */
 		"pushq %rsi\n"
-		"call uretprobe_regs_trigger\n"
+		"call uprobe_regs_trigger\n"
 
 		/* save  return value and load 2nd argument pointer to rax */
 		"pushq %rax\n"
@@ -95,25 +99,37 @@ __naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *after)
 );
 }
 
-static void test_uretprobe_regs_equal(void)
+static void test_uprobe_regs_equal(bool retprobe)
 {
+	LIBBPF_OPTS(bpf_uprobe_opts, opts,
+		.retprobe = retprobe,
+	);
 	struct uprobe_syscall *skel = NULL;
 	struct pt_regs before = {}, after = {};
 	unsigned long *pb = (unsigned long *) &before;
 	unsigned long *pa = (unsigned long *) &after;
 	unsigned long *pp;
+	unsigned long offset;
 	unsigned int i, cnt;
-	int err;
+
+	offset = get_uprobe_offset(&uprobe_regs_trigger);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		return;
 
 	skel = uprobe_syscall__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "uprobe_syscall__open_and_load"))
 		goto cleanup;
 
-	err = uprobe_syscall__attach(skel);
-	if (!ASSERT_OK(err, "uprobe_syscall__attach"))
+	skel->links.probe = bpf_program__attach_uprobe_opts(skel->progs.probe,
+				0, "/proc/self/exe", offset, &opts);
+	if (!ASSERT_OK_PTR(skel->links.probe, "bpf_program__attach_uprobe_opts"))
 		goto cleanup;
 
-	uretprobe_regs(&before, &after);
+	/* make sure uprobe gets optimized */
+	if (!retprobe)
+		uprobe_regs_trigger();
+
+	uprobe_regs(&before, &after);
 
 	pp = (unsigned long *) &skel->bss->regs;
 	cnt = sizeof(before)/sizeof(*pb);
@@ -122,7 +138,7 @@ static void test_uretprobe_regs_equal(void)
 		unsigned int offset = i * sizeof(unsigned long);
 
 		/*
-		 * Check register before and after uretprobe_regs_trigger call
+		 * Check register before and after uprobe_regs_trigger call
 		 * that triggers the uretprobe.
 		 */
 		switch (offset) {
@@ -136,7 +152,7 @@ static void test_uretprobe_regs_equal(void)
 
 		/*
 		 * Check register seen from bpf program and register after
-		 * uretprobe_regs_trigger call
+		 * uprobe_regs_trigger call (with rax exception, check below).
 		 */
 		switch (offset) {
 		/*
@@ -149,6 +165,15 @@ static void test_uretprobe_regs_equal(void)
 		case offsetof(struct pt_regs, rsp):
 		case offsetof(struct pt_regs, ss):
 			break;
+		/*
+		 * uprobe does not see return value in rax, it needs to see the
+		 * original (before) rax value
+		 */
+		case offsetof(struct pt_regs, rax):
+			if (!retprobe) {
+				ASSERT_EQ(pp[i], pb[i], "uprobe rax prog-before value check");
+				break;
+			}
 		default:
 			if (!ASSERT_EQ(pp[i], pa[i], "register prog-after value check"))
 				fprintf(stdout, "failed register offset %u\n", offset);
@@ -186,13 +211,13 @@ static void test_uretprobe_regs_change(void)
 	unsigned long cnt = sizeof(before)/sizeof(*pb);
 	unsigned int i, err, offset;
 
-	offset = get_uprobe_offset(uretprobe_regs_trigger);
+	offset = get_uprobe_offset(uprobe_regs_trigger);
 
 	err = write_bpf_testmod_uprobe(offset);
 	if (!ASSERT_OK(err, "register_uprobe"))
 		return;
 
-	uretprobe_regs(&before, &after);
+	uprobe_regs(&before, &after);
 
 	err = write_bpf_testmod_uprobe(0);
 	if (!ASSERT_OK(err, "unregister_uprobe"))
@@ -347,7 +372,7 @@ static void test_uretprobe_shadow_stack(void)
 	}
 
 	/* Run all of the uretprobe tests. */
-	test_uretprobe_regs_equal();
+	test_uprobe_regs_equal(false);
 	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
 
@@ -709,7 +734,7 @@ static void test_uprobe_sigill(void)
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
-		test_uretprobe_regs_equal();
+		test_uprobe_regs_equal(true);
 	if (test__start_subtest("uretprobe_regs_change"))
 		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
@@ -728,6 +753,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_race();
 	if (test__start_subtest("uprobe_sigill"))
 		test_uprobe_sigill();
+	if (test__start_subtest("uprobe_regs_equal"))
+		test_uprobe_regs_equal(false);
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall.c b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
index 8a4fa6c7ef59..e08c31669e5a 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall.c
@@ -7,8 +7,8 @@ struct pt_regs regs;
 
 char _license[] SEC("license") = "GPL";
 
-SEC("uretprobe//proc/self/exe:uretprobe_regs_trigger")
-int uretprobe(struct pt_regs *ctx)
+SEC("uprobe")
+int probe(struct pt_regs *ctx)
 {
 	__builtin_memcpy(&regs, ctx, sizeof(regs));
 	return 0;
-- 
2.49.0


