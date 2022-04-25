Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8900350D888
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 06:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbiDYFAO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiDYFAO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 01:00:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9771A6D953
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 21:57:08 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23OMexgn010967
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 21:57:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=faDM0Cx012X2CZ4fvoz/GqwqQFXb5fobDlhS9XyNU1I=;
 b=SkTJHV4/pFq31iTPhyTyiRonYBK7jimErnteJnHkRxVxVqqDtV4/pl6FBniQINGUSMKD
 MFUhTNJWwu3fc2YHzDJng+TAN8jPWMwkfJMlbK3NKrzGEPDnRB/bE7oISPkfHa5gLdjX
 RAxpzE8YbF9Tzd4cLWeY88jQ6pgDPd0TLUA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmf9pqffa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 24 Apr 2022 21:57:07 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub202.TheFacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 21:57:06 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Apr 2022 21:57:06 -0700
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 8F9D162D2365; Sun, 24 Apr 2022 21:57:01 -0700 (PDT)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] bpf/selftests: add granular subtest output for prog_test
Date:   Sun, 24 Apr 2022 21:56:42 -0700
Message-ID: <20220425045642.3978269-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: s0aZiA9jsXhgVcrHdJM5V9gJlA7OdbCW
X-Proofpoint-GUID: s0aZiA9jsXhgVcrHdJM5V9gJlA7OdbCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_01,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement per subtest log collection for both parallel
and sequential test execution. This allows granular
per-subtest error output in the 'All error logs' section.
Add subtest log transfer into the protocol during the
parallel test execution.

Move all test log printing logic into dump_test_log
function. One exception is the output of test names when
verbose printing is enabled. Move test name/result
printing into separate functions to avoid repetition.

Print all successful subtest results in the log. Print
only failed test logs when test does not have subtests.
Or only failed subtests' logs when test has subtests.

Disable 'All error logs' output when verbose mode is
enabled. This functionality was already broken and is
causing confusion.

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 639 +++++++++++++++++------
 tools/testing/selftests/bpf/test_progs.h |  35 +-
 2 files changed, 498 insertions(+), 176 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index c536d1d29d57..375e10576336 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -18,6 +18,90 @@
 #include <sys/socket.h>
 #include <sys/un.h>
=20
+static bool verbose(void)
+{
+	return env.verbosity > VERBOSE_NONE;
+}
+
+static void stdio_hijack_init(char **log_buf, size_t *log_cnt)
+{
+#ifdef __GLIBC__
+	if (verbose() && env.worker_id =3D=3D -1) {
+		/* nothing to do, output to stdout by default */
+		return;
+	}
+
+	fflush(stdout);
+	fflush(stderr);
+
+	stdout =3D open_memstream(log_buf, log_cnt);
+	if (!stdout) {
+		stdout =3D env.stdout;
+		perror("open_memstream");
+		return;
+	}
+
+	if (env.subtest_state)
+		env.subtest_state->stdout =3D stdout;
+	else
+		env.test_state->stdout =3D stdout;
+
+	stderr =3D stdout;
+#endif
+}
+
+static void stdio_hijack(char **log_buf, size_t *log_cnt)
+{
+#ifdef __GLIBC__
+	if (verbose() && env.worker_id =3D=3D -1) {
+		/* nothing to do, output to stdout by default */
+		return;
+	}
+
+	env.stdout =3D stdout;
+	env.stderr =3D stderr;
+
+	stdio_hijack_init(log_buf, log_cnt);
+#endif
+}
+
+static void stdio_restore_cleanup(void)
+{
+#ifdef __GLIBC__
+	if (verbose() && env.worker_id =3D=3D -1) {
+		/* nothing to do, output to stdout by default */
+		return;
+	}
+
+	fflush(stdout);
+
+	if (env.subtest_state) {
+		fclose(env.subtest_state->stdout);
+		stdout =3D env.test_state->stdout;
+	} else {
+		fclose(env.test_state->stdout);
+	}
+#endif
+}
+
+static void stdio_restore(void)
+{
+#ifdef __GLIBC__
+	if (verbose() && env.worker_id =3D=3D -1) {
+		/* nothing to do, output to stdout by default */
+		return;
+	}
+
+	if (stdout =3D=3D env.stdout)
+		return;
+
+	stdio_restore_cleanup();
+
+	stdout =3D env.stdout;
+	stderr =3D env.stderr;
+#endif
+}
+
 /* Adapted from perf/util/string.c */
 static bool glob_match(const char *str, const char *pat)
 {
@@ -130,30 +214,96 @@ static bool should_run_subtest(struct test_selector=
 *sel,
 	return subtest_num < subtest_sel->num_set_len && subtest_sel->num_set[s=
ubtest_num];
 }
=20
+static char *test_result(bool failed, bool skipped)
+{
+	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
+}
+
+static void print_test_log(char *log_buf, size_t log_cnt)
+{
+	log_buf[log_cnt] =3D '\0';
+	fprintf(env.stdout, "%s", log_buf);
+	if (log_buf[log_cnt - 1] !=3D '\n')
+		fprintf(env.stdout, "\n");
+}
+
+static void print_test_name(int test_num, const char *test_name, char *r=
esult)
+{
+	fprintf(env.stdout, "#%-9d %s", test_num, test_name);
+
+	if (result)
+		fprintf(env.stdout, ":%s", result);
+
+	fprintf(env.stdout, "\n");
+}
+
+static void print_subtest_name(int test_num, int subtest_num,
+			       const char *test_name, char *subtest_name,
+			       char *result)
+{
+	fprintf(env.stdout, "#%-3d/%-5d %s/%s",
+		test_num, subtest_num,
+		test_name, subtest_name);
+
+	if (result)
+		fprintf(env.stdout, ":%s", result);
+
+	fprintf(env.stdout, "\n");
+}
+
 static void dump_test_log(const struct prog_test_def *test,
 			  const struct test_state *test_state,
-			  bool force_failed)
+			  bool skip_ok_subtests,
+			  bool par_exec_result)
 {
-	bool failed =3D test_state->error_cnt > 0 || force_failed;
+	bool test_failed =3D test_state->error_cnt > 0;
+	bool force_log =3D test_state->force_log;
+	bool print_test =3D verbose() || force_log || test_failed;
+	int i;
+	struct subtest_state *subtest_state;
+	bool subtest_failed;
+	bool print_subtest;
=20
-	/* worker always holds log */
+	/* we do not print anything in the worker thread */
 	if (env.worker_id !=3D -1)
 		return;
=20
-	fflush(stdout); /* exports test_state->log_buf & test_state->log_cnt */
+	/* there is nothing to print when verbose log is used and execution
+	 * is not in parallel mode
+	 */
+	if (verbose() && !par_exec_result)
+		return;
+
+	if (test_state->subtest_num || print_test)
+		print_test_name(test->test_num, test->test_name, NULL);
+
+	if (test_state->log_cnt && print_test)
+		print_test_log(test_state->log_buf, test_state->log_cnt);
=20
-	fprintf(env.stdout, "#%-3d %s:%s\n",
-		test->test_num, test->test_name,
-		failed ? "FAIL" : (test_state->skip_cnt ? "SKIP" : "OK"));
+	for (i =3D 0; i < test_state->subtest_num; i++) {
+		subtest_state =3D &test_state->subtest_states[i];
+		subtest_failed =3D subtest_state->error_cnt;
+		print_subtest =3D verbose() || force_log || subtest_failed;
=20
-	if (env.verbosity > VERBOSE_NONE || test_state->force_log || failed) {
-		if (test_state->log_cnt) {
-			test_state->log_buf[test_state->log_cnt] =3D '\0';
-			fprintf(env.stdout, "%s", test_state->log_buf);
-			if (test_state->log_buf[test_state->log_cnt - 1] !=3D '\n')
-				fprintf(env.stdout, "\n");
+		if (skip_ok_subtests && !subtest_failed)
+			continue;
+
+		if (subtest_state->log_cnt && print_subtest) {
+			print_subtest_name(test->test_num, i + 1,
+					   test->test_name, subtest_state->name,
+					   NULL);
+			print_test_log(subtest_state->log_buf,
+				       subtest_state->log_cnt);
 		}
+
+		print_subtest_name(test->test_num, i + 1,
+				   test->test_name, subtest_state->name,
+				   test_result(subtest_state->error_cnt,
+					       subtest_state->skipped));
 	}
+
+	print_test_name(test->test_num, test->test_name,
+			test_result(test_failed, test_state->skip_cnt));
 }
=20
 static void stdio_restore(void);
@@ -205,35 +355,50 @@ static void restore_netns(void)
 void test__end_subtest(void)
 {
 	struct prog_test_def *test =3D env.test;
-	struct test_state *state =3D env.test_state;
-	int sub_error_cnt =3D state->error_cnt - state->old_error_cnt;
-
-	fprintf(stdout, "#%d/%d %s/%s:%s\n",
-	       test->test_num, state->subtest_num, test->test_name, state->subt=
est_name,
-	       sub_error_cnt ? "FAIL" : (state->subtest_skip_cnt ? "SKIP" : "OK=
"));
-
-	if (sub_error_cnt =3D=3D 0) {
-		if (state->subtest_skip_cnt =3D=3D 0) {
-			state->sub_succ_cnt++;
-		} else {
-			state->subtest_skip_cnt =3D 0;
-			state->skip_cnt++;
-		}
+	struct test_state *test_state =3D env.test_state;
+	struct subtest_state *subtest_state =3D env.subtest_state;
+
+	if (subtest_state->error_cnt) {
+		test_state->error_cnt++;
+	} else {
+		if (!subtest_state->skipped)
+			test_state->sub_succ_cnt++;
+		else
+			test_state->skip_cnt++;
 	}
=20
-	free(state->subtest_name);
-	state->subtest_name =3D NULL;
+	if (verbose() && !env.workers)
+		print_subtest_name(test->test_num, test_state->subtest_num,
+				   test->test_name, subtest_state->name,
+				   test_result(subtest_state->error_cnt,
+					       subtest_state->skipped));
+
+	stdio_restore_cleanup();
+	env.subtest_state =3D NULL;
 }
=20
 bool test__start_subtest(const char *subtest_name)
 {
 	struct prog_test_def *test =3D env.test;
 	struct test_state *state =3D env.test_state;
+	struct subtest_state *subtest_state;
+	size_t sub_state_size =3D sizeof(*subtest_state);
=20
-	if (state->subtest_name)
+	if (env.subtest_state)
 		test__end_subtest();
=20
 	state->subtest_num++;
+	state->subtest_states =3D
+		realloc(state->subtest_states,
+			state->subtest_num * sub_state_size);
+	if (!state->subtest_states) {
+		fprintf(stderr, "Not enough memory to allocate subtest result\n");
+		return false;
+	}
+
+	subtest_state =3D &state->subtest_states[state->subtest_num - 1];
+
+	memset(subtest_state, 0, sub_state_size);
=20
 	if (!subtest_name || !subtest_name[0]) {
 		fprintf(env.stderr,
@@ -242,21 +407,30 @@ bool test__start_subtest(const char *subtest_name)
 		return false;
 	}
=20
+	subtest_state->name =3D strdup(subtest_name);
+	if (!subtest_state->name) {
+		fprintf(env.stderr,
+			"Subtest #%d: failed to copy subtest name!\n",
+			state->subtest_num);
+		return false;
+	}
+
 	if (!should_run_subtest(&env.test_selector,
 				&env.subtest_selector,
 				state->subtest_num,
 				test->test_name,
-				subtest_name))
-		return false;
-
-	state->subtest_name =3D strdup(subtest_name);
-	if (!state->subtest_name) {
-		fprintf(env.stderr,
-			"Subtest #%d: failed to copy subtest name!\n",
-			state->subtest_num);
+				subtest_name)) {
+		subtest_state->skipped =3D true;
 		return false;
 	}
-	state->old_error_cnt =3D state->error_cnt;
+
+	env.subtest_state =3D subtest_state;
+	stdio_hijack_init(&subtest_state->log_buf, &subtest_state->log_cnt);
+
+	if (verbose() && !env.workers)
+		print_subtest_name(test->test_num, state->subtest_num,
+				   test->test_name, subtest_state->name,
+				   NULL);
=20
 	return true;
 }
@@ -268,15 +442,18 @@ void test__force_log(void)
=20
 void test__skip(void)
 {
-	if (env.test_state->subtest_name)
-		env.test_state->subtest_skip_cnt++;
+	if (env.subtest_state)
+		env.subtest_state->skipped =3D true;
 	else
 		env.test_state->skip_cnt++;
 }
=20
 void test__fail(void)
 {
-	env.test_state->error_cnt++;
+	if (env.subtest_state)
+		env.subtest_state->error_cnt++;
+	else
+		env.test_state->error_cnt++;
 }
=20
 int test__join_cgroup(const char *path)
@@ -455,14 +632,14 @@ static void unload_bpf_testmod(void)
 		fprintf(env.stderr, "Failed to trigger kernel-side RCU sync!\n");
 	if (delete_module("bpf_testmod", 0)) {
 		if (errno =3D=3D ENOENT) {
-			if (env.verbosity > VERBOSE_NONE)
+			if (verbose())
 				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
 			return;
 		}
 		fprintf(env.stderr, "Failed to unload bpf_testmod.ko from kernel: %d\n=
", -errno);
 		return;
 	}
-	if (env.verbosity > VERBOSE_NONE)
+	if (verbose())
 		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
 }
=20
@@ -473,7 +650,7 @@ static int load_bpf_testmod(void)
 	/* ensure previous instance of the module is unloaded */
 	unload_bpf_testmod();
=20
-	if (env.verbosity > VERBOSE_NONE)
+	if (verbose())
 		fprintf(stdout, "Loading bpf_testmod.ko...\n");
=20
 	fd =3D open("bpf_testmod.ko", O_RDONLY);
@@ -488,7 +665,7 @@ static int load_bpf_testmod(void)
 	}
 	close(fd);
=20
-	if (env.verbosity > VERBOSE_NONE)
+	if (verbose())
 		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
 	return 0;
 }
@@ -655,7 +832,7 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 			}
 		}
=20
-		if (env->verbosity > VERBOSE_NONE) {
+		if (verbose()) {
 			if (setenv("SELFTESTS_VERBOSE", "1", 1) =3D=3D -1) {
 				fprintf(stderr,
 					"Unable to setenv SELFTESTS_VERBOSE=3D1 (errno=3D%d)",
@@ -696,44 +873,6 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
 	return 0;
 }
=20
-static void stdio_hijack(char **log_buf, size_t *log_cnt)
-{
-#ifdef __GLIBC__
-	env.stdout =3D stdout;
-	env.stderr =3D stderr;
-
-	if (env.verbosity > VERBOSE_NONE && env.worker_id =3D=3D -1) {
-		/* nothing to do, output to stdout by default */
-		return;
-	}
-
-	/* stdout and stderr -> buffer */
-	fflush(stdout);
-
-	stdout =3D open_memstream(log_buf, log_cnt);
-	if (!stdout) {
-		stdout =3D env.stdout;
-		perror("open_memstream");
-		return;
-	}
-
-	stderr =3D stdout;
-#endif
-}
-
-static void stdio_restore(void)
-{
-#ifdef __GLIBC__
-	if (stdout =3D=3D env.stdout)
-		return;
-
-	fclose(stdout);
-
-	stdout =3D env.stdout;
-	stderr =3D env.stderr;
-#endif
-}
-
 /*
  * Determine if test_progs is running as a "flavored" test runner and sw=
itch
  * into corresponding sub-directory to load correct BPF objects.
@@ -759,7 +898,7 @@ int cd_flavor_subdir(const char *exec_name)
 	if (!flavor)
 		return 0;
 	flavor++;
-	if (env.verbosity > VERBOSE_NONE)
+	if (verbose())
 		fprintf(stdout,	"Switching to flavor '%s' subdirectory...\n", flavor);
=20
 	return chdir(flavor);
@@ -812,8 +951,10 @@ void crash_handler(int signum)
=20
 	sz =3D backtrace(bt, ARRAY_SIZE(bt));
=20
-	if (env.test)
-		dump_test_log(env.test, env.test_state, true);
+	if (env.test) {
+		env.test_state->error_cnt++;
+		dump_test_log(env.test, env.test_state, true, false);
+	}
 	if (env.stdout)
 		stdio_restore();
 	if (env.worker_id !=3D -1)
@@ -839,13 +980,18 @@ static inline const char *str_msg(const struct msg =
*msg, char *buf)
 {
 	switch (msg->type) {
 	case MSG_DO_TEST:
-		sprintf(buf, "MSG_DO_TEST %d", msg->do_test.test_num);
+		sprintf(buf, "MSG_DO_TEST %d", msg->do_test.num);
 		break;
 	case MSG_TEST_DONE:
 		sprintf(buf, "MSG_TEST_DONE %d (log: %d)",
-			msg->test_done.test_num,
+			msg->test_done.num,
 			msg->test_done.have_log);
 		break;
+	case MSG_SUBTEST_DONE:
+		sprintf(buf, "MSG_SUBTEST_DONE %d (log: %d)",
+			msg->subtest_done.num,
+			msg->subtest_done.have_log);
+		break;
 	case MSG_TEST_LOG:
 		sprintf(buf, "MSG_TEST_LOG (cnt: %ld, last: %d)",
 			strlen(msg->test_log.log_buf),
@@ -895,18 +1041,23 @@ static void run_one_test(int test_num)
=20
 	stdio_hijack(&state->log_buf, &state->log_cnt);
=20
+	if (verbose() && env.worker_id =3D=3D -1)
+		print_test_name(test_num + 1, test->test_name, NULL);
+
 	if (test->run_test)
 		test->run_test();
 	else if (test->run_serial_test)
 		test->run_serial_test();
=20
 	/* ensure last sub-test is finalized properly */
-	if (state->subtest_name)
+	if (env.subtest_state)
 		test__end_subtest();
=20
 	state->tested =3D true;
=20
-	dump_test_log(test, state, false);
+	if (verbose() && env.worker_id =3D=3D -1)
+		print_test_name(test_num + 1, test->test_name,
+				test_result(state->error_cnt, state->skip_cnt));
=20
 	reset_affinity();
 	restore_netns();
@@ -914,6 +1065,8 @@ static void run_one_test(int test_num)
 		cleanup_cgroup_environment();
=20
 	stdio_restore();
+
+	dump_test_log(test, state, false, false);
 }
=20
 struct dispatch_data {
@@ -921,6 +1074,73 @@ struct dispatch_data {
 	int sock_fd;
 };
=20
+static int read_prog_test_msg(int sock_fd, struct msg *msg, enum msg_typ=
e type)
+{
+	if (recv_message(sock_fd, msg) < 0)
+		return 1;
+
+	if (msg->type !=3D type) {
+		printf("%s: unexpected message type %d. expected %d\n", __func__, msg-=
>type, type);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int dispatch_thread_read_log(int sock_fd, char **log_buf, size_t =
*log_cnt)
+{
+	FILE *log_fp =3D NULL;
+
+	log_fp =3D open_memstream(log_buf, log_cnt);
+	if (!log_fp)
+		return 1;
+
+	while (true) {
+		struct msg msg;
+
+		if (read_prog_test_msg(sock_fd, &msg, MSG_TEST_LOG))
+			return 1;
+
+		fprintf(log_fp, "%s", msg.test_log.log_buf);
+		if (msg.test_log.is_last)
+			break;
+	}
+	fclose(log_fp);
+	log_fp =3D NULL;
+	return 0;
+}
+
+static int dispatch_thread_send_subtests(int sock_fd, struct test_state =
*state)
+{
+	struct msg msg;
+	struct subtest_state *subtest_state;
+	int subtest_num =3D state->subtest_num;
+
+	state->subtest_states =3D malloc(subtest_num * sizeof(*subtest_state));
+
+	for (int i =3D 0; i < subtest_num; i++) {
+		subtest_state =3D &state->subtest_states[i];
+
+		memset(subtest_state, 0, sizeof(*subtest_state));
+
+		if (read_prog_test_msg(sock_fd, &msg, MSG_SUBTEST_DONE))
+			return 1;
+
+		subtest_state->name =3D strdup(msg.subtest_done.name);
+		subtest_state->error_cnt =3D msg.subtest_done.error_cnt;
+		subtest_state->skipped =3D msg.subtest_done.skipped;
+
+		/* collect all logs */
+		if (msg.subtest_done.have_log)
+			if (dispatch_thread_read_log(sock_fd,
+						     &subtest_state->log_buf,
+						     &subtest_state->log_cnt))
+				return 1;
+	}
+
+	return 0;
+}
+
 static void *dispatch_thread(void *ctx)
 {
 	struct dispatch_data *data =3D ctx;
@@ -957,8 +1177,9 @@ static void *dispatch_thread(void *ctx)
 		{
 			struct msg msg_do_test;
=20
+			memset(&msg_do_test, 0, sizeof(msg_do_test));
 			msg_do_test.type =3D MSG_DO_TEST;
-			msg_do_test.do_test.test_num =3D test_to_run;
+			msg_do_test.do_test.num =3D test_to_run;
 			if (send_message(sock_fd, &msg_do_test) < 0) {
 				perror("Fail to send command");
 				goto done;
@@ -967,49 +1188,39 @@ static void *dispatch_thread(void *ctx)
 		}
=20
 		/* wait for test done */
-		{
-			int err;
-			struct msg msg_test_done;
+		do {
+			struct msg msg;
=20
-			err =3D recv_message(sock_fd, &msg_test_done);
-			if (err < 0)
+			if (read_prog_test_msg(sock_fd, &msg, MSG_TEST_DONE))
 				goto error;
-			if (msg_test_done.type !=3D MSG_TEST_DONE)
-				goto error;
-			if (test_to_run !=3D msg_test_done.test_done.test_num)
+			if (test_to_run !=3D msg.test_done.num)
 				goto error;
=20
 			state =3D &test_states[test_to_run];
 			state->tested =3D true;
-			state->error_cnt =3D msg_test_done.test_done.error_cnt;
-			state->skip_cnt =3D msg_test_done.test_done.skip_cnt;
-			state->sub_succ_cnt =3D msg_test_done.test_done.sub_succ_cnt;
+			state->error_cnt =3D msg.test_done.error_cnt;
+			state->skip_cnt =3D msg.test_done.skip_cnt;
+			state->sub_succ_cnt =3D msg.test_done.sub_succ_cnt;
+			state->subtest_num =3D msg.test_done.subtest_num;
=20
 			/* collect all logs */
-			if (msg_test_done.test_done.have_log) {
-				log_fp =3D open_memstream(&state->log_buf, &state->log_cnt);
-				if (!log_fp)
+			if (msg.test_done.have_log) {
+				if (dispatch_thread_read_log(sock_fd,
+							     &state->log_buf,
+							     &state->log_cnt))
 					goto error;
+			}
=20
-				while (true) {
-					struct msg msg_log;
-
-					if (recv_message(sock_fd, &msg_log) < 0)
-						goto error;
-					if (msg_log.type !=3D MSG_TEST_LOG)
-						goto error;
+			/* collect all subtests and subtest logs */
+			if (!state->subtest_num)
+				break;
=20
-					fprintf(log_fp, "%s", msg_log.test_log.log_buf);
-					if (msg_log.test_log.is_last)
-						break;
-				}
-				fclose(log_fp);
-				log_fp =3D NULL;
-			}
-		} /* wait for test done */
+			if (dispatch_thread_send_subtests(sock_fd, state))
+				goto error;
+		} while (false);
=20
 		pthread_mutex_lock(&stdout_output_lock);
-		dump_test_log(test, state, false);
+		dump_test_log(test, state, false, true);
 		pthread_mutex_unlock(&stdout_output_lock);
 	} /* while (true) */
 error:
@@ -1052,18 +1263,24 @@ static void calculate_summary_and_print_errors(st=
ruct test_env *env)
 			succ_cnt++;
 	}
=20
-	if (fail_cnt)
+	/*
+	 * We only print error logs summary when there are failed tests and
+	 * verbose mode is not enabled. Otherwise, results may be incosistent.
+	 *
+	 */
+	if (!verbose() && fail_cnt) {
 		printf("\nAll error logs:\n");
=20
-	/* print error logs again */
-	for (i =3D 0; i < prog_test_cnt; i++) {
-		struct prog_test_def *test =3D &prog_test_defs[i];
-		struct test_state *state =3D &test_states[i];
+		/* print error logs again */
+		for (i =3D 0; i < prog_test_cnt; i++) {
+			struct prog_test_def *test =3D &prog_test_defs[i];
+			struct test_state *state =3D &test_states[i];
=20
-		if (!state->tested || !state->error_cnt)
-			continue;
+			if (!state->tested || !state->error_cnt)
+				continue;
=20
-		dump_test_log(test, state, true);
+			dump_test_log(test, state, true, true);
+		}
 	}
=20
 	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
@@ -1154,6 +1371,90 @@ static void server_main(void)
 	}
 }
=20
+static void worker_main_send_log(int sock, char *log_buf, size_t log_cnt=
)
+{
+	char *src;
+	size_t slen;
+
+	src =3D log_buf;
+	slen =3D log_cnt;
+	while (slen) {
+		struct msg msg_log;
+		char *dest;
+		size_t len;
+
+		memset(&msg_log, 0, sizeof(msg_log));
+		msg_log.type =3D MSG_TEST_LOG;
+		dest =3D msg_log.test_log.log_buf;
+		len =3D slen >=3D MAX_LOG_TRUNK_SIZE ? MAX_LOG_TRUNK_SIZE : slen;
+		memcpy(dest, src, len);
+
+		src +=3D len;
+		slen -=3D len;
+		if (!slen)
+			msg_log.test_log.is_last =3D true;
+
+		assert(send_message(sock, &msg_log) >=3D 0);
+	}
+}
+
+static void free_subtest_state(struct subtest_state *state)
+{
+	if (state->log_buf) {
+		free(state->log_buf);
+		state->log_buf =3D NULL;
+		state->log_cnt =3D 0;
+	}
+	free(state->name);
+	state->name =3D NULL;
+}
+
+static int worker_main_send_subtests(int sock, struct test_state *state)
+{
+	int i, result =3D 0;
+	struct msg msg;
+	struct subtest_state *subtest_state;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.type =3D MSG_SUBTEST_DONE;
+
+	for (i =3D 0; i < state->subtest_num; i++) {
+		subtest_state =3D &state->subtest_states[i];
+
+		msg.subtest_done.num =3D i;
+
+		strncpy(msg.subtest_done.name, subtest_state->name, MAX_SUBTEST_NAME);
+
+		msg.subtest_done.error_cnt =3D subtest_state->error_cnt;
+		msg.subtest_done.skipped =3D subtest_state->skipped;
+		msg.subtest_done.have_log =3D false;
+
+		if (verbose() || state->force_log || subtest_state->error_cnt) {
+			if (subtest_state->log_cnt)
+				msg.subtest_done.have_log =3D true;
+		}
+
+		if (send_message(sock, &msg) < 0) {
+			perror("Fail to send message done");
+			result =3D 1;
+			goto out;
+		}
+
+		/* send logs */
+		if (msg.subtest_done.have_log)
+			worker_main_send_log(sock, subtest_state->log_buf, subtest_state->log=
_cnt);
+
+		free_subtest_state(subtest_state);
+		free(subtest_state->name);
+	}
+
+out:
+	for (; i < state->subtest_num; i++)
+		free_subtest_state(&state->subtest_states[i]);
+	free(state->subtest_states);
+	return result;
+}
+
 static int worker_main(int sock)
 {
 	save_netns();
@@ -1172,10 +1473,10 @@ static int worker_main(int sock)
 					env.worker_id);
 			goto out;
 		case MSG_DO_TEST: {
-			int test_to_run =3D msg.do_test.test_num;
+			int test_to_run =3D msg.do_test.num;
 			struct prog_test_def *test =3D &prog_test_defs[test_to_run];
 			struct test_state *state =3D &test_states[test_to_run];
-			struct msg msg_done;
+			struct msg msg;
=20
 			if (env.debug)
 				fprintf(stderr, "[%d]: #%d:%s running.\n",
@@ -1185,54 +1486,38 @@ static int worker_main(int sock)
=20
 			run_one_test(test_to_run);
=20
-			memset(&msg_done, 0, sizeof(msg_done));
-			msg_done.type =3D MSG_TEST_DONE;
-			msg_done.test_done.test_num =3D test_to_run;
-			msg_done.test_done.error_cnt =3D state->error_cnt;
-			msg_done.test_done.skip_cnt =3D state->skip_cnt;
-			msg_done.test_done.sub_succ_cnt =3D state->sub_succ_cnt;
-			msg_done.test_done.have_log =3D false;
+			memset(&msg, 0, sizeof(msg));
+			msg.type =3D MSG_TEST_DONE;
+			msg.test_done.num =3D test_to_run;
+			msg.test_done.error_cnt =3D state->error_cnt;
+			msg.test_done.skip_cnt =3D state->skip_cnt;
+			msg.test_done.sub_succ_cnt =3D state->sub_succ_cnt;
+			msg.test_done.subtest_num =3D state->subtest_num;
+			msg.test_done.have_log =3D false;
=20
-			if (env.verbosity > VERBOSE_NONE || state->force_log || state->error_=
cnt) {
+			if (verbose() || state->force_log || state->error_cnt) {
 				if (state->log_cnt)
-					msg_done.test_done.have_log =3D true;
+					msg.test_done.have_log =3D true;
 			}
-			if (send_message(sock, &msg_done) < 0) {
+			if (send_message(sock, &msg) < 0) {
 				perror("Fail to send message done");
 				goto out;
 			}
=20
 			/* send logs */
-			if (msg_done.test_done.have_log) {
-				char *src;
-				size_t slen;
-
-				src =3D state->log_buf;
-				slen =3D state->log_cnt;
-				while (slen) {
-					struct msg msg_log;
-					char *dest;
-					size_t len;
-
-					memset(&msg_log, 0, sizeof(msg_log));
-					msg_log.type =3D MSG_TEST_LOG;
-					dest =3D msg_log.test_log.log_buf;
-					len =3D slen >=3D MAX_LOG_TRUNK_SIZE ? MAX_LOG_TRUNK_SIZE : slen;
-					memcpy(dest, src, len);
-
-					src +=3D len;
-					slen -=3D len;
-					if (!slen)
-						msg_log.test_log.is_last =3D true;
-
-					assert(send_message(sock, &msg_log) >=3D 0);
-				}
-			}
+			if (msg.test_done.have_log)
+				worker_main_send_log(sock, state->log_buf, state->log_cnt);
+
 			if (state->log_buf) {
 				free(state->log_buf);
 				state->log_buf =3D NULL;
 				state->log_cnt =3D 0;
 			}
+
+			if (state->subtest_num)
+				if (worker_main_send_subtests(sock, state))
+					goto out;
+
 			if (env.debug)
 				fprintf(stderr, "[%d]: #%d:%s done.\n",
 					env.worker_id,
@@ -1250,6 +1535,23 @@ static int worker_main(int sock)
 	return 0;
 }
=20
+static void free_test_states(void)
+{
+	int i, j;
+
+	for (i =3D 0; i < ARRAY_SIZE(prog_test_defs); i++) {
+		struct test_state *test_state =3D &test_states[i];
+
+		for (j =3D 0; j < test_state->subtest_num; j++)
+			free_subtest_state(&test_state->subtest_states[j]);
+
+		free(test_state->subtest_states);
+		free(test_state->log_buf);
+		test_state->subtest_states =3D NULL;
+		test_state->log_buf =3D NULL;
+	}
+}
+
 int main(int argc, char **argv)
 {
 	static const struct argp argp =3D {
@@ -1396,6 +1698,7 @@ int main(int argc, char **argv)
 		unload_bpf_testmod();
=20
 	free_test_selector(&env.test_selector);
+	free_test_states();
=20
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt =3D=3D 0)
 		return EXIT_NO_TEST;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 0a102ce460d6..18262077fdeb 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -64,23 +64,31 @@ struct test_selector {
 	int num_set_len;
 };
=20
+struct subtest_state {
+	char *name;
+	size_t log_cnt;
+	char *log_buf;
+	int error_cnt;
+	bool skipped;
+
+	FILE *stdout;
+};
+
 struct test_state {
 	bool tested;
 	bool force_log;
=20
 	int error_cnt;
 	int skip_cnt;
-	int subtest_skip_cnt;
 	int sub_succ_cnt;
=20
-	char *subtest_name;
+	struct subtest_state *subtest_states;
 	int subtest_num;
=20
-	/* store counts before subtest started */
-	int old_error_cnt;
-
 	size_t log_cnt;
 	char *log_buf;
+
+	FILE *stdout;
 };
=20
 struct test_env {
@@ -96,7 +104,8 @@ struct test_env {
 	bool list_test_names;
=20
 	struct prog_test_def *test; /* current running test */
-	struct test_state *test_state; /* current running test result */
+	struct test_state *test_state; /* current running test state */
+	struct subtest_state *subtest_state; /* current running subtest state *=
/
=20
 	FILE *stdout;
 	FILE *stderr;
@@ -116,29 +125,39 @@ struct test_env {
 };
=20
 #define MAX_LOG_TRUNK_SIZE 8192
+#define MAX_SUBTEST_NAME 1024
 enum msg_type {
 	MSG_DO_TEST =3D 0,
 	MSG_TEST_DONE =3D 1,
 	MSG_TEST_LOG =3D 2,
+	MSG_SUBTEST_DONE =3D 3,
 	MSG_EXIT =3D 255,
 };
 struct msg {
 	enum msg_type type;
 	union {
 		struct {
-			int test_num;
+			int num;
 		} do_test;
 		struct {
-			int test_num;
+			int num;
 			int sub_succ_cnt;
 			int error_cnt;
 			int skip_cnt;
 			bool have_log;
+			int subtest_num;
 		} test_done;
 		struct {
 			char log_buf[MAX_LOG_TRUNK_SIZE + 1];
 			bool is_last;
 		} test_log;
+		struct {
+			int num;
+			char name[MAX_SUBTEST_NAME + 1];
+			int error_cnt;
+			bool skipped;
+			bool have_log;
+		} subtest_done;
 	};
 };
=20
--=20
2.30.2

