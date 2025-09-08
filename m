Return-Path: <bpf+bounces-67708-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F0B48D10
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 14:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3533C7AA8EC
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F92FE05B;
	Mon,  8 Sep 2025 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCiHGmfj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593942EBDE6;
	Mon,  8 Sep 2025 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333645; cv=none; b=CCaOjpp65qRPLumpmjGLOee5dARc5PEXNOYkIEPPTK7NpM83xMmzZlwY3Ynyor9MsORpoB4OB8J/GYxwPhkvj01MuJdJJ4w96OR8ol1N8TZfW7MUkKeien6OXYZ9g1XT2X0MFRaL5S8WCkdP6kIOnoSxjje0miihFUlUM/ytukc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333645; c=relaxed/simple;
	bh=AVpuHvvS5I5LtGxHyezfUbjP3WODclgFHrgBZgJ6/k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4XZmZBVIvjM05joEz4w/uKX6asS5GCydaDlTQ5sv2Yy3gYz84XivwsyNJLl5axPDGvJ43yqKSFF4H9V2vjKBgfw23zzI1j5SVc1SdKsCoFHcpSZAknffjHRwi935JSzUlleDLBsWyox2mibnmMvWKKGTbZT8WPzcSg6eVKOqwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCiHGmfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669AAC4CEF1;
	Mon,  8 Sep 2025 12:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757333644;
	bh=AVpuHvvS5I5LtGxHyezfUbjP3WODclgFHrgBZgJ6/k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCiHGmfj5qcNS6q95ZUcfPGpvi4/qMPuorzGgZf1w8GCpCGIBpOWY1bdW4mVIyaGk
	 1peA2Sg7Vp4mhpMtYcThMSfw6fCbbNDu+ZYf4dhusiL+c5LfIZLYZUFo/oOwvm6bLz
	 qFzAjW9nkpZzu8p7JUo8YSRgSzQvZxC7yZ8JuRha5giMmGD2nXy3igrCFYAeHS3HcM
	 u9JduVk0gO5Oef3RR+BLQq8mX6Z7YlfGVZR+PlNoFGs95bTfIQZTk5liQ3QIslIYzj
	 zQR28s2jNDoUnhQglzCuvFLhHJExO0XSGNjPi6iK3oV1cshXFgiM82JzaQxJc01rzB
	 w+qMEVKlqFnTQ==
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
Subject: [PATCHv2 perf/core 4/4] selftests/bpf: Add uprobe context ip register change test
Date: Mon,  8 Sep 2025 14:13:10 +0200
Message-ID: <20250908121310.46824-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908121310.46824-1-jolsa@kernel.org>
References: <20250908121310.46824-1-jolsa@kernel.org>
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
 .../testing/selftests/bpf/prog_tests/uprobe.c | 42 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_uprobe.c | 14 +++++++
 2 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/testing/selftests/bpf/prog_tests/uprobe.c
index 19dd900df188..86404476c1da 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
@@ -190,10 +190,52 @@ static void regs_common(void)
 	test_uprobe__destroy(skel);
 }
 
+static noinline unsigned long uprobe_regs_change_ip_1(void)
+{
+	return 0xc0ffee;
+}
+
+static noinline unsigned long uprobe_regs_change_ip_2(void)
+{
+	return 0xdeadbeef;
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
2.51.0


