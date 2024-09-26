Return-Path: <bpf+bounces-40349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA53098731F
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 13:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EB4286F66
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 11:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D31158D66;
	Thu, 26 Sep 2024 11:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMiLZ7pz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F43156230;
	Thu, 26 Sep 2024 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351640; cv=none; b=paZEEFkHOc1XBoMGWWMAe0CKZqxESrZ0C4Dhq2hO3T4I8YoiYF3tr8SgyeBSVBt2ifaCAeEbaFB0cvDQRzCNCXqlOak5ng0bKv8mSNvEByEwKkNQorLcs5jBdAfOIg/inVyNwLFpwAW2dDq2gM0Pq3Z2iB7UeZdw43y2E6eEtmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351640; c=relaxed/simple;
	bh=ldoq/21Iy8XOxX/1iQ6TNqo+98qmfhdsNcodCAQ09Io=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vb9h9ZNxaQpjlTWsoRYvrZY9StbRFwm7itRvjQdBWoDsmnULiyckbJ3z9ebDqYH5Lf4kj3ZVXHR0bU/6B9TuhTj4lg66DnYqLXcWFFAXaa7VYO/iHOLIJ8kWWpjLOsg35Pmad1oO013Pwd5fGxsCg6t8rC/6L2uEQtHmLzlSS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMiLZ7pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4D1C4CEC5;
	Thu, 26 Sep 2024 11:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727351639;
	bh=ldoq/21Iy8XOxX/1iQ6TNqo+98qmfhdsNcodCAQ09Io=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vMiLZ7pzmIyRwyZFaRNQd4JqEKy9ZK8kSUbIxiCvazs9iE9KwMUaM2lSMtGSu8R+g
	 hcDWtNYgURtRVZbAo51maeBoSKsBOXRSVpInslqs/XnHSGIwLsvQlkrNbwEyTI7Tni
	 LW37extN0HxHdDJnXZbm1P5KlbDvUF2XcprvK3gAAt9imGsmKoEXaZbL84N5cAoBw8
	 7yzJxEaSCb0SV/So7dREb2LjuMSsMftuG58Q83KZ8nYx6D6D28vspI5LiIcal1FkrS
	 DxUsSlxBjvp6FP9FKfHS/MC74oB7SLOjdbE3s7VyNFPDaz4HozryDCJkkDizY2xgoa
	 8v/Z/gjVPe2sQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay12@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Augment send_signal test with remote signaling
Date: Thu, 26 Sep 2024 11:53:28 +0000
Message-Id: <20240926115328.105634-3-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240926115328.105634-1-puranjay@kernel.org>
References: <20240926115328.105634-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases to test bpf_send_signal_remote(). In these new test cases,
the main process triggers the BPF program and the forked process
receives the signals. The target process's signal handler receives a
cookie from the bpf program.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 133 +++++++++++++-----
 .../bpf/progs/test_send_signal_kern.c         |  35 ++++-
 2 files changed, 130 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 6cc69900b3106..beb771347a503 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -8,17 +8,25 @@ static int sigusr1_received;
 
 static void sigusr1_handler(int signum)
 {
-	sigusr1_received = 1;
+	sigusr1_received = 8;
+}
+
+static void sigusr1_siginfo_handler(int s, siginfo_t *i, void *v)
+{
+	sigusr1_received = i->si_value.sival_int;
 }
 
 static void test_send_signal_common(struct perf_event_attr *attr,
-				    bool signal_thread)
+				    bool signal_thread, bool remote)
 {
 	struct test_send_signal_kern *skel;
+	struct sigaction sa;
 	int pipe_c2p[2], pipe_p2c[2];
 	int err = -1, pmu_fd = -1;
+	volatile int j = 0;
 	char buf[256];
 	pid_t pid;
+	int old_prio;
 
 	if (!ASSERT_OK(pipe(pipe_c2p), "pipe_c2p"))
 		return;
@@ -39,11 +47,14 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	}
 
 	if (pid == 0) {
-		int old_prio;
-		volatile int j = 0;
-
 		/* install signal handler and notify parent */
-		ASSERT_NEQ(signal(SIGUSR1, sigusr1_handler), SIG_ERR, "signal");
+		if (remote) {
+			sa.sa_sigaction = sigusr1_siginfo_handler;
+			sa.sa_flags = SA_RESTART | SA_SIGINFO;
+			ASSERT_NEQ(sigaction(SIGUSR1, &sa, NULL), -1, "sigaction");
+		} else {
+			ASSERT_NEQ(signal(SIGUSR1, sigusr1_handler), SIG_ERR, "signal");
+		}
 
 		close(pipe_c2p[0]); /* close read */
 		close(pipe_p2c[1]); /* close write */
@@ -52,10 +63,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		 * that if an interrupt happens, the underlying task
 		 * is this process.
 		 */
-		errno = 0;
-		old_prio = getpriority(PRIO_PROCESS, 0);
-		ASSERT_OK(errno, "getpriority");
-		ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
+		if (!remote) {
+			errno = 0;
+			old_prio = getpriority(PRIO_PROCESS, 0);
+			ASSERT_OK(errno, "getpriority");
+			ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
+		}
 
 		/* notify parent signal handler is installed */
 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
@@ -66,20 +79,25 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		/* wait a little for signal handler */
 		for (int i = 0; i < 1000000000 && !sigusr1_received; i++) {
 			j /= i + j + 1;
-			if (!attr)
-				/* trigger the nanosleep tracepoint program. */
-				usleep(1);
+			if (remote)
+				sleep(1);
+			else
+				if (!attr)
+					/* trigger the nanosleep tracepoint program. */
+					usleep(1);
 		}
 
-		buf[0] = sigusr1_received ? '2' : '0';
-		ASSERT_EQ(sigusr1_received, 1, "sigusr1_received");
+		buf[0] = sigusr1_received;
+
+		ASSERT_EQ(sigusr1_received, 8, "sigusr1_received");
 		ASSERT_EQ(write(pipe_c2p[1], buf, 1), 1, "pipe_write");
 
 		/* wait for parent notification and exit */
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
 
 		/* restore the old priority */
-		ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
+		if (!remote)
+			ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
 
 		close(pipe_c2p[1]);
 		close(pipe_p2c[0]);
@@ -93,6 +111,17 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		goto skel_open_load_failure;
 
+	/* boost with a high priority so we got a higher chance
+	 * that if an interrupt happens, the underlying task
+	 * is this process.
+	 */
+	if (remote) {
+		errno = 0;
+		old_prio = getpriority(PRIO_PROCESS, 0);
+		ASSERT_OK(errno, "getpriority");
+		ASSERT_OK(setpriority(PRIO_PROCESS, 0, -20), "setpriority");
+	}
+
 	if (!attr) {
 		err = test_send_signal_kern__attach(skel);
 		if (!ASSERT_OK(err, "skel_attach")) {
@@ -100,8 +129,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 			goto destroy_skel;
 		}
 	} else {
-		pmu_fd = syscall(__NR_perf_event_open, attr, pid, -1 /* cpu */,
-				 -1 /* group id */, 0 /* flags */);
+		if (!remote)
+			pmu_fd = syscall(__NR_perf_event_open, attr, pid, -1 /* cpu */,
+					 -1 /* group id */, 0 /* flags */);
+		else
+			pmu_fd = syscall(__NR_perf_event_open, attr, getpid(), -1 /* cpu */,
+					 -1 /* group id */, 0 /* flags */);
 		if (!ASSERT_GE(pmu_fd, 0, "perf_event_open")) {
 			err = -1;
 			goto destroy_skel;
@@ -119,11 +152,30 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	/* trigger the bpf send_signal */
 	skel->bss->signal_thread = signal_thread;
 	skel->bss->sig = SIGUSR1;
-	skel->bss->pid = pid;
+	if (!remote) {
+		skel->bss->target_pid = 0;
+		skel->bss->pid = pid;
+	} else {
+		skel->bss->target_pid = pid;
+		skel->bss->pid = getpid();
+	}
 
 	/* notify child that bpf program can send_signal now */
 	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
 
+	/* For the remote test, the BPF program is triggered from this
+	 * process but the other process/thread is signaled.
+	 */
+	if (remote) {
+		if (!attr) {
+			for (int i = 0; i < 10; i++)
+				usleep(1);
+		} else {
+			for (int i = 0; i < 100000000; i++)
+				j /= i + 1;
+		}
+	}
+
 	/* wait for result */
 	err = read(pipe_c2p[0], buf, 1);
 	if (!ASSERT_GE(err, 0, "reading pipe"))
@@ -133,7 +185,7 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		goto disable_pmu;
 	}
 
-	ASSERT_EQ(buf[0], '2', "incorrect result");
+	ASSERT_EQ(buf[0], 8, "incorrect result");
 
 	/* notify child safe to exit */
 	ASSERT_EQ(write(pipe_p2c[1], buf, 1), 1, "pipe_write");
@@ -142,18 +194,21 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	close(pmu_fd);
 destroy_skel:
 	test_send_signal_kern__destroy(skel);
+	/* restore the old priority */
+	if (remote)
+		ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
 skel_open_load_failure:
 	close(pipe_c2p[0]);
 	close(pipe_p2c[1]);
 	wait(NULL);
 }
 
-static void test_send_signal_tracepoint(bool signal_thread)
+static void test_send_signal_tracepoint(bool signal_thread, bool remote)
 {
-	test_send_signal_common(NULL, signal_thread);
+	test_send_signal_common(NULL, signal_thread, remote);
 }
 
-static void test_send_signal_perf(bool signal_thread)
+static void test_send_signal_perf(bool signal_thread, bool remote)
 {
 	struct perf_event_attr attr = {
 		.freq = 1,
@@ -162,10 +217,10 @@ static void test_send_signal_perf(bool signal_thread)
 		.config = PERF_COUNT_SW_CPU_CLOCK,
 	};
 
-	test_send_signal_common(&attr, signal_thread);
+	test_send_signal_common(&attr, signal_thread, remote);
 }
 
-static void test_send_signal_nmi(bool signal_thread)
+static void test_send_signal_nmi(bool signal_thread, bool remote)
 {
 	struct perf_event_attr attr = {
 		.sample_period = 1,
@@ -191,21 +246,35 @@ static void test_send_signal_nmi(bool signal_thread)
 		close(pmu_fd);
 	}
 
-	test_send_signal_common(&attr, signal_thread);
+	test_send_signal_common(&attr, signal_thread, remote);
 }
 
 void test_send_signal(void)
 {
 	if (test__start_subtest("send_signal_tracepoint"))
-		test_send_signal_tracepoint(false);
+		test_send_signal_tracepoint(false, false);
 	if (test__start_subtest("send_signal_perf"))
-		test_send_signal_perf(false);
+		test_send_signal_perf(false, false);
 	if (test__start_subtest("send_signal_nmi"))
-		test_send_signal_nmi(false);
+		test_send_signal_nmi(false, false);
 	if (test__start_subtest("send_signal_tracepoint_thread"))
-		test_send_signal_tracepoint(true);
+		test_send_signal_tracepoint(true, false);
 	if (test__start_subtest("send_signal_perf_thread"))
-		test_send_signal_perf(true);
+		test_send_signal_perf(true, false);
 	if (test__start_subtest("send_signal_nmi_thread"))
-		test_send_signal_nmi(true);
+		test_send_signal_nmi(true, false);
+
+	/* Signal remote thread and thread group */
+	if (test__start_subtest("send_signal_tracepoint_remote"))
+		test_send_signal_tracepoint(false, true);
+	if (test__start_subtest("send_signal_perf_remote"))
+		test_send_signal_perf(false, true);
+	if (test__start_subtest("send_signal_nmi_remote"))
+		test_send_signal_nmi(false, true);
+	if (test__start_subtest("send_signal_tracepoint_thread_remote"))
+		test_send_signal_tracepoint(true, true);
+	if (test__start_subtest("send_signal_perf_thread_remote"))
+		test_send_signal_perf(true, true);
+	if (test__start_subtest("send_signal_nmi_thread_remote"))
+		test_send_signal_nmi(true, true);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index 92354cd720440..4f25b60fe05b2 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -1,27 +1,50 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 
-__u32 sig = 0, pid = 0, status = 0, signal_thread = 0;
+struct task_struct *bpf_task_from_pid(int pid) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+int bpf_send_signal_remote(struct task_struct *task, int sig, enum pid_type type, int value) __ksym;
+
+__u32 sig = 0, pid = 0, status = 0, signal_thread = 0, target_pid = 0;
 
 static __always_inline int bpf_send_signal_test(void *ctx)
 {
+	struct task_struct *target_task = NULL;
 	int ret;
+	int value;
 
 	if (status != 0 || pid == 0)
 		return 0;
 
 	if ((bpf_get_current_pid_tgid() >> 32) == pid) {
-		if (signal_thread)
-			ret = bpf_send_signal_thread(sig);
-		else
-			ret = bpf_send_signal(sig);
+		if (target_pid) {
+			target_task = bpf_task_from_pid(target_pid);
+			if (!target_task)
+				return 0;
+			value = 8;
+		}
+
+		if (signal_thread) {
+			if (target_pid)
+				ret = bpf_send_signal_remote(target_task, sig, PIDTYPE_PID, value);
+			else
+				ret = bpf_send_signal_thread(sig);
+		} else {
+			if (target_pid)
+				ret = bpf_send_signal_remote(target_task, sig, PIDTYPE_TGID, value);
+			else
+				ret = bpf_send_signal(sig);
+		}
 		if (ret == 0)
 			status = 1;
 	}
 
+	if (target_task)
+		bpf_task_release(target_task);
+
 	return 0;
 }
 
-- 
2.40.1


