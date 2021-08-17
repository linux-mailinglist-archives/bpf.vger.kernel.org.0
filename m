Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C753EE1EF
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 03:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhHQBDx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 21:03:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62886 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235367AbhHQBDx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Aug 2021 21:03:53 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H0thV8009101
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 18:03:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3ydV5R2RLfoRekJk7IQzPk54M4G5l4CHTLmMyjXTu5E=;
 b=gpwkTX7zOLh3DOUtRA9z7KOow7ux3l+zec9fenWfqpfeYfa5gkFTV/OIsPn6xeubQL39
 4OUyFX7ItO9NuCja7MqFd54wKPCEMFcbObb80vrTX0TASTs4wUBHt/1fixGW+OGjMRXw
 sSSXmsa7/Hebgy9vXgdlrcQzVdmx5VIekRw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aftr4k79p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 18:03:21 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 18:03:19 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 628CA22890C1; Mon, 16 Aug 2021 18:03:12 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v4 bpf-next 4/4] selftests/bpf: Support glob matching for test selector.
Date:   Mon, 16 Aug 2021 18:03:10 -0700
Message-ID: <20210817010310.2300741-5-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817010310.2300741-1-fallentree@fb.com>
References: <20210817010310.2300741-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 9QjyEsLrgK50bUvVEhLWdcgwK9et-A5H
X-Proofpoint-GUID: 9QjyEsLrgK50bUvVEhLWdcgwK9et-A5H
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_09:2021-08-16,2021-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170004
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds '-a' and '-d' arguments, supporting exact string match, a=
s well
as using '*' wildcard in test/subtests selection. The old '-t' '-b' argum=
ents
still supports partial string match, but they can't be used together yet.

Caveat: As same as the current substring matching mechanism, test and sub=
test
selector applies independently, 'a*/b*' will execute all tests matches "a=
*",
and with subtest name matches "b*", but tests matches "a*" but has no sub=
tests
will also be executed.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 64 +++++++++++++++++++++---
 tools/testing/selftests/bpf/test_progs.h |  1 +
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 90539b15b744..f5dbaa29d370 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -13,6 +13,28 @@
 #include <execinfo.h> /* backtrace */
 #include <linux/membarrier.h>
=20
+/* Adapted from perf/util/string.c */
+static bool glob_match(const char *str, const char *pat)
+{
+	while (*str && *pat && *pat !=3D '*') {
+		if (*str !=3D *pat)
+			return false;
+		str++;
+		pat++;
+	}
+	/* Check wild card */
+	if (*pat =3D=3D '*') {
+		while (*pat =3D=3D '*')
+			pat++;
+		if (!*pat) /* Tail wild card matches all */
+			return true;
+		while (*str)
+			if (glob_match(str++, pat))
+				return true;
+	}
+	return !*str && !*pat;
+}
+
 #define EXIT_NO_TEST		2
 #define EXIT_ERR_SETUP_INFRA	3
=20
@@ -55,12 +77,12 @@ static bool should_run(struct test_selector *sel, int=
 num, const char *name)
 	int i;
=20
 	for (i =3D 0; i < sel->blacklist.cnt; i++) {
-		if (strstr(name, sel->blacklist.strs[i]))
+		if (glob_match(name, sel->blacklist.strs[i]))
 			return false;
 	}
=20
 	for (i =3D 0; i < sel->whitelist.cnt; i++) {
-		if (strstr(name, sel->whitelist.strs[i]))
+		if (glob_match(name, sel->whitelist.strs[i]))
 			return true;
 	}
=20
@@ -450,6 +472,8 @@ enum ARG_KEYS {
 	ARG_VERBOSE =3D 'v',
 	ARG_GET_TEST_CNT =3D 'c',
 	ARG_LIST_TEST_NAMES =3D 'l',
+	ARG_TEST_NAME_GLOB_ALLOWLIST =3D 'a',
+	ARG_TEST_NAME_GLOB_DENYLIST =3D 'd',
 };
=20
 static const struct argp_option opts[] =3D {
@@ -467,6 +491,10 @@ static const struct argp_option opts[] =3D {
 	  "Get number of selected top-level tests " },
 	{ "list", ARG_LIST_TEST_NAMES, NULL, 0,
 	  "List test names that would run (without running them) " },
+	{ "allow", ARG_TEST_NAME_GLOB_ALLOWLIST, "NAMES", 0,
+	  "Run tests with name matching the pattern (support *)." },
+	{ "deny", ARG_TEST_NAME_GLOB_DENYLIST, "NAMES", 0,
+	  "Don't run tests with name matching the pattern (support *)." },
 	{},
 };
=20
@@ -491,7 +519,7 @@ static void free_str_set(const struct str_set *set)
 	free(set->strs);
 }
=20
-static int parse_str_list(const char *s, struct str_set *set)
+static int parse_str_list(const char *s, struct str_set *set, bool is_gl=
ob_pattern)
 {
 	char *input, *state =3D NULL, *next, **tmp, **strs =3D NULL;
 	int cnt =3D 0;
@@ -508,8 +536,14 @@ static int parse_str_list(const char *s, struct str_=
set *set)
 		if (!tmp)
 			goto err;
 		strs =3D tmp;
+		if (is_glob_pattern)
+			strs[cnt] =3D strdup(next);
+		else {
+			char* pat =3D malloc(strlen(next) + 2 + 1);
+			sprintf(pat, "*%s*", next);
+			strs[cnt] =3D pat;
+		}
=20
-		strs[cnt] =3D strdup(next);
 		if (!strs[cnt])
 			goto err;
=20
@@ -553,29 +587,43 @@ static error_t parse_arg(int key, char *arg, struct=
 argp_state *state)
 		}
 		break;
 	}
+	case ARG_TEST_NAME_GLOB_ALLOWLIST:
 	case ARG_TEST_NAME: {
+		if (env->test_selector.whitelist.cnt || env->subtest_selector.whitelis=
t.cnt) {
+			fprintf(stderr, "-a and -t are mutually exclusive, you can only speci=
fy one.\n");
+			return -EINVAL;
+		}
 		char *subtest_str =3D strchr(arg, '/');
=20
 		if (subtest_str) {
 			*subtest_str =3D '\0';
 			if (parse_str_list(subtest_str + 1,
-					   &env->subtest_selector.whitelist))
+					   &env->subtest_selector.whitelist,
+					   key =3D=3D ARG_TEST_NAME_GLOB_ALLOWLIST))
 				return -ENOMEM;
 		}
-		if (parse_str_list(arg, &env->test_selector.whitelist))
+		if (parse_str_list(arg, &env->test_selector.whitelist,
+				   key =3D=3D ARG_TEST_NAME_GLOB_ALLOWLIST))
 			return -ENOMEM;
 		break;
 	}
+	case ARG_TEST_NAME_GLOB_DENYLIST:
 	case ARG_TEST_NAME_BLACKLIST: {
+		if (env->test_selector.blacklist.cnt || env->subtest_selector.blacklis=
t.cnt) {
+			fprintf(stderr, "-d and -b are mutually exclusive, you can only speci=
fy one.\n");
+			return -EINVAL;
+		}
 		char *subtest_str =3D strchr(arg, '/');
=20
 		if (subtest_str) {
 			*subtest_str =3D '\0';
 			if (parse_str_list(subtest_str + 1,
-					   &env->subtest_selector.blacklist))
+					   &env->subtest_selector.blacklist,
+					   key =3D=3D ARG_TEST_NAME_GLOB_DENYLIST))
 				return -ENOMEM;
 		}
-		if (parse_str_list(arg, &env->test_selector.blacklist))
+		if (parse_str_list(arg, &env->test_selector.blacklist,
+				   key =3D=3D ARG_TEST_NAME_GLOB_DENYLIST))
 			return -ENOMEM;
 		break;
 	}
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index c8c2bf878f67..c475d65dce4f 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -49,6 +49,7 @@ enum verbosity {
 struct str_set {
 	const char **strs;
 	int cnt;
+	bool is_glob_pattern;
 };
=20
 struct test_selector {
--=20
2.30.2

