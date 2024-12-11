Return-Path: <bpf+bounces-46637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FB09ECD64
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 14:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65AB188B31B
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE6D237FFA;
	Wed, 11 Dec 2024 13:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwKPDwJL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7992368EF;
	Wed, 11 Dec 2024 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924179; cv=none; b=msmbkLgBoC2r23+t78qnN5zKEzPQPHI+/vK/BsnIJkR6aAmhORhE4XZTkgCzWIfF0a/xdQ2GxRoC/FzwFkfxA3XK8orivdHZwViSRvjFeaTBviGroLm5TrTc3LQbqvZtDd80LEPSp7jP4OMLrloMVtQoz7KP+KJmAdBVzkIPSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924179; c=relaxed/simple;
	bh=ztxN7nzwUWr4QzxZKHnancBay3JT0i2VtQ+cjXHy2tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPp0vLg62PbGcL9lJT0z6bTjCx0W+J312p6o9FXJuvSZWnlbJ0A+Qr7KOqAwqLLk7rg9o3YKw19tLkddBgvr79EkLgJLBAUd5ReiGsNoplBaxSNAvEFnVFHD8/z3L6Pub6aTyXoD79H97AbP4UmU94LXZSaLLp+e3vx4Clw2vvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwKPDwJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C6EC4CED2;
	Wed, 11 Dec 2024 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733924178;
	bh=ztxN7nzwUWr4QzxZKHnancBay3JT0i2VtQ+cjXHy2tA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwKPDwJLQAt1JS8a6Un25ef2oMlp4ycTW4moj9ToixK1Zn4JuGU0BlhHonj9Kld9Y
	 4Qd/ZDT6Da8naRKdArvgyKBJe/1ksjdNtmwNt6uEnIEw2rr/clVAA4/wFV3DeRWpaH
	 L7I+EnBRE4qw9UCkvwonSBcFSOyA2eFmV3S0dHhVMIv+2m8MUSkPSKinG405/t+iRv
	 ea3LHi2HH36pNXsIHZoqECkL5lZ7XMeMp7A7x6J9VHsRiTctZj7pnxwaiui00eMCby
	 MDpsYkiXfFYUV5+2OihRXPZm9weT9H1bQ5dHJ+s/CkgvNtRqGv0WHyVXVxmAVrBXC/
	 h6CmdnrEpxFrg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 12/13] selftests/bpf: Add uprobe syscall sigill signal test
Date: Wed, 11 Dec 2024 14:34:01 +0100
Message-ID: <20241211133403.208920-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211133403.208920-1-jolsa@kernel.org>
References: <20241211133403.208920-1-jolsa@kernel.org>
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
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index eacd14db8f8d..12631abc7017 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -607,6 +607,40 @@ static void test_uprobe_race(void)
 	for (i = 0; i < nr; i++)
 		pthread_join(threads[i], NULL);
 }
+
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
 #else
 static void test_uretprobe_regs_equal(void)
 {
@@ -647,6 +681,11 @@ static void test_uprobe_race(void)
 {
 	test__skip();
 }
+
+static void test_uprobe_sigill(void)
+{
+	test__skip();
+}
 #endif
 
 void test_uprobe_syscall(void)
@@ -667,4 +706,6 @@ void test_uprobe_syscall(void)
 		test_uprobe_usdt();
 	if (test__start_subtest("uprobe_race"))
 		test_uprobe_race();
+	if (test__start_subtest("uprobe_sigill"))
+		test_uprobe_sigill();
 }
-- 
2.47.0


