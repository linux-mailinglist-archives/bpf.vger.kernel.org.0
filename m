Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F59D4F4DA9
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1457248AbiDEXr2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389573AbiDEWBu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 18:01:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DAF139CE2
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 13:42:31 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 235I0VMp024078
        for <bpf@vger.kernel.org>; Tue, 5 Apr 2022 13:42:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=JilJffTdYOzr8IPxk0rQ9nFYszJuqaoOeHQCQkADZmY=;
 b=KsI8rfAjXS6ALJ2BPuGAUEdrpB6dNknvf8A8GhtbCPml9jvTAshc/zPgAYUmCT3e1nfd
 WbmkMW9wlaMZ2FAR4B9c4oMY+WnJKVqwkjqXg/nGrKk7iZN7AXMAcCIgm3xi2BXcXrT5
 uXQgzTzT9+d0hDBfq+HyFEgFlbmmNfDQeE4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f8egtpves-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 13:42:20 -0700
Received: from twshared27284.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 5 Apr 2022 13:42:19 -0700
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 0180F53942F6; Tue,  5 Apr 2022 13:42:12 -0700 (PDT)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: Improve by-name subtest selection logic in prog_tests
Date:   Tue, 5 Apr 2022 13:41:58 -0700
Message-ID: <20220405204158.2496618-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ia7EGd_-NLiddHD1VNPUfEFFoYisNpXk
X-Proofpoint-ORIG-GUID: Ia7EGd_-NLiddHD1VNPUfEFFoYisNpXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-05_07,2022-04-05_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Improve subtest selection logic when using -t/-a/-d parameters.
In particular, more than one subtest can be specified or a
combination of tests / subtests.

-a send_signal -d send_signal/send_signal_nmi* - runs send_signal
test without nmi tests

-a send_signal/send_signal_nmi*,find_vma - runs two send_signal
subtests and find_vma test

This will allow us to have granular control over which subtests
to disable in the CI system instead of disabling whole tests.

Also, add new selftest to avoid possible regression when
changing prog_test test name selection logic.

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
---
 .../selftests/bpf/prog_tests/arg_parsing.c    |  88 ++++++++++
 tools/testing/selftests/bpf/test_progs.c      | 157 +++++++++---------
 tools/testing/selftests/bpf/test_progs.h      |  16 +-
 tools/testing/selftests/bpf/testing_helpers.c |  87 ++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |   6 +
 5 files changed, 266 insertions(+), 88 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arg_parsing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools=
/testing/selftests/bpf/prog_tests/arg_parsing.c
new file mode 100644
index 000000000000..f41a532e6194
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include "test_progs.h"
+#include "testing_helpers.h"
+
+static int duration;
+
+static void init_test_set(struct test_set *test_set)
+{
+	test_set->cnt =3D 0;
+	test_set->tests =3D NULL;
+}
+
+static void free_test_set(struct test_set *test_set)
+{
+	int i, j;
+
+	for (i =3D 0; i < test_set->cnt; i++) {
+		for (j =3D 0; j < test_set->tests[i].subtest_cnt; j++)
+			free((void *)test_set->tests[i].subtests[j]);
+		free(test_set->tests[i].subtests);
+		free(test_set->tests[i].name);
+	}
+
+	free(test_set->tests);
+	init_test_set(test_set);
+}
+
+static void test_parse_test_list(void)
+{
+	struct test_set test_set;
+
+	init_test_set(&test_set);
+
+	parse_test_list("arg_parsing", &test_set, true);
+	if (CHECK(test_set.cnt !=3D 1, "parse_test_list subtest argument", "Une=
xpected number of tests in num table %d\n", test_set.cnt))
+		goto error;
+	if (!ASSERT_OK_PTR(test_set.tests, "tests__initialized"))
+		goto error;
+	if (CHECK(!test_set.tests[0].whole_test, "parse_test_list subtest argum=
ent", "Expected test 0 to be initialized"))
+		goto error;
+	if (CHECK(strcmp("arg_parsing", test_set.tests[0].name), "parse_test_li=
st subtest argument", "Expected test 0 to be initialized"))
+		goto error;
+	free_test_set(&test_set);
+
+	parse_test_list("arg_parsing,bpf_cookie", &test_set, true);
+	if (CHECK(test_set.cnt !=3D 2, "parse_test_list subtest argument", "Une=
xpected number of tests in num table %d\n", test_set.cnt))
+		goto error;
+	if (!ASSERT_OK_PTR(test_set.tests, "tests__initialized"))
+		goto error;
+	if (CHECK(!test_set.tests[0].whole_test, "parse_test_list subtest argum=
ent", "Expected test 0 to be fully runnable"))
+		goto error;
+	if (CHECK(!test_set.tests[1].whole_test, "parse_test_list subtest argum=
ent", "Expected test 1 to be fully runnable"))
+		goto error;
+	if (CHECK(strcmp("arg_parsing", test_set.tests[0].name), "parse_test_li=
st subtest argument", "Expected test 0 to be arg_parsing"))
+		goto error;
+	if (CHECK(strcmp("bpf_cookie", test_set.tests[1].name), "parse_test_lis=
t subtest argument", "Expected test 1 to be bpf_cookie"))
+		goto error;
+	free_test_set(&test_set);
+
+	parse_test_list("arg_parsing/test_parse_test_list,bpf_cookie", &test_se=
t, true);
+	if (CHECK(test_set.cnt !=3D 2, "parse_test_list subtest argument", "Une=
xpected number of tests in num table %d\n", test_set.cnt))
+		goto error;
+	if (!ASSERT_OK_PTR(test_set.tests, "tests__initialized"))
+		goto error;
+	if (CHECK(test_set.tests[0].whole_test, "parse_test_list no subtest arg=
ument", "Expected test 0 to be fully runnable"))
+		goto error;
+	if (CHECK(!test_set.tests[1].whole_test, "parse_test_list no subtest ar=
gument", "Expected test 0 to be fully runnable"))
+		goto error;
+	if (CHECK(strcmp("arg_parsing", test_set.tests[0].name), "parse_test_li=
st subtest argument", "Expected test 0 to be arg_parsing"))
+		goto error;
+	if (CHECK(test_set.tests[0].subtest_cnt !=3D 1, "parse_test_list subtes=
t number", "Unexpected number of subtests for arg_parsing %d\n", test_set=
.tests[0].subtest_cnt))
+		goto error;
+	if (CHECK(strcmp("test_parse_test_list", test_set.tests[0].subtests[0])=
, "parse_test_list subtest name", "Expected test 0 first subtest to be to=
 be test_parse_test_list"))
+		goto error;
+	if (CHECK(test_set.tests[1].subtest_cnt !=3D 0, "parse_test_list subtes=
t number", "Unexpected number of subtests for bpf_cookie %d\n", test_set.=
tests[1].subtest_cnt))
+		goto error;
+	if (CHECK(strcmp("bpf_cookie", test_set.tests[1].name), "parse_test_lis=
t subtest argument", "Expected test 1 to be bpf_cookie"))
+		goto error;
+error:
+	free_test_set(&test_set);
+}
+
+void test_arg_parsing(void)
+{
+	if (test__start_subtest("test_parse_test_list"))
+		test_parse_test_list();
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 0a4b45d7b515..671e37cada4b 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -3,6 +3,7 @@
  */
 #define _GNU_SOURCE
 #include "test_progs.h"
+#include "testing_helpers.h"
 #include "cgroup_helpers.h"
 #include <argp.h>
 #include <pthread.h>
@@ -82,14 +83,14 @@ int usleep(useconds_t usec)
 static bool should_run(struct test_selector *sel, int num, const char *n=
ame)
 {
 	int i;
-
 	for (i =3D 0; i < sel->blacklist.cnt; i++) {
-		if (glob_match(name, sel->blacklist.strs[i]))
+		if (glob_match(name, sel->blacklist.tests[i].name) &&
+		    sel->blacklist.tests[i].whole_test)
 			return false;
 	}
=20
 	for (i =3D 0; i < sel->whitelist.cnt; i++) {
-		if (glob_match(name, sel->whitelist.strs[i]))
+		if (glob_match(name, sel->whitelist.tests[i].name))
 			return true;
 	}
=20
@@ -99,6 +100,46 @@ static bool should_run(struct test_selector *sel, int=
 num, const char *name)
 	return num < sel->num_set_len && sel->num_set[num];
 }
=20
+static bool should_run_subtest(struct test_selector *sel,
+			       struct test_selector *subtest_sel,
+			       int subtest_num,
+			       const char *test_name,
+			       const char *subtest_name)
+{
+	int i, j;
+
+	for (i =3D 0; i < sel->blacklist.cnt; i++) {
+		if (glob_match(test_name, sel->blacklist.tests[i].name)) {
+			if (!sel->blacklist.tests[i].subtest_cnt)
+				return false;
+
+			for (j =3D 0; j < sel->blacklist.tests[i].subtest_cnt; j++) {
+				if (glob_match(subtest_name,
+					       sel->blacklist.tests[i].subtests[j]))
+					return false;
+			}
+		}
+	}
+
+	for (i =3D 0; i < sel->whitelist.cnt; i++) {
+		if (glob_match(test_name, sel->whitelist.tests[i].name)) {
+			if (!sel->whitelist.tests[i].subtest_cnt)
+				return true;
+
+			for (j =3D 0; j < sel->whitelist.tests[i].subtest_cnt; j++) {
+				if (glob_match(subtest_name,
+					       sel->whitelist.tests[i].subtests[j]))
+					return true;
+			}
+		}
+	}
+
+	if (!sel->whitelist.cnt && !subtest_sel->num_set)
+		return true;
+
+	return subtest_num < subtest_sel->num_set_len && subtest_sel->num_set[s=
ubtest_num];
+}
+
 static void dump_test_log(const struct prog_test_def *test, bool failed)
 {
 	if (stdout =3D=3D env.stdout)
@@ -196,7 +237,7 @@ void test__end_subtest(void)
 	test->subtest_name =3D NULL;
 }
=20
-bool test__start_subtest(const char *name)
+bool test__start_subtest(const char *subtest_name)
 {
 	struct prog_test_def *test =3D env.test;
=20
@@ -205,17 +246,21 @@ bool test__start_subtest(const char *name)
=20
 	test->subtest_num++;
=20
-	if (!name || !name[0]) {
+	if (!subtest_name || !subtest_name[0]) {
 		fprintf(env.stderr,
 			"Subtest #%d didn't provide sub-test name!\n",
 			test->subtest_num);
 		return false;
 	}
=20
-	if (!should_run(&env.subtest_selector, test->subtest_num, name))
+	if (!should_run_subtest(&env.test_selector,
+				&env.subtest_selector,
+				test->subtest_num,
+				test->test_name,
+				subtest_name))
 		return false;
=20
-	test->subtest_name =3D strdup(name);
+	test->subtest_name =3D strdup(subtest_name);
 	if (!test->subtest_name) {
 		fprintf(env.stderr,
 			"Subtest #%d: failed to copy subtest name!\n",
@@ -527,63 +572,29 @@ static int libbpf_print_fn(enum libbpf_print_level =
level,
 	return 0;
 }
=20
-static void free_str_set(const struct str_set *set)
+static void free_test_set(const struct test_set *set)
 {
-	int i;
+	int i, j;
=20
 	if (!set)
 		return;
=20
-	for (i =3D 0; i < set->cnt; i++)
-		free((void *)set->strs[i]);
-	free(set->strs);
-}
-
-static int parse_str_list(const char *s, struct str_set *set, bool is_gl=
ob_pattern)
-{
-	char *input, *state =3D NULL, *next, **tmp, **strs =3D NULL;
-	int i, cnt =3D 0;
+	for (i =3D 0; i < set->cnt; i++) {
+		free((void *)set->tests[i].name);
+		for (j =3D 0; j < set->tests[i].subtest_cnt; j++)
+			free((void *)set->tests[i].subtests[j]);
=20
-	input =3D strdup(s);
-	if (!input)
-		return -ENOMEM;
-
-	while ((next =3D strtok_r(state ? NULL : input, ",", &state))) {
-		tmp =3D realloc(strs, sizeof(*strs) * (cnt + 1));
-		if (!tmp)
-			goto err;
-		strs =3D tmp;
-
-		if (is_glob_pattern) {
-			strs[cnt] =3D strdup(next);
-			if (!strs[cnt])
-				goto err;
-		} else {
-			strs[cnt] =3D malloc(strlen(next) + 2 + 1);
-			if (!strs[cnt])
-				goto err;
-			sprintf(strs[cnt], "*%s*", next);
-		}
-
-		cnt++;
+		free((void *)set->tests[i].subtests);
 	}
=20
-	tmp =3D realloc(set->strs, sizeof(*strs) * (cnt + set->cnt));
-	if (!tmp)
-		goto err;
-	memcpy(tmp + set->cnt, strs, sizeof(*strs) * cnt);
-	set->strs =3D (const char **)tmp;
-	set->cnt +=3D cnt;
+	free((void *)set->tests);
+}
=20
-	free(input);
-	free(strs);
-	return 0;
-err:
-	for (i =3D 0; i < cnt; i++)
-		free(strs[i]);
-	free(strs);
-	free(input);
-	return -ENOMEM;
+static void free_test_selector(struct test_selector *test_selector)
+{
+	free_test_set(&test_selector->blacklist);
+	free_test_set(&test_selector->whitelist);
+	free(test_selector->num_set);
 }
=20
 extern int extra_prog_load_log_flags;
@@ -615,33 +626,17 @@ static error_t parse_arg(int key, char *arg, struct=
 argp_state *state)
 	}
 	case ARG_TEST_NAME_GLOB_ALLOWLIST:
 	case ARG_TEST_NAME: {
-		char *subtest_str =3D strchr(arg, '/');
-
-		if (subtest_str) {
-			*subtest_str =3D '\0';
-			if (parse_str_list(subtest_str + 1,
-					   &env->subtest_selector.whitelist,
-					   key =3D=3D ARG_TEST_NAME_GLOB_ALLOWLIST))
-				return -ENOMEM;
-		}
-		if (parse_str_list(arg, &env->test_selector.whitelist,
-				   key =3D=3D ARG_TEST_NAME_GLOB_ALLOWLIST))
+		if (parse_test_list(arg,
+				    &env->test_selector.whitelist,
+				    key =3D=3D ARG_TEST_NAME_GLOB_ALLOWLIST))
 			return -ENOMEM;
 		break;
 	}
 	case ARG_TEST_NAME_GLOB_DENYLIST:
 	case ARG_TEST_NAME_BLACKLIST: {
-		char *subtest_str =3D strchr(arg, '/');
-
-		if (subtest_str) {
-			*subtest_str =3D '\0';
-			if (parse_str_list(subtest_str + 1,
-					   &env->subtest_selector.blacklist,
-					   key =3D=3D ARG_TEST_NAME_GLOB_DENYLIST))
-				return -ENOMEM;
-		}
-		if (parse_str_list(arg, &env->test_selector.blacklist,
-				   key =3D=3D ARG_TEST_NAME_GLOB_DENYLIST))
+		if (parse_test_list(arg,
+				    &env->test_selector.blacklist,
+				    key =3D=3D ARG_TEST_NAME_GLOB_DENYLIST))
 			return -ENOMEM;
 		break;
 	}
@@ -1493,12 +1488,8 @@ int main(int argc, char **argv)
 out:
 	if (!env.list_test_names && env.has_testmod)
 		unload_bpf_testmod();
-	free_str_set(&env.test_selector.blacklist);
-	free_str_set(&env.test_selector.whitelist);
-	free(env.test_selector.num_set);
-	free_str_set(&env.subtest_selector.blacklist);
-	free_str_set(&env.subtest_selector.whitelist);
-	free(env.subtest_selector.num_set);
+
+	free_test_selector(&env.test_selector);
=20
 	if (env.succ_cnt + env.fail_cnt + env.skip_cnt =3D=3D 0)
 		return EXIT_NO_TEST;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index eec4c7385b14..6a465a98341e 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -37,7 +37,6 @@ typedef __u16 __sum16;
 #include <bpf/bpf_endian.h>
 #include "trace_helpers.h"
 #include "testing_helpers.h"
-#include "flow_dissector_load.h"
=20
 enum verbosity {
 	VERBOSE_NONE,
@@ -46,14 +45,21 @@ enum verbosity {
 	VERBOSE_SUPER,
 };
=20
-struct str_set {
-	const char **strs;
+struct prog_test {
+	char *name;
+	char **subtests;
+	int subtest_cnt;
+	bool whole_test;
+};
+
+struct test_set {
+	struct prog_test *tests;
 	int cnt;
 };
=20
 struct test_selector {
-	struct str_set whitelist;
-	struct str_set blacklist;
+	struct test_set whitelist;
+	struct test_set blacklist;
 	bool *num_set;
 	int num_set_len;
 };
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
index 795b6798ccee..d2160d2a1303 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -6,6 +6,7 @@
 #include <errno.h>
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include "test_progs.h"
 #include "testing_helpers.h"
=20
 int parse_num_list(const char *s, bool **num_set, int *num_set_len)
@@ -69,6 +70,92 @@ int parse_num_list(const char *s, bool **num_set, int =
*num_set_len)
 	return 0;
 }
=20
+int parse_test_list(const char *s,
+		    struct test_set *test_set,
+		    bool is_glob_pattern)
+{
+	char *input, *state =3D NULL, *next;
+	struct prog_test *tmp, *tests =3D NULL;
+	int i, j, cnt =3D 0;
+
+	input =3D strdup(s);
+	if (!input)
+		return -ENOMEM;
+
+	while ((next =3D strtok_r(state ? NULL : input, ",", &state))) {
+		char *subtest_str =3D strchr(next, '/');
+		char *pattern =3D NULL;
+
+		tmp =3D realloc(tests, sizeof(*tests) * (cnt + 1));
+		if (!tmp)
+			goto err;
+		tests =3D tmp;
+
+		tests[cnt].subtest_cnt =3D 0;
+		tests[cnt].subtests =3D NULL;
+		tests[cnt].whole_test =3D false;
+
+		if (subtest_str) {
+			char **tmp_subtests =3D NULL;
+			*subtest_str =3D '\0';
+			int subtest_cnt =3D tests[cnt].subtest_cnt;
+
+			tmp_subtests =3D realloc(tests[cnt].subtests,
+					       sizeof(*tmp_subtests) *
+					       (subtest_cnt + 1));
+			if (!tmp_subtests)
+				goto err;
+			tests[cnt].subtests =3D tmp_subtests;
+
+			tests[cnt].subtests[subtest_cnt] =3D strdup(subtest_str + 1);
+			if (!tests[cnt].subtests[subtest_cnt])
+				goto err;
+
+			tests[cnt].subtest_cnt++;
+		} else {
+			tests[cnt].whole_test =3D true;
+		}
+
+		if (is_glob_pattern) {
+			pattern =3D "%s";
+			tests[cnt].name =3D malloc(strlen(next) + 1);
+		} else {
+			pattern =3D "*%s*";
+			tests[cnt].name =3D malloc(strlen(next) + 2 + 1);
+		}
+
+		if (!tests[cnt].name)
+			goto err;
+
+		sprintf(tests[cnt].name, pattern, next);
+
+		cnt++;
+	}
+
+	tmp =3D realloc(test_set->tests, sizeof(*tests) * (cnt + test_set->cnt)=
);
+	if (!tmp)
+		goto err;
+
+	memcpy(tmp + test_set->cnt, tests, sizeof(*tests) * cnt);
+	test_set->tests =3D tmp;
+	test_set->cnt +=3D cnt;
+
+	free(tests);
+	free(input);
+	return 0;
+
+err:
+	for (i =3D 0; i < cnt; i++) {
+		for (j =3D 0; j < tests[i].subtest_cnt; j++)
+			free(tests[i].subtests[j]);
+
+		free(tests[i].name);
+	}
+	free(tests);
+	free(input);
+	return -ENOMEM;
+}
+
 __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_inf=
o *info)
 {
 	__u32 info_len =3D sizeof(*info);
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testin=
g/selftests/bpf/testing_helpers.h
index f46ebc476ee8..d2f502184cd1 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -12,3 +12,9 @@ int bpf_test_load_program(enum bpf_prog_type type, cons=
t struct bpf_insn *insns,
 			  size_t insns_cnt, const char *license,
 			  __u32 kern_version, char *log_buf,
 			  size_t log_buf_sz);
+
+/*
+ * below function is exported for testing in prog_test test
+ */
+struct test_set;
+int parse_test_list(const char *s, struct test_set *test_set, bool is_gl=
ob_pattern);
--=20
2.30.2

