Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C067B505FC1
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 00:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbiDRW3y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 18:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiDRW3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 18:29:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8440E2AC41
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:27:10 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23IHLeFE025562
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:27:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=vZkA2cgwAr5pKClXtvfVBDGFX4+BIyhhAr6rBixF5CI=;
 b=GN1bpXVi7HL91AOJUxNADZxYv8u7key5U3Q167er3r/hLT/E5pRNY4E8kSbVI4l5HLjK
 Y4e30FDfp4lw3/C6JIBVGmheVBGAHMBa+V2QUvXM+F/xKBXxAXYUXSA0WqAFLFcbZ77v
 8yZr4VshqOI2U148jEZVTWiO75PPTCrXm1Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fftwskkhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 15:27:09 -0700
Received: from twshared29473.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 15:27:08 -0700
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 39C625E333E7; Mon, 18 Apr 2022 15:27:06 -0700 (PDT)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: refactor prog_tests logging and test execution
Date:   Mon, 18 Apr 2022 15:25:07 -0700
Message-ID: <20220418222507.1726259-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SSfzL8FOL8c8zRnakPYL8qZlmIDa-9oH
X-Proofpoint-ORIG-GUID: SSfzL8FOL8c8zRnakPYL8qZlmIDa-9oH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a pre-req to add separate logging for each subtest in
test_progs.

Move all the mutable test data to the test_result struct.
Move per-test init/de-init into the run_one_test function.
Consolidate data aggregation and final log output in
calculate_and_print_summary function.
As a side effect, this patch fixes double counting of errors
for subtests and possible duplicate output of subtest log
on failures.

Also, add prog_tests_framework.c test to verify some of the
counting logic.

As part of verification, confirmed that number of reported
tests is the same before and after the change for both parallel
and sequential test execution.

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_mod_race.c   |   4 +-
 .../bpf/prog_tests/prog_tests_framework.c     |  56 +++
 tools/testing/selftests/bpf/test_progs.c      | 327 +++++++-----------
 tools/testing/selftests/bpf/test_progs.h      |  35 +-
 4 files changed, 202 insertions(+), 220 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_tests_fra=
mework.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c b/tool=
s/testing/selftests/bpf/prog_tests/bpf_mod_race.c
index d43f548c572c..a4d0cc9d3367 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_mod_race.c
@@ -36,13 +36,13 @@ struct test_config {
 	void (*bpf_destroy)(void *);
 };
=20
-enum test_state {
+enum bpf_test_state {
 	_TS_INVALID,
 	TS_MODULE_LOAD,
 	TS_MODULE_LOAD_FAIL,
 };
=20
-static _Atomic enum test_state state =3D _TS_INVALID;
+static _Atomic enum bpf_test_state state =3D _TS_INVALID;
=20
 static int sys_finit_module(int fd, const char *param_values, int flags)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.=
c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
new file mode 100644
index 000000000000..14f2796076e0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include "test_progs.h"
+#include "testing_helpers.h"
+
+static void clear_test_state(struct test_state *state)
+{
+	state->error_cnt =3D 0;
+	state->sub_succ_cnt =3D 0;
+	state->skip_cnt =3D 0;
+}
+
+void test_prog_tests_framework(void)
+{
+	struct test_state *state =3D env.test_state;
+
+	/* in all the ASSERT calls below we need to return on the first
+	 * error due to the fact that we are cleaning the test state after
+	 * each dummy subtest
+	 */
+
+	/* test we properly count skipped tests with subtests */
+	if (test__start_subtest("test_good_subtest"))
+		test__end_subtest();
+	if (!ASSERT_EQ(state->skip_cnt, 0, "skip_cnt_check"))
+		return;
+	if (!ASSERT_EQ(state->error_cnt, 0, "error_cnt_check"))
+		return;
+	if (!ASSERT_EQ(state->subtest_num, 1, "subtest_num_check"))
+		return;
+	clear_test_state(state);
+
+	if (test__start_subtest("test_skip_subtest")) {
+		test__skip();
+		test__end_subtest();
+	}
+	if (test__start_subtest("test_skip_subtest")) {
+		test__skip();
+		test__end_subtest();
+	}
+	if (!ASSERT_EQ(state->skip_cnt, 2, "skip_cnt_check"))
+		return;
+	if (!ASSERT_EQ(state->subtest_num, 3, "subtest_num_check"))
+		return;
+	clear_test_state(state);
+
+	if (test__start_subtest("test_fail_subtest")) {
+		test__fail();
+		test__end_subtest();
+	}
+	if (!ASSERT_EQ(state->error_cnt, 1, "error_cnt_check"))
+		return;
+	if (!ASSERT_EQ(state->subtest_num, 4, "subtest_num_check"))
+		return;
+	clear_test_state(state);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index dcad9871f556..016794845ca2 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -51,19 +51,8 @@ struct prog_test_def {
 	int test_num;
 	void (*run_test)(void);
 	void (*run_serial_test)(void);
-	bool force_log;
-	int error_cnt;
-	int skip_cnt;
-	int sub_succ_cnt;
 	bool should_run;
-	bool tested;
 	bool need_cgroup_cleanup;
-
-	char *subtest_name;
-	int subtest_num;
-
-	/* store counts before subtest started */
-	int old_error_cnt;
 };
=20
 /* Override C runtime library's usleep() implementation to ensure nanosl=
eep()
@@ -141,35 +130,32 @@ static bool should_run_subtest(struct test_selector=
 *sel,
 	return subtest_num < subtest_sel->num_set_len && subtest_sel->num_set[s=
ubtest_num];
 }
=20
-static void dump_test_log(const struct prog_test_def *test, bool failed)
+static void dump_test_log(const struct prog_test_def *test,
+			  const struct test_state *test_state,
+			  bool force_failed)
 {
-	if (stdout =3D=3D env.stdout)
-		return;
+	bool failed =3D test_state->error_cnt > 0 || force_failed;
=20
 	/* worker always holds log */
 	if (env.worker_id !=3D -1)
 		return;
=20
-	fflush(stdout); /* exports env.log_buf & env.log_cnt */
+	fflush(stdout); /* exports test_state->log_buf & test_state->log_cnt */
+
+	fprintf(env.stdout, "#%d %s:%s\n",
+		test->test_num, test->test_name,
+		failed ? "FAIL" : (test_state->skip_cnt ? "SKIP" : "OK"));
=20
-	if (env.verbosity > VERBOSE_NONE || test->force_log || failed) {
-		if (env.log_cnt) {
-			env.log_buf[env.log_cnt] =3D '\0';
-			fprintf(env.stdout, "%s", env.log_buf);
-			if (env.log_buf[env.log_cnt - 1] !=3D '\n')
+	if (env.verbosity > VERBOSE_NONE || test_state->force_log || failed) {
+		if (test_state->log_cnt) {
+			test_state->log_buf[test_state->log_cnt] =3D '\0';
+			fprintf(env.stdout, "%s", test_state->log_buf);
+			if (test_state->log_buf[test_state->log_cnt - 1] !=3D '\n')
 				fprintf(env.stdout, "\n");
 		}
 	}
 }
=20
-static void skip_account(void)
-{
-	if (env.test->skip_cnt) {
-		env.skip_cnt++;
-		env.test->skip_cnt =3D 0;
-	}
-}
-
 static void stdio_restore(void);
=20
 /* A bunch of tests set custom affinity per-thread and/or per-process. R=
eset
@@ -219,72 +205,79 @@ static void restore_netns(void)
 void test__end_subtest(void)
 {
 	struct prog_test_def *test =3D env.test;
-	int sub_error_cnt =3D test->error_cnt - test->old_error_cnt;
+	struct test_state *state =3D env.test_state;
=20
-	dump_test_log(test, sub_error_cnt);
+	int sub_error_cnt =3D state->error_cnt - state->old_error_cnt;
=20
 	fprintf(stdout, "#%d/%d %s/%s:%s\n",
-	       test->test_num, test->subtest_num, test->test_name, test->subtes=
t_name,
-	       sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
+	       test->test_num, state->subtest_num, test->test_name, state->subt=
est_name,
+	       sub_error_cnt ? "FAIL" : (state->subtest_skip_cnt ? "SKIP" : "OK=
"));
=20
-	if (sub_error_cnt)
-		test->error_cnt++;
-	else if (test->skip_cnt =3D=3D 0)
-		test->sub_succ_cnt++;
-	skip_account();
+	if (!sub_error_cnt) {
+		if (state->subtest_skip_cnt =3D=3D 0) {
+			state->sub_succ_cnt++;
+		} else {
+			state->subtest_skip_cnt =3D 0;
+			state->skip_cnt++;
+		}
+	}
=20
-	free(test->subtest_name);
-	test->subtest_name =3D NULL;
+	free(state->subtest_name);
+	state->subtest_name =3D NULL;
 }
=20
 bool test__start_subtest(const char *subtest_name)
 {
 	struct prog_test_def *test =3D env.test;
+	struct test_state *state =3D env.test_state;
=20
-	if (test->subtest_name)
+	if (state->subtest_name)
 		test__end_subtest();
=20
-	test->subtest_num++;
+	state->subtest_num++;
=20
 	if (!subtest_name || !subtest_name[0]) {
 		fprintf(env.stderr,
 			"Subtest #%d didn't provide sub-test name!\n",
-			test->subtest_num);
+			state->subtest_num);
 		return false;
 	}
=20
 	if (!should_run_subtest(&env.test_selector,
 				&env.subtest_selector,
-				test->subtest_num,
+				state->subtest_num,
 				test->test_name,
 				subtest_name))
 		return false;
=20
-	test->subtest_name =3D strdup(subtest_name);
-	if (!test->subtest_name) {
+	state->subtest_name =3D strdup(subtest_name);
+	if (!state->subtest_name) {
 		fprintf(env.stderr,
 			"Subtest #%d: failed to copy subtest name!\n",
-			test->subtest_num);
+			state->subtest_num);
 		return false;
 	}
-	env.test->old_error_cnt =3D env.test->error_cnt;
+	state->old_error_cnt =3D state->error_cnt;
=20
 	return true;
 }
=20
 void test__force_log(void)
 {
-	env.test->force_log =3D true;
+	env.test_state->force_log =3D true;
 }
=20
 void test__skip(void)
 {
-	env.test->skip_cnt++;
+	if (env.test_state->subtest_name)
+		env.test_state->subtest_skip_cnt++;
+	else
+		env.test_state->skip_cnt++;
 }
=20
 void test__fail(void)
 {
-	env.test->error_cnt++;
+	env.test_state->error_cnt++;
 }
=20
 int test__join_cgroup(const char *path)
@@ -517,8 +510,11 @@ static struct prog_test_def prog_test_defs[] =3D {
 #include <prog_tests/tests.h>
 #undef DEFINE_TEST
 };
+
 static const int prog_test_cnt =3D ARRAY_SIZE(prog_test_defs);
=20
+static struct test_state test_states[ARRAY_SIZE(prog_test_defs)];
+
 const char *argp_program_version =3D "test_progs 0.1";
 const char *argp_program_bug_address =3D "<bpf@vger.kernel.org>";
 static const char argp_program_doc[] =3D "BPF selftests test runner";
@@ -701,7 +697,7 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 	return 0;
 }
=20
-static void stdio_hijack(void)
+static void stdio_hijack(char **log_buf, size_t *log_cnt)
 {
 #ifdef __GLIBC__
 	env.stdout =3D stdout;
@@ -715,7 +711,7 @@ static void stdio_hijack(void)
 	/* stdout and stderr -> buffer */
 	fflush(stdout);
=20
-	stdout =3D open_memstream(&env.log_buf, &env.log_cnt);
+	stdout =3D open_memstream(log_buf, log_cnt);
 	if (!stdout) {
 		stdout =3D env.stdout;
 		perror("open_memstream");
@@ -818,7 +814,7 @@ void crash_handler(int signum)
 	sz =3D backtrace(bt, ARRAY_SIZE(bt));
=20
 	if (env.test)
-		dump_test_log(env.test, true);
+		dump_test_log(env.test, env.test_state, true);
 	if (env.stdout)
 		stdio_restore();
 	if (env.worker_id !=3D -1)
@@ -840,17 +836,6 @@ static int current_test_idx;
 static pthread_mutex_t current_test_lock;
 static pthread_mutex_t stdout_output_lock;
=20
-struct test_result {
-	int error_cnt;
-	int skip_cnt;
-	int sub_succ_cnt;
-
-	size_t log_cnt;
-	char *log_buf;
-};
-
-static struct test_result test_results[ARRAY_SIZE(prog_test_defs)];
-
 static inline const char *str_msg(const struct msg *msg, char *buf)
 {
 	switch (msg->type) {
@@ -904,8 +889,12 @@ static int recv_message(int sock, struct msg *msg)
 static void run_one_test(int test_num)
 {
 	struct prog_test_def *test =3D &prog_test_defs[test_num];
+	struct test_state *state =3D &test_states[test_num];
=20
 	env.test =3D test;
+	env.test_state =3D state;
+
+	stdio_hijack(&state->log_buf, &state->log_cnt);
=20
 	if (test->run_test)
 		test->run_test();
@@ -913,17 +902,19 @@ static void run_one_test(int test_num)
 		test->run_serial_test();
=20
 	/* ensure last sub-test is finalized properly */
-	if (test->subtest_name)
+	if (state->subtest_name)
 		test__end_subtest();
=20
-	test->tested =3D true;
+	state->tested =3D true;
=20
-	dump_test_log(test, test->error_cnt);
+	dump_test_log(test, state, false);
=20
 	reset_affinity();
 	restore_netns();
 	if (test->need_cgroup_cleanup)
 		cleanup_cgroup_environment();
+
+	stdio_restore();
 }
=20
 struct dispatch_data {
@@ -942,7 +933,7 @@ static void *dispatch_thread(void *ctx)
 	while (true) {
 		int test_to_run =3D -1;
 		struct prog_test_def *test;
-		struct test_result *result;
+		struct test_state *state;
=20
 		/* grab a test */
 		{
@@ -989,16 +980,15 @@ static void *dispatch_thread(void *ctx)
 			if (test_to_run !=3D msg_test_done.test_done.test_num)
 				goto error;
=20
-			test->tested =3D true;
-			result =3D &test_results[test_to_run];
-
-			result->error_cnt =3D msg_test_done.test_done.error_cnt;
-			result->skip_cnt =3D msg_test_done.test_done.skip_cnt;
-			result->sub_succ_cnt =3D msg_test_done.test_done.sub_succ_cnt;
+			state =3D &test_states[test_to_run];
+			state->tested =3D true;
+			state->error_cnt =3D msg_test_done.test_done.error_cnt;
+			state->skip_cnt =3D msg_test_done.test_done.skip_cnt;
+			state->sub_succ_cnt =3D msg_test_done.test_done.sub_succ_cnt;
=20
 			/* collect all logs */
 			if (msg_test_done.test_done.have_log) {
-				log_fp =3D open_memstream(&result->log_buf, &result->log_cnt);
+				log_fp =3D open_memstream(&state->log_buf, &state->log_cnt);
 				if (!log_fp)
 					goto error;
=20
@@ -1017,25 +1007,11 @@ static void *dispatch_thread(void *ctx)
 				fclose(log_fp);
 				log_fp =3D NULL;
 			}
-			/* output log */
-			{
-				pthread_mutex_lock(&stdout_output_lock);
-
-				if (result->log_cnt) {
-					result->log_buf[result->log_cnt] =3D '\0';
-					fprintf(stdout, "%s", result->log_buf);
-					if (result->log_buf[result->log_cnt - 1] !=3D '\n')
-						fprintf(stdout, "\n");
-				}
-
-				fprintf(stdout, "#%d %s:%s\n",
-					test->test_num, test->test_name,
-					result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
-
-				pthread_mutex_unlock(&stdout_output_lock);
-			}
-
 		} /* wait for test done */
+
+		pthread_mutex_lock(&stdout_output_lock);
+		dump_test_log(test, state, false);
+		pthread_mutex_unlock(&stdout_output_lock);
 	} /* while (true) */
 error:
 	if (env.debug)
@@ -1057,38 +1033,50 @@ static void *dispatch_thread(void *ctx)
 	return NULL;
 }
=20
-static void print_all_error_logs(void)
+static void calculate_summary_and_print_errors(struct test_env *env)
 {
 	int i;
+	int succ_cnt =3D 0, fail_cnt =3D 0, sub_succ_cnt =3D 0, skip_cnt =3D 0;
=20
-	if (env.fail_cnt)
-		fprintf(stdout, "\nAll error logs:\n");
+	for (i =3D 0; i < prog_test_cnt; i++) {
+		struct test_state *state =3D &test_states[i];
+
+		if (!state->tested)
+			continue;
+
+		sub_succ_cnt +=3D state->sub_succ_cnt;
+		skip_cnt +=3D state->skip_cnt;
+
+		if (state->error_cnt)
+			fail_cnt++;
+		else
+			succ_cnt++;
+	}
+
+	if (fail_cnt)
+		printf("\nAll error logs:\n");
=20
 	/* print error logs again */
 	for (i =3D 0; i < prog_test_cnt; i++) {
-		struct prog_test_def *test;
-		struct test_result *result;
-
-		test =3D &prog_test_defs[i];
-		result =3D &test_results[i];
+		struct prog_test_def *test =3D &prog_test_defs[i];
+		struct test_state *state =3D &test_states[i];
=20
-		if (!test->tested || !result->error_cnt)
+		if (!state->tested || !state->error_cnt)
 			continue;
=20
-		fprintf(stdout, "\n#%d %s:%s\n",
-			test->test_num, test->test_name,
-			result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
-
-		if (result->log_cnt) {
-			result->log_buf[result->log_cnt] =3D '\0';
-			fprintf(stdout, "%s", result->log_buf);
-			if (result->log_buf[result->log_cnt - 1] !=3D '\n')
-				fprintf(stdout, "\n");
-		}
+		dump_test_log(test, state, true);
 	}
+
+	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
+	       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt);
+
+	env->succ_cnt =3D succ_cnt;
+	env->sub_succ_cnt =3D sub_succ_cnt;
+	env->fail_cnt =3D fail_cnt;
+	env->skip_cnt =3D skip_cnt;
 }
=20
-static int server_main(void)
+static void server_main(void)
 {
 	pthread_t *dispatcher_threads;
 	struct dispatch_data *data;
@@ -1144,60 +1132,18 @@ static int server_main(void)
=20
 	for (int i =3D 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test =3D &prog_test_defs[i];
-		struct test_result *result =3D &test_results[i];
=20
 		if (!test->should_run || !test->run_serial_test)
 			continue;
=20
-		stdio_hijack();
-
 		run_one_test(i);
-
-		stdio_restore();
-		if (env.log_buf) {
-			result->log_cnt =3D env.log_cnt;
-			result->log_buf =3D strdup(env.log_buf);
-
-			free(env.log_buf);
-			env.log_buf =3D NULL;
-			env.log_cnt =3D 0;
-		}
-		restore_netns();
-
-		fprintf(stdout, "#%d %s:%s\n",
-			test->test_num, test->test_name,
-			test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
-
-		result->error_cnt =3D test->error_cnt;
-		result->skip_cnt =3D test->skip_cnt;
-		result->sub_succ_cnt =3D test->sub_succ_cnt;
 	}
=20
 	/* generate summary */
 	fflush(stderr);
 	fflush(stdout);
=20
-	for (i =3D 0; i < prog_test_cnt; i++) {
-		struct prog_test_def *current_test;
-		struct test_result *result;
-
-		current_test =3D &prog_test_defs[i];
-		result =3D &test_results[i];
-
-		if (!current_test->tested)
-			continue;
-
-		env.succ_cnt +=3D result->error_cnt ? 0 : 1;
-		env.skip_cnt +=3D result->skip_cnt;
-		if (result->error_cnt)
-			env.fail_cnt++;
-		env.sub_succ_cnt +=3D result->sub_succ_cnt;
-	}
-
-	print_all_error_logs();
-
-	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
-		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
+	calculate_summary_and_print_errors(&env);
=20
 	/* reap all workers */
 	for (i =3D 0; i < env.workers; i++) {
@@ -1207,8 +1153,6 @@ static int server_main(void)
 		if (pid !=3D env.worker_pids[i])
 			perror("Unable to reap worker");
 	}
-
-	return 0;
 }
=20
 static int worker_main(int sock)
@@ -1229,35 +1173,29 @@ static int worker_main(int sock)
 					env.worker_id);
 			goto out;
 		case MSG_DO_TEST: {
-			int test_to_run;
-			struct prog_test_def *test;
+			int test_to_run =3D msg.do_test.test_num;
+			struct prog_test_def *test =3D &prog_test_defs[test_to_run];
+			struct test_state *state =3D &test_states[test_to_run];
 			struct msg msg_done;
=20
-			test_to_run =3D msg.do_test.test_num;
-			test =3D &prog_test_defs[test_to_run];
-
 			if (env.debug)
 				fprintf(stderr, "[%d]: #%d:%s running.\n",
 					env.worker_id,
 					test_to_run + 1,
 					test->test_name);
=20
-			stdio_hijack();
-
 			run_one_test(test_to_run);
=20
-			stdio_restore();
-
 			memset(&msg_done, 0, sizeof(msg_done));
 			msg_done.type =3D MSG_TEST_DONE;
 			msg_done.test_done.test_num =3D test_to_run;
-			msg_done.test_done.error_cnt =3D test->error_cnt;
-			msg_done.test_done.skip_cnt =3D test->skip_cnt;
-			msg_done.test_done.sub_succ_cnt =3D test->sub_succ_cnt;
+			msg_done.test_done.error_cnt =3D state->error_cnt;
+			msg_done.test_done.skip_cnt =3D state->skip_cnt;
+			msg_done.test_done.sub_succ_cnt =3D state->sub_succ_cnt;
 			msg_done.test_done.have_log =3D false;
=20
-			if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cn=
t) {
-				if (env.log_cnt)
+			if (env.verbosity > VERBOSE_NONE || state->force_log || state->error_=
cnt) {
+				if (state->log_cnt)
 					msg_done.test_done.have_log =3D true;
 			}
 			if (send_message(sock, &msg_done) < 0) {
@@ -1270,8 +1208,8 @@ static int worker_main(int sock)
 				char *src;
 				size_t slen;
=20
-				src =3D env.log_buf;
-				slen =3D env.log_cnt;
+				src =3D state->log_buf;
+				slen =3D state->log_cnt;
 				while (slen) {
 					struct msg msg_log;
 					char *dest;
@@ -1291,10 +1229,10 @@ static int worker_main(int sock)
 					assert(send_message(sock, &msg_log) >=3D 0);
 				}
 			}
-			if (env.log_buf) {
-				free(env.log_buf);
-				env.log_buf =3D NULL;
-				env.log_cnt =3D 0;
+			if (state->log_buf) {
+				free(state->log_buf);
+				state->log_buf =3D NULL;
+				state->log_cnt =3D 0;
 			}
 			if (env.debug)
 				fprintf(stderr, "[%d]: #%d:%s done.\n",
@@ -1425,7 +1363,6 @@ int main(int argc, char **argv)
=20
 	for (i =3D 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test =3D &prog_test_defs[i];
-		struct test_result *result;
=20
 		if (!test->should_run)
 			continue;
@@ -1441,34 +1378,7 @@ int main(int argc, char **argv)
 			continue;
 		}
=20
-		stdio_hijack();
-
 		run_one_test(i);
-
-		stdio_restore();
-
-		fprintf(env.stdout, "#%d %s:%s\n",
-			test->test_num, test->test_name,
-			test->error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
-
-		result =3D &test_results[i];
-		result->error_cnt =3D test->error_cnt;
-		if (env.log_buf) {
-			result->log_buf =3D strdup(env.log_buf);
-			result->log_cnt =3D env.log_cnt;
-
-			free(env.log_buf);
-			env.log_buf =3D NULL;
-			env.log_cnt =3D 0;
-		}
-
-		if (test->error_cnt)
-			env.fail_cnt++;
-		else
-			env.succ_cnt++;
-
-		skip_account();
-		env.sub_succ_cnt +=3D test->sub_succ_cnt;
 	}
=20
 	if (env.get_test_cnt) {
@@ -1479,10 +1389,7 @@ int main(int argc, char **argv)
 	if (env.list_test_names)
 		goto out;
=20
-	print_all_error_logs();
-
-	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
-		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
+	calculate_summary_and_print_errors(&env);
=20
 	close(env.saved_netns_fd);
 out:
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 6a8d68bb459e..0a102ce460d6 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -64,6 +64,25 @@ struct test_selector {
 	int num_set_len;
 };
=20
+struct test_state {
+	bool tested;
+	bool force_log;
+
+	int error_cnt;
+	int skip_cnt;
+	int subtest_skip_cnt;
+	int sub_succ_cnt;
+
+	char *subtest_name;
+	int subtest_num;
+
+	/* store counts before subtest started */
+	int old_error_cnt;
+
+	size_t log_cnt;
+	char *log_buf;
+};
+
 struct test_env {
 	struct test_selector test_selector;
 	struct test_selector subtest_selector;
@@ -76,12 +95,11 @@ struct test_env {
 	bool get_test_cnt;
 	bool list_test_names;
=20
-	struct prog_test_def *test; /* current running tests */
+	struct prog_test_def *test; /* current running test */
+	struct test_state *test_state; /* current running test result */
=20
 	FILE *stdout;
 	FILE *stderr;
-	char *log_buf;
-	size_t log_cnt;
 	int nr_cpus;
=20
 	int succ_cnt; /* successful tests */
@@ -126,11 +144,12 @@ struct msg {
=20
 extern struct test_env env;
=20
-extern void test__force_log();
-extern bool test__start_subtest(const char *name);
-extern void test__skip(void);
-extern void test__fail(void);
-extern int test__join_cgroup(const char *path);
+void test__force_log(void);
+bool test__start_subtest(const char *name);
+void test__end_subtest(void);
+void test__skip(void);
+void test__fail(void);
+int test__join_cgroup(const char *path);
=20
 #define PRINT_FAIL(format...)                                           =
       \
 	({                                                                     =
\
--=20
2.30.2

