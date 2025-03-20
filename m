Return-Path: <bpf+bounces-54458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06887A6A54E
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 12:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5D13B3E3A
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 11:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D4221D86;
	Thu, 20 Mar 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXj9ASwC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AE21CCEE2;
	Thu, 20 Mar 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471119; cv=none; b=kNbRLIem+1eB+C82sYlBPg7VDdu5/F66QBT8+ZbtNX9JjYkyHtGgfAMdILNNunnIQonuE4Safx2k7Bl9CVW1rPNufJeD6z9fRweZZfB8wKa4ao0bAR5k1XYrEOZLBGkmv8BxuTP16ihWIoxAixPJmYrYoQvrnT9DJf3VYAjs6tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471119; c=relaxed/simple;
	bh=CmhOUNOyf8C5VZqhe+kYbT/wErrIykPEDyBCg4k/eMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFk1wJDkwyCC11nL6fc15hBFC1FJAtqkzhRsSEZySsN6NHvPCUYjbjsd5G7z0KRsO9X0bXicydcsG9olxdFmDtHnxZdmCo2NqwuCr3UyrOp0H87a0pzvi8M9sKM8XDKy0DE7IDqfp5r0x46Vi7cMHWiJXRb6zb2AdvJZKhP1lJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXj9ASwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C999C4CEDD;
	Thu, 20 Mar 2025 11:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471116;
	bh=CmhOUNOyf8C5VZqhe+kYbT/wErrIykPEDyBCg4k/eMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WXj9ASwCqzSMdqU23qfJikG0DnpPw91K8hDBxXCue/rynXyq5wrIRs2DQNLtUrHWW
	 cptTn/D7VNCtO0jp0I8hqWgD0X/TD1oTjAkkTGWL4VQTH/LzAQfdAQ3+vBN5276WvE
	 NFeRjvGkj97+bTIdBR30D1tByOA0O+axTVQHAtXSJKtb5kJPvGJ188LGFdJJ2Zg/+3
	 83IwF5DsB0aLQRV+AI8xMtLsyjYFplcZhNcRbtkxHQTaE/jteFWKJt/Q9J1rs1rRUb
	 bMyQ03rKdo2fBTaJGCcaUN5yXL/93PFDki3nOHr/zPdnGStF74sHT6HXhMR90V91Wb
	 9gQzJ2ZhsC4ng==
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
Subject: [PATCH RFCv3 17/23] selftests/bpf: Add uprobe syscall sigill signal test
Date: Thu, 20 Mar 2025 12:41:52 +0100
Message-ID: <20250320114200.14377-18-jolsa@kernel.org>
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

Make sure that calling uprobe syscall from outside uprobe trampoline
results in sigill signal.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 5c10cf173e6d..b3518f48329c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -672,6 +672,40 @@ static void test_uprobe_race(void)
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
@@ -692,6 +726,8 @@ static void __test_uprobe_syscall(void)
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


