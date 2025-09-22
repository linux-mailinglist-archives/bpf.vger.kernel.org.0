Return-Path: <bpf+bounces-69177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FABB8F29D
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 08:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E0C17E141
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 06:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CC298CD5;
	Mon, 22 Sep 2025 06:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVJ0pSDs"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799B23D7FD;
	Mon, 22 Sep 2025 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522938; cv=none; b=g8lb5UemVBml1gimGTEci20lsFXyQgI42QM/1RYkAXvOubZo233lA5xksBwOtVwfMGSPW05EJQuz2Pp7VKoTyda45tm6bzD6DGvWGv/TzPIa5XlB5bUxjevnGKhtl7vSvwIZ2Z1vDUAr0wzRHfHzoCIXtG8ly5FMt6vKMn3BfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522938; c=relaxed/simple;
	bh=pJRF8S8U2FX02MCJ49AA3VhDSUd/4W936qZZdQA49LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Omt0J3P+s1FByWfWBFVDU3ucEUzzegaz5q128xwWmW7VhPTh9E0MsBEL9zNj4r447eX6MK+8VA87n5PwflIE7saf0PgCS/M5FhlBy/HEeSyVCaJ5EPixLEOFcUnzMscUpsioHrqqbIeRrjtRJ3OjDSGJSPIzjekLIHm5ruKFLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVJ0pSDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B89CC4CEF0;
	Mon, 22 Sep 2025 06:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758522938;
	bh=pJRF8S8U2FX02MCJ49AA3VhDSUd/4W936qZZdQA49LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YVJ0pSDsNARG9+ZSgivoLx2HyycjZfnqMlSkqVrGwFc8L91NUcPJUR6uMfREkrZZ5
	 uAFo4RbH6UGDYK6NKHltZ4sPdOgFr06HO84vspL3VwXbsyjqhiVdeFJHwNrc7X8KH5
	 bGieG1NW5lMPCKjJNydYdkNELwQItuCDR2fq6Aw+WwHkW3fhYYCtoUn7DV3BPfaTAT
	 HQXYbi+3j7fQ2TKQodGBURIOXdPVGrd/bFcp8hwg5lOF9g7iMbfYEW3OfNZkBYWwfW
	 8/A6fGL/RZzB4SeCdtQjX8n9xL3af4n1WYqqelteh5YA9i68QG8ngmE81ivE7SHir6
	 cAqldsoyhqUOg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Cc: jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kees@kernel.org,
	samitolvanen@google.com,
	rppt@kernel.org,
	luto@kernel.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 2/2] lib/test_fprobe: Add recursion check test cases
Date: Mon, 22 Sep 2025 15:35:33 +0900
Message-ID: <175852293339.307379.8831172703363408291.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <175852291163.307379.14414635977719513326.stgit@devnote2>
References: <175852291163.307379.14414635977719513326.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add test cases for checking recursion level must be less than 2.
This ensures that fprobe can prevent infinite recursive call by
itself.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/tests/test_fprobe.c |   92 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/lib/tests/test_fprobe.c b/lib/tests/test_fprobe.c
index cf92111b5c79..0022da242a83 100644
--- a/lib/tests/test_fprobe.c
+++ b/lib/tests/test_fprobe.c
@@ -17,8 +17,10 @@ static u32 rand1, entry_val, exit_val;
 /* Use indirect calls to avoid inlining the target functions */
 static u32 (*target)(u32 value);
 static u32 (*target2)(u32 value);
+static u32 (*target3)(u32 value);
 static unsigned long target_ip;
 static unsigned long target2_ip;
+static unsigned long target3_ip;
 static int entry_return_value;
 
 static noinline u32 fprobe_selftest_target(u32 value)
@@ -31,13 +33,18 @@ static noinline u32 fprobe_selftest_target2(u32 value)
 	return (value / div_factor) + 1;
 }
 
+static noinline u32 fprobe_selftest_target3(u32 value)
+{
+	return (value / div_factor) + 2;
+}
+
 static notrace int fp_entry_handler(struct fprobe *fp, unsigned long ip,
 				    unsigned long ret_ip,
 				    struct ftrace_regs *fregs, void *data)
 {
 	KUNIT_EXPECT_FALSE(current_test, preemptible());
 	/* This can be called on the fprobe_selftest_target and the fprobe_selftest_target2 */
-	if (ip != target_ip)
+	if (ip != target_ip && ip != target3_ip)
 		KUNIT_EXPECT_EQ(current_test, ip, target2_ip);
 	entry_val = (rand1 / div_factor);
 	if (fp->entry_data_size) {
@@ -190,6 +197,84 @@ static void test_fprobe_skip(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
 }
 
+static int recur_count;
+static int recur_high;
+
+static notrace int fp_recur_entry_handler(struct fprobe *fp, unsigned long ip,
+					  unsigned long ret_ip,
+					  struct ftrace_regs *fregs, void *data)
+{
+	/* fgraph/fprobe allows one-level nesting. */
+	if (recur_count > 1)
+		return 0;
+
+	recur_count++;
+	if (recur_count > recur_high)
+		recur_high = recur_count;
+	target3(rand1);
+	recur_count--;
+
+	return 0;
+}
+
+static notrace void fp_recur_exit_handler(struct fprobe *fp, unsigned long ip,
+					  unsigned long ret_ip,
+					  struct ftrace_regs *fregs, void *data)
+{
+	/* fgraph/fprobe allows one-level nesting. */
+	if (recur_count > 1)
+		return;
+
+	recur_count++;
+	if (recur_count > recur_high)
+		recur_high = recur_count;
+	target3(rand1);
+	recur_count--;
+}
+
+static void test_fprobe_recursion_entry(struct kunit *test)
+{
+	struct fprobe fp = {
+		.entry_handler = fp_recur_entry_handler,
+	};
+	struct fprobe fp3 = {
+		.entry_handler = fp_recur_entry_handler,
+	};
+
+	current_test = test;
+	recur_count = 0;
+	recur_high = 0;
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp, "fprobe_selftest_target", NULL));
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp3, "fprobe_selftest_target3", NULL));
+
+	target(rand1);
+
+	KUNIT_EXPECT_LE(test, recur_high, 2);
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp3));
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
+}
+
+static void test_fprobe_recursion_exit(struct kunit *test)
+{
+	struct fprobe fp = {
+		.exit_handler = fp_recur_exit_handler,
+	};
+	struct fprobe fp3 = {
+		.exit_handler = fp_recur_exit_handler,
+	};
+
+	current_test = test;
+	recur_count = 0;
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp, "fprobe_selftest_target", NULL));
+	KUNIT_EXPECT_EQ(test, 0, register_fprobe(&fp3, "fprobe_selftest_target3", NULL));
+
+	target(rand1);
+
+	KUNIT_EXPECT_LE(test, recur_high, 2);
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp3));
+	KUNIT_EXPECT_EQ(test, 0, unregister_fprobe(&fp));
+}
+
 static unsigned long get_ftrace_location(void *func)
 {
 	unsigned long size, addr = (unsigned long)func;
@@ -205,8 +290,10 @@ static int fprobe_test_init(struct kunit *test)
 	rand1 = get_random_u32_above(div_factor);
 	target = fprobe_selftest_target;
 	target2 = fprobe_selftest_target2;
+	target3 = fprobe_selftest_target3;
 	target_ip = get_ftrace_location(target);
 	target2_ip = get_ftrace_location(target2);
+	target3_ip = get_ftrace_location(target3);
 
 	return 0;
 }
@@ -217,6 +304,8 @@ static struct kunit_case fprobe_testcases[] = {
 	KUNIT_CASE(test_fprobe_syms),
 	KUNIT_CASE(test_fprobe_data),
 	KUNIT_CASE(test_fprobe_skip),
+	KUNIT_CASE(test_fprobe_recursion_entry),
+	KUNIT_CASE(test_fprobe_recursion_exit),
 	{}
 };
 
@@ -227,4 +316,3 @@ static struct kunit_suite fprobe_test_suite = {
 };
 
 kunit_test_suites(&fprobe_test_suite);
-


