Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8183E500B
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 01:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbhHIXhY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 19:37:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15310 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237001AbhHIXhX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 19:37:23 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179NSieQ027754
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 16:37:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=H+ExqalY1V1+Lpanc3JZlajOHfLNi4M3diibtxocCyY=;
 b=D8BS39lvUzEMfHdX03WqLamhMSHzqOVoxqeAHJsoUVXoHlvsqA/zagnnOkSkmwF6jzpw
 UF++2vnKuHD8AkKChkkNGYJIwedb/94dUwhMPCNuy6oZLP8/i//q0hXYRI1TThvRKxC/
 9H3yPVqln89uDCJJ97eNI8bGjOSA/socz0w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3ab7exahw6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 16:37:02 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 16:37:01 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id A1AE71E278FE; Mon,  9 Aug 2021 16:36:55 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH bpf-next 2/5] Support glob matching for test selector.
Date:   Mon, 9 Aug 2021 16:36:30 -0700
Message-ID: <20210809233633.973638-2-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809233633.973638-1-fallentree@fb.com>
References: <20210809233633.973638-1-fallentree@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: GgaUoxJpq5TbQc5ZyJbE2xiKW3LLtust
X-Proofpoint-ORIG-GUID: GgaUoxJpq5TbQc5ZyJbE2xiKW3LLtust
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090165
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds glob matching to test selector, it allows user to use "*"=
, "?", "[]" to match test name to run.

The glob matching function is copied from perf/util/string.c

Signed-off-by: Yucong Sun <fallentree@fb.com>
---
 tools/testing/selftests/bpf/test_progs.c | 94 +++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
index 74dde0af1592..c5bffd2e78ae 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -13,6 +13,96 @@
 #include <execinfo.h> /* backtrace */
 #include <linux/membarrier.h>
=20
+// Copied from perf/util/string.c
+
+/* Character class matching */
+static bool __match_charclass(const char *pat, char c, const char **npat=
)
+{
+	bool complement =3D false, ret =3D true;
+
+	if (*pat =3D=3D '!') {
+		complement =3D true;
+		pat++;
+	}
+	if (*pat++ =3D=3D c) /* First character is special */
+		goto end;
+
+	while (*pat && *pat !=3D ']') { /* Matching */
+		if (*pat =3D=3D '-' && *(pat + 1) !=3D ']') { /* Range */
+			if (*(pat - 1) <=3D c && c <=3D *(pat + 1))
+				goto end;
+			if (*(pat - 1) > *(pat + 1))
+				goto error;
+			pat +=3D 2;
+		} else if (*pat++ =3D=3D c)
+			goto end;
+	}
+	if (!*pat)
+		goto error;
+	ret =3D false;
+
+end:
+	while (*pat && *pat !=3D ']') /* Searching closing */
+		pat++;
+	if (!*pat)
+		goto error;
+	*npat =3D pat + 1;
+	return complement ? !ret : ret;
+
+error:
+	return false;
+}
+
+// Copied from perf/util/string.c
+/* Glob/lazy pattern matching */
+static bool __match_glob(const char *str, const char *pat, bool ignore_s=
pace,
+			 bool case_ins)
+{
+	while (*str && *pat && *pat !=3D '*') {
+		if (ignore_space) {
+			/* Ignore spaces for lazy matching */
+			if (isspace(*str)) {
+				str++;
+				continue;
+			}
+			if (isspace(*pat)) {
+				pat++;
+				continue;
+			}
+		}
+		if (*pat =3D=3D '?') { /* Matches any single character */
+			str++;
+			pat++;
+			continue;
+		} else if (*pat =3D=3D '[') /* Character classes/Ranges */
+			if (__match_charclass(pat + 1, *str, &pat)) {
+				str++;
+				continue;
+			} else
+				return false;
+		else if (*pat =3D=3D '\\') /* Escaped char match as normal char */
+			pat++;
+		if (case_ins) {
+			if (tolower(*str) !=3D tolower(*pat))
+				return false;
+		} else if (*str !=3D *pat)
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
+			if (__match_glob(str++, pat, ignore_space, case_ins))
+				return true;
+	}
+	return !*str && !*pat;
+}
+
 #define EXIT_NO_TEST		2
 #define EXIT_ERR_SETUP_INFRA	3
=20
@@ -55,12 +145,12 @@ static bool should_run(struct test_selector *sel, in=
t num, const char *name)
 	int i;
=20
 	for (i =3D 0; i < sel->blacklist.cnt; i++) {
-		if (strstr(name, sel->blacklist.strs[i]))
+		if (__match_glob(name, sel->blacklist.strs[i], false, false))
 			return false;
 	}
=20
 	for (i =3D 0; i < sel->whitelist.cnt; i++) {
-		if (strstr(name, sel->whitelist.strs[i]))
+		if (__match_glob(name, sel->whitelist.strs[i], false, false))
 			return true;
 	}
=20
--=20
2.30.2

