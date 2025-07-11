Return-Path: <bpf+bounces-63025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1195DB01653
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593EF76536C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B911C22FE0F;
	Fri, 11 Jul 2025 08:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV6tRJvi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDFD223719;
	Fri, 11 Jul 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222785; cv=none; b=TQriUpGV0v6HAESREppt9CzGAH8/GJXsMx4uccb/O5biGzl4oTW0nMp8norvCIryIok0Ax9ivmdwMW5w4UCF1KowRsdbxAvXcIe/L/n5JDwD33f3Kz2PxyRDWMKBPjZY5TMD5MOF14vlNl7LZR1K6iTbVBZtRrw4WfCl2+DdII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222785; c=relaxed/simple;
	bh=vJD2P+yQBieCXkhAy84uB8BCox7Bdj9MOS71Wbou8FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTOx2J1jooWrgBMm1tgQeVV3s8gdwEXyqvdJDqeWJfPqiKbVOg+fouajd8LZsy7agh5ZOuvPGud9fJbyItVz/FVt6CoSmBuByN7OjDhEg+D+FWvOfYYNm0LmZwx6edTaErIQa2jXmr9atYwxIJKHkVlnkmtq/c0BrY5m2J5/erU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV6tRJvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBB1C4CEEF;
	Fri, 11 Jul 2025 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222784;
	bh=vJD2P+yQBieCXkhAy84uB8BCox7Bdj9MOS71Wbou8FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XV6tRJvijSa3OA+7bi07uxoJeyPTLekEYduz9DA4hOedbMFHmW236BzPvkt9mLyS5
	 b1RrJrX1tK86YrYAAMCTmOCdKYL1Au74A59LWlMv+5t2eb3OwNtUjWrIMfpqjWuT2/
	 AuKU4kdlKuWCfqaz6zzxXj6kOdnzcGJClHMX6dIFohemE1RGQ3NGMT++dz7jN8EdHv
	 lU2jV7VgvbqLct3CihabBv9dQBj9BWvCi5ns2c1qF03TCksRQP0yyaQthh41FfdkLU
	 kzcoOyVn/XlWcGoqW9HWj810UlR6dzUFADKEXER7XmUsCoXh7z6G2i3PA2Q8BF31hl
	 ttUqc4j+pX4PQ==
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
Subject: [PATCHv5 perf/core 16/22] selftests/bpf: Add uprobe syscall sigill signal test
Date: Fri, 11 Jul 2025 10:29:24 +0200
Message-ID: <20250711082931.3398027-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711082931.3398027-1-jolsa@kernel.org>
References: <20250711082931.3398027-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that calling uprobe syscall from outside uprobe trampoline
results in sigill signal.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 043570fdbd75..bd59b4b5bd3c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -735,6 +735,40 @@ static void test_uprobe_race(void)
 	ASSERT_FALSE(USDT_SEMA_IS_ACTIVE(race), "race_semaphore");
 }
 
+#ifndef __NR_uprobe
+#define __NR_uprobe 336
+#endif
+
+static void test_uprobe_sigill(void)
+{
+	int status, err, pid;
+
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		return;
+	/* child */
+	if (pid == 0) {
+		asm volatile (
+			"pushq %rax\n"
+			"pushq %rcx\n"
+			"pushq %r11\n"
+			"movq $" __stringify(__NR_uprobe) ", %rax\n"
+			"syscall\n"
+			"popq %r11\n"
+			"popq %rcx\n"
+			"retq\n"
+		);
+		exit(0);
+	}
+
+	err = waitpid(pid, &status, 0);
+	ASSERT_EQ(err, pid, "waitpid");
+
+	/* verify the child got killed with SIGILL */
+	ASSERT_EQ(WIFSIGNALED(status), 1, "WIFSIGNALED");
+	ASSERT_EQ(WTERMSIG(status), SIGILL, "WTERMSIG");
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -755,6 +789,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
+	if (test__start_subtest("uprobe_sigill"))
+		test_uprobe_sigill();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.50.0


