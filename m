Return-Path: <bpf+bounces-56345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4642CA95852
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401D2165773
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934121D5A2;
	Mon, 21 Apr 2025 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqFFJ7Zl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE921B9FC;
	Mon, 21 Apr 2025 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272066; cv=none; b=tDzyumZsDF1802edCzvyGfZnrZ1bbb7EpTvodizXhuwSDppeSugsFUOOpgjAvkSrCBJBNotzR3ooxiSpeF7CPf4406NkDXkwZ10F+opqpP4CuI6YfJiaaCGVE59IvoC0iGKRVpVh1lD48oILlPuTQDHiWQ8ziNTYm4n2RE5Ykjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272066; c=relaxed/simple;
	bh=SREC6BOLxkMw16dJMZEBgmN7wOFw0w7YqTHRg+lx7B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuSpwZ+ABNVwBuoI+V6+KMxUmsopRQnWeNW2MDrVmYT0O9up46C4yb4mLhdsgO7UZW+cciIbBnAfYAPWMKbSETHkouCfdXl80dfDIvYo2Yfu5wVIdWXWpnh8pkEa+BLIwwjwU/OXiLjc27Df5lVwXvxSuB/R6fYXwmyHQ0JQPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqFFJ7Zl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7D0C4CEE4;
	Mon, 21 Apr 2025 21:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272065;
	bh=SREC6BOLxkMw16dJMZEBgmN7wOFw0w7YqTHRg+lx7B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqFFJ7ZlSWWVKpVAwBRwz3KNuAh4xFdJiRB9GO9GdvF5u8Bap50B7QhaobvTouMQM
	 +6X/nz7OhNTxmsgVcchSItkIdl3J8JJzYiLzT22RSRAPuCtu67STa66d0sRHeO2/rU
	 Nsspe1zW5vOq/OLmZRtc+dQ76bgh09HMswKzQrFF/YpVDYBg/Le7+BEVOM0IzrZ+Ty
	 Kv012+dJp9pKizTOePoCsy3KCy/7gDnRhaqrem3l2/kA901sbH1EkI7abmNRli0vSD
	 ihDawBFnxl8dSm8royf/2Mtb53jVHYzzbvWu6g1ZkCQrzEfoV8gj3onhlRxSRcDUPb
	 Wh4ccspI4m2fg==
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
Subject: [PATCH perf/core 16/22] selftests/bpf: Add uprobe syscall sigill signal test
Date: Mon, 21 Apr 2025 23:44:16 +0200
Message-ID: <20250421214423.393661-17-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
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
index 57ef1207c3f5..f001986981ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -691,6 +691,40 @@ static void test_uprobe_race(void)
 		pthread_join(threads[i], NULL);
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
@@ -711,6 +745,8 @@ static void __test_uprobe_syscall(void)
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


