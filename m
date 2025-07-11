Return-Path: <bpf+bounces-63026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF52B0165C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F585C138C
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8B224B1E;
	Fri, 11 Jul 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxwTa1O/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C4920D4FC;
	Fri, 11 Jul 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222797; cv=none; b=KpRg7QxategV+xDdQRPD1zdAfBG0iX+v0YBc/Zouf2NhDzxcVLPCUxKjTX0UcKRXql6SB0I0Q20E3x7Alsf8dHxWa7JzxDVJ5hTEEDDo7piDJKp9C2+D5RJOjPJQxeersyy+pen7UafxE0WCGOonPtY3D9Qah3Bcp6afOMYp55o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222797; c=relaxed/simple;
	bh=xQ1uO15BgNrojwWQfKGfBramGLnRFMIa/c54AN3CquM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ8RvagnBlDIoG+kA6Ztw2dUPg3NilC2chBnqJDMeFrJdaxyi7+sl7NbyiXVF88VtR5Z76/ffrwCoLwdDV3qDDa6f3Q8P1qKO+OI3+2nPVXRoTJL2uh5dLlzJklNEoS9QpoRPfyWIsOaPUJhIMeKNMCfuPbe7yNxqRnWDZZOW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxwTa1O/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A70C4CEED;
	Fri, 11 Jul 2025 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222795;
	bh=xQ1uO15BgNrojwWQfKGfBramGLnRFMIa/c54AN3CquM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxwTa1O/Mmy9onKd6HN3iBJuo1CFKIA1y5mVktIzN+m2wLK3sWZD+kwO4N6h5tma2
	 P8RVvPwsU9gf9FF/sVSx1+xSzYLw0m1FTN3YSuWZtBsTLgVyXMdDqRlT5SZNmmxR6V
	 RN41DaMazxptb9AGhi86KwluQscKk1y0jMCH+gdXx6jZMX8WKk+MpV6FHdhbtVdSAy
	 F4jiFYAWY3Ss0NgQoO5yHbhbApr3Jxe7VMa3TL3nbf0IeRN3U1UNXdQG4HaaCL0+rT
	 8Dm4VlCKc1zX1Dg0d4Dk7MDyu4HWcN2HE4WFdDvAgvGpn0intPlFVsq4nK44aNmY8y
	 twsMwdb00y+lw==
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
Subject: [PATCHv5 perf/core 17/22] selftests/bpf: Add optimized usdt variant for basic usdt test
Date: Fri, 11 Jul 2025 10:29:25 +0200
Message-ID: <20250711082931.3398027-18-jolsa@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711082931.3398027-1-jolsa@kernel.org>
References: <20250711082931.3398027-1-jolsa@kernel.org>
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


