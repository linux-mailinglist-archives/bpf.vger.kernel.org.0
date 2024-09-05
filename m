Return-Path: <bpf+bounces-39002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D053796D79E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 13:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7641C23481
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 11:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F8919415D;
	Thu,  5 Sep 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgjmS8j7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4651618732F;
	Thu,  5 Sep 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537134; cv=none; b=Oe/bOq6wVjCZRtCYQxqS1k1hDJ3RjsA6ZSrVVR/S3IqRWCNEKLNua6+8lMThhgPELpE1rhQATxcyILCY1/7DnIatuF2+PqnKBVqvlzYpUBokCxWZhl7+IKSdCkBj//RSR+yw7I7KkDtmXF6YyM+VAs4bp2vmQs4R0JSs1mjtexM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537134; c=relaxed/simple;
	bh=D5S920V3t6cXwRIkyEPu6OV9wD5N2mHt4dpwnePX+aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSq/46Q7A2Y74DkL9abPUcoQbnnk0UGqgCfLAEa7l771/oLgHsKFG5jfYi5A5wDSiFQc5aWcMWfwYiZIMfCnOFwSrncnOUeiYg4Zidl5mgg+QWnD/Nntx+6A/uLjdf3kdc2g6hTwgMmprc4QTHY/HlMlY0rkLxwWUEurZmHmroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgjmS8j7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3103C4CEC4;
	Thu,  5 Sep 2024 11:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725537134;
	bh=D5S920V3t6cXwRIkyEPu6OV9wD5N2mHt4dpwnePX+aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgjmS8j7f+2G5g08iLPE+6/5N61nvXDi/4X1dchOBd1qnu4eei6hT+g1ATi3qkNwm
	 QiSAR+T5IggyBLNT8GXMzSqSWi6Dvw6H0ARZHoth2oYg7TvlTSUj2FQMi2CArlD/Cf
	 XYXFm08EBVvyj2PteHQYzhdibBUmwpmlsi/oVpVcYONUCRCBGeivzKNg6VY8pHuDLe
	 GZDBpje/ylDxOSZ9SVIKh9zQgjxN6TStSGNIwxXCAfXmTD4efb6Xf+jcIAjeeCpj7q
	 DOQBzEj1UGvHcGJJ9aWlZnq0LhtaZJN1AJVzx7axYaB7GzAuonPsAU5672SjqU+Huq
	 2rNtUSVbowrJA==
From: Jiri Olsa <jolsa@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tianyi Liu <i.pear@outlook.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCHv2 bpf-next 4/4] selftests/bpf: Add uprobe multi pid filter test for clone-ed processes
Date: Thu,  5 Sep 2024 14:51:24 +0300
Message-ID: <20240905115124.1503998-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905115124.1503998-1-jolsa@kernel.org>
References: <20240905115124.1503998-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The idea is to run same test as for test_pid_filter_process, but instead
of standard fork-ed process we create the process with clone(CLONE_VM..)
to make sure the thread leader process filter works properly in this case.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 66 ++++++++++++-------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 9c2f99233304..f160d01ba5da 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -40,6 +40,7 @@ struct child {
 	int pid;
 	int tid;
 	pthread_t thread;
+	char stack[65536];
 };
 
 static void release_child(struct child *child)
@@ -69,41 +70,56 @@ static void kick_child(struct child *child)
 	fflush(NULL);
 }
 
-static int spawn_child(struct child *child)
+static int child_func(void *arg)
 {
+	struct child *child = arg;
 	int err, c;
 
+	close(child->go[1]);
+
+	/* wait for parent's kick */
+	err = read(child->go[0], &c, 1);
+	if (err != 1)
+		exit(err);
+
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+	usdt_trigger();
+
+	exit(errno);
+}
+
+static int spawn_child_flag(struct child *child, bool clone_vm)
+{
 	/* pipe to notify child to execute the trigger functions */
 	if (pipe(child->go))
 		return -1;
 
-	child->pid = child->tid = fork();
+	if (clone_vm) {
+		child->pid = child->tid = clone(child_func, child->stack + sizeof(child->stack)/2,
+						CLONE_VM|SIGCHLD, child);
+	} else {
+		child->pid = child->tid = fork();
+	}
 	if (child->pid < 0) {
 		release_child(child);
 		errno = EINVAL;
 		return -1;
 	}
 
-	/* child */
-	if (child->pid == 0) {
-		close(child->go[1]);
-
-		/* wait for parent's kick */
-		err = read(child->go[0], &c, 1);
-		if (err != 1)
-			exit(err);
-
-		uprobe_multi_func_1();
-		uprobe_multi_func_2();
-		uprobe_multi_func_3();
-		usdt_trigger();
-
-		exit(errno);
-	}
+	/* fork-ed child */
+	if (!clone_vm && child->pid == 0)
+		child_func(child);
 
 	return 0;
 }
 
+static int spawn_child(struct child *child)
+{
+	return spawn_child_flag(child, false);
+}
+
 static void *child_thread(void *ctx)
 {
 	struct child *child = ctx;
@@ -948,7 +964,7 @@ static struct bpf_program *uprobe_multi_program(struct uprobe_multi_pid_filter *
 
 #define TASKS 3
 
-static void run_pid_filter(struct uprobe_multi_pid_filter *skel, bool retprobe)
+static void run_pid_filter(struct uprobe_multi_pid_filter *skel, bool clone_vm, bool retprobe)
 {
 	LIBBPF_OPTS(bpf_uprobe_multi_opts, opts, .retprobe = retprobe);
 	struct bpf_link *link[TASKS] = {};
@@ -958,7 +974,7 @@ static void run_pid_filter(struct uprobe_multi_pid_filter *skel, bool retprobe)
 	memset(skel->bss->test, 0, sizeof(skel->bss->test));
 
 	for (i = 0; i < TASKS; i++) {
-		if (!ASSERT_OK(spawn_child(&child[i]), "spawn_child"))
+		if (!ASSERT_OK(spawn_child_flag(&child[i], clone_vm), "spawn_child"))
 			goto cleanup;
 		skel->bss->pids[i] = child[i].pid;
 	}
@@ -986,7 +1002,7 @@ static void run_pid_filter(struct uprobe_multi_pid_filter *skel, bool retprobe)
 		release_child(&child[i]);
 }
 
-static void test_pid_filter_process(void)
+static void test_pid_filter_process(bool clone_vm)
 {
 	struct uprobe_multi_pid_filter *skel;
 
@@ -994,8 +1010,8 @@ static void test_pid_filter_process(void)
 	if (!ASSERT_OK_PTR(skel, "uprobe_multi_pid_filter__open_and_load"))
 		return;
 
-	run_pid_filter(skel, false);
-	run_pid_filter(skel, true);
+	run_pid_filter(skel, clone_vm, false);
+	run_pid_filter(skel, clone_vm, true);
 
 	uprobe_multi_pid_filter__destroy(skel);
 }
@@ -1093,5 +1109,7 @@ void test_uprobe_multi_test(void)
 	if (test__start_subtest("consumers"))
 		test_consumers();
 	if (test__start_subtest("filter_fork"))
-		test_pid_filter_process();
+		test_pid_filter_process(false);
+	if (test__start_subtest("filter_clone_vm"))
+		test_pid_filter_process(true);
 }
-- 
2.46.0


