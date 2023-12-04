Return-Path: <bpf+bounces-16668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826188042B4
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 00:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8CA281392
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 23:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8378435F06;
	Mon,  4 Dec 2023 23:40:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAAD101
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 15:40:48 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KH1jw030882
	for <bpf@vger.kernel.org>; Mon, 4 Dec 2023 15:40:48 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3use5ndc1w-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 15:40:48 -0800
Received: from twshared21997.42.prn1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 15:40:12 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id A8ECC3C9726CE; Mon,  4 Dec 2023 15:39:57 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next 11/13] bpf: add dynptr global subprog arg tag support
Date: Mon, 4 Dec 2023 15:39:29 -0800
Message-ID: <20231204233931.49758-12-andrii@kernel.org>
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
X-Proofpoint-ORIG-GUID: 0y_rVtdkCf_6y9dn-mLWoPyHO0ctmwFD
X-Proofpoint-GUID: 0y_rVtdkCf_6y9dn-mLWoPyHO0ctmwFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_22,2023-12-04_01,2023-05-22_02

Add ability to pass a pointer to dynptr for global functions by using
btf_decl_tag("arg:dynptr") tag hint. This allows to have global subprogs
that accept and work with generic dynptrs that are created by caller.

This is conceptually exactly the same semantics as
bpf_user_ringbuf_drain()'s use of dynptr to pass a variable-sized
pointer to ringbuf record. So we heavily rely on CONST_PTR_TO_DYNPTR
bits of already existing logic in the verifier.

During global subprog validation, we mark such CONST_PTR_TO_DYNPTR as
having LOCAL type, as that's the most unassuming type of dynptr and it
doesn't have any special helpers that can try to free or acquire extra
references (unlike skb, xdp, or ringbuf dynptr). So that seems like a saf=
e
"choise" to make from correctness standpoint. It's still possible to
pass any type of dynptr to such subprog, though, because generic dynptr
helpers, like getting data/slice pointers, read/write memory copying
routines, dynptr adjustment and getter routines all work correctly with
any type of dynptr.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c      | 4 ++++
 kernel/bpf/verifier.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6b75774bfaae..06684e77eb43 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6870,6 +6870,10 @@ int btf_prepare_func_args(struct bpf_verifier_env =
*env, int subprog)
 				sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
 				continue;
 			}
+			if (strcmp(tag, "dynptr") =3D=3D 0) {
+				sub->args[i].arg_type =3D ARG_PTR_TO_DYNPTR | MEM_RDONLY;
+				continue;
+			}
 			if (strcmp(tag, "pkt_meta") =3D=3D 0) {
 				sub->args[i].arg_type =3D ARG_PTR_TO_PACKET_META;
 				continue;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 61e778dbde10..e08677c0629c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9292,6 +9292,10 @@ static int btf_check_func_arg_match(struct bpf_ver=
ifier_env *env, int subprog,
 					i, reg_type_str(env, reg->type));
 				return -EINVAL;
 			}
+		} else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
+			ret =3D process_dynptr_func(env, regno, -1, arg->arg_type, 0);
+			if (ret)
+				return ret;
 		} else {
 			bpf_log(log, "verifier bug: unrecognized arg#%d type %d\n",
 				i, arg->arg_type);
@@ -20013,6 +20017,9 @@ static int do_check_common(struct bpf_verifier_en=
v *env, int subprog)
 			} else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_END) {
 				reg->type =3D PTR_TO_PACKET_END;
 				mark_reg_known_zero(env, regs, i);
+			} else if (arg->arg_type =3D=3D (ARG_PTR_TO_DYNPTR | MEM_RDONLY)) {
+				/* assume unspecial LOCAL dynptr type */
+				__mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
 			} else if (base_type(arg->arg_type) =3D=3D ARG_PTR_TO_MEM) {
 				reg->type =3D PTR_TO_MEM;
 				if (arg->arg_type & PTR_MAYBE_NULL)
--=20
2.34.1


