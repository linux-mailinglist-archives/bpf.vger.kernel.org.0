Return-Path: <bpf+bounces-14775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9D7E7D9E
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E141C20AC5
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4F81DDD2;
	Fri, 10 Nov 2023 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB351DFCF
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 16:11:14 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305753BF3C
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:11 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AAER3PH029082
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:10 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u97ht62j5-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 08:11:10 -0800
Received: from twshared15991.38.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 08:11:09 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 46E0A3B49982D; Fri, 10 Nov 2023 08:11:03 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 2/8] bpf: move verifier state printing code to kernel/bpf/log.c
Date: Fri, 10 Nov 2023 08:10:51 -0800
Message-ID: <20231110161057.1943534-3-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110161057.1943534-1-andrii@kernel.org>
References: <20231110161057.1943534-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0iRwB0BnXx91ghk8ehSeJq6ftUiQjh1W
X-Proofpoint-GUID: 0iRwB0BnXx91ghk8ehSeJq6ftUiQjh1W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_13,2023-11-09_01,2023-05-22_02

Move a good chunk of code from verifier.c to log.c: verifier state
verbose printing logic. This is an important and very much
logging/debugging oriented code. It fits the overlall log.c's focus on
verifier logging, and moving it allows to keep growing it without
unnecessarily adding to verifier.c code that otherwise contains a core
verification logic.

There are not many shared dependencies between this code and the rest of
verifier.c code, except a few single-line helpers for various register
type checks and a bit of state "scratching" helpers. We move all such
trivial helpers into include/bpf/bpf_verifier.h as static inlines.

No functional changes in this patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h |  72 +++++++
 kernel/bpf/log.c             | 342 +++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 403 -----------------------------------
 3 files changed, 414 insertions(+), 403 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d7898f636929..22f56f1eb27d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -782,4 +782,76 @@ static inline bool bpf_type_has_unsafe_modifiers(u32=
 type)
 	return type_flag(type) & ~BPF_REG_TRUSTED_MODIFIERS;
 }
=20
+static inline bool type_is_ptr_alloc_obj(u32 type)
+{
+	return base_type(type) =3D=3D PTR_TO_BTF_ID && type_flag(type) & MEM_AL=
LOC;
+}
+
+static inline bool type_is_non_owning_ref(u32 type)
+{
+	return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
+}
+
+static inline bool type_is_pkt_pointer(enum bpf_reg_type type)
+{
+	type =3D base_type(type);
+	return type =3D=3D PTR_TO_PACKET ||
+	       type =3D=3D PTR_TO_PACKET_META;
+}
+
+static inline bool type_is_sk_pointer(enum bpf_reg_type type)
+{
+	return type =3D=3D PTR_TO_SOCKET ||
+		type =3D=3D PTR_TO_SOCK_COMMON ||
+		type =3D=3D PTR_TO_TCP_SOCK ||
+		type =3D=3D PTR_TO_XDP_SOCK;
+}
+
+static inline void mark_reg_scratched(struct bpf_verifier_env *env, u32 =
regno)
+{
+	env->scratched_regs |=3D 1U << regno;
+}
+
+static inline void mark_stack_slot_scratched(struct bpf_verifier_env *en=
v, u32 spi)
+{
+	env->scratched_stack_slots |=3D 1ULL << spi;
+}
+
+static inline bool reg_scratched(const struct bpf_verifier_env *env, u32=
 regno)
+{
+	return (env->scratched_regs >> regno) & 1;
+}
+
+static inline bool stack_slot_scratched(const struct bpf_verifier_env *e=
nv, u64 regno)
+{
+	return (env->scratched_stack_slots >> regno) & 1;
+}
+
+static inline bool verifier_state_scratched(const struct bpf_verifier_en=
v *env)
+{
+	return env->scratched_regs || env->scratched_stack_slots;
+}
+
+static inline void mark_verifier_state_clean(struct bpf_verifier_env *en=
v)
+{
+	env->scratched_regs =3D 0U;
+	env->scratched_stack_slots =3D 0ULL;
+}
+
+/* Used for printing the entire verifier state. */
+static inline void mark_verifier_state_scratched(struct bpf_verifier_env=
 *env)
+{
+	env->scratched_regs =3D ~0U;
+	env->scratched_stack_slots =3D ~0ULL;
+}
+
+const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type=
 type);
+const char *dynptr_type_str(enum bpf_dynptr_type type);
+const char *iter_type_str(const struct btf *btf, u32 btf_id);
+const char *iter_state_str(enum bpf_iter_state state);
+
+void print_verifier_state(struct bpf_verifier_env *env,
+			  const struct bpf_func_state *state, bool print_all);
+void print_insn_state(struct bpf_verifier_env *env, const struct bpf_fun=
c_state *state);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index f20e1449c882..c1b257eac21b 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -384,3 +384,345 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifi=
er_env *env,
=20
 	env->prev_linfo =3D linfo;
 }
+
+static const char *btf_type_name(const struct btf *btf, u32 id)
+{
+	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
+}
+
+/* string representation of 'enum bpf_reg_type'
+ *
+ * Note that reg_type_str() can not appear more than once in a single ve=
rbose()
+ * statement.
+ */
+const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type=
 type)
+{
+	char postfix[16] =3D {0}, prefix[64] =3D {0};
+	static const char * const str[] =3D {
+		[NOT_INIT]		=3D "?",
+		[SCALAR_VALUE]		=3D "scalar",
+		[PTR_TO_CTX]		=3D "ctx",
+		[CONST_PTR_TO_MAP]	=3D "map_ptr",
+		[PTR_TO_MAP_VALUE]	=3D "map_value",
+		[PTR_TO_STACK]		=3D "fp",
+		[PTR_TO_PACKET]		=3D "pkt",
+		[PTR_TO_PACKET_META]	=3D "pkt_meta",
+		[PTR_TO_PACKET_END]	=3D "pkt_end",
+		[PTR_TO_FLOW_KEYS]	=3D "flow_keys",
+		[PTR_TO_SOCKET]		=3D "sock",
+		[PTR_TO_SOCK_COMMON]	=3D "sock_common",
+		[PTR_TO_TCP_SOCK]	=3D "tcp_sock",
+		[PTR_TO_TP_BUFFER]	=3D "tp_buffer",
+		[PTR_TO_XDP_SOCK]	=3D "xdp_sock",
+		[PTR_TO_BTF_ID]		=3D "ptr_",
+		[PTR_TO_MEM]		=3D "mem",
+		[PTR_TO_BUF]		=3D "buf",
+		[PTR_TO_FUNC]		=3D "func",
+		[PTR_TO_MAP_KEY]	=3D "map_key",
+		[CONST_PTR_TO_DYNPTR]	=3D "dynptr_ptr",
+	};
+
+	if (type & PTR_MAYBE_NULL) {
+		if (base_type(type) =3D=3D PTR_TO_BTF_ID)
+			strncpy(postfix, "or_null_", 16);
+		else
+			strncpy(postfix, "_or_null", 16);
+	}
+
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
+		 type & MEM_RDONLY ? "rdonly_" : "",
+		 type & MEM_RINGBUF ? "ringbuf_" : "",
+		 type & MEM_USER ? "user_" : "",
+		 type & MEM_PERCPU ? "percpu_" : "",
+		 type & MEM_RCU ? "rcu_" : "",
+		 type & PTR_UNTRUSTED ? "untrusted_" : "",
+		 type & PTR_TRUSTED ? "trusted_" : ""
+	);
+
+	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
+		 prefix, str[base_type(type)], postfix);
+	return env->tmp_str_buf;
+}
+
+const char *dynptr_type_str(enum bpf_dynptr_type type)
+{
+	switch (type) {
+	case BPF_DYNPTR_TYPE_LOCAL:
+		return "local";
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		return "ringbuf";
+	case BPF_DYNPTR_TYPE_SKB:
+		return "skb";
+	case BPF_DYNPTR_TYPE_XDP:
+		return "xdp";
+	case BPF_DYNPTR_TYPE_INVALID:
+		return "<invalid>";
+	default:
+		WARN_ONCE(1, "unknown dynptr type %d\n", type);
+		return "<unknown>";
+	}
+}
+
+const char *iter_type_str(const struct btf *btf, u32 btf_id)
+{
+	if (!btf || btf_id =3D=3D 0)
+		return "<invalid>";
+
+	/* we already validated that type is valid and has conforming name */
+	return btf_type_name(btf, btf_id) + sizeof(ITER_PREFIX) - 1;
+}
+
+const char *iter_state_str(enum bpf_iter_state state)
+{
+	switch (state) {
+	case BPF_ITER_STATE_ACTIVE:
+		return "active";
+	case BPF_ITER_STATE_DRAINED:
+		return "drained";
+	case BPF_ITER_STATE_INVALID:
+		return "<invalid>";
+	default:
+		WARN_ONCE(1, "unknown iter state %d\n", state);
+		return "<unknown>";
+	}
+}
+
+static char slot_type_char[] =3D {
+	[STACK_INVALID]	=3D '?',
+	[STACK_SPILL]	=3D 'r',
+	[STACK_MISC]	=3D 'm',
+	[STACK_ZERO]	=3D '0',
+	[STACK_DYNPTR]	=3D 'd',
+	[STACK_ITER]	=3D 'i',
+};
+
+static void print_liveness(struct bpf_verifier_env *env,
+			   enum bpf_reg_liveness live)
+{
+	if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN | REG_LIVE_DONE))
+	    verbose(env, "_");
+	if (live & REG_LIVE_READ)
+		verbose(env, "r");
+	if (live & REG_LIVE_WRITTEN)
+		verbose(env, "w");
+	if (live & REG_LIVE_DONE)
+		verbose(env, "D");
+}
+
+static void print_scalar_ranges(struct bpf_verifier_env *env,
+				const struct bpf_reg_state *reg,
+				const char **sep)
+{
+	struct {
+		const char *name;
+		u64 val;
+		bool omit;
+	} minmaxs[] =3D {
+		{"smin",   reg->smin_value,         reg->smin_value =3D=3D S64_MIN},
+		{"smax",   reg->smax_value,         reg->smax_value =3D=3D S64_MAX},
+		{"umin",   reg->umin_value,         reg->umin_value =3D=3D 0},
+		{"umax",   reg->umax_value,         reg->umax_value =3D=3D U64_MAX},
+		{"smin32", (s64)reg->s32_min_value, reg->s32_min_value =3D=3D S32_MIN}=
,
+		{"smax32", (s64)reg->s32_max_value, reg->s32_max_value =3D=3D S32_MAX}=
,
+		{"umin32", reg->u32_min_value,      reg->u32_min_value =3D=3D 0},
+		{"umax32", reg->u32_max_value,      reg->u32_max_value =3D=3D U32_MAX}=
,
+	}, *m1, *m2, *mend =3D &minmaxs[ARRAY_SIZE(minmaxs)];
+	bool neg1, neg2;
+
+	for (m1 =3D &minmaxs[0]; m1 < mend; m1++) {
+		if (m1->omit)
+			continue;
+
+		neg1 =3D m1->name[0] =3D=3D 's' && (s64)m1->val < 0;
+
+		verbose(env, "%s%s=3D", *sep, m1->name);
+		*sep =3D ",";
+
+		for (m2 =3D m1 + 2; m2 < mend; m2 +=3D 2) {
+			if (m2->omit || m2->val !=3D m1->val)
+				continue;
+			/* don't mix negatives with positives */
+			neg2 =3D m2->name[0] =3D=3D 's' && (s64)m2->val < 0;
+			if (neg2 !=3D neg1)
+				continue;
+			m2->omit =3D true;
+			verbose(env, "%s=3D", m2->name);
+		}
+
+		verbose(env, m1->name[0] =3D=3D 's' ? "%lld" : "%llu", m1->val);
+	}
+}
+
+void print_verifier_state(struct bpf_verifier_env *env, const struct bpf=
_func_state *state,
+			  bool print_all)
+{
+	const struct bpf_reg_state *reg;
+	enum bpf_reg_type t;
+	int i;
+
+	if (state->frameno)
+		verbose(env, " frame%d:", state->frameno);
+	for (i =3D 0; i < MAX_BPF_REG; i++) {
+		reg =3D &state->regs[i];
+		t =3D reg->type;
+		if (t =3D=3D NOT_INIT)
+			continue;
+		if (!print_all && !reg_scratched(env, i))
+			continue;
+		verbose(env, " R%d", i);
+		print_liveness(env, reg->live);
+		verbose(env, "=3D");
+		if (t =3D=3D SCALAR_VALUE && reg->precise)
+			verbose(env, "P");
+		if ((t =3D=3D SCALAR_VALUE || t =3D=3D PTR_TO_STACK) &&
+		    tnum_is_const(reg->var_off)) {
+			/* reg->off should be 0 for SCALAR_VALUE */
+			verbose(env, "%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, t))=
;
+			verbose(env, "%lld", reg->var_off.value + reg->off);
+		} else {
+			const char *sep =3D "";
+
+			verbose(env, "%s", reg_type_str(env, t));
+			if (base_type(t) =3D=3D PTR_TO_BTF_ID)
+				verbose(env, "%s", btf_type_name(reg->btf, reg->btf_id));
+			verbose(env, "(");
+/*
+ * _a stands for append, was shortened to avoid multiline statements bel=
ow.
+ * This macro is used to output a comma separated list of attributes.
+ */
+#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS__);=
 sep =3D ","; })
+
+			if (reg->id)
+				verbose_a("id=3D%d", reg->id);
+			if (reg->ref_obj_id)
+				verbose_a("ref_obj_id=3D%d", reg->ref_obj_id);
+			if (type_is_non_owning_ref(reg->type))
+				verbose_a("%s", "non_own_ref");
+			if (t !=3D SCALAR_VALUE)
+				verbose_a("off=3D%d", reg->off);
+			if (type_is_pkt_pointer(t))
+				verbose_a("r=3D%d", reg->range);
+			else if (base_type(t) =3D=3D CONST_PTR_TO_MAP ||
+				 base_type(t) =3D=3D PTR_TO_MAP_KEY ||
+				 base_type(t) =3D=3D PTR_TO_MAP_VALUE)
+				verbose_a("ks=3D%d,vs=3D%d",
+					  reg->map_ptr->key_size,
+					  reg->map_ptr->value_size);
+			if (tnum_is_const(reg->var_off)) {
+				/* Typically an immediate SCALAR_VALUE, but
+				 * could be a pointer whose offset is too big
+				 * for reg->off
+				 */
+				verbose_a("imm=3D%llx", reg->var_off.value);
+			} else {
+				print_scalar_ranges(env, reg, &sep);
+				if (!tnum_is_unknown(reg->var_off)) {
+					char tn_buf[48];
+
+					tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
+					verbose_a("var_off=3D%s", tn_buf);
+				}
+			}
+#undef verbose_a
+
+			verbose(env, ")");
+		}
+	}
+	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
+		char types_buf[BPF_REG_SIZE + 1];
+		bool valid =3D false;
+		int j;
+
+		for (j =3D 0; j < BPF_REG_SIZE; j++) {
+			if (state->stack[i].slot_type[j] !=3D STACK_INVALID)
+				valid =3D true;
+			types_buf[j] =3D slot_type_char[state->stack[i].slot_type[j]];
+		}
+		types_buf[BPF_REG_SIZE] =3D 0;
+		if (!valid)
+			continue;
+		if (!print_all && !stack_slot_scratched(env, i))
+			continue;
+		switch (state->stack[i].slot_type[BPF_REG_SIZE - 1]) {
+		case STACK_SPILL:
+			reg =3D &state->stack[i].spilled_ptr;
+			t =3D reg->type;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
+			verbose(env, "=3D%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, =
t));
+			if (t =3D=3D SCALAR_VALUE && reg->precise)
+				verbose(env, "P");
+			if (t =3D=3D SCALAR_VALUE && tnum_is_const(reg->var_off))
+				verbose(env, "%lld", reg->var_off.value + reg->off);
+			break;
+		case STACK_DYNPTR:
+			i +=3D BPF_DYNPTR_NR_SLOTS - 1;
+			reg =3D &state->stack[i].spilled_ptr;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
+			verbose(env, "=3Ddynptr_%s", dynptr_type_str(reg->dynptr.type));
+			if (reg->ref_obj_id)
+				verbose(env, "(ref_id=3D%d)", reg->ref_obj_id);
+			break;
+		case STACK_ITER:
+			/* only main slot has ref_obj_id set; skip others */
+			reg =3D &state->stack[i].spilled_ptr;
+			if (!reg->ref_obj_id)
+				continue;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
+			verbose(env, "=3Diter_%s(ref_id=3D%d,state=3D%s,depth=3D%u)",
+				iter_type_str(reg->iter.btf, reg->iter.btf_id),
+				reg->ref_obj_id, iter_state_str(reg->iter.state),
+				reg->iter.depth);
+			break;
+		case STACK_MISC:
+		case STACK_ZERO:
+		default:
+			reg =3D &state->stack[i].spilled_ptr;
+
+			for (j =3D 0; j < BPF_REG_SIZE; j++)
+				types_buf[j] =3D slot_type_char[state->stack[i].slot_type[j]];
+			types_buf[BPF_REG_SIZE] =3D 0;
+
+			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
+			print_liveness(env, reg->live);
+			verbose(env, "=3D%s", types_buf);
+			break;
+		}
+	}
+	if (state->acquired_refs && state->refs[0].id) {
+		verbose(env, " refs=3D%d", state->refs[0].id);
+		for (i =3D 1; i < state->acquired_refs; i++)
+			if (state->refs[i].id)
+				verbose(env, ",%d", state->refs[i].id);
+	}
+	if (state->in_callback_fn)
+		verbose(env, " cb");
+	if (state->in_async_callback_fn)
+		verbose(env, " async_cb");
+	verbose(env, "\n");
+	if (!print_all)
+		mark_verifier_state_clean(env);
+}
+
+static inline u32 vlog_alignment(u32 pos)
+{
+	return round_up(max(pos + BPF_LOG_MIN_ALIGNMENT / 2, BPF_LOG_ALIGNMENT)=
,
+			BPF_LOG_MIN_ALIGNMENT) - pos - 1;
+}
+
+void print_insn_state(struct bpf_verifier_env *env, const struct bpf_fun=
c_state *state)
+{
+	if (env->prev_log_pos && env->prev_log_pos =3D=3D env->log.end_pos) {
+		/* remove new line character */
+		bpf_vlog_reset(&env->log, env->prev_log_pos - 1);
+		verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_pos), ' ');
+	} else {
+		verbose(env, "%d:", env->insn_idx);
+	}
+	print_verifier_state(env, state, false);
+}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d2830d384d9b..cf574b69477c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -368,21 +368,6 @@ static void verbose_invalid_scalar(struct bpf_verifi=
er_env *env,
 	verbose(env, " should have been in %s\n", tn_buf);
 }
=20
-static bool type_is_pkt_pointer(enum bpf_reg_type type)
-{
-	type =3D base_type(type);
-	return type =3D=3D PTR_TO_PACKET ||
-	       type =3D=3D PTR_TO_PACKET_META;
-}
-
-static bool type_is_sk_pointer(enum bpf_reg_type type)
-{
-	return type =3D=3D PTR_TO_SOCKET ||
-		type =3D=3D PTR_TO_SOCK_COMMON ||
-		type =3D=3D PTR_TO_TCP_SOCK ||
-		type =3D=3D PTR_TO_XDP_SOCK;
-}
-
 static bool type_may_be_null(u32 type)
 {
 	return type & PTR_MAYBE_NULL;
@@ -406,16 +391,6 @@ static bool reg_not_null(const struct bpf_reg_state =
*reg)
 		type =3D=3D PTR_TO_MEM;
 }
=20
-static bool type_is_ptr_alloc_obj(u32 type)
-{
-	return base_type(type) =3D=3D PTR_TO_BTF_ID && type_flag(type) & MEM_AL=
LOC;
-}
-
-static bool type_is_non_owning_ref(u32 type)
-{
-	return type_is_ptr_alloc_obj(type) && type_flag(type) & NON_OWN_REF;
-}
-
 static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg=
)
 {
 	struct btf_record *rec =3D NULL;
@@ -532,83 +507,6 @@ static bool is_cmpxchg_insn(const struct bpf_insn *i=
nsn)
 	       insn->imm =3D=3D BPF_CMPXCHG;
 }
=20
-/* string representation of 'enum bpf_reg_type'
- *
- * Note that reg_type_str() can not appear more than once in a single ve=
rbose()
- * statement.
- */
-static const char *reg_type_str(struct bpf_verifier_env *env,
-				enum bpf_reg_type type)
-{
-	char postfix[16] =3D {0}, prefix[64] =3D {0};
-	static const char * const str[] =3D {
-		[NOT_INIT]		=3D "?",
-		[SCALAR_VALUE]		=3D "scalar",
-		[PTR_TO_CTX]		=3D "ctx",
-		[CONST_PTR_TO_MAP]	=3D "map_ptr",
-		[PTR_TO_MAP_VALUE]	=3D "map_value",
-		[PTR_TO_STACK]		=3D "fp",
-		[PTR_TO_PACKET]		=3D "pkt",
-		[PTR_TO_PACKET_META]	=3D "pkt_meta",
-		[PTR_TO_PACKET_END]	=3D "pkt_end",
-		[PTR_TO_FLOW_KEYS]	=3D "flow_keys",
-		[PTR_TO_SOCKET]		=3D "sock",
-		[PTR_TO_SOCK_COMMON]	=3D "sock_common",
-		[PTR_TO_TCP_SOCK]	=3D "tcp_sock",
-		[PTR_TO_TP_BUFFER]	=3D "tp_buffer",
-		[PTR_TO_XDP_SOCK]	=3D "xdp_sock",
-		[PTR_TO_BTF_ID]		=3D "ptr_",
-		[PTR_TO_MEM]		=3D "mem",
-		[PTR_TO_BUF]		=3D "buf",
-		[PTR_TO_FUNC]		=3D "func",
-		[PTR_TO_MAP_KEY]	=3D "map_key",
-		[CONST_PTR_TO_DYNPTR]	=3D "dynptr_ptr",
-	};
-
-	if (type & PTR_MAYBE_NULL) {
-		if (base_type(type) =3D=3D PTR_TO_BTF_ID)
-			strncpy(postfix, "or_null_", 16);
-		else
-			strncpy(postfix, "_or_null", 16);
-	}
-
-	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s%s",
-		 type & MEM_RDONLY ? "rdonly_" : "",
-		 type & MEM_RINGBUF ? "ringbuf_" : "",
-		 type & MEM_USER ? "user_" : "",
-		 type & MEM_PERCPU ? "percpu_" : "",
-		 type & MEM_RCU ? "rcu_" : "",
-		 type & PTR_UNTRUSTED ? "untrusted_" : "",
-		 type & PTR_TRUSTED ? "trusted_" : ""
-	);
-
-	snprintf(env->tmp_str_buf, TMP_STR_BUF_LEN, "%s%s%s",
-		 prefix, str[base_type(type)], postfix);
-	return env->tmp_str_buf;
-}
-
-static char slot_type_char[] =3D {
-	[STACK_INVALID]	=3D '?',
-	[STACK_SPILL]	=3D 'r',
-	[STACK_MISC]	=3D 'm',
-	[STACK_ZERO]	=3D '0',
-	[STACK_DYNPTR]	=3D 'd',
-	[STACK_ITER]	=3D 'i',
-};
-
-static void print_liveness(struct bpf_verifier_env *env,
-			   enum bpf_reg_liveness live)
-{
-	if (live & (REG_LIVE_READ | REG_LIVE_WRITTEN | REG_LIVE_DONE))
-	    verbose(env, "_");
-	if (live & REG_LIVE_READ)
-		verbose(env, "r");
-	if (live & REG_LIVE_WRITTEN)
-		verbose(env, "w");
-	if (live & REG_LIVE_DONE)
-		verbose(env, "D");
-}
-
 static int __get_spi(s32 off)
 {
 	return (-off - 1) / BPF_REG_SIZE;
@@ -678,87 +576,6 @@ static const char *btf_type_name(const struct btf *b=
tf, u32 id)
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
 }
=20
-static const char *dynptr_type_str(enum bpf_dynptr_type type)
-{
-	switch (type) {
-	case BPF_DYNPTR_TYPE_LOCAL:
-		return "local";
-	case BPF_DYNPTR_TYPE_RINGBUF:
-		return "ringbuf";
-	case BPF_DYNPTR_TYPE_SKB:
-		return "skb";
-	case BPF_DYNPTR_TYPE_XDP:
-		return "xdp";
-	case BPF_DYNPTR_TYPE_INVALID:
-		return "<invalid>";
-	default:
-		WARN_ONCE(1, "unknown dynptr type %d\n", type);
-		return "<unknown>";
-	}
-}
-
-static const char *iter_type_str(const struct btf *btf, u32 btf_id)
-{
-	if (!btf || btf_id =3D=3D 0)
-		return "<invalid>";
-
-	/* we already validated that type is valid and has conforming name */
-	return btf_type_name(btf, btf_id) + sizeof(ITER_PREFIX) - 1;
-}
-
-static const char *iter_state_str(enum bpf_iter_state state)
-{
-	switch (state) {
-	case BPF_ITER_STATE_ACTIVE:
-		return "active";
-	case BPF_ITER_STATE_DRAINED:
-		return "drained";
-	case BPF_ITER_STATE_INVALID:
-		return "<invalid>";
-	default:
-		WARN_ONCE(1, "unknown iter state %d\n", state);
-		return "<unknown>";
-	}
-}
-
-static void mark_reg_scratched(struct bpf_verifier_env *env, u32 regno)
-{
-	env->scratched_regs |=3D 1U << regno;
-}
-
-static void mark_stack_slot_scratched(struct bpf_verifier_env *env, u32 =
spi)
-{
-	env->scratched_stack_slots |=3D 1ULL << spi;
-}
-
-static bool reg_scratched(const struct bpf_verifier_env *env, u32 regno)
-{
-	return (env->scratched_regs >> regno) & 1;
-}
-
-static bool stack_slot_scratched(const struct bpf_verifier_env *env, u64=
 regno)
-{
-	return (env->scratched_stack_slots >> regno) & 1;
-}
-
-static bool verifier_state_scratched(const struct bpf_verifier_env *env)
-{
-	return env->scratched_regs || env->scratched_stack_slots;
-}
-
-static void mark_verifier_state_clean(struct bpf_verifier_env *env)
-{
-	env->scratched_regs =3D 0U;
-	env->scratched_stack_slots =3D 0ULL;
-}
-
-/* Used for printing the entire verifier state. */
-static void mark_verifier_state_scratched(struct bpf_verifier_env *env)
-{
-	env->scratched_regs =3D ~0U;
-	env->scratched_stack_slots =3D ~0ULL;
-}
-
 static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_typ=
e)
 {
 	switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
@@ -1298,226 +1115,6 @@ static void scrub_spilled_slot(u8 *stype)
 		*stype =3D STACK_MISC;
 }
=20
-static void print_scalar_ranges(struct bpf_verifier_env *env,
-				const struct bpf_reg_state *reg,
-				const char **sep)
-{
-	struct {
-		const char *name;
-		u64 val;
-		bool omit;
-	} minmaxs[] =3D {
-		{"smin",   reg->smin_value,         reg->smin_value =3D=3D S64_MIN},
-		{"smax",   reg->smax_value,         reg->smax_value =3D=3D S64_MAX},
-		{"umin",   reg->umin_value,         reg->umin_value =3D=3D 0},
-		{"umax",   reg->umax_value,         reg->umax_value =3D=3D U64_MAX},
-		{"smin32", (s64)reg->s32_min_value, reg->s32_min_value =3D=3D S32_MIN}=
,
-		{"smax32", (s64)reg->s32_max_value, reg->s32_max_value =3D=3D S32_MAX}=
,
-		{"umin32", reg->u32_min_value,      reg->u32_min_value =3D=3D 0},
-		{"umax32", reg->u32_max_value,      reg->u32_max_value =3D=3D U32_MAX}=
,
-	}, *m1, *m2, *mend =3D &minmaxs[ARRAY_SIZE(minmaxs)];
-	bool neg1, neg2;
-
-	for (m1 =3D &minmaxs[0]; m1 < mend; m1++) {
-		if (m1->omit)
-			continue;
-
-		neg1 =3D m1->name[0] =3D=3D 's' && (s64)m1->val < 0;
-
-		verbose(env, "%s%s=3D", *sep, m1->name);
-		*sep =3D ",";
-
-		for (m2 =3D m1 + 2; m2 < mend; m2 +=3D 2) {
-			if (m2->omit || m2->val !=3D m1->val)
-				continue;
-			/* don't mix negatives with positives */
-			neg2 =3D m2->name[0] =3D=3D 's' && (s64)m2->val < 0;
-			if (neg2 !=3D neg1)
-				continue;
-			m2->omit =3D true;
-			verbose(env, "%s=3D", m2->name);
-		}
-
-		verbose(env, m1->name[0] =3D=3D 's' ? "%lld" : "%llu", m1->val);
-	}
-}
-
-static void print_verifier_state(struct bpf_verifier_env *env,
-				 const struct bpf_func_state *state,
-				 bool print_all)
-{
-	const struct bpf_reg_state *reg;
-	enum bpf_reg_type t;
-	int i;
-
-	if (state->frameno)
-		verbose(env, " frame%d:", state->frameno);
-	for (i =3D 0; i < MAX_BPF_REG; i++) {
-		reg =3D &state->regs[i];
-		t =3D reg->type;
-		if (t =3D=3D NOT_INIT)
-			continue;
-		if (!print_all && !reg_scratched(env, i))
-			continue;
-		verbose(env, " R%d", i);
-		print_liveness(env, reg->live);
-		verbose(env, "=3D");
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
-	}
-	for (i =3D 0; i < state->allocated_stack / BPF_REG_SIZE; i++) {
-		char types_buf[BPF_REG_SIZE + 1];
-		bool valid =3D false;
-		int j;
-
-		for (j =3D 0; j < BPF_REG_SIZE; j++) {
-			if (state->stack[i].slot_type[j] !=3D STACK_INVALID)
-				valid =3D true;
-			types_buf[j] =3D slot_type_char[state->stack[i].slot_type[j]];
-		}
-		types_buf[BPF_REG_SIZE] =3D 0;
-		if (!valid)
-			continue;
-		if (!print_all && !stack_slot_scratched(env, i))
-			continue;
-		switch (state->stack[i].slot_type[BPF_REG_SIZE - 1]) {
-		case STACK_SPILL:
-			reg =3D &state->stack[i].spilled_ptr;
-			t =3D reg->type;
-
-			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-			print_liveness(env, reg->live);
-			verbose(env, "=3D%s", t =3D=3D SCALAR_VALUE ? "" : reg_type_str(env, =
t));
-			if (t =3D=3D SCALAR_VALUE && reg->precise)
-				verbose(env, "P");
-			if (t =3D=3D SCALAR_VALUE && tnum_is_const(reg->var_off))
-				verbose(env, "%lld", reg->var_off.value + reg->off);
-			break;
-		case STACK_DYNPTR:
-			i +=3D BPF_DYNPTR_NR_SLOTS - 1;
-			reg =3D &state->stack[i].spilled_ptr;
-
-			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-			print_liveness(env, reg->live);
-			verbose(env, "=3Ddynptr_%s", dynptr_type_str(reg->dynptr.type));
-			if (reg->ref_obj_id)
-				verbose(env, "(ref_id=3D%d)", reg->ref_obj_id);
-			break;
-		case STACK_ITER:
-			/* only main slot has ref_obj_id set; skip others */
-			reg =3D &state->stack[i].spilled_ptr;
-			if (!reg->ref_obj_id)
-				continue;
-
-			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-			print_liveness(env, reg->live);
-			verbose(env, "=3Diter_%s(ref_id=3D%d,state=3D%s,depth=3D%u)",
-				iter_type_str(reg->iter.btf, reg->iter.btf_id),
-				reg->ref_obj_id, iter_state_str(reg->iter.state),
-				reg->iter.depth);
-			break;
-		case STACK_MISC:
-		case STACK_ZERO:
-		default:
-			reg =3D &state->stack[i].spilled_ptr;
-
-			for (j =3D 0; j < BPF_REG_SIZE; j++)
-				types_buf[j] =3D slot_type_char[state->stack[i].slot_type[j]];
-			types_buf[BPF_REG_SIZE] =3D 0;
-
-			verbose(env, " fp%d", (-i - 1) * BPF_REG_SIZE);
-			print_liveness(env, reg->live);
-			verbose(env, "=3D%s", types_buf);
-			break;
-		}
-	}
-	if (state->acquired_refs && state->refs[0].id) {
-		verbose(env, " refs=3D%d", state->refs[0].id);
-		for (i =3D 1; i < state->acquired_refs; i++)
-			if (state->refs[i].id)
-				verbose(env, ",%d", state->refs[i].id);
-	}
-	if (state->in_callback_fn)
-		verbose(env, " cb");
-	if (state->in_async_callback_fn)
-		verbose(env, " async_cb");
-	verbose(env, "\n");
-	if (!print_all)
-		mark_verifier_state_clean(env);
-}
-
-static inline u32 vlog_alignment(u32 pos)
-{
-	return round_up(max(pos + BPF_LOG_MIN_ALIGNMENT / 2, BPF_LOG_ALIGNMENT)=
,
-			BPF_LOG_MIN_ALIGNMENT) - pos - 1;
-}
-
-static void print_insn_state(struct bpf_verifier_env *env,
-			     const struct bpf_func_state *state)
-{
-	if (env->prev_log_pos && env->prev_log_pos =3D=3D env->log.end_pos) {
-		/* remove new line character */
-		bpf_vlog_reset(&env->log, env->prev_log_pos - 1);
-		verbose(env, "%*c;", vlog_alignment(env->prev_insn_print_pos), ' ');
-	} else {
-		verbose(env, "%d:", env->insn_idx);
-	}
-	print_verifier_state(env, state, false);
-}
-
 /* copy array src of length n * size bytes to dst. dst is reallocated if=
 it's too
  * small to hold src. This is different from krealloc since we don't wan=
t to preserve
  * the contents of dst.
--=20
2.34.1


