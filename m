Return-Path: <bpf+bounces-3710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB5742073
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 08:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8951C20962
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 06:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00355257;
	Thu, 29 Jun 2023 06:37:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EFA15D2
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 06:37:44 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5891727
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:42 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0WD5n016988
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=xEevr6V9RfsVQ2tUVoxWMPsoZAX+luWtD02dH7XrfxY=;
 b=XyfnUF+A9eEyDylPypk0qk6bkbq8eNjIvfLuuFdigkzRRuvdmdg6eKespfFuwEUpOgxJ
 Sa6mcU2DlDttHrqhGOHOf3zVww8pEhzEKVbw4cZmj13oIM4o2SI8BIC9ADDQfls3uYTm
 YRWbsH5Yl0mE1tQKS4DBxy2J/oHfcfGwJT0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgyg3j96d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 23:37:41 -0700
Received: from twshared37136.03.ash8.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 23:37:40 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 87478221E7BE9; Wed, 28 Jun 2023 23:37:26 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 02/13] bpf: Add verifier support for sign-extension load insns
Date: Wed, 28 Jun 2023 23:37:26 -0700
Message-ID: <20230629063726.1649316-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629063715.1646832-1-yhs@fb.com>
References: <20230629063715.1646832-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: SP89flEoro_KMtodCjRVLA4SkAu3Vb8Q
X-Proofpoint-ORIG-GUID: SP89flEoro_KMtodCjRVLA4SkAu3Vb8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add sign-extension load support for map values. This is a minimum
change to make selftests passing.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 kernel/bpf/verifier.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 212c367e2f46..6845504d42a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6247,7 +6247,7 @@ static int check_stack_access_within_bounds(
  */
 static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
u32 regno,
 			    int off, int bpf_size, enum bpf_access_type t,
-			    int value_regno, bool strict_alignment_once)
+			    int value_regno, bool strict_alignment_once, bool sign_ext_ld)
 {
 	struct bpf_reg_state *regs =3D cur_regs(env);
 	struct bpf_reg_state *reg =3D regs + regno;
@@ -6316,6 +6316,19 @@ static int check_mem_access(struct bpf_verifier_en=
v *env, int insn_idx, u32 regn
 				__mark_reg_known(&regs[value_regno], val);
 			} else {
 				mark_reg_unknown(env, regs, value_regno);
+
+				if (sign_ext_ld) {
+					if (size =3D=3D 1) {
+						regs[value_regno].smax_value =3D (char)INT_MAX;
+						regs[value_regno].smin_value =3D (char)INT_MIN;
+					} else if (size =3D=3D 2) {
+						regs[value_regno].smax_value =3D (short)INT_MAX;
+						regs[value_regno].smin_value =3D (short)INT_MIN;
+					} else if (size =3D=3D 4) {
+						regs[value_regno].smax_value =3D INT_MAX;
+						regs[value_regno].smin_value =3D INT_MIN;
+					}
+				}
 			}
 		}
 	} else if (base_type(reg->type) =3D=3D PTR_TO_MEM) {
@@ -6477,7 +6490,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
 	}
=20
 	if (!err && size < BPF_REG_SIZE && value_regno >=3D 0 && t =3D=3D BPF_R=
EAD &&
-	    regs[value_regno].type =3D=3D SCALAR_VALUE) {
+	    regs[value_regno].type =3D=3D SCALAR_VALUE && !sign_ext_ld) {
 		/* b/h/w load zero-extends, mark upper bits as known 0 */
 		coerce_reg_to_size(&regs[value_regno], size);
 	}
@@ -6571,17 +6584,17 @@ static int check_atomic(struct bpf_verifier_env *=
env, int insn_idx, struct bpf_i
 	 * case to simulate the register fill.
 	 */
 	err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-			       BPF_SIZE(insn->code), BPF_READ, -1, true);
+			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
 	if (!err && load_reg >=3D 0)
 		err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
 				       BPF_SIZE(insn->code), BPF_READ, load_reg,
-				       true);
+				       true, false);
 	if (err)
 		return err;
=20
 	/* Check whether we can write into the same memory. */
 	err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
=20
@@ -6827,7 +6840,7 @@ static int check_helper_mem_access(struct bpf_verif=
ier_env *env, int regno,
 				return zero_size_allowed ? 0 : -EACCES;
=20
 			return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
-						atype, -1, false);
+						atype, -1, false, false);
 		}
=20
 		fallthrough;
@@ -7199,7 +7212,7 @@ static int process_dynptr_func(struct bpf_verifier_=
env *env, int regno, int insn
 		/* we write BPF_DW bits (8 bytes) at a time */
 		for (i =3D 0; i < BPF_DYNPTR_SIZE; i +=3D 8) {
 			err =3D check_mem_access(env, insn_idx, regno,
-					       i, BPF_DW, BPF_WRITE, -1, false);
+					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
 		}
@@ -7292,7 +7305,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, int regno, int insn_id
=20
 		for (i =3D 0; i < nr_slots * 8; i +=3D BPF_REG_SIZE) {
 			err =3D check_mem_access(env, insn_idx, regno,
-					       i, BPF_DW, BPF_WRITE, -1, false);
+					       i, BPF_DW, BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
 		}
@@ -9422,7 +9435,7 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 	 */
 	for (i =3D 0; i < meta.access_size; i++) {
 		err =3D check_mem_access(env, insn_idx, meta.regno, i, BPF_B,
-				       BPF_WRITE, -1, false);
+				       BPF_WRITE, -1, false, false);
 		if (err)
 			return err;
 	}
@@ -16300,7 +16313,8 @@ static int do_check(struct bpf_verifier_env *env)
 			 */
 			err =3D check_mem_access(env, env->insn_idx, insn->src_reg,
 					       insn->off, BPF_SIZE(insn->code),
-					       BPF_READ, insn->dst_reg, false);
+					       BPF_READ, insn->dst_reg, false,
+					       BPF_MODE(insn->code) =3D=3D BPF_MEMS);
 			if (err)
 				return err;
=20
@@ -16337,7 +16351,7 @@ static int do_check(struct bpf_verifier_env *env)
 			/* check that memory (dst_reg + off) is writeable */
 			err =3D check_mem_access(env, env->insn_idx, insn->dst_reg,
 					       insn->off, BPF_SIZE(insn->code),
-					       BPF_WRITE, insn->src_reg, false);
+					       BPF_WRITE, insn->src_reg, false, false);
 			if (err)
 				return err;
=20
@@ -16362,7 +16376,7 @@ static int do_check(struct bpf_verifier_env *env)
 			/* check that memory (dst_reg + off) is writeable */
 			err =3D check_mem_access(env, env->insn_idx, insn->dst_reg,
 					       insn->off, BPF_SIZE(insn->code),
-					       BPF_WRITE, -1, false);
+					       BPF_WRITE, -1, false, false);
 			if (err)
 				return err;
=20
--=20
2.34.1


