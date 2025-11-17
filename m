Return-Path: <bpf+bounces-74727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59D6C642C2
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4023B2EE9
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C53321D6;
	Mon, 17 Nov 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFll8DXq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F1F337688;
	Mon, 17 Nov 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763383347; cv=none; b=NlxteKD1HW3c7r5OeCU+Hnww+oULMeT8O08UfJxA9OykdXYbpU/CEDMMeFdSfnrbCwKq/5f/TC9OBL9dsODPSPnRj26AzQ59NIiOKB/MAgcQ5lSP2QYjsGcSzhxJpj1ePBmlh/JUj84J+iSrWXebv5QrDagXTWuNLdYukMJmjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763383347; c=relaxed/simple;
	bh=cE4vQD/v8RCVF+qyXCZu+VSYXoW/3YpROOS/NObDU50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huW3Y/Raa0cxawXnxfqXFiP3X2l1lRur4B8zqkyGxJN7Bv5U0HF1lkoH/qrCH6HHry8XFARBmsLJaWjaxMxJsoQp97EvjiTEbAwWNKlNMLy91bR8W5AD216RVlBpfEBIM4gEIL6U8VwQIMp41JszR0gYwBkbjKDcAUlV1EG2BJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFll8DXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E928C19424;
	Mon, 17 Nov 2025 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763383347;
	bh=cE4vQD/v8RCVF+qyXCZu+VSYXoW/3YpROOS/NObDU50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oFll8DXq8tlNWl9wJQCmyvynVkTMO5vBLDzAllNGd/aEu2URZWqxqqQT6dztNbMnA
	 C4XsJ4LgVkQ5A/NlpPnjjZDk/bMXPcn+1xmqLQaZUf+Hdr8wgzuMvs48WstwXmp1eA
	 1WTuTWNnkdaBe/vl7gjL8PuHeJvtKXB0rs0njPfsoKEe8HuY5ps5NP5WwmCSTShzmX
	 UMGZ65z6W2zI578BpSKIJVIAXAhhrpLUYihJ/WgkXfBY8oFHX89FJHiGJHqU4wrZYF
	 ZDR/VDR7eMZoG4PrxJPYjTUSRjaeryFmYaEmsPJHDB+tphLbvMGbPMavRiJWs6k3cm
	 MtyR2aYt0xJ/g==
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
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@ACULAB.COM>
Subject: [RFC PATCH 7/8] selftests/bpf: Add test for uprobe prologue optimization
Date: Mon, 17 Nov 2025 13:40:56 +0100
Message-ID: <20251117124057.687384-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117124057.687384-1-jolsa@kernel.org>
References: <20251117124057.687384-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test that places uprobe on top of supported prologue
and checks that the uprobe gets properly optimized.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c | 63 ++++++++++++++++---
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index 27fa6f309188..c6a58afc7ace 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -428,21 +428,21 @@ static void *check_attach(struct uprobe_syscall_executed *skel, trigger_t trigge
 	return tramp;
 }
 
-static void check_detach(void *addr, void *tramp)
+static void check_detach(void *addr, void *tramp, unsigned char *orig)
 {
 	/* [uprobes_trampoline] stays after detach */
 	ASSERT_OK(find_uprobes_trampoline(tramp), "uprobes_trampoline");
-	ASSERT_OK(memcmp(addr, nop5, 5), "nop5");
+	ASSERT_OK(memcmp(addr, orig, 5), "orig");
 }
 
 static void check(struct uprobe_syscall_executed *skel, struct bpf_link *link,
-		  trigger_t trigger, void *addr, int executed)
+		  trigger_t trigger, void *addr, int executed, unsigned char *orig)
 {
 	void *tramp;
 
 	tramp = check_attach(skel, trigger, addr, executed);
 	bpf_link__destroy(link);
-	check_detach(addr, tramp);
+	check_detach(addr, tramp, orig);
 }
 
 static void test_uprobe_legacy(void)
@@ -470,7 +470,7 @@ static void test_uprobe_legacy(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
 		goto cleanup;
 
-	check(skel, link, uprobe_test, uprobe_test, 2);
+	check(skel, link, uprobe_test, uprobe_test, 2, nop5);
 
 	/* uretprobe */
 	skel->bss->executed = 0;
@@ -480,7 +480,7 @@ static void test_uprobe_legacy(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
 		goto cleanup;
 
-	check(skel, link, uprobe_test, uprobe_test, 2);
+	check(skel, link, uprobe_test, uprobe_test, 2, nop5);
 
 cleanup:
 	uprobe_syscall_executed__destroy(skel);
@@ -512,7 +512,7 @@ static void test_uprobe_multi(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
-	check(skel, link, uprobe_test, uprobe_test, 2);
+	check(skel, link, uprobe_test, uprobe_test, 2, nop5);
 
 	/* uretprobe.multi */
 	skel->bss->executed = 0;
@@ -522,7 +522,7 @@ static void test_uprobe_multi(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
-	check(skel, link, uprobe_test, uprobe_test, 2);
+	check(skel, link, uprobe_test, uprobe_test, 2, nop5);
 
 cleanup:
 	uprobe_syscall_executed__destroy(skel);
@@ -555,7 +555,7 @@ static void test_uprobe_session(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_multi"))
 		goto cleanup;
 
-	check(skel, link, uprobe_test, uprobe_test, 4);
+	check(skel, link, uprobe_test, uprobe_test, 4, nop5);
 
 cleanup:
 	uprobe_syscall_executed__destroy(skel);
@@ -584,7 +584,7 @@ static void test_uprobe_usdt(void)
 	if (!ASSERT_OK_PTR(link, "bpf_program__attach_usdt"))
 		goto cleanup;
 
-	check(skel, link, usdt_test, addr, 2);
+	check(skel, link, usdt_test, addr, 2, nop5);
 
 cleanup:
 	uprobe_syscall_executed__destroy(skel);
@@ -813,6 +813,47 @@ static void test_emulate(void)
 	uprobe_syscall__destroy(skel);
 }
 
+__attribute__((aligned(16)))
+__nocf_check __weak __naked void prologue_trigger(void)
+{
+	asm volatile (
+		"pushq %rbp\n"
+		"movq  %rsp,%rbp\n"
+		"subq  $0xb0,%rsp\n"
+		"addq  $0xb0,%rsp\n"
+		"pop %rbp\n"
+		"ret\n"
+	);
+}
+
+static void test_optimize_prologue(void)
+{
+	struct uprobe_syscall_executed *skel = NULL;
+	struct bpf_link *link;
+	unsigned long offset;
+
+	offset = get_uprobe_offset(&prologue_trigger);
+	if (!ASSERT_GE(offset, 0, "get_uprobe_offset"))
+		goto cleanup;
+
+	/* uprobe */
+	skel = uprobe_syscall_executed__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "uprobe_syscall_executed__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	link = bpf_program__attach_uprobe_opts(skel->progs.test_uprobe,
+				0, "/proc/self/exe", offset, NULL);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_uprobe_opts"))
+		goto cleanup;
+
+	check(skel, link, prologue_trigger, prologue_trigger, 2, (unsigned char *) prologue_trigger);
+
+cleanup:
+	uprobe_syscall_executed__destroy(skel);
+}
+
 static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
@@ -839,6 +880,8 @@ static void __test_uprobe_syscall(void)
 		test_regs_change();
 	if (test__start_subtest("emulate_mov"))
 		test_emulate();
+	if (test__start_subtest("optimize_prologue"))
+		test_optimize_prologue();
 }
 #else
 static void __test_uprobe_syscall(void)
-- 
2.51.1


