Return-Path: <bpf+bounces-62672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF4AFCC0F
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D317A162D53
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078A42DECC0;
	Tue,  8 Jul 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTbPtVn7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C822DEA6C;
	Tue,  8 Jul 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981178; cv=none; b=UvMlh/MwLje44xjMczVxxUTVv+7er5rE8i7F9bN+QFkFwSsVwt7EX3sxWIVrggfRiDUQMxs5y4ZuQRCN9yWT1Vkl6gvR+lvzRU7lWVgAqtSxVmFqeOdEd9EBkb9hOZZLOb2joXzmCN+RcbuBkLkV1YvJE9MIxVtbJnt14lINg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981178; c=relaxed/simple;
	bh=+E7vh5NNthjCrVoWIjxnf1hIEmGvlio3Zz4prRhuBts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQCMRzkp88ZwJJ5wfQ1CuXCdiGxZp4socDiqBVkhDsdpdnXjWH0ShJfvtKaUB/Lu6GCw6+3fMAo9AW8rhagQp/w6FwP1RWVCgycXecwUDXttfB8rdovTiKzKBTVO/+phiigLwb46K+TvfaUdWgRD7AgI27UxwxbxpPmLsFORESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTbPtVn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF23C4CEED;
	Tue,  8 Jul 2025 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981178;
	bh=+E7vh5NNthjCrVoWIjxnf1hIEmGvlio3Zz4prRhuBts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTbPtVn7lUzhcAOlL+M0ioFoik1+CDCgVeJUH8YLpDRRGkw6wU6fVjlK5AGAz66vB
	 H6OLUBy3qs4oqTKr+UeSBGJIg7XPdaRII+iWrNpi4Sf07Ft/rqErdo7iuArozROG8B
	 zyPR58mlzwu2XqLhUkjq9RBn5pirHxvqWUbh4dXm5Ox4/ng/1Fktj7l8ms33S1MJkD
	 WIZv4o/mL1TD7AkWWJMNB782A3eLloD17khEPRExNRGI8eu9A/9FoRngvnuHy+r5OA
	 rjVXw1+sTiRwCZSqhsTZBEfTHOVVQzupG/OqxY7NDCwdJ1S4kCxP7VQQM9lehNz9tr
	 pBdMahnM59SGQ==
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
Subject: [PATCHv4 perf/core 13/22] selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
Date: Tue,  8 Jul 2025 15:23:22 +0200
Message-ID: <20250708132333.2739553-14-jolsa@kernel.org>
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
2.50.0


