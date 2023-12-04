Return-Path: <bpf+bounces-16669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA058042BB
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32A41C20B8A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C66136B15;
	Mon,  4 Dec 2023 23:43:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B5A102
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:43:05 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B4MJhaA000498
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:43:04 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3usqf80m78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:43:03 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:43:01 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 9C90A3C9726A9; Mon,  4 Dec 2023 15:39:55 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 10/13] bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog args
Date: Mon, 4 Dec 2023 15:39:28 -0800
Message-ID: <20231204233931.49758-11-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: nsiQGq2fa382ZVaObc3okF0ijWTY50nz
X-Proofpoint-GUID: nsiQGq2fa382ZVaObc3okF0ijWTY50nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

Add support for annotating global BPF subprog arguments to provide more
information about expected semantics of the argument. Currently,
verifier relies purely on argument's BTF type information, and supports
three general use cases: scalar, pointer-to-context, and
pointer-to-fixed-size-memory.

Scalar and pointer-to-fixed-mem work well in practice and are quite
natural to use. But pointer-to-context is a bit problematic, as typical
BPF users don't realize that they need to use a special type name to
signal to verifier that argument is not just some pointer, but actually
a PTR_TO_CTX. Further, even if users do know which type to use, it is
limiting in situations where the same BPF program logic is used across
few different program types. Common case is kprobes, tracepoints, and
perf_event programs having a helper to send some data over BPF perf
buffer. bpf_perf_event_output() requires `ctx` argument, and so it's
quite cumbersome to share such global subprog across few BPF programs of
different types, necessitating extra static subprog that is context
type-agnostic.

Long story short, there is a need to go beyond types and allow users to
add hints to global subprog arguments to define expectations.

This patch adds such support for a few initial special tags:
  - pointer to context;
  - pointer to packet {data, metadata, end};
  - non-null qualifier for generic pointer arguments.

All of the above came up in practice already and seem generally useful
additions. Pointer to pkt_{data,meta,end} are useful for networking
applications that don't use dynptrs yet. Non-null qualifier is an often
requested feature, which currently has to be worked around by having
unnecessary NULL checks inside subprogs even if we know that arguments
are never NULL. Pointer to context was discussed earlier.

As for implementation, we utilize btf_decl_tag attribute and set up an
"arg:xxx" convention to specify argument hint. As such:
  - btf_decl_tag("arg:ctx") is a PTR_TO_CTX hint;
  - btf_decl_tag("arg:nonnull") marks pointer argument as not allowed to
    be NULL, making NULL check inside global subprog unnecessary;
  - btf_decl_tag("arg:ptr_data"), btf_decl_tag("arg:ptr_meta"), and
    btf_decl_tag("arg:ptr_end"), are marking arguments as special packet
    pointers.

Please check arg:ptr_xxx checks especially carefully, I suspect we might
need some extra validation for them to always be correct. Note that we
also added ARG_PTR_TO_PACKET_{DATA,META,END} enumerators to enum bpf_arg_=
type
to accommodate them.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h   |  4 ++++
 kernel/bpf/btf.c      | 56 ++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 30d9b4599f63..d33168412afb 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -721,6 +721,10 @@ enum bpf_arg_type {
 	ARG_PTR_TO_TIMER,	/* pointer to bpf_timer */
 	ARG_PTR_TO_KPTR,	/* pointer to referenced kptr */
 	ARG_PTR_TO_DYNPTR,      /* pointer to bpf_dynptr. See bpf_type_flag for=
 dynptr type */
+
+	ARG_PTR_TO_PACKET_DATA,
+	ARG_PTR_TO_PACKET_META,
+	ARG_PTR_TO_PACKET_END,
 	__BPF_ARG_TYPE_MAX,
=20
 	/* Extended arg_types. */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 707af8d054e4..6b75774bfaae 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6781,7 +6781,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	enum bpf_prog_type prog_type =3D prog->type;
 	struct btf *btf =3D prog->aux->btf;
 	const struct btf_param *args;
-	const struct btf_type *t, *ref_t;
+	const struct btf_type *t, *ref_t, *fn_t;
 	u32 i, nargs, btf_id;
 	const char *tname;
=20
@@ -6801,8 +6801,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 		return -EFAULT;
 	}
=20
-	t =3D btf_type_by_id(btf, btf_id);
-	if (!t || !btf_type_is_func(t)) {
+	fn_t =3D btf_type_by_id(btf, btf_id);
+	if (!fn_t || !btf_type_is_func(fn_t)) {
 		/* These checks were already done by the verifier while loading
 		 * struct bpf_func_info
 		 */
@@ -6810,7 +6810,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 			subprog);
 		return -EFAULT;
 	}
-	tname =3D btf_name_by_offset(btf, t->name_off);
+	tname =3D btf_name_by_offset(btf, fn_t->name_off);
=20
 	if (prog->aux->func_info_aux[subprog].unreliable) {
 		bpf_log(log, "Verifier bug in function %s()\n", tname);
@@ -6819,7 +6819,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	if (prog_type =3D=3D BPF_PROG_TYPE_EXT)
 		prog_type =3D prog->aux->dst_prog->type;
=20
-	t =3D btf_type_by_id(btf, t->type);
+	t =3D btf_type_by_id(btf, fn_t->type);
 	if (!t || !btf_type_is_func_proto(t)) {
 		bpf_log(log, "Invalid type of function %s()\n", tname);
 		return -EFAULT;
@@ -6845,7 +6845,47 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 	 * Only PTR_TO_CTX and SCALAR are supported atm.
 	 */
 	for (i =3D 0; i < nargs; i++) {
+		bool is_nonnull =3D false;
+		const char *tag;
+
 		t =3D btf_type_by_id(btf, args[i].type);
+
+		tag =3D btf_find_decl_tag_value(btf, fn_t, i, "arg:");
+		if (IS_ERR(tag) && PTR_ERR(tag) =3D=3D -ENOENT) {
+			tag =3D NULL;
+		} else if (IS_ERR(tag)) {
+			bpf_log(log, "arg#%d type's tag fetching failure: %ld\n", i, PTR_ERR(=
tag));
+			return PTR_ERR(tag);
+		}
+		/* 'arg:<tag>' decl_tag takes precedence over derivation of
+		 * register type from BTF type itself
+		 */
+		if (tag) {
+			/* disallow arg tags in static subprogs */
+			if (!is_global) {
+				bpf_log(log, "arg#%d type tag is not supported in static functions\n=
", i);
+				return -EOPNOTSUPP;
+			}
+			if (strcmp(tag, "ctx") =3D=3D 0) {
+				sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
+				continue;
+			}
+			if (strcmp(tag, "pkt_meta") =3D=3D 0) {
+				sub->args[i].arg_type =3D ARG_PTR_TO_PACKET_META;
+				continue;
+			}
+			if (strcmp(tag, "pkt_data") =3D=3D 0) {
+				sub->args[i].arg_type =3D ARG_PTR_TO_PACKET_DATA;
+				continue;
+			}
+			if (strcmp(tag, "pkt_end") =3D=3D 0) {
+				sub->args[i].arg_type =3D ARG_PTR_TO_PACKET_END;
+				continue;
+			}
+			if (strcmp(tag, "nonnull") =3D=3D 0)
+				is_nonnull =3D true;
+		}
+
 		while (btf_type_is_modifier(t))
 			t =3D btf_type_by_id(btf, t->type);
 		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
@@ -6869,10 +6909,14 @@ int btf_prepare_func_args(struct bpf_verifier_env=
 *env, int subprog)
 				return -EINVAL;
 			}
=20
-			sub->args[i].arg_type =3D ARG_PTR_TO_MEM_OR_NULL;
+			sub->args[i].arg_type =3D is_nonnull ? ARG_PTR_TO_MEM : ARG_PTR_TO_ME=
M_OR_NULL;
 			sub->args[i].mem_size =3D mem_size;
 			continue;
 		}
+		if (is_nonnull) {
+			bpf_log(log, "arg#%d marked as non-null, but is not a pointer type\n"=
, i);
+			return -EINVAL;
+		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
 			i, btf_type_str(t), tname);
 		return -EINVAL;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5787b7fd16ba..61e778dbde10 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9268,9 +9268,30 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
 			ret =3D check_func_arg_reg_off(env, reg, regno, ARG_DONTCARE);
 			if (ret < 0)
 				return ret;
-
 			if (check_mem_reg(env, reg, regno, arg->mem_size))
 				return -EINVAL;
+			if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->type & PTR_MAYBE_NULL)=
) {
+				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
+				return -EINVAL;
+			}
+		} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_META) {
+			if (reg->type !=3D PTR_TO_PACKET_META) {
+				bpf_log(log, "arg#%d expected pkt_meta, but got %s\n",
+					i, reg_type_str(env, reg->type));
+				return -EINVAL;
+			}
+		} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_DATA) {
+			if (reg->type !=3D PTR_TO_PACKET) {
+				bpf_log(log, "arg#%d expected pkt, but got %s\n",
+					i, reg_type_str(env, reg->type));
+				return -EINVAL;
+			}
+		} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_END) {
+			if (reg->type !=3D PTR_TO_PACKET_END) {
+				bpf_log(log, "arg#%d expected pkt_end, but got %s\n",
+					i, reg_type_str(env, reg->type));
+				return -EINVAL;
+			}
 		} else {
 			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
 				i, arg->arg_type);
@@ -19983,6 +20004,15 @@ static int do_check_common(struct bpf_verifier_e=
nv *env, int subprog)
 			} else if (arg->arg_type =3D=3D ARG_SCALAR) {
 				reg->type =3D SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
+			} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_META) {
+				reg->type =3D PTR_TO_PACKET_META;
+				mark_reg_known_zero(env, regs, i);
+			} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_DATA) {
+				reg->type =3D PTR_TO_PACKET;
+				mark_reg_known_zero(env, regs, i);
+			} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_END) {
+				reg->type =3D PTR_TO_PACKET_END;
+				mark_reg_known_zero(env, regs, i);
 			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
 				reg->type =3D PTR_TO_MEM;
 				if (arg->arg_type & PTR_MAYBE_NULL)
--=20
2.34.1


