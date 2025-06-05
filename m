Return-Path: <bpf+bounces-59741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DF5ACF077
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872121654AD
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29143231852;
	Thu,  5 Jun 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8V5X7MU"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8932376E1;
	Thu,  5 Jun 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749129977; cv=none; b=L4F+dzlBjPxkVGPwYJPrzNSSermFf4ZjrhO2faRE7Y7GgOshc21++sddSWQspSyIXQWseTs8XHoU5q/Il5XYkG7rXxjAB+ijOP8hgBXPlalqX2SPq9c+gt6f/gpqa1UxcFL52grPtvEjm3r1KPo2ctJNZdDsAW8yjcaNvy5xNJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749129977; c=relaxed/simple;
	bh=mzdtZaCPuwEsXgXzfygAKng1jrji6Of8Gk6C2jTwzqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYLDumkuCzrTPnazMSJ2QbBp2cMr+AMpc0dVSLth616G8KnM40mhfbr4RYyIzk5KwMBkx6euEHN6FowGhSNgbJzorx7gWPHSKFw+/lJTUSfGbEJO1THa/pTR0ba7LoQYFhOzCJ8giAtQUT/+96+wUbXrpDS8tqiOzvp6v+gyovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8V5X7MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6525C4CEE7;
	Thu,  5 Jun 2025 13:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749129976;
	bh=mzdtZaCPuwEsXgXzfygAKng1jrji6Of8Gk6C2jTwzqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W8V5X7MUefP6sdAD+ZVzNJh7+yoTueAWY+tGfUlfNQCNLKW1SekoDBksESDm6nkCe
	 PdYhiLUDkRLN9YZKq+PqtNZdEPoAtE09pxvrZ1W+vIc1Q69L32TPYNMEP6H8gpbc+d
	 0m9Hbb/U03axUAtSApGEH4bFUZ70XJ2dU20Tw2PTYcAkK6GYTY7QtfdsCm+8c9/cp7
	 jRJAHb2yIvRx4riOFzZUE1wD8vpgpq/VTAIHikO5Py8kYlepaJ2ASYrXdkXfke1HDz
	 ShnetJowVHvjj8ASgBz+Q40lqFo/qz8joTcvejkly6LNyIkjMoKWXb0/ecFrQ9wFsF
	 zc4DtDLxklivA==
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
Subject: [PATCHv3 perf/core 12/22] selftests/bpf: Reorg the uprobe_syscall test function
Date: Thu,  5 Jun 2025 15:23:39 +0200
Message-ID: <20250605132350.1488129-13-jolsa@kernel.org>
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

Adding __test_uprobe_syscall with non x86_64 stub to execute all the tests,
so we don't need to keep adding non x86_64 stub functions for new tests.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index c397336fe1ed..2b00f16406c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -350,29 +350,8 @@ static void test_uretprobe_shadow_stack(void)
 
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
 }
-#else
-static void test_uretprobe_regs_equal(void)
-{
-	test__skip();
-}
-
-static void test_uretprobe_regs_change(void)
-{
-	test__skip();
-}
-
-static void test_uretprobe_syscall_call(void)
-{
-	test__skip();
-}
 
-static void test_uretprobe_shadow_stack(void)
-{
-	test__skip();
-}
-#endif
-
-void test_uprobe_syscall(void)
+static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uretprobe_regs_equal();
@@ -383,3 +362,14 @@ void test_uprobe_syscall(void)
 	if (test__start_subtest("uretprobe_shadow_stack"))
 		test_uretprobe_shadow_stack();
 }
+#else
+static void __test_uprobe_syscall(void)
+{
+	test__skip();
+}
+#endif
+
+void test_uprobe_syscall(void)
+{
+	__test_uprobe_syscall();
+}
-- 
2.49.0


