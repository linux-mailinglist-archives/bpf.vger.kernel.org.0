Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552F6405D63
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhIIThA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 15:37:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233984AbhIIThA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 15:37:00 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 189JUxnO018083
        for <bpf@vger.kernel.org>; Thu, 9 Sep 2021 12:35:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=TWDHySUv9LNwoEsIO3SHzIFWcmTIfDexxI0HYz+MeHs=;
 b=omvFa0B7hGek4Vg1b9NGmDQANDr3dkoXKxM6dXUFHDBlqfqgpxciabmppdUni27lKaDL
 hrT9mrlx4AIUolyQmwuZ6sJ8l4Y9cngaXYS9oWaPr274915ry0L/fDAOiftklRDQnb6J
 n7XEveHeEmr66XIjCzmKD03QvBgruywyRO0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aydp6mktu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 12:35:50 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 9 Sep 2021 12:35:49 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id BE1F033FB9B8; Thu,  9 Sep 2021 12:35:45 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, Yucong Sun <sunyucong@gmail.com>
Subject: [PATCH v3 bpf-next] selftests/bpf: Add parallelism to test_progs
Date:   Thu, 9 Sep 2021 12:35:44 -0700
Message-ID: <20210909193544.1829238-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: y9M5290olTETUsKwdSRl9ZaEq1EjHXdQ
X-Proofpoint-GUID: y9M5290olTETUsKwdSRl9ZaEq1EjHXdQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-09_07:2021-09-09,2021-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yucong Sun <sunyucong@gmail.com>

This patch adds "-j" mode to test_progs, executing tests in multiple proc=
ess.
"-j" mode is optional, and works with all existing test selection mechani=
sm, as
well as "-v", "-l" etc.

In "-j" mode, main process use UDS/DGRAM to communicate to each forked wo=
rker,
commanding it to run tests and collect logs. After all tests are finished=
, a
summary is printed. main process use multiple competing threads to dispat=
ch
work to worker, trying to keep them all busy.

Example output:

  > ./test_progs -n 15-20 -j
  [    8.584709] bpf_testmod: loading out-of-tree module taints kernel.
  Launching 2 workers.
  [0]: Running test 15.
  [1]: Running test 16.
  [1]: Running test 17.
  [1]: Running test 18.
  [1]: Running test 19.
  [1]: Running test 20.
  [1]: worker exit.
  [0]: worker exit.
  #15 btf_dump:OK
  #16 btf_endian:OK
  #17 btf_map_in_map:OK
  #18 btf_module:OK
  #19 btf_skc_cls_ingress:OK
  #20 btf_split:OK
  Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED

Know issue:

Some tests fail when running concurrently, later patch will either
fix the test or pin them to worker 0.

Signed-off-by: Yucong Sun <sunyucong@gmail.com>

V3 -> V2: fix missing outputs in commit messages.
V2 -> V1: switch to UDS client/server model.
---
 tools/testing/selftests/bpf/test_progs.c | 456 ++++++++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.h |  36 +-
 2 files changed, 478 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index cc1cd240445d..8204dd9aa657 100644
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
@@ -48,6 +53,7 @@ struct prog_test_def {
 	bool force_log;
 	int error_cnt;
 	int skip_cnt;
+	int sub_succ_cnt;
 	bool tested;
 	bool need_cgroup_cleanup;
=20
@@ -97,6 +103,10 @@ static void dump_test_log(const struct prog_test_def =
*test, bool failed)
 	if (stdout =3D=3D env.stdout)
 		return;
=20
+	/* worker always holds log */
+	if (env.worker_index !=3D -1)
+		return;
+
 	fflush(stdout); /* exports env.log_buf & env.log_cnt */
=20
 	if (env.verbosity > VERBOSE_NONE || test->force_log || failed) {
@@ -172,14 +182,14 @@ void test__end_subtest()
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
@@ -474,6 +484,7 @@ enum ARG_KEYS {
 	ARG_LIST_TEST_NAMES =3D 'l',
 	ARG_TEST_NAME_GLOB_ALLOWLIST =3D 'a',
 	ARG_TEST_NAME_GLOB_DENYLIST =3D 'd',
+	ARG_NUM_WORKERS =3D 'j',
 };
=20
 static const struct argp_option opts[] =3D {
@@ -495,6 +506,8 @@ static const struct argp_option opts[] =3D {
 	  "Run tests with name matching the pattern (supports '*' wildcard)." }=
,
 	{ "deny", ARG_TEST_NAME_GLOB_DENYLIST, "NAMES", 0,
 	  "Don't run tests with name matching the pattern (supports '*' wildcar=
d)." },
+	{ "workers", ARG_NUM_WORKERS, "WORKERS", OPTION_ARG_OPTIONAL,
+	  "Number of workers to run in parallel, default to number of cpus." },
 	{},
 };
=20
@@ -661,6 +674,17 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
 	case ARG_LIST_TEST_NAMES:
 		env->list_test_names =3D true;
 		break;
+	case ARG_NUM_WORKERS:
+		if (arg) {
+			env->workers =3D atoi(arg);
+			if (!env->workers) {
+				fprintf(stderr, "Invalid number of worker: %s.", arg);
+				return -1;
+			}
+		} else {
+			env->workers =3D get_nprocs();
+		}
+		break;
 	case ARGP_KEY_ARG:
 		argp_usage(state);
 		break;
@@ -678,7 +702,7 @@ static void stdio_hijack(void)
 	env.stdout =3D stdout;
 	env.stderr =3D stderr;
=20
-	if (env.verbosity > VERBOSE_NONE) {
+	if (env.verbosity > VERBOSE_NONE && env.worker_index =3D=3D -1) {
 		/* nothing to do, output to stdout by default */
 		return;
 	}
@@ -704,10 +728,6 @@ static void stdio_restore(void)
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
@@ -760,6 +780,364 @@ void crash_handler(int signum)
 	backtrace_symbols_fd(bt, sz, STDERR_FILENO);
 }
=20
+int current_test_idx =3D -1;
+pthread_mutex_t current_test_lock;
+
+struct test_result {
+	int error_cnt;
+	int skip_cnt;
+	int sub_succ_cnt;
+
+	size_t log_cnt;
+	char *log_buf;
+};
+struct test_result test_results[ARRAY_SIZE(prog_test_defs)];
+
+
+static inline const char *str_msg(const struct message *msg)
+{
+	static char buf[255];
+
+	switch (msg->type) {
+	case MSG_DO_TEST:
+		sprintf(buf, "MSG_DO_TEST %d", msg->u.message_do_test.num);
+		break;
+	case MSG_TEST_DONE:
+		sprintf(buf, "MSG_TEST_DONE %d (log: %d)",
+			       msg->u.message_test_done.num,
+			       msg->u.message_test_done.have_log);
+		break;
+	case MSG_TEST_LOG:
+		sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
+			strlen(msg->u.message_test_log.log_buf),
+			msg->u.message_test_log.is_last);
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
+int send_message(int sock, const struct message *msg)
+{
+	if (env.verbosity > VERBOSE_NONE)
+		fprintf(stderr, "Sending msg: %s\n", str_msg(msg));
+	return send(sock, msg, sizeof(*msg), 0);
+}
+
+int recv_message(int sock, struct message *msg)
+{
+	int ret;
+
+	memset(msg, 0, sizeof(*msg));
+	ret =3D recv(sock, msg, sizeof(*msg), 0);
+	if (ret >=3D 0) {
+		if (env.verbosity > VERBOSE_NONE)
+			fprintf(stderr, "Received msg: %s\n", str_msg(msg));
+	}
+	return ret;
+}
+
+struct dispatch_data {
+	int idx;
+	int sock;
+};
+
+void* dispatch_thread(void *_data)
+{
+	struct dispatch_data *data;
+	int sock;
+	FILE *log_fd =3D NULL;
+
+	data =3D (struct dispatch_data *)_data;
+	sock =3D data->sock;
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
+			test_to_run =3D current_test_idx;
+			current_test_idx++;
+
+			pthread_mutex_unlock(&current_test_lock);
+		}
+
+		test =3D &prog_test_defs[test_to_run];
+		test->test_num =3D test_to_run + 1;
+
+		if (!should_run(&env.test_selector,
+				test->test_num, test->test_name))
+			continue;
+
+		/* run test through worker */
+		{
+			struct message msg_do_test;
+
+			msg_do_test.type =3D MSG_DO_TEST;
+			msg_do_test.u.message_do_test.num =3D test_to_run;
+			if (send_message(sock, &msg_do_test) < 0) {
+				perror("Fail to send command");
+				goto done;
+			}
+			env.worker_current_test[data->idx] =3D test_to_run;
+		}
+
+		/* wait for test done */
+		{
+			struct message msg_test_done;
+
+			if (recv_message(sock, &msg_test_done) < 0)
+				goto error;
+			if (msg_test_done.type !=3D MSG_TEST_DONE)
+				goto error;
+			if (test_to_run !=3D msg_test_done.u.message_test_done.num)
+				goto error;
+
+			result =3D &test_results[test_to_run];
+
+			test->tested =3D true;
+
+			result->error_cnt =3D msg_test_done.u.message_test_done.error_cnt;
+			result->skip_cnt =3D msg_test_done.u.message_test_done.skip_cnt;
+			result->sub_succ_cnt =3D msg_test_done.u.message_test_done.sub_succ_c=
nt;
+
+			/* collect all logs */
+			if (msg_test_done.u.message_test_done.have_log) {
+				log_fd =3D open_memstream(&result->log_buf, &result->log_cnt);
+				if (!log_fd)
+					goto error;
+
+				while (true) {
+					struct message msg_log;
+
+					if (recv_message(sock, &msg_log) < 0)
+						goto error;
+					if (msg_log.type !=3D MSG_TEST_LOG)
+						goto error;
+
+					fprintf(log_fd, "%s", msg_log.u.message_test_log.log_buf);
+					if (msg_log.u.message_test_log.is_last)
+						break;
+				}
+				fclose(log_fd);
+				log_fd =3D NULL;
+			}
+		}
+	} /* while (true) */
+error:
+	fprintf(stderr, "[%d]: Protocol/IO error: %s", data->idx, strerror(errn=
o));
+
+	if (log_fd)
+		fclose(log_fd);
+done:
+	{
+		struct message msg_exit;
+
+		msg_exit.type =3D MSG_EXIT;
+		if (send_message(sock, &msg_exit) < 0)
+			fprintf(stderr, "[%d]: send_message msg_exit: %s", data->idx, strerro=
r(errno));
+	}
+	return NULL;
+}
+
+int server_main(void)
+{
+	pthread_t *dispatcher_threads;
+	struct dispatch_data *data;
+
+	dispatcher_threads =3D calloc(sizeof(pthread_t), env.workers);
+	data =3D calloc(sizeof(struct dispatch_data), env.workers);
+
+	env.worker_current_test =3D calloc(sizeof(int), env.workers);
+	for (int i =3D 0; i < env.workers; i++) {
+		int rc;
+
+		data[i].idx =3D i;
+		data[i].sock =3D env.worker_socks[i];
+		rc =3D pthread_create(&dispatcher_threads[i], NULL, dispatch_thread, &=
data[i]);
+		if (rc < 0) {
+			perror("Failed to launch dispatcher thread");
+			return -1;
+		}
+	}
+
+	/* wait for all dispatcher to finish */
+	for (int i =3D 0; i < env.workers; i++) {
+		while (true) {
+			struct timespec timeout =3D {
+				.tv_sec =3D time(NULL) + 5,
+				.tv_nsec =3D 0
+			};
+			if (pthread_timedjoin_np(dispatcher_threads[i], NULL, &timeout) !=3D =
ETIMEDOUT)
+				break;
+			fprintf(stderr, "Still waiting for thread %d (test %d).\n", i,  env.w=
orker_current_test[i] + 1);
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
+		env.fail_cnt +=3D result->error_cnt;
+		env.sub_succ_cnt +=3D result->sub_succ_cnt;
+
+		if (result->log_cnt) {
+			result->log_buf[result->log_cnt] =3D '\0';
+			fprintf(stdout, "%s", result->log_buf);
+			if (result->log_buf[result->log_cnt - 1] !=3D '\n')
+				fprintf(stdout, "\n");
+		}
+		fprintf(stdout, "#%d %s:%s\n",
+			current_test->test_num, current_test->test_name,
+			result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
+	}
+
+	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
+		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
+
+	/* reap all workers */
+	for (int i =3D 0; i < env.workers; i++) {
+		int wstatus, pid;
+
+		pid =3D waitpid(env.worker_pids[i], &wstatus, 0);
+		assert(pid =3D=3D env.worker_pids[i]);
+	}
+
+	return 0;
+}
+
+int worker_main(int sock)
+{
+	save_netns();
+
+	while (true) {
+		/* receive command */
+		struct message msg;
+
+		assert(recv_message(sock, &msg) >=3D 0);
+
+		switch (msg.type) {
+		case MSG_EXIT:
+			fprintf(stderr, "[%d]: worker exit.\n",  env.worker_index);
+			goto out;
+		case MSG_DO_TEST: {
+			int test_to_run =3D msg.u.message_do_test.num;
+
+			fprintf(stderr, "[%d]: Running test %d.\n",
+				env.worker_index, test_to_run + 1);
+
+			struct prog_test_def *test =3D
+				&prog_test_defs[test_to_run];
+
+			env.test =3D test;
+			test->test_num =3D test_to_run + 1;
+
+			stdio_hijack();
+
+			test->run_test();
+
+			/* ensure last sub-test is finalized properly */
+			if (test->subtest_name)
+				test__end_subtest();
+
+			stdio_restore();
+
+			test->tested =3D true;
+
+			skip_account();
+
+			reset_affinity();
+			restore_netns();
+			if (test->need_cgroup_cleanup)
+				cleanup_cgroup_environment();
+
+			struct message msg_done;
+
+			msg_done.type =3D MSG_TEST_DONE;
+			msg_done.u.message_test_done.num =3D test_to_run;
+			msg_done.u.message_test_done.error_cnt =3D test->error_cnt;
+			msg_done.u.message_test_done.skip_cnt =3D test->skip_cnt;
+			msg_done.u.message_test_done.sub_succ_cnt =3D test->sub_succ_cnt;
+			msg_done.u.message_test_done.have_log =3D false;
+
+			if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cn=
t) {
+				if (env.log_cnt)
+					msg_done.u.message_test_done.have_log =3D true;
+			}
+			assert(send_message(sock, &msg_done) >=3D 0);
+
+			/* send logs */
+			if (msg_done.u.message_test_done.have_log) {
+				char *src;
+				size_t slen;
+
+				src =3D env.log_buf;
+				slen =3D env.log_cnt;
+				while (slen) {
+					struct message msg_log;
+					char *dest;
+					size_t len;
+
+					memset(&msg_log, 0, sizeof(msg_log));
+					msg_log.type =3D MSG_TEST_LOG;
+					dest =3D msg_log.u.message_test_log.log_buf;
+					len =3D slen >=3D MAX_LOG_TRUNK_SIZE ? MAX_LOG_TRUNK_SIZE : slen;
+					memcpy(dest, src, len);
+
+					src +=3D len;
+					slen -=3D len;
+					if (!slen)
+						msg_log.u.message_test_log.is_last =3D true;
+
+					assert(send_message(sock, &msg_log) >=3D 0);
+				}
+			}
+			if (env.log_buf) {
+				free(env.log_buf);
+				env.log_buf =3D NULL;
+				env.log_cnt =3D 0;
+			}
+			break;
+		} /* case MSG_DO_TEST */
+		default:
+			fprintf(stderr, "[%d]: unknown message.\n",  env.worker_index);
+			return -1;
+		}
+	}
+out:
+	restore_netns();
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	static const struct argp argp =3D {
@@ -798,13 +1176,57 @@ int main(int argc, char **argv)
 		return -1;
 	}
=20
-	save_netns();
-	stdio_hijack();
 	env.has_testmod =3D true;
 	if (!env.list_test_names && load_bpf_testmod()) {
 		fprintf(env.stderr, "WARNING! Selftests relying on bpf_testmod.ko will=
 be skipped.\n");
 		env.has_testmod =3D false;
 	}
+
+	/* ignore workers if we are just listing */
+	if (env.get_test_cnt || env.list_test_names)
+		env.workers =3D 0;
+
+	/* launch workers if requested */
+	env.worker_index =3D -1; /* main process */
+	if (env.workers) {
+		env.worker_pids =3D calloc(sizeof(__pid_t), env.workers);
+		env.worker_socks =3D calloc(sizeof(int), env.workers);
+		fprintf(stdout, "Launching %d workers.\n", env.workers);
+		for (int i =3D 0; i < env.workers; i++) {
+			int sv[2];
+			__pid_t pid;
+
+			if (socketpair(AF_UNIX, SOCK_DGRAM, 0, sv) < 0) {
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
+				env.worker_index =3D i;
+				return worker_main(sv[1]);
+			}
+		}
+
+		if (env.worker_index =3D=3D -1) {
+			server_main();
+			goto out;
+		}
+	}
+
+	/* The rest of the main process */
+
+	/* on single mode */
+	save_netns();
+	stdio_hijack();
+
 	for (i =3D 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test =3D &prog_test_defs[i];
=20
@@ -827,6 +1249,7 @@ int main(int argc, char **argv)
 		}
=20
 		test->run_test();
+
 		/* ensure last sub-test is finalized properly */
 		if (test->subtest_name)
 			test__end_subtest();
@@ -843,16 +1266,21 @@ int main(int argc, char **argv)
 			env.fail_cnt++;
 		else
 			env.succ_cnt++;
+
 		skip_account();
+		env.sub_succ_cnt +=3D test->sub_succ_cnt;
=20
 		reset_affinity();
 		restore_netns();
 		if (test->need_cgroup_cleanup)
 			cleanup_cgroup_environment();
 	}
-	if (!env.list_test_names && env.has_testmod)
-		unload_bpf_testmod();
 	stdio_restore();
+	if (env.log_buf) {
+		free(env.log_buf);
+		env.log_buf =3D NULL;
+		env.log_cnt =3D 0;
+	}
=20
 	if (env.get_test_cnt) {
 		printf("%d\n", env.succ_cnt);
@@ -865,14 +1293,16 @@ int main(int argc, char **argv)
 	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
 		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
=20
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
index c8c2bf878f67..085e3580ec08 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -69,7 +69,8 @@ struct test_env {
 	bool get_test_cnt;
 	bool list_test_names;
=20
-	struct prog_test_def *test;
+	struct prog_test_def *test; /* current running tests */
+
 	FILE *stdout;
 	FILE *stderr;
 	char *log_buf;
@@ -82,6 +83,39 @@ struct test_env {
 	int skip_cnt; /* skipped tests */
=20
 	int saved_netns_fd;
+	int workers; /* number of worker process */
+	int worker_index; /* index number of current worker, main process is -1=
 */
+	__pid_t *worker_pids; /* array of worker pids */
+	int *worker_socks; /* array of worker socks */
+	int *worker_current_test; /* array of current running test for each wor=
ker */
+};
+
+#define MAX_LOG_TRUNK_SIZE 8192
+enum message_type {
+	MSG_DO_TEST =3D 0,
+	MSG_TEST_DONE =3D 1,
+	MSG_TEST_LOG =3D 2,
+	MSG_EXIT =3D 255,
+};
+struct message {
+	enum message_type type;
+	union {
+		struct {
+			int num;
+		} message_do_test;
+		struct {
+			int num;
+
+			int sub_succ_cnt;
+			int error_cnt;
+			int skip_cnt;
+			bool have_log;
+		} message_test_done;
+		struct {
+			char log_buf[MAX_LOG_TRUNK_SIZE + 1];
+			bool is_last;
+		} message_test_log;
+	} u;
 };
=20
 extern struct test_env env;
--=20
2.30.2

