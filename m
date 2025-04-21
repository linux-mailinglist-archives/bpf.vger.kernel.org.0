Return-Path: <bpf+bounces-56346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3C6A95854
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B496E166A8E
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14B221267;
	Mon, 21 Apr 2025 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc4v+KUa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0521E0BE;
	Mon, 21 Apr 2025 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272077; cv=none; b=dbxiEhNFPD0ezpFDQV6Lr9FBAbC76X9Lqfwax4t/cvsBikRiMjSMbeegnLmpXTNGQ3I3O0Ftln7bqbXLTPeF4119Kb+ds6C3SHpzNzbRGYY+qMOYYO2gQ08VepY6d1WvIe4ObWGBZd1bOUfe99jT2x3D3+z4iPwyxwtwTb9Ugys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272077; c=relaxed/simple;
	bh=HTzBLdxwEvxQBtSDIW0CoRoNOhQjNbfqNb3hpAJa9fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOHKholDEU98iZCyebkPxjBBprgK6AdzoindhmKzgPOFAX3QzjWaVb4g00yQcwGmUHrjLLi9MuTR4MCsLZ+a+MV9Zpt0OUmFqviV/8LwJR+DN7pLQTq13mV5LEubAympaLyeqlmDoWhS0VZ0MRorA2Pn19BIb3S+oXJHXw89vZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc4v+KUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D347AC4CEE4;
	Mon, 21 Apr 2025 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272076;
	bh=HTzBLdxwEvxQBtSDIW0CoRoNOhQjNbfqNb3hpAJa9fU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jc4v+KUa0x/8wLpfA1d5p4RhU4Xq+IkA9ryJGtXeHS9wru2elBUuYiMcBNf3jYijU
	 pK2gAsMJ5qLGOXz/m44pR74/sbcoPc2ORfT04J4vX8FPfueu0vOhndAlvB+tGdk8/q
	 i0inec7k/yEn+GhYjwrao1Ca4k7Gekqewl5zik9PX1kftgu4HQB1lUQj86TSOo/PMq
	 Gg/SCQyTGJWEb7K5pGrVFlwgrZNcjVJYOm118oVtfmyFj/cA3ibs4OBhMwpL998sBb
	 Xa0o4khYTG1kBlxrMBg0v+JHOT6kOg66KiutTFzO0tHSid6B+n2OeD/9dki/dkQKN7
	 TXLWwsq8zvFiA==
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
Subject: [PATCH perf/core 17/22] selftests/bpf: Add optimized usdt variant for basic usdt test
Date: Mon, 21 Apr 2025 23:44:17 +0200
Message-ID: <20250421214423.393661-18-jolsa@kernel.org>
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

Adding optimized usdt variant for basic usdt test to check that
usdt arguments are properly passed in optimized code path.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 38 ++++++++++++-------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 495d66414b57..3a5b5230bfa0 100644
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
@@ -419,7 +427,11 @@ static void subtest_urandom_usdt(bool auto_attach)
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
2.49.0


