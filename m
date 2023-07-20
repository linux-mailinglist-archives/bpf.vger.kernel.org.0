Return-Path: <bpf+bounces-5395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FF75A308
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 02:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6739B1C21201
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 00:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D68D2F41;
	Thu, 20 Jul 2023 00:02:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092B720FE
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 00:02:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5194E69
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:15 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMZxr7031400
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=+jMlI7JRCJrFwwV2PbJfVGA5+YkA4XSaE4RopIUm6C0=;
 b=Pe5Evw1CBDoa52MaYJ9yD1BUQvHEJKTmbx2YhN45tkpZmPXpgCdFqWBiH5/JClGcLvGw
 rA4faqGUtCs9S81JP4DQeQGphmkdltplwoq3VHKLb874pfJ924ii6FMmmEvzg3b22eQq
 Z12oWlTLBEpcXZwqPNrnmVJsVpPty9aFI3o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rxbc6q1aa-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 17:02:15 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:01:52 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:01:52 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D98382354E8BE; Wed, 19 Jul 2023 17:01:40 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        <bpf@ietf.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song
	<maskray@google.com>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 07/17] bpf: Support new 32bit offset jmp instruction
Date: Wed, 19 Jul 2023 17:01:40 -0700
Message-ID: <20230720000140.105530-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720000103.99949-1-yhs@fb.com>
References: <20230720000103.99949-1-yhs@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rtMXI08W2zzfsSRNYPendE6kEdiE9wJ2
X-Proofpoint-ORIG-GUID: rtMXI08W2zzfsSRNYPendE6kEdiE9wJ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add interpreter/jit/verifier support for 32bit offset jmp instruction.
If a conditional jmp instruction needs more than 16bit offset,
it can be simulated with a conditional jmp + a 32bit jmp insn.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 28 ++++++++++++++++++----------
 kernel/bpf/core.c           | 19 ++++++++++++++++---
 kernel/bpf/verifier.c       | 32 ++++++++++++++++++++++----------
 3 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a89b62eb2b40..a5930042139d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1815,16 +1815,24 @@ st:			if (is_imm8(insn->off))
 			break;
=20
 		case BPF_JMP | BPF_JA:
-			if (insn->off =3D=3D -1)
-				/* -1 jmp instructions will always jump
-				 * backwards two bytes. Explicitly handling
-				 * this case avoids wasting too many passes
-				 * when there are long sequences of replaced
-				 * dead code.
-				 */
-				jmp_offset =3D -2;
-			else
-				jmp_offset =3D addrs[i + insn->off] - addrs[i];
+		case BPF_JMP32 | BPF_JA:
+			if (BPF_CLASS(insn->code) =3D=3D BPF_JMP) {
+				if (insn->off =3D=3D -1)
+					/* -1 jmp instructions will always jump
+					 * backwards two bytes. Explicitly handling
+					 * this case avoids wasting too many passes
+					 * when there are long sequences of replaced
+					 * dead code.
+					 */
+					jmp_offset =3D -2;
+				else
+					jmp_offset =3D addrs[i + insn->off] - addrs[i];
+			} else {
+				if (insn->imm =3D=3D -1)
+					jmp_offset =3D -2;
+				else
+					jmp_offset =3D addrs[i + insn->imm] - addrs[i];
+			}
=20
 			if (!jmp_offset) {
 				/*
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 646d2fe537be..db0b631908c2 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -373,7 +373,12 @@ static int bpf_adj_delta_to_off(struct bpf_insn *ins=
n, u32 pos, s32 end_old,
 {
 	const s32 off_min =3D S16_MIN, off_max =3D S16_MAX;
 	s32 delta =3D end_new - end_old;
-	s32 off =3D insn->off;
+	s32 off;
+
+	if (insn->code =3D=3D (BPF_JMP32 | BPF_JA))
+		off =3D insn->imm;
+	else
+		off =3D insn->off;
=20
 	if (curr < pos && curr + off + 1 >=3D end_old)
 		off +=3D delta;
@@ -381,8 +386,12 @@ static int bpf_adj_delta_to_off(struct bpf_insn *ins=
n, u32 pos, s32 end_old,
 		off -=3D delta;
 	if (off < off_min || off > off_max)
 		return -ERANGE;
-	if (!probe_pass)
-		insn->off =3D off;
+	if (!probe_pass) {
+		if (insn->code =3D=3D (BPF_JMP32 | BPF_JA))
+			insn->imm =3D off;
+		else
+			insn->off =3D off;
+	}
 	return 0;
 }
=20
@@ -1593,6 +1602,7 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
 	INSN_3(JMP, JSLE, K),			\
 	INSN_3(JMP, JSET, K),			\
 	INSN_2(JMP, JA),			\
+	INSN_2(JMP32, JA),			\
 	/* Store instructions. */		\
 	/*   Register based. */			\
 	INSN_3(STX, MEM,  B),			\
@@ -1989,6 +1999,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
 	JMP_JA:
 		insn +=3D insn->off;
 		CONT;
+	JMP32_JA:
+		insn +=3D insn->imm;
+		CONT;
 	JMP_EXIT:
 		return BPF_R0;
 	/* JMP */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9436fa795f39..daf23c5da2ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2855,7 +2855,10 @@ static int check_subprogs(struct bpf_verifier_env =
*env)
 			goto next;
 		if (BPF_OP(code) =3D=3D BPF_EXIT || BPF_OP(code) =3D=3D BPF_CALL)
 			goto next;
-		off =3D i + insn[i].off + 1;
+		if (code =3D=3D (BPF_JMP32 | BPF_JA))
+			off =3D i + insn[i].imm + 1;
+		else
+			off =3D i + insn[i].off + 1;
 		if (off < subprog_start || off >=3D subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
 			return -EINVAL;
@@ -2867,6 +2870,7 @@ static int check_subprogs(struct bpf_verifier_env *=
env)
 			 * or unconditional jump back
 			 */
 			if (code !=3D (BPF_JMP | BPF_EXIT) &&
+			    code !=3D (BPF_JMP32 | BPF_JA) &&
 			    code !=3D (BPF_JMP | BPF_JA)) {
 				verbose(env, "last insn is not an exit or jmp\n");
 				return -EINVAL;
@@ -14792,7 +14796,7 @@ static int visit_func_call_insn(int t, struct bpf=
_insn *insns,
 static int visit_insn(int t, struct bpf_verifier_env *env)
 {
 	struct bpf_insn *insns =3D env->prog->insnsi, *insn =3D &insns[t];
-	int ret;
+	int ret, off;
=20
 	if (bpf_pseudo_func(insn))
 		return visit_func_call_insn(t, insns, env, true);
@@ -14840,14 +14844,19 @@ static int visit_insn(int t, struct bpf_verifie=
r_env *env)
 		if (BPF_SRC(insn->code) !=3D BPF_K)
 			return -EINVAL;
=20
+		if (BPF_CLASS(insn->code) =3D=3D BPF_JMP)
+			off =3D insn->off;
+		else
+			off =3D insn->imm;
+
 		/* unconditional jump with single edge */
-		ret =3D push_insn(t, t + insn->off + 1, FALLTHROUGH, env,
+		ret =3D push_insn(t, t + off + 1, FALLTHROUGH, env,
 				true);
 		if (ret)
 			return ret;
=20
-		mark_prune_point(env, t + insn->off + 1);
-		mark_jmp_point(env, t + insn->off + 1);
+		mark_prune_point(env, t + off + 1);
+		mark_jmp_point(env, t + off + 1);
=20
 		return ret;
=20
@@ -16643,15 +16652,18 @@ static int do_check(struct bpf_verifier_env *en=
v)
 				mark_reg_scratched(env, BPF_REG_0);
 			} else if (opcode =3D=3D BPF_JA) {
 				if (BPF_SRC(insn->code) !=3D BPF_K ||
-				    insn->imm !=3D 0 ||
 				    insn->src_reg !=3D BPF_REG_0 ||
 				    insn->dst_reg !=3D BPF_REG_0 ||
-				    class =3D=3D BPF_JMP32) {
+				    (class =3D=3D BPF_JMP && insn->imm !=3D 0) ||
+				    (class =3D=3D BPF_JMP32 && insn->off !=3D 0)) {
 					verbose(env, "BPF_JA uses reserved fields\n");
 					return -EINVAL;
 				}
=20
-				env->insn_idx +=3D insn->off + 1;
+				if (class =3D=3D BPF_JMP)
+					env->insn_idx +=3D insn->off + 1;
+				else
+					env->insn_idx +=3D insn->imm + 1;
 				continue;
=20
 			} else if (opcode =3D=3D BPF_EXIT) {
@@ -17498,13 +17510,13 @@ static bool insn_is_cond_jump(u8 code)
 {
 	u8 op;
=20
+	op =3D BPF_OP(code);
 	if (BPF_CLASS(code) =3D=3D BPF_JMP32)
-		return true;
+		return op !=3D BPF_JA;
=20
 	if (BPF_CLASS(code) !=3D BPF_JMP)
 		return false;
=20
-	op =3D BPF_OP(code);
 	return op !=3D BPF_JA && op !=3D BPF_EXIT && op !=3D BPF_CALL;
 }
=20
--=20
2.34.1


