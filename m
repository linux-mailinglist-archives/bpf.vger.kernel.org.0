Return-Path: <bpf+bounces-56348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BFEA9585F
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F83C3A2E40
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB6722129D;
	Mon, 21 Apr 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGcqbKEG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1432921A447;
	Mon, 21 Apr 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272101; cv=none; b=kH7B6PitoM8l2ROY92aO9CtvNPJx7pwW+Qe3podU8EKUXtmMnikNrO8jaef0/3cNZ8QLuJncxWW823rWfz1s/BiEiyWegXsFj+eFCjPxm6GKTNsKpwYPryb+4EmPhkfn4JNyqBF05vZsksw0NPc01MBhk8m0bCWvW+nwrasHfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272101; c=relaxed/simple;
	bh=7eDFb2bAXwqgRpr5YRBO8GLWorMSw54LpDK70BKgOtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSPod62VfppkooUOv+WonGT5Gp2TZrPyukV+s7/pbXnLuQLD2T6o/3IRbKhyVfHpus6jbJQK/2Amrwv/2+GvPSkXvO2ySdIvQoHBCgl/sYfsTYvDrlQcR2w8dYXMSgYgVhxAjGySGKWMLLNebEK8nx0277i1K0rb3LaGSaRkOFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGcqbKEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670D0C4CEE4;
	Mon, 21 Apr 2025 21:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745272100;
	bh=7eDFb2bAXwqgRpr5YRBO8GLWorMSw54LpDK70BKgOtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lGcqbKEGKHShum4cV4RIDj+V8SixsqAxJuVMFNKxGquiyXwTYwdT+r2uTKl8/PC7t
	 gVfBF8BdIU5KbCyXO391IqhtyPeNg5ANlZ0wSu/aBGCB59/wn9d2y6YlyccSI7BIg4
	 uPwqbaEhoZEJl0wTPqfXMFZ6WHs1kpGJG9hjstiVcm2jhQMOBVpZjxD9VngL1Svvcy
	 AxfWHjH+i/yvRmKi6G9txmqSX6N/94kOZHpJpIrZ+xH30T9oVGm0bUyCzNc7W6zHtr
	 4dJQSu6pefcaDBRB6cU8xk/P76Jd7p+o65up+iSur5oO6GkmqZRAdOiqtCie8tDGKJ
	 bnb6wQ/WfTrTw==
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
Subject: [PATCH perf/core 19/22] selftests/bpf: Change test_uretprobe_regs_change for uprobe and uretprobe
Date: Mon, 21 Apr 2025 23:44:19 +0200
Message-ID: <20250421214423.393661-20-jolsa@kernel.org>
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
index 6d88c5b0f6aa..684f8ab2e7f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
@@ -203,7 +203,7 @@ static int write_bpf_testmod_uprobe(unsigned long offset)
 	return ret != n ? (int) ret : 0;
 }
 
-static void test_uretprobe_regs_change(void)
+static void test_regs_change(void)
 {
 	struct pt_regs before = {}, after = {};
 	unsigned long *pb = (unsigned long *) &before;
@@ -217,6 +217,9 @@ static void test_uretprobe_regs_change(void)
 	if (!ASSERT_OK(err, "register_uprobe"))
 		return;
 
+	/* make sure uprobe gets optimized */
+	uprobe_regs_trigger();
+
 	uprobe_regs(&before, &after);
 
 	err = write_bpf_testmod_uprobe(0);
@@ -632,7 +635,6 @@ static void test_uretprobe_shadow_stack(void)
 
 	test_uprobe_regs_equal(false);
 	test_uprobe_regs_equal(true);
-	test_uretprobe_regs_change();
 	test_uretprobe_syscall_call();
 
 	test_uprobe_legacy();
@@ -640,6 +642,8 @@ static void test_uretprobe_shadow_stack(void)
 	test_uprobe_session();
 	test_uprobe_usdt();
 
+	test_regs_change();
+
 	shstk_is_enabled = false;
 
 	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
@@ -755,8 +759,6 @@ static void __test_uprobe_syscall(void)
 {
 	if (test__start_subtest("uretprobe_regs_equal"))
 		test_uprobe_regs_equal(true);
-	if (test__start_subtest("uretprobe_regs_change"))
-		test_uretprobe_regs_change();
 	if (test__start_subtest("uretprobe_syscall_call"))
 		test_uretprobe_syscall_call();
 	if (test__start_subtest("uretprobe_shadow_stack"))
@@ -775,6 +777,8 @@ static void __test_uprobe_syscall(void)
 		test_uprobe_sigill();
 	if (test__start_subtest("uprobe_regs_equal"))
 		test_uprobe_regs_equal(false);
+	if (test__start_subtest("regs_change"))
+		test_regs_change();
 }
 #else
 static void __test_uprobe_syscall(void)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index f38eaf0d35ef..5a3dc463ace5 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -496,15 +496,21 @@ static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
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
@@ -516,6 +522,7 @@ struct testmod_uprobe {
 static DEFINE_MUTEX(testmod_uprobe_mutex);
 
 static struct testmod_uprobe uprobe = {
+	.consumer.handler = uprobe_handler,
 	.consumer.ret_handler = uprobe_ret_handler,
 };
 
-- 
2.49.0


