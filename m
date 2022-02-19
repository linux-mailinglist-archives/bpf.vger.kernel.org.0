Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1934BC385
	for <lists+bpf@lfdr.de>; Sat, 19 Feb 2022 01:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbiBSAhG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 19:37:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAhG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 19:37:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4FC22BE4
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 16:36:46 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 21INNvdN009794
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 16:36:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=/CbnuIr0yZ1u+pLmmLJy3VUL7dygqXoxDejMlZc+R7o=;
 b=dgHY3ogBC/2OpCvojdBoCvbyCXCUJfcQbVpEbYY91E9sQXwytFdlgCewGDsSkBugfscO
 yQzZdFJwbdhGumK7RL1awqV13mjOc8LSq2o1t3g9PyhkdFnCoMuOKRyXjcRxDjrPbOxh
 qBNY5DiMSaG+5PyjXhiKedlXQz4fRY1BqMM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3eaj671nmn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 18 Feb 2022 16:36:45 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 16:36:43 -0800
Received: by devvm4897.frc0.facebook.com (Postfix, from userid 537053)
        id 122F131D521D; Fri, 18 Feb 2022 16:36:38 -0800 (PST)
From:   Mykola Lysenko <mykolal@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Mykola Lysenko <mykolal@fb.com>
Subject: [PATCH bpf-next] Small BPF verifier log improvements
Date:   Fri, 18 Feb 2022 16:36:33 -0800
Message-ID: <20220219003633.1110239-1-mykolal@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Y9sv_iUfWjyUMHlHqqfC3pczuEIuAO6b
X-Proofpoint-ORIG-GUID: Y9sv_iUfWjyUMHlHqqfC3pczuEIuAO6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_10,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202190001
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In particular:
1) remove output of inv for scalars
2) remove _value suffixes for umin/umax/s32_min/etc (except map_value)
3) remove output of id=3D0
4) remove output of ref_obj_id=3D0

Signed-off-by: Mykola Lysenko <mykolal@fb.com>
---
 kernel/bpf/verifier.c                         |  72 +++---
 .../testing/selftests/bpf/prog_tests/align.c  | 218 +++++++++---------
 .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
 3 files changed, 156 insertions(+), 138 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d7473fee247c..a43bb0cf4c46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -539,7 +539,7 @@ static const char *reg_type_str(struct bpf_verifier_e=
nv *env,
 	char postfix[16] =3D {0}, prefix[32] =3D {0};
 	static const char * const str[] =3D {
 		[NOT_INIT]		=3D "?",
-		[SCALAR_VALUE]		=3D "inv",
+		[SCALAR_VALUE]		=3D "",
 		[PTR_TO_CTX]		=3D "ctx",
 		[CONST_PTR_TO_MAP]	=3D "map_ptr",
 		[PTR_TO_MAP_VALUE]	=3D "map_value",
@@ -666,6 +666,15 @@ static void scrub_spilled_slot(u8 *stype)
 		*stype =3D STACK_MISC;
 }
=20
+#define verbose_append(fmt, ...) \
+({ \
+	if (is_first_item) \
+		is_first_item =3D false; \
+	else \
+		verbose(env, ","); \
+	verbose(env, fmt, __VA_ARGS__); \
+})
+
 static void print_verifier_state(struct bpf_verifier_env *env,
 				 const struct bpf_func_state *state,
 				 bool print_all)
@@ -693,65 +702,74 @@ static void print_verifier_state(struct bpf_verifie=
r_env *env,
 			/* reg->off should be 0 for SCALAR_VALUE */
 			verbose(env, "%lld", reg->var_off.value + reg->off);
 		} else {
+			bool is_first_item =3D true;
+
 			if (base_type(t) =3D=3D PTR_TO_BTF_ID ||
 			    base_type(t) =3D=3D PTR_TO_PERCPU_BTF_ID)
 				verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
-			verbose(env, "(id=3D%d", reg->id);
-			if (reg_type_may_be_refcounted_or_null(t))
-				verbose(env, ",ref_obj_id=3D%d", reg->ref_obj_id);
+
+			verbose(env, "(");
+
+			if (reg->id) {
+				verbose(env, "id=3D%d", reg->id);
+				is_first_item =3D false;
+			}
+
+			if (reg_type_may_be_refcounted_or_null(t) && reg->ref_obj_id)
+				verbose_append("ref_obj_id=3D%d", reg->ref_obj_id);
 			if (t !=3D SCALAR_VALUE)
-				verbose(env, ",off=3D%d", reg->off);
+				verbose_append("off=3D%d", reg->off);
 			if (type_is_pkt_pointer(t))
-				verbose(env, ",r=3D%d", reg->range);
+				verbose_append("r=3D%d", reg->range);
 			else if (base_type(t) =3D=3D CONST_PTR_TO_MAP ||
 				 base_type(t) =3D=3D PTR_TO_MAP_KEY ||
 				 base_type(t) =3D=3D PTR_TO_MAP_VALUE)
-				verbose(env, ",ks=3D%d,vs=3D%d",
-					reg->map_ptr->key_size,
-					reg->map_ptr->value_size);
+				verbose_append("ks=3D%d,vs=3D%d",
+					       reg->map_ptr->key_size,
+					       reg->map_ptr->value_size);
 			if (tnum_is_const(reg->var_off)) {
 				/* Typically an immediate SCALAR_VALUE, but
 				 * could be a pointer whose offset is too big
 				 * for reg->off
 				 */
-				verbose(env, ",imm=3D%llx", reg->var_off.value);
+				verbose_append("imm=3D%llx", reg->var_off.value);
 			} else {
 				if (reg->smin_value !=3D reg->umin_value &&
 				    reg->smin_value !=3D S64_MIN)
-					verbose(env, ",smin_value=3D%lld",
-						(long long)reg->smin_value);
+					verbose_append("smin=3D%lld",
+						       (long long)reg->smin_value);
 				if (reg->smax_value !=3D reg->umax_value &&
 				    reg->smax_value !=3D S64_MAX)
-					verbose(env, ",smax_value=3D%lld",
-						(long long)reg->smax_value);
+					verbose_append("smax=3D%lld",
+						       (long long)reg->smax_value);
 				if (reg->umin_value !=3D 0)
-					verbose(env, ",umin_value=3D%llu",
-						(unsigned long long)reg->umin_value);
+					verbose_append("umin=3D%llu",
+						       (unsigned long long)reg->umin_value);
 				if (reg->umax_value !=3D U64_MAX)
-					verbose(env, ",umax_value=3D%llu",
-						(unsigned long long)reg->umax_value);
+					verbose_append("umax=3D%llu",
+						       (unsigned long long)reg->umax_value);
 				if (!tnum_is_unknown(reg->var_off)) {
 					char tn_buf[48];
=20
 					tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-					verbose(env, ",var_off=3D%s", tn_buf);
+					verbose_append("var_off=3D%s", tn_buf);
 				}
 				if (reg->s32_min_value !=3D reg->smin_value &&
 				    reg->s32_min_value !=3D S32_MIN)
-					verbose(env, ",s32_min_value=3D%d",
-						(int)(reg->s32_min_value));
+					verbose_append("s32_min=3D%d",
+						       (int)(reg->s32_min_value));
 				if (reg->s32_max_value !=3D reg->smax_value &&
 				    reg->s32_max_value !=3D S32_MAX)
-					verbose(env, ",s32_max_value=3D%d",
-						(int)(reg->s32_max_value));
+					verbose_append("s32_max=3D%d",
+						       (int)(reg->s32_max_value));
 				if (reg->u32_min_value !=3D reg->umin_value &&
 				    reg->u32_min_value !=3D U32_MIN)
-					verbose(env, ",u32_min_value=3D%d",
-						(int)(reg->u32_min_value));
+					verbose_append("u32_min=3D%d",
+						       (int)(reg->u32_min_value));
 				if (reg->u32_max_value !=3D reg->umax_value &&
 				    reg->u32_max_value !=3D U32_MAX)
-					verbose(env, ",u32_max_value=3D%d",
-						(int)(reg->u32_max_value));
+					verbose_append("u32_max=3D%d",
+						       (int)(reg->u32_max_value));
 			}
 			verbose(env, ")");
 		}
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testi=
ng/selftests/bpf/prog_tests/align.c
index 0ee29e11eaee..210dc6b4a169 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -39,13 +39,13 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
+			{0, "R1=3Dctx(off=3D0,imm=3D0)"},
 			{0, "R10=3Dfp0"},
-			{0, "R3_w=3Dinv2"},
-			{1, "R3_w=3Dinv4"},
-			{2, "R3_w=3Dinv8"},
-			{3, "R3_w=3Dinv16"},
-			{4, "R3_w=3Dinv32"},
+			{0, "R3_w=3D2"},
+			{1, "R3_w=3D4"},
+			{2, "R3_w=3D8"},
+			{3, "R3_w=3D16"},
+			{4, "R3_w=3D32"},
 		},
 	},
 	{
@@ -67,19 +67,19 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
+			{0, "R1=3Dctx(off=3D0,imm=3D0)"},
 			{0, "R10=3Dfp0"},
-			{0, "R3_w=3Dinv1"},
-			{1, "R3_w=3Dinv2"},
-			{2, "R3_w=3Dinv4"},
-			{3, "R3_w=3Dinv8"},
-			{4, "R3_w=3Dinv16"},
-			{5, "R3_w=3Dinv1"},
-			{6, "R4_w=3Dinv32"},
-			{7, "R4_w=3Dinv16"},
-			{8, "R4_w=3Dinv8"},
-			{9, "R4_w=3Dinv4"},
-			{10, "R4_w=3Dinv2"},
+			{0, "R3_w=3D1"},
+			{1, "R3_w=3D2"},
+			{2, "R3_w=3D4"},
+			{3, "R3_w=3D8"},
+			{4, "R3_w=3D16"},
+			{5, "R3_w=3D1"},
+			{6, "R4_w=3D32"},
+			{7, "R4_w=3D16"},
+			{8, "R4_w=3D8"},
+			{9, "R4_w=3D4"},
+			{10, "R4_w=3D2"},
 		},
 	},
 	{
@@ -96,14 +96,14 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
+			{0, "R1=3Dctx(off=3D0,imm=3D0)"},
 			{0, "R10=3Dfp0"},
-			{0, "R3_w=3Dinv4"},
-			{1, "R3_w=3Dinv8"},
-			{2, "R3_w=3Dinv10"},
-			{3, "R4_w=3Dinv8"},
-			{4, "R4_w=3Dinv12"},
-			{5, "R4_w=3Dinv14"},
+			{0, "R3_w=3D4"},
+			{1, "R3_w=3D8"},
+			{2, "R3_w=3D10"},
+			{3, "R4_w=3D8"},
+			{4, "R4_w=3D12"},
+			{5, "R4_w=3D14"},
 		},
 	},
 	{
@@ -118,12 +118,12 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{0, "R1=3Dctx(id=3D0,off=3D0,imm=3D0)"},
+			{0, "R1=3Dctx(off=3D0,imm=3D0)"},
 			{0, "R10=3Dfp0"},
-			{0, "R3_w=3Dinv7"},
-			{1, "R3_w=3Dinv7"},
-			{2, "R3_w=3Dinv14"},
-			{3, "R3_w=3Dinv56"},
+			{0, "R3_w=3D7"},
+			{1, "R3_w=3D7"},
+			{2, "R3_w=3D14"},
+			{3, "R3_w=3D56"},
 		},
 	},
=20
@@ -161,19 +161,19 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{6, "R0_w=3Dpkt(id=3D0,off=3D8,r=3D8,imm=3D0)"},
-			{6, "R3_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{7, "R3_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
-			{8, "R3_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{9, "R3_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{10, "R3_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
-			{12, "R3_w=3Dpkt_end(id=3D0,off=3D0,imm=3D0)"},
-			{17, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{18, "R4_w=3Dinv(id=3D0,umax_value=3D8160,var_off=3D(0x0; 0x1fe0))"},
-			{19, "R4_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
-			{20, "R4_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{21, "R4_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{22, "R4_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
+			{6, "R0_w=3Dpkt(off=3D8,r=3D8,imm=3D0)"},
+			{6, "R3_w=3D(umax=3D255,var_off=3D(0x0; 0xff))"},
+			{7, "R3_w=3D(umax=3D510,var_off=3D(0x0; 0x1fe))"},
+			{8, "R3_w=3D(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{9, "R3_w=3D(umax=3D2040,var_off=3D(0x0; 0x7f8))"},
+			{10, "R3_w=3D(umax=3D4080,var_off=3D(0x0; 0xff0))"},
+			{12, "R3_w=3Dpkt_end(off=3D0,imm=3D0)"},
+			{17, "R4_w=3D(umax=3D255,var_off=3D(0x0; 0xff))"},
+			{18, "R4_w=3D(umax=3D8160,var_off=3D(0x0; 0x1fe0))"},
+			{19, "R4_w=3D(umax=3D4080,var_off=3D(0x0; 0xff0))"},
+			{20, "R4_w=3D(umax=3D2040,var_off=3D(0x0; 0x7f8))"},
+			{21, "R4_w=3D(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{22, "R4_w=3D(umax=3D510,var_off=3D(0x0; 0x1fe))"},
 		},
 	},
 	{
@@ -194,16 +194,16 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{6, "R3_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{7, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{8, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{9, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{10, "R4_w=3Dinv(id=3D0,umax_value=3D510,var_off=3D(0x0; 0x1fe))"},
-			{11, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{12, "R4_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
-			{13, "R4_w=3Dinv(id=3D1,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{14, "R4_w=3Dinv(id=3D0,umax_value=3D2040,var_off=3D(0x0; 0x7f8))"},
-			{15, "R4_w=3Dinv(id=3D0,umax_value=3D4080,var_off=3D(0x0; 0xff0))"},
+			{6, "R3_w=3D(umax=3D255,var_off=3D(0x0; 0xff))"},
+			{7, "R4_w=3D(id=3D1,umax=3D255,var_off=3D(0x0; 0xff))"},
+			{8, "R4_w=3D(umax=3D255,var_off=3D(0x0; 0xff))"},
+			{9, "R4_w=3D(id=3D1,umax=3D255,var_off=3D(0x0; 0xff))"},
+			{10, "R4_w=3D(umax=3D510,var_off=3D(0x0; 0x1fe))"},
+			{11, "R4_w=3D(id=3D1,umax=3D255,var_off=3D(0x0; 0xff))"},
+			{12, "R4_w=3D(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{13, "R4_w=3D(id=3D1,umax=3D255,var_off=3D(0x0; 0xff))"},
+			{14, "R4_w=3D(umax=3D2040,var_off=3D(0x0; 0x7f8))"},
+			{15, "R4_w=3D(umax=3D4080,var_off=3D(0x0; 0xff0))"},
 		},
 	},
 	{
@@ -234,14 +234,14 @@ static struct bpf_align_test tests[] =3D {
 		},
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.matches =3D {
-			{2, "R5_w=3Dpkt(id=3D0,off=3D0,r=3D0,imm=3D0)"},
-			{4, "R5_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0)"},
-			{5, "R4_w=3Dpkt(id=3D0,off=3D14,r=3D0,imm=3D0)"},
-			{9, "R2=3Dpkt(id=3D0,off=3D0,r=3D18,imm=3D0)"},
-			{10, "R5=3Dpkt(id=3D0,off=3D14,r=3D18,imm=3D0)"},
-			{10, "R4_w=3Dinv(id=3D0,umax_value=3D255,var_off=3D(0x0; 0xff))"},
-			{13, "R4_w=3Dinv(id=3D0,umax_value=3D65535,var_off=3D(0x0; 0xffff))"}=
,
-			{14, "R4_w=3Dinv(id=3D0,umax_value=3D65535,var_off=3D(0x0; 0xffff))"}=
,
+			{2, "R5_w=3Dpkt(off=3D0,r=3D0,imm=3D0)"},
+			{4, "R5_w=3Dpkt(off=3D14,r=3D0,imm=3D0)"},
+			{5, "R4_w=3Dpkt(off=3D14,r=3D0,imm=3D0)"},
+			{9, "R2=3Dpkt(off=3D0,r=3D18,imm=3D0)"},
+			{10, "R5=3Dpkt(off=3D14,r=3D18,imm=3D0)"},
+			{10, "R4_w=3D(umax=3D255,var_off=3D(0x0; 0xff))"},
+			{13, "R4_w=3D(umax=3D65535,var_off=3D(0x0; 0xffff))"},
+			{14, "R4_w=3D(umax=3D65535,var_off=3D(0x0; 0xffff))"},
 		},
 	},
 	{
@@ -296,59 +296,59 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
-			{7, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{6, "R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0)"},
+			{7, "R6_w=3D(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Offset is added to packet pointer R5, resulting in
 			 * known fixed offset, and variable offset from R6.
 			 */
-			{11, "R5_w=3Dpkt(id=3D1,off=3D14,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
+			{11, "R5_w=3Dpkt(id=3D1,off=3D14,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * it's total offset is NET_IP_ALIGN + reg->off (0) +
 			 * reg->aux_off (14) which is 16.  Then the variable
 			 * offset is considered using reg->aux_off_align which
 			 * is 4 and meets the load's requirements.
 			 */
-			{15, "R4=3Dpkt(id=3D1,off=3D18,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
-			{15, "R5=3Dpkt(id=3D1,off=3D14,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
+			{15, "R4=3Dpkt(id=3D1,off=3D18,r=3D18,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
+			{15, "R5=3Dpkt(id=3D1,off=3D14,r=3D18,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
 			/* Variable offset is added to R5 packet pointer,
 			 * resulting in auxiliary alignment of 4.
 			 */
-			{17, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
+			{17, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
 			/* Constant offset is added to R5, resulting in
 			 * reg->off of 14.
 			 */
-			{18, "R5_w=3Dpkt(id=3D2,off=3D14,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
+			{18, "R5_w=3Dpkt(id=3D2,off=3D14,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off
 			 * (14) which is 16.  Then the variable offset is 4-byte
 			 * aligned, so the total offset is 4-byte aligned and
 			 * meets the load's requirements.
 			 */
-			{23, "R4=3Dpkt(id=3D2,off=3D18,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
-			{23, "R5=3Dpkt(id=3D2,off=3D14,r=3D18,umax_value=3D1020,var_off=3D(0x=
0; 0x3fc))"},
+			{23, "R4=3Dpkt(id=3D2,off=3D18,r=3D18,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
+			{23, "R5=3Dpkt(id=3D2,off=3D14,r=3D18,umax=3D1020,var_off=3D(0x0; 0x3=
fc))"},
 			/* Constant offset is added to R5 packet pointer,
 			 * resulting in reg->off value of 14.
 			 */
-			{25, "R5_w=3Dpkt(id=3D0,off=3D14,r=3D8"},
+			{25, "R5_w=3Dpkt(off=3D14,r=3D8"},
 			/* Variable offset is added to R5, resulting in a
 			 * variable offset of (4n).
 			 */
-			{26, "R5_w=3Dpkt(id=3D3,off=3D14,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
+			{26, "R5_w=3Dpkt(id=3D3,off=3D14,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
 			/* Constant is added to R5 again, setting reg->off to 18. */
-			{27, "R5_w=3Dpkt(id=3D3,off=3D18,r=3D0,umax_value=3D1020,var_off=3D(0=
x0; 0x3fc))"},
+			{27, "R5_w=3Dpkt(id=3D3,off=3D18,r=3D0,umax=3D1020,var_off=3D(0x0; 0x=
3fc))"},
 			/* And once more we add a variable; resulting var_off
 			 * is still (4n), fixed offset is not changed.
 			 * Also, we create a new reg->id.
 			 */
-			{28, "R5_w=3Dpkt(id=3D4,off=3D18,r=3D0,umax_value=3D2040,var_off=3D(0=
x0; 0x7fc)"},
+			{28, "R5_w=3Dpkt(id=3D4,off=3D18,r=3D0,umax=3D2040,var_off=3D(0x0; 0x=
7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
 			 * which is 20.  Then the variable offset is (4n), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{33, "R4=3Dpkt(id=3D4,off=3D22,r=3D22,umax_value=3D2040,var_off=3D(0x=
0; 0x7fc)"},
-			{33, "R5=3Dpkt(id=3D4,off=3D18,r=3D22,umax_value=3D2040,var_off=3D(0x=
0; 0x7fc)"},
+			{33, "R4=3Dpkt(id=3D4,off=3D22,r=3D22,umax=3D2040,var_off=3D(0x0; 0x7=
fc)"},
+			{33, "R5=3Dpkt(id=3D4,off=3D18,r=3D22,umax=3D2040,var_off=3D(0x0; 0x7=
fc)"},
 		},
 	},
 	{
@@ -386,36 +386,36 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
-			{7, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{6, "R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0)"},
+			{7, "R6_w=3D(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{8, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D1034,var_off=3D(0=
x2; 0x7fc))"},
+			{8, "R6_w=3D(umin=3D14,umax=3D1034,var_off=3D(0x2; 0x7fc))"},
 			/* Packet pointer has (4n+2) offset */
-			{11, "R5_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D14,umax_value=3D10=
34,var_off=3D(0x2; 0x7fc)"},
-			{12, "R4=3Dpkt(id=3D1,off=3D4,r=3D0,umin_value=3D14,umax_value=3D1034=
,var_off=3D(0x2; 0x7fc)"},
+			{11, "R5_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin=3D14,umax=3D1034,var_off=3D=
(0x2; 0x7fc)"},
+			{12, "R4=3Dpkt(id=3D1,off=3D4,r=3D0,umin=3D14,umax=3D1034,var_off=3D(=
0x2; 0x7fc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{15, "R5=3Dpkt(id=3D1,off=3D0,r=3D4,umin_value=3D14,umax_value=3D1034=
,var_off=3D(0x2; 0x7fc)"},
+			{15, "R5=3Dpkt(id=3D1,off=3D0,r=3D4,umin=3D14,umax=3D1034,var_off=3D(=
0x2; 0x7fc)"},
 			/* Newly read value in R6 was shifted left by 2, so has
 			 * known alignment of 4.
 			 */
-			{17, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{17, "R6_w=3D(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Added (4n) to packet pointer's (4n+2) var_off, giving
 			 * another (4n+2).
 			 */
-			{19, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umin_value=3D14,umax_value=3D20=
54,var_off=3D(0x2; 0xffc)"},
-			{20, "R4=3Dpkt(id=3D2,off=3D4,r=3D0,umin_value=3D14,umax_value=3D2054=
,var_off=3D(0x2; 0xffc)"},
+			{19, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D0,umin=3D14,umax=3D2054,var_off=3D=
(0x2; 0xffc)"},
+			{20, "R4=3Dpkt(id=3D2,off=3D4,r=3D0,umin=3D14,umax=3D2054,var_off=3D(=
0x2; 0xffc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{23, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin_value=3D14,umax_value=3D2054=
,var_off=3D(0x2; 0xffc)"},
+			{23, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin=3D14,umax=3D2054,var_off=3D(=
0x2; 0xffc)"},
 		},
 	},
 	{
@@ -448,18 +448,18 @@ static struct bpf_align_test tests[] =3D {
 		.prog_type =3D BPF_PROG_TYPE_SCHED_CLS,
 		.result =3D REJECT,
 		.matches =3D {
-			{3, "R5_w=3Dpkt_end(id=3D0,off=3D0,imm=3D0)"},
+			{3, "R5_w=3Dpkt_end(off=3D0,imm=3D0)"},
 			/* (ptr - ptr) << 2 =3D=3D unknown, (4n) */
-			{5, "R5_w=3Dinv(id=3D0,smax_value=3D9223372036854775804,umax_value=3D=
18446744073709551612,var_off=3D(0x0; 0xfffffffffffffffc)"},
+			{5, "R5_w=3D(smax=3D9223372036854775804,umax=3D18446744073709551612,v=
ar_off=3D(0x0; 0xfffffffffffffffc)"},
 			/* (4n) + 14 =3D=3D (4n+2).  We blow our bounds, because
 			 * the add could overflow.
 			 */
-			{6, "R5_w=3Dinv(id=3D0,smin_value=3D-9223372036854775806,smax_value=3D=
9223372036854775806,umin_value=3D2,umax_value=3D18446744073709551614,var_=
off=3D(0x2; 0xfffffffffffffffc)"},
+			{6, "R5_w=3D(smin=3D-9223372036854775806,smax=3D9223372036854775806,u=
min=3D2,umax=3D18446744073709551614,var_off=3D(0x2; 0xfffffffffffffffc)"}=
,
 			/* Checked s>=3D0 */
-			{9, "R5=3Dinv(id=3D0,umin_value=3D2,umax_value=3D9223372036854775806,=
var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{9, "R5=3D(umin=3D2,umax=3D9223372036854775806,var_off=3D(0x2; 0x7fff=
fffffffffffc)"},
 			/* packet pointer + nonnegative (4n+2) */
-			{11, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
-			{12, "R4_w=3Dpkt(id=3D1,off=3D4,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{11, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin=3D2,umax=3D922337203685477=
5806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{12, "R4_w=3Dpkt(id=3D1,off=3D4,r=3D0,umin=3D2,umax=3D922337203685477=
5806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
 			/* NET_IP_ALIGN + (4n+2) =3D=3D (4n), alignment is fine.
 			 * We checked the bounds, but it might have been able
 			 * to overflow if the packet pointer started in the
@@ -467,7 +467,7 @@ static struct bpf_align_test tests[] =3D {
 			 * So we did not get a 'range' on R6, and the access
 			 * attempt will fail.
 			 */
-			{15, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin_value=3D2,umax_value=3D922=
3372036854775806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
+			{15, "R6_w=3Dpkt(id=3D1,off=3D0,r=3D0,umin=3D2,umax=3D922337203685477=
5806,var_off=3D(0x2; 0x7ffffffffffffffc)"},
 		}
 	},
 	{
@@ -502,23 +502,23 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
-			{8, "R6_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{6, "R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0)"},
+			{8, "R6_w=3D(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{9, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D1034,var_off=3D(0=
x2; 0x7fc))"},
+			{9, "R6_w=3D(umin=3D14,umax=3D1034,var_off=3D(0x2; 0x7fc))"},
 			/* New unknown value in R7 is (4n) */
-			{10, "R7_w=3Dinv(id=3D0,umax_value=3D1020,var_off=3D(0x0; 0x3fc))"},
+			{10, "R7_w=3D(umax=3D1020,var_off=3D(0x0; 0x3fc))"},
 			/* Subtracting it from R6 blows our unsigned bounds */
-			{11, "R6=3Dinv(id=3D0,smin_value=3D-1006,smax_value=3D1034,umin_value=
=3D2,umax_value=3D18446744073709551614,var_off=3D(0x2; 0xfffffffffffffffc=
)"},
+			{11, "R6=3D(smin=3D-1006,smax=3D1034,umin=3D2,umax=3D1844674407370955=
1614,var_off=3D(0x2; 0xfffffffffffffffc)"},
 			/* Checked s>=3D 0 */
-			{14, "R6=3Dinv(id=3D0,umin_value=3D2,umax_value=3D1034,var_off=3D(0x2=
; 0x7fc))"},
+			{14, "R6=3D(umin=3D2,umax=3D1034,var_off=3D(0x2; 0x7fc))"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{20, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin_value=3D2,umax_value=3D1034,=
var_off=3D(0x2; 0x7fc)"},
+			{20, "R5=3Dpkt(id=3D2,off=3D0,r=3D4,umin=3D2,umax=3D1034,var_off=3D(0=
x2; 0x7fc)"},
=20
 		},
 	},
@@ -556,23 +556,23 @@ static struct bpf_align_test tests[] =3D {
 			/* Calculated offset in R6 has unknown value, but known
 			 * alignment of 4.
 			 */
-			{6, "R2_w=3Dpkt(id=3D0,off=3D0,r=3D8,imm=3D0)"},
-			{9, "R6_w=3Dinv(id=3D0,umax_value=3D60,var_off=3D(0x0; 0x3c))"},
+			{6, "R2_w=3Dpkt(off=3D0,r=3D8,imm=3D0)"},
+			{9, "R6_w=3D(umax=3D60,var_off=3D(0x0; 0x3c))"},
 			/* Adding 14 makes R6 be (4n+2) */
-			{10, "R6_w=3Dinv(id=3D0,umin_value=3D14,umax_value=3D74,var_off=3D(0x=
2; 0x7c))"},
+			{10, "R6_w=3D(umin=3D14,umax=3D74,var_off=3D(0x2; 0x7c))"},
 			/* Subtracting from packet pointer overflows ubounds */
-			{13, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D8,umin_value=3D184467440737095515=
42,umax_value=3D18446744073709551602,var_off=3D(0xffffffffffffff82; 0x7c)=
"},
+			{13, "R5_w=3Dpkt(id=3D2,off=3D0,r=3D8,umin=3D18446744073709551542,uma=
x=3D18446744073709551602,var_off=3D(0xffffffffffffff82; 0x7c)"},
 			/* New unknown value in R7 is (4n), >=3D 76 */
-			{14, "R7_w=3Dinv(id=3D0,umin_value=3D76,umax_value=3D1096,var_off=3D(=
0x0; 0x7fc))"},
+			{14, "R7_w=3D(umin=3D76,umax=3D1096,var_off=3D(0x0; 0x7fc))"},
 			/* Adding it to packet pointer gives nice bounds again */
-			{16, "R5_w=3Dpkt(id=3D3,off=3D0,r=3D0,umin_value=3D2,umax_value=3D108=
2,var_off=3D(0x2; 0xfffffffc)"},
+			{16, "R5_w=3Dpkt(id=3D3,off=3D0,r=3D0,umin=3D2,umax=3D1082,var_off=3D=
(0x2; 0xfffffffc)"},
 			/* At the time the word size load is performed from R5,
 			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
 			 * which is 2.  Then the variable offset is (4n+2), so
 			 * the total offset is 4-byte aligned and meets the
 			 * load's requirements.
 			 */
-			{20, "R5=3Dpkt(id=3D3,off=3D0,r=3D4,umin_value=3D2,umax_value=3D1082,=
var_off=3D(0x2; 0xfffffffc)"},
+			{20, "R5=3Dpkt(id=3D3,off=3D0,r=3D4,umin=3D2,umax=3D1082,var_off=3D(0=
x2; 0xfffffffc)"},
 		},
 	},
 };
@@ -648,8 +648,8 @@ static int do_test_single(struct bpf_align_test *test=
)
 			/* Check the next line as well in case the previous line
 			 * did not have a corresponding bpf insn. Example:
 			 * func#0 @0
-			 * 0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3Dfp0
-			 * 0: (b7) r3 =3D 2                 ; R3_w=3Dinv2
+			 * 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
+			 * 0: (b7) r3 =3D 2                 ; R3_w=3D2
 			 */
 			if (!strstr(line_ptr, m.match)) {
 				cur_line =3D -1;
diff --git a/tools/testing/selftests/bpf/prog_tests/log_buf.c b/tools/tes=
ting/selftests/bpf/prog_tests/log_buf.c
index 1ef377a7e731..fe9a23e65ef4 100644
--- a/tools/testing/selftests/bpf/prog_tests/log_buf.c
+++ b/tools/testing/selftests/bpf/prog_tests/log_buf.c
@@ -78,7 +78,7 @@ static void obj_load_log_buf(void)
 	ASSERT_OK_PTR(strstr(libbpf_log_buf, "prog 'bad_prog': BPF program load=
 failed"),
 		      "libbpf_log_not_empty");
 	ASSERT_OK_PTR(strstr(obj_log_buf, "DATASEC license"), "obj_log_not_empt=
y");
-	ASSERT_OK_PTR(strstr(good_log_buf, "0: R1=3Dctx(id=3D0,off=3D0,imm=3D0)=
 R10=3Dfp0"),
+	ASSERT_OK_PTR(strstr(good_log_buf, "0: R1=3Dctx(off=3D0,imm=3D0) R10=3D=
fp0"),
 		      "good_log_verbose");
 	ASSERT_OK_PTR(strstr(bad_log_buf, "invalid access to map value, value_s=
ize=3D16 off=3D16000 size=3D4"),
 		      "bad_log_not_empty");
@@ -175,7 +175,7 @@ static void bpf_prog_load_log_buf(void)
 	opts.log_level =3D 2;
 	fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "good_prog", "GPL",
 			   good_prog_insns, good_prog_insn_cnt, &opts);
-	ASSERT_OK_PTR(strstr(log_buf, "0: R1=3Dctx(id=3D0,off=3D0,imm=3D0) R10=3D=
fp0"), "good_log_2");
+	ASSERT_OK_PTR(strstr(log_buf, "0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0")=
, "good_log_2");
 	ASSERT_GE(fd, 0, "good_fd2");
 	if (fd >=3D 0)
 		close(fd);
--=20
2.30.2

