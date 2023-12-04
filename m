Return-Path: <bpf+bounces-16661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A768042A7
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67C82813F9
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF57E36B15;
	Mon,  4 Dec 2023 23:40:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD02C3
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:40:00 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B4MQC8F020118
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:39:59 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3us9fbxxbs-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:39:59 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:39:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id CCC173C9725D0; Mon,  4 Dec 2023 15:39:37 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 02/13] bpf: emit more dynptr information in verifier log
Date: Mon, 4 Dec 2023 15:39:20 -0800
Message-ID: <20231204233931.49758-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204233931.49758-1-andrii@kernel.org>
References: <20231204233931.49758-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 4bkGqfqlApZhsb5RwvW4Ksf8vyWBAJdU
X-Proofpoint-GUID: 4bkGqfqlApZhsb5RwvW4Ksf8vyWBAJdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

Emit dynptr type for CONST_PTR_TO_DYNPTR register. Also emit id,
ref_obj_id, and dynptr_id fields for STACK_DYNPTR stack slots.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 61d7d23a0118..594a234f122b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -628,6 +628,12 @@ static bool type_is_map_ptr(enum bpf_reg_type t) {
 	}
 }
=20
+/*
+ * _a stands for append, was shortened to avoid multiline statements bel=
ow.
+ * This macro is used to output a comma separated list of attributes.
+ */
+#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, ##__VA_ARGS__=
); sep =3D ","; })
+
 static void print_reg_state(struct bpf_verifier_env *env,
 			    const struct bpf_func_state *state,
 			    const struct bpf_reg_state *reg)
@@ -643,11 +649,6 @@ static void print_reg_state(struct bpf_verifier_env =
*env,
 		verbose_snum(env, reg->var_off.value + reg->off);
 		return;
 	}
-/*
- * _a stands for append, was shortened to avoid multiline statements bel=
ow.
- * This macro is used to output a comma separated list of attributes.
- */
-#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, ##__VA_ARGS__=
); sep =3D ","; })
=20
 	verbose(env, "%s", reg_type_str(env, t));
 	if (t =3D=3D PTR_TO_STACK) {
@@ -686,6 +687,8 @@ static void print_reg_state(struct bpf_verifier_env *=
env,
 		verbose_a("sz=3D");
 		verbose_unum(env, reg->mem_size);
 	}
+	if (t =3D=3D CONST_PTR_TO_DYNPTR)
+		verbose_a("type=3D%s",  dynptr_type_str(reg->dynptr.type));
 	if (tnum_is_const(reg->var_off)) {
 		/* a pointer register with fixed offset */
 		if (reg->var_off.value) {
@@ -702,8 +705,6 @@ static void print_reg_state(struct bpf_verifier_env *=
env,
 		}
 	}
 	verbose(env, ")");
-
-#undef verbose_a
 }
=20
 void print_verifier_state(struct bpf_verifier_env *env, const struct bpf=
_func_state *state,
@@ -727,6 +728,7 @@ void print_verifier_state(struct bpf_verifier_env *en=
v, const struct bpf_func_st
 	}
 	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
 		char types_buf[BPF_REG_SIZE + 1];
+		const char *sep =3D "";
 		bool valid =3D false;
 		u8 slot_type;
 		int j;
@@ -765,9 +767,14 @@ void print_verifier_state(struct bpf_verifier_env *e=
nv, const struct bpf_func_st
=20
 			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
 			print_liveness(env, reg->live);
-			verbose(env, "=3Ddynptr_%s", dynptr_type_str(reg->dynptr.type));
+			verbose(env, "=3Ddynptr_%s(", dynptr_type_str(reg->dynptr.type));
+			if (reg->id)
+				verbose_a("id=3D%d", reg->id);
 			if (reg->ref_obj_id)
-				verbose(env, "(ref_id=3D%d)", reg->ref_obj_id);
+				verbose_a("ref_id=3D%d", reg->ref_obj_id);
+			if (reg->dynptr_id)
+				verbose_a("dynptr_id=3D%d", reg->dynptr_id);
+			verbose(env, ")");
 			break;
 		case STACK_ITER:
 			/* only main slot has ref_obj_id set; skip others */
--=20
2.34.1


