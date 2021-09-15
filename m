Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C198140BF91
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 08:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhIOGM5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 02:12:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49778 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230395AbhIOGM4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 02:12:56 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18ENSFHS000965
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 23:11:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=yek57vxqUqpCQZjKCXC0yPj+GrhhPQh/DP0x2vsjv0Q=;
 b=LPlCgaYywiciffK5gV5GRgYOo8cxBzYo9jq+wIa7GJHxJCVa2xj8OBQ0CE1nnhj//3Xt
 5XN3EywsouWoOcxRAI5t30ijjZFESzP7tke5uWzPHOhntElSp6w8BH5nGBo5Ash63fRl
 CkG/aG9rFQGuUnxyEhP6hwgr+BvwXKAdlfI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b33y7a556-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 23:11:38 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 23:10:45 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id 5339573C43A3; Tue, 14 Sep 2021 23:10:36 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] selftests/bpf: skip btf_tag test if btf_tag attribute not supported
Date:   Tue, 14 Sep 2021 23:10:36 -0700
Message-ID: <20210915061036.2577971-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: gwqAYBPH_7D3ErvJYkJhgltPk7U00_M0
X-Proofpoint-ORIG-GUID: gwqAYBPH_7D3ErvJYkJhgltPk7U00_M0
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_01,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109150038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit c240ba287890 ("selftests/bpf: Add a test with a bpf
program with btf_tag attributes") added btf_tag selftest
to test BTF_KIND_TAG generation from C source code, and to
test kernel validation of generated BTF types.
But if an old clang (clang 13 or earlier) is used, the
following compiler warning may be seen:
  progs/tag.c:23:20: warning: unknown attribute 'btf_tag' ignored
and the test itself is marked OK. The compiler warning is bad
and the test itself shouldn't be marked OK.

This patch added the check for btf_tag attribute support.
If btf_tag is not supported by the clang, the attribute will
not be used in the code and the test will be marked as skipped.
For example, with clang 13:
  ./test_progs -t btf_tag
  #21 btf_tag:SKIP
  Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED

The selftests/README.rst is updated to clarify when the btf_tag
test may be skipped.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/README.rst           | 14 ++++++++++++++
 tools/testing/selftests/bpf/prog_tests/btf_tag.c |  6 ++++++
 tools/testing/selftests/bpf/progs/tag.c          | 12 +++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftes=
ts/bpf/README.rst
index 9b17f2867488..8200c0da2769 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -201,6 +201,20 @@ Without it, the error from compiling bpf selftests loo=
ks like:
=20
 __ https://reviews.llvm.org/D93563
=20
+btf_tag test and Clang version
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+The btf_tag selftest require LLVM support to recognize the btf_tag attribu=
te.
+It was introduced in `Clang 14`__.
+
+Without it, the btf_tag selftest will be skipped and you will observe:
+
+.. code-block:: console
+
+  #<test_num> btf_tag:SKIP
+
+__ https://reviews.llvm.org/D106614
+
 Clang dependencies for static linking tests
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/testi=
ng/selftests/bpf/prog_tests/btf_tag.c
index f939527ede77..91821f42714d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_tag.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -10,5 +10,11 @@ void test_btf_tag(void)
 	skel =3D tag__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "btf_tag"))
 		return;
+
+	if (skel->rodata->skip_tests) {
+		printf("%s:SKIP: btf_tag attribute not supported", __func__);
+		test__skip();
+	}
+
 	tag__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/tag.c b/tools/testing/selfte=
sts/bpf/progs/tag.c
index 17f88c58a6c5..b46b1bfac7da 100644
--- a/tools/testing/selftests/bpf/progs/tag.c
+++ b/tools/testing/selftests/bpf/progs/tag.c
@@ -4,8 +4,19 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
=20
+#ifndef __has_attribute
+#define __has_attribute(x) 0
+#endif
+
+#if __has_attribute(btf_tag)
 #define __tag1 __attribute__((btf_tag("tag1")))
 #define __tag2 __attribute__((btf_tag("tag2")))
+volatile const bool skip_tests __tag1 __tag2 =3D false;
+#else
+#define __tag1
+#define __tag2
+volatile const bool skip_tests =3D true;
+#endif
=20
 struct key_t {
 	int a;
@@ -20,7 +31,6 @@ struct {
 	__type(value, __u64);
 } hashmap1 SEC(".maps");
=20
-__u32 total __tag1 __tag2 =3D 0;
=20
 static __noinline int foo(int x __tag1 __tag2) __tag1 __tag2
 {
--=20
2.30.2

