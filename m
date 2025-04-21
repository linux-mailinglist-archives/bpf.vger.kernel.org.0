Return-Path: <bpf+bounces-56341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2235A9584E
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3A63B0646
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290B21C190;
	Mon, 21 Apr 2025 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWTKbciV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C9021A421;
	Mon, 21 Apr 2025 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272017; cv=none; b=mb6Kta4QWXeZEi6/ikl13sHz3V/rQP8CV8hE/CHTKdyrROwQgMBQV06bD0O3v/yhT9Ez9eJp/OA9OpCHP22jkOggNIIbjlc5vUXV9GCZWsPIzE7bfurx0+TAfcWLT5aErcliyB/fHc61TuUlfTWHr4TfdKv/ZKDHwnqeS7D6AT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272017; c=relaxed/simple;
	bh=QHeRP+3vFIU4kzTD64Z50sxitOHVSEPLwnAxE9SvpDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDHnH61Zy1tCVtbvCqOZAA6sV+t8lbIWUH+UnqFfy2tmD4+R+ckdqD4qSsDSIgrROEQAR65ExhASfdmcHOWKLA+VVJiIHyJmFYuhRjNm7Qg3f2oxlI0PygqHLe4nslJ5+1xun2Qj13xSF8EXO/NUpVAURB58LVjyXTAOAL47aZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWTKbciV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B944EC4CEE4;
	Mon, 21 Apr 2025 21:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272017;
	bh=QHeRP+3vFIU4kzTD64Z50sxitOHVSEPLwnAxE9SvpDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWTKbciVgJUk4YqDNH6wXkskafiaPg5xNbUEjP8L8y89AXwTJpUfzZmt7Qi5blWzb
	 yLM5TN3u4Hsqy+HAzpBS1AscYTO4IrX4QObhNLHKGaGK7TucNjVCtGgOrGlM7FfqJJ
	 ysAIF+dRH0zJ7RlaYu9QEHDAHLwuH8qCVbrUNeeaU0NBX9FWyLS8VhurN7qJCxItpS
	 NR/ARwZ5SDlR4rkCmQDtPfFC3zdXcWxw47g7stC3CexXjrzOYm7liRwNjaa7HmAhWN
	 dRmP1dlPhRQz2JzF0u3tipdb/u9uZCT9b80jc8HLQtYlgNP3FfbEJ2eooeBYfX/lxt
	 FIjEa+qP9rnYQ==
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
Subject: [PATCH perf/core 12/22] selftests/bpf: Reorg the uprobe_syscall test function
Date: Mon, 21 Apr 2025 23:44:12 +0200
Message-ID: <20250421214423.393661-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421214423.393661-1-jolsa@kernel.org>
References: <20250421214423.393661-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding __test_uprobe_syscall with non x86_64 stub to execute all the tests,
so we don't need to keep adding non x86_64 stub functions for new tests.

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


