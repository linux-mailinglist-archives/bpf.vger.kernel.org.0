Return-Path: <bpf+bounces-30067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D06048CA537
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8182F280FD7
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36D137C3C;
	Mon, 20 May 2024 23:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odyWFE7z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D31847
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248856; cv=none; b=E58wfgkYb2AhBRlEllrO533q0OS+xwrGGOO1ACB8sknC5cazdEuOlDh6NK8Cpt6LD4kcY+bEhxiitPW2lGYeGSlwliaE4iyvbAlkvd8kWUnaCGV9x+8tnTIckKXE4Q3Bod9g/VL2UpcSfhj2sVYF1bsqmKjv0r0PoIo8vvJRql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248856; c=relaxed/simple;
	bh=UOr8jcDQNy+75ZDhZJrIzzSRkorBpelOnSWmF5UQPOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsJdWLD2IqpAXl+AV4Bo+FKg9SLtdzd3kVdDcJCZNfTHPj/Ml9ByCJktuoULlu1vY33bLsg8GL53a+JYMXPs5yd+0rgyb/2yPoYY0SSrk5MEdPDhLFq9//AX8k2oG52ZfKN8FqwSN+/qbn48PDKR3EYN0py7SA16D1LmOeQrW5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odyWFE7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262EAC2BD10;
	Mon, 20 May 2024 23:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716248856;
	bh=UOr8jcDQNy+75ZDhZJrIzzSRkorBpelOnSWmF5UQPOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odyWFE7zinKLwWQSwUvfCAda4g70xiodPyflJv7FcVfHN4MFop8HGtPXRrPGAm7rl
	 cDBvpzC2E8pBlo1BpvCTIZgRgX1wiNr6TLRJL2tbYazFNZeCSL6zn2fBM0JzYZ+xcF
	 8r2/4lLy+zaBdoSq9QwnCqApWDQ3Vz+c+r8lWg7+39FT2GrUSx2XRY12DD7ivTfwsC
	 jbdWDBaD+pz14fiXhF5BQlrgvbDkHHuODZEjsf5JfNzIoM+6cy08AvxvdrnAYVlH2X
	 A67wFmsTQu/QKjHeXmq4NmqsZ0BqWLo2VnlhQaBdtwt4W6WHG1IX2ic/fvE+1V8mUs
	 dgu9B5Wa3BUfw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf 4/5] selftests/bpf: extend multi-uprobe tests with child thread case
Date: Mon, 20 May 2024 16:47:19 -0700
Message-ID: <20240520234720.1748918-5-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520234720.1748918-1-andrii@kernel.org>
References: <20240520234720.1748918-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend existing multi-uprobe tests to test that PID filtering works
correctly. We already have child *process* tests, but we need also child
*thread* tests. This patch adds spawn_thread() helper to start child
thread, wait for it to be ready, and then instruct it to trigger desired
uprobes.

Additionally, we extend BPF-side code to track thread ID, not just
process ID. Also we detect whether extraneous triggerings with
unexpected process IDs happened, and validate that none of that happened
in practice.

These changes prove that fixed PID filtering logic for multi-uprobe
works as expected. These tests fail on old kernels.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../bpf/prog_tests/uprobe_multi_test.c        | 107 ++++++++++++++++--
 .../selftests/bpf/progs/uprobe_multi.c        |  17 ++-
 2 files changed, 115 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
index 38fda42fd70f..677232d31432 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <unistd.h>
+#include <pthread.h>
 #include <test_progs.h>
 #include "uprobe_multi.skel.h"
 #include "uprobe_multi_bench.skel.h"
@@ -27,7 +28,10 @@ noinline void uprobe_multi_func_3(void)
 
 struct child {
 	int go[2];
+	int c2p[2]; /* child -> parent channel */
 	int pid;
+	int tid;
+	pthread_t thread;
 };
 
 static void release_child(struct child *child)
@@ -38,6 +42,10 @@ static void release_child(struct child *child)
 		return;
 	close(child->go[1]);
 	close(child->go[0]);
+	if (child->thread)
+		pthread_join(child->thread, NULL);
+	close(child->c2p[0]);
+	close(child->c2p[1]);
 	if (child->pid > 0)
 		waitpid(child->pid, &child_status, 0);
 }
@@ -63,7 +71,7 @@ static struct child *spawn_child(void)
 	if (pipe(child.go))
 		return NULL;
 
-	child.pid = fork();
+	child.pid = child.tid = fork();
 	if (child.pid < 0) {
 		release_child(&child);
 		errno = EINVAL;
@@ -89,6 +97,66 @@ static struct child *spawn_child(void)
 	return &child;
 }
 
+static void *child_thread(void *ctx)
+{
+	struct child *child = ctx;
+	int c = 0, err;
+
+	child->tid = syscall(SYS_gettid);
+
+	/* let parent know we are ready */
+	err = write(child->c2p[1], &c, 1);
+	if (err != 1)
+		pthread_exit(&err);
+
+	/* wait for parent's kick */
+	err = read(child->go[0], &c, 1);
+	if (err != 1)
+		pthread_exit(&err);
+
+	uprobe_multi_func_1();
+	uprobe_multi_func_2();
+	uprobe_multi_func_3();
+
+	err = 0;
+	pthread_exit(&err);
+}
+
+static struct child *spawn_thread(void)
+{
+	static struct child child;
+	int c, err;
+
+	/* pipe to notify child to execute the trigger functions */
+	if (pipe(child.go))
+		return NULL;
+	/* pipe to notify parent that child thread is ready */
+	if (pipe(child.c2p)) {
+		close(child.go[0]);
+		close(child.go[1]);
+		return NULL;
+	}
+
+	child.pid = getpid();
+
+	err = pthread_create(&child.thread, NULL, child_thread, &child);
+	if (err) {
+		err = -errno;
+		close(child.go[0]);
+		close(child.go[1]);
+		close(child.c2p[0]);
+		close(child.c2p[1]);
+		errno = -err;
+		return NULL;
+	}
+
+	err = read(child.c2p[0], &c, 1);
+	if (!ASSERT_EQ(err, 1, "child_thread_ready"))
+		return NULL;
+
+	return &child;
+}
+
 static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child)
 {
 	skel->bss->uprobe_multi_func_1_addr = (__u64) uprobe_multi_func_1;
@@ -103,15 +171,22 @@ static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child
 	 * passed at the probe attach.
 	 */
 	skel->bss->pid = child ? 0 : getpid();
+	skel->bss->expect_pid = child ? child->pid : 0;
+
+	/* trigger all probes, if we are testing child *process*, just to make
+	 * sure that PID filtering doesn't let through activations from wrong
+	 * PIDs; when we test child *thread*, we don't want to do this to
+	 * avoid double counting number of triggering events
+	 */
+	if (!child || !child->thread) {
+		uprobe_multi_func_1();
+		uprobe_multi_func_2();
+		uprobe_multi_func_3();
+	}
 
 	if (child)
 		kick_child(child);
 
-	/* trigger all probes */
-	uprobe_multi_func_1();
-	uprobe_multi_func_2();
-	uprobe_multi_func_3();
-
 	/*
 	 * There are 2 entry and 2 exit probe called for each uprobe_multi_func_[123]
 	 * function and each slepable probe (6) increments uprobe_multi_sleep_result.
@@ -126,8 +201,12 @@ static void uprobe_multi_test_run(struct uprobe_multi *skel, struct child *child
 
 	ASSERT_EQ(skel->bss->uprobe_multi_sleep_result, 6, "uprobe_multi_sleep_result");
 
-	if (child)
+	ASSERT_FALSE(skel->bss->bad_pid_seen, "bad_pid_seen");
+
+	if (child) {
 		ASSERT_EQ(skel->bss->child_pid, child->pid, "uprobe_multi_child_pid");
+		ASSERT_EQ(skel->bss->child_tid, child->tid, "uprobe_multi_child_tid");
+	}
 }
 
 static void test_skel_api(void)
@@ -210,6 +289,13 @@ test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_multi
 		return;
 
 	__test_attach_api(binary, pattern, opts, child);
+
+	/* pid filter (thread) */
+	child = spawn_thread();
+	if (!ASSERT_OK_PTR(child, "spawn_thread"))
+		return;
+
+	__test_attach_api(binary, pattern, opts, child);
 }
 
 static void test_attach_api_pattern(void)
@@ -495,6 +581,13 @@ static void test_link_api(void)
 		return;
 
 	__test_link_api(child);
+
+	/* pid filter (thread) */
+	child = spawn_thread();
+	if (!ASSERT_OK_PTR(child, "spawn_thread"))
+		return;
+
+	__test_link_api(child);
 }
 
 static void test_bench_attach_uprobe(void)
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index 419d9aa28fce..86a7ff5d3726 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -22,6 +22,10 @@ __u64 uprobe_multi_sleep_result = 0;
 
 int pid = 0;
 int child_pid = 0;
+int child_tid = 0;
+
+int expect_pid = 0;
+bool bad_pid_seen = false;
 
 bool test_cookie = false;
 void *user_ptr = 0;
@@ -36,11 +40,19 @@ static __always_inline bool verify_sleepable_user_copy(void)
 
 static void uprobe_multi_check(void *ctx, bool is_return, bool is_sleep)
 {
-	child_pid = bpf_get_current_pid_tgid() >> 32;
+	__u64 cur_pid_tgid = bpf_get_current_pid_tgid();
+	__u32 cur_pid;
 
-	if (pid && child_pid != pid)
+	cur_pid = cur_pid_tgid >> 32;
+	if (pid && cur_pid != pid)
 		return;
 
+	if (expect_pid && cur_pid != expect_pid)
+		bad_pid_seen = true;
+
+	child_pid = cur_pid_tgid >> 32;
+	child_tid = (__u32)cur_pid_tgid;
+
 	__u64 cookie = test_cookie ? bpf_get_attach_cookie(ctx) : 0;
 	__u64 addr = bpf_get_func_ip(ctx);
 
@@ -97,5 +109,6 @@ int uretprobe_sleep(struct pt_regs *ctx)
 SEC("uprobe.multi//proc/self/exe:uprobe_multi_func_*")
 int uprobe_extra(struct pt_regs *ctx)
 {
+	/* we need this one just to mix PID-filtered and global uprobes */
 	return 0;
 }
-- 
2.43.0


