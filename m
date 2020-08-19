Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FC624946E
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 07:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgHSF3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 01:29:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgHSF3Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 01:29:16 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 07J5S3hK020276
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 22:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=193pnoSgsTskf9GUQRWXue3Fyche+mq0EDJzQ1RZQX0=;
 b=hmGiou0M5ACCH+toAIUdVm8R7944qeC5y8qArzG2RNNB1iQSGbw1FBnO8KqkAm2YinH4
 nisSw5WVfo3keUM6aLbzaybqK8xWNVaEU+LnGC5+SXvdokey9RxgCKimBwjSm+xBKyKo
 tMOC/245tLwqX4IxkVgtB3QEpv6+PCRXnQY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3304jj6rp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2020 22:29:13 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 18 Aug 2020 22:29:12 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 29BD92EC5C14; Tue, 18 Aug 2020 22:29:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: add tests for ENUMVAL_EXISTS/ENUMVAL_VALUE relocations
Date:   Tue, 18 Aug 2020 22:28:49 -0700
Message-ID: <20200819052849.336700-6-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200819052849.336700-1-andriin@fb.com>
References: <20200819052849.336700-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-19_03:2020-08-18,2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=8
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190046
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add tests validating existence and value relocations for enum value-based
relocations. If __builtin_preserve_enum_value() built-in is not supported=
,
skip tests.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 56 +++++++++++++
 .../bpf/progs/btf__core_reloc_enumval.c       |  3 +
 .../progs/btf__core_reloc_enumval___diff.c    |  3 +
 .../btf__core_reloc_enumval___err_missing.c   |  3 +
 .../btf__core_reloc_enumval___val3_missing.c  |  3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 84 +++++++++++++++++++
 .../bpf/progs/test_core_reloc_enumval.c       | 73 ++++++++++++++++
 7 files changed, 225 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___err_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
mval___val3_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_enu=
mval.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index ad550510ef69..30e40ff4b0d8 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -289,6 +289,23 @@ static int duration =3D 0;
 	.fails =3D true,							\
 }
=20
+#define ENUMVAL_CASE_COMMON(name)					\
+	.case_name =3D #name,						\
+	.bpf_obj_file =3D "test_core_reloc_enumval.o",			\
+	.btf_src_file =3D "btf__core_reloc_" #name ".o"			\
+
+#define ENUMVAL_CASE(name, ...) {					\
+	ENUMVAL_CASE_COMMON(name),					\
+	.output =3D STRUCT_TO_CHAR_PTR(core_reloc_enumval_output)		\
+			__VA_ARGS__,					\
+	.output_len =3D sizeof(struct core_reloc_enumval_output),		\
+}
+
+#define ENUMVAL_ERR_CASE(name) {					\
+	ENUMVAL_CASE_COMMON(name),					\
+	.fails =3D true,							\
+}
+
 struct core_reloc_test_case;
=20
 typedef int (*setup_test_fn)(struct core_reloc_test_case *test);
@@ -686,6 +703,45 @@ static struct core_reloc_test_case test_cases[] =3D =
{
 	/* BTF_TYPE_ID_LOCAL/BTF_TYPE_ID_TARGET tests */
 	TYPE_ID_CASE(type_id, setup_type_id_case_success),
 	TYPE_ID_CASE(type_id___missing_targets, setup_type_id_case_failure),
+
+	/* Enumerator value existence and value relocations */
+	ENUMVAL_CASE(enumval, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D true,
+		.anon_val1_exists =3D true,
+		.anon_val2_exists =3D true,
+		.anon_val3_exists =3D true,
+		.named_val1 =3D 1,
+		.named_val2 =3D 2,
+		.anon_val1 =3D 0x10,
+		.anon_val2 =3D 0x20,
+	}),
+	ENUMVAL_CASE(enumval___diff, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D true,
+		.anon_val1_exists =3D true,
+		.anon_val2_exists =3D true,
+		.anon_val3_exists =3D true,
+		.named_val1 =3D 101,
+		.named_val2 =3D 202,
+		.anon_val1 =3D 0x11,
+		.anon_val2 =3D 0x22,
+	}),
+	ENUMVAL_CASE(enumval___val3_missing, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D false,
+		.anon_val1_exists =3D true,
+		.anon_val2_exists =3D true,
+		.anon_val3_exists =3D false,
+		.named_val1 =3D 111,
+		.named_val2 =3D 222,
+		.anon_val1 =3D 0x111,
+		.anon_val2 =3D 0x222,
+	}),
+	ENUMVAL_ERR_CASE(enumval___err_missing),
 };
=20
 struct data {
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval.c =
b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval.c
new file mode 100644
index 000000000000..48e62f3f074f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
diff.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___diff=
.c
new file mode 100644
index 000000000000..53e5e5a76888
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___diff.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___diff x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
err_missing.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval=
___err_missing.c
new file mode 100644
index 000000000000..d024fb2ac06e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___err_mis=
sing.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___err_missing x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___=
val3_missing.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumva=
l___val3_missing.c
new file mode 100644
index 000000000000..9de6595d250c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enumval___val3_mi=
ssing.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enumval___val3_missing x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
index 10afcc5f219f..e6e616cb7bc9 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -1075,3 +1075,87 @@ struct core_reloc_type_id {
 struct core_reloc_type_id___missing_targets {
 	/* nothing */
 };
+
+/*
+ * ENUMERATOR VALUE EXISTENCE AND VALUE RELOCATION
+ */
+struct core_reloc_enumval_output {
+	bool named_val1_exists;
+	bool named_val2_exists;
+	bool named_val3_exists;
+	bool anon_val1_exists;
+	bool anon_val2_exists;
+	bool anon_val3_exists;
+
+	int named_val1;
+	int named_val2;
+	int anon_val1;
+	int anon_val2;
+};
+
+enum named_enum {
+	NAMED_ENUM_VAL1 =3D 1,
+	NAMED_ENUM_VAL2 =3D 2,
+	NAMED_ENUM_VAL3 =3D 3,
+};
+
+typedef enum {
+	ANON_ENUM_VAL1 =3D 0x10,
+	ANON_ENUM_VAL2 =3D 0x20,
+	ANON_ENUM_VAL3 =3D 0x30,
+} anon_enum;
+
+struct core_reloc_enumval {
+	enum named_enum f1;
+	anon_enum f2;
+};
+
+/* differing enumerator values */
+enum named_enum___diff {
+	NAMED_ENUM_VAL1___diff =3D 101,
+	NAMED_ENUM_VAL2___diff =3D 202,
+	NAMED_ENUM_VAL3___diff =3D 303,
+};
+
+typedef enum {
+	ANON_ENUM_VAL1___diff =3D 0x11,
+	ANON_ENUM_VAL2___diff =3D 0x22,
+	ANON_ENUM_VAL3___diff =3D 0x33,
+} anon_enum___diff;
+
+struct core_reloc_enumval___diff {
+	enum named_enum___diff f1;
+	anon_enum___diff f2;
+};
+
+/* missing (optional) third enum value */
+enum named_enum___val3_missing {
+	NAMED_ENUM_VAL1___val3_missing =3D 111,
+	NAMED_ENUM_VAL2___val3_missing =3D 222,
+};
+
+typedef enum {
+	ANON_ENUM_VAL1___val3_missing =3D 0x111,
+	ANON_ENUM_VAL2___val3_missing =3D 0x222,
+} anon_enum___val3_missing;
+
+struct core_reloc_enumval___val3_missing {
+	enum named_enum___val3_missing f1;
+	anon_enum___val3_missing f2;
+};
+
+/* missing (mandatory) second enum value, should fail */
+enum named_enum___err_missing {
+	NAMED_ENUM_VAL1___err_missing =3D 1,
+	NAMED_ENUM_VAL3___err_missing =3D 3,
+};
+
+typedef enum {
+	ANON_ENUM_VAL1___err_missing =3D 0x111,
+	ANON_ENUM_VAL3___err_missing =3D 0x222,
+} anon_enum___err_missing;
+
+struct core_reloc_enumval___err_missing {
+	enum named_enum___err_missing f1;
+	anon_enum___err_missing f2;
+};
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c =
b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
new file mode 100644
index 000000000000..fa8367e89b9e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enumval.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+
+#include <linux/bpf.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") =3D "GPL";
+
+struct {
+	char in[256];
+	char out[256];
+	bool skip;
+} data =3D {};
+
+enum named_enum {
+	NAMED_ENUM_VAL1 =3D 1,
+	NAMED_ENUM_VAL2 =3D 2,
+	NAMED_ENUM_VAL3 =3D 3,
+};
+
+typedef enum {
+	ANON_ENUM_VAL1 =3D 0x10,
+	ANON_ENUM_VAL2 =3D 0x20,
+	ANON_ENUM_VAL3 =3D 0x30,
+} anon_enum;
+
+struct core_reloc_enumval_output {
+	bool named_val1_exists;
+	bool named_val2_exists;
+	bool named_val3_exists;
+	bool anon_val1_exists;
+	bool anon_val2_exists;
+	bool anon_val3_exists;
+
+	int named_val1;
+	int named_val2;
+	int anon_val1;
+	int anon_val2;
+};
+
+SEC("raw_tracepoint/sys_enter")
+int test_core_enumval(void *ctx)
+{
+#if __has_builtin(__builtin_preserve_enum_value)
+	struct core_reloc_enumval_output *out =3D (void *)&data.out;
+	enum named_enum named =3D 0;
+	anon_enum anon =3D 0;
+
+	out->named_val1_exists =3D bpf_core_enum_value_exists(named, NAMED_ENUM=
_VAL1);
+	out->named_val2_exists =3D bpf_core_enum_value_exists(enum named_enum, =
NAMED_ENUM_VAL2);
+	out->named_val3_exists =3D bpf_core_enum_value_exists(enum named_enum, =
NAMED_ENUM_VAL3);
+
+	out->anon_val1_exists =3D bpf_core_enum_value_exists(anon, ANON_ENUM_VA=
L1);
+	out->anon_val2_exists =3D bpf_core_enum_value_exists(anon_enum, ANON_EN=
UM_VAL2);
+	out->anon_val3_exists =3D bpf_core_enum_value_exists(anon_enum, ANON_EN=
UM_VAL3);
+
+	out->named_val1 =3D bpf_core_enum_value(named, NAMED_ENUM_VAL1);
+	out->named_val2 =3D bpf_core_enum_value(named, NAMED_ENUM_VAL2);
+	/* NAMED_ENUM_VAL3 value is optional */
+
+	out->anon_val1 =3D bpf_core_enum_value(anon, ANON_ENUM_VAL1);
+	out->anon_val2 =3D bpf_core_enum_value(anon, ANON_ENUM_VAL2);
+	/* ANON_ENUM_VAL3 value is optional */
+#else
+	data.skip =3D true;
+#endif
+
+	return 0;
+}
+
--=20
2.24.1

