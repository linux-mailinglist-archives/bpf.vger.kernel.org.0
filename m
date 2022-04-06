Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D944F6CB6
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 23:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiDFVbz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 17:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiDFVb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 17:31:27 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7B2A0462
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 13:37:09 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 236H9c02017136
        for <bpf@vger.kernel.org>; Wed, 6 Apr 2022 13:37:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=8Z3Zz7zysPJRvih6vfPxVUmBMrurBDR9ygs9oS+QpvA=;
 b=DcVUdyznoLBZ+0A6cTEbUATYomcs/uvhxGgsQmP7ZlM44vlwqpHNR7bgPgqqTiEXGqPt
 sWHgEkZOtfDH04F83gYadHvhQBIr6zRbTEl7F+tTPdADjBhNlmH0XcYgEMbYbmwJNWDx
 27ufYedB8vFEWuW1oN3WIZm54hUwwEo4wCw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f8trxsafy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 13:37:08 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 13:37:07 -0700
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 111CD546BC67; Wed,  6 Apr 2022 13:37:03 -0700 (PDT)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH v2 bpf-next] selftests/bpf: Improve by-name subtest selection logic in prog_tests
Date:   Wed, 6 Apr 2022 13:36:55 -0700
Message-ID: <20220406203655.235663-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: OpIyxqhVD9qunoLAzYU2j6anENWpzGCE
X-Proofpoint-ORIG-GUID: OpIyxqhVD9qunoLAzYU2j6anENWpzGCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_12,2022-04-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

-a 'send_signal*' -a find_vma -d send_signal/send_signal_nmi* -
runs 2 send_signal test and find_vma test. Disables two send_signal
nmi subtests

-t send_signal -t find_vma - runs two *send_signal* tests and one
*find_vma* test

This will allow us to have granular control over which subtests
to disable in the CI system instead of disabling whole tests.

Also, add new selftest to avoid possible regression when
changing prog_test test name selection logic.

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
---
 .../selftests/bpf/prog_tests/arg_parsing.c    |  99 +++++++++++
 tools/testing/selftests/bpf/test_progs.c      | 156 +++++++++---------
 tools/testing/selftests/bpf/test_progs.h      |  15 +-
 tools/testing/selftests/bpf/testing_helpers.c |  84 ++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |   8 +
 5 files changed, 275 insertions(+), 87 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arg_parsing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools=
/testing/selftests/bpf/prog_tests/arg_parsing.c
new file mode 100644
index 000000000000..8db17685da23
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+#include "test_progs.h"
+#include "testing_helpers.h"
+
+static void init_test_filter_set(struct test_filter_set *set)
+{
+	set->cnt =3D 0;
+	set->tests =3D NULL;
+}
+
+static void free_test_filter_set(struct test_filter_set *set)
+{
+	int i, j;
+
+	for (i =3D 0; i < set->cnt; i++) {
+		for (j =3D 0; j < set->tests[i].subtest_cnt; j++)
+			free((void *)set->tests[i].subtests[j]);
+		free(set->tests[i].subtests);
+		free(set->tests[i].name);
+	}
+
+	free(set->tests);
+	init_test_filter_set(set);
+}
+
+static void test_parse_test_list(void)
+{
+	struct test_filter_set set;
+
+	init_test_filter_set(&set);
+
+	ASSERT_OK(parse_test_list("arg_parsing", &set, true), "parsing");
+	if (!ASSERT_EQ(set.cnt, 1, "test filters count"))
+		goto error;
+	if (!ASSERT_OK_PTR(set.tests, "test filters initialized"))
+		goto error;
+	ASSERT_EQ(set.tests[0].subtest_cnt, 0, "subtest filters count");
+	ASSERT_OK(strcmp("arg_parsing", set.tests[0].name), "subtest name");
+	free_test_filter_set(&set);
+
+	ASSERT_OK(parse_test_list("arg_parsing,bpf_cookie", &set, true),
+		  "parsing");
+	if (!ASSERT_EQ(set.cnt, 2, "count of test filters"))
+		goto error;
+	if (!ASSERT_OK_PTR(set.tests, "test filters initialized"))
+		goto error;
+	ASSERT_EQ(set.tests[0].subtest_cnt, 0, "subtest filters count");
+	ASSERT_EQ(set.tests[1].subtest_cnt, 0, "subtest filters count");
+	ASSERT_OK(strcmp("arg_parsing", set.tests[0].name), "test name");
+	ASSERT_OK(strcmp("bpf_cookie", set.tests[1].name), "test name");
+	free_test_filter_set(&set);
+
+	ASSERT_OK(parse_test_list("arg_parsing/arg_parsing,bpf_cookie",
+				  &set,
+				  true),
+		  "parsing");
+	if (!ASSERT_EQ(set.cnt, 2, "count of test filters"))
+		goto error;
+	if (!ASSERT_OK_PTR(set.tests, "test filters initialized"))
+		goto error;
+	if (!ASSERT_EQ(set.tests[0].subtest_cnt, 1, "subtest filters count"))
+		goto error;
+	if (!ASSERT_EQ(set.tests[1].subtest_cnt, 0, "subtest filters count"))
+		goto error;
+	ASSERT_OK(strcmp("arg_parsing", set.tests[0].name), "test name");
+	ASSERT_OK(strcmp("arg_parsing", set.tests[0].subtests[0]),
+		  "subtest name");
+	ASSERT_OK(strcmp("bpf_cookie", set.tests[1].name), "test name");
+	free_test_filter_set(&set);
+
+	ASSERT_OK(parse_test_list("arg_parsing/arg_parsing", &set, true),
+		  "parsing");
+	ASSERT_OK(parse_test_list("bpf_cookie", &set, true), "parsing");
+	ASSERT_OK(parse_test_list("send_signal", &set, true), "parsing");
+	if (!ASSERT_EQ(set.cnt, 3, "count of test filters"))
+		goto error;
+	if (!ASSERT_OK_PTR(set.tests, "test filters initialized"))
+		goto error;
+	if (!ASSERT_EQ(set.tests[0].subtest_cnt, 1, "subtest filters count"))
+		goto error;
+	if (!ASSERT_EQ(set.tests[1].subtest_cnt, 0, "subtest filters count"))
+		goto error;
+	if (!ASSERT_EQ(set.tests[2].subtest_cnt, 0, "subtest filters count"))
+		goto error;
+	ASSERT_OK(strcmp("arg_parsing", set.tests[0].name), "test name");
+	ASSERT_OK(strcmp("arg_parsing", set.tests[0].subtests[0]),
+		  "subtest name");
+	ASSERT_OK(strcmp("bpf_cookie", set.tests[1].name), "test name");
+	ASSERT_OK(strcmp("send_signal", set.tests[2].name), "test name");
+error:
+	free_test_filter_set(&set);
+}
+
+void test_arg_parsing(void)
+{
+	if (test__start_subtest("test_parse_test_list"))
+		test_parse_test_list();
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 0a4b45d7b515..3599d4ee8d24 100644
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
@@ -84,12 +85,13 @@ static bool should_run(struct test_selector *sel, int=
 num, const char *name)
 	int i;
=20
 	for (i =3D 0; i < sel->blacklist.cnt; i++) {
-		if (glob_match(name, sel->blacklist.strs[i]))
+		if (glob_match(name, sel->blacklist.tests[i].name) &&
+		    !sel->blacklist.tests[i].subtest_cnt)
 			return false;
 	}
=20
 	for (i =3D 0; i < sel->whitelist.cnt; i++) {
-		if (glob_match(name, sel->whitelist.strs[i]))
+		if (glob_match(name, sel->whitelist.tests[i].name))
 			return true;
 	}
=20
@@ -99,6 +101,46 @@ static bool should_run(struct test_selector *sel, int=
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
@@ -196,7 +238,7 @@ void test__end_subtest(void)
 	test->subtest_name =3D NULL;
 }
=20
-bool test__start_subtest(const char *name)
+bool test__start_subtest(const char *subtest_name)
 {
 	struct prog_test_def *test =3D env.test;
=20
@@ -205,17 +247,21 @@ bool test__start_subtest(const char *name)
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
@@ -527,63 +573,29 @@ static int libbpf_print_fn(enum libbpf_print_level =
level,
 	return 0;
 }
=20
-static void free_str_set(const struct str_set *set)
+static void free_test_filter_set(const struct test_filter_set *set)
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
-
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
+	for (i =3D 0; i < set->cnt; i++) {
+		free((void *)set->tests[i].name);
+		for (j =3D 0; j < set->tests[i].subtest_cnt; j++)
+			free((void *)set->tests[i].subtests[j]);
=20
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
+	free_test_filter_set(&test_selector->blacklist);
+	free_test_filter_set(&test_selector->whitelist);
+	free(test_selector->num_set);
 }
=20
 extern int extra_prog_load_log_flags;
@@ -615,33 +627,17 @@ static error_t parse_arg(int key, char *arg, struct=
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
@@ -1493,12 +1489,8 @@ int main(int argc, char **argv)
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
index eec4c7385b14..ecb5fef29ee6 100644
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
@@ -46,14 +45,20 @@ enum verbosity {
 	VERBOSE_SUPER,
 };
=20
-struct str_set {
-	const char **strs;
+struct test_filter {
+	char *name;
+	char **subtests;
+	int subtest_cnt;
+};
+
+struct test_filter_set {
+	struct test_filter *tests;
 	int cnt;
 };
=20
 struct test_selector {
-	struct str_set whitelist;
-	struct str_set blacklist;
+	struct test_filter_set whitelist;
+	struct test_filter_set blacklist;
 	bool *num_set;
 	int num_set_len;
 };
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
index 795b6798ccee..4416a2532ece 100644
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
@@ -69,6 +70,89 @@ int parse_num_list(const char *s, bool **num_set, int =
*num_set_len)
 	return 0;
 }
=20
+int parse_test_list(const char *s,
+		    struct test_filter_set *set,
+		    bool is_glob_pattern)
+{
+	char *input, *state =3D NULL, *next;
+	struct test_filter *tmp, *tests =3D NULL;
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
+
+		if (subtest_str) {
+			char **tmp_subtests =3D NULL;
+			int subtest_cnt =3D tests[cnt].subtest_cnt;
+
+			*subtest_str =3D '\0';
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
+	tmp =3D realloc(set->tests, sizeof(*tests) * (cnt + set->cnt));
+	if (!tmp)
+		goto err;
+
+	memcpy(tmp +  set->cnt, tests, sizeof(*tests) * cnt);
+	set->tests =3D tmp;
+	set->cnt +=3D cnt;
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
index f46ebc476ee8..6ec00bf79cb5 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -12,3 +12,11 @@ int bpf_test_load_program(enum bpf_prog_type type, con=
st struct bpf_insn *insns,
 			  size_t insns_cnt, const char *license,
 			  __u32 kern_version, char *log_buf,
 			  size_t log_buf_sz);
+
+/*
+ * below function is exported for testing in prog_test test
+ */
+struct test_filter_set;
+int parse_test_list(const char *s,
+		    struct test_filter_set *test_set,
+		    bool is_glob_pattern);
--=20
2.30.2

