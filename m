Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1285A3B1E
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 04:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiH1CzA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 22:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH1Cy7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 22:54:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3691A066
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:56 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27S2mgUX028027
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aqB3dZzYC2Vdj1hM1Bkau3YY2gwUun68jY9QaP6Y+Oo=;
 b=bAZ7XdmLVl2MSRCHGrnMG8lH1v1G3Eq+mltQNPtb7PkrCX4HDuHjxffcOig5Ha6uwGqZ
 Of14FkU1PTCcMuSlArI5VTVj8XYz2KWEo0EMlg2z42jidLd6oNXDt2mOGILpWTzw3SXN
 vUcx5QPMn0SJqGXcnSTJhn86RyvtbkrCxNs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j7gsytu4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 19:54:55 -0700
Received: from twshared0823.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 27 Aug 2022 19:54:54 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id E65D8EA747F4; Sat, 27 Aug 2022 19:54:48 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v3 2/7] bpf: x86: Support in-register struct arguments in trampoline programs
Date:   Sat, 27 Aug 2022 19:54:48 -0700
Message-ID: <20220828025448.143923-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220828025438.142798-1-yhs@fb.com>
References: <20220828025438.142798-1-yhs@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XOFW8TobFAnczEYoBb9eFVlB4tmS9DE_
X-Proofpoint-GUID: XOFW8TobFAnczEYoBb9eFVlB4tmS9DE_
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In C, struct value can be passed as a function argument.
For small structs, struct value may be passed in
one or more registers. For trampoline based bpf programs,
This would cause complication since one-to-one mapping between
function argument and arch argument register is not valid
any more.

The latest llvm16 added bpf support to pass by values
for struct up to 16 bytes ([1]). This is also true for
x86_64 architecture where two registers will hold
the struct value if the struct size is >8 and <=3D 16.
This may not be true if one of struct member is 'double'
type but in current linux source code we don't have
such instance yet, so we assume all >8 && <=3D 16 struct
holds two general purpose argument registers.

Also change on-stack nr_args value to the number
of registers holding the arguments. This will
permit bpf_get_func_arg() helper to get all
argument values.

 [1] https://reviews.llvm.org/D132144

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c1f6c1c51d99..ae89f4143eb4 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1751,34 +1751,60 @@ st:			if (is_imm8(insn->off))
 static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_ar=
gs,
 		      int stack_size)
 {
-	int i;
+	int i, j, arg_size, nr_regs;
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i =3D 0; i < min(nr_args, 6); i++)
-		emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
-			 BPF_REG_FP,
-			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 -(stack_size - i * 8));
+	for (i =3D 0, j =3D 0; i < min(nr_args, 6); i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
+			nr_regs =3D (m->arg_size[i] + 7) / 8;
+			arg_size =3D 8;
+		} else {
+			nr_regs =3D 1;
+			arg_size =3D m->arg_size[i];
+		}
+
+		while (nr_regs) {
+			emit_stx(prog, bytes_to_bpf_size(arg_size),
+				 BPF_REG_FP,
+				 j =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + j,
+				 -(stack_size - j * 8));
+			nr_regs--;
+			j++;
+		}
+	}
 }
=20
 static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr=
_args,
 			 int stack_size)
 {
-	int i;
+	int i, j, arg_size, nr_regs;
=20
 	/* Restore function arguments from stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
 	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
 	 */
-	for (i =3D 0; i < min(nr_args, 6); i++)
-		emit_ldx(prog, bytes_to_bpf_size(m->arg_size[i]),
-			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 BPF_REG_FP,
-			 -(stack_size - i * 8));
+	for (i =3D 0, j =3D 0; i < min(nr_args, 6); i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
+			nr_regs =3D (m->arg_size[i] + 7) / 8;
+			arg_size =3D 8;
+		} else {
+			nr_regs =3D 1;
+			arg_size =3D m->arg_size[i];
+		}
+
+		while (nr_regs) {
+			emit_ldx(prog, bytes_to_bpf_size(arg_size),
+				 j =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + j,
+				 BPF_REG_FP,
+				 -(stack_size - j * 8));
+			nr_regs--;
+			j++;
+		}
+	}
 }
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
@@ -2015,7 +2041,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_imag=
e *im, void *image, void *i
 				struct bpf_tramp_links *tlinks,
 				void *orig_call)
 {
-	int ret, i, nr_args =3D m->nr_args;
+	int ret, i, nr_args =3D m->nr_args, extra_nregs =3D 0;
 	int regs_off, ip_off, args_off, stack_size =3D nr_args * 8, run_ctx_off;
 	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
@@ -2028,6 +2054,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_ima=
ge *im, void *image, void *i
 	if (nr_args > 6)
 		return -ENOTSUPP;
=20
+	for (i =3D 0; i < MAX_BPF_FUNC_ARGS; i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+			extra_nregs +=3D (m->arg_size[i] + 7) / 8 - 1;
+	}
+	if (nr_args + extra_nregs > 6)
+		return -ENOTSUPP;
+	stack_size +=3D extra_nregs * 8;
+
 	/* Generated trampoline stack layout:
 	 *
 	 * RBP + 8         [ return address  ]
@@ -2040,7 +2074,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_imag=
e *im, void *image, void *i
 	 *                 [ ...             ]
 	 * RBP - regs_off  [ reg_arg1        ]  program's ctx pointer
 	 *
-	 * RBP - args_off  [ args count      ]  always
+	 * RBP - args_off  [ arg regs count  ]  always
 	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 *
@@ -2083,11 +2117,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	EMIT4(0x48, 0x83, 0xEC, stack_size); /* sub rsp, stack_size */
 	EMIT1(0x53);		 /* push rbx */
=20
-	/* Store number of arguments of the traced function:
-	 *   mov rax, nr_args
+	/* Store number of argument registers of the traced function:
+	 *   mov rax, nr_args + extra_nregs
 	 *   mov QWORD PTR [rbp - args_off], rax
 	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_args);
+	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_args + extra_nregs);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -args_off);
=20
 	if (flags & BPF_TRAMP_F_IP_ARG) {
--=20
2.30.2

