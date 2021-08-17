Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BC53EE5DC
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 06:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhHQEsS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 00:48:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234066AbhHQEsR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 00:48:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17H4g3ZG012490
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:47:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=eSbx265IJW9bXPxO/h5OoEeCACvMyd+YdTv3DLk0ycE=;
 b=MxZdhBYt6iauLdmiu9bdOiGHC8Z7Itq6syQxgAdrAuTIANAPXIVRRAj1XzNAxDs7ebGS
 CHt0xFsXBgv5VNVurIkdRXq3s9jN4El1p76RaaxeqixEONBw9CnJlxNOkmJItS/EKcl1
 lzObtg2Fw5lOCvRgDqo3ARFnLO0A8+4UWMU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3aftpev0sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:47:44 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 21:47:43 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 0367522A241E; Mon, 16 Aug 2021 21:47:37 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v5 bpf-next 4/4] selftests/bpf: Support glob matching for test selector.
Date:   Mon, 16 Aug 2021 21:47:32 -0700
Message-ID: <20210817044732.3263066-5-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817044732.3263066-1-fallentree@fb.com>
References: <20210817044732.3263066-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: J_vWcT1fcOO4zy5fBH4q4Y91TzpaHe2F
X-Proofpoint-GUID: J_vWcT1fcOO4zy5fBH4q4Y91TzpaHe2F
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_01:2021-08-16,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds '-a' and '-d' arguments, support exact string match, as w=
ell as
using '*' wildcard in test/subtests selection. The old '-t' '-b' argument=
s
still supports partial string match, but they can't be used together yet.

This patach also adds support for mulitple '-a' '-d' '-t' '-b' arguments.

Caveat: Same as the current substring matching mechanism, test and subtes=
t
selector applies independently, 'a*/b*' will execute all tests matching "=
a*",
and with subtest name matching "b*", but tests matching "a*" that has no
subtests will also be executed.

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 72 +++++++++++++++++++-----
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 90539b15b744..c34eb818f115 100644
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
@@ -500,28 +528,38 @@ static int parse_str_list(const char *s, struct str=
_set *set)
 	if (!input)
 		return -ENOMEM;
=20
-	set->cnt =3D 0;
-	set->strs =3D NULL;
-
 	while ((next =3D strtok_r(state ? NULL : input, ",", &state))) {
 		tmp =3D realloc(strs, sizeof(*strs) * (cnt + 1));
 		if (!tmp)
 			goto err;
 		strs =3D tmp;
+		if (is_glob_pattern) {
+			strs[cnt] =3D strdup(next);
+		} else {
+			strs[cnt] =3D malloc(strlen(next) + 2 + 1);
+			if (!strs[cnt])
+				goto err;
+			sprintf(strs[cnt], "*%s*", next);
+		}
=20
-		strs[cnt] =3D strdup(next);
 		if (!strs[cnt])
 			goto err;
=20
 		cnt++;
 	}
=20
-	set->cnt =3D cnt;
-	set->strs =3D (const char **)strs;
+	tmp =3D realloc(set->strs, sizeof(*strs) * (cnt + set->cnt));
+	if (!tmp)
+		goto err;
+	memcpy(tmp + set->cnt,  strs,  sizeof(*strs) * (cnt));
+	set->strs =3D (const char **)tmp;
+	set->cnt +=3D cnt;
 	free(input);
+	free(strs);
 	return 0;
 err:
-	free(strs);
+	if (strs)
+		free(strs);
 	free(input);
 	return -ENOMEM;
 }
@@ -553,29 +591,35 @@ static error_t parse_arg(int key, char *arg, struct=
 argp_state *state)
 		}
 		break;
 	}
+	case ARG_TEST_NAME_GLOB_ALLOWLIST:
 	case ARG_TEST_NAME: {
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
--=20
2.30.2

