Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571A6F0E97
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 00:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjD0Wx6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 18:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjD0Wxz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 18:53:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B11BDC
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:53:54 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RMnD9F006047
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:53:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Tfg/2PoJ1PnlvHzjhmnbVWjloWiIpTXqZiImuElDW44=;
 b=Xy4bbIIYRyHr+O0ijpRW9mCuZXDDn5IX3cYa5GuedOM/yJJ1SkSmaJmJWfFztYZFDYB6
 PZHpTBQYB2uIk/501B+pIRBu46I/6xD2tDTjuYwN5qYgm2xQd8wlUqFZDiq7SFiX7w62
 1JXB82eH2XvmbdGzvS8i2gT7NLzEkoYmBvU61C3rNRB5l0Yl2nunK6AY8VccgQhWR5f7
 F4lcpAzirFo/tpfv7Du01R8iHPWFEEk3CqxIJQ2ULWQ+OpP5jqWiFLu0pFHJc/fQiirE
 ogfo0HKleAvwavJytbWxaYJaROLYrwp51bIF+Q1iW1aDC64k1mBo0m0RqJnd0XhmFhGL gQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q825ur0wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 15:53:53 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 15:53:52 -0700
Received: by devvm5710.vll0.facebook.com (Postfix, from userid 624576)
        id 8F1372D198AA; Thu, 27 Apr 2023 15:53:39 -0700 (PDT)
From:   Stephen Veiss <sveiss@meta.com>
To:     <bpf@vger.kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     Yonghong Song <yhs@meta.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Stephen Veiss <sveiss@meta.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test_progs can read test lists from file
Date:   Thu, 27 Apr 2023 15:53:33 -0700
Message-ID: <20230427225333.3506052-3-sveiss@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230427225333.3506052-1-sveiss@meta.com>
References: <20230427225333.3506052-1-sveiss@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BEo7QQhlFCnzMbXpVFINszcbLJOSvhk5
X-Proofpoint-ORIG-GUID: BEo7QQhlFCnzMbXpVFINszcbLJOSvhk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_09,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Improve test selection logic when using -a/-b/-d/-t options.
The list of tests to include or exclude can now be read from a file,
specified as @<filename>.

The file contains one name (or wildcard pattern) per line, and
comments beginning with # are ignored.

These options can be passed multiple times to read more than one file.

Signed-off-by: Stephen Veiss <sveiss@meta.com>
---

Notes:
    There was a suggestion to replace remove() with close() in
    test_parse_test_list_file. mkstemp() doesn't unlink the temp file it
    creates, so this would have left a file behind. I did try to clean up
    the error logic here slightly instead.

 .../selftests/bpf/prog_tests/arg_parsing.c    | 55 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.c      | 37 +++++++++----
 tools/testing/selftests/bpf/testing_helpers.c | 47 ++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  3 +
 4 files changed, 132 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools=
/testing/selftests/bpf/prog_tests/arg_parsing.c
index 3754cd5f8c0a..bb143de68875 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -113,8 +113,63 @@ static void test_parse_test_list(void)
 	free_test_filter_set(&set);
 }
=20
+static void test_parse_test_list_file(void)
+{
+	struct test_filter_set set;
+	char tmpfile[80];
+	FILE *fp;
+	int fd;
+
+	snprintf(tmpfile, sizeof(tmpfile), "/tmp/bpf_arg_parsing_test.XXXXXX");
+	fd =3D mkstemp(tmpfile);
+	if (!ASSERT_GE(fd, 0, "create tmp"))
+		return;
+
+	fp =3D fdopen(fd, "w");
+	if (!ASSERT_NEQ(fp, NULL, "fdopen tmp")) {
+		close(fd);
+		goto out_remove;
+	}
+
+	fprintf(fp, "# comment\n");
+	fprintf(fp, "  test_with_spaces    \n");
+	fprintf(fp, "testA/subtest    # comment\n");
+	fprintf(fp, "testB#comment with no space\n");
+	fprintf(fp, "testB # duplicate\n");
+	fprintf(fp, "testA/subtest # subtest duplicate\n");
+	fprintf(fp, "testA/subtest2\n");
+	fprintf(fp, "testC_no_eof_newline");
+	fflush(fp);
+
+	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
+		goto out_fclose;
+
+	init_test_filter_set(&set);
+
+	ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file");
+
+	ASSERT_EQ(set.cnt, 4, "test  count");
+	ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name")=
;
+	ASSERT_EQ(set.tests[0].subtest_cnt, 0, "test 0 subtest count");
+	ASSERT_OK(strcmp("testA", set.tests[1].name), "test 1 name");
+	ASSERT_EQ(set.tests[1].subtest_cnt, 2, "test 1 subtest count");
+	ASSERT_OK(strcmp("subtest", set.tests[1].subtests[0]), "test 1 subtest =
0");
+	ASSERT_OK(strcmp("subtest2", set.tests[1].subtests[1]), "test 1 subtest=
 1");
+	ASSERT_OK(strcmp("testB", set.tests[2].name), "test 2 name");
+	ASSERT_OK(strcmp("testC_no_eof_newline", set.tests[3].name), "test 3 na=
me");
+
+	free_test_filter_set(&set);
+
+out_fclose:
+	fclose(fp);
+out_remove:
+	remove(tmpfile);
+}
+
 void test_arg_parsing(void)
 {
 	if (test__start_subtest("test_parse_test_list"))
 		test_parse_test_list();
+	if (test__start_subtest("test_parse_test_list_file"))
+		test_parse_test_list_file();
 }
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index ea82921110da..793689dcc170 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -714,7 +714,13 @@ static struct test_state test_states[ARRAY_SIZE(prog=
_test_defs)];
=20
 const char *argp_program_version =3D "test_progs 0.1";
 const char *argp_program_bug_address =3D "<bpf@vger.kernel.org>";
-static const char argp_program_doc[] =3D "BPF selftests test runner";
+static const char argp_program_doc[] =3D
+"BPF selftests test runner\v"
+"Options accepting the NAMES parameter take either a comma-separated lis=
t\n"
+"of test names, or a filename prefixed with @. The file contains one nam=
e\n"
+"(or wildcard pattern) per line, and comments beginning with # are ignor=
ed.\n"
+"\n"
+"These options can be passed repeatedly to read multiple files.\n";
=20
 enum ARG_KEYS {
 	ARG_TEST_NUM =3D 'n',
@@ -797,6 +803,7 @@ extern int extra_prog_load_log_flags;
 static error_t parse_arg(int key, char *arg, struct argp_state *state)
 {
 	struct test_env *env =3D state->input;
+	int err =3D 0;
=20
 	switch (key) {
 	case ARG_TEST_NUM: {
@@ -821,18 +828,28 @@ static error_t parse_arg(int key, char *arg, struct=
 argp_state *state)
 	}
 	case ARG_TEST_NAME_GLOB_ALLOWLIST:
 	case ARG_TEST_NAME: {
-		if (parse_test_list(arg,
-				    &env->test_selector.whitelist,
-				    key =3D=3D ARG_TEST_NAME_GLOB_ALLOWLIST))
-			return -ENOMEM;
+		if (arg[0] =3D=3D '@')
+			err =3D parse_test_list_file(arg + 1,
+						   &env->test_selector.whitelist,
+						   key =3D=3D ARG_TEST_NAME_GLOB_ALLOWLIST);
+		else
+			err =3D parse_test_list(arg,
+					      &env->test_selector.whitelist,
+					      key =3D=3D ARG_TEST_NAME_GLOB_ALLOWLIST);
+
 		break;
 	}
 	case ARG_TEST_NAME_GLOB_DENYLIST:
 	case ARG_TEST_NAME_BLACKLIST: {
-		if (parse_test_list(arg,
-				    &env->test_selector.blacklist,
-				    key =3D=3D ARG_TEST_NAME_GLOB_DENYLIST))
-			return -ENOMEM;
+		if (arg[0] =3D=3D '@')
+			err =3D parse_test_list_file(arg + 1,
+						   &env->test_selector.blacklist,
+						   key =3D=3D ARG_TEST_NAME_GLOB_DENYLIST);
+		else
+			err =3D parse_test_list(arg,
+					      &env->test_selector.blacklist,
+					      key =3D=3D ARG_TEST_NAME_GLOB_DENYLIST);
+
 		break;
 	}
 	case ARG_VERIFIER_STATS:
@@ -900,7 +917,7 @@ static error_t parse_arg(int key, char *arg, struct a=
rgp_state *state)
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
-	return 0;
+	return err;
 }
=20
 /*
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
index fca617e87710..dc9595ade8de 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 /* Copyright (C) 2019 Netronome Systems, Inc. */
 /* Copyright (C) 2020 Facebook, Inc. */
+#include <ctype.h>
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
@@ -167,6 +168,52 @@ static int insert_test(struct test_filter_set *set,
 	return -ENOMEM;
 }
=20
+int parse_test_list_file(const char *path,
+			 struct test_filter_set *set,
+			 bool is_glob_pattern)
+{
+	char *buf =3D NULL, *capture_start, *capture_end, *scan_end;
+	size_t buflen =3D 0;
+	int err =3D 0;
+	FILE *f;
+
+	f =3D fopen(path, "r");
+	if (!f) {
+		err =3D -errno;
+		fprintf(stderr, "Failed to open '%s': %d\n", path, err);
+		return err;
+	}
+
+	while (getline(&buf, &buflen, f) !=3D -1) {
+		capture_start =3D buf;
+
+		while (isspace(*capture_start))
+			++capture_start;
+
+		capture_end =3D capture_start;
+		scan_end =3D capture_start;
+
+		while (*scan_end && *scan_end !=3D '#') {
+			if (!isspace(*scan_end))
+				capture_end =3D scan_end;
+
+			++scan_end;
+		}
+
+		if (capture_end =3D=3D capture_start)
+			continue;
+
+		*(++capture_end) =3D '\0';
+
+		err =3D insert_test(set, capture_start, is_glob_pattern);
+		if (err)
+			break;
+	}
+
+	fclose(f);
+	return err;
+}
+
 int parse_test_list(const char *s,
 		    struct test_filter_set *set,
 		    bool is_glob_pattern)
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testin=
g/selftests/bpf/testing_helpers.h
index eb8790f928e4..98f09bbae86f 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -20,5 +20,8 @@ struct test_filter_set;
 int parse_test_list(const char *s,
 		    struct test_filter_set *test_set,
 		    bool is_glob_pattern);
+int parse_test_list_file(const char *path,
+			 struct test_filter_set *test_set,
+			 bool is_glob_pattern);
=20
 __u64 read_perf_max_sample_freq(void);
--=20
2.34.1

