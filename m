Return-Path: <bpf+bounces-71999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8530BC04C14
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 09:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85E6402163
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 07:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED19E2E6CC3;
	Fri, 24 Oct 2025 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iad6GyB9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3472E2DE6;
	Fri, 24 Oct 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291253; cv=none; b=Dy35+exU/yYwXPJGEcWTxLiOpm9KImNZM3Jkb68JbaAReCAKk9lWeUUo8tYziWRrUj3v3PWEDj+paYE0EPSJq2JWSu+oyiefA8N6/upoL5oHby8tgHkZaTRqpKjLBtLJw7gfoSchqVpLfE8GZ2jjTnULQq+xC+2nOkQJPmaHewo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291253; c=relaxed/simple;
	bh=LHfX99HybPRtLnMnbIWaFMCULw9nfKFbYV9Nalslgso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5XLiNJJr5eymrmsYCX+iUpR69BbLP6RHR0PcdIDX4644zKRGAy2zOYlYZybEXRNzKGWLMSEpH8ATPtgxVhQwk9PRCAB1BlH5eKRkNwBYXOEZ3WHVot6ILcyZlhD6jaPN7efCFBrtOBXGZYttvdomg35tuO/qhH/OTvmOe4hxH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iad6GyB9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3OFB4020773;
	Fri, 24 Oct 2025 07:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=MTIfn
	kAqvz7HGI3LZnMC2nPyrD2ygLYTkkHPdF5VuME=; b=Iad6GyB9worfQLkB4gsYN
	Q5XHplNHjMQEDJElz/xo+gm0yFI3w3GQGNqSj63PB2BVj7V9lSOLfs8uDVrgxeXL
	4HfRtl6ORPJj3G7EVJvvv1OwxEu+dPGf2MJ747NJFAQMEZo5XGLw5eUb5sIlfA8c
	WP6fiXkhtZ0AqTWB7iAoeKLKGQ8rQB0RtH6EOkOz7Q7ZX/pZcAcyUE9cHm0FM2uo
	NizF0L3KoNncqu1fst6+pD0fdDxyN30tzMhlRUeZUdTWCMzQAG/J5kraPjuEMQRR
	G0XFxTTr0kl2Kn8E477vfn5KavlQWIr3sK6jVkUiiki6i91gD8eqic6wJcFVSdoU
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vw3bq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6HeJC022289;
	Fri, 24 Oct 2025 07:33:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgm4km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:33:48 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59O7XYwl019356;
	Fri, 24 Oct 2025 07:33:47 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-57-127.vpn.oracle.com [10.154.57.127])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49v1bgm48v-5;
	Fri, 24 Oct 2025 07:33:47 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: dwarves@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC dwarves 4/5] btf_encoder: Support encoding of inline location information
Date: Fri, 24 Oct 2025 08:33:27 +0100
Message-ID: <20251024073328.370457-5-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251024073328.370457-1-alan.maguire@oracle.com>
References: <20251024073328.370457-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240065
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX5jjLbcJQSOUb
 PbrjKguL3Pdo9FFLNxXSatNaKzBKDoz+yzFb6HU2W2aKQEag9QV6k8nv3i15xuama2hk26nDG8t
 eqUNNXIuziWV8UVfR7BdlTQsMLaJcNrqyN2BqPohaoq81QoATwtoPG2f1exoSFYWzvTnRD52qS2
 yN0yfqe68mWt/v2HmSJQOfm4tdnHRheWPSAYQ57UZI2EBjeW6SqS+rBF8X+2ub30uf3IScloDE0
 DORw9vXL1POhfbiuDJ0IJ/enFxHi4rcVGQG8qg/Ww+IRwZx3h29HYqbkx8QQ972PEq8xYH4iUUG
 cST1q437x6GXvvLgureAwS999Tn3Lx6rvkw81EJyOvUCVVSOJltun18BxNfj5V6Dr8BE2gHU8O8
 xgDTQR2aNPpFCk3yOYlFAWa7hi0LzkynvwzuuqJ304mkIbDXVrU=
X-Proofpoint-ORIG-GUID: Gbv1tu5SKi45PYd6FjC1e3to1wl8Jlrd
X-Proofpoint-GUID: Gbv1tu5SKi45PYd6FjC1e3to1wl8Jlrd
X-Authority-Analysis: v=2.4 cv=FuwIPmrq c=1 sm=1 tr=0 ts=68fb2bdd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=SgRc0pz8ICCZHlU92ggA:9 cc=ntf awl=host:13624

This patch requires updated libbpf with APIs to add location
information.  Iterate over inline expansions saving prototype
and associated location info for later addition.  Location
info can either be added to .BTF or a new .BTF.extra section
which is split BTF relative to .BTF; this helps when size of
location info makes adding it to .BTF prohibitive.  To support
this we need to dedup .BTF first, then access the mappings of
types to ensure the types of the parameters and return values
of the functions associated with the inline sites get post-dedup
updates.  Finally the .BTF.extra section itself is deduplicated
allowing for FUNC_PROTO, LOC_PARAM and LOC_PROTO deduplication.

Multiple BTF_KIND_LOCSECs are added if there are more then
65535 (max value vlen can support).

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 btf_encoder.c | 396 +++++++++++++++++++++++++++++++++++++++++++++-----
 dwarves.h     |   9 ++
 2 files changed, 371 insertions(+), 34 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 710a122..ae56aa8 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -35,6 +35,7 @@
 #include <pthread.h>
 
 #define BTF_BASE_ELF_SEC	".BTF.base"
+#define BTF_EXTRA_ELF_SEC	".BTF.extra"
 #define BTF_IDS_SECTION		".BTF_ids"
 #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
 #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
@@ -43,6 +44,38 @@
 #define BTF_FASTCALL_TAG       "bpf_fastcall"
 #define BPF_ARENA_ATTR         "address_space(1)"
 
+/* For older libbpf may need to define BTF loc data. */
+#if !defined(BTF_KIND_LOC_UAPI_DEFINED) && !defined(BTF_KIND_LOC_LIBBPF_DEFINED)
+#define BTF_KIND_LOC_PARAM      20
+#define BTF_KIND_LOC_PROTO      21
+#define BTF_KIND_LOCSEC         22
+
+#define BTF_TYPE_LOC_PARAM_SIZE(t)      ((__s32)((t)->size))
+#define BTF_LOC_FLAG_DEREF		0x1
+#define BTF_LOC_FLAG_CONTINUE		0x2
+
+struct btf_loc_param {
+	union {
+		struct {
+			__u16 reg;      /* register number */
+			__u16 flags;    /* register dereference */
+			__s32 offset;   /* offset from register-stored address */
+		};
+		struct {
+			__u32 val_lo32; /* lo 32 bits of 64-bit value */
+			__u32 val_hi32; /* hi 32 bits of 64-bit value */
+		};
+	};
+};
+
+struct btf_loc {
+        __u32 name_off;
+        __u32 func_proto;
+        __u32 loc_proto;
+        __u32 offset;
+};
+#endif
+
 /* kfunc flags, see include/linux/btf.h in the kernel source */
 #define KF_FASTCALL   (1 << 12)
 #define KF_ARENA_RET  (1 << 13)
@@ -77,10 +110,25 @@ struct btf_encoder_func_annot {
 	int16_t component_idx;
 };
 
+struct loc_param {
+	struct parameter_loc *locs;
+	uint8_t nlocs;
+};
+
+struct loc {
+	char *name;
+	struct loc_param *params;
+	uint8_t nparams;
+	int func_proto_id;
+	int loc_proto_id;
+	uint32_t offset;
+};
+
 /* state used to do later encoding of saved functions */
 struct btf_encoder_func_state {
 	struct btf_encoder *encoder;
 	struct elf_function *elf;
+	struct loc *loc;
 	uint32_t type_id_off;
 	uint16_t nr_parms;
 	uint16_t nr_annots;
@@ -125,6 +173,12 @@ struct elf_functions {
 	int cnt;
 };
 
+struct btf_encoder_func_states {
+	struct btf_encoder_func_state *array;
+	int cnt;
+	int cap;
+};
+
 /*
  * cu: cu being processed.
  */
@@ -150,11 +204,9 @@ struct btf_encoder {
 	struct elf_secinfo *secinfo;
 	size_t             seccnt;
 	int                encode_vars;
-	struct {
-		struct btf_encoder_func_state *array;
-		int cnt;
-		int cap;
-	} func_states;
+	struct btf_encoder_func_states func_states;
+	struct btf_encoder_func_states loc_states;
+	__u32		   *dedup_map;
 	/* This is a list of elf_functions tables, one per ELF.
 	 * Multiple ELF modules can be processed in one pahole run,
 	 * so we have to store elf_functions tables per ELF.
@@ -812,14 +864,16 @@ static int btf__add_bpf_arena_type_tags(struct btf *btf, struct btf_encoder_func
 
 static inline bool is_kfunc_state(struct btf_encoder_func_state *state)
 {
-	return state && state->elf && state->elf->kfunc;
+	if (!state || !state->elf)
+		return false;
+	return state->elf->kfunc;
 }
 
 static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype,
 					   struct btf_encoder_func_state *state)
 {
+	struct btf *btf = encoder->btf;
 	const struct btf_type *t;
-	struct btf *btf;
 	struct parameter *param;
 	uint16_t nr_params, param_idx;
 	int32_t id, type_id;
@@ -829,19 +883,24 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 	assert(ftype != NULL || state != NULL);
 
 	if (is_kfunc_state(state) && encoder->tag_kfuncs && encoder->encode_attributes)
-		if (btf__add_bpf_arena_type_tags(encoder->btf, state) < 0)
+		if (btf__add_bpf_arena_type_tags(btf, state) < 0)
 			return -1;
 
 	/* add btf_type for func_proto */
 	if (ftype) {
-		btf = encoder->btf;
 		nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 		type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
 	} else if (state) {
-		encoder = state->encoder;
-		btf = state->encoder->btf;
 		nr_params = state->nr_parms;
 		type_id = state->ret_type_id;
+		/* ret type_id may need to be adjusted after dedup; if
+		 * dedup_map is present, adjust id to the post-dedup
+		 * id.  This is used when creating .BTF.extra which
+		 * refers to .BTF that has ben deduped; since we
+		 * recorded the type id it has changed due to dedup.
+		 */
+		if (encoder->dedup_map)
+			type_id = encoder->dedup_map[type_id];
 	} else {
 		return 0;
 	}
@@ -886,7 +945,13 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
 			 */
 			strncpy(tmp_name, name, sizeof(tmp_name) - 1);
 
-			if (btf_encoder__add_func_param(encoder, tmp_name, p->type_id,
+			/* Similar to above, parameter type_id may need to be
+			 * adjusted after dedup.
+			 */
+			type_id = p->type_id;
+			if (encoder->dedup_map)
+				type_id = encoder->dedup_map[p->type_id];
+			if (btf_encoder__add_func_param(encoder, tmp_name, type_id,
 							param_idx == nr_params))
 				return -1;
 		}
@@ -1165,26 +1230,27 @@ static bool funcs__match(struct btf_encoder_func_state *s1,
 	return true;
 }
 
-static struct btf_encoder_func_state *btf_encoder__alloc_func_state(struct btf_encoder *encoder)
+static struct btf_encoder_func_state *
+btf_encoder__alloc_func_state(struct btf_encoder_func_states *func_states)
 {
 	struct btf_encoder_func_state *state, *tmp;
 
-	if (encoder->func_states.cnt >= encoder->func_states.cap) {
+	if (func_states->cnt >= func_states->cap) {
 
 		/* We only need to grow to accommodate duplicate
 		 * function declarations across different CUs, so the
 		 * rate of the array growth shouldn't be high.
 		 */
-		encoder->func_states.cap += 64;
+		func_states->cap += 64;
 
-		tmp = realloc(encoder->func_states.array, sizeof(*tmp) * encoder->func_states.cap);
+		tmp = realloc(func_states->array, sizeof(*tmp) * func_states->cap);
 		if (!tmp)
 			return NULL;
 
-		encoder->func_states.array = tmp;
+		func_states->array = tmp;
 	}
 
-	state = &encoder->func_states.array[encoder->func_states.cnt++];
+	state = &func_states->array[func_states->cnt++];
 	memset(state, 0, sizeof(*state));
 
 	return state;
@@ -1217,6 +1283,9 @@ static bool elf_function__has_ambiguous_address(struct elf_function *func)
 	uint64_t addr = 0;
 	int i;
 
+	if (!func)
+		return false;
+
 	if (func->sym_cnt <= 1)
 		return false;
 
@@ -1232,30 +1301,33 @@ static bool elf_function__has_ambiguous_address(struct elf_function *func)
 	return false;
 }
 
-static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn, struct elf_function *func)
+static int btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn,
+				  struct elf_function *func, struct loc *loc)
 {
-	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(encoder);
+	struct btf_encoder_func_state *state = btf_encoder__alloc_func_state(loc ?
+					       &encoder->loc_states :
+					       &encoder->func_states);
 	struct ftype *ftype = &fn->proto;
 	struct btf *btf = encoder->btf;
 	struct llvm_annotation *annot;
 	struct parameter *param;
 	uint8_t param_idx = 0;
-	int str_off, err = 0;
+	int err = -ENOMEM;
+	int str_off;
 
 	if (!state)
 		return -ENOMEM;
 
 	state->encoder = encoder;
 	state->elf = func;
+	state->loc = loc;
 	state->ambiguous_addr = elf_function__has_ambiguous_address(func);
 	state->nr_parms = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
 	state->ret_type_id = ftype->tag.type == 0 ? 0 : encoder->type_id_off + ftype->tag.type;
 	if (state->nr_parms > 0) {
 		state->parms = zalloc(state->nr_parms * sizeof(*state->parms));
-		if (!state->parms) {
-			err = -ENOMEM;
+		if (!state->parms)
 			goto out;
-		}
 	}
 	state->inconsistent_proto = ftype->inconsistent_proto;
 	state->unexpected_reg = ftype->unexpected_reg;
@@ -1283,10 +1355,8 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
 		uint8_t idx = 0;
 
 		state->annots = zalloc(state->nr_annots * sizeof(*state->annots));
-		if (!state->annots) {
-			err = -ENOMEM;
+		if (!state->annots)
 			goto out;
-		}
 		list_for_each_entry(annot, &fn->annots, node) {
 			str_off = btf__add_str(encoder->btf, annot->value);
 			if (str_off < 0) {
@@ -1351,6 +1421,10 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
 	uint16_t idx;
 	int err;
 
+	/* If inline, skip. */
+	if (!state->elf)
+		return 0;
+
 	btf_fnproto_id = btf_encoder__add_func_proto(encoder, NULL, state);
 	name = func->name;
 	if (btf_fnproto_id >= 0)
@@ -1486,15 +1560,19 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
 		 */
 		add_to_btf |= !state->unexpected_reg && !state->inconsistent_proto && !state->uncertain_parm_loc && !state->ambiguous_addr;
 
-		if (state->uncertain_parm_loc)
+		if (!add_to_btf) {
 			btf_encoder__log_func_skip(encoder, saved_fns[i].elf,
-					"uncertain parameter location\n",
-					0, 0);
+				state->unexpected_reg ? "unexpected regs\n" :
+				state->inconsistent_proto ? "inconsistent prototype\n" :
+				state->uncertain_parm_loc ? "uncertain parameter locations\n" :
+				"ambiguous address location\n");
+		}
 
 		if (add_to_btf) {
 			err = btf_encoder__add_func(state->encoder, state);
 			if (err < 0)
 				goto out;
+
 		}
 	}
 
@@ -2108,8 +2186,146 @@ out:
 	return err;
 }
 
+static int saved_loc_funcs_cmp(const void *a, const void *b)
+{
+	const struct btf_encoder_func_state *al = a;
+	const struct btf_encoder_func_state *bl = b;
+
+	return al->loc->offset - bl->loc->offset;
+}
+
+static int btf_encoder__add_saved_loc_param(struct btf_encoder *encoder,
+					    struct loc_param *param,
+					    int32_t *param_ids,
+					    uint8_t *num_param_ids)
+
+{
+	uint16_t flags = param->nlocs > 1 ? BTF_LOC_FLAG_CONTINUE : 0;
+	uint64_t value;
+	bool is_const;
+	int32_t ret = 0;
+
+	/* do we have meaningful location data ? */
+	if (param->nlocs == 0)
+		goto out;
+
+	is_const = param->locs[0].is_const;
+	value = is_const ? param->locs[0].value : 0;
+	if (is_const) {
+		flags |= param->locs[0].flags;
+		if (param->locs[0].is_deref)
+			flags |= BTF_LOC_FLAG_DEREF;
+	}
+
+	ret = btf__add_loc_param(encoder->btf, param->locs[0].size, is_const, value,
+				 is_const ? 0 : param->locs[0].reg, flags,
+				 is_const ? 0 : param->locs[0].offset);
+	if (ret <= 0)
+		goto out;
+
+	if (ret > 0) {
+		param_ids[*num_param_ids] = ret;
+		if (param->nlocs == 2) {
+			(*num_param_ids)++;
+			is_const = param->locs[1].is_const;
+			value = is_const ? param->locs[1].value : 0;
+			flags = is_const ? 0 : param->locs[1].flags;
+			ret = btf__add_loc_param(encoder->btf,
+						 param->locs[1].size,
+						 is_const, value,
+						 is_const ? 0 : param->locs[1].reg,
+						 flags,
+						 is_const ? 0 : param->locs[1].offset);
+			if (ret > 0)
+				param_ids[*num_param_ids] = ret;
+		}
+	}
+out:
+	if (ret <= 0)
+		param_ids[*num_param_ids] = 0;
+
+	(*num_param_ids)++;
+	return ret;
+}
+
+static int32_t btf_encoder__add_locsecs(struct btf_encoder *encoder)
+{
+	struct btf_encoder_func_state *saved_loc_funcs = encoder->loc_states.array;
+	uint32_t i, nr_saved_loc_funcs = encoder->loc_states.cnt;
+	struct btf *btf = encoder->btf;
+	int32_t ret;
+
+	qsort(saved_loc_funcs, nr_saved_loc_funcs, sizeof(*saved_loc_funcs), saved_loc_funcs_cmp);
+
+	for (i = 0; i < nr_saved_loc_funcs; i++) {
+		struct btf_encoder_func_state *state = &saved_loc_funcs[i];
+		struct loc *loc = state->loc;
+		int32_t param_ids[32] = {};
+		uint8_t j = 0, num_param_ids = 0;
+
+		loc->func_proto_id = btf_encoder__add_func_proto(encoder, NULL, state);
+		if (loc->func_proto_id < 0) {
+			btf__log_err(btf, BTF_KIND_FUNC_PROTO, "func_proto", true,
+				     loc->func_proto_id,
+				     "Error emitting BTF func proto");
+		}
+		for (j = 0; j < loc->nparams; j++) {
+			ret = btf_encoder__add_saved_loc_param(encoder, &loc->params[j],
+							       param_ids, &num_param_ids);
+			if (ret < 0)
+				return ret;
+		}
+		loc->loc_proto_id = btf__add_loc_proto(btf);
+		if (loc->loc_proto_id < 0) {
+			btf__log_err(btf, BTF_KIND_LOC_PROTO, "loc_proto", true, loc->loc_proto_id,
+				     "Error emitting BTF location prototype");
+			return loc->loc_proto_id;
+		}
+		for (j = 0; j < num_param_ids; j++) {
+			ret = btf__add_loc_proto_param(btf, param_ids[j]);
+			if (ret < 0) {
+				btf__log_err(btf, BTF_KIND_LOC_PROTO, "loc_proto_param", true, ret,
+					     "Error emitting BTF location prototype param for %u",
+					     loc->loc_proto_id);
+				return ret;
+			}
+		}
+	}
+	for (i = 0; i < nr_saved_loc_funcs; i++) {
+		struct loc *loc = saved_loc_funcs[i].loc;
+
+		/* vlen max is 65535, so add a new locsec for each
+		 * 65535 locations.
+		 */
+		if (i == 0 || (i % 0xffff) == 0) {
+			int32_t id = btf__add_locsec(btf, "inline");
+
+			if (id < 0) {
+				btf__log_err(btf, BTF_KIND_LOCSEC, "inline",
+					     true, id, "Error emitting BTF type");
+				return id;
+			}
+		}
+		ret = btf__add_locsec_loc(btf, loc->name, loc->func_proto_id, loc->loc_proto_id,
+					 loc->offset);
+		if (ret < 0) {
+			btf__log_err(btf, BTF_KIND_LOCSEC, "inline", true, ret,
+				     "Error emitting BTF loc");
+			return ret;
+		}
+	}
+	return 0;
+}
+
 int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 {
+#if defined(BTF_KIND_LOC_UAPI_DEFINED) || defined(BTF_KIND_LOC_LIBBPF_DEFINED)
+	size_t map_sz = 0;
+	LIBBPF_OPTS(btf_dedup_opts, dedup_opts, .dedup_map = &encoder->dedup_map,
+		    .dedup_map_sz = &map_sz);
+#else
+	LIBBPF_OPTS(btf_dedup_opts, dedup_opts);
+#endif
 	int err;
 	size_t shndx;
 
@@ -2121,11 +2337,14 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 		if (gobuffer__size(&encoder->secinfo[shndx].secinfo))
 			btf_encoder__add_datasec(encoder, shndx);
 
+	if (encoder->loc_states.cnt && !conf->btf_gen_inlines_extra)
+		btf_encoder__add_locsecs(encoder);
+
 	/* Empty file, nothing to do, so... done! */
 	if (btf__type_cnt(encoder->btf) == 1)
 		return 0;
 
-	if (btf__dedup(encoder->btf, NULL)) {
+	if (btf__dedup(encoder->btf, &dedup_opts)) {
 		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
 		return -1;
 	}
@@ -2159,6 +2378,20 @@ int btf_encoder__encode(struct btf_encoder *encoder, struct conf_load *conf)
 			return err;
 		}
 		err = btf_encoder__write_elf(encoder, encoder->btf, BTF_ELF_SEC);
+		if (!err && conf->btf_gen_inlines_extra) {
+			struct btf *base = encoder->btf;
+
+			encoder->btf = btf__new_empty_split(base);
+			encoder->type_id_off = btf__type_cnt(base) - 1;
+			err = btf_encoder__add_locsecs(encoder);
+			if (!err)
+				err = btf__dedup(encoder->btf, NULL);
+			if (!err)
+				err = btf_encoder__write_elf(encoder, encoder->btf,
+							     BTF_EXTRA_ELF_SEC);
+			btf__free(encoder->btf);
+			encoder->btf = base;
+		}
 	}
 
 	elf_functions_list__clear(&encoder->elf_functions_list);
@@ -2320,7 +2553,7 @@ static size_t get_elf_section(struct btf_encoder *encoder, uint64_t addr)
  * values. Prefixes should be added sparingly, and it should be objectively
  * obvious that they are not useful.
  */
-static bool filter_variable_name(const char *name)
+static bool filter_name(const char *name)
 {
 	static const struct { char *s; size_t len; } skip[] = {
 		#define X(str) {str, sizeof(str) - 1}
@@ -2429,7 +2662,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		if (!name)
 			continue;
 
-		if (filter_variable_name(name))
+		if (filter_name(name))
 			continue;
 
 		/* A 0 address may be in a "discard" section; DWARF provides
@@ -2689,6 +2922,74 @@ static bool ftype__has_uncertain_arg_loc(struct cu *cu, struct ftype *ftype)
 	return false;
 }
 
+/* save loc params for later addition. */
+static int btf_encoder__add_loc_param(struct btf_encoder *encoder,
+				      struct inline_expansion *ie,
+				      struct parameter *param,
+				      uint64_t base,
+				      struct loc_param *lp)
+{
+	uint8_t i, nlocs;
+
+	nlocs = param->nlocs;
+	if (nlocs) {
+		lp->locs = calloc(nlocs, sizeof(struct parameter_loc));
+		if (!lp->locs)
+			return -ENOMEM;
+		memcpy(lp->locs, param->locs, nlocs * sizeof(struct parameter_loc));
+	}
+	lp->nlocs = nlocs;
+	for (i = 0; i < nlocs; i++) {
+		if (param->locs[i].is_addr && lp->locs[i].value >= base)
+			lp->locs[i].value -= base;
+	}
+	return nlocs;
+}
+
+static int btf_encoder__add_inline_expansion(struct btf_encoder *encoder,
+				      struct inline_expansion *ie, uint64_t base)
+{
+	struct loc *loc = calloc(1, sizeof(*loc));
+	struct parameter *param = NULL;
+	int err = -ENOMEM;
+
+	if (loc)
+		loc->name = strdup(ie->function->name);
+	if (!loc || !loc->name)
+		goto out;
+
+	inline_expansion__for_each_parameter(ie, param) {
+		loc->nparams++;
+	}
+
+	if (loc->nparams > 0) {
+		int i = 0;
+
+		loc->params = calloc(loc->nparams, sizeof(struct loc_param));
+		if (!loc->params)
+			goto out;
+		param = NULL;
+		inline_expansion__for_each_parameter(ie, param) {
+			err = btf_encoder__add_loc_param(encoder, ie, param, base,
+							 &loc->params[i++]);
+			if (err < 0)
+				goto out;
+		}
+	}
+	loc->offset = (uint32_t)(ie->ip.addr - base);
+
+	err = btf_encoder__save_func(encoder, ie->function, NULL, loc);
+	if (!err)
+		return 0;
+out:
+	if (loc) {
+		free(loc->name);
+		free(loc->params);
+	}
+	free(loc);
+	return err;
+}
+
 int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
 {
 	struct llvm_annotation *annot;
@@ -2696,8 +2997,11 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	struct elf_functions *funcs;
 	uint32_t core_id;
 	struct function *fn;
+	struct inline_expansion *ie;
+	uint64_t base = 0;
 	struct tag *pos;
 	int err = 0;
+	size_t i;
 
 	encoder->cu = cu;
 	funcs = btf_encoder__elf_functions(encoder);
@@ -2815,11 +3119,35 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 		if (ftype__has_uncertain_arg_loc(cu, &fn->proto))
 			fn->proto.uncertain_parm_loc = 1;
 
-		err = btf_encoder__save_func(encoder, fn, func);
+		err = btf_encoder__save_func(encoder, fn, func, NULL);
 		if (err)
 			goto out;
 	}
 
+	core_id = 0;
+
+	/* Use .text base to adjust addresses from absolute to relative;
+	 * other sections like discarded-after init sections have different
+	 * ELF section base but a single global adjustment for kernel/module
+	 * is easier to manage.
+	 */
+	for (i = 1; i < encoder->seccnt; i++) {
+		if (!(encoder->secinfo[i].type == SHT_PROGBITS))
+			continue;
+		if (strcmp(encoder->secinfo[i].name, ".text") == 0) {
+			base = encoder->secinfo[i].addr;
+			break;
+		}
+	}
+
+	if (conf_load->btf_gen_inlines) {
+		cu__for_each_inline_expansion(cu, core_id, ie) {
+			if (!ie->ip.addr || !ie->name || filter_name(ie->name))
+				continue;
+			btf_encoder__add_inline_expansion(encoder, ie, base);
+		}
+	}
+
 	if (encoder->encode_vars)
 		err = btf_encoder__encode_cu_variables(encoder);
 
diff --git a/dwarves.h b/dwarves.h
index d6efdd0..df6a518 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -55,6 +55,13 @@ __weak extern int btf__add_enum64(struct btf *btf, const char *name, __u32 byte_
 __weak extern int btf__add_enum64_value(struct btf *btf, const char *name, __u64 value);
 __weak extern int btf__add_type_attr(struct btf *btf, const char *value, int ref_type_id);
 __weak extern int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf, struct btf **new_split_btf);
+__weak extern int btf__add_loc_param(struct btf *btf, __s32 size, bool is_value, __u64 value,
+				     __u16 reg, __u16 flags, __s32 offset);
+__weak extern int btf__add_loc_proto(struct btf *btf);
+__weak extern int btf__add_loc_proto_param(struct btf *btf, __u32 id);
+__weak extern int btf__add_locsec(struct btf *btf, const char *name);
+__weak extern int btf__add_locsec_loc(struct btf *btf, const char *name, __u32 func_proto,
+				      __u32 loc_proto, __u32 offset);
 
 /*
  * BTF combines all the types into one big CU using btf_dedup(), so for something
@@ -100,6 +107,8 @@ struct conf_load {
 	bool			reproducible_build;
 	bool			btf_decl_tag_kfuncs;
 	bool			btf_gen_distilled_base;
+	bool			btf_gen_inlines;
+	bool			btf_gen_inlines_extra;	/* target .BTF.extra? */
 	bool			btf_attributes;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
-- 
2.39.3


