Return-Path: <bpf+bounces-52360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD23A42291
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 15:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D614189E6DB
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D3314375C;
	Mon, 24 Feb 2025 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQGFrXR4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726A31624F4;
	Mon, 24 Feb 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405906; cv=none; b=Q3+sTAQqzS2xHuUkhzsMSZlnwUIUQOukWjupCjp3M635HsEg1x41cbaRPQgPj458enypfufL00dfewSyebYAyweyKTkWwSKl7YTR8FqNHlBgzSaJXVmSZpKpOqNvuuD/tH8L4MhWhroShR6df4NXY0wi64rtRXE3aM6uWeLq3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405906; c=relaxed/simple;
	bh=T05ccRrW+5iNE/vBxthb+1sXi/TkcmqToBotvoslBxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CpY4+57Bysq6UpaHc8xBxT38tgGakIb9EqE67CL99T+vPFIGV2wpwZu8gKZAFGX6CxwT4RgnN4KKhy5jTZu6reS87Q2keaJ1NdqMYkn1LlJ9upCcDH7LAFJko3IANySlJUlJjQuq03R1k8t9qbFpM1nJ2DknxypPf0XphNcwFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQGFrXR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77931C4CED6;
	Mon, 24 Feb 2025 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405906;
	bh=T05ccRrW+5iNE/vBxthb+1sXi/TkcmqToBotvoslBxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQGFrXR4aqzDrpGldWoN+4wZ/cTGC3LWpe0w42+Y75jnCvda8NblZgmcV4aWsZXBj
	 cOrqFbVeZrYoAmYR+IJirHsMn/68HoiR136R3Ob6Q71foDaal1ch2+LSfZ7dRTS2ik
	 HtQAB1NfgDzNb117v3qpjW/BVlUVa5RPpmh7JMEQ/4TGluHQ5lBuCLyZJ6UPY01sY0
	 kwuB5sUoFJ79KiQH/o/RZ/rUfEVU8LVWHGQw6GA0jXTBaVmzv0uBuIepFYRSes2o5s
	 OFmQhzaNht1XV4db3KnY+Hbmo5ATC4XB/LFpjLiTu6FOtgwR9AvG1FbYXB8mpkd+8D
	 pBNja64ZDSolA==
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
Subject: [PATCH RFCv2 17/18] selftests/bpf: Add uprobe syscall sigill signal test
Date: Mon, 24 Feb 2025 15:01:49 +0100
Message-ID: <20250224140151.667679-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224140151.667679-1-jolsa@kernel.org>
References: <20250224140151.667679-1-jolsa@kernel.org>
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
index 3f320da4ac46..c5894ddc5b5e 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -631,6 +631,40 @@ static void test_uprobe_race(void)
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
@@ -649,6 +683,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
+	if (test__start_subtest("uprobe_sigill"))
+		test_uprobe_sigill();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.48.1


