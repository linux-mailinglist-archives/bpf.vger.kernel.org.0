Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334C851F24F
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiEIBam convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 8 May 2022 21:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiEIAp6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:45:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A926573
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:42:07 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248NQP6O023350
        for <bpf@vger.kernel.org>; Sun, 8 May 2022 17:42:07 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwm3p63rp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 08 May 2022 17:42:07 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 8 May 2022 17:42:05 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 7E1AF19A4AD1C; Sun,  8 May 2022 17:42:01 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 6/9] selftests/bpf: add bpf_core_field_offset() tests
Date:   Sun, 8 May 2022 17:41:45 -0700
Message-ID: <20220509004148.1801791-7-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509004148.1801791-1-andrii@kernel.org>
References: <20220509004148.1801791-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8rRxHUcw7Ud9NIvjkybBi5pQceKp46EJ
X-Proofpoint-ORIG-GUID: 8rRxHUcw7Ud9NIvjkybBi5pQceKp46EJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add test cases for bpf_core_field_offset() helper.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../selftests/bpf/prog_tests/core_reloc.c     | 13 ++++++++--
 .../progs/btf__core_reloc_size___diff_offs.c  |  3 +++
 .../selftests/bpf/progs/core_reloc_types.h    | 18 +++++++++++++
 .../bpf/progs/test_core_reloc_size.c          | 25 ++++++++++++++++++-
 4 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_size___diff_offs.c

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index f28f75aa9154..3712dfe1be59 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -277,13 +277,21 @@ static int duration = 0;
 #define SIZE_OUTPUT_DATA(type)						\
 	STRUCT_TO_CHAR_PTR(core_reloc_size_output) {			\
 		.int_sz = sizeof(((type *)0)->int_field),		\
+		.int_off = offsetof(type, int_field),			\
 		.struct_sz = sizeof(((type *)0)->struct_field),		\
+		.struct_off = offsetof(type, struct_field),		\
 		.union_sz = sizeof(((type *)0)->union_field),		\
+		.union_off = offsetof(type, union_field),		\
 		.arr_sz = sizeof(((type *)0)->arr_field),		\
-		.arr_elem_sz = sizeof(((type *)0)->arr_field[0]),	\
+		.arr_off = offsetof(type, arr_field),			\
+		.arr_elem_sz = sizeof(((type *)0)->arr_field[1]),	\
+		.arr_elem_off = offsetof(type, arr_field[1]),		\
 		.ptr_sz = 8, /* always 8-byte pointer for BPF */	\
+		.ptr_off = offsetof(type, ptr_field),			\
 		.enum_sz = sizeof(((type *)0)->enum_field),		\
+		.enum_off = offsetof(type, enum_field),			\
 		.float_sz = sizeof(((type *)0)->float_field),		\
+		.float_off = offsetof(type, float_field),		\
 	}
 
 #define SIZE_CASE(name) {						\
@@ -714,9 +722,10 @@ static const struct core_reloc_test_case test_cases[] = {
 	}),
 	BITFIELDS_ERR_CASE(bitfields___err_too_big_bitfield),
 
-	/* size relocation checks */
+	/* field size and offset relocation checks */
 	SIZE_CASE(size),
 	SIZE_CASE(size___diff_sz),
+	SIZE_CASE(size___diff_offs),
 	SIZE_ERR_CASE(size___err_ambiguous),
 
 	/* validate type existence and size relocations */
diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_size___diff_offs.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_size___diff_offs.c
new file mode 100644
index 000000000000..3824345d82ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_size___diff_offs.c
@@ -0,0 +1,3 @@
+#include "core_reloc_types.h"
+
+void f(struct core_reloc_size___diff_offs x) {}
diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
index c95c0cabe951..f9dc9766546e 100644
--- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
+++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
@@ -785,13 +785,21 @@ struct core_reloc_bitfields___err_too_big_bitfield {
  */
 struct core_reloc_size_output {
 	int int_sz;
+	int int_off;
 	int struct_sz;
+	int struct_off;
 	int union_sz;
+	int union_off;
 	int arr_sz;
+	int arr_off;
 	int arr_elem_sz;
+	int arr_elem_off;
 	int ptr_sz;
+	int ptr_off;
 	int enum_sz;
+	int enum_off;
 	int float_sz;
+	int float_off;
 };
 
 struct core_reloc_size {
@@ -814,6 +822,16 @@ struct core_reloc_size___diff_sz {
 	double float_field;
 };
 
+struct core_reloc_size___diff_offs {
+	float float_field;
+	enum { YET_OTHER_VALUE = 123 } enum_field;
+	void *ptr_field;
+	int arr_field[4];
+	union { int x; } union_field;
+	struct { int x; } struct_field;
+	int int_field;
+};
+
 /* Error case of two candidates with the fields (int_field) at the same
  * offset, but with differing final relocation values: size 4 vs size 1
  */
diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_size.c b/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
index 6766addd2583..5b686053ce42 100644
--- a/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
+++ b/tools/testing/selftests/bpf/progs/test_core_reloc_size.c
@@ -15,13 +15,21 @@ struct {
 
 struct core_reloc_size_output {
 	int int_sz;
+	int int_off;
 	int struct_sz;
+	int struct_off;
 	int union_sz;
+	int union_off;
 	int arr_sz;
+	int arr_off;
 	int arr_elem_sz;
+	int arr_elem_off;
 	int ptr_sz;
+	int ptr_off;
 	int enum_sz;
+	int enum_off;
 	int float_sz;
+	int float_off;
 };
 
 struct core_reloc_size {
@@ -41,13 +49,28 @@ int test_core_size(void *ctx)
 	struct core_reloc_size_output *out = (void *)&data.out;
 
 	out->int_sz = bpf_core_field_size(in->int_field);
+	out->int_off = bpf_core_field_offset(in->int_field);
+
 	out->struct_sz = bpf_core_field_size(in->struct_field);
+	out->struct_off = bpf_core_field_offset(in->struct_field);
+
 	out->union_sz = bpf_core_field_size(in->union_field);
+	out->union_off = bpf_core_field_offset(in->union_field);
+
 	out->arr_sz = bpf_core_field_size(in->arr_field);
-	out->arr_elem_sz = bpf_core_field_size(struct core_reloc_size, arr_field[0]);
+	out->arr_off = bpf_core_field_offset(in->arr_field);
+
+	out->arr_elem_sz = bpf_core_field_size(struct core_reloc_size, arr_field[1]);
+	out->arr_elem_off = bpf_core_field_offset(struct core_reloc_size, arr_field[1]);
+
 	out->ptr_sz = bpf_core_field_size(struct core_reloc_size, ptr_field);
+	out->ptr_off = bpf_core_field_offset(struct core_reloc_size, ptr_field);
+
 	out->enum_sz = bpf_core_field_size(struct core_reloc_size, enum_field);
+	out->enum_off = bpf_core_field_offset(struct core_reloc_size, enum_field);
+
 	out->float_sz = bpf_core_field_size(struct core_reloc_size, float_field);
+	out->float_off = bpf_core_field_offset(struct core_reloc_size, float_field);
 
 	return 0;
 }
-- 
2.30.2

