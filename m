Return-Path: <bpf+bounces-67191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E3B40727
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892154E0A1D
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D632ED58;
	Tue,  2 Sep 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlP9p4MB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316DA32ED34;
	Tue,  2 Sep 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823813; cv=none; b=B1hSgCvhwkwRdA9wSDP2f/eqDJyekUEtxnxhaVxBnpVqEEKd6zUj1uY9D5XLEbPqe52cE6Q4Oty/C4pPcNEjiW3KFI5CIn/szr6kI/30Scewm1GxKzHkJ2nhLHwWFtKDfCfIfxPz0IOgKN3kieXhe/tCFBa2e2dE6o/GhI/3MAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823813; c=relaxed/simple;
	bh=+Fy5/n5q5O6S2Jq0jxYE4pCKd/S3K2EoH3z8PsCyozo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdlZVvkqCylt1MN7Zp8G75wKMWgv/LiTp69QCvr9MfO09wH4D3N9anF0hfymDx0Elv62XjT+WrB8/EpoGXHAxsfqlcCEoszksFcj3x1IDQWMZyoFS01UtvvE6soPyO6BU95b9WIOPCk4FLNwulAAYPKhL4WQYMTjd73cHtJI4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlP9p4MB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDEEC4CEF6;
	Tue,  2 Sep 2025 14:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823812;
	bh=+Fy5/n5q5O6S2Jq0jxYE4pCKd/S3K2EoH3z8PsCyozo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlP9p4MBPA2f0AcAshbsjPmV0TtniAo9YQd7e7qhJawNPHMDb3mbhR+kRo5AjfVob
	 L3Z7fvB5rqpI5i7ZpweK5RV6ohS0bJ/KqjIjDKFG0LPRFkA/2vZHRcL1+TVbhDAroG
	 JmUMI2Gzvgp7ztWS//JSYDwXtEHs2h5Rtv1qSABceZL57yhe31T5nceHNMToYLku4z
	 fEF0l1/PYPIKfnjT63RXkSkEw2D8Qllt8bDLbypMkewkM3bsKBEEsrs7SkEiC8c9IO
	 isEUjA5vCfx7in0zi6XfTslCbD9m7hOSMqraUtFgFKTqNf8Ram5GRxvICrrogRJv5w
	 11HsK+MGGRICg==
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
Subject: [PATCH perf/core 09/11] selftests/bpf: Add uprobe multi context ip register change test
Date: Tue,  2 Sep 2025 16:35:02 +0200
Message-ID: <20250902143504.1224726-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902143504.1224726-1-jolsa@kernel.org>
References: <20250902143504.1224726-1-jolsa@kernel.org>
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
 .../bpf/prog_tests/uprobe_multi_test.c        | 42 +++++++++++++++++++
 .../selftests/bpf/progs/uprobe_multi.c        | 14 +++++++
 2 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 012652b07399..4630a6c65c3c 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -1437,10 +1437,52 @@ static void unique_regs_common(void)
 	uprobe_multi__destroy(skel);
 }
 
+noinline static unsigned long uprobe_regs_change_ip_1(void)
+{
+	return 0xc0ffee;
+}
+
+noinline static unsigned long uprobe_regs_change_ip_2(void)
+{
+	return 0xdeadbeef;
+}
+
+static void unique_regs_ip(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts,
+		.unique = true,
+	);
+	struct uprobe_multi *skel;
+	int ret;
+
+	skel = uprobe_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->bss->pid = getpid();
+	skel->bss->ip = (unsigned long) uprobe_regs_change_ip_2;
+
+	skel->links.uprobe_change_ip = bpf_program__attach_uprobe_multi(
+						skel->progs.uprobe_change_ip,
+						-1, "/proc/self/exe",
+						"uprobe_regs_change_ip_1",
+						&opts);
+	if (!ASSERT_OK_PTR(skel->links.uprobe_change_ip, "bpf_program__attach_uprobe_multi"))
+		goto cleanup;
+
+	ret = uprobe_regs_change_ip_1();
+	ASSERT_EQ(ret, 0xdeadbeef, "ret");
+
+cleanup:
+	uprobe_multi__destroy(skel);
+}
+
 static void test_unique(void)
 {
 	if (test__start_subtest("unique_regs_common"))
 		unique_regs_common();
+	if (test__start_subtest("unique_regs_ip"))
+		unique_regs_ip();
 }
 #else
 static void test_unique(void) { }
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index f26f8b840985..563fd37ed77d 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -164,4 +164,18 @@ int BPF_UPROBE(uprobe_change_regs)
 	ctx->si  = regs.si;
 	return 0;
 }
+
+unsigned long ip;
+
+SEC("uprobe.unique")
+int BPF_UPROBE(uprobe_change_ip)
+{
+	pid_t cur_pid = bpf_get_current_pid_tgid() >> 32;
+
+	if (cur_pid != pid)
+		return 0;
+
+	ctx->ip = ip;
+	return 0;
+}
 #endif
-- 
2.51.0


