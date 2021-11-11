Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FDE44DE7B
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 00:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhKKX3Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 18:29:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15380 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233551AbhKKX3X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Nov 2021 18:29:23 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABMe1jb007989
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=stGcfiucZYg4AwnOsneFBnjnjUu/ua0X6ABMFaJor/I=;
 b=CXr7yKeSJ+xp7JIp8pAVrbeley7QonlnRMg2EEi7aUxoMcSA9Cd8zSz4vJashW9u6Qah
 Hji8gmE95xIPmHdbWyAjP6J8LVgPwjs1JMbu8FNOcMiKwmCUizcmPQriehZFUSuOrhTK
 oi8cQC2Jk/KD7X/Wmn9F+9x66EQPrndUu04= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9bnf0k20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 15:26:33 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 11 Nov 2021 15:26:32 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 8827324B3EC5; Thu, 11 Nov 2021 15:26:29 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 08/10] selftests/bpf: Add a C test for btf_type_tag
Date:   Thu, 11 Nov 2021 15:26:29 -0800
Message-ID: <20211111232629.791689-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211111232543.786041-1-yhs@fb.com>
References: <20211111232543.786041-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: c2LlEPhUG6tXlKrQmQD_R6n7D6Ji3IkD
X-Proofpoint-GUID: c2LlEPhUG6tXlKrQmQD_R6n7D6Ji3IkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_09,2021-11-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The following is the main btf_type_tag usage in the
C test:
  #define __tag1 __attribute__((btf_type_tag("tag1")))
  #define __tag2 __attribute__((btf_type_tag("tag2")))
  struct btf_type_tag_test {
       int __tag1 * __tag1 __tag2 *p;
  } g;

The bpftool raw dump with related types:
  [4] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
  [11] STRUCT 'btf_type_tag_test' size=3D8 vlen=3D1
          'p' type_id=3D14 bits_offset=3D0
  [12] TYPE_TAG 'tag1' type_id=3D16
  [13] TYPE_TAG 'tag2' type_id=3D12
  [14] PTR '(anon)' type_id=3D13
  [15] TYPE_TAG 'tag1' type_id=3D4
  [16] PTR '(anon)' type_id=3D15
  [17] VAR 'g' type_id=3D11, linkage=3Dglobal

With format C dump, we have
  struct btf_type_tag_test {
        int __attribute__((btf_type_tag("tag1"))) * __attribute__((btf_ty=
pe_tag("tag1"))) __attribute__((btf_type_tag("tag2"))) *p;
  };
The result C code is identical to the original definition except macro's =
are gone.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/btf_tag.c        | 24 ++++++++++++++++++
 .../selftests/bpf/progs/btf_type_tag.c        | 25 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf_type_tag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/tes=
ting/selftests/bpf/prog_tests/btf_tag.c
index d15cc7a88182..88d63e23e35f 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -3,6 +3,12 @@
 #include <test_progs.h>
 #include "btf_decl_tag.skel.h"
=20
+/* struct btf_type_tag_test is referenced in btf_type_tag.skel.h */
+struct btf_type_tag_test {
+        int **p;
+};
+#include "btf_type_tag.skel.h"
+
 static void test_btf_decl_tag(void)
 {
 	struct btf_decl_tag *skel;
@@ -19,8 +25,26 @@ static void test_btf_decl_tag(void)
 	btf_decl_tag__destroy(skel);
 }
=20
+static void test_btf_type_tag(void)
+{
+	struct btf_type_tag *skel;
+
+	skel =3D btf_type_tag__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "btf_type_tag"))
+		return;
+
+	if (skel->rodata->skip_tests) {
+		printf("%s:SKIP: btf_type_tag attribute not supported", __func__);
+		test__skip();
+	}
+
+	btf_type_tag__destroy(skel);
+}
+
 void test_btf_tag(void)
 {
 	if (test__start_subtest("btf_decl_tag"))
 		test_btf_decl_tag();
+	if (test__start_subtest("btf_type_tag"))
+		test_btf_type_tag();
 }
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag.c b/tools/tes=
ting/selftests/bpf/progs/btf_type_tag.c
new file mode 100644
index 000000000000..1d488da7e920
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#if __has_attribute(btf_type_tag)
+#define __tag1 __attribute__((btf_type_tag("tag1")))
+#define __tag2 __attribute__((btf_type_tag("tag2")))
+volatile const bool skip_tests =3D false;
+#else
+#define __tag1
+#define __tag2
+volatile const bool skip_tests =3D true;
+#endif
+
+struct btf_type_tag_test {
+	int __tag1 * __tag1 __tag2 *p;
+} g;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(sub, int x)
+{
+  return 0;
+}
--=20
2.30.2

