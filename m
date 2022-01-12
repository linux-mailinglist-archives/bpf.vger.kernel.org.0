Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8948CCF6
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 21:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350769AbiALUPT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 15:15:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50508 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350686AbiALUPR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 Jan 2022 15:15:17 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CHFlNV001587
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 12:15:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kUSByD/m4uaLxd03QJ2ntvoZh7fudcqMs8Xx/1QZ2TA=;
 b=Nwi5zhdlmUtuovuR+kzYIfTfb6eBpr4q1LDifYWWXbHQAMa5aL7D1rh9BbRUwiDI7vRN
 1v+shfAk2w1uSVGA/YET/GPBcORn35rvaE9Oha0IYZNJii6XyfkJ4uzZ186JeDTP8OB6
 gxc7LCq6y+cJ+2TrGYnQ6tibOOteywHUhuY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dhs9748m2-20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 12:15:17 -0800
Received: from twshared29821.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 12 Jan 2022 12:15:10 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 389774FCA1B9; Wed, 12 Jan 2022 12:15:07 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH bpf-next v2 3/5] selftests/bpf: rename btf_decl_tag.c to test_btf_decl_tag.c
Date:   Wed, 12 Jan 2022 12:15:07 -0800
Message-ID: <20220112201507.1626185-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220112201449.1620763-1-yhs@fb.com>
References: <20220112201449.1620763-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: PB-UzLCXLWJ5gbIQW19fy5JrqI5wI1cF
X-Proofpoint-GUID: PB-UzLCXLWJ5gbIQW19fy5JrqI5wI1cF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_05,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201120119
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

