Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2BF44BB06
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhKJFXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:23:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30918 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229526AbhKJFXI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 00:23:08 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA51ii3030194
        for <bpf@vger.kernel.org>; Tue, 9 Nov 2021 21:20:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ZPdYxCzim13yMPMVaPAcv0kLa3XXIMihpFakL+KmyDI=;
 b=qgqs9F5JxQbbvIadL6cSsf3RigtNHdoIicUBiIFLU8zlofM6Nt3NVo0kDHgCimLAeN4H
 64Uzbz3xPq0HzREysBNgZEFGez1kOTkm99jjkCEIhImpzw+3qlA27XRFkw+mPeRhSqk4
 sxvOEvx6++b7tEyBPBN6KxsKE7h45u9T3sY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c87jg83ns-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:20:21 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 9 Nov 2021 21:20:19 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id AF9E7236120A; Tue,  9 Nov 2021 21:20:17 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next 07/10] selftests/bpf: Rename progs/tag.c to progs/btf_decl_tag.c
Date:   Tue, 9 Nov 2021 21:20:17 -0800
Message-ID: <20211110052017.372003-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110051940.367472-1-yhs@fb.com>
References: <20211110051940.367472-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: PJHdiUFJWQiWj9YKtPtB6f2XCASR6mBm
X-Proofpoint-ORIG-GUID: PJHdiUFJWQiWj9YKtPtB6f2XCASR6mBm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-10_01,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rename progs/tag.c to progs/btf_decl_tag.c so we can introduce
progs/btf_type_tag.c in the next patch.

Also create a subtest for btf_decl_tag in prog_tests/btf_tag.c
so we can introduce btf_type_tag subtest in the next patch.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/btf_tag.c        | 20 ++++++++++++-------
 .../bpf/progs/{tag.c =3D> btf_decl_tag.c}       |  0
 2 files changed, 13 insertions(+), 7 deletions(-)
 rename tools/testing/selftests/bpf/progs/{tag.c =3D> btf_decl_tag.c} (10=
0%)

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
similarity index 100%
rename from tools/testing/selftests/bpf/progs/tag.c
rename to tools/testing/selftests/bpf/progs/btf_decl_tag.c
--=20
2.30.2

