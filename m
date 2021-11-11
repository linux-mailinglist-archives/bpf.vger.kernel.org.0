Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906C844DE7A
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 00:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhKKX3U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 18:29:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233119AbhKKX3T (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 18:29:19 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABMebXj016098
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=CD+pk/mLiIIFN0fAszFLT/Cgj06U7TcK42KuqOg8KfU=;
 b=rJ7LZXH3/p7L63keVAEe7wlBL9q7c7tXgOK0kxE8JVdtlAOgpJscK1iKentBonPyzWsg
 5PWctcufcW5sUgQ8wK2rjfQ484TVaAeKUcHpLpFNRR2vbLp4COOy4WK6CHbPgVg3nhKW
 UdXDJC+fiqFHvMn5EIgGQYefRHT0tmMvJQ8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c98k51xyy-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:30 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 15:26:25 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 5125724B3E9E; Thu, 11 Nov 2021 15:26:24 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 07/10] selftests/bpf: Rename progs/tag.c to progs/btf_decl_tag.c
Date:   Thu, 11 Nov 2021 15:26:24 -0800
Message-ID: <20211111232624.791186-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111232543.786041-1-yhs@fb.com>
References: <20211111232543.786041-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: pqPyft8W9FjYulXoBZht1JfTKs9V1UVs
X-Proofpoint-GUID: pqPyft8W9FjYulXoBZht1JfTKs9V1UVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rename progs/tag.c to progs/btf_decl_tag.c so we can introduce
progs/btf_type_tag.c in the next patch.

Also create a subtest for btf_decl_tag in prog_tests/btf_tag.c
so we can introduce btf_type_tag subtest in the next patch.

I also took opportunity to remove the check whether __has_attribute
is defined or not in progs/btf_decl_tag.c since all recent
clangs should already support this macro.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/btf_tag.c        | 20 ++++++++++++-------
 .../bpf/progs/{tag.c =3D> btf_decl_tag.c}       |  4 ----
 2 files changed, 13 insertions(+), 11 deletions(-)
 rename tools/testing/selftests/bpf/progs/{tag.c =3D> btf_decl_tag.c} (94=
%)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/tes=
ting/selftests/bpf/prog_tests/btf_tag.c
index 91821f42714d..d15cc7a88182 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -1,20 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
 #include <test_progs.h>
-#include "tag.skel.h"
+#include "btf_decl_tag.skel.h"
=20
-void test_btf_tag(void)
+static void test_btf_decl_tag(void)
 {
-	struct tag *skel;
+	struct btf_decl_tag *skel;
=20
-	skel =3D tag__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "btf_tag"))
+	skel =3D btf_decl_tag__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "btf_decl_tag"))
 		return;
=20
 	if (skel->rodata->skip_tests) {
-		printf("%s:SKIP: btf_tag attribute not supported", __func__);
+		printf("%s:SKIP: btf_decl_tag attribute not supported", __func__);
 		test__skip();
 	}
=20
-	tag__destroy(skel);
+	btf_decl_tag__destroy(skel);
+}
+
+void test_btf_tag(void)
+{
+	if (test__start_subtest("btf_decl_tag"))
+		test_btf_decl_tag();
 }
diff --git a/tools/testing/selftests/bpf/progs/tag.c b/tools/testing/self=
tests/bpf/progs/btf_decl_tag.c
similarity index 94%
rename from tools/testing/selftests/bpf/progs/tag.c
rename to tools/testing/selftests/bpf/progs/btf_decl_tag.c
index 1792f4eda095..c88ccc53529a 100644
--- a/tools/testing/selftests/bpf/progs/tag.c
+++ b/tools/testing/selftests/bpf/progs/btf_decl_tag.c
@@ -4,10 +4,6 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
=20
-#ifndef __has_attribute
-#define __has_attribute(x) 0
-#endif
-
 #if __has_attribute(btf_decl_tag)
 #define __tag1 __attribute__((btf_decl_tag("tag1")))
 #define __tag2 __attribute__((btf_decl_tag("tag2")))
--=20
2.30.2

