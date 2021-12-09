Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723B146F22A
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 18:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbhLIRjc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Dec 2021 12:39:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40636 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243102AbhLIRjb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Dec 2021 12:39:31 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B96u962030516
        for <bpf@vger.kernel.org>; Thu, 9 Dec 2021 09:35:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kUSByD/m4uaLxd03QJ2ntvoZh7fudcqMs8Xx/1QZ2TA=;
 b=o32evHBTQU7SObDa2IYONUr28sL9dLJesRRLUdd7gT25HffEjBdDzd9FqT010GUe5pSj
 m4L8A/0A8dHZO29QGV005MI9qC5klK5sYZzmStPC/TnOqc0nYiQfuaIx1JBCpQGZgV0M
 E8PAF4UeEkOCtFpkmkE+vUN+cJMzH4Bx0NM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cucyduw5u-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 09 Dec 2021 09:35:58 -0800
Received: from intmgw001.05.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 09:35:57 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id EEA6538B9D65; Thu,  9 Dec 2021 09:35:53 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next 3/5] selftests/bpf: rename btf_decl_tag.c to test_btf_decl_tag.c
Date:   Thu, 9 Dec 2021 09:35:53 -0800
Message-ID: <20211209173553.1528895-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209173537.1525283-1-yhs@fb.com>
References: <20211209173537.1525283-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: mMQtHiK9HwsEArwVgU5fIg8h3sK8qXKP
X-Proofpoint-ORIG-GUID: mMQtHiK9HwsEArwVgU5fIg8h3sK8qXKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The uapi btf.h contains the following declaration:
  struct btf_decl_tag {
       __s32   component_idx;
  };

The skeleton will also generate a struct with name
"btf_decl_tag" for bpf program btf_decl_tag.c.

Rename btf_decl_tag.c to test_btf_decl_tag.c so
the corresponding skeleton struct name becomes
"test_btf_decl_tag". This way, we could include
uapi btf.h in prog_tests/btf_tag.c.
There is no functionality change for this patch.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_tag.c          | 8 ++++----
 .../bpf/progs/{btf_decl_tag.c =3D> test_btf_decl_tag.c}     | 0
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename tools/testing/selftests/bpf/progs/{btf_decl_tag.c =3D> test_btf_d=
ecl_tag.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/tes=
ting/selftests/bpf/prog_tests/btf_tag.c
index 88d63e23e35f..c4cf27777ff7 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
 #include <test_progs.h>
-#include "btf_decl_tag.skel.h"
+#include "test_btf_decl_tag.skel.h"
=20
 /* struct btf_type_tag_test is referenced in btf_type_tag.skel.h */
 struct btf_type_tag_test {
@@ -11,9 +11,9 @@ struct btf_type_tag_test {
=20
 static void test_btf_decl_tag(void)
 {
-	struct btf_decl_tag *skel;
+	struct test_btf_decl_tag *skel;
=20
-	skel =3D btf_decl_tag__open_and_load();
+	skel =3D test_btf_decl_tag__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "btf_decl_tag"))
 		return;
=20
@@ -22,7 +22,7 @@ static void test_btf_decl_tag(void)
 		test__skip();
 	}
=20
-	btf_decl_tag__destroy(skel);
+	test_btf_decl_tag__destroy(skel);
 }
=20
 static void test_btf_type_tag(void)
diff --git a/tools/testing/selftests/bpf/progs/btf_decl_tag.c b/tools/tes=
ting/selftests/bpf/progs/test_btf_decl_tag.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/btf_decl_tag.c
rename to tools/testing/selftests/bpf/progs/test_btf_decl_tag.c
--=20
2.30.2

