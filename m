Return-Path: <bpf+bounces-58299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB2AB8623
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BD4169CD9
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8603B29A322;
	Thu, 15 May 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtVHS3CP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D49298C1B;
	Thu, 15 May 2025 12:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311259; cv=none; b=lYEC7aeJL5lPf6ByJQ/pqq6wnN2BT8Za3ifZdgAjHrn6spIpMdT4R0m8SEDmMcK8gDKbHObCUYoLS5CHAVHEJmXBFKdvVQbjax1NlC1SRfj/WmYI6b/j7yxqK7eu1UkdII0D61j+dUKJgT3C9i3z8PDMRpjVtQDL0r/XImxDyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311259; c=relaxed/simple;
	bh=mzdtZaCPuwEsXgXzfygAKng1jrji6Of8Gk6C2jTwzqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f60Ig54CZkTHXsSi94bkdKY0Xlbg24Sm9DyC8jM9RR+7MvLXNwpCdBNj3rSsHqj5ELNofBRYMomrksc0y5E8zKnt3S567iu0J8ofveviMU1UPPOeDcQDoIeOWp9hDS7AoBtqqbnu4svUjuZRUpqslRUi05RC338CsD4om0Vi7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtVHS3CP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90375C4CEE7;
	Thu, 15 May 2025 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311258;
	bh=mzdtZaCPuwEsXgXzfygAKng1jrji6Of8Gk6C2jTwzqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtVHS3CPbxG8kjmBSKuHa5izrfMrZ0NJafeNQhOhMYnMORSL8uDkEBEJ6qIo0ZDV/
	 KrhMAavYUhIdb4aoW84bF5Z29vscdAtysgzfapasJgSLY1dWIGmt32oz1LVuk4YZ5K
	 0sqreIBhgVR7AfFHVRh7xuXbnGTLCtajc3PkCXDj/t+tbCXI73OFWqfXR+uXawcMkm
	 3MxXOwsAfHaj+TfiwAcw7fZ8WkD2zzs/YwBp5hCDSr1QZkPGDRQ42/sSJAOqHTi3gd
	 C5SShR+Ytqmf6wGnfqNr68L7TmAG49qvwo1ghHizmo4DcNf9gFkV1JbBT2WZ+P78k8
	 /v5RmEeU4/5TQ==
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
Subject: [PATCHv2 perf/core 12/22] selftests/bpf: Reorg the uprobe_syscall test function
Date: Thu, 15 May 2025 14:11:09 +0200
Message-ID: <20250515121121.2332905-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515121121.2332905-1-jolsa@kernel.org>
References: <20250515121121.2332905-1-jolsa@kernel.org>
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


