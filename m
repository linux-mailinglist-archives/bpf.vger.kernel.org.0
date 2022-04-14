Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0473450054E
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 07:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbiDNFHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 01:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDNFHt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 01:07:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C7724BC0
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 22:05:25 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 23DMLKr0003417
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 22:05:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=crJZ7vgCANGOZPdqWtrbMB1VP+SUAUi2a1Dp4ilw5M0=;
 b=hEmgkqG3C/spk6LRBE7llKgVHajZ558P+Su9gCvpfDDj/7j62zdGQnzQ5GfMr/fpBnoC
 5ygplwRmCAkrJL033hGf8oNsGGW8MgZTOU5THg/hfjxvHj3Esa7FyodVwZxl8auzTETJ
 +AihBjlzBl6UcGdbBM8z7jqo/CeWZDEGQyU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fdpr47sgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 22:05:24 -0700
Received: from twshared5730.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 13 Apr 2022 22:05:23 -0700
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 23B805AC82E5; Wed, 13 Apr 2022 22:05:15 -0700 (PDT)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: consolidate common code in run_one_test function
Date:   Wed, 13 Apr 2022 22:05:09 -0700
Message-ID: <20220414050509.750209-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ScBtQR2uUVXKxclVnuNIQTt4YsNsyX12
X-Proofpoint-GUID: ScBtQR2uUVXKxclVnuNIQTt4YsNsyX12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-13_04,2022-04-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a pre-req to add separate logging for each subtest.

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
 .../bpf/prog_tests/prog_tests_framework.c     |  55 ++++
 tools/testing/selftests/bpf/test_progs.c      | 301 +++++++-----------
 tools/testing/selftests/bpf/test_progs.h      |  32 +-
 3 files changed, 195 insertions(+), 193 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_tests_fra=
mework.c

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.=
c b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
new file mode 100644
index 000000000000..7a5be06653f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_tests_framework.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include "test_progs.h"
+#include "testing_helpers.h"
+
+static void clear_test_result(struct test_result *result)
+{
+	result->error_cnt =3D 0;
+	result->sub_succ_cnt =3D 0;
+	result->skip_cnt =3D 0;
+}
+
+void test_prog_tests_framework(void)
+{
+	struct test_result *result =3D env.test_result;
+
+	// in all the ASSERT calls below we need to return on the first
+	// error due to the fact that we are cleaning the test state after
+	// each dummy subtest
+
+	// test we properly count skipped tests with subtests
+	if (test__start_subtest("test_good_subtest"))
+		test__end_subtest();
+	if (!ASSERT_EQ(result->skip_cnt, 0, "skip_cnt_check"))
+		return;
+	if (!ASSERT_EQ(result->error_cnt, 0, "error_cnt_check"))
+		return;
+	if (!ASSERT_EQ(result->subtest_num, 1, "subtest_num_check"))
+		return;
+	clear_test_result(result);
+
+	if (test__start_subtest("test_skip_subtest")) {
+		test__skip();
+		test__end_subtest();
+	}
+	if (test__start_subtest("test_skip_subtest")) {
+		test__skip();
+		test__end_subtest();
+	}
+	if (!ASSERT_EQ(result->skip_cnt, 2, "skip_cnt_check"))
+		return;
+	if (!ASSERT_EQ(result->subtest_num, 3, "subtest_num_check"))
+		return;
+	clear_test_result(result);
+
+	if (test__start_subtest("test_fail_subtest")) {
+		test__fail();
+		test__end_subtest();
+	}
+	if (!ASSERT_EQ(result->error_cnt, 1, "error_cnt_check"))
+		return;
+	if (!ASSERT_EQ(result->subtest_num, 4, "subtest_num_check"))
+		return;
+	clear_test_result(result);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index dcad9871f556..b3881d4fd99d 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -52,18 +52,8 @@ struct prog_test_def {
 	void (*run_test)(void);
 	void (*run_serial_test)(void);
 	bool force_log;
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
@@ -162,14 +152,6 @@ static void dump_test_log(const struct prog_test_def=
 *test, bool failed)
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
@@ -219,55 +201,59 @@ static void restore_netns(void)
 void test__end_subtest(void)
 {
 	struct prog_test_def *test =3D env.test;
-	int sub_error_cnt =3D test->error_cnt - test->old_error_cnt;
+	struct test_result *result =3D env.test_result;
=20
-	dump_test_log(test, sub_error_cnt);
+	int sub_error_cnt =3D result->error_cnt - result->old_error_cnt;
=20
 	fprintf(stdout, "#%d/%d %s/%s:%s\n",
-	       test->test_num, test->subtest_num, test->test_name, test->subtes=
t_name,
-	       sub_error_cnt ? "FAIL" : (test->skip_cnt ? "SKIP" : "OK"));
+	       test->test_num, result->subtest_num, test->test_name, result->su=
btest_name,
+	       sub_error_cnt ? "FAIL" : (result->subtest_skip_cnt ? "SKIP" : "O=
K"));
=20
-	if (sub_error_cnt)
-		test->error_cnt++;
-	else if (test->skip_cnt =3D=3D 0)
-		test->sub_succ_cnt++;
-	skip_account();
+	if (!sub_error_cnt) {
+		if (result->subtest_skip_cnt =3D=3D 0) {
+			result->sub_succ_cnt++;
+		} else {
+			result->subtest_skip_cnt =3D 0;
+			result->skip_cnt++;
+		}
+	}
=20
-	free(test->subtest_name);
-	test->subtest_name =3D NULL;
+	free(result->subtest_name);
+	result->subtest_name =3D NULL;
 }
=20
 bool test__start_subtest(const char *subtest_name)
 {
 	struct prog_test_def *test =3D env.test;
+	struct test_result *result =3D env.test_result;
=20
-	if (test->subtest_name)
+	if (result->subtest_name)
 		test__end_subtest();
=20
-	test->subtest_num++;
+	result->subtest_num++;
=20
 	if (!subtest_name || !subtest_name[0]) {
 		fprintf(env.stderr,
 			"Subtest #%d didn't provide sub-test name!\n",
-			test->subtest_num);
+			result->subtest_num);
 		return false;
 	}
=20
 	if (!should_run_subtest(&env.test_selector,
 				&env.subtest_selector,
-				test->subtest_num,
+				result->subtest_num,
 				test->test_name,
 				subtest_name))
 		return false;
=20
-	test->subtest_name =3D strdup(subtest_name);
-	if (!test->subtest_name) {
+	result->subtest_name =3D strdup(subtest_name);
+	if (!result->subtest_name) {
 		fprintf(env.stderr,
 			"Subtest #%d: failed to copy subtest name!\n",
-			test->subtest_num);
+			result->subtest_num);
 		return false;
 	}
-	env.test->old_error_cnt =3D env.test->error_cnt;
+	result->old_error_cnt =3D result->error_cnt;
=20
 	return true;
 }
@@ -279,12 +265,15 @@ void test__force_log(void)
=20
 void test__skip(void)
 {
-	env.test->skip_cnt++;
+	if (env.test_result->subtest_name)
+		env.test_result->subtest_skip_cnt++;
+	else
+		env.test_result->skip_cnt++;
 }
=20
 void test__fail(void)
 {
-	env.test->error_cnt++;
+	env.test_result->error_cnt++;
 }
=20
 int test__join_cgroup(const char *path)
@@ -517,8 +506,11 @@ static struct prog_test_def prog_test_defs[] =3D {
 #include <prog_tests/tests.h>
 #undef DEFINE_TEST
 };
+
 static const int prog_test_cnt =3D ARRAY_SIZE(prog_test_defs);
=20
+static struct test_result test_results[ARRAY_SIZE(prog_test_defs)];
+
 const char *argp_program_version =3D "test_progs 0.1";
 const char *argp_program_bug_address =3D "<bpf@vger.kernel.org>";
 static const char argp_program_doc[] =3D "BPF selftests test runner";
@@ -838,18 +830,6 @@ static void sigint_handler(int signum)
=20
 static int current_test_idx;
 static pthread_mutex_t current_test_lock;
-static pthread_mutex_t stdout_output_lock;
-
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
=20
 static inline const char *str_msg(const struct msg *msg, char *buf)
 {
@@ -904,8 +884,12 @@ static int recv_message(int sock, struct msg *msg)
 static void run_one_test(int test_num)
 {
 	struct prog_test_def *test =3D &prog_test_defs[test_num];
+	struct test_result *result =3D &test_results[test_num];
+
+	stdio_hijack();
=20
 	env.test =3D test;
+	env.test_result =3D result;
=20
 	if (test->run_test)
 		test->run_test();
@@ -913,17 +897,26 @@ static void run_one_test(int test_num)
 		test->run_serial_test();
=20
 	/* ensure last sub-test is finalized properly */
-	if (test->subtest_name)
+	if (result->subtest_name)
 		test__end_subtest();
=20
-	test->tested =3D true;
-
-	dump_test_log(test, test->error_cnt);
+	result->tested =3D true;
=20
 	reset_affinity();
 	restore_netns();
 	if (test->need_cgroup_cleanup)
 		cleanup_cgroup_environment();
+
+	stdio_restore();
+
+	if (env.log_buf) {
+		result->log_buf =3D strdup(env.log_buf);
+		result->log_cnt =3D env.log_cnt;
+
+		free(env.log_buf);
+		env.log_buf =3D NULL;
+		env.log_cnt =3D 0;
+	}
 }
=20
 struct dispatch_data {
@@ -989,9 +982,8 @@ static void *dispatch_thread(void *ctx)
 			if (test_to_run !=3D msg_test_done.test_done.test_num)
 				goto error;
=20
-			test->tested =3D true;
 			result =3D &test_results[test_to_run];
-
+			result->tested =3D true;
 			result->error_cnt =3D msg_test_done.test_done.error_cnt;
 			result->skip_cnt =3D msg_test_done.test_done.skip_cnt;
 			result->sub_succ_cnt =3D msg_test_done.test_done.sub_succ_cnt;
@@ -1017,24 +1009,6 @@ static void *dispatch_thread(void *ctx)
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
 	} /* while (true) */
 error:
@@ -1057,38 +1031,72 @@ static void *dispatch_thread(void *ctx)
 	return NULL;
 }
=20
-static void print_all_error_logs(void)
+static void calculate_and_print_summary(struct test_env *env)
 {
 	int i;
+	int succ_cnt =3D 0, fail_cnt =3D 0, sub_succ_cnt =3D 0, skip_cnt =3D 0;
+
+	for (i =3D 0; i < prog_test_cnt; i++) {
+		struct prog_test_def *test =3D &prog_test_defs[i];
+		struct test_result *result =3D &test_results[i];
+
+		if (!result->tested)
+			continue;
+
+		sub_succ_cnt +=3D result->sub_succ_cnt;
+		skip_cnt +=3D result->skip_cnt;
+
+		if (result->error_cnt)
+			fail_cnt++;
+		else
+			succ_cnt++;
+
+		printf("#%d %s:%s\n",
+		       test->test_num, test->test_name,
+		       result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK")=
);
+
+		if (env->verbosity > VERBOSE_NONE || test->force_log || result->error_=
cnt) {
+			if (result->log_cnt) {
+				result->log_buf[result->log_cnt] =3D '\0';
+				printf("%s", result->log_buf);
+				if (result->log_buf[result->log_cnt - 1] !=3D '\n')
+					printf("\n");
+			}
+		}
+	}
=20
-	if (env.fail_cnt)
-		fprintf(stdout, "\nAll error logs:\n");
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
+		struct test_result *result =3D &test_results[i];
=20
-		if (!test->tested || !result->error_cnt)
+		if (!result->tested || !result->error_cnt)
 			continue;
=20
-		fprintf(stdout, "\n#%d %s:%s\n",
-			test->test_num, test->test_name,
-			result->error_cnt ? "FAIL" : (result->skip_cnt ? "SKIP" : "OK"));
+		printf("\n#%d %s:%s\n",
+		       test->test_num, test->test_name, "FAIL");
=20
 		if (result->log_cnt) {
 			result->log_buf[result->log_cnt] =3D '\0';
-			fprintf(stdout, "%s", result->log_buf);
+			printf("%s", result->log_buf);
 			if (result->log_buf[result->log_cnt - 1] !=3D '\n')
-				fprintf(stdout, "\n");
+				printf("\n");
 		}
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
@@ -1144,60 +1152,18 @@ static int server_main(void)
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
+	calculate_and_print_summary(&env);
=20
 	/* reap all workers */
 	for (i =3D 0; i < env.workers; i++) {
@@ -1207,8 +1173,6 @@ static int server_main(void)
 		if (pid !=3D env.worker_pids[i])
 			perror("Unable to reap worker");
 	}
-
-	return 0;
 }
=20
 static int worker_main(int sock)
@@ -1229,35 +1193,29 @@ static int worker_main(int sock)
 					env.worker_id);
 			goto out;
 		case MSG_DO_TEST: {
-			int test_to_run;
-			struct prog_test_def *test;
+			int test_to_run =3D msg.do_test.test_num;
+			struct prog_test_def *test =3D &prog_test_defs[test_to_run];
+			struct test_result *result =3D &test_results[test_to_run];
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
+			msg_done.test_done.error_cnt =3D result->error_cnt;
+			msg_done.test_done.skip_cnt =3D result->skip_cnt;
+			msg_done.test_done.sub_succ_cnt =3D result->sub_succ_cnt;
 			msg_done.test_done.have_log =3D false;
=20
-			if (env.verbosity > VERBOSE_NONE || test->force_log || test->error_cn=
t) {
-				if (env.log_cnt)
+			if (env.verbosity > VERBOSE_NONE || test->force_log || result->error_=
cnt) {
+				if (result->log_cnt)
 					msg_done.test_done.have_log =3D true;
 			}
 			if (send_message(sock, &msg_done) < 0) {
@@ -1270,8 +1228,8 @@ static int worker_main(int sock)
 				char *src;
 				size_t slen;
=20
-				src =3D env.log_buf;
-				slen =3D env.log_cnt;
+				src =3D result->log_buf;
+				slen =3D result->log_cnt;
 				while (slen) {
 					struct msg msg_log;
 					char *dest;
@@ -1291,10 +1249,10 @@ static int worker_main(int sock)
 					assert(send_message(sock, &msg_log) >=3D 0);
 				}
 			}
-			if (env.log_buf) {
-				free(env.log_buf);
-				env.log_buf =3D NULL;
-				env.log_cnt =3D 0;
+			if (result->log_buf) {
+				free(result->log_buf);
+				result->log_buf =3D NULL;
+				result->log_cnt =3D 0;
 			}
 			if (env.debug)
 				fprintf(stderr, "[%d]: #%d:%s done.\n",
@@ -1425,7 +1383,6 @@ int main(int argc, char **argv)
=20
 	for (i =3D 0; i < prog_test_cnt; i++) {
 		struct prog_test_def *test =3D &prog_test_defs[i];
-		struct test_result *result;
=20
 		if (!test->should_run)
 			continue;
@@ -1441,34 +1398,7 @@ int main(int argc, char **argv)
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
@@ -1479,10 +1409,7 @@ int main(int argc, char **argv)
 	if (env.list_test_names)
 		goto out;
=20
-	print_all_error_logs();
-
-	fprintf(stdout, "Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
-		env.succ_cnt, env.sub_succ_cnt, env.skip_cnt, env.fail_cnt);
+	calculate_and_print_summary(&env);
=20
 	close(env.saved_netns_fd);
 out:
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index 6a8d68bb459e..0521d6348e83 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -64,6 +64,24 @@ struct test_selector {
 	int num_set_len;
 };
=20
+struct test_result {
+	bool tested;
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
@@ -76,7 +94,8 @@ struct test_env {
 	bool get_test_cnt;
 	bool list_test_names;
=20
-	struct prog_test_def *test; /* current running tests */
+	struct prog_test_def *test; /* current running test */
+	struct test_result *test_result; /* current running test result */
=20
 	FILE *stdout;
 	FILE *stderr;
@@ -126,11 +145,12 @@ struct msg {
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

