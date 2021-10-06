Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DAA424653
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhJFS62 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 14:58:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40076 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238898AbhJFS60 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 14:58:26 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196F9rBn020407
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 11:56:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vuTFPALfeV+4NEvYB5QlGn5m8t9f62v8O6z96E1eDek=;
 b=YYES6OBLSlJpPiq8aeGahqwGsMjpAvcFIfYrHoQSppmHLtv0QbOEkv3YFd31eK40D2JP
 YkKE5TGq5wqxs3x92iV9mOozIcBjERyuJqqGabge8nj4kneEOEX61Gotwe9IK96saNUk
 u3S3luHFAPxiVpL0MqyQFS9Xkw+Rli7barE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhe6q9yka-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 11:56:34 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 11:56:32 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 157BE4BDB5AD; Wed,  6 Oct 2021 11:56:20 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>
Subject: [PATCH bpf-next v6 01/14] selftests/bpf: Add parallelism to test_progs
Date:   Wed, 6 Oct 2021 11:56:06 -0700
Message-ID: <20211006185619.364369-2-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211006185619.364369-1-fallentree@fb.com>
References: <20211006185619.364369-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: LIAlh5oV7HUog7feTDP3HH2lY9DYV4ob
X-Proofpoint-GUID: LIAlh5oV7HUog7feTDP3HH2lY9DYV4ob
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch adds "-j" mode to test_progs, executing tests in multiple
process.  "-j" mode is optional, and works with all existing test
selection mechanism, as well as "-v", "-l" etc.

In "-j" mode, main process use UDS/DGRAM to communicate to each forked
worker, commanding it to run tests and collect logs. After all tests are
finished, a summary is printed. main process use multiple competing
threads to dispatch work to worker, trying to keep them all busy.

The test status will be printed as soon as it is finished, if there are
error logs, it will be printed after the final summary line.

By specifying "--debug", additional debug information on server/worker
communication will be printed.

Example output:
  > ./test_progs -n 15-20 -j
  [   12.801730] bpf_testmod: loading out-of-tree module taints kernel.
  Launching 8 workers.
  #20 btf_split:OK
  #16 btf_endian:OK
  #18 btf_module:OK
  #17 btf_map_in_map:OK
  #19 btf_skc_cls_ingress:OK
  #15 btf_dump:OK
  Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yucong Sun <sunyucong@gmail.com>
---
 tools/testing/selftests/bpf/test_progs.c | 598 +++++++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.h |  36 +-
 2 files changed, 600 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 2ed01f615d20..51e18d8df7f2 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -12,6 +12,11 @@
 #include <string.h>
 #include <execinfo.h> /* backtrace */
 #include <linux/membarrier.h>
+#include <sys/sysinfo.h> /* get_nprocs */
+#include <netinet/in.h>
+#include <sys/select.h>
+#include <sys/socket.h>
+#include <sys/un.h>
=20
 /* Adapted from perf/util/string.c */
 static bool glob_match(const char *str, const char *pat)
@@ -48,6 +53,8 @@ struct prog_test_def {
 	bool force_log;
 	int error_cnt;
 	int skip_cnt;
+	int sub_succ_cnt;
+	bool should_run;
 	bool tested;
 	bool need_cgroup_cleanup;
=20
@@ -97,6 +104,10 @@ static void dump_test_log(const struct prog_test_def =
*test, bool failed)
 	if (stdout =3D=3D env.stdout)
 		return;
=20
+	/* worker always holds log */
+	if (env.worker_id !=3D -1)
+		return;
+
 	fflush(stdout); /* exports env.log_buf & env.log_cnt */
=20
 	if (env.verbosity > VERBOSE_NONE || test->force_log || failed) {
@@ -107,8 +118,6 @@ static void dump_test_log(const struct prog_test_def =
*test, bool failed)
 				fprintf(env.stdout, "\n");
 		}
 	}
-
-	fseeko(stdout, 0, SEEK_SET); /* rewind */
 }
=20
 static void skip_account(void)
@@ -172,14 +181,14 @@ void test__end_subtest()
=20
 	dump_test_log(test, sub_error_cnt);
=20
-	fprintf(env.stdout, "#%d/%d %s/%s:%s\n",
+	fprintf(stdout, "#%d/%d %s/%s:%s\n",
 	       test->test_num, test->subtest_num, test->test_name, test->subtes=
t_name,
 	       sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
=20
 	if (sub_error_cnt)
-		env.fail_cnt++;
+		test->error_cnt++;
 	else if (test->skip_cnt =3D=3D 0)
-		env.sub_succ_cnt++;
+		test->sub_succ_cnt++;
 	skip_account();
=20
 	free(test->subtest_name);
@@ -474,6 +483,8 @@ enum ARG_KEYS {
 	ARG_LIST_TEST_NAMES =3D 'l',
 	ARG_TEST_NAME_GLOB_ALLOWLIST =3D 'a',
 	ARG_TEST_NAME_GLOB_DENYLIST =3D 'd',
+	ARG_NUM_WORKERS =3D 'j',
+	ARG_DEBUG =3D -1,
 };
=20
 static const struct argp_option opts[] =3D {
@@ -495,6 +506,10 @@ static const struct argp_option opts[] =3D {
 	  "Run tests with name matching the pattern (supports '*' wildcard)." }=
,
 	{ "deny", ARG_TEST_NAME_GLOB_DENYLIST, "NAMES", 0,
 	  "Don't run tests with name matching the pattern (supports '*' wildcar=
d)." },
+	{ "workers", ARG_NUM_WORKERS, "WORKERS", OPTION_ARG_OPTIONAL,
+	  "Number of workers to run in parallel, default to number of cpus." },
+	{ "debug", ARG_DEBUG, NULL, 0,
+	  "print extra debug information for test_progs." },
 	{},
 };
=20
@@ -650,7 +665,7 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 				fprintf(stderr,
 					"Unable to setenv SELFTESTS_VERBOSE=3D1 (errno=3D%d)",
 					errno);
-				return -1;
+				return -EINVAL;
 			}
 		}
=20
@@ -661,6 +676,20 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
 	case ARG_LIST_TEST_NAMES:
 		env->list_test_names =3D true;
 		break;
+	case ARG_NUM_WORKERS:
+		if (arg) {
+			env->workers =3D atoi(arg);
+			if (!env->workers) {
+				fprintf(stderr, "Invalid number of worker: %s.", arg);
+				return -EINVAL;
+			}
+		} else {
+			env->workers =3D get_nprocs();
+		}
+		break;
+	case ARG_DEBUG:
+		env->debug =3D true;
+		break;
 	case ARGP_KEY_ARG:
 		argp_usage(state);
 		break;
@@ -678,7 +707,7 @@ static void stdio_hijack(void)
 	env.stdout =3D stdout;
 	env.stderr =3D stderr;
=20
-	if (env.verbosity > VERBOSE_NONE) {
+	if (env.verbosity > VERBOSE_NONE && env.worker_id =3D=3D -1) {
 		/* nothing to do, output to stdout by default */
 		return;
 	}
@@ -704,10 +733,6 @@ static void stdio_restore(void)
 		return;
=20
 	fclose(stdout);
-	free(env.log_buf);
-
-	env.log_buf =3D NULL;
-	env.log_cnt =3D 0;
=20
 	stdout =3D env.stdout;
 	stderr =3D env.stderr;
@@ -794,11 +819,456 @@ void crash_handler(int signum)
 		dump_test_log(env.test, true);
 	if (env.stdout)
 		stdio_restore();
-
+	if (env.worker_id !=3D -1)
+		fprintf(stderr, "[%d]: ", env.worker_id);
 	fprintf(stderr, "Caught signal #%d!\nStack trace:\n", signum);
 	backtrace_symbols_fd(bt, sz, STDERR_FILENO);
 }
=20
+void sigint_handler(int signum) {
+	for (int i =3D 0; i < env.workers; i++)
+		if (env.worker_socks[i] > 0)
+			close(env.worker_socks[i]);
+}
+
+static int current_test_idx;
+static pthread_mutex_t current_test_lock;
+static pthread_mutex_t stdout_output_lock;
+
+struct test_result {
+	int error_cnt;
+	int skip_cnt;
+	int sub_succ_cnt;
+
+	size_t log_cnt;
+	char *log_buf;
+};
+
+static struct test_result test_results[ARRAY_SIZE(prog_test_defs)];
+
+static inline const char *str_msg(const struct msg *msg, char *buf)
+{
+	switch (msg->type) {
+	case MSG_DO_TEST:
+		sprintf(buf, "MSG_DO_TEST %d", msg->do_test.test_num);
+		break;
+	case MSG_TEST_DONE:
+		sprintf(buf, "MSG_TEST_DONE %d (log: %d)",
+			msg->test_done.test_num,
+			msg->test_done.have_log);
+		break;
+	case MSG_TEST_LOG:
+		sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
+			strlen(msg->test_log.log_buf),
+			msg->test_log.is_last);
+		break;
+	case MSG_EXIT:
+		sprintf(buf, "MSG_EXIT");
+		break;
+	default:
+		sprintf(buf, "UNKNOWN");
+		break;
+	}
+
+	return buf;
+}
+
+static int send_message(int sock, const struct msg *msg)
+{
+	char buf[256];
+
+	if (env.debug)
+		fprintf(stderr, "Sending msg: %s\n", str_msg(msg, buf));
+	return send(sock, msg, sizeof(*msg), 0);
+}
+
+static int recv_message(int sock, struct msg *msg)
+{
+	int ret;
+	char buf[256];
+
+	memset(msg, 0, sizeof(*msg));
+	ret =3D recv(sock, msg, sizeof(*msg), 0);
+	if (ret >=3D 0) {
+		if (env.debug)
+			fprintf(stderr, "Received msg: %s\n", str_msg(msg, buf));
+	}
+	return ret;
+}
+
+static void run_one_test(int test_num)
+{
+	struct prog_test_def *test =3D &prog_test_defs[test_num];
+
+	env.test =3D test;
+
+	test->run_test();
+
+	/* ensure last sub-test is finalized properly */
+	if (test->subtest_name)
+		test__end_subtest();
+
+	test->tested =3D true;
+
+	dump_test_log(test, test->error_cnt);
+
+	reset_affinity();
+	restore_netns();
+	if (test->need_cgroup_cleanup)
+		cleanup_cgroup_environment();
+}
+
+struct dispatch_data {
+	int worker_id;
+	int sock_fd;
+};
+
+void *dispatch_thread(void *ctx)
+{
+	struct dispatch_data *data =3D ctx;
+	int sock_fd;
+	FILE *log_fd =3D NULL;
+
+	sock_fd =3D data->sock_fd;
+
+	while (true) {
+		int test_to_run =3D -1;
+		struct prog_test_def *test;
+		struct test_result *result;
+
+		/* grab a test */
+		{
+			pthread_mutex_lock(&current_test_lock);
+
+			if (current_test_idx >=3D prog_test_cnt) {
+				pthread_mutex_unlock(&current_test_lock);
+				goto done;
+			}
+
+			test =3D &prog_test_defs[current_test_idx];
+			test_to_run =3D current_test_idx;
+			current_test_idx++;
+
+			pthread_mutex_unlock(&current_test_lock);
+		}
+
+		if (!test->should_run)
+			continue;
+
+		/* run test through worker */
+		{
+			struct msg msg_do_test;
+
+			msg_do_test.type =3D MSG_DO_TEST;
+			msg_do_test.do_test.test_num =3D test_to_run;
+			if (send_message(sock_fd, &msg_do_test) < 0) {
+				perror("Fail to send command");
+				goto done;
+			}
+			env.worker_current_test[data->worker_id] =3D test_to_run;
+		}
+
+		/* wait for test done */
+		{
+			int err;
+			struct msg msg_test_done;
+
+			err =3D recv_message(sock_fd, &msg_test_done);
+			if (err < 0)
+				goto error;
+			if (msg_test_done.type !=3D MSG_TEST_DONE)
+				goto error;
+			if (test_to_run !=3D msg_test_done.test_done.test_num)
+				goto error;
+
+			test->tested =3D true;
+			result =3D &test_results[test_to_run];
+
+			result->error_cnt =3D msg_test_done.test_done.error_cnt;
+			result->skip_cnt =3D msg_test_done.test_done.skip_cnt;
+			result->sub_succ_cnt =3D msg_test_done.test_done.sub_succ_cnt;
+
+			/* collect all logs */
+			if (msg_test_done.test_done.have_log) {
+				log_fd =3D open_memstream(&result->log_buf, &result->log_cnt);
+				if (!log_fd)
+					goto error;
+
+				while (true) {
+					struct msg msg_log;
+
+					if (recv_message(sock_fd, &msg_log) < 0)
+						goto error;
+					if (msg_log.type !=3D MSG_TEST_LOG)
+						goto error;
+
+					fprintf(log_fd, "%s", msg_log.test_log.log_buf);
+					if (msg_log.test_log.is_last)
+						break;
+				}
+				fclose(log_fd);
+				log_fd =3D NULL;
+			}
+			/* output log */
+			{
+				pthread_mutex_lock(&stdout_output_lock);
+
+				if (result->log_cnt) {
+					result->log_buf[result->log_cnt] =3D '\0';
+					fprintf(stdout, "%s", result->log_buf);
+					if (result->log_buf[result->log_cnt - 1] !=3D '\n')
+						fprintf(stdout, "\n");
+				}
+
+				fprintf(stdout, "#%d %s:%s\n",
+					test->test_num, test->test_name,
+					result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
+
+				pthread_mutex_unlock(&stdout_output_lock);
+			}
+
+		} /* wait for test done */
+	} /* while (true) */
+error:
+	if (env.debug)
+		fprintf(stderr, "[%d]: Protocol/IO error: %s.\n", data->worker_id, str=
error(errno));
+
+	if (log_fd)
+		fclose(log_fd);
+done:
+	{
+		struct msg msg_exit;
+
+		msg_exit.type =3D MSG_EXIT;
+		if (send_message(sock_fd, &msg_exit) < 0) {
+			if (env.debug)
+				fprintf(stderr, "[%d]: send_message msg_exit: %s.\n",
+					data->worker_id, strerror(errno));
+		}
+	}
+	return NULL;
+}
+
+static void print_all_error_logs(void)
+{
+	if (env.fail_cnt)
+		fprintf(stdout, "\nAll error logs:\n");
+
+	/* print error logs again */
+
+	for (int i =3D 0; i < prog_test_cnt; i++) {
+		struct prog_test_def *test;
+		struct test_result *result;
+
+		test =3D &prog_test_defs[i];
+		result =3D &test_results[i];
+
+		if (!test->tested || !result->error_cnt)
+			continue;
+
+		fprintf(stdout, "\n#%d %s:%s\n",
+			test->test_num, test->test_name,
+			result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
+
+		if (result->log_cnt) {
+			result->log_buf[result->log_cnt] =3D '\0';
+			fprintf(stdout, "%s", result->log_buf);
+			if (result->log_buf[result->log_cnt - 1] !=3D '\n')
+				fprintf(stdout, "\n");
+		}
+	}
+}
+
+static int server_main(void)
+{
+	pthread_t *dispatcher_threads;
+	struct dispatch_data *data;
+	struct sigaction sigact_int =3D {
+		.sa_handler =3D sigint_handler,
+		.sa_flags =3D SA_RESETHAND,
+	};
+
+	sigaction(SIGINT, &sigact_int, NULL);
+
+	dispatcher_threads =3D calloc(sizeof(pthread_t), env.workers);
+	data =3D calloc(sizeof(struct dispatch_data), env.workers);
+
+	env.worker_current_test =3D calloc(sizeof(int), env.workers);
+	for (int i =3D 0; i < env.workers; i++) {
+		int rc;
+
+		data[i].worker_id =3D i;
+		data[i].sock_fd =3D env.worker_socks[i];
+		rc =3D pthread_create(&dispatcher_threads[i], NULL, dispatch_thread, &=
data[i]);
+		if (rc < 0) {
+			perror("Failed to launch dispatcher thread");
+			exit(EXIT_ERR_SETUP_INFRA);
+		}
+	}
+
+	/* wait for all dispatcher to finish */
+	for (int i =3D 0; i < env.workers; i++) {
+		while (true) {
+			int ret =3D pthread_tryjoin_np(dispatcher_threads[i], NULL);
+
+			if (!ret) {
+				break;
+			} else if (ret =3D=3D EBUSY) {
+				if (env.debug)
+					fprintf(stderr, "Still waiting for thread %d (test %d).\n",
+						i,  env.worker_current_test[i] + 1);
+				usleep(1000 * 1000);
+				continue;
+			} else {
+				fprintf(stderr, "Unexpected error joining dispatcher thread: %d", re=
t);
+				break;
+			}
+		}
+	}
+	free(dispatcher_threads);
+	free(env.worker_current_test);
+	free(data);
+
+	/* generate summary */
+	fflush(stderr);
+	fflush(stdout);
+
+	for (int i =3D 0; i < prog_test_cnt; i++) {
+		struct prog_test_def *current_test;
+		struct test_result *result;
+
+		current_test =3D &prog_test_defs[i];
+		result =3D &test_results[i];
+
+		if (!current_test->tested)
+			continue;
+
+		env.succ_cnt +=3D result->error_cnt ? 0 : 1;
+		env.skip_cnt +=3D result->skip_cnt;
+		if (result->error_cnt)
+			env.fail_cnt++;
+		env.sub_succ_cnt +=3D result->sub_succ_cnt;
+	}
+
+	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
+		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
+
+	print_all_error_logs();
+
+	/* reap all workers */
+	for (int i =3D 0; i < env.workers; i++) {
+		int wstatus, pid;
+
+		pid =3D waitpid(env.worker_pids[i], &wstatus, 0);
+		if (pid !=3D env.worker_pids[i])
+			perror("Unable to reap worker");
+	}
+
+	return 0;
+}
+
+static int worker_main(int sock)
+{
+	save_netns();
+
+	while (true) {
+		/* receive command */
+		struct msg msg;
+
+		if (recv_message(sock, &msg) < 0)
+			goto out;
+
+		switch (msg.type) {
+		case MSG_EXIT:
+			if (env.debug)
+				fprintf(stderr, "[%d]: worker exit.\n",
+					env.worker_id);
+			goto out;
+		case MSG_DO_TEST: {
+			int test_to_run;
+			struct prog_test_def *test;
+			struct msg msg_done;
+
+			test_to_run =3D msg.do_test.test_num;
+			test =3D &prog_test_defs[test_to_run];
+
+			if (env.debug)
+				fprintf(stderr, "[%d]: #%d:%s running.\n",
+					env.worker_id,
+					test_to_run + 1,
+					test->test_name);
+
+			stdio_hijack();
+
+			run_one_test(test_to_run);
+
+			stdio_restore();
+
+			memset(&msg_done, 0, sizeof(msg_done));
+			msg_done.type =3D MSG_TEST_DONE;
+			msg_done.test_done.test_num =3D test_to_run;
+			msg_done.test_done.error_cnt =3D test->error_cnt;
+			msg_done.test_done.skip_cnt =3D test->skip_cnt;
+			msg_done.test_done.sub_succ_cnt =3D test->sub_succ_cnt;
+			msg_done.test_done.have_log =3D false;
+
+			if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cn=
t) {
+				if (env.log_cnt)
+					msg_done.test_done.have_log =3D true;
+			}
+			if (send_message(sock, &msg_done) < 0) {
+				perror("Fail to send message done");
+				goto out;
+			}
+
+			/* send logs */
+			if (msg_done.test_done.have_log) {
+				char *src;
+				size_t slen;
+
+				src =3D env.log_buf;
+				slen =3D env.log_cnt;
+				while (slen) {
+					struct msg msg_log;
+					char *dest;
+					size_t len;
+
+					memset(&msg_log, 0, sizeof(msg_log));
+					msg_log.type =3D MSG_TEST_LOG;
+					dest =3D msg_log.test_log.log_buf;
+					len =3D slen >=3D MAX_LOG_TRUNK_SIZE ? MAX_LOG_TRUNK_SIZE : slen;
+					memcpy(dest, src, len);
+
+					src +=3D len;
+					slen -=3D len;
+					if (!slen)
+						msg_log.test_log.is_last =3D true;
+
+					assert(send_message(sock, &msg_log) >=3D 0);
+				}
+			}
+			if (env.log_buf) {
+				free(env.log_buf);
+				env.log_buf =3D NULL;
+				env.log_cnt =3D 0;
+			}
+			if (env.debug)
+				fprintf(stderr, "[%d]: #%d:%s done.\n",
+					env.worker_id,
+					test_to_run + 1,
+					test->test_name);
+			break;
+		} /* case MSG_DO_TEST */
+		default:
+			if (env.debug)
+				fprintf(stderr, "[%d]: unknown message.\n",  env.worker_id);
+			return -1;
+		}
+	}
+out:
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	static const struct argp argp =3D {
@@ -809,7 +1279,7 @@ int main(int argc, char **argv)
 	struct sigaction sigact =3D {
 		.sa_handler =3D crash_handler,
 		.sa_flags =3D SA_RESETHAND,
-	};
+		};
 	int err, i;
=20
 	sigaction(SIGSEGV, &sigact, NULL);
@@ -837,21 +1307,77 @@ int main(int argc, char **argv)
 		return -1;
 	}
=20
-	save_netns();
-	stdio_hijack();
+	env.stdout =3D stdout;
+	env.stderr =3D stderr;
+
 	env.has_testmod =3D true;
 	if (!env.list_test_names && load_bpf_testmod()) {
 		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will=
 be skipped.\n");
 		env.has_testmod =3D false;
 	}
+
+	/* initializing tests */
 	for (i =3D 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test =3D &prog_test_defs[i];
=20
-		env.test =3D test;
 		test->test_num =3D i + 1;
-
-		if (!should_run(&env.test_selector,
+		if (should_run(&env.test_selector,
 				test->test_num, test->test_name))
+			test->should_run =3D true;
+		else
+			test->should_run =3D false;
+	}
+
+	/* ignore workers if we are just listing */
+	if (env.get_test_cnt || env.list_test_names)
+		env.workers =3D 0;
+
+	/* launch workers if requested */
+	env.worker_id =3D -1; /* main process */
+	if (env.workers) {
+		env.worker_pids =3D calloc(sizeof(__pid_t), env.workers);
+		env.worker_socks =3D calloc(sizeof(int), env.workers);
+		if (env.debug)
+			fprintf(stdout, "Launching %d workers.\n", env.workers);
+		for (int i =3D 0; i < env.workers; i++) {
+			int sv[2];
+			pid_t pid;
+
+			if (socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv) < 0) {
+				perror("Fail to create worker socket");
+				return -1;
+			}
+			pid =3D fork();
+			if (pid < 0) {
+				perror("Failed to fork worker");
+				return -1;
+			} else if (pid !=3D 0) { /* main process */
+				close(sv[1]);
+				env.worker_pids[i] =3D pid;
+				env.worker_socks[i] =3D sv[0];
+			} else { /* inside each worker process */
+				close(sv[0]);
+				env.worker_id =3D i;
+				return worker_main(sv[1]);
+			}
+		}
+
+		if (env.worker_id =3D=3D -1) {
+			server_main();
+			goto out;
+		}
+	}
+
+	/* The rest of the main process */
+
+	/* on single mode */
+	save_netns();
+
+	for (i =3D 0; i < prog_test_cnt; i++) {
+		struct prog_test_def *test =3D &prog_test_defs[i];
+		struct test_result *result;
+
+		if (!test->should_run)
 			continue;
=20
 		if (env.get_test_cnt) {
@@ -865,33 +1391,35 @@ int main(int argc, char **argv)
 			continue;
 		}
=20
-		test->run_test();
-		/* ensure last sub-test is finalized properly */
-		if (test->subtest_name)
-			test__end_subtest();
+		stdio_hijack();
=20
-		test->tested =3D true;
+		run_one_test(i);
=20
-		dump_test_log(test, test->error_cnt);
+		stdio_restore();
=20
 		fprintf(env.stdout, "#%d %s:%s\n",
 			test->test_num, test->test_name,
 			test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
=20
+		result =3D &test_results[i];
+		result->error_cnt =3D test->error_cnt;
+		if (env.log_buf) {
+			result->log_buf =3D strdup(env.log_buf);
+			result->log_cnt =3D env.log_cnt;
+
+			free(env.log_buf);
+			env.log_buf =3D NULL;
+			env.log_cnt =3D 0;
+		}
+
 		if (test->error_cnt)
 			env.fail_cnt++;
 		else
 			env.succ_cnt++;
-		skip_account();
=20
-		reset_affinity();
-		restore_netns();
-		if (test->need_cgroup_cleanup)
-			cleanup_cgroup_environment();
+		skip_account();
+		env.sub_succ_cnt +=3D test->sub_succ_cnt;
 	}
-	if (!env.list_test_names && env.has_testmod)
-		unload_bpf_testmod();
-	stdio_restore();
=20
 	if (env.get_test_cnt) {
 		printf("%d\n", env.succ_cnt);
@@ -904,14 +1432,18 @@ int main(int argc, char **argv)
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
=20
+	print_all_error_logs();
+
+	close(env.saved_netns_fd);
 out:
+	if (!env.list_test_names && env.has_testmod)
+		unload_bpf_testmod();
 	free_str_set(&env.test_selector.blacklist);
 	free_str_set(&env.test_selector.whitelist);
 	free(env.test_selector.num_set);
 	free_str_set(&env.subtest_selector.blacklist);
 	free_str_set(&env.subtest_selector.whitelist);
 	free(env.subtest_selector.num_set);
-	close(env.saved_netns_fd);
=20
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt =3D=3D 0)
 		return EXIT_NO_TEST;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 94bef0aa74cf..b239dc9fcef0 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -62,6 +62,7 @@ struct test_env {
 	struct test_selector test_selector;
 	struct test_selector subtest_selector;
 	bool verifier_stats;
+	bool debug;
 	enum verbosity verbosity;
=20
 	bool jit_enabled;
@@ -69,7 +70,8 @@ struct test_env {
 	bool get_test_cnt;
 	bool list_test_names;
=20
-	struct prog_test_def *test;
+	struct prog_test_def *test; /* current running tests */
+
 	FILE *stdout;
 	FILE *stderr;
 	char *log_buf;
@@ -82,6 +84,38 @@ struct test_env {
 	int skip_cnt; /* skipped tests */
=20
 	int saved_netns_fd;
+	int workers; /* number of worker process */
+	int worker_id; /* id number of current worker, main process is -1 */
+	pid_t *worker_pids; /* array of worker pids */
+	int *worker_socks; /* array of worker socks */
+	int *worker_current_test; /* array of current running test for each wor=
ker */
+};
+
+#define MAX_LOG_TRUNK_SIZE 8192
+enum msg_type {
+	MSG_DO_TEST =3D 0,
+	MSG_TEST_DONE =3D 1,
+	MSG_TEST_LOG =3D 2,
+	MSG_EXIT =3D 255,
+};
+struct msg {
+	enum msg_type type;
+	union {
+		struct {
+			int test_num;
+		} do_test;
+		struct {
+			int test_num;
+			int sub_succ_cnt;
+			int error_cnt;
+			int skip_cnt;
+			bool have_log;
+		} test_done;
+		struct {
+			char log_buf[MAX_LOG_TRUNK_SIZE + 1];
+			bool is_last;
+		} test_log;
+	};
 };
=20
 extern struct test_env env;
--=20
2.30.2

