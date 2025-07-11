Return-Path: <bpf+bounces-63028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F5B01662
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 10:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019AE17D918
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3697111BF;
	Fri, 11 Jul 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VI8Kxz4z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDD721ABBB;
	Fri, 11 Jul 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222820; cv=none; b=Fw4aQHocX3ngNBcHMfpXggdOte2GJrY6Yqf4qMXKzmfivdC503wnsEeKIT8VeLZ41HI1Xp8sQaFcNA3cE4uB6P3DlUEQh7NiF0UsRr2JMR5B6Lt0pIgGa2LlYYtVctdyTJ2AkjCZ9FntS8nPP/CzbYTpc+Yf4x+KGu1k0y/iWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222820; c=relaxed/simple;
	bh=+ywqxuQlx+5CdeLdgvKCdELs+zxvlnwLuqzRLDkHIbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azHTF0AfScDvQX3xV0wul6T03i8rAC3S5q7g1Yoj/Z+h3zGHxK393sfNntPr7D8aIAyZFjxN93oKhfXCdpT3zghxgBYmK0K9eL1qRY/C++KkcUulQ12Sz+ioDjOL2RPeg8Asacwg/KeTFiZsQcRWsUrnmBtaoLRxrLbGSjFB8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VI8Kxz4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6F4C4CEED;
	Fri, 11 Jul 2025 08:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752222818;
	bh=+ywqxuQlx+5CdeLdgvKCdELs+zxvlnwLuqzRLDkHIbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VI8Kxz4zjsaFgUQMDvmFnsj72uJCjLYt0XOY25vv10IIKUuyavvTksAYavVnSItLJ
	 CfmjqTMRFgnSTY/7MHum8lCRB4oB8vCL/Hno7ZVM/ff/ZCVUo7SdA9pnt5yF75OdBs
	 FXd6DaWioqv6wDPCykdGOsevEwVW3e9Ehw/TYKWIxQfFq1dsw8ifJrCQifNjX299Pf
	 L0cvhaEEw3Ibs4q23zhEZ9zbnTMh7TLMpVW8W87ZQp4criQRr5Hn+h20d3PErn8iK5
	 4DtrARY0zHOvms/vdU1nKQEaou5kQHngbpfnpCVleyB/hjUTV0o5JOgj6gyxiTsEqN
	 7yOZtVh7s0gKA==
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
Subject: [PATCHv5 perf/core 19/22] selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
Date: Fri, 11 Jul 2025 10:29:27 +0200
Message-ID: <20250711082931.3398027-20-jolsa@kernel.org>
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

Changing the test_uretprobe_regs_change test to test both uprobe
and uretprobe by adding entry consumer handler to the testmod
and making it to change one of the registers.

Making sure that changed values both uprobe and uretprobe handlers
propagate to the user space.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/uprobe_syscall.c        | 12 ++++++++----
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
index fc0b75dd9c36..aa779e200202 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -207,7 +207,7 @@ static int write_bpf_testmod_uprobe(unsigned long offset)
 	return ret != n ? (int) ret : 0;
 }
 
-static void test_uretprobe_regs_change(void)
+static void test_regs_change(void)
 {
 	struct pt_regs before = {}, after = {};
 	unsigned long *pb = (unsigned long *) &before;
@@ -221,6 +221,9 @@ static void test_uretprobe_regs_change(void)
 	if (!ASSERT_OK(err, "register_uprobe"))
 		return;
 
+	/* make sure uprobe gets optimized */
+	uprobe_regs_trigger();
+
 	uprobe_regs(&before, &after);
 
 	err = write_bpf_testmod_uprobe(0);
@@ -643,7 +646,6 @@ static void test_uretprobe_shadow_stack(void)
 
 	test_uprobe_regs_equal(false);
 	test_uprobe_regs_equal(true);
-	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
 
 	test_uprobe_legacy();
@@ -651,6 +653,8 @@ static void test_uretprobe_shadow_stack(void)
 	test_uprobe_session();
 	test_uprobe_usdt();
 
+	test_regs_change();
+
 	shstk_is_enabled = false;
 
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
@@ -799,8 +803,6 @@ static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uprobe_regs_equal(true);
-	if (test__start_subtest("uretprobe_regs_change"))
-		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
 		test_uretprobe_syscall_call();
 	if (test__start_subtest("uretprobe_shadow_stack"))
@@ -819,6 +821,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_sigill();
 	if (test__start_subtest("uprobe_regs_equal"))
 		test_uprobe_regs_equal(false);
+	if (test__start_subtest("regs_change"))
+		test_regs_change();
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918cdf31f..511911053bdc 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -500,15 +500,21 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
  */
 #ifdef __x86_64__
 
+static int
+uprobe_handler(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data)
+{
+	regs->cx = 0x87654321feebdaed;
+	return 0;
+}
+
 static int
 uprobe_ret_handler(struct uprobe_consumer *self, unsigned long func,
 		   struct pt_regs *regs, __u64 *data)
 
 {
 	regs->ax  = 0x12345678deadbeef;
-	regs->cx  = 0x87654321feebdaed;
 	regs->r11 = (u64) -1;
-	return true;
+	return 0;
 }
 
 struct testmod_uprobe {
@@ -520,6 +526,7 @@ struct testmod_uprobe {
 static DEFINE_MUTEX(testmod_uprobe_mutex);
 
 static struct testmod_uprobe uprobe = {
+	.consumer.handler = uprobe_handler,
 	.consumer.ret_handler = uprobe_ret_handler,
 };
 
-- 
2.50.0


