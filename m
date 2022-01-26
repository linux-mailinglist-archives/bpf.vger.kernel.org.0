Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5249D4B6
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 22:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiAZVsm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 16:48:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20014 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232753AbiAZVsl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 16:48:41 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QL28mD021130
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=hxivEcICclmHFb3RmBIwDP138VPBXCk9Ldy0H+1ovqA=;
 b=YpRpNwieo2pzqhyyKRYfGuyluzpAHHJ2gp8v0NcNlG/jHl9Q8zReaZZTBm7jRCCeTQO5
 CK9Vi9fdm4Kdlao9uED2TCuDzVhO0nHmIP7SlWojkjUi+QRmfIkIBhDzI8LxHhfDqOaH
 Tv5liBM0O1VhvTzJCG3vYSxJOrdh4b6ex78= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtrpf7f65-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:41 -0800
Received: from twshared3205.02.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 13:48:34 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 284622C9AA2D; Wed, 26 Jan 2022 13:48:16 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 3/5] bpf, x86: Store program ID to trampoline frames.
Date:   Wed, 26 Jan 2022 13:48:07 -0800
Message-ID: <20220126214809.3868787-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126214809.3868787-1-kuifeng@fb.com>
References: <20220126214809.3868787-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: aeitscmT7yWBz4o1LrLVVUpABNcR2npZ
X-Proofpoint-ORIG-GUID: aeitscmT7yWBz4o1LrLVVUpABNcR2npZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=958
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Store the program ID in the trampoline frame before calling a BPF
program if any of BPF programs called by the trampoline need its
program ID, i.e., need_prog_id is true.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 44 +++++++++++++++++++++++++++----------
 include/linux/bpf.h         |  2 ++
 kernel/bpf/trampoline.c     |  3 +++
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1c2d3ef57dad..98ed42215887 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1754,13 +1754,21 @@ static void restore_regs(const struct btf_func_mo=
del *m, u8 **prog, int nr_args,
 }
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-			   struct bpf_prog *p, int stack_size, bool save_ret)
+			   struct bpf_prog *p, int stack_size,
+			   int pgid_off, bool save_ret)
 {
 	u8 *prog =3D *pprog;
 	u8 *jmp_insn;
=20
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+
+	/* Store BPF program ID
+	 * mov QWORD PTR [rbp - pgid_off], rdi
+	 */
+	if (pgid_off > 0)
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_1, -pgid_off);
+
 	if (emit_call(&prog,
 		      p->aux->sleepable ? __bpf_prog_enter_sleepable :
 		      __bpf_prog_enter, prog))
@@ -1843,14 +1851,14 @@ static int emit_cond_near_jump(u8 **pprog, void *=
func, void *ip, u8 jmp_cond)
=20
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_progs *tp, int stack_size,
-		      bool save_ret)
+		      int pgid_off, bool save_ret)
 {
 	int i;
 	u8 *prog =3D *pprog;
=20
 	for (i =3D 0; i < tp->nr_progs; i++) {
 		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size,
-				    save_ret))
+				    pgid_off, save_ret))
 			return -EINVAL;
 	}
 	*pprog =3D prog;
@@ -1859,7 +1867,7 @@ static int invoke_bpf(const struct btf_func_model *=
m, u8 **pprog,
=20
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog=
,
 			      struct bpf_tramp_progs *tp, int stack_size,
-			      u8 **branches)
+			      int pgid_off, u8 **branches)
 {
 	u8 *prog =3D *pprog;
 	int i;
@@ -1870,7 +1878,8 @@ static int invoke_bpf_mod_ret(const struct btf_func=
_model *m, u8 **pprog,
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	for (i =3D 0; i < tp->nr_progs; i++) {
-		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size, true))
+		if (invoke_bpf_prog(m, &prog, tp->progs[i], stack_size,
+				    pgid_off, true))
 			return -EINVAL;
=20
 		/* mod_ret prog stored return value into [rbp - 8]. Emit:
@@ -1976,7 +1985,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 				void *orig_call)
 {
 	int ret, i, nr_args =3D m->nr_args;
-	int regs_off, flags_off, ip_off, args_off, stack_size =3D nr_args * 8;
+	int regs_off, flags_off, pgid_off =3D 0, ip_off, args_off, stack_size =3D=
 nr_args * 8;
 	struct bpf_tramp_progs *fentry =3D &tprogs[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_progs *fexit =3D &tprogs[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_progs *fmod_ret =3D &tprogs[BPF_TRAMP_MODIFY_RETURN];
@@ -2005,7 +2014,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	 *
 	 * RBP - args_off  [ args count      ]  always
 	 *
+	 * RBP - flags_off [ flags           ]  BPF_TRAMP_F_IP_ARG or
+	 *                                      BPF_TRAMP_F_PROG_ID flags.
+	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
+	 *
+	 * RBP - pgid_off  [ program ID      ]  BPF_TRAMP_F_PROG_ID flags.
 	 */
=20
 	/* room for return value of orig_call or fentry prog */
@@ -2019,7 +2033,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	stack_size +=3D 8;
 	args_off =3D stack_size;
=20
-	if (flags & BPF_TRAMP_F_IP_ARG)
+	if (flags & (BPF_TRAMP_F_IP_ARG | BPF_TRAMP_F_PROG_ID))
 		stack_size +=3D 8; /* room for flags */
=20
 	flags_off =3D stack_size;
@@ -2029,6 +2043,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
=20
 	ip_off =3D stack_size;
=20
+	/* room for program ID */
+	if (flags & BPF_TRAMP_F_PROG_ID) {
+		stack_size +=3D 8;
+		pgid_off =3D stack_size;
+	}
+
 	if (flags & BPF_TRAMP_F_SKIP_FRAME)
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
@@ -2049,13 +2069,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_=
image *im, void *image, void *i
 	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_args);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -args_off);
=20
-	if (flags & BPF_TRAMP_F_IP_ARG) {
+	if (flags & (BPF_TRAMP_F_IP_ARG | BPF_TRAMP_F_PROG_ID)) {
 		/* Store flags
 		 * move rax, flags
 		 * mov QWORD PTR [rbp - flags_off], rax
 		 */
 		emit_mov_imm64(&prog, BPF_REG_0, 0,
-			       (u32) (flags & BPF_TRAMP_F_IP_ARG));
+			       (u32) (flags & (BPF_TRAMP_F_IP_ARG | BPF_TRAMP_F_PROG_ID)));
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -flags_off);
 	}
=20
@@ -2082,7 +2102,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	}
=20
 	if (fentry->nr_progs)
-		if (invoke_bpf(m, &prog, fentry, regs_off,
+		if (invoke_bpf(m, &prog, fentry, regs_off, pgid_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
=20
@@ -2092,7 +2112,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 		if (!branches)
 			return -ENOMEM;
=20
-		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
+		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off, pgid_off,
 				       branches)) {
 			ret =3D -EINVAL;
 			goto cleanup;
@@ -2130,7 +2150,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	}
=20
 	if (fexit->nr_progs)
-		if (invoke_bpf(m, &prog, fexit, regs_off, false)) {
+		if (invoke_bpf(m, &prog, fexit, regs_off, pgid_off, false)) {
 			ret =3D -EINVAL;
 			goto cleanup;
 		}
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e8ec8d2f2fe3..37353745fee5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -656,6 +656,8 @@ struct btf_func_model {
 #define BPF_TRAMP_F_IP_ARG		BIT(3)
 /* Return the return value of fentry prog. Only used by bpf_struct_ops. =
*/
 #define BPF_TRAMP_F_RET_FENTRY_RET	BIT(4)
+/* Store BPF program ID on the trampoline stack. */
+#define BPF_TRAMP_F_PROG_ID		BIT(5)
=20
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is =
~50
  * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c65622e4216c..959a33619b36 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -373,6 +373,9 @@ static int bpf_trampoline_update(struct bpf_trampolin=
e *tr)
 	if (ip_arg)
 		flags |=3D BPF_TRAMP_F_IP_ARG;
=20
+	if (prog_id)
+		flags |=3D BPF_TRAMP_F_PROG_ID;
+
 	err =3D arch_prepare_bpf_trampoline(im, im->image, im->image + PAGE_SIZ=
E,
 					  &tr->func.model, flags, tprogs,
 					  tr->func.addr);
--=20
2.30.2

