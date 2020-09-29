Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3503227BC11
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 06:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgI2EdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 00:33:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48884 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725283AbgI2EdP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 29 Sep 2020 00:33:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08T4TieL017138
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 21:33:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OTOPuh1u6CXRxSNj2GxsqAOTernktkvZtULFi+s4N7I=;
 b=WnOSklAIuMViZv5iCiZnXR3cpOUbtF6cw2mTdux6OZBQPDp5fgJ6wMaXIVan8GATZ5Hp
 7tydZaB2rt4QYdgplg6WFEL0s/fUnnM279rWJQaSF3BgmFVaeQmLgDPCbC7chH4CUEkV
 X7uwNaStDnZ1Nk7ICDM3EboEqxK/OfVcs8g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33t3cpb18n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 21:33:13 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Sep 2020 21:33:12 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 31B952EC774E; Mon, 28 Sep 2020 21:30:56 -0700 (PDT)
From:   Andrii Nakryiko <andriin@fb.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tony Ambardar <tony.ambardar@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH bpf-next 1/3] selftests/bpf: move and extend ASSERT_xxx() testing macros
Date:   Mon, 28 Sep 2020 21:30:44 -0700
Message-ID: <20200929043046.1324350-2-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200929043046.1324350-1-andriin@fb.com>
References: <20200929043046.1324350-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-28,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 suspectscore=8 priorityscore=1501 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009290045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move existing ASSERT_xxx() macros out of btf_write selftest into test_pro=
gs.h
to use across all selftests. Also expand a set of macros for typical case=
s.

Now there are the following macros:
  - ASSERT_EQ() -- check for equality of two integers;
  - ASSERT_STREQ() -- check for equality of two C strings;
  - ASSERT_OK() -- check for successful (zero) return result;
  - ASSERT_ERR() -- check for unsuccessful (non-zero) return result;
  - ASSERT_NULL() -- check for NULL pointer;
  - ASSERT_OK_PTR() -- check for a valid pointer;
  - ASSERT_ERR_PTR() -- check for NULL or negative error encoded in a poi=
nter.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/btf_write.c      | 34 ----------
 tools/testing/selftests/bpf/test_progs.h      | 63 +++++++++++++++++++
 2 files changed, 63 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_write.c b/tools/t=
esting/selftests/bpf/prog_tests/btf_write.c
index 88dce2cfa79b..314e1e7c36df 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_write.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_write.c
@@ -3,40 +3,6 @@
 #include <test_progs.h>
 #include <bpf/btf.h>
=20
-#define ASSERT_EQ(actual, expected, name) ({				\
-	typeof(actual) ___act =3D (actual);				\
-	typeof(expected) ___exp =3D (expected);				\
-	bool ___ok =3D ___act =3D=3D ___exp;					\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual %lld !=3D expected %lld\n",		\
-	      (name), (long long)(___act), (long long)(___exp));	\
-	___ok;								\
-})
-
-#define ASSERT_STREQ(actual, expected, name) ({				\
-	const char *___act =3D actual;					\
-	const char *___exp =3D expected;					\
-	bool ___ok =3D strcmp(___act, ___exp) =3D=3D 0;			\
-	CHECK(!___ok, (name),						\
-	      "unexpected %s: actual '%s' !=3D expected '%s'\n",		\
-	      (name), ___act, ___exp);					\
-	___ok;								\
-})
-
-#define ASSERT_OK(res, name) ({						\
-	long long ___res =3D (res);					\
-	bool ___ok =3D ___res =3D=3D 0;					\
-	CHECK(!___ok, (name), "unexpected error: %lld\n", ___res);	\
-	___ok;								\
-})
-
-#define ASSERT_ERR(res, name) ({					\
-	long long ___res =3D (res);					\
-	bool ___ok =3D ___res < 0;					\
-	CHECK(!___ok, (name), "unexpected success: %lld\n", ___res);	\
-	___ok;								\
-})
-
 static int duration =3D 0;
=20
 void test_btf_write() {
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
index dbb820dde138..238f5f61189e 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -130,6 +130,69 @@ extern int test__join_cgroup(const char *path);
 #define CHECK_ATTR(condition, tag, format...) \
 	_CHECK(condition, tag, tattr.duration, format)
=20
+#define ASSERT_EQ(actual, expected, name) ({				\
+	static int duration =3D 0;					\
+	typeof(actual) ___act =3D (actual);				\
+	typeof(expected) ___exp =3D (expected);				\
+	bool ___ok =3D ___act =3D=3D ___exp;					\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual %lld !=3D expected %lld\n",		\
+	      (name), (long long)(___act), (long long)(___exp));	\
+	___ok;								\
+})
+
+#define ASSERT_STREQ(actual, expected, name) ({				\
+	static int duration =3D 0;					\
+	const char *___act =3D actual;					\
+	const char *___exp =3D expected;					\
+	bool ___ok =3D strcmp(___act, ___exp) =3D=3D 0;			\
+	CHECK(!___ok, (name),						\
+	      "unexpected %s: actual '%s' !=3D expected '%s'\n",		\
+	      (name), ___act, ___exp);					\
+	___ok;								\
+})
+
+#define ASSERT_OK(res, name) ({						\
+	static int duration =3D 0;					\
+	long long ___res =3D (res);					\
+	bool ___ok =3D ___res =3D=3D 0;					\
+	CHECK(!___ok, (name), "unexpected error: %lld\n", ___res);	\
+	___ok;								\
+})
+
+#define ASSERT_ERR(res, name) ({					\
+	static int duration =3D 0;					\
+	long long ___res =3D (res);					\
+	bool ___ok =3D ___res < 0;					\
+	CHECK(!___ok, (name), "unexpected success: %lld\n", ___res);	\
+	___ok;								\
+})
+
+#define ASSERT_NULL(ptr, name) ({					\
+	static int duration =3D 0;					\
+	const void *___res =3D (ptr);					\
+	bool ___ok =3D !___res;						\
+	CHECK(!___ok, (name), "unexpected pointer: %p\n", ___res);	\
+	___ok;								\
+})
+
+#define ASSERT_OK_PTR(ptr, name) ({					\
+	static int duration =3D 0;					\
+	const void *___res =3D (ptr);					\
+	bool ___ok =3D !IS_ERR_OR_NULL(___res);				\
+	CHECK(!___ok, (name),						\
+	      "unexpected error: %ld\n", PTR_ERR(___res));		\
+	___ok;								\
+})
+
+#define ASSERT_ERR_PTR(ptr, name) ({					\
+	static int duration =3D 0;					\
+	const void *___res =3D (ptr);					\
+	bool ___ok =3D IS_ERR(___res)					\
+	CHECK(!___ok, (name), "unexpected pointer: %p\n", ___res);	\
+	___ok;								\
+})
+
 static inline __u64 ptr_to_u64(const void *ptr)
 {
 	return (__u64) (unsigned long) ptr;
--=20
2.24.1

