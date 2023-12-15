Return-Path: <bpf+bounces-17920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6822A813F10
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3EBDB21DF8
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BDD809;
	Fri, 15 Dec 2023 01:14:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255747E4
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3BEMrINl019712
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 17:14:02 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3v0avv8xbb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 17:14:01 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 14 Dec 2023 17:14:00 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B140C3D2CCF38; Thu, 14 Dec 2023 17:13:49 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>,
        Eduard Zingerman
	<eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 07/10] bpf: add support for passing dynptr pointer to global subprog
Date: Thu, 14 Dec 2023 17:13:31 -0800
Message-ID: <20231215011334.2307144-8-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215011334.2307144-1-andrii@kernel.org>
References: <20231215011334.2307144-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cIC2kg3gF7YGuIjo9wJWEBHWXxkERffO
X-Proofpoint-GUID: cIC2kg3gF7YGuIjo9wJWEBHWXxkERffO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_17,2023-12-14_01,2023-05-22_02

Add ability to pass a pointer to dynptr into global functions.
This allows to have global subprogs that accept and work with generic
dynptrs that are created by caller. Dynptr argument is detected based on
the name of a struct type, if it's "bpf_dynptr", it's assumed to be
a proper dynptr pointer. Both actual struct and forward struct
declaration types are supported.

This is conceptually exactly the same semantics as
bpf_user_ringbuf_drain()'s use of dynptr to pass a variable-sized
pointer to ringbuf record. So we heavily rely on CONST_PTR_TO_DYNPTR
bits of already existing logic in the verifier.

During global subprog validation, we mark such CONST_PTR_TO_DYNPTR as
having LOCAL type, as that's the most unassuming type of dynptr and it
doesn't have any special helpers that can try to free or acquire extra
references (unlike skb, xdp, or ringbuf dynptr). So that seems like a saf=
e
"choice" to make from correctness standpoint. It's still possible to
pass any type of dynptr to such subprog, though, because generic dynptr
helpers, like getting data/slice pointers, read/write memory copying
routines, dynptr adjustment and getter routines all work correctly with
any type of dynptr.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c      | 23 +++++++++++++++++++++++
 kernel/bpf/verifier.c |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c0fc8977be97..51e8b4bee0c8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6765,6 +6765,25 @@ int btf_check_type_match(struct bpf_verifier_log *=
log, const struct bpf_prog *pr
 	return btf_check_func_type_match(log, btf1, t1, btf2, t2);
 }
=20
+static bool btf_is_dynptr_ptr(const struct btf *btf, const struct btf_ty=
pe *t)
+{
+	const char *name;
+
+	t =3D btf_type_by_id(btf, t->type); /* skip PTR */
+
+	while (btf_type_is_modifier(t))
+		t =3D btf_type_by_id(btf, t->type);
+
+	/* allow either struct or struct forward declaration */
+	if (btf_type_is_struct(t) ||
+	    (btf_type_is_fwd(t) && btf_type_kflag(t) =3D=3D 0)) {
+		name =3D btf_str_by_offset(btf, t->name_off);
+		return name && strcmp(name, "bpf_dynptr") =3D=3D 0;
+	}
+
+	return false;
+}
+
 /* Process BTF of a function to produce high-level expectation of functi=
on
  * arguments (like ARG_PTR_TO_CTX, or ARG_PTR_TO_MEM, etc). This informa=
tion
  * is cached in subprog info for reuse.
@@ -6885,6 +6904,10 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 			sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
 			continue;
 		}
+		if (btf_type_is_ptr(t) && btf_is_dynptr_ptr(btf, t)) {
+			sub->args[i].arg_type =3D ARG_PTR_TO_DYNPTR | MEM_RDONLY;
+			continue;
+		}
 		if (is_global && btf_type_is_ptr(t)) {
 			u32 mem_size;
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e64210d8c617..e4838c9b79db 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9303,6 +9303,10 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
 				bpf_log(log, "arg#%d is expected to be non-NULL\n", i);
 				return -EINVAL;
 			}
+		} else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
+			ret =3D process_dynptr_func(env, regno, -1, arg->arg_type, 0);
+			if (ret)
+				return ret;
 		} else {
 			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
 				i, arg->arg_type);
@@ -20023,6 +20027,9 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
 			} else if (arg->arg_type =3D=3D ARG_ANYTHING) {
 				reg->type =3D SCALAR_VALUE;
 				mark_reg_unknown(env, regs, i);
+			} else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
+				/* assume unspecial LOCAL dynptr type */
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
 			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
 				reg->type =3D PTR_TO_MEM;
 				if (arg->arg_type & PTR_MAYBE_NULL)
--=20
2.34.1


