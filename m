Return-Path: <bpf+bounces-35505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF293B07E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216511C220A5
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534CE158A18;
	Wed, 24 Jul 2024 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEWRZmw4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C913D157491;
	Wed, 24 Jul 2024 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821203; cv=none; b=Zd45X3DufWSZE45PB7xapV1D1e0SKmPK7owBeZPNtoNQlpw1vQU+kj33344umvyoUSafdoY+Ugo8AjM6t7eucBfSJpiHNhsXXGyKiqbjOB22wJN4crgtTv/uKc4plkbKHGvrxNl/1ZNdCJzYDee9GUxjIwmKKKDx3DWvU6Q1XnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821203; c=relaxed/simple;
	bh=WVHnpgVlRWA6v0PEIyFysfZEhhuYE/sRCymcf8mpVi8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqJaPss0ZoalbPFgFUoCC3WrltcS92gzWlnoFVIvPMjKQNL2iziloW+SQafkvZkHGvTQAkgFqpCtk09/BtUHTNja9/oDFKM6pg2h7xsk9v6klvCxDC/GX6sti2j6ERu6DZpeGhm+/esqEwQmaXAnjB8neIAKENJYFUpMTeUVu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEWRZmw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27650C4AF0E;
	Wed, 24 Jul 2024 11:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721821203;
	bh=WVHnpgVlRWA6v0PEIyFysfZEhhuYE/sRCymcf8mpVi8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iEWRZmw4G2UDKAzCVu3u+MJPZSyFdNIrwZPKr3aL4ZWMSqrUrA6Y2o7ItA2uZN0gX
	 ign3YJAcU8JXSWnHBJm3jxRBTTfqwCRx9oHw1Wp2ZZq3+HHiGBDzZTigroQ/ZDlYPY
	 xjkrmJQEZxygo0OTwa9CbG/kUUrTum9bPE4hNGuVmB36xd8RJF85mt2mN6oBWWCvGf
	 GdS4iC8a9JAZ69xb2Q2K0jfGxmg9+NqzJmDUD5dXnDDYSblNNADjaNDkORpVCD3Sia
	 yfM7aNJl5FbehzmlduSiqGfOjzyju3hSR25b8yqoLI1u3FM8t4Y5n0loCS2X85mIB3
	 p7MwXPrXWpDrw==
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Augment send_signal test with remote signaling
Date: Wed, 24 Jul 2024 11:39:44 +0000
Message-Id: <20240724113944.75977-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240724113944.75977-1-puranjay@kernel.org>
References: <20240724113944.75977-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases to test bpf_send_signal_pid/tgid(). In these new test cases,
the main process triggers the BPF program and the forked process
receives the signals.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/send_signal.c    | 110 +++++++++++++-----
 .../bpf/progs/test_send_signal_kern.c         |  17 ++-
 2 files changed, 95 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 6cc69900b310..a8392dfc69e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -12,13 +12,15 @@ static void sigusr1_handler(int signum)
 }
 
 static void test_send_signal_common(struct perf_event_attr *attr,
-				    bool signal_thread)
+				    bool signal_thread, bool remote)
 {
 	struct test_send_signal_kern *skel;
 	int pipe_c2p[2], pipe_p2c[2];
 	int err = -1, pmu_fd = -1;
+	volatile int j = 0;
 	char buf[256];
 	pid_t pid;
+	int old_prio;
 
 	if (!ASSERT_OK(pipe(pipe_c2p), "pipe_c2p"))
 		return;
@@ -39,9 +41,6 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 	}
 
 	if (pid == 0) {
-		int old_prio;
-		volatile int j = 0;
-
 		/* install signal handler and notify parent */
 		ASSERT_NEQ(signal(SIGUSR1, sigusr1_handler), SIG_ERR, "signal");
 
@@ -52,10 +51,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
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
@@ -66,9 +67,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
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
 
 		buf[0] = sigusr1_received ? '2' : '0';
@@ -79,7 +83,8 @@ static void test_send_signal_common(struct perf_event_attr *attr,
 		ASSERT_EQ(read(pipe_p2c[0], buf, 1), 1, "pipe_read");
 
 		/* restore the old priority */
-		ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
+		if (!remote)
+			ASSERT_OK(setpriority(PRIO_PROCESS, 0, old_prio), "setpriority");
 
 		close(pipe_c2p[1]);
 		close(pipe_p2c[0]);
@@ -93,6 +98,17 @@ static void test_send_signal_common(struct perf_event_attr *attr,
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
@@ -100,8 +116,12 @@ static void test_send_signal_common(struct perf_event_attr *attr,
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
@@ -119,11 +139,30 @@ static void test_send_signal_common(struct perf_event_attr *attr,
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
@@ -142,18 +181,21 @@ static void test_send_signal_common(struct perf_event_attr *attr,
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
@@ -162,10 +204,10 @@ static void test_send_signal_perf(bool signal_thread)
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
@@ -191,21 +233,35 @@ static void test_send_signal_nmi(bool signal_thread)
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
index 92354cd72044..fd6c055377ae 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -4,7 +4,7 @@
 #include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 
-__u32 sig = 0, pid = 0, status = 0, signal_thread = 0;
+__u32 sig = 0, pid = 0, status = 0, signal_thread = 0, target_pid = 0;
 
 static __always_inline int bpf_send_signal_test(void *ctx)
 {
@@ -14,10 +14,17 @@ static __always_inline int bpf_send_signal_test(void *ctx)
 		return 0;
 
 	if ((bpf_get_current_pid_tgid() >> 32) == pid) {
-		if (signal_thread)
-			ret = bpf_send_signal_thread(sig);
-		else
-			ret = bpf_send_signal(sig);
+		if (signal_thread) {
+			if (target_pid != 0)
+				ret = bpf_send_signal_pid(sig, target_pid);
+			else
+				ret = bpf_send_signal_thread(sig);
+		} else {
+			if (target_pid != 0)
+				ret = bpf_send_signal_tgid(sig, target_pid);
+			else
+				ret = bpf_send_signal(sig);
+		}
 		if (ret == 0)
 			status = 1;
 	}
-- 
2.40.1


