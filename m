Return-Path: <bpf+bounces-59745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EC4ACF081
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAF4174877
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32FE23D28C;
	Thu,  5 Jun 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ssZ/+q4o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA21235072;
	Thu,  5 Jun 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130023; cv=none; b=GTVAaL8pOTl6gsciBaaBNj5tOHrV29QivF7fEk/f58tGFyEcMzr59d5bnaOOu+Cy2RN1enAVP6KVENaOELBQvvpPc8k3Aq4k1RjO9Lm61YTQCD5xNjROsNI63QuGf4be57yEOjF6kwC3EmXy/zl7HOVCYbh6ixplTZFoVBU9KEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130023; c=relaxed/simple;
	bh=homajw06345S0l4YIs2RkqSbi/C7IEpQUvMFjl5CQ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAxtb68yFdDIOk9JBjapBTD1ZBYqtL5s5haINCXisT+lzRIBx+IX2E+BSwa1PIoqGLeYC94FlmnSdZMpSZ90cemDZe7dAR9Pq09miW2e+Vb6ISROBNyf1UKsPrYvX0lIX+Xdsj5v1ouXEDuJ7tOH8ntLgujxcwwB/EiMvf+ZUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ssZ/+q4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE0FC4CEE7;
	Thu,  5 Jun 2025 13:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749130023;
	bh=homajw06345S0l4YIs2RkqSbi/C7IEpQUvMFjl5CQ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ssZ/+q4oS1F9zHoKYoabsKnU1EICmVGkYwct1HnU+lODvQ6zxxZYlPfBDniXvbKDR
	 WgQXenxIisMoNj76F2CtpkF4Uz+z2uYXrMDFEUq8YQN9ICVKYqjL5lgZzgogK31/LN
	 cJlCMpSlvIqZPXP0+wXMZQNfQezVaaH/vG1J1UPtlIFu9/XU/MCalAuxvp6tg/8+lh
	 pIAHhLm/KRoFvpaTwjwsenumSbArPxaqYNOT5oV19kOakHSBrAm+VlRJ5Cc90+tkz4
	 VKpvdRkwqYCTBqS9MVR3edOMRK+La34XYq6fACs/NYBKq9smSbxt/GzTqBZlK22pUA
	 cOb/wS4Hil/Ig==
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
Subject: [PATCHv3 perf/core 16/22] selftests/bpf: Add uprobe syscall sigill signal test
Date: Thu,  5 Jun 2025 15:23:43 +0200
Message-ID: <20250605132350.1488129-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605132350.1488129-1-jolsa@kernel.org>
References: <20250605132350.1488129-1-jolsa@kernel.org>
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
index 792ff7d411d2..94be99dcd1f3 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -740,6 +740,40 @@ static void test_uprobe_race(void)
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
@@ -760,6 +794,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
+	if (test__start_subtest("uprobe_sigill"))
+		test_uprobe_sigill();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.49.0


