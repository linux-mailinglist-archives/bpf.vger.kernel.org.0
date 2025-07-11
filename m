Return-Path: <bpf+bounces-63022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E26B0164A
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E17166B33
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986BE221FB4;
	Fri, 11 Jul 2025 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3JjuY2z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC71FBCAF;
	Fri, 11 Jul 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222751; cv=none; b=eVylmA67WpmuRToXvyzgCxzwyNu+Aw/GMjBll273aloDLh3sRdFkGCT/1OfdrIn/a8a0wmAfP9KZ4VJjNXaXb5T7PLXZ3rMZ0m0wCvjFfNToouOWuw7Tme3lUXu02sPxQgXZJSmdSlXj7cfUhGZtOZu3LIlUCl278Aw3wulVFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222751; c=relaxed/simple;
	bh=+E7vh5NNthjCrVoWIjxnf1hIEmGvlio3Zz4prRhuBts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nS2t8f4+Q67KiIrL3WcSt16e1lIaPEMbZtDh2GNPSHjX/8ON+RoG/fdCEFYk0zZa6JA7seSM8INL7RsyuxhYXp1l15kARoQ1d0R4ZUkQBLLHdFoHQTBJjEae4qUlHEQZgsbaXC1nZKYpLepDNMWS8aXeqr5XMe+qKK20nZvKVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3JjuY2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28590C4CEED;
	Fri, 11 Jul 2025 08:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222750;
	bh=+E7vh5NNthjCrVoWIjxnf1hIEmGvlio3Zz4prRhuBts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3JjuY2zGEv1BTr8thP1fMdMbE7yqV4KRnuZNOKWe6cnevTBpEN5G7nGaRcUkuk32
	 BmRjCTgXBva8i+5AYDmJ11NXeAKJhuUvMjV6HVlLaTZD4tbVzKXwxPjQjNO9xKCQQk
	 sGabwG+A/OHYW/RRs/putHisNdPEU5z9PIbyDjYRFU2YAmWuPfTudQoBYP2rk4sJu/
	 pXx4o5Q3eIewVMH7Cum48ED+sE6pUet5dhAKcRaoRoBz2+WG1n6KT9fao15hnbAqet
	 Fpr4iY4txgJ+9rzeibfhMmUEB9P7dS5XGEY07b4zsWLFA+bWnQqXiA82xShKAt60jc
	 PXd4jqmxJJJQg==
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
Subject: [PATCHv5 perf/core 13/22] selftests/bpf: Rename uprobe_syscall_executed prog to test_uretprobe_multi
Date: Fri, 11 Jul 2025 10:29:21 +0200
Message-ID: <20250711082931.3398027-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711082931.3398027-1-jolsa@kernel.org>
References: <20250711082931.3398027-1-jolsa@kernel.org>
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


