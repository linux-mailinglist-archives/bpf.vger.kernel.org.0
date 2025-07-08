Return-Path: <bpf+bounces-62675-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89414AFCC23
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E894879D8
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C0F2DFA24;
	Tue,  8 Jul 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gijJAnau"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011212DC32B;
	Tue,  8 Jul 2025 13:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981213; cv=none; b=bpT6PXP/k6yGqW3lgf7h4asmeaw6Ua2CxKQsgSjHlY2CheUpzDA5iDaAEnWz8Q9/WuOqAV8mu0zC2xiq7ZXefDOQTp9VG8OhLbOrkZ+nt5S6XX+MeqYMCWj70ISlb7iAgJHa4CkwEjmpQ6RWzDwJHykTi/maNKC0LHUiRrZcoSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981213; c=relaxed/simple;
	bh=vJD2P+yQBieCXkhAy84uB8BCox7Bdj9MOS71Wbou8FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDz5UO4tQgjaZ8ut+hyLuomxRcaq4ExSl3vCjCfMPgJuGYUxdaaTeTpIZUL1y5tdg+q1LVB/cnTCPa1lA2aSlS6aKLHw85R2RFWjRwROBgDL1NYnGyg++G05QHveMUFIH9H/xE5nLEUxo254DMWCRrnzeulvuV8aESfsV4y4j0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gijJAnau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548ABC4CEED;
	Tue,  8 Jul 2025 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981212;
	bh=vJD2P+yQBieCXkhAy84uB8BCox7Bdj9MOS71Wbou8FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gijJAnau+L+TBq8kSd26Sz+LHT0p+7Vv0bKOnWKzDprZQCfptS7uZnp7mfT0ztDPH
	 WuU/Rf1wnCKUsplw6sJcR8DtpwIP6m/XSuBAyEYwTqYbqaQRl6PpsxoEsEXhsL7lGl
	 ny+NPzgmM2AtxAW1o7jiQlK1idPQcabc7yJxeJtHZ0bSPKPa+2C/1Hzgk9v5eZqU1D
	 0emY0ytpRELZSZJkKGQJBmwtxcl9Lx5MPDLj8VaqarK22y5zu5QYvd/zy/vwlrxvg0
	 T8vr2iTNO/KSaV3TcBrHHoEm+vTNVjS8zu4ifGbPMzEproCMtMFVn3KjlFDAz5eLVn
	 20MegD0LLuu9A==
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
Subject: [PATCHv4 perf/core 16/22] selftests/bpf: Add uprobe syscall sigill signal test
Date: Tue,  8 Jul 2025 15:23:25 +0200
Message-ID: <20250708132333.2739553-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708132333.2739553-1-jolsa@kernel.org>
References: <20250708132333.2739553-1-jolsa@kernel.org>
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


