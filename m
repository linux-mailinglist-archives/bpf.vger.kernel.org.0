Return-Path: <bpf+bounces-63848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BACB0B589
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1E8189C8E0
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C996A211706;
	Sun, 20 Jul 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZZmH+YF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A51F5423;
	Sun, 20 Jul 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010681; cv=none; b=IKWn0SeNk1XKEyF4tABjTcRCGpko6dSytxK3iN175RN/b4xLBNxrlt/k2Y1x+upWGV2dn42KWITAB+akvkTMTdfBFVKupJq6DJ6+cIZ50UhomFB2RjJ22e0POIbT2Mb5+wqhoLCMmRRrcg/ab9JCj3GUm6tv34TrDB35Z3SPczI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010681; c=relaxed/simple;
	bh=NBQnh8MyNYWIoskdzLseSfov7zi9ofoZZPrWYPz0A9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugbgJb9xDEISA3XPhquqNgWNq5HPF689VfCuFEtR38qVmR0/wRV18HIwZ62rDorn1QBg7WkKMCkjn56Ns1ZfgN+5A2QKxA0ibcvDt+D/KcIbdDhO5/NuaV2HZZrfWMcorbMnaJOvrVwz/v3IOc/A3tAH7ue3oYvJVp3gacM6B9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZZmH+YF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B13EC4CEE7;
	Sun, 20 Jul 2025 11:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010681;
	bh=NBQnh8MyNYWIoskdzLseSfov7zi9ofoZZPrWYPz0A9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rZZmH+YFl1ejyc/xQ0wAfEUgQqgSuIG96TnQWfoE3skG6IAw+IdL5OwPUUOy6oU1m
	 C5cIQ41QZORpoZRy00tSWnrp+j7ijx/bGXAKrQ8Hhb89vE0Nkd9dKiaQ/Nb+ky6erN
	 UIJozftKpeCbTUl0QRxJj8U6aFErmCd3tAnQRa49/FGG6JOvhk7o4DXN+o8W1OpTZ+
	 RxfQPMIoYNmzDKXZqEkAbpWuFXETPqI99xJ78IHZ3Tf/p10YOQ1Ae80oVp3HQ2CA68
	 TW6gN4spVeA1X7KxEwyTAPM2i8t9hQKP2ns7myijiN70iGs8f4761wyUvO+8fI4hIa
	 UYydsp8XZ7yRw==
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
Subject: [PATCHv6 perf/core 16/22] selftests/bpf: Add uprobe syscall sigill signal test
Date: Sun, 20 Jul 2025 13:21:26 +0200
Message-ID: <20250720112133.244369-17-jolsa@kernel.org>
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

Make sure that calling uprobe syscall from outside uprobe trampoline
results in sigill signal.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 3d27c8bc019e..02e98cba5cc6 100644
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
2.50.1


