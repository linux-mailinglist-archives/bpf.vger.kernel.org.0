Return-Path: <bpf+bounces-59742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 431C1ACF07D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874A9189C243
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3C423A9AB;
	Thu,  5 Jun 2025 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8Sq7amY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0A233136;
	Thu,  5 Jun 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129988; cv=none; b=UFSpeC24JXEbHOFINZ98f6v4keH0WSxdatdsPRRP6Bfr+xGoF+7n6xTs0BBRpVmXI/SRaGcXWVP2Wf6Un7c4e3AdBJg4DFnkBPV6xEvO3BNg83OpL1x7FSQddfwz7zzYQWuBDaFy46iQvmUhv+fDccYQkFyLLcW9PbrLCOO9h4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129988; c=relaxed/simple;
	bh=0DC7ve8IiJAoEjCch9TNOdt5+d0u+dCXKqTLsu4cBW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUW1WOxSt8v7bhJaO82Qr6NN5pi1T1KVFl6FswAAQsBwTmbnG8kVy/0ruH2fXVqG9IjjzTmueDREJXwKHeWEbOix1N+oLKPb5nDIbsxyCaFCzcZcYZXV0ZYr8wEb+6k1/fX/HIFlgK79xjXHq7rk85jdsaqBkOJDwAp12ycpLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8Sq7amY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9ECC4CEE7;
	Thu,  5 Jun 2025 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749129988;
	bh=0DC7ve8IiJAoEjCch9TNOdt5+d0u+dCXKqTLsu4cBW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8Sq7amYE2fZ2Z4E9bbYmzwISreeK7ta9AwDOJ9ze1jYImogo8l8UC8SNUyajMrMj
	 lhOVI4JqUyOmZprD6BTSgzIbaYOCfQZHQ+deKbcyp0u9p43OIiugvj49wryG+nX5I8
	 lQbgWhFKdKF2zp0kEN7DYtXDaLcFH7tyEv3satxmIpmDeyBZb0UneLdh6biyVXUljo
	 8frLrntMr6p5Fwn0eKv72+F9324L3VPn3stArJRO8v1bDnKmvm38yTGyh1btst2P/7
	 qx0drarw34QNFw+97ZQuNK1uQgdl0i43rynCxvhImv7Lp8w5QT2WRh7UnvuLTfCcxL
	 uWByraTglSC0A==
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
Subject: [PATCHv3 perf/core 13/22] selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
Date: Thu,  5 Jun 2025 15:23:40 +0200
Message-ID: <20250605132350.1488129-14-jolsa@kernel.org>
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

Renaming uprobe_syscall_executed prog to test_uretprobe_multi
to fit properly in the following changes that add more programs.

Plus adding pid filter and increasing executed variable.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c        | 12 ++++++++----
 .../selftests/bpf/progs/uprobe_syscall_executed.c    |  8 ++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 2b00f16406c8..1cce50b5d18c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -252,6 +252,7 @@ static void test_uretprobe_syscall_call(void)
 	);
 	struct uprobe_syscall_executed *skel;
 	int pid, status, err, go[2], c;
+	struct bpf_link *link;
 
 	if (!ASSERT_OK(pipe(go), "pipe"))
 		return;
@@ -277,11 +278,14 @@ static void test_uretprobe_syscall_call(void)
 		_exit(0);
 	}
 
-	skel->links.test = bpf_program__attach_uprobe_multi(skel->progs.test, pid,
-							    "/proc/self/exe",
-							    "uretprobe_syscall_call", &opts);
-	if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_multi"))
+	skel->bss->pid = pid;
+
+	link = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
+						pid, "/proc/self/exe",
+						"uretprobe_syscall_call", &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
+	skel->links.test_uretprobe_multi = link;
 
 	/* kick the child */
 	write(go[1], &c, 1);
diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
index 0d7f1a7db2e2..8f48976a33aa 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
@@ -8,10 +8,14 @@ struct pt_regs regs;
 char _license[] SEC("license") = "GPL";
 
 int executed = 0;
+int pid;
 
 SEC("uretprobe.multi")
-int test(struct pt_regs *regs)
+int test_uretprobe_multi(struct pt_regs *ctx)
 {
-	executed = 1;
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	executed++;
 	return 0;
 }
-- 
2.49.0


