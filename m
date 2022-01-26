Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BBF49D4B3
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 22:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiAZVsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 16:48:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232750AbiAZVsb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 16:48:31 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QL2Ble026279
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=h6bW2gHsSqURPzdA6QliBuoHm5HqRZFE6c440MJPem0=;
 b=W9UBNbzrcOuPN2qXPaVWlM4T5qXfk+2BHYxMAwUqyF3ZEtDGMf4/lBv3VxIcf5cB4Ff9
 Th6zCXtJYBxYwn62GdqFFrvJLrsaR3Smlm1+5nOGSK2w7/EQ41l9NX0SihI4bmVA9k15
 3whK/HX3czLVznD04NqW/0gL7w7eWAIw2Gg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dts3ef77s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:30 -0800
Received: from twshared2974.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 13:48:28 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 2699B2C9AA2B; Wed, 26 Jan 2022 13:48:16 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 1/5] bpf: Add a flags value on trampoline frames.
Date:   Wed, 26 Jan 2022 13:48:05 -0800
Message-ID: <20220126214809.3868787-2-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126214809.3868787-1-kuifeng@fb.com>
References: <20220126214809.3868787-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7NbRflsBSnwSE-xh9PizGTIPcF_X03wT
X-Proofpoint-GUID: 7NbRflsBSnwSE-xh9PizGTIPcF_X03wT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=804 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The flags indicate what values are below nargs.  It appears only if
one or more values are there.  The order in the flags, from LSB to
MSB, indicates the order of values in the trampoline frame.  LSB is at
the highest location, close to the flags and nargs.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 17 ++++++++++++++++-
 kernel/bpf/verifier.c       |  2 +-
 kernel/trace/bpf_trace.c    | 23 ++++++++++++++++++++++-
 3 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ce1f86f245c9..1c2d3ef57dad 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1976,7 +1976,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 				void *orig_call)
 {
 	int ret, i, nr_args =3D m->nr_args;
-	int regs_off, ip_off, args_off, stack_size =3D nr_args * 8;
+	int regs_off, flags_off, ip_off, args_off, stack_size =3D nr_args * 8;
 	struct bpf_tramp_progs *fentry =3D &tprogs[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_progs *fexit =3D &tprogs[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_progs *fmod_ret =3D &tprogs[BPF_TRAMP_MODIFY_RETURN];
@@ -2019,6 +2019,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	stack_size +=3D 8;
 	args_off =3D stack_size;
=20
+	if (flags & BPF_TRAMP_F_IP_ARG)
+		stack_size +=3D 8; /* room for flags */
+
+	flags_off =3D stack_size;
+
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size +=3D 8; /* room for IP address argument */
=20
@@ -2044,6 +2049,16 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_args);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -args_off);
=20
+	if (flags & BPF_TRAMP_F_IP_ARG) {
+		/* Store flags
+		 * move rax, flags
+		 * mov QWORD PTR [rbp - flags_off], rax
+		 */
+		emit_mov_imm64(&prog, BPF_REG_0, 0,
+			       (u32) (flags & BPF_TRAMP_F_IP_ARG));
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -flags_off);
+	}
+
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
 		 * mov rax, QWORD PTR [rbp + 8]
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c5a46d41f28..ff91f5038010 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13585,7 +13585,7 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
 		if (prog_type =3D=3D BPF_PROG_TYPE_TRACING &&
 		    insn->imm =3D=3D BPF_FUNC_get_func_ip) {
 			/* Load IP address from ctx - 16 */
-			insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -16);
+			insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -24);
=20
 			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, 1);
 			if (!new_prog)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 06a9e220069e..bf2c9d11ad05 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1009,10 +1009,31 @@ const struct bpf_func_proto bpf_snprintf_btf_prot=
o =3D {
 	.arg5_type	=3D ARG_ANYTHING,
 };
=20
+static int get_trampo_var_off(void *ctx, u32 flag)
+{
+	int off =3D 2;            /* All variables are placed before flags */
+	u32 flags =3D (u32)((u64 *)ctx)[-2];
+
+	if (!(flags & flag))
+		return -1;      /* The variable is not there */
+	if (flag & (flag - 1))
+		return -1;      /* 2 or more bits are set */
+
+	for (; flags & flag; flags &=3D flags - 1)
+		off++;
+
+	return off;
+}
+
 BPF_CALL_1(bpf_get_func_ip_tracing, void *, ctx)
 {
 	/* This helper call is inlined by verifier. */
-	return ((u64 *)ctx)[-2];
+	int off =3D get_trampo_var_off(ctx, BPF_TRAMP_F_IP_ARG);
+
+	if (off < 0)
+		return 0;
+
+	return ((u64 *)ctx)[-off];
 }
=20
 static const struct bpf_func_proto bpf_get_func_ip_proto_tracing =3D {
--=20
2.30.2

