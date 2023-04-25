Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931076EEA71
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 00:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbjDYWzQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 18:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjDYWzP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 18:55:15 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C849E58
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 15:55:14 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEOql022679
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 15:55:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=DK9BiSaygivGzkHU2rPTTpmtK2Ygsjf+OKdNPfmBpPQ=;
 b=ODVeDQd1/x8vXQfJhrMYSRVnaBEc/Wfljc6nARgY49x/rk356xQ09Z01e7pZjTUURUCj
 lR1y+By7eCjBCyYcx6LXlyY6qpezvsM8b00DwxsAKP/j7qHzGBpBEuf1e0dok6w9HpV5
 EOd/uX40Cyns+iqsHbVOfeSlST1/poLVJALJ9JNRE57WrkONdbAJd4AIDm/dNAseu9Dc
 +nNEpkRqvgdTuvTGWrgnPFEBCPMvVFPjG+cO3JJcNgxTNWVahIcARTm/iL+yfkNkVElC
 UqyDe6VtYJs7GRu5KXfOW3gDpOfL6x39t3XM5jEVN8Z0gQsIpAzNXrIj/Nq4ZR63CCH7 VA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6mws98uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 15:55:14 -0700
Received: from twshared29562.14.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 25 Apr 2023 15:54:53 -0700
Received: by devvm5710.vll0.facebook.com (Postfix, from userid 624576)
        id 2B0532A34508; Tue, 25 Apr 2023 15:54:39 -0700 (PDT)
From:   Stephen Veiss <sveiss@meta.com>
To:     <bpf@vger.kernel.org>
CC:     Stephen Veiss <sveiss@meta.com>
Subject: [PATCH bpf-next 1/2] selftests/bpf: extract insert_test from parse_test_list
Date:   Tue, 25 Apr 2023 15:54:00 -0700
Message-ID: <20230425225401.1075796-2-sveiss@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230425225401.1075796-1-sveiss@meta.com>
References: <20230425225401.1075796-1-sveiss@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ahHvElujomhrMmcn7Y7OzLaIF-gXyLJ7
X-Proofpoint-ORIG-GUID: ahHvElujomhrMmcn7Y7OzLaIF-gXyLJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Split the logic to insert new tests into test filter sets out from
parse_test_list.

Fix the subtest insertion logic to reuse an existing top-level test
filter, which prevents the creation of duplicate top-level test filters
each with a single subtest.

Signed-off-by: Stephen Veiss <sveiss@meta.com>
---
 .../selftests/bpf/prog_tests/arg_parsing.c    |  13 ++
 tools/testing/selftests/bpf/testing_helpers.c | 176 +++++++++++-------
 2 files changed, 117 insertions(+), 72 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools=
/testing/selftests/bpf/prog_tests/arg_parsing.c
index b17bfa0e0aac..3754cd5f8c0a 100644
--- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
+++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
@@ -96,6 +96,19 @@ static void test_parse_test_list(void)
 		goto error;
 	ASSERT_OK(strcmp("*bpf_cookie*", set.tests[0].name), "test name");
 	ASSERT_OK(strcmp("*trace*", set.tests[0].subtests[0]), "subtest name");
+	free_test_filter_set(&set);
+
+	ASSERT_OK(parse_test_list("t/subtest1,t/subtest2", &set, true),
+		  "parsing");
+	if (!ASSERT_EQ(set.cnt, 1, "count of test filters"))
+		goto error;
+	if (!ASSERT_OK_PTR(set.tests, "test filters initialized"))
+		goto error;
+	if (!ASSERT_EQ(set.tests[0].subtest_cnt, 2, "subtest filters count"))
+		goto error;
+	ASSERT_OK(strcmp("t", set.tests[0].name), "test name");
+	ASSERT_OK(strcmp("subtest1", set.tests[0].subtests[0]), "subtest name")=
;
+	ASSERT_OK(strcmp("subtest2", set.tests[0].subtests[1]), "subtest name")=
;
 error:
 	free_test_filter_set(&set);
 }
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
index 0b5e0829e5be..14322371e1d8 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -70,92 +70,124 @@ int parse_num_list(const char *s, bool **num_set, in=
t *num_set_len)
 	return 0;
 }
=20
+static int do_insert_test(struct test_filter_set *set,
+			  char *test_str,
+			  char *subtest_str)
+{
+	struct test_filter *tmp, *test;
+	char **ctmp;
+	int i;
+
+	for (i =3D 0; i < set->cnt; i++) {
+		test =3D &set->tests[i];
+
+		if (strcmp(test_str, test->name) =3D=3D 0) {
+			free(test_str);
+			goto subtest;
+		}
+	}
+
+	tmp =3D realloc(set->tests, sizeof(*test) * (set->cnt + 1));
+	if (!tmp)
+		return -ENOMEM;
+
+	set->tests =3D tmp;
+	test =3D &set->tests[set->cnt];
+
+	test->name =3D test_str;
+	test->subtests =3D NULL;
+	test->subtest_cnt =3D 0;
+
+	set->cnt++;
+
+subtest:
+	if (!subtest_str)
+		return 0;
+
+	for (i =3D 0; i < test->subtest_cnt; i++) {
+		if (strcmp(subtest_str, test->subtests[i]) =3D=3D 0) {
+			free(subtest_str);
+			return 0;
+		}
+	}
+
+	ctmp =3D realloc(test->subtests,
+		       sizeof(*test->subtests) * (test->subtest_cnt + 1));
+	if (!ctmp)
+		return -ENOMEM;
+
+	test->subtests =3D ctmp;
+	test->subtests[test->subtest_cnt] =3D subtest_str;
+
+	test->subtest_cnt++;
+
+	return 0;
+}
+
+static int insert_test(struct test_filter_set *set,
+		       char *test_spec,
+		       bool is_glob_pattern)
+{
+	char *pattern, *subtest_str, *ext_test_str, *ext_subtest_str =3D NULL;
+	int glob_chars =3D 0;
+
+	if (is_glob_pattern) {
+		pattern =3D "%s";
+	} else {
+		pattern =3D "*%s*";
+		glob_chars =3D 2;
+	}
+
+	subtest_str =3D strchr(test_spec, '/');
+	if (subtest_str) {
+		*subtest_str =3D '\0';
+		subtest_str +=3D 1;
+	}
+
+	ext_test_str =3D malloc(strlen(test_spec) + glob_chars + 1);
+	if (!ext_test_str)
+		goto err;
+
+	sprintf(ext_test_str, pattern, test_spec);
+
+	if (subtest_str) {
+		ext_subtest_str =3D malloc(strlen(subtest_str) + glob_chars + 1);
+		if (!ext_subtest_str)
+			goto err;
+
+		sprintf(ext_subtest_str, pattern, subtest_str);
+	}
+
+	return do_insert_test(set, ext_test_str, ext_subtest_str);
+
+err:
+	free(ext_test_str);
+	free(ext_subtest_str);
+
+	return -ENOMEM;
+}
+
 int parse_test_list(const char *s,
 		    struct test_filter_set *set,
 		    bool is_glob_pattern)
 {
-	char *input, *state =3D NULL, *next;
-	struct test_filter *tmp, *tests =3D NULL;
-	int i, j, cnt =3D 0;
+	char *input, *state =3D NULL, *test_spec;
+	int err;
=20
 	input =3D strdup(s);
 	if (!input)
 		return -ENOMEM;
=20
-	while ((next =3D strtok_r(state ? NULL : input, ",", &state))) {
-		char *subtest_str =3D strchr(next, '/');
-		char *pattern =3D NULL;
-		int glob_chars =3D 0;
-
-		tmp =3D realloc(tests, sizeof(*tests) * (cnt + 1));
-		if (!tmp)
-			goto err;
-		tests =3D tmp;
-
-		tests[cnt].subtest_cnt =3D 0;
-		tests[cnt].subtests =3D NULL;
-
-		if (is_glob_pattern) {
-			pattern =3D "%s";
-		} else {
-			pattern =3D "*%s*";
-			glob_chars =3D 2;
+	while ((test_spec =3D strtok_r(state ? NULL : input, ",", &state))) {
+		err =3D insert_test(set, test_spec, is_glob_pattern);
+		if (err) {
+			free(input);
+			return err;
 		}
-
-		if (subtest_str) {
-			char **tmp_subtests =3D NULL;
-			int subtest_cnt =3D tests[cnt].subtest_cnt;
-
-			*subtest_str =3D '\0';
-			subtest_str +=3D 1;
-			tmp_subtests =3D realloc(tests[cnt].subtests,
-					       sizeof(*tmp_subtests) *
-					       (subtest_cnt + 1));
-			if (!tmp_subtests)
-				goto err;
-			tests[cnt].subtests =3D tmp_subtests;
-
-			tests[cnt].subtests[subtest_cnt] =3D
-				malloc(strlen(subtest_str) + glob_chars + 1);
-			if (!tests[cnt].subtests[subtest_cnt])
-				goto err;
-			sprintf(tests[cnt].subtests[subtest_cnt],
-				pattern,
-				subtest_str);
-
-			tests[cnt].subtest_cnt++;
-		}
-
-		tests[cnt].name =3D malloc(strlen(next) + glob_chars + 1);
-		if (!tests[cnt].name)
-			goto err;
-		sprintf(tests[cnt].name, pattern, next);
-
-		cnt++;
 	}
=20
-	tmp =3D realloc(set->tests, sizeof(*tests) * (cnt + set->cnt));
-	if (!tmp)
-		goto err;
-
-	memcpy(tmp +  set->cnt, tests, sizeof(*tests) * cnt);
-	set->tests =3D tmp;
-	set->cnt +=3D cnt;
-
-	free(tests);
 	free(input);
 	return 0;
-
-err:
-	for (i =3D 0; i < cnt; i++) {
-		for (j =3D 0; j < tests[i].subtest_cnt; j++)
-			free(tests[i].subtests[j]);
-
-		free(tests[i].name);
-	}
-	free(tests);
-	free(input);
-	return -ENOMEM;
 }
=20
 __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_inf=
o *info)
--=20
2.34.1

