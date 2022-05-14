Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D7526E91
	for <lists+bpf@lfdr.de>; Sat, 14 May 2022 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiENDOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 May 2022 23:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiENDN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 23:13:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22D234A966
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:57 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24DNXanE016943
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=Uves9wPr2LNkAdg6tnpMUOX9Ui3iE1IjKNcBUt11Cd8=;
 b=LuZqZZIhloZrqEdW5P5Sn4hp8z9itopdYx5Kp18ADfZ6FDQvusiW5DRsvvBq6fVYkYtY
 e/UJ0NlFRSo2h6KiaGPMAN0CxgjgEQE5l5pPvXzMdhUsQKI+5XJrDsaAAMRsdEy6tQcl
 B23a6BGoWLJiGyf9fK2tUz9uRnjffoWOGTw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g1cxefsv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:13:56 -0700
Received: from twshared10276.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 20:13:56 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id BCD66A45F6D4; Fri, 13 May 2022 20:13:45 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 16/18] selftests/bpf: Add a test for enum64 value relocations
Date:   Fri, 13 May 2022 20:13:45 -0700
Message-ID: <20220514031345.3246727-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514031221.3240268-1-yhs@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -_w5Bbn7zpBpJDfNo-7AnvU9gCzioIPy
X-Proofpoint-GUID: -_w5Bbn7zpBpJDfNo-7AnvU9gCzioIPy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-13_11,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a test for enum64 value relocations.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 58 ++++++++++++++
 .../bpf/progs/btf__core_reloc_enum64val.c     |  3 +
 .../progs/btf__core_reloc_enum64val___diff.c  |  3 +
 .../btf__core_reloc_enum64val___err_missing.c |  3 +
 ...btf__core_reloc_enum64val___val3_missing.c |  3 +
 .../selftests/bpf/progs/core_reloc_types.h    | 78 +++++++++++++++++++
 .../bpf/progs/test_core_reloc_enum64val.c     | 70 +++++++++++++++++
 7 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val___diff.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val___err_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_enu=
m64val___val3_missing.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_core_reloc_enu=
m64val.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index 3712dfe1be59..47c1ef117275 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -363,6 +363,25 @@ static int duration =3D 0;
 	.fails =3D true,							\
 }
=20
+#define ENUM64VAL_CASE_COMMON(name)					\
+	.case_name =3D #name,						\
+	.bpf_obj_file =3D "test_core_reloc_enum64val.o",			\
+	.btf_src_file =3D "btf__core_reloc_" #name ".o",			\
+	.raw_tp_name =3D "sys_enter",					\
+	.prog_name =3D "test_core_enum64val"
+
+#define ENUM64VAL_CASE(name, ...) {					\
+	ENUM64VAL_CASE_COMMON(name),					\
+	.output =3D STRUCT_TO_CHAR_PTR(core_reloc_enum64val_output)	\
+			__VA_ARGS__,					\
+	.output_len =3D sizeof(struct core_reloc_enum64val_output),	\
+}
+
+#define ENUM64VAL_ERR_CASE(name) {					\
+	ENUM64VAL_CASE_COMMON(name),					\
+	.fails =3D true,							\
+}
+
 struct core_reloc_test_case;
=20
 typedef int (*setup_test_fn)(struct core_reloc_test_case *test);
@@ -831,6 +850,45 @@ static const struct core_reloc_test_case test_cases[=
] =3D {
 		.anon_val2 =3D 0x222,
 	}),
 	ENUMVAL_ERR_CASE(enumval___err_missing),
+
+	/* 64bit enumerator value existence and value relocations */
+	ENUM64VAL_CASE(enum64val, {
+		.unsigned_val1_exists =3D true,
+		.unsigned_val2_exists =3D true,
+		.unsigned_val3_exists =3D true,
+		.signed_val1_exists =3D true,
+		.signed_val2_exists =3D true,
+		.signed_val3_exists =3D true,
+		.unsigned_val1 =3D 0x1ffffffffULL,
+		.unsigned_val2 =3D 0x2,
+		.signed_val1 =3D 0x1ffffffffLL,
+		.signed_val2 =3D -2,
+	}),
+	ENUM64VAL_CASE(enum64val___diff, {
+		.unsigned_val1_exists =3D true,
+		.unsigned_val2_exists =3D true,
+		.unsigned_val3_exists =3D true,
+		.signed_val1_exists =3D true,
+		.signed_val2_exists =3D true,
+		.signed_val3_exists =3D true,
+		.unsigned_val1 =3D 0x101ffffffffULL,
+		.unsigned_val2 =3D 0x202ffffffffULL,
+		.signed_val1 =3D -101,
+		.signed_val2 =3D -202,
+	}),
+	ENUM64VAL_CASE(enum64val___val3_missing, {
+		.unsigned_val1_exists =3D true,
+		.unsigned_val2_exists =3D true,
+		.unsigned_val3_exists =3D false,
+		.signed_val1_exists =3D true,
+		.signed_val2_exists =3D true,
+		.signed_val3_exists =3D false,
+		.unsigned_val1 =3D 0x111ffffffffULL,
+		.unsigned_val2 =3D 0x222,
+		.signed_val1 =3D 0x111ffffffffLL,
+		.signed_val2 =3D -222,
+	}),
+	ENUM64VAL_ERR_CASE(enum64val___err_missing),
 };
=20
 struct data {
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val.=
c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val.c
new file mode 100644
index 000000000000..888e79db6a77
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enum64val x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val_=
__diff.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___=
diff.c
new file mode 100644
index 000000000000..194749130d87
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___diff.=
c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enum64val___diff x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val_=
__err_missing.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum6=
4val___err_missing.c
new file mode 100644
index 000000000000..3d732d4193e4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___err_m=
issing.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enum64val___err_missing x) {}
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val_=
__val3_missing.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum=
64val___val3_missing.c
new file mode 100644
index 000000000000..17cf5d6a848d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_enum64val___val3_=
missing.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_enum64val___val3_missing x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
index f9dc9766546e..26e103302c05 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -1117,6 +1117,20 @@ struct core_reloc_enumval_output {
 	int anon_val2;
 };
=20
+struct core_reloc_enum64val_output {
+	bool unsigned_val1_exists;
+	bool unsigned_val2_exists;
+	bool unsigned_val3_exists;
+	bool signed_val1_exists;
+	bool signed_val2_exists;
+	bool signed_val3_exists;
+
+	long unsigned_val1;
+	long unsigned_val2;
+	long signed_val1;
+	long signed_val2;
+};
+
 enum named_enum {
 	NAMED_ENUM_VAL1 =3D 1,
 	NAMED_ENUM_VAL2 =3D 2,
@@ -1134,6 +1148,23 @@ struct core_reloc_enumval {
 	anon_enum f2;
 };
=20
+enum named_unsigned_enum64 {
+	UNSIGNED_ENUM64_VAL1 =3D 0x1ffffffffULL,
+	UNSIGNED_ENUM64_VAL2 =3D 0x2,
+	UNSIGNED_ENUM64_VAL3 =3D 0x3ffffffffULL,
+};
+
+enum named_signed_enum64 {
+	SIGNED_ENUM64_VAL1 =3D 0x1ffffffffLL,
+	SIGNED_ENUM64_VAL2 =3D -2,
+	SIGNED_ENUM64_VAL3 =3D 0x3ffffffffLL,
+};
+
+struct core_reloc_enum64val {
+	enum named_unsigned_enum64 f1;
+	enum named_signed_enum64 f2;
+};
+
 /* differing enumerator values */
 enum named_enum___diff {
 	NAMED_ENUM_VAL1___diff =3D 101,
@@ -1152,6 +1183,23 @@ struct core_reloc_enumval___diff {
 	anon_enum___diff f2;
 };
=20
+enum named_unsigned_enum64___diff {
+	UNSIGNED_ENUM64_VAL1___diff =3D 0x101ffffffffULL,
+	UNSIGNED_ENUM64_VAL2___diff =3D 0x202ffffffffULL,
+	UNSIGNED_ENUM64_VAL3___diff =3D 0x303ffffffffULL,
+};
+
+enum named_signed_enum64___diff {
+	SIGNED_ENUM64_VAL1___diff =3D -101,
+	SIGNED_ENUM64_VAL2___diff =3D -202,
+	SIGNED_ENUM64_VAL3___diff =3D -303,
+};
+
+struct core_reloc_enum64val___diff {
+	enum named_unsigned_enum64___diff f1;
+	enum named_signed_enum64___diff f2;
+};
+
 /* missing (optional) third enum value */
 enum named_enum___val3_missing {
 	NAMED_ENUM_VAL1___val3_missing =3D 111,
@@ -1168,6 +1216,21 @@ struct core_reloc_enumval___val3_missing {
 	anon_enum___val3_missing f2;
 };
=20
+enum named_unsigned_enum64___val3_missing {
+	UNSIGNED_ENUM64_VAL1___val3_missing =3D 0x111ffffffffULL,
+	UNSIGNED_ENUM64_VAL2___val3_missing =3D 0x222,
+};
+
+enum named_signed_enum64___val3_missing {
+	SIGNED_ENUM64_VAL1___val3_missing =3D 0x111ffffffffLL,
+	SIGNED_ENUM64_VAL2___val3_missing =3D -222,
+};
+
+struct core_reloc_enum64val___val3_missing {
+	enum named_unsigned_enum64___val3_missing f1;
+	enum named_signed_enum64___val3_missing f2;
+};
+
 /* missing (mandatory) second enum value, should fail */
 enum named_enum___err_missing {
 	NAMED_ENUM_VAL1___err_missing =3D 1,
@@ -1183,3 +1246,18 @@ struct core_reloc_enumval___err_missing {
 	enum named_enum___err_missing f1;
 	anon_enum___err_missing f2;
 };
+
+enum named_unsigned_enum64___err_missing {
+	UNSIGNED_ENUM64_VAL1___err_missing =3D 0x1ffffffffULL,
+	UNSIGNED_ENUM64_VAL3___err_missing =3D 0x3ffffffffULL,
+};
+
+enum named_signed_enum64___err_missing {
+	SIGNED_ENUM64_VAL1___err_missing =3D 0x1ffffffffLL,
+	SIGNED_ENUM64_VAL3___err_missing =3D -3,
+};
+
+struct core_reloc_enum64val___err_missing {
+	enum named_unsigned_enum64___err_missing f1;
+	enum named_signed_enum64___err_missing f2;
+};
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.=
c b/tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.c
new file mode 100644
index 000000000000..820f4e1b8f30
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
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
+enum named_unsigned_enum64 {
+	UNSIGNED_ENUM64_VAL1 =3D 0x1ffffffffULL,
+	UNSIGNED_ENUM64_VAL2 =3D 0x2ffffffffULL,
+	UNSIGNED_ENUM64_VAL3 =3D 0x3ffffffffULL,
+};
+
+enum named_signed_enum64 {
+	SIGNED_ENUM64_VAL1 =3D 0x1ffffffffLL,
+	SIGNED_ENUM64_VAL2 =3D -2,
+	SIGNED_ENUM64_VAL3 =3D 0x3ffffffffLL,
+};
+
+struct core_reloc_enum64val_output {
+	bool unsigned_val1_exists;
+	bool unsigned_val2_exists;
+	bool unsigned_val3_exists;
+	bool signed_val1_exists;
+	bool signed_val2_exists;
+	bool signed_val3_exists;
+
+	long unsigned_val1;
+	long unsigned_val2;
+	long signed_val1;
+	long signed_val2;
+};
+
+SEC("raw_tracepoint/sys_enter")
+int test_core_enum64val(void *ctx)
+{
+#if __has_builtin(__builtin_preserve_enum_value)
+	struct core_reloc_enum64val_output *out =3D (void *)&data.out;
+	enum named_unsigned_enum64 named_unsigned =3D 0;
+	enum named_signed_enum64 named_signed =3D 0;
+
+	out->unsigned_val1_exists =3D bpf_core_enum_value_exists(named_unsigned=
, UNSIGNED_ENUM64_VAL1);
+	out->unsigned_val2_exists =3D bpf_core_enum_value_exists(enum named_uns=
igned_enum64, UNSIGNED_ENUM64_VAL2);
+	out->unsigned_val3_exists =3D bpf_core_enum_value_exists(enum named_uns=
igned_enum64, UNSIGNED_ENUM64_VAL3);
+	out->signed_val1_exists =3D bpf_core_enum_value_exists(named_signed, SI=
GNED_ENUM64_VAL1);
+	out->signed_val2_exists =3D bpf_core_enum_value_exists(enum named_signe=
d_enum64, SIGNED_ENUM64_VAL2);
+	out->signed_val3_exists =3D bpf_core_enum_value_exists(enum named_signe=
d_enum64, SIGNED_ENUM64_VAL3);
+
+	out->unsigned_val1 =3D bpf_core_enum_value(named_unsigned, UNSIGNED_ENU=
M64_VAL1);
+	out->unsigned_val2 =3D bpf_core_enum_value(named_unsigned, UNSIGNED_ENU=
M64_VAL2);
+	out->signed_val1 =3D bpf_core_enum_value(named_signed, SIGNED_ENUM64_VA=
L1);
+	out->signed_val2 =3D bpf_core_enum_value(named_signed, SIGNED_ENUM64_VA=
L2);
+	/* NAMED_ENUM64_VAL3 value is optional */
+
+#else
+	data.skip =3D true;
+#endif
+
+	return 0;
+}
--=20
2.30.2

