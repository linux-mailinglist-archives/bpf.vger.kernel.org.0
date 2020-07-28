Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13568231574
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 00:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgG1WSF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 18:18:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56748 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729491AbgG1WSF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Jul 2020 18:18:05 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06SMAVU6013728
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 15:18:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=wLOdyT/+RINEnZFGW5QzQlENlb1kTGqEEkiZ0zQDfZI=;
 b=Ec6XAlo3QMk0izl1qQ42bsOMjOf1c6S+mMpsSq1FiyQwqCRKkCBHtFQcf9LaH30vV9XO
 wb0RHhdJDxyX7ElPV5A+MVcJIRqCDgltHgPJl6FB+MLLFIEktt+jED8+zKtPrPYRF8kc
 j6suCaSuEjWwXo34kvCnNZJK390jKvpbBgg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32jp0uj20s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 15:18:03 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 28 Jul 2020 15:18:02 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id AC59B3704F19; Tue, 28 Jul 2020 15:18:01 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Yonghong Song <yhs@fb.com>
Smtp-Origin-Hostname: devbig003.ftw2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/2] selftests/bpf: test bpf_iter buffer access with negative offset
Date:   Tue, 28 Jul 2020 15:18:01 -0700
Message-ID: <20200728221801.1090406-1-yhs@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200728221801.1090349-1-yhs@fb.com>
References: <20200728221801.1090349-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-28_17:2020-07-28,2020-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=13 malwarescore=0
 mlxlogscore=997 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280157
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit afbf21dce668 ("bpf: Support readonly/readwrite buffers
in verifier") added readonly/readwrite buffer support which
is currently used by bpf_iter tracing programs. It has
a bug with incorrect parameter ordering which later fixed
by Commit f6dfbe31e8fa ("bpf: Fix swapped arguments in calls
to check_buffer_access").

This patch added a test case with a negative offset access
which will trigger the error path.

Without Commit f6dfbe31e8fa, running the test case in the patch,
the error message looks like:
   R1_w=3Drdwr_buf(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  ; value_sum +=3D *(__u32 *)(value - 4);
  2: (61) r1 =3D *(u32 *)(r1 -4)
  R1 invalid (null) buffer access: off=3D-4, size=3D4

With the above commit, the error message looks like:
   R1_w=3Drdwr_buf(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
  ; value_sum +=3D *(__u32 *)(value - 4);
  2: (61) r1 =3D *(u32 *)(r1 -4)
  R1 invalid rdwr buffer access: off=3D-4, size=3D4

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/bpf_iter.c       | 13 ++++++++++++
 .../selftests/bpf/progs/bpf_iter_test_kern6.c | 21 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_test_kern6=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
index d95de80b1851..4ffefdc1130f 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -21,6 +21,7 @@
 #include "bpf_iter_bpf_percpu_array_map.skel.h"
 #include "bpf_iter_bpf_sk_storage_map.skel.h"
 #include "bpf_iter_test_kern5.skel.h"
+#include "bpf_iter_test_kern6.skel.h"
=20
 static int duration;
=20
@@ -885,6 +886,16 @@ static void test_rdonly_buf_out_of_bound(void)
 	bpf_iter_test_kern5__destroy(skel);
 }
=20
+static void test_buf_neg_offset(void)
+{
+	struct bpf_iter_test_kern6 *skel;
+
+	skel =3D bpf_iter_test_kern6__open_and_load();
+	if (CHECK(skel, "bpf_iter_test_kern6__open_and_load",
+		  "skeleton open_and_load unexpected success\n"))
+		bpf_iter_test_kern6__destroy(skel);
+}
+
 void test_bpf_iter(void)
 {
 	if (test__start_subtest("btf_id_or_null"))
@@ -933,4 +944,6 @@ void test_bpf_iter(void)
 		test_bpf_sk_storage_map();
 	if (test__start_subtest("rdonly-buf-out-of-bound"))
 		test_rdonly_buf_out_of_bound();
+	if (test__start_subtest("buf-neg-offset"))
+		test_buf_neg_offset();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c b/to=
ols/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
new file mode 100644
index 000000000000..1c7304f56b1e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_test_kern6.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 Facebook */
+#include "bpf_iter.h"
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+__u32 value_sum =3D 0;
+
+SEC("iter/bpf_map_elem")
+int dump_bpf_hash_map(struct bpf_iter__bpf_map_elem *ctx)
+{
+	void *value =3D ctx->value;
+
+	if (value =3D=3D (void *)0)
+		return 0;
+
+	/* negative offset, verifier failure. */
+	value_sum +=3D *(__u32 *)(value - 4);
+	return 0;
+}
--=20
2.24.1

