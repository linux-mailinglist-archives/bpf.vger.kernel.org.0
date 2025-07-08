Return-Path: <bpf+bounces-62676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51A4AFCC20
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 15:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089617B5A80
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84622DFA28;
	Tue,  8 Jul 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEwRcOop"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684D72AF07;
	Tue,  8 Jul 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751981225; cv=none; b=AZ2jzrIntp3zSb2TR9k25vIIy4pcloXUpZaz+OmoO+Amhh53X4MznBjTpqCZcYGiDPgEEe689rCqhAF2rtPaW0t231bTbl9XPVqyrWgBB00dXxIxzK8OpiLF81rUpjxJ5dwT0QE4W7jTGoEr/8EgwqY1XjutvIy1Sync0dG9XdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751981225; c=relaxed/simple;
	bh=xQ1uO15BgNrojwWQfKGfBramGLnRFMIa/c54AN3CquM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1ZBUlt82ri6jXhaBSW7DBT/bOwrAIYwK2wCu1M4H7Ac8ERMQsm2eInZMcii+jOwaWqhZHGhDJv4bCcpC1qG4LkmsTxzv2nvNCy4bZoIErXuYe07z0LHJsbWp+lhoGWs0wL9dbPY1v1W7PW53i+xltg/7VAbDLPKt4cFTGNlTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEwRcOop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EEDC4CEED;
	Tue,  8 Jul 2025 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751981225;
	bh=xQ1uO15BgNrojwWQfKGfBramGLnRFMIa/c54AN3CquM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEwRcOopSE4gZlYkV82x80mpbenN6zHhsA8XdzF+2PYsuJo35vqJec9nQejZxEfRP
	 XngbJu2h02G8OD5OR7oiX2HMkSGXUsvqKlQ/cuF7xLHXuUBzFZvBOQ0BWePtOzJ6+e
	 LHrDqIfbTWzDwCl/gf9+8/dJyvVbA7okb5z30iNoS9cOnRMu5MvxuFgi5FP66y3ZTy
	 QvQ35m9DNhWEtRbzoEONPYpg5gq1U804vmcYODcHhX7H1jCbb4rsZOgLvH+X18EI7s
	 B9nbM4SZqmxhVd85Cs8EbjIpxvJy14/ZX1e3uCOSLhwPLXdXAQHReBdUHclDg7Sh5y
	 LDzoSup4ldwGg==
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
Subject: [PATCHv4 perf/core 17/22] selftests/bpf: Add optimized usdt variant for basic usdt test
Date: Tue,  8 Jul 2025 15:23:26 +0200
Message-ID: <20250708132333.2739553-18-jolsa@kernel.org>
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

Adding optimized usdt variant for basic usdt test to check that
usdt arguments are properly passed in optimized code path.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 38 ++++++++++++-------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 9057e983cc54..833eb87483a1 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -40,12 +40,19 @@ static void __always_inline trigger_func(int x) {
 	}
 }
 
-static void subtest_basic_usdt(void)
+static void subtest_basic_usdt(bool optimized)
 {
 	LIBBPF_OPTS(bpf_usdt_opts, opts);
 	struct test_usdt *skel;
 	struct test_usdt__bss *bss;
-	int err, i;
+	int err, i, called;
+
+#define TRIGGER(x) ({			\
+	trigger_func(x);		\
+	if (optimized)			\
+		trigger_func(x);	\
+	optimized ? 2 : 1;		\
+	})
 
 	skel = test_usdt__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
@@ -66,11 +73,11 @@ static void subtest_basic_usdt(void)
 	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
 		goto cleanup;
 
-	trigger_func(1);
+	called = TRIGGER(1);
 
-	ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
-	ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
-	ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
+	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
+	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
+	ASSERT_EQ(bss->usdt12_called, called, "usdt12_called");
 
 	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
 	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
@@ -119,11 +126,11 @@ static void subtest_basic_usdt(void)
 	 * bpf_program__attach_usdt() handles this properly and attaches to
 	 * all possible places of USDT invocation.
 	 */
-	trigger_func(2);
+	called += TRIGGER(2);
 
-	ASSERT_EQ(bss->usdt0_called, 2, "usdt0_called");
-	ASSERT_EQ(bss->usdt3_called, 2, "usdt3_called");
-	ASSERT_EQ(bss->usdt12_called, 2, "usdt12_called");
+	ASSERT_EQ(bss->usdt0_called, called, "usdt0_called");
+	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
+	ASSERT_EQ(bss->usdt12_called, called, "usdt12_called");
 
 	/* only check values that depend on trigger_func()'s input value */
 	ASSERT_EQ(bss->usdt3_args[0], 2, "usdt3_arg1");
@@ -142,9 +149,9 @@ static void subtest_basic_usdt(void)
 	if (!ASSERT_OK_PTR(skel->links.usdt3, "usdt3_reattach"))
 		goto cleanup;
 
-	trigger_func(3);
+	called += TRIGGER(3);
 
-	ASSERT_EQ(bss->usdt3_called, 3, "usdt3_called");
+	ASSERT_EQ(bss->usdt3_called, called, "usdt3_called");
 	/* this time usdt3 has custom cookie */
 	ASSERT_EQ(bss->usdt3_cookie, 0xBADC00C51E, "usdt3_cookie");
 	ASSERT_EQ(bss->usdt3_arg_cnt, 3, "usdt3_arg_cnt");
@@ -158,6 +165,7 @@ static void subtest_basic_usdt(void)
 
 cleanup:
 	test_usdt__destroy(skel);
+#undef TRIGGER
 }
 
 unsigned short test_usdt_100_semaphore SEC(".probes");
@@ -425,7 +433,11 @@ static void subtest_urandom_usdt(bool auto_attach)
 void test_usdt(void)
 {
 	if (test__start_subtest("basic"))
-		subtest_basic_usdt();
+		subtest_basic_usdt(false);
+#ifdef __x86_64__
+	if (test__start_subtest("basic_optimized"))
+		subtest_basic_usdt(true);
+#endif
 	if (test__start_subtest("multispec"))
 		subtest_multispec_usdt();
 	if (test__start_subtest("urand_auto_attach"))
-- 
2.50.0


