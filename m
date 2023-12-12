Return-Path: <bpf+bounces-17615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B4B80FB52
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C1C281D80
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 23:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC064CFF;
	Tue, 12 Dec 2023 23:26:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F8BE
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:59 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCLfmmx010152
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:59 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uxxbb95ep-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 15:25:58 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 12 Dec 2023 15:25:56 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id D33003D0C8A43; Tue, 12 Dec 2023 15:25:49 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH v2 bpf-next 06/10] bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog args
Date: Tue, 12 Dec 2023 15:25:31 -0800
Message-ID: <20231212232535.1875938-7-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212232535.1875938-1-andrii@kernel.org>
References: <20231212232535.1875938-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: T-DmHKC67IJ9avVgjS0syZWe1OGZhoVA
X-Proofpoint-ORIG-GUID: T-DmHKC67IJ9avVgjS0syZWe1OGZhoVA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02

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

This patch adds such support for two initial special tags:
  - pointer to context;
  - non-null qualifier for generic pointer arguments.

All of the above came up in practice already and seem generally useful
additions. Non-null qualifier is an often requested feature, which
currently has to be worked around by having unnecessary NULL checks
inside subprogs even if we know that arguments are never NULL. Pointer
to context was discussed earlier.

As for implementation, we utilize btf_decl_tag attribute and set up an
"arg:xxx" convention to specify argument hint. As such:
  - btf_decl_tag("arg:ctx") is a PTR_TO_CTX hint;
  - btf_decl_tag("arg:nonnull") marks pointer argument as not allowed to
    be NULL, making NULL check inside global subprog unnecessary.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c      | 44 +++++++++++++++++++++++++++++++++++++------
 kernel/bpf/verifier.c |  5 ++++-
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 341811bcca53..c0fc8977be97 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6782,7 +6782,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	enum bpf_prog_type prog_type =3D prog->type;
 	struct btf *btf =3D prog->aux->btf;
 	const struct btf_param *args;
-	const struct btf_type *t, *ref_t;
+	const struct btf_type *t, *ref_t, *fn_t;
 	u32 i, nargs, btf_id;
 	const char *tname;
=20
@@ -6802,8 +6802,8 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
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
@@ -6811,7 +6811,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 			subprog);
 		return -EFAULT;
 	}
-	tname =3D btf_name_by_offset(btf, t->name_off);
+	tname =3D btf_name_by_offset(btf, fn_t->name_off);
=20
 	if (prog->aux->func_info_aux[subprog].unreliable) {
 		bpf_log(log, "Verifier bug in function %s()\n", tname);
@@ -6820,7 +6820,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *=
env, int subprog)
 	if (prog_type =3D=3D BPF_PROG_TYPE_EXT)
 		prog_type =3D prog->aux->dst_prog->type;
=20
-	t =3D btf_type_by_id(btf, t->type);
+	t =3D btf_type_by_id(btf, fn_t->type);
 	if (!t || !btf_type_is_func_proto(t)) {
 		bpf_log(log, "Invalid type of function %s()\n", tname);
 		return -EFAULT;
@@ -6846,7 +6846,35 @@ int btf_prepare_func_args(struct bpf_verifier_env =
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
+			if (strcmp(tag, "nonnull") =3D=3D 0)
+				is_nonnull =3D true;
+		}
+
 		while (btf_type_is_modifier(t))
 			t =3D btf_type_by_id(btf, t->type);
 		if (btf_type_is_int(t) || btf_is_any_enum(t)) {
@@ -6870,10 +6898,14 @@ int btf_prepare_func_args(struct bpf_verifier_env=
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
index 2dbbe9ef1617..1af98dc94546 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9291,9 +9291,12 @@ static int btf_check_func_arg_match(struct bpf_ver=
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
 		} else {
 			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
 				i, arg->arg_type);
--=20
2.34.1


