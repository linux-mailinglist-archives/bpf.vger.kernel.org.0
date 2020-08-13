Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDA82434C1
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHMHR4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 03:17:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63636 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbgHMHRw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 03:17:52 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07D7BOcY005909
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 00:17:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vsGbIfBVjfmeWQEtBH7b9ZovMw2naPbz9pZYdjeHFZI=;
 b=WPosc3nQwtB2uykQuWhZfq2smeIxyMAZX+4x8Ho8emhMdOFC8wY8zoz+CuzVrhFmybE/
 bcI9FrdXckLDmpAFzlwPGLz3MIS3wc70hY+D+bSxLkF3unIYc051EEB6R/jLJWkAsiER
 HoSu4PP0gmgg8c8EFEA9+/XLbRYo2mx8ycA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32v0kgrf66-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 00:17:52 -0700
Received: from intmgw001.08.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 00:17:45 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id EF9492EC5928; Thu, 13 Aug 2020 00:17:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf 7/9] selftests/bpf: correct various core_reloc 64-bit assumptions
Date:   Thu, 13 Aug 2020 00:17:20 -0700
Message-ID: <20200813071722.2213397-8-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813071722.2213397-1-andriin@fb.com>
References: <20200813071722.2213397-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_04:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=961 priorityscore=1501 mlxscore=0 suspectscore=8 clxscore=1015
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130055
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure that types are memory layout- and field alignment-compatible regar=
dless
of 32/64-bitness mix of libbpf and BPF architecture.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 20 +++---
 .../selftests/bpf/progs/core_reloc_types.h    | 69 ++++++++++---------
 2 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/=
testing/selftests/bpf/prog_tests/core_reloc.c
index 084ed26a7d78..a54eafc5e4b3 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -237,8 +237,8 @@
 		.union_sz =3D sizeof(((type *)0)->union_field),		\
 		.arr_sz =3D sizeof(((type *)0)->arr_field),		\
 		.arr_elem_sz =3D sizeof(((type *)0)->arr_field[0]),	\
-		.ptr_sz =3D sizeof(((type *)0)->ptr_field),		\
-		.enum_sz =3D sizeof(((type *)0)->enum_field),	\
+		.ptr_sz =3D 8, /* always 8-byte pointer for BPF */	\
+		.enum_sz =3D sizeof(((type *)0)->enum_field),		\
 	}
=20
 #define SIZE_CASE(name) {						\
@@ -432,20 +432,20 @@ static struct core_reloc_test_case test_cases[] =3D=
 {
 		.sb4 =3D -1,
 		.sb20 =3D -0x17654321,
 		.u32 =3D 0xBEEF,
-		.s32 =3D -0x3FEDCBA987654321,
+		.s32 =3D -0x3FEDCBA987654321LL,
 	}),
 	BITFIELDS_CASE(bitfields___bitfield_vs_int, {
-		.ub1 =3D 0xFEDCBA9876543210,
+		.ub1 =3D 0xFEDCBA9876543210LL,
 		.ub2 =3D 0xA6,
-		.ub7 =3D -0x7EDCBA987654321,
-		.sb4 =3D -0x6123456789ABCDE,
-		.sb20 =3D 0xD00D,
+		.ub7 =3D -0x7EDCBA987654321LL,
+		.sb4 =3D -0x6123456789ABCDELL,
+		.sb20 =3D 0xD00DLL,
 		.u32 =3D -0x76543,
-		.s32 =3D 0x0ADEADBEEFBADB0B,
+		.s32 =3D 0x0ADEADBEEFBADB0BLL,
 	}),
 	BITFIELDS_CASE(bitfields___just_big_enough, {
-		.ub1 =3D 0xF,
-		.ub2 =3D 0x0812345678FEDCBA,
+		.ub1 =3D 0xFLL,
+		.ub2 =3D 0x0812345678FEDCBALL,
 	}),
 	BITFIELDS_ERR_CASE(bitfields___err_too_big_bitfield),
=20
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools=
/testing/selftests/bpf/progs/core_reloc_types.h
index 34d84717c946..69139ed66216 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -1,5 +1,10 @@
 #include <stdint.h>
 #include <stdbool.h>
+
+void preserce_ptr_sz_fn(long x) {}
+
+#define __bpf_aligned __attribute__((aligned(8)))
+
 /*
  * KERNEL
  */
@@ -444,51 +449,51 @@ struct core_reloc_primitives {
 	char a;
 	int b;
 	enum core_reloc_primitives_enum c;
-	void *d;
-	int (*f)(const char *);
+	void *d __bpf_aligned;
+	int (*f)(const char *) __bpf_aligned;
 };
=20
 struct core_reloc_primitives___diff_enum_def {
 	char a;
 	int b;
-	void *d;
-	int (*f)(const char *);
+	void *d __bpf_aligned;
+	int (*f)(const char *) __bpf_aligned;
 	enum {
 		X =3D 100,
 		Y =3D 200,
-	} c; /* inline enum def with differing set of values */
+	} c __bpf_aligned; /* inline enum def with differing set of values */
 };
=20
 struct core_reloc_primitives___diff_func_proto {
-	void (*f)(int); /* incompatible function prototype */
-	void *d;
-	enum core_reloc_primitives_enum c;
+	void (*f)(int) __bpf_aligned; /* incompatible function prototype */
+	void *d __bpf_aligned;
+	enum core_reloc_primitives_enum c __bpf_aligned;
 	int b;
 	char a;
 };
=20
 struct core_reloc_primitives___diff_ptr_type {
-	const char * const d; /* different pointee type + modifiers */
-	char a;
+	const char * const d __bpf_aligned; /* different pointee type + modifie=
rs */
+	char a __bpf_aligned;
 	int b;
 	enum core_reloc_primitives_enum c;
-	int (*f)(const char *);
+	int (*f)(const char *) __bpf_aligned;
 };
=20
 struct core_reloc_primitives___err_non_enum {
 	char a[1];
 	int b;
 	int c; /* int instead of enum */
-	void *d;
-	int (*f)(const char *);
+	void *d __bpf_aligned;
+	int (*f)(const char *) __bpf_aligned;
 };
=20
 struct core_reloc_primitives___err_non_int {
 	char a[1];
-	int *b; /* ptr instead of int */
-	enum core_reloc_primitives_enum c;
-	void *d;
-	int (*f)(const char *);
+	int *b __bpf_aligned; /* ptr instead of int */
+	enum core_reloc_primitives_enum c __bpf_aligned;
+	void *d __bpf_aligned;
+	int (*f)(const char *) __bpf_aligned;
 };
=20
 struct core_reloc_primitives___err_non_ptr {
@@ -496,7 +501,7 @@ struct core_reloc_primitives___err_non_ptr {
 	int b;
 	enum core_reloc_primitives_enum c;
 	int d; /* int instead of ptr */
-	int (*f)(const char *);
+	int (*f)(const char *) __bpf_aligned;
 };
=20
 /*
@@ -507,7 +512,7 @@ struct core_reloc_mods_output {
 };
=20
 typedef const int int_t;
-typedef const char *char_ptr_t;
+typedef const char *char_ptr_t __bpf_aligned;
 typedef const int arr_t[7];
=20
 struct core_reloc_mods_substruct {
@@ -523,9 +528,9 @@ typedef struct {
 struct core_reloc_mods {
 	int a;
 	int_t b;
-	char *c;
+	char *c __bpf_aligned;
 	char_ptr_t d;
-	int e[3];
+	int e[3] __bpf_aligned;
 	arr_t f;
 	struct core_reloc_mods_substruct g;
 	core_reloc_mods_substruct_t h;
@@ -535,9 +540,9 @@ struct core_reloc_mods {
 struct core_reloc_mods___mod_swap {
 	int b;
 	int_t a;
-	char *d;
+	char *d __bpf_aligned;
 	char_ptr_t c;
-	int f[3];
+	int f[3] __bpf_aligned;
 	arr_t e;
 	struct {
 		int y;
@@ -555,7 +560,7 @@ typedef arr1_t arr2_t;
 typedef arr2_t arr3_t;
 typedef arr3_t arr4_t;
=20
-typedef const char * const volatile fancy_char_ptr_t;
+typedef const char * const volatile fancy_char_ptr_t __bpf_aligned;
=20
 typedef core_reloc_mods_substruct_t core_reloc_mods_substruct_tt;
=20
@@ -567,7 +572,7 @@ struct core_reloc_mods___typedefs {
 	arr4_t e;
 	fancy_char_ptr_t d;
 	fancy_char_ptr_t c;
-	int3_t b;
+	int3_t b __bpf_aligned;
 	int3_t a;
 };
=20
@@ -739,19 +744,19 @@ struct core_reloc_bitfields___bit_sz_change {
 	int8_t		sb4: 1;		/*  4 ->  1 */
 	int32_t		sb20: 30;	/* 20 -> 30 */
 	/* non-bitfields */
-	uint16_t	u32;		/* 32 -> 16 */
-	int64_t		s32;		/* 32 -> 64 */
+	uint16_t	u32;			/* 32 -> 16 */
+	int64_t		s32 __bpf_aligned;	/* 32 -> 64 */
 };
=20
 /* turn bitfield into non-bitfield and vice versa */
 struct core_reloc_bitfields___bitfield_vs_int {
 	uint64_t	ub1;		/*  3 -> 64 non-bitfield */
 	uint8_t		ub2;		/* 20 ->  8 non-bitfield */
-	int64_t		ub7;		/*  7 -> 64 non-bitfield signed */
-	int64_t		sb4;		/*  4 -> 64 non-bitfield signed */
-	uint64_t	sb20;		/* 20 -> 16 non-bitfield unsigned */
-	int32_t		u32: 20;	/* 32 non-bitfield -> 20 bitfield */
-	uint64_t	s32: 60;	/* 32 non-bitfield -> 60 bitfield */
+	int64_t		ub7 __bpf_aligned;	/*  7 -> 64 non-bitfield signed */
+	int64_t		sb4 __bpf_aligned;	/*  4 -> 64 non-bitfield signed */
+	uint64_t	sb20 __bpf_aligned;	/* 20 -> 16 non-bitfield unsigned */
+	int32_t		u32: 20;		/* 32 non-bitfield -> 20 bitfield */
+	uint64_t	s32: 60 __bpf_aligned;	/* 32 non-bitfield -> 60 bitfield */
 };
=20
 struct core_reloc_bitfields___just_big_enough {
--=20
2.24.1

