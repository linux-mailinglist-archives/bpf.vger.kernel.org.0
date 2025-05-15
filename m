Return-Path: <bpf+bounces-58305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34954AB863A
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8F0A02B09
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984429B8CA;
	Thu, 15 May 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaXu2hww"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4C6298C12;
	Thu, 15 May 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311348; cv=none; b=oRY2k8JyrJv+/3Vn/Uf9G4SO8W+DaJmnyRXxwKlkjg7Pj4TRzQhk1M5SndMVUhedvjnkOWYNVxMGjSSYq70lz3wk7SH72cM7hQ18GstHZ08CBE3OaE2kk6q8bO6vwMDxZ3pbAnG8VRh7NvZ81aJkoJU7aZBqHdraqKFkTyBTv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311348; c=relaxed/simple;
	bh=qgCFyzzXk7WUIGud/uwZfcFiloi7fK7NFsMYWURP+5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvpwUpMS1G/g3Q1iKVkI4QRUJm6w0BCFiscW/D7E9Rdk6JcXCs/BUraFbWAqmuOhJY3356tG/6x7sU6d/e6WnQj1lKRMWBJ1ipgVZvaGiyu2nKfnAY+DDrjnar9h8z5cphEx7+BQfF0k4T5mt5LZTb2sFJAaHy+0sh2JWTBkGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaXu2hww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158ABC4CEE7;
	Thu, 15 May 2025 12:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311345;
	bh=qgCFyzzXk7WUIGud/uwZfcFiloi7fK7NFsMYWURP+5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaXu2hwwYIfAkZLA5sYcJor94I552Njqbv9uT7FRXjNcX3nthxC5+ARytXWQT8ZLh
	 1sTrw+sxIKr53i1BNw3HZnjxHXxN7XoZ94eDF9K89P4iUKeKBzm11sTGRIB8VyKlVC
	 tx4Fw6CQ7XJMQ+2IESYEWJYEOFc/nutiz5Y1TYjvFRS4XeaHfW2ebz9FyJnTTi2OOU
	 pw10pn/Oql/NUQgkesCAtmc2d8OGuu8VTyP8JYWRO60bkCf6Sq+tauxkwQ1dMQKAlj
	 152EAldIDPV+DuebOEzLYFb9JViT42DayUmF8+gEeQPo05/WpQyH8wJkda1pUsSGrQ
	 fyfuAo/08ybrw==
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
Subject: [PATCHv2 perf/core 18/22] selftests/bpf: Add uprobe_regs_equal test
Date: Thu, 15 May 2025 14:11:15 +0200
Message-ID: <20250515121121.2332905-19-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 56 ++++++++++++++-----
 .../selftests/bpf/progs/uprobe_syscall.c      |  4 +-
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index fa0ee813472f..645de7d71948 100644
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
@@ -621,7 +646,8 @@ static void test_uretprobe_shadow_stack(void)
 	/* Run all the tests with shadow stack in place. */
 	shstk_is_enabled = true;
 
-	test_uretprobe_regs_equal();
+	test_uprobe_regs_equal(false);
+	test_uprobe_regs_equal(true);
 	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
 
@@ -763,7 +789,7 @@ static void test_uprobe_sigill(void)
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
-		test_uretprobe_regs_equal();
+		test_uprobe_regs_equal(true);
 	if (test__start_subtest("uretprobe_regs_change"))
 		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
@@ -782,6 +808,8 @@ static void __test_uprobe_syscall(void)
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


