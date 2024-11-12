Return-Path: <bpf+bounces-44613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D09C5761
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 13:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0F4B47AA8
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7962213145;
	Tue, 12 Nov 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs9zImDL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B472123DB
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409769; cv=none; b=Qdn73hONEJwNQjKUHGx/5ZSYOx2uLlmXluVR/wd9k6t9Oe9GTpiPzIFwVLIWnGCmCTo6p2PxG1a/ZUTgyqRKvwpfeFch+0ePC4XoIpIUhQYdLB+EZEJORFY5eg5laSpgcuMzRckIobCI+Ncl95kWf80/f9SQwLZVvsjzSHgPyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409769; c=relaxed/simple;
	bh=FawqOUxNkJhlsFIJ/iUBmcyzM8iCx84JZqAfuSGvpw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afmRvb5uVQi1NDcfL/tezQrUvNnm649YwWQTzy9+iq9/BbZZO9NCcimZYO8ZqPX7nts82nqVU0lhi88dJQqI8ADjc2Uf5rwdnX8X96dccjQUe+pYlp+0FxD/95HOz88WGhqJH1reDJFmtfLsncNH4XzKqsn1WcfP8vQTwT5yEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs9zImDL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c805a0753so52747215ad.0
        for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 03:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731409767; x=1732014567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ipw+/tOoWpZ+cqXhj6lp+I84AFWlc4yAcESwPamR9RU=;
        b=Xs9zImDLh5QvgS82ayijAEDKM4oBbjuXN5ozwTqap0kvGa8IKRPmu5YYrhdB40Jg1l
         CDs9tLMTXFzf7USL6FYZtio7GYm2CbXimWYlpuXn3GwpVMmwHc0xHIbj+ecJNw8CVtZp
         zs5jw49i1/3LilWOB7dm5m74xRoq8BPx2jiJ2OQ3KA6L/0euyU6bYDD7+5UTQsFmQisf
         f2bmZyUUjSoxTu+IijRTPSLf21p8fSKxKBczoIaUGzFu4IVf9b6tpIHEdnpL0LgCMqeL
         0q5RncCFX1TdFojLGxvfDIemRx2aJMtb9DypLePOZGQmUGp6InTydBrS7kB4xY60GCWJ
         QxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409767; x=1732014567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ipw+/tOoWpZ+cqXhj6lp+I84AFWlc4yAcESwPamR9RU=;
        b=edVjXfqR36suq3KhwcPisYwbUDeuTILkkcKSWP/OcRC+RdCIDHYdPhtpotQS4sz7jz
         zwxalzqeWAgm25O1lF/HzdOa51CMKwO+X4ReBVp7cjQ8lx63Wk4uXv760lrF0V9eMmcy
         t1MEKy9x5f5hiL6tooSZ+HbFo3y7AKOhqURmqvMh0mnk5hEPCErK9XIZdjVIOcdFVJ0L
         RV2CCCFhybVP5gZV/G64bIZVvY7pEsY/VEDhMwwn9O1jfD8H8QiQ5LbcXeP7xgPDVX31
         kwsdZbtjoKpzXmyISujqir9Op5dBbqWznL9AByMJl8ztweVZH8oDL46aHjcsCamV5S2G
         /1lQ==
X-Gm-Message-State: AOJu0YyfhToMD8yvJ5fcMVELhAWkr2t3prxC7iELJ714I4oiMOdd5G4i
	dOI8j0Qg269LTsf7T0tNahsYt0y5z776gIC6o7NiqRSCFopna7AruME+Hw==
X-Google-Smtp-Source: AGHT+IF2MOgE20xqGs7n4O9wjiPghxWyjrRdhRClFxYOxh1cjxaWq2EM4tJ3z14WyktHuM4nC75gGQ==
X-Received: by 2002:a17:903:234c:b0:20b:6188:fc5e with SMTP id d9443c01a7336-21183d66a42mr224974075ad.28.1731409766516;
        Tue, 12 Nov 2024 03:09:26 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45eabsm91789135ad.114.2024.11.12.03.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:09:25 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [bpf-next 1/4] selftests/bpf: watchdog timer for test_progs
Date: Tue, 12 Nov 2024 03:09:03 -0800
Message-ID: <20241112110906.3045278-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112110906.3045278-1-eddyz87@gmail.com>
References: <20241112110906.3045278-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit provides a watchdog timer that sets a limit of how long a
single sub-test could run:
- if sub-test runs for 10 seconds, the name of the test is printed
  (currently the name of the test is printed only after it finishes);
- if sub-test runs for 120 seconds, the running thread is terminated
  with SIGSEGV (to trigger crash_handler() and get a stack trace).

Specifically:
- the timer is armed on each call to run_one_test();
- re-armed at each call to test__start_subtest();
- is stopped when exiting run_one_test().

Default timeout could be overridden using '-w' or '--watchdog-timeout'
options. Value 0 can be used to turn the timer off.
Here is an example execution:

    $ ./ssh-exec.sh ./test_progs -w 5 -t \
      send_signal/send_signal_perf_thread_remote,send_signal/send_signal_nmi_thread_remote
    WATCHDOG: test case send_signal/send_signal_nmi_thread_remote executes for 5 seconds, terminating with SIGSEGV
    Caught signal #11!
    Stack trace:
    ./test_progs(crash_handler+0x1f)[0x9049ef]
    /lib64/libc.so.6(+0x40d00)[0x7f1f1184fd00]
    /lib64/libc.so.6(read+0x4a)[0x7f1f1191cc4a]
    ./test_progs[0x720dd3]
    ./test_progs[0x71ef7a]
    ./test_progs(test_send_signal+0x1db)[0x71edeb]
    ./test_progs[0x9066c5]
    ./test_progs(main+0x5ed)[0x9054ad]
    /lib64/libc.so.6(+0x2a088)[0x7f1f11839088]
    /lib64/libc.so.6(__libc_start_main+0x8b)[0x7f1f1183914b]
    ./test_progs(_start+0x25)[0x527385]
    #292     send_signal:FAIL
    test_send_signal_common:PASS:reading pipe 0 nsec
    test_send_signal_common:PASS:reading pipe error: size 0 0 nsec
    test_send_signal_common:PASS:incorrect result 0 nsec
    test_send_signal_common:PASS:pipe_write 0 nsec
    test_send_signal_common:PASS:setpriority 0 nsec

Timer is implemented using timer_{create,start} librt API.
Internally librt uses pthreads for SIGEV_THREAD timers,
so this change adds a background timer thread to the test process.
Because of this a few checks in tests 'bpf_iter' and 'iters'
need an update to account for an extra thread.

For parallelized scenario the watchdog is also created for each worker
fork. If one of the workers gets stuck, it would be terminated by a
watchdog. In theory, this might lead to a scenario when all worker
threads are exhausted, however this should not be a problem for
server_main(), as it would exit with some of the tests not run.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       |   8 +-
 .../testing/selftests/bpf/prog_tests/iters.c  |   4 +-
 tools/testing/selftests/bpf/test_progs.c      | 104 ++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.h      |   6 +
 4 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index b8e1224cfd19..6f1bfacd7375 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -265,10 +265,10 @@ static void *run_test_task_tid(void *arg)
 
 	linfo.task.tid = 0;
 	linfo.task.pid = getpid();
-	/* This includes the parent thread, this thread,
+	/* This includes the parent thread, this thread, watchdog timer thread
 	 * and the do_nothing_wait thread
 	 */
-	test_task_common(&opts, 2, 1);
+	test_task_common(&opts, 3, 1);
 
 	test_task_common_nocheck(NULL, &num_unknown_tid, &num_known_tid);
 	ASSERT_GT(num_unknown_tid, 2, "check_num_unknown_tid");
@@ -297,7 +297,7 @@ static void test_task_pid(void)
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
 
-	test_task_common(&opts, 1, 1);
+	test_task_common(&opts, 2, 1);
 }
 
 static void test_task_pidfd(void)
@@ -315,7 +315,7 @@ static void test_task_pidfd(void)
 	opts.link_info = &linfo;
 	opts.link_info_len = sizeof(linfo);
 
-	test_task_common(&opts, 1, 1);
+	test_task_common(&opts, 2, 1);
 
 	close(pidfd);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/iters.c b/tools/testing/selftests/bpf/prog_tests/iters.c
index 89ff23c4a8bc..3cea71f9c500 100644
--- a/tools/testing/selftests/bpf/prog_tests/iters.c
+++ b/tools/testing/selftests/bpf/prog_tests/iters.c
@@ -192,8 +192,8 @@ static void subtest_task_iters(void)
 	syscall(SYS_getpgid);
 	iters_task__detach(skel);
 	ASSERT_EQ(skel->bss->procs_cnt, 1, "procs_cnt");
-	ASSERT_EQ(skel->bss->threads_cnt, thread_num + 1, "threads_cnt");
-	ASSERT_EQ(skel->bss->proc_threads_cnt, thread_num + 1, "proc_threads_cnt");
+	ASSERT_EQ(skel->bss->threads_cnt, thread_num + 2, "threads_cnt");
+	ASSERT_EQ(skel->bss->proc_threads_cnt, thread_num + 2, "proc_threads_cnt");
 	ASSERT_EQ(skel->bss->invalid_cnt, 0, "invalid_cnt");
 	pthread_mutex_unlock(&do_nothing_mutex);
 	for (int i = 0; i < thread_num; i++)
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 7421874380c2..6088d8222d59 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -16,6 +16,7 @@
 #include <sys/socket.h>
 #include <sys/un.h>
 #include <bpf/btf.h>
+#include <time.h>
 #include "json_writer.h"
 
 #include "network_helpers.h"
@@ -179,6 +180,88 @@ int usleep(useconds_t usec)
 	return syscall(__NR_nanosleep, &ts, NULL);
 }
 
+/* Watchdog timer is started by watchdog_start() and stopped by watchdog_stop().
+ * If timer is active for longer than env.secs_till_notify,
+ * it prints the name of the current test to the stderr.
+ * If timer is active for longer than env.secs_till_kill,
+ * it kills the thread executing the test by sending a SIGSEGV signal to it.
+ */
+static void watchdog_timer_func(union sigval sigval)
+{
+	struct itimerspec timeout = {};
+	char test_name[256];
+	int err;
+
+	if (env.subtest_state)
+		snprintf(test_name, sizeof(test_name), "%s/%s",
+			 env.test->test_name, env.subtest_state->name);
+	else
+		snprintf(test_name, sizeof(test_name), "%s",
+			 env.test->test_name);
+
+	switch (env.watchdog_state) {
+	case WD_NOTIFY:
+		fprintf(env.stderr_saved, "WATCHDOG: test case %s executes for %d seconds...\n",
+			test_name, env.secs_till_notify);
+		timeout.it_value.tv_sec = env.secs_till_kill - env.secs_till_notify;
+		env.watchdog_state = WD_KILL;
+		err = timer_settime(env.watchdog, 0, &timeout, NULL);
+		if (err)
+			fprintf(env.stderr_saved, "Failed to arm watchdog timer\n");
+		break;
+	case WD_KILL:
+		fprintf(env.stderr_saved,
+			"WATCHDOG: test case %s executes for %d seconds, terminating with SIGSEGV\n",
+			test_name, env.secs_till_kill);
+		pthread_kill(env.main_thread, SIGSEGV);
+		break;
+	}
+}
+
+static void watchdog_start(void)
+{
+	struct itimerspec timeout = {};
+	int err;
+
+	if (env.secs_till_kill == 0)
+		return;
+	if (env.secs_till_notify > 0) {
+		env.watchdog_state = WD_NOTIFY;
+		timeout.it_value.tv_sec = env.secs_till_notify;
+	} else {
+		env.watchdog_state = WD_KILL;
+		timeout.it_value.tv_sec = env.secs_till_kill;
+	}
+	err = timer_settime(env.watchdog, 0, &timeout, NULL);
+	if (err)
+		fprintf(env.stderr_saved, "Failed to start watchdog timer\n");
+}
+
+static void watchdog_stop(void)
+{
+	struct itimerspec timeout = {};
+	int err;
+
+	env.watchdog_state = WD_NOTIFY;
+	err = timer_settime(env.watchdog, 0, &timeout, NULL);
+	if (err)
+		fprintf(env.stderr_saved, "Failed to stop watchdog timer\n");
+}
+
+static void watchdog_init(void)
+{
+	struct sigevent watchdog_sev = {
+		.sigev_notify = SIGEV_THREAD,
+		.sigev_notify_function = watchdog_timer_func,
+	};
+	int err;
+
+	env.main_thread = pthread_self();
+	err = timer_create(CLOCK_MONOTONIC, &watchdog_sev, &env.watchdog);
+	if (err)
+		fprintf(stderr, "Failed to initialize watchdog timer\n");
+}
+
 static bool should_run(struct test_selector *sel, int num, const char *name)
 {
 	int i;
@@ -515,6 +598,7 @@ bool test__start_subtest(const char *subtest_name)
 
 	env.subtest_state = subtest_state;
 	stdio_hijack_init(&subtest_state->log_buf, &subtest_state->log_cnt);
+	watchdog_start();
 
 	return true;
 }
@@ -780,6 +864,7 @@ enum ARG_KEYS {
 	ARG_DEBUG = -1,
 	ARG_JSON_SUMMARY = 'J',
 	ARG_TRAFFIC_MONITOR = 'm',
+	ARG_WATCHDOG_TIMEOUT = 'w',
 };
 
 static const struct argp_option opts[] = {
@@ -810,6 +895,8 @@ static const struct argp_option opts[] = {
 	{ "traffic-monitor", ARG_TRAFFIC_MONITOR, "NAMES", 0,
 	  "Monitor network traffic of tests with name matching the pattern (supports '*' wildcard)." },
 #endif
+	{ "watchdog-timeout", ARG_WATCHDOG_TIMEOUT, "SECONDS", 0,
+	  "Kill the process if tests are not making progress for specified number of seconds." },
 	{},
 };
 
@@ -1035,6 +1122,16 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 					      true);
 		break;
 #endif
+	case ARG_WATCHDOG_TIMEOUT:
+		env->secs_till_kill = atoi(arg);
+		if (env->secs_till_kill < 0) {
+			fprintf(stderr, "Invalid watchdog timeout: %s.\n", arg);
+			return -EINVAL;
+		}
+		if (env->secs_till_kill < env->secs_till_notify) {
+			env->secs_till_notify = 0;
+		}
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -1263,10 +1360,12 @@ static void run_one_test(int test_num)
 
 	stdio_hijack(&state->log_buf, &state->log_cnt);
 
+	watchdog_start();
 	if (test->run_test)
 		test->run_test();
 	else if (test->run_serial_test)
 		test->run_serial_test();
+	watchdog_stop();
 
 	/* ensure last sub-test is finalized properly */
 	if (env.subtest_state)
@@ -1707,6 +1806,7 @@ static int worker_main_send_subtests(int sock, struct test_state *state)
 static int worker_main(int sock)
 {
 	save_netns();
+	watchdog_init();
 
 	while (true) {
 		/* receive command */
@@ -1816,6 +1916,8 @@ int main(int argc, char **argv)
 
 	sigaction(SIGSEGV, &sigact, NULL);
 
+	env.secs_till_notify = 10;
+	env.secs_till_kill = 120;
 	err = argp_parse(&argp, argc, argv, 0, NULL, &env);
 	if (err)
 		return err;
@@ -1824,6 +1926,8 @@ int main(int argc, char **argv)
 	if (err)
 		return err;
 
+	watchdog_init();
+
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 	libbpf_set_print(libbpf_print_fn);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 7a58895867c3..74de33ae37e5 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -131,6 +131,12 @@ struct test_env {
 	pid_t *worker_pids; /* array of worker pids */
 	int *worker_socks; /* array of worker socks */
 	int *worker_current_test; /* array of current running test for each worker */
+
+	pthread_t main_thread;
+	int secs_till_notify;
+	int secs_till_kill;
+	timer_t watchdog; /* watch for stalled tests/subtests */
+	enum { WD_NOTIFY, WD_KILL } watchdog_state;
 };
 
 #define MAX_LOG_TRUNK_SIZE 8192
-- 
2.47.0


