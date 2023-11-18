Return-Path: <bpf+bounces-15298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291CD7EFD90
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 04:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D919128137C
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 03:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0243A23C3;
	Sat, 18 Nov 2023 03:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7FCD79
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:46:53 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI2r5SW003655
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:46:53 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uemvd856k-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 19:46:52 -0800
Received: from twshared58712.02.prn6.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 19:46:50 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 0CEB93BB2FFB2; Fri, 17 Nov 2023 19:46:41 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH v3 bpf-next 3/8] bpf: extract register state printing
Date: Fri, 17 Nov 2023 19:46:18 -0800
Message-ID: <20231118034623.3320920-4-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118034623.3320920-1-andrii@kernel.org>
References: <20231118034623.3320920-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Of38ZqFlVdDAdyRF_0xqT_LlYv2rS4sd
X-Proofpoint-ORIG-GUID: Of38ZqFlVdDAdyRF_0xqT_LlYv2rS4sd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_01,2023-11-17_01,2023-05-22_02

Extract printing register state representation logic into a separate
helper, as we are going to reuse it for spilled register state printing
in the next patch. This also nicely reduces code nestedness.

No functional changes.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/log.c | 120 +++++++++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 57 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index c1b257eac21b..05d737e2fab3 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -553,6 +553,67 @@ static void print_scalar_ranges(struct bpf_verifier_=
env *env,
 	}
 }
=20
+static void print_reg_state(struct bpf_verifier_env *env, const struct b=
pf_reg_state *reg)
+{
+	enum bpf_reg_type t;
+	const char *sep =3D "";
+
+	t =3D reg->type;
+	if (t =3D=3D SCALAR_VALUE && reg->precise)
+		verbose(env, "P");
+	if ((t =3D=3D SCALAR_VALUE || t =3D=3D PTR_TO_STACK) &&
+	    tnum_is_const(reg->var_off)) {
+		/* reg->off should be 0 for SCALAR_VALUE */
+		verbose(env, "%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, t));
+		verbose(env, "%lld", reg->var_off.value + reg->off);
+		return;
+	}
+/*
+ * _a stands for append, was shortened to avoid multiline statements bel=
ow.
+ * This macro is used to output a comma separated list of attributes.
+ */
+#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS__);=
 sep =3D ","; })
+
+	verbose(env, "%s", reg_type_str(env, t));
+	if (base_type(t) =3D=3D PTR_TO_BTF_ID)
+		verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
+	verbose(env, "(");
+	if (reg->id)
+		verbose_a("id=3D%d", reg->id);
+	if (reg->ref_obj_id)
+		verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
+	if (type_is_non_owning_ref(reg->type))
+		verbose_a("%s", "non_own_ref");
+	if (t !=3D SCALAR_VALUE)
+		verbose_a("off=3D%d", reg->off);
+	if (type_is_pkt_pointer(t))
+		verbose_a("r=3D%d", reg->range);
+	else if (base_type(t) =3D=3D CONST_PTR_TO_MAP ||
+		 base_type(t) =3D=3D PTR_TO_MAP_KEY ||
+		 base_type(t) =3D=3D PTR_TO_MAP_VALUE)
+		verbose_a("ks=3D%d,vs=3D%d",
+			  reg->map_ptr->key_size,
+			  reg->map_ptr->value_size);
+	if (tnum_is_const(reg->var_off)) {
+		/* Typically an immediate SCALAR_VALUE, but
+		 * could be a pointer whose offset is too big
+		 * for reg->off
+		 */
+		verbose_a("imm=3D%llx", reg->var_off.value);
+	} else {
+		print_scalar_ranges(env, reg, &sep);
+		if (!tnum_is_unknown(reg->var_off)) {
+			char tn_buf[48];
+
+			tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+			verbose_a("var_off=3D%s", tn_buf);
+		}
+	}
+	verbose(env, ")");
+
+#undef verbose_a
+}
+
 void print_verifier_state(struct bpf_verifier_env *env, const struct bpf=
_func_state *state,
 			  bool print_all)
 {
@@ -564,69 +625,14 @@ void print_verifier_state(struct bpf_verifier_env *=
env, const struct bpf_func_st
 		verbose(env, " frame%d:", state->frameno);
 	for (i =3D 0; i < MAX_BPF_REG; i++) {
 		reg =3D &state->regs[i];
-		t =3D reg->type;
-		if (t =3D=3D NOT_INIT)
+		if (reg->type =3D=3D NOT_INIT)
 			continue;
 		if (!print_all && !reg_scratched(env, i))
 			continue;
 		verbose(env, " R%d", i);
 		print_liveness(env, reg->live);
 		verbose(env, "=3D");
-		if (t =3D=3D SCALAR_VALUE && reg->precise)
-			verbose(env, "P");
-		if ((t =3D=3D SCALAR_VALUE || t =3D=3D PTR_TO_STACK) &&
-		    tnum_is_const(reg->var_off)) {
-			/* reg->off should be 0 for SCALAR_VALUE */
-			verbose(env, "%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, t))=
;
-			verbose(env, "%lld", reg->var_off.value + reg->off);
-		} else {
-			const char *sep =3D "";
-
-			verbose(env, "%s", reg_type_str(env, t));
-			if (base_type(t) =3D=3D PTR_TO_BTF_ID)
-				verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
-			verbose(env, "(");
-/*
- * _a stands for append, was shortened to avoid multiline statements bel=
ow.
- * This macro is used to output a comma separated list of attributes.
- */
-#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS__);=
 sep =3D ","; })
-
-			if (reg->id)
-				verbose_a("id=3D%d", reg->id);
-			if (reg->ref_obj_id)
-				verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
-			if (type_is_non_owning_ref(reg->type))
-				verbose_a("%s", "non_own_ref");
-			if (t !=3D SCALAR_VALUE)
-				verbose_a("off=3D%d", reg->off);
-			if (type_is_pkt_pointer(t))
-				verbose_a("r=3D%d", reg->range);
-			else if (base_type(t) =3D=3D CONST_PTR_TO_MAP ||
-				 base_type(t) =3D=3D PTR_TO_MAP_KEY ||
-				 base_type(t) =3D=3D PTR_TO_MAP_VALUE)
-				verbose_a("ks=3D%d,vs=3D%d",
-					  reg->map_ptr->key_size,
-					  reg->map_ptr->value_size);
-			if (tnum_is_const(reg->var_off)) {
-				/* Typically an immediate SCALAR_VALUE, but
-				 * could be a pointer whose offset is too big
-				 * for reg->off
-				 */
-				verbose_a("imm=3D%llx", reg->var_off.value);
-			} else {
-				print_scalar_ranges(env, reg, &sep);
-				if (!tnum_is_unknown(reg->var_off)) {
-					char tn_buf[48];
-
-					tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-					verbose_a("var_off=3D%s", tn_buf);
-				}
-			}
-#undef verbose_a
-
-			verbose(env, ")");
-		}
+		print_reg_state(env, reg);
 	}
 	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
 		char types_buf[BPF_REG_SIZE + 1];
--=20
2.34.1


