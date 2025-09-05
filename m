Return-Path: <bpf+bounces-67614-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1059EB46509
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 22:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311671CC2E35
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1490283FFB;
	Fri,  5 Sep 2025 20:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdJWkdDB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3622E03EE;
	Fri,  5 Sep 2025 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105890; cv=none; b=LJ6PZpyq8Suske69DAM4856Jhe1tCIe+hBpqhlPWseQvxHB/mnQbUh6/E2l6AahyoRmLteN80ME9KyKbkHHKfgDr5JUJZ2a+Jo18Dt53licFvPIjpk8vDPFp6ThcwxmPIxSBF6BfmJVlN9cXQpVJjJlll8lIOkmuy/fad6+hPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105890; c=relaxed/simple;
	bh=QMZ/veCn4xaV39aEXQXHqu9USRqQHNLeV/rMSYlEz7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trhvZmu21cfEJb6LB0QQCPZpHGyRg9w4MbSzRWUIPjpKBvfPJGspg5qBPOzCBiF3chZOAruY/P9CUcRozKrd5Vqi9ja4tQRaK42qtV5bufPv1XDB5wRrrJuwUhTUPJijIttUlq0zMXAuYsJmc7WVvk/L+ysvf9q39qlPx6A9kM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdJWkdDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334CDC4CEF1;
	Fri,  5 Sep 2025 20:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757105889;
	bh=QMZ/veCn4xaV39aEXQXHqu9USRqQHNLeV/rMSYlEz7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SdJWkdDBr3RiVA9C6GFt0y6pOYMK54XtG1YPwxmvnZrQmWt2cmV45eVM1HYhCMMHg
	 cdFZ2EfXg964oGBSeyTeu1e91G8CxETBRkCO24M1R7W1zDZg57aKEZBOvpOs0IVtSL
	 f5bx2Bzyjleey1SM6iKCbA18AUEn48tgQwspVT/rVSqfb0y3xbTmnh33yMdzFWMpT8
	 gv8T/LsDvnaczAV8W1/lvY+d5Yb5hxOEl0IiiSBq0EuYk7bb1uD7I6YOidxGcg0UxX
	 VP+EsqHpCI5DxLoSI4lXHZRQUONtb5IJlmf47wLviW0RHcZiCv0I5XsxEoNumNRdyJ
	 cH6KuYf1iIdLw==
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
	Ingo Molnar <mingo@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH perf/core 2/3] selftests/bpf: Fix uprobe_sigill test for uprobe syscall error value
Date: Fri,  5 Sep 2025 22:57:30 +0200
Message-ID: <20250905205731.1961288-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905205731.1961288-1-jolsa@kernel.org>
References: <20250905205731.1961288-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uprobe syscall now returns -ENXIO errno when called outside
kernel trampoline, fixing the current sigill test to reflect that
and renaming it to uprobe_error.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 34 ++++---------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 5da0b49eeaca..6d75ede16e7c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -757,34 +757,12 @@ static void test_uprobe_race(void)
 #define __NR_uprobe 336
 #endif
 
-static void test_uprobe_sigill(void)
+static void test_uprobe_error(void)
 {
-	int status, err, pid;
+	long err = syscall(__NR_uprobe);
 
-	pid = fork();
-	if (!ASSERT_GE(pid, 0, "fork"))
-		return;
-	/* child */
-	if (pid == 0) {
-		asm volatile (
-			"pushq %rax\n"
-			"pushq %rcx\n"
-			"pushq %r11\n"
-			"movq $" __stringify(__NR_uprobe) ", %rax\n"
-			"syscall\n"
-			"popq %r11\n"
-			"popq %rcx\n"
-			"retq\n"
-		);
-		exit(0);
-	}
-
-	err = waitpid(pid, &status, 0);
-	ASSERT_EQ(err, pid, "waitpid");
-
-	/* verify the child got killed with SIGILL */
-	ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
-	ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
+	ASSERT_EQ(err, -1, "error");
+	ASSERT_EQ(errno, ENXIO, "errno");
 }
 
 static void __test_uprobe_syscall(void)
@@ -805,8 +783,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
-	if (test__start_subtest("uprobe_sigill"))
-		test_uprobe_sigill();
+	if (test__start_subtest("uprobe_error"))
+		test_uprobe_error();
 	if (test__start_subtest("uprobe_regs_equal"))
 		test_uprobe_regs_equal(false);
 	if (test__start_subtest("regs_change"))
-- 
2.51.0


