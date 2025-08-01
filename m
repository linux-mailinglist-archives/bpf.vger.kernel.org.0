Return-Path: <bpf+bounces-64933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B03B1887C
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 23:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE50F1C84FB9
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 21:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F4928DF0C;
	Fri,  1 Aug 2025 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTcBVxfF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D52147F9;
	Fri,  1 Aug 2025 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082217; cv=none; b=te9V4mWhn2/XD45gwoLwCJKp46VS7hzLaFkSlEhAuiDFM3FpqT9bzrd5EPK5cPxt9T+NdF+dRBUq8P7a443AqFyu4V0HXCz+b6Bp8/WTmSvkre3kRt6CLXCxC5bh8sFBg1cTunLisS8JFIJ3BmWqShCTaHtDvd4nEhlwxI856b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082217; c=relaxed/simple;
	bh=2IgccXrML8eTSCHq8i8NG7mRfzsM4SW1DbQbW7h/63o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bs2r+VbAu0BtEPiF87ptSyxGiLghJYAvzuGITcdR/bMiN5HeVS9RCgBNoM6kXKlm7sMdjmfo2gVPeWtTRLDAqKlGM7SFCSLwN8WLBZye5WjuQPgCfH4bJ7y/nI6rGL6KPNs0WhCkxp10988XD2TDG6M9GF3/1qedEoBaTKqgzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTcBVxfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BEC1C4CEE7;
	Fri,  1 Aug 2025 21:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754082215;
	bh=2IgccXrML8eTSCHq8i8NG7mRfzsM4SW1DbQbW7h/63o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTcBVxfF+mhViauYFPTaQyiIlVGrpqFWWl4i6C1BKv/Njn5gmxCz6PgMx4v3BzLd+
	 /kl8gsPpO9wumGLVGPt+EGMLfU4w2OWitzrAmr5bnL/QwnpAiTS6LsJIjbTUi3PtGm
	 2uvHOjUr6mP2Li8o6fUO7xPQ1Xj8xmVNRD9SANSZwoiHoyeSqZXTwslsIJMxsF28hC
	 XhkOOkrm6SFq2uKVsudFQqlD1AmDEuIhzlfAgbRd3XVkJ0n9u/1biG7XPjLV41B4C4
	 Dqq8NvbDU5GxOD5YFSvBpMkc1gpfA7ZpI7KbYqK+QRvd1X+autuUfG86wwv98qYgsV
	 boHwO1XVfOPGg==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
	Ingo Molnar <mingo@kernel.org>
Subject: [RFC 4/4] selftests/bpf: Add uprobe context ip register change test
Date: Fri,  1 Aug 2025 23:02:38 +0200
Message-ID: <20250801210238.2207429-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801210238.2207429-1-jolsa@kernel.org>
References: <20250801210238.2207429-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test to check we can change the application execution
through instruction pointer change through uprobe program.

It's x86_64 specific test.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/uprobe.c | 48 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_uprobe.c | 14 ++++++
 2 files changed, 62 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/testing/selftests/bpf/prog_tests/uprobe.c
index 7c7cb08d10b3..05cd3b65260f 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
@@ -190,10 +190,58 @@ static void regs_common(void)
 	test_uprobe__destroy(skel);
 }
 
+static __naked unsigned long uprobe_regs_change_ip_1(void)
+{
+	asm volatile (
+		"movq $0xc0ffee, %rax\n"
+		"ret\n"
+	);
+}
+
+static __naked unsigned long uprobe_regs_change_ip_2(void)
+{
+	asm volatile (
+		"movq $0xdeadbeef, %rax\n"
+		"ret\n"
+	);
+}
+
+static void regs_ip(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
+	struct test_uprobe *skel;
+	unsigned long ret;
+
+	skel = test_uprobe__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->my_pid = getpid();
+	skel->bss->ip = (unsigned long) uprobe_regs_change_ip_2;
+
+	uprobe_opts.func_name = "uprobe_regs_change_ip_1";
+	skel->links.test_regs_change_ip = bpf_program__attach_uprobe_opts(
+						skel->progs.test_regs_change_ip,
+						-1,
+						"/proc/self/exe",
+						0 /* offset */,
+						&uprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.test_regs_change_ip, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	ret = uprobe_regs_change_ip_1();
+	ASSERT_EQ(ret, 0xdeadbeef, "ret");
+
+cleanup:
+	test_uprobe__destroy(skel);
+}
+
 static void test_uprobe_regs_change(void)
 {
 	if (test__start_subtest("regs_change_common"))
 		regs_common();
+	if (test__start_subtest("regs_change_ip"))
+		regs_ip();
 }
 #else
 static void test_uprobe_regs_change(void) { }
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe.c b/tools/testing/selftests/bpf/progs/test_uprobe.c
index 9437bd76a437..12f4065fca20 100644
--- a/tools/testing/selftests/bpf/progs/test_uprobe.c
+++ b/tools/testing/selftests/bpf/progs/test_uprobe.c
@@ -82,4 +82,18 @@ int BPF_UPROBE(test_regs_change)
 	ctx->si  = regs.si;
 	return 0;
 }
+
+unsigned long ip;
+
+SEC("uprobe")
+int BPF_UPROBE(test_regs_change_ip)
+{
+	pid_t pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (pid != my_pid)
+		return 0;
+
+	ctx->ip = ip;
+	return 0;
+}
 #endif
-- 
2.50.1


