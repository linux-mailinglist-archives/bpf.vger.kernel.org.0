Return-Path: <bpf+bounces-67193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 368C3B40738
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 16:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE701A8379D
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 14:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4B93148D5;
	Tue,  2 Sep 2025 14:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA+33WIy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB253002BB;
	Tue,  2 Sep 2025 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823837; cv=none; b=D0bA9PmBL8dUgl5hyQjC1dKY06H2pXOI0X/+1Qa4pvvQ8eJ2yim3xBcNbDfizHwgIUVgLaOV4LvJCieH0ClW3IYXtI1UpjX9wbK6W9xQtJz3QfalPiRe3bkn8UZ0pCYe5vDQVy2znIPzpwJ1hMvZrYxMWBPHFASOCFXlyW8ZKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823837; c=relaxed/simple;
	bh=U92VCsC0ZBHxBm+P1kswlbRRmd+LYWTcaMx17qX9d1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsnIGIvAWq0jFFVz35G9sx/RDRS/QZxtY82eHXI0lMOIMOCGCpBu+EBxcBzK2GqncMFwd7wzlnenkuUBhV7vKBN1iOHT0Tvh5U5HCPnnoceMWubYCQIdBrqlmL0qRHqZaBm95onZZvCXB96ssK0o7r+OxZi3iEz+aGa4cHgTBJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA+33WIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1642C4CEED;
	Tue,  2 Sep 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823834;
	bh=U92VCsC0ZBHxBm+P1kswlbRRmd+LYWTcaMx17qX9d1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pA+33WIyaP0wcH/pODyKD6UBB0ixOMFAJA5p0Cohwck6HWtiRd2gXr4lcAxKArUqR
	 sQEDl+xRGD7nT1HDjhL02fJJvQbTS/O9YaVVr3N9BaWa/CLjqekwqJw3+QUUG32M3y
	 BgpYmXoIIPtmME4yrpZmsqiu03ki79URy94Lo+1xn9+/VOpIzCfF26l+OeYWSbqn/x
	 knqJ62ZuA7ElPUH2yYOsg1kQB7VDVw36JQayfEDWDKhn235TVhn64QY5csSJeVJw15
	 694W8y2xkGzPD5jC12y3ZACTW6SOCrviqs6VESuFD5NP0+EvKv2LzraPqhKORD1/DQ
	 AN/k+POHHrwQA==
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
Subject: [PATCH perf/core 11/11] selftests/bpf: Add uprobe unique attach test
Date: Tue,  2 Sep 2025 16:35:04 +0200
Message-ID: <20250902143504.1224726-12-jolsa@kernel.org>
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

Adding test to check the unique uprobe attchment together
with not-unique uprobe on top perf uprobe pmu.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/uprobe.c | 111 +++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe.c b/tools/testing/selftests/bpf/prog_tests/uprobe.c
index cf3e0e7a64fa..4e1be03d863d 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe.c
@@ -33,7 +33,7 @@ static int urand_trigger(FILE **urand_pipe)
 	return exit_code;
 }
 
-void test_uprobe(void)
+static void test_uprobe_urandlib(void)
 {
 	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
 	struct test_uprobe *skel;
@@ -93,3 +93,112 @@ void test_uprobe(void)
 		pclose(urand_pipe);
 	test_uprobe__destroy(skel);
 }
+
+static noinline void uprobe_unique_trigger(void)
+{
+	asm volatile ("");
+}
+
+static void test_uprobe_unique(void)
+{
+	LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts,
+		.func_name = "uprobe_unique_trigger",
+	);
+	struct bpf_link *link_1, *link_2 = NULL;
+	struct bpf_program *prog_1, *prog_2;
+	struct test_uprobe *skel;
+
+	skel = test_uprobe__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_uprobe__open_and_load"))
+		return;
+
+	skel->bss->my_pid = getpid();
+
+	prog_1 = skel->progs.test1;
+	prog_2 = skel->progs.test2;
+
+	/* not-unique and unique */
+	uprobe_opts.unique = false;
+	link_1 = bpf_program__attach_uprobe_opts(prog_1, -1, "/proc/self/exe",
+						 0 /* offset */, &uprobe_opts);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_uprobe_opts_1"))
+		goto cleanup;
+
+	uprobe_opts.unique = true;
+	link_2 = bpf_program__attach_uprobe_opts(prog_2, -1, "/proc/self/exe",
+						 0 /* offset */, &uprobe_opts);
+	if (!ASSERT_ERR_PTR(link_2, "bpf_program__attach_uprobe_opts_2")) {
+		bpf_link__destroy(link_2);
+		goto cleanup;
+	}
+
+	bpf_link__destroy(link_1);
+
+	/* unique and unique */
+	uprobe_opts.unique = true;
+	link_1 = bpf_program__attach_uprobe_opts(prog_1, -1, "/proc/self/exe",
+						 0 /* offset */, &uprobe_opts);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_uprobe_opts_1"))
+		goto cleanup;
+
+	uprobe_opts.unique = true;
+	link_2 = bpf_program__attach_uprobe_opts(prog_2, -1, "/proc/self/exe",
+						 0 /* offset */, &uprobe_opts);
+	if (!ASSERT_ERR_PTR(link_2, "bpf_program__attach_uprobe_opts_2")) {
+		bpf_link__destroy(link_2);
+		goto cleanup;
+	}
+
+	bpf_link__destroy(link_1);
+
+	/* unique and not-unique */
+	uprobe_opts.unique = true;
+	link_1 = bpf_program__attach_uprobe_opts(prog_1, -1, "/proc/self/exe",
+						 0 /* offset */, &uprobe_opts);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_uprobe_opts_1"))
+		goto cleanup;
+
+	uprobe_opts.unique = false;
+	link_2 = bpf_program__attach_uprobe_opts(prog_2, -1, "/proc/self/exe",
+						 0 /* offset */, &uprobe_opts);
+	if (!ASSERT_ERR_PTR(link_2, "bpf_program__attach_uprobe_opts_2")) {
+		bpf_link__destroy(link_2);
+		goto cleanup;
+	}
+
+	bpf_link__destroy(link_1);
+
+	/* not-unique and not-unique */
+	uprobe_opts.unique = false;
+	link_1 = bpf_program__attach_uprobe_opts(prog_1, -1, "/proc/self/exe",
+						 0 /* offset */, &uprobe_opts);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_uprobe_opts_1"))
+		goto cleanup;
+
+	uprobe_opts.unique = false;
+	link_2 = bpf_program__attach_uprobe_opts(prog_2, -1, "/proc/self/exe",
+						 0 /* offset */, &uprobe_opts);
+	if (!ASSERT_OK_PTR(link_2, "bpf_program__attach_uprobe_opts_2")) {
+		bpf_link__destroy(link_1);
+		goto cleanup;
+	}
+
+	uprobe_unique_trigger();
+
+	ASSERT_EQ(skel->bss->test1_result, 1, "test1_result");
+	ASSERT_EQ(skel->bss->test2_result, 1, "test2_result");
+
+	bpf_link__destroy(link_1);
+	bpf_link__destroy(link_2);
+
+cleanup:
+	test_uprobe__destroy(skel);
+}
+
+void test_uprobe(void)
+{
+	if (test__start_subtest("urandlib"))
+		test_uprobe_urandlib();
+	if (test__start_subtest("unique"))
+		test_uprobe_unique();
+}
-- 
2.51.0


