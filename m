Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C404403156
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 01:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347209AbhIGXCo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 19:02:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15944 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347032AbhIGXCn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 19:02:43 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187MxtIp011452
        for <bpf@vger.kernel.org>; Tue, 7 Sep 2021 16:01:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8xXwtfkiykV6FNsdj/Oayegw6eJWL8E9/DiZDfKAiLg=;
 b=XHE1PxWZYImWpsIq3xhtL4jniPw7g31AAev2VdDGY4SWnTZq2ZOIBzYYqKmwcSWTSUt8
 rQtcro4F+Jbsm8x8f5RD9Ns6yg3Cg3VZ8xpYROcntGvn92Mkdbe1wYqKQzStVgLQUVIR
 X+2vCmmyCjQ7ulSNaaHiXr317kRrQl56Sxs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcq4t7qk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 16:01:36 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 16:01:34 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id D567F6E0C10A; Tue,  7 Sep 2021 16:01:32 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 8/9] selftests/bpf: add a test with a bpf program with btf_tag attributes
Date:   Tue, 7 Sep 2021 16:01:32 -0700
Message-ID: <20210907230132.1960689-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907230050.1957493-1-yhs@fb.com>
References: <20210907230050.1957493-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: v165mIFGdZKYRDAnP9hbE6GrQyg9MSC7
X-Proofpoint-ORIG-GUID: v165mIFGdZKYRDAnP9hbE6GrQyg9MSC7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a bpf program with btf_tag attributes. The program is
loaded successfully with the kernel. With the command
  bpftool btf dump file ./tag.o
the following dump shows that tags are properly encoded:
  [8] STRUCT 'key_t' size=3D12 vlen=3D3
          'a' type_id=3D2 bits_offset=3D0
          'b' type_id=3D2 bits_offset=3D32
          'c' type_id=3D2 bits_offset=3D64
  [9] TAG 'tag1' type_id=3D8, comp_id=3D-1
  [10] TAG 'tag2' type_id=3D8, comp_id=3D-1
  [11] TAG 'tag1' type_id=3D8, comp_id=3D1
  [12] TAG 'tag2' type_id=3D8, comp_id=3D1
  ...
  [21] FUNC_PROTO '(anon)' ret_type_id=3D2 vlen=3D1
          'x' type_id=3D2
  [22] FUNC 'foo' type_id=3D21 linkage=3Dstatic
  [23] TAG 'tag1' type_id=3D22, comp_id=3D0
  [24] TAG 'tag2' type_id=3D22, comp_id=3D0
  [25] TAG 'tag1' type_id=3D22, comp_id=3D-1
  [26] TAG 'tag2' type_id=3D22, comp_id=3D-1
  ...
  [29] VAR 'total' type_id=3D27, linkage=3Dglobal
  [30] TAG 'tag1' type_id=3D29, comp_id=3D-1
  [31] TAG 'tag2' type_id=3D29, comp_id=3D-1

If an old clang compiler, which does not support btf_tag attribute,
is used, these btf_tag attributes will be silently ignored.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/btf_tag.c        | 14 +++++++
 tools/testing/selftests/bpf/progs/tag.c       | 39 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
 create mode 100644 tools/testing/selftests/bpf/progs/tag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_tag.c b/tools/tes=
ting/selftests/bpf/prog_tests/btf_tag.c
new file mode 100644
index 000000000000..f939527ede77
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/btf_tag.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include <test_progs.h>
+#include "tag.skel.h"
+
+void test_btf_tag(void)
+{
+	struct tag *skel;
+
+	skel =3D tag__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "btf_tag"))
+		return;
+	tag__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/tag.c b/tools/testing/self=
tests/bpf/progs/tag.c
new file mode 100644
index 000000000000..17f88c58a6c5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tag.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define __tag1 __attribute__((btf_tag("tag1")))
+#define __tag2 __attribute__((btf_tag("tag2")))
+
+struct key_t {
+	int a;
+	int b __tag1 __tag2;
+	int c;
+} __tag1 __tag2;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 3);
+	__type(key, struct key_t);
+	__type(value, __u64);
+} hashmap1 SEC(".maps");
+
+__u32 total __tag1 __tag2 =3D 0;
+
+static __noinline int foo(int x __tag1 __tag2) __tag1 __tag2
+{
+	struct key_t key;
+	__u64 val =3D 1;
+
+	key.a =3D key.b =3D key.c =3D x;
+	bpf_map_update_elem(&hashmap1, &key, &val, 0);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(sub, int x)
+{
+	return foo(x);
+}
--=20
2.30.2

