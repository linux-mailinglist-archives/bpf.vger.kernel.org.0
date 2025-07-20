Return-Path: <bpf+bounces-63850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D2B0B588
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DC93BCA3B
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CA321480B;
	Sun, 20 Jul 2025 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tU1fuxpn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C811F91D6;
	Sun, 20 Jul 2025 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010705; cv=none; b=RsNkSzoBNnEDT0La627VYyPz7mB0Cxrc1H2OMk5XZLVICUVsUNcxjpRT6P3ty0otRrwp2UY666x/JI+lqgHeYohW3UXO7VZRqpXYn3AyY+0UMPdppfVs2xvZcCwxwVkv1xzZ66SlxzFcKS5+Seh7phCzJPijq7A8uYutP4/XdLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010705; c=relaxed/simple;
	bh=TdfJfSEDtNa4TMnwpX+E6AWQrtBa2VwBe7vfj6B5v4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U466AmLS067spjo64ZIW/m6Q/OfI8rwb5v5yKOfFko6YTVLr5MDRaBVtRjmfkouezH20iW1ve7mKbmmWcrQRF1jaMxjON06qlrZhp/xm3jTFt3K9BW92XROW8hQ5o4dZlZN87sKJpZwMdYspJkNm2r9AEJVdIZZkAtQmKtq0aic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tU1fuxpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C53C4CEE7;
	Sun, 20 Jul 2025 11:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010705;
	bh=TdfJfSEDtNa4TMnwpX+E6AWQrtBa2VwBe7vfj6B5v4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tU1fuxpnWSKFQnIT0xZ2yNOKhvtEUkC7QuBQ2G/n2p9+bC8l0X9Sma/ZTvL/8RJAw
	 TsYcbQBBOS05nBfjNl6zG7uTV4eWgFckP9h6srPVafV6dOSq/IbIYKiLxwoVnP515d
	 W867c+j9W6/6AADHebM5AWWBE0ar3vZllFHRzkK7CTz5P0wdTQxuz64f//lnyUoR6b
	 9F/Fmx1GmUw4fecdzIYE2q1GF+1TMdC4nnqLwFg6+Fn33mKAI7Z+FoFtox6S3POxte
	 1nBax4eR7WVNq9B6UZd8s2fV/LZDirx3C+IakkBfQPtEDzOBI6z5ujUT4kvPraeEFX
	 7V5Muthq6WDGw==
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCHv6 perf/core 18/22] selftests/bpf: Add uprobe_regs_equal test
Date: Sun, 20 Jul 2025 13:21:28 +0200
Message-ID: <20250720112133.244369-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720112133.244369-1-jolsa@kernel.org>
References: <20250720112133.244369-1-jolsa@kernel.org>
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

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 56 ++++++++++++++-----
 .../selftests/bpf/progs/uprobe_syscall.c      |  4 +-
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 02e98cba5cc6..36ce9e261b5c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -22,15 +22,17 @@
 
 #pragma GCC diagnostic ignored "-Wattributes"
 
-__naked unsigned long uretprobe_regs_trigger(void)
+__attribute__((aligned(16)))
+__nocf_check __weak __naked unsigned long uprobe_regs_trigger(void)
 {
 	asm volatile (
+		".byte 0x0f, 0x1f, 0x44, 0x00, 0x00\n" /* nop5 */
 		"movq $0xdeadbeef, %rax\n"
 		"ret\n"
 	);
 }
 
-__naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *after)
+__naked void uprobe_regs(struct pt_regs *before, struct pt_regs *after)
 {
 	asm volatile (
 		"movq %r15,   0(%rdi)\n"
@@ -51,15 +53,17 @@ __naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *after)
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
@@ -99,25 +103,37 @@ __naked void uretprobe_regs(struct pt_regs *before, struct pt_regs *after)
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
@@ -126,7 +142,7 @@ static void test_uretprobe_regs_equal(void)
 		unsigned int offset = i * sizeof(unsigned long);
 
 		/*
-		 * Check register before and after uretprobe_regs_trigger call
+		 * Check register before and after uprobe_regs_trigger call
 		 * that triggers the uretprobe.
 		 */
 		switch (offset) {
@@ -140,7 +156,7 @@ static void test_uretprobe_regs_equal(void)
 
 		/*
 		 * Check register seen from bpf program and register after
-		 * uretprobe_regs_trigger call
+		 * uprobe_regs_trigger call (with rax exception, check below).
 		 */
 		switch (offset) {
 		/*
@@ -153,6 +169,15 @@ static void test_uretprobe_regs_equal(void)
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
@@ -190,13 +215,13 @@ static void test_uretprobe_regs_change(void)
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
@@ -616,7 +641,8 @@ static void test_uretprobe_shadow_stack(void)
 	/* Run all the tests with shadow stack in place. */
 	shstk_is_enabled = true;
 
-	test_uretprobe_regs_equal();
+	test_uprobe_regs_equal(false);
+	test_uprobe_regs_equal(true);
 	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
 
@@ -772,7 +798,7 @@ static void test_uprobe_sigill(void)
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
-		test_uretprobe_regs_equal();
+		test_uprobe_regs_equal(true);
 	if (test__start_subtest("uretprobe_regs_change"))
 		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
@@ -791,6 +817,8 @@ static void __test_uprobe_syscall(void)
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
2.50.1


