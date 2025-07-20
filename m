Return-Path: <bpf+bounces-63845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9053B0B583
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 13:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9966B189CA0F
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92B21019C;
	Sun, 20 Jul 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDZ1E4dE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2741F419A;
	Sun, 20 Jul 2025 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753010648; cv=none; b=Q+d7VcyAsF8su2ASBviDueNLo2Oo7/M25T1pApQEGtM68HlxxTme+aYXFx8PVR+xwUDKNXFDOGeDrEkEuwKGNRM3P1R1uRlJCvolJ40Qjv/lAk3ipQbYH/KYCeG2h50BWpdhJi9ZVUqK5LC/Vm18ZrkoOqt+z6wCUnYVOfop5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753010648; c=relaxed/simple;
	bh=xG++SGD2nDWRF+AHSkagHd75sluL0Q0m1R0BWzx2XYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8+aOreizQCxJPLvtq5TUQdc7F/UlMMfQIwH8Cm2I8R9qDi3vQ2VFyJ5oXcvYJX2gyHlVNE7fCMx2PH97roTopTD1IiucxAcPIYGS0xNxr3ABlteuMkmJmzbn5KefsJ3VA1XjOdKK2hppQ1PDIti0cqDOtvhjnM1tv+9kEMUM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDZ1E4dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3814EC4CEE7;
	Sun, 20 Jul 2025 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753010648;
	bh=xG++SGD2nDWRF+AHSkagHd75sluL0Q0m1R0BWzx2XYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XDZ1E4dE01aYMwhXweJEFzVDSvsknCmuT7/lmxtno7xWO6BPKo7uUEObLOWjvUP55
	 Qc7ebbtSPdQ6ENZ5RfiX6u7S/4xp0n7ZICCNVlBGiZuMk/Ti14NvZuFZGEfzwsPlyh
	 tXAC5BKXF1l+iElqHPVom6QzuansF1rETGHbl8iY1RutCgUe+Znj3BNKcYu3FHci45
	 Xg7yUgpRWlfQEMFgep5ukB/FFtQJtn590GU8mO+xUrhUWDofGi+HC5Pd3Q/qZvuDNC
	 3LbdAX1LW2+Mghc7SfssimskJBl5N9pyGR0rk+1TH3Kz/H9o/c7Mi2DzsNX1vIUWP+
	 w5azL6QmNk2uQ==
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
Subject: [PATCHv6 perf/core 13/22] selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
Date: Sun, 20 Jul 2025 13:21:23 +0200
Message-ID: <20250720112133.244369-14-jolsa@kernel.org>
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
index a8f00aee7799..6d58a44da2b2 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -252,6 +252,7 @@ static void test_uretprobe_syscall_call(void)
 	);
 	struct uprobe_syscall_executed *skel;
 	int pid, status, err, go[2], c = 0;
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
2.50.1


