Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37107516745
	for <lists+bpf@lfdr.de>; Sun,  1 May 2022 21:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350991AbiEATEc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 1 May 2022 15:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351379AbiEATE3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 1 May 2022 15:04:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1FA33A21
        for <bpf@vger.kernel.org>; Sun,  1 May 2022 12:01:00 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 241DUFrH030146
        for <bpf@vger.kernel.org>; Sun, 1 May 2022 12:01:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=G8DEWpWB1y1Ov+VehyLGBM0hP4ObaxlnbEB2G5hjBRM=;
 b=mAc2lEN62Votobq3iY5CmtU2Bms6Gfj3dTDO4CYBWOJajpN3Qex4/jHSvIxwxAQ7b41T
 smMrV41D2CiM4xKpCSt/VTs2gxNEyJUTb21WVEgWCQbrc68o6Yt6pW7d1Kt6BLgUWOqI
 EbZNqdqu9bMyZ8lU/lCaKZXskWgPeMlwSXE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fs27rdsh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 01 May 2022 12:01:00 -0700
Received: from twshared8053.07.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 1 May 2022 12:00:58 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id AB6A49C01F9E; Sun,  1 May 2022 12:00:54 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 10/12] selftests/bpf: add a test for enum64 value relocation
Date:   Sun, 1 May 2022 12:00:54 -0700
Message-ID: <20220501190054.2580458-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220501190002.2576452-1-yhs@fb.com>
References: <20220501190002.2576452-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: CLj31BYe7VWJI1WKikiC-3Ewf5wzGqhX
X-Proofpoint-ORIG-GUID: CLj31BYe7VWJI1WKikiC-3Ewf5wzGqhX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-01_07,2022-04-28_01,2022-02-23_01
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
 .../selftests/bpf/prog_tests/core_reloc.c     | 43 +++++++++++++++
 .../bpf/progs/btf__core_reloc_enum64val.c     |  3 ++
 .../progs/btf__core_reloc_enum64val___diff.c  |  3 ++
 .../btf__core_reloc_enum64val___err_missing.c |  3 ++
 ...btf__core_reloc_enum64val___val3_missing.c |  3 ++
 .../selftests/bpf/progs/core_reloc_types.h    | 47 ++++++++++++++++
 .../bpf/progs/test_core_reloc_enum64val.c     | 53 +++++++++++++++++++
 7 files changed, 155 insertions(+)
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
index f28f75aa9154..b0054f16c9cd 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -355,6 +355,25 @@ static int duration =3D 0;
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
@@ -822,6 +841,30 @@ static const struct core_reloc_test_case test_cases[=
] =3D {
 		.anon_val2 =3D 0x222,
 	}),
 	ENUMVAL_ERR_CASE(enumval___err_missing),
+
+	/* 64bit enumerator value existence and value relocations */
+	ENUM64VAL_CASE(enum64val, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D true,
+		.named_val1 =3D 0x1ffffffffULL,
+		.named_val2 =3D 0x2,
+	}),
+	ENUM64VAL_CASE(enum64val___diff, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D true,
+		.named_val1 =3D 0x101ffffffffULL,
+		.named_val2 =3D 0x202ffffffffULL,
+	}),
+	ENUM64VAL_CASE(enum64val___val3_missing, {
+		.named_val1_exists =3D true,
+		.named_val2_exists =3D true,
+		.named_val3_exists =3D false,
+		.named_val1 =3D 0x111ffffffffULL,
+		.named_val2 =3D 0x222,
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
index c95c0cabe951..e6e12a93514b 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -1099,6 +1099,15 @@ struct core_reloc_enumval_output {
 	int anon_val2;
 };
=20
+struct core_reloc_enum64val_output {
+	bool named_val1_exists;
+	bool named_val2_exists;
+	bool named_val3_exists;
+
+	long named_val1;
+	long named_val2;
+};
+
 enum named_enum {
 	NAMED_ENUM_VAL1 =3D 1,
 	NAMED_ENUM_VAL2 =3D 2,
@@ -1116,6 +1125,16 @@ struct core_reloc_enumval {
 	anon_enum f2;
 };
=20
+enum named_enum64 {
+	NAMED_ENUM64_VAL1 =3D 0x1ffffffffULL,
+	NAMED_ENUM64_VAL2 =3D 0x2,
+	NAMED_ENUM64_VAL3 =3D 0x3ffffffffULL,
+};
+
+struct core_reloc_enum64val {
+	enum named_enum64 f1;
+};
+
 /* differing enumerator values */
 enum named_enum___diff {
 	NAMED_ENUM_VAL1___diff =3D 101,
@@ -1134,6 +1153,16 @@ struct core_reloc_enumval___diff {
 	anon_enum___diff f2;
 };
=20
+enum named_enum64___diff {
+	NAMED_ENUM64_VAL1___diff =3D 0x101ffffffffULL,
+	NAMED_ENUM64_VAL2___diff =3D 0x202ffffffffULL,
+	NAMED_ENUM64_VAL3___diff =3D 0x303ffffffffULL,
+};
+
+struct core_reloc_enum64val___diff {
+	enum named_enum64___diff f1;
+};
+
 /* missing (optional) third enum value */
 enum named_enum___val3_missing {
 	NAMED_ENUM_VAL1___val3_missing =3D 111,
@@ -1150,6 +1179,15 @@ struct core_reloc_enumval___val3_missing {
 	anon_enum___val3_missing f2;
 };
=20
+enum named_enum64___val3_missing {
+	NAMED_ENUM64_VAL1___val3_missing =3D 0x111ffffffffULL,
+	NAMED_ENUM64_VAL2___val3_missing =3D 0x222,
+};
+
+struct core_reloc_enum64val___val3_missing {
+	enum named_enum64___val3_missing f1;
+};
+
 /* missing (mandatory) second enum value, should fail */
 enum named_enum___err_missing {
 	NAMED_ENUM_VAL1___err_missing =3D 1,
@@ -1165,3 +1203,12 @@ struct core_reloc_enumval___err_missing {
 	enum named_enum___err_missing f1;
 	anon_enum___err_missing f2;
 };
+
+enum named_enum64___err_missing {
+	NAMED_ENUM64_VAL1___err_missing =3D 0x1ffffffffULL,
+	NAMED_ENUM64_VAL3___err_missing =3D 0x3ffffffffULL,
+};
+
+struct core_reloc_enum64val___err_missing {
+	enum named_enum64___err_missing f1;
+};
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.=
c b/tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.c
new file mode 100644
index 000000000000..1bccf9214547
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_enum64val.c
@@ -0,0 +1,53 @@
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
+enum named_enum64 {
+	NAMED_ENUM64_VAL1 =3D 0x1ffffffffULL,
+	NAMED_ENUM64_VAL2 =3D 0x2ffffffffULL,
+	NAMED_ENUM64_VAL3 =3D 0x3ffffffffULL,
+};
+
+struct core_reloc_enum64val_output {
+	bool named_val1_exists;
+	bool named_val2_exists;
+	bool named_val3_exists;
+
+	long named_val1;
+	long named_val2;
+};
+
+SEC("raw_tracepoint/sys_enter")
+int test_core_enum64val(void *ctx)
+{
+#if __has_builtin(__builtin_preserve_enum_value)
+	struct core_reloc_enum64val_output *out =3D (void *)&data.out;
+	enum named_enum64 named =3D 0;
+
+	out->named_val1_exists =3D bpf_core_enum_value_exists(named, NAMED_ENUM=
64_VAL1);
+	out->named_val2_exists =3D bpf_core_enum_value_exists(enum named_enum64=
, NAMED_ENUM64_VAL2);
+	out->named_val3_exists =3D bpf_core_enum_value_exists(enum named_enum64=
, NAMED_ENUM64_VAL3);
+
+	out->named_val1 =3D bpf_core_enum_value(named, NAMED_ENUM64_VAL1);
+	out->named_val2 =3D bpf_core_enum_value(named, NAMED_ENUM64_VAL2);
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

