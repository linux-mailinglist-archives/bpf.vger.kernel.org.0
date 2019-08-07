Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2671A854AE
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389524AbfHGUtD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 16:49:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389340AbfHGUtD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 16:49:03 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x77KdeZY009947
        for <bpf@vger.kernel.org>; Wed, 7 Aug 2019 13:49:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=k+YSQbFSi98i0H3wYu9qdA58YpKseAiuHui3DkMCjIY=;
 b=TCUDKBiHK+kJ7WrKQ7eHuRC+PeOAntGpWcS5/FHgbyt3t8bpKZPOaDxuDOtMmK36W59n
 zGGY5KC04taUoSXDPfnbTJ0AaJd0KrSEIe84qXsFgI9piGdYv3z/9mQvF7uYJZEiHd58
 kDSPuhPErDgpdfudiawfRM+qcfXw23YuxAA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2u7xhahr5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 13:49:01 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Aug 2019 13:49:00 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 4232686167B; Wed,  7 Aug 2019 13:49:00 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 07/14] selftests/bpf: add CO-RE relocs struct flavors tests
Date:   Wed, 7 Aug 2019 13:48:36 -0700
Message-ID: <20190807204843.513594-8-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190807204843.513594-1-andriin@fb.com>
References: <20190807204843.513594-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=67 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070179
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests verifying that BPF program can use various struct/union
"flavors" to extract data from the same target struct/union.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 34 ++++++++++
 .../bpf/progs/btf__core_reloc_flavors.c       |  3 +
 .../btf__core_reloc_flavors__err_wrong_name.c |  3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 15 +++++
 .../bpf/progs/test_core_reloc_flavors.c       | 62 +++++++++++++++++++
 5 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_flavors.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_flavors__err_wrong_name.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_reloc_types.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_flavors.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 4323a459c8a2..59fd9cb207ab 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -1,5 +1,32 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "progs/core_reloc_types.h"
+
+#define STRUCT_TO_CHAR_PTR(struct_name) (const char *)&(struct struct_name)
+
+#define FLAVORS_DATA(struct_name) STRUCT_TO_CHAR_PTR(struct_name) {	\
+	.a = 42,							\
+	.b = 0xc001,							\
+	.c = 0xbeef,							\
+}
+
+#define FLAVORS_CASE_COMMON(name)					\
+	.case_name = #name,						\
+	.bpf_obj_file = "test_core_reloc_flavors.o",			\
+	.btf_src_file = "btf__core_reloc_" #name ".o"			\
+
+#define FLAVORS_CASE(name) {						\
+	FLAVORS_CASE_COMMON(name),					\
+	.input = FLAVORS_DATA(core_reloc_##name),			\
+	.input_len = sizeof(struct core_reloc_##name),			\
+	.output = FLAVORS_DATA(core_reloc_flavors),			\
+	.output_len = sizeof(struct core_reloc_flavors),		\
+}
+
+#define FLAVORS_ERR_CASE(name) {					\
+	FLAVORS_CASE_COMMON(name),					\
+	.fails = true,							\
+}
 
 struct core_reloc_test_case {
 	const char *case_name;
@@ -23,6 +50,13 @@ static struct core_reloc_test_case test_cases[] = {
 		.output = "\1", /* true */
 		.output_len = 1,
 	},
+
+	/* validate BPF program can use multiple flavors to match against
+	 * single target BTF type
+	 */
+	FLAVORS_CASE(flavors),
+
+	FLAVORS_ERR_CASE(flavors__err_wrong_name),
 };
 
 struct data {
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_flavors.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_flavors.c
new file mode 100644
index 000000000000..b74455b91227
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_flavors.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_flavors x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_flavors__err_wrong_name.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_flavors__err_wrong_name.c
new file mode 100644
index 000000000000..7b6035f86ee6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_flavors__err_wrong_name.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_flavors__err_wrong_name x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
new file mode 100644
index 000000000000..33b0c6a61912
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -0,0 +1,15 @@
+/*
+ * FLAVORS
+ */
+struct core_reloc_flavors {
+	int a;
+	int b;
+	int c;
+};
+
+/* this is not a flavor, as it doesn't have triple underscore */
+struct core_reloc_flavors__err_wrong_name {
+	int a;
+	int b;
+	int c;
+};
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_flavors.c b/tools/testing/selftests/bpf/progs/test_core_reloc_flavors.c
new file mode 100644
index 000000000000..9fda73e87972
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_flavors.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Facebook
+
+#include <linux/bpf.h>
+#include <stdint.h>
+#include "bpf_helpers.h"
+
+char _license[] SEC("license") = "GPL";
+
+static volatile struct data {
+	char in[256];
+	char out[256];
+} data;
+
+struct core_reloc_flavors {
+	int a;
+	int b;
+	int c;
+};
+
+/* local flavor with reversed layout */
+struct core_reloc_flavors___reversed {
+	int c;
+	int b;
+	int a;
+};
+
+/* local flavor with nested/overlapping layout */
+struct core_reloc_flavors___weird {
+	struct {
+		int b;
+	};
+	/* a and c overlap in local flavor, but this should still work
+	 * correctly with target original flavor
+	 */
+	union {
+		int a;
+		int c;
+	};
+};
+
+SEC("raw_tracepoint/sys_enter")
+int test_core_flavors(void *ctx)
+{
+	struct core_reloc_flavors *in_orig = (void *)&data.in;
+	struct core_reloc_flavors___reversed *in_rev = (void *)&data.in;
+	struct core_reloc_flavors___weird *in_weird = (void *)&data.in;
+	struct core_reloc_flavors *out = (void *)&data.out;
+
+	/* read a using weird layout */
+	if (BPF_CORE_READ(&out->a, &in_weird->a))
+		return 1;
+	/* read b using reversed layout */
+	if (BPF_CORE_READ(&out->b, &in_rev->b))
+		return 1;
+	/* read c using original layout */
+	if (BPF_CORE_READ(&out->c, &in_orig->c))
+		return 1;
+
+	return 0;
+}
+
-- 
2.17.1

