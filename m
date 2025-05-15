Return-Path: <bpf+bounces-58306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66597AB863C
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 14:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D035188BBFF
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 12:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5153299946;
	Thu, 15 May 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFiQsT9V"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85B29A9FD;
	Thu, 15 May 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311360; cv=none; b=NZYK2YiMfDmUa0CbU3UxbJ3UJ0IxK5Uo3zicN3UCVlL77j+dnSR2bRqhhUuEWGCwKxwY/dalb63k35b/zXivUHE36vg55r3psZaeu1O68QMyEP+64kkLAG0ZITY7+lTYtKKKfD4wm2nyfoDCgZ7pe10uDmcmbvivo1cbUQKq+/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311360; c=relaxed/simple;
	bh=UHsM0cJ2kl2Zy9w+Cjj5a2E4oRqjDNgJ+bX6ZOczKnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spk7EQ3jgfdhOfyKVEJXj/Crvv4fgbCTi4wymmzAw5w3v9TLzVQJKqeAhQRUqQyiXphBNWJ5dtrt5GvMOQe1BBaCm5/JptC5QGrBlR3+Ax/z7x8DID39HI3DlUcmc/HEVUgwrcyCfZ2/br907SguZbx1PeKarS4B6B8PDZsBhik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFiQsT9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD0DC4CEE7;
	Thu, 15 May 2025 12:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747311360;
	bh=UHsM0cJ2kl2Zy9w+Cjj5a2E4oRqjDNgJ+bX6ZOczKnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pFiQsT9Vh09ZyXHlj07OL/W9EgmIOS3o9v40str4/YVIwOt6OTO5lW2+3aprOHsPY
	 iAPB/l4RW71R37StGnE27AHTBncPy/TAoR5/xMyOkLpFIdSyeCQhjVoQQ/MwSJB1Ha
	 sLf+Y2UZH72WLlK3J5junC3VRKRjgYnoM6uQ5OawC9T8P1Q2LUKUUr4ttwKSmv/or1
	 Vecd20uG86pzXukuo8m6nE+k+XwC2NftJ7Bg2WjSgWvxZ7YPXpnIkdvTD+0kSgAugE
	 N34ABc00px23nGbaSz6xR2LDO3SaZSOs8kTM3o1xlIPhAQe0uOhC9vZkh0gyCFNEd1
	 cnfOq5wghrlqQ==
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
Subject: [PATCHv2 perf/core 19/22] selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
Date: Thu, 15 May 2025 14:11:16 +0200
Message-ID: <20250515121121.2332905-20-jolsa@kernel.org>
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
index 645de7d71948..d59492b91035 100644
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
@@ -648,7 +651,6 @@ static void test_uretprobe_shadow_stack(void)
 
 	test_uprobe_regs_equal(false);
 	test_uprobe_regs_equal(true);
-	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
 
 	test_uprobe_legacy();
@@ -656,6 +658,8 @@ static void test_uretprobe_shadow_stack(void)
 	test_uprobe_session();
 	test_uprobe_usdt();
 
+	test_regs_change();
+
 	shstk_is_enabled = false;
 
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
@@ -790,8 +794,6 @@ static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uprobe_regs_equal(true);
-	if (test__start_subtest("uretprobe_regs_change"))
-		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
 		test_uretprobe_syscall_call();
 	if (test__start_subtest("uretprobe_shadow_stack"))
@@ -810,6 +812,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_sigill();
 	if (test__start_subtest("uprobe_regs_equal"))
 		test_uprobe_regs_equal(false);
+	if (test__start_subtest("regs_change"))
+		test_regs_change();
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 2e54b95ad898..93a4854a9f5d 100644
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
2.49.0


