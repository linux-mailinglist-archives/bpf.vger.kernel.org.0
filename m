Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6DC854B8
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389581AbfHGUtV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 16:49:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41338 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389551AbfHGUtL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 16:49:11 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77KcgXi012496
        for <bpf@vger.kernel.org>; Wed, 7 Aug 2019 13:49:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=v/XKrRs9YHMncx3lFFdKDgBbAKO8LkI9J72eQYYn5kU=;
 b=K8PgRVBEjUovMEkcpMph11HyNP8Xgx7RsK8swVBr9HKGmSwVh2hwTaeMRlZgs+apfWcU
 vAJoP0ORiHVfnDnZRJXzVCRJJaA695OHSCdsi+di47M7nNK3GF+oDEc35n24PA9Hf2fE
 seNMBLFSY7RRYtDslX7pkvaS7EEtYXguH4g= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2u80f8sbhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 13:49:10 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 7 Aug 2019 13:49:09 -0700
Received: by dev101.prn2.facebook.com (Postfix, from userid 137359)
        id 71F9386167B; Wed,  7 Aug 2019 13:49:08 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: dev101.prn2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v5 bpf-next 11/14] selftests/bpf: add CO-RE relocs modifiers/typedef tests
Date:   Wed, 7 Aug 2019 13:48:40 -0700
Message-ID: <20190807204843.513594-12-andriin@fb.com>
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

Add tests validating correct handling of various combinations of
typedefs and const/volatile/restrict modifiers.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: Song Liu <songliubraving@fb.com>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 27 +++++++
 .../bpf/progs/btf__core_reloc_mods.c          |  3 +
 .../progs/btf__core_reloc_mods___mod_swap.c   |  3 +
 .../progs/btf__core_reloc_mods___typedefs.c   |  3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 72 +++++++++++++++++++
 .../bpf/progs/test_core_reloc_mods.c          | 62 ++++++++++++++++
 6 files changed, 170 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_mods.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_mods___mod_swap.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_mods___typedefs.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_mods.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 37b36df93ded..9dadf462a951 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -107,6 +107,28 @@
 	.fails = true,							\
 }
 
+#define MODS_CASE(name) {						\
+	.case_name = #name,						\
+	.bpf_obj_file = "test_core_reloc_mods.o",			\
+	.btf_src_file = "btf__core_reloc_" #name ".o",			\
+	.input = STRUCT_TO_CHAR_PTR(core_reloc_##name) {		\
+		.a = 1,							\
+		.b = 2,							\
+		.c = (void *)3,						\
+		.d = (void *)4,						\
+		.e = { [2] = 5 },					\
+		.f = { [1] = 6 },					\
+		.g = { .x = 7 },					\
+		.h = { .y = 8 },					\
+	},								\
+	.input_len = sizeof(struct core_reloc_##name),			\
+	.output = STRUCT_TO_CHAR_PTR(core_reloc_mods_output) {		\
+		.a = 1, .b = 2, .c = 3, .d = 4,				\
+		.e = 5, .f = 6, .g = 7, .h = 8,				\
+	},								\
+	.output_len = sizeof(struct core_reloc_mods_output),		\
+}
+
 struct core_reloc_test_case {
 	const char *case_name;
 	const char *bpf_obj_file;
@@ -173,6 +195,11 @@ static struct core_reloc_test_case test_cases[] = {
 	PRIMITIVES_ERR_CASE(primitives___err_non_enum),
 	PRIMITIVES_ERR_CASE(primitives___err_non_int),
 	PRIMITIVES_ERR_CASE(primitives___err_non_ptr),
+
+	/* const/volatile/restrict and typedefs scenarios */
+	MODS_CASE(mods),
+	MODS_CASE(mods___mod_swap),
+	MODS_CASE(mods___typedefs),
 };
 
 struct data {
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_mods.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_mods.c
new file mode 100644
index 000000000000..124197a2e813
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_mods.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_mods x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_mods___mod_swap.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_mods___mod_swap.c
new file mode 100644
index 000000000000..f8a6592ca75f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_mods___mod_swap.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_mods___mod_swap x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_mods___typedefs.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_mods___typedefs.c
new file mode 100644
index 000000000000..5c0d73687247
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_mods___typedefs.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_mods___typedefs x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index 7526a5f5755b..3401e8342e57 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -454,3 +454,75 @@ struct core_reloc_primitives___err_non_ptr {
 	int d; /* int instead of ptr */
 	int (*f)(const char *);
 };
+
+/*
+ * MODS
+ */
+struct core_reloc_mods_output {
+	int a, b, c, d, e, f, g, h;
+};
+
+typedef const int int_t;
+typedef const char *char_ptr_t;
+typedef const int arr_t[7];
+
+struct core_reloc_mods_substruct {
+	int x;
+	int y;
+};
+
+typedef struct {
+	int x;
+	int y;
+} core_reloc_mods_substruct_t;
+
+struct core_reloc_mods {
+	int a;
+	int_t b;
+	char *c;
+	char_ptr_t d;
+	int e[3];
+	arr_t f;
+	struct core_reloc_mods_substruct g;
+	core_reloc_mods_substruct_t h;
+};
+
+/* a/b, c/d, e/f, and g/h pairs are swapped */
+struct core_reloc_mods___mod_swap {
+	int b;
+	int_t a;
+	char *d;
+	char_ptr_t c;
+	int f[3];
+	arr_t e;
+	struct {
+		int y;
+		int x;
+	} h;
+	core_reloc_mods_substruct_t g;
+};
+
+typedef int int1_t;
+typedef int1_t int2_t;
+typedef int2_t int3_t;
+
+typedef int arr1_t[5];
+typedef arr1_t arr2_t;
+typedef arr2_t arr3_t;
+typedef arr3_t arr4_t;
+
+typedef const char * const volatile restrict fancy_char_ptr_t;
+
+typedef core_reloc_mods_substruct_t core_reloc_mods_substruct_tt;
+
+/* we need more typedefs */
+struct core_reloc_mods___typedefs {
+	core_reloc_mods_substruct_tt g;
+	core_reloc_mods_substruct_tt h;
+	arr4_t f;
+	arr4_t e;
+	fancy_char_ptr_t d;
+	fancy_char_ptr_t c;
+	int3_t b;
+	int3_t a;
+};
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c b/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
new file mode 100644
index 000000000000..f98b942c062b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_mods.c
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
+struct core_reloc_mods_output {
+	int a, b, c, d, e, f, g, h;
+};
+
+typedef const int int_t;
+typedef const char *char_ptr_t;
+typedef const int arr_t[7];
+
+struct core_reloc_mods_substruct {
+	int x;
+	int y;
+};
+
+typedef struct {
+	int x;
+	int y;
+} core_reloc_mods_substruct_t;
+
+struct core_reloc_mods {
+	int a;
+	int_t b;
+	char *c;
+	char_ptr_t d;
+	int e[3];
+	arr_t f;
+	struct core_reloc_mods_substruct g;
+	core_reloc_mods_substruct_t h;
+};
+
+SEC("raw_tracepoint/sys_enter")
+int test_core_mods(void *ctx)
+{
+	struct core_reloc_mods *in = (void *)&data.in;
+	struct core_reloc_mods_output *out = (void *)&data.out;
+
+	if (BPF_CORE_READ(&out->a, &in->a) ||
+	    BPF_CORE_READ(&out->b, &in->b) ||
+	    BPF_CORE_READ(&out->c, &in->c) ||
+	    BPF_CORE_READ(&out->d, &in->d) ||
+	    BPF_CORE_READ(&out->e, &in->e[2]) ||
+	    BPF_CORE_READ(&out->f, &in->f[1]) ||
+	    BPF_CORE_READ(&out->g, &in->g.x) ||
+	    BPF_CORE_READ(&out->h, &in->h.y))
+		return 1;
+
+	return 0;
+}
+
-- 
2.17.1

