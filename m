Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6182A590B77
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 07:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiHLFYo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 01:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLFYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 01:24:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C244A00E4
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:42 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27BJWxht027709
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=pcMG6NNKc9675VQ3BVSd4/itHt0rcMDOY+SIOPGt2iI=;
 b=k3jRoeApmtTScrl+1Ps4P3xHefHm1PNytlzYpFHaRw75JOsZzNtILl/z/TOgWjmI4gp3
 637UbPCnoUfOFMTP4y0jd/xlRTX7bIXYpwU6cwf2KCPVsIxK94WqNilWX4tSIhEcLKDu
 Wv07f9xpCB38Q3m3aTe4F/dNlFELPlJ2HXI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hw810tw9h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 22:24:41 -0700
Received: from twshared8442.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 22:24:39 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 35404DF8C439; Thu, 11 Aug 2022 22:24:35 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct arguments
Date:   Thu, 11 Aug 2022 22:24:35 -0700
Message-ID: <20220812052435.523068-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812052419.520522-1-yhs@fb.com>
References: <20220812052419.520522-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: q8770GVjluNGobIVp9yqNWxRjB2quBe8
X-Proofpoint-ORIG-GUID: q8770GVjluNGobIVp9yqNWxRjB2quBe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

To support struct value argument and make bpf programs
easy to write, the bpf program function parameter is
changed from struct type to a pointer to struct type.
The following is a simplified example.

In one of later selftests, we have a bpf_testmod function:
    struct bpf_testmod_struct_arg_2 {
        long a;
        long b;
    };
    noinline int
    bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 =
b, int c) {
        bpf_testmod_test_struct_arg_result =3D a + b.a + b.b + c;
        return bpf_testmod_test_struct_arg_result;
    }

When a bpf program is attached to the bpf_testmod function
bpf_testmod_test_struct_arg_2(), the bpf program may look like
    SEC("fentry/bpf_testmod_test_struct_arg_2")
    int BPF_PROG(test_struct_arg_3, int a, struct bpf_testmod_struct_arg_=
2 *b, int c)
    {
        t2_a =3D a;
        t2_b_a =3D b->a;
        t2_b_b =3D b->b;
        t2_c =3D c;
        return 0;
    }

Basically struct value becomes a pointer to the struct.
The trampoline stack will be increased to store the stack values and
the pointer to these values will be saved in the stack slot corresponding
to that argument. For x86_64, the struct size is limited up to 16 bytes
so the struct can fit in one or two registers. The struct size of more
than 16 bytes is not supported now as our current use case is
for sockptr_t in the argument. We could handle such large struct's
in the future if we have concrete use cases.

The main changes are in save_regs() and restore_regs(). The following
illustrated the trampoline asm codes for save_regs() and restore_regs().
save_regs():
    /* first argument */
    mov    DWORD PTR [rbp-0x18],edi
    /* second argument: struct, save actual values and put the pointer to=
 the slot */
    lea    rax,[rbp-0x40]
    mov    QWORD PTR [rbp-0x10],rax
    mov    QWORD PTR [rbp-0x40],rsi
    mov    QWORD PTR [rbp-0x38],rdx
    /* third argument */
    mov    DWORD PTR [rbp-0x8],esi
restore_regs():
    mov    edi,DWORD PTR [rbp-0x18]
    mov    rsi,QWORD PTR [rbp-0x40]
    mov    rdx,QWORD PTR [rbp-0x38]
    mov    esi,DWORD PTR [rbp-0x8]

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c | 137 +++++++++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 27 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2657b58001cf..2fa7d694c559 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -37,6 +37,11 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int =
len)
 #define EMIT3(b1, b2, b3)	EMIT((b1) + ((b2) << 8) + ((b3) << 16), 3)
 #define EMIT4(b1, b2, b3, b4)   EMIT((b1) + ((b2) << 8) + ((b3) << 16) +=
 ((b4) << 24), 4)
=20
+#define EMIT2_UPDATE_PROG(bytes, len) \
+	do { *prog =3D emit_code(*prog, bytes, len); } while (0)
+#define EMIT4_UPDATE_PROG(b1, b2, b3, b4) \
+	EMIT2_UPDATE_PROG((b1) + ((b2) << 8) + ((b3) << 16) + ((b4) << 24), 4)
+
 #define EMIT1_off32(b1, off) \
 	do { EMIT1(b1); EMIT(off, 4); } while (0)
 #define EMIT2_off32(b1, b2, off) \
@@ -1749,36 +1754,92 @@ st:			if (is_imm8(insn->off))
 }
=20
 static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_=
args,
-		      int regs_off)
+		      int regs_off, int struct_val_off)
 {
-	int i;
-	/* Store function arguments to stack.
-	 * For a function that accepts two pointers the sequence will be:
-	 * mov QWORD PTR [rbp-0x10],rdi
-	 * mov QWORD PTR [rbp-0x8],rsi
-	 */
-	for (i =3D 0; i < min(nr_args, 6); i++)
-		emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
-			 BPF_REG_FP,
-			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 -(regs_off - i * 8));
+	int i, j, curr_reg_idx, curr_s_stack_off, s_arg_nregs;
+
+	curr_reg_idx =3D curr_s_stack_off =3D 0;
+	for (i =3D 0; i < nr_args; i++) {
+		if (!(m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)) {
+			/* Store function arguments to stack.
+			 * For a function that accepts two pointers the sequence will be:
+			 * mov QWORD PTR [rbp-0x10],rdi
+			 * mov QWORD PTR [rbp-0x8],rsi
+			 */
+			emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
+				 BPF_REG_FP,
+				 curr_reg_idx =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + curr_reg_idx,
+				 -(regs_off - i * 8));
+			curr_reg_idx++;
+			continue;
+		}
+
+		/* lea rax, [rbp - struct_val_off] */
+		EMIT4_UPDATE_PROG(0x48, 0x8D, 0x45, -(struct_val_off - curr_s_stack_of=
f * 8));
+		/* The struct value is converted to a pointer argument.
+		 * mov QWORD PTR [rbp - s_arg_idx * 8],rax
+		 */
+		emit_stx(prog, bytes_to_bpf_size(8),
+			 BPF_REG_FP, BPF_REG_0, -(regs_off - i * 8));
+
+		/* Save struct registers to stack.
+		 * For example, argument 1 (second argument) size is 16 which occupies=
 two
+		 * registers, these two register values will be saved in stack.
+		 * mov QWORD PTR [rbp-0x40],rsi
+		 * mov QWORD PTR [rbp-0x38],rdx
+		 */
+		s_arg_nregs =3D (m->arg_size[i] + 7) / 8;
+		for (j =3D 0; j < s_arg_nregs; j++) {
+			emit_stx(prog, bytes_to_bpf_size(8),
+				 BPF_REG_FP,
+				 curr_reg_idx =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + curr_reg_idx,
+				 -(struct_val_off - curr_s_stack_off * 8));
+			curr_reg_idx++;
+			curr_s_stack_off++;
+		}
+	}
 }
=20
 static void restore_regs(const struct btf_func_model *m, u8 **prog, int =
nr_args,
-			 int regs_off)
+			 int regs_off, int struct_val_off)
 {
-	int i;
+	int i, j, curr_reg_idx, curr_s_stack_off, s_arg_nregs;
+
+	curr_reg_idx =3D curr_s_stack_off =3D 0;
+	for (i =3D 0; i < nr_args; i++) {
+		if (!(m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)) {
+			/* Restore struct values from stack.
+			 * For example, argument 1 (second argument) size is 16 which occupie=
s two
+			 * registers, these two register values will be restored to the origi=
nal
+			 * registers.
+			 * mov rsi,QWORD PTR [rbp-0x40]
+			 * mov rdx,QWORD PTR [rbp-0x38]
+			 */
+			emit_ldx(prog, bytes_to_bpf_size(m->arg_size[i]),
+				 curr_reg_idx  =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + curr_reg_idx,
+				 BPF_REG_FP,
+				 -(regs_off - i * 8));
+			curr_reg_idx++;
+			continue;
+		}
=20
-	/* Restore function arguments from stack.
-	 * For a function that accepts two pointers the sequence will be:
-	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
-	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
-	 */
-	for (i =3D 0; i < min(nr_args, 6); i++)
-		emit_ldx(prog, bytes_to_bpf_size(m->arg_size[i]),
-			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 BPF_REG_FP,
-			 -(regs_off - i * 8));
+		/* Restore struct values from stack.
+		 * For example, argument 1 (second argument) size is 16 which occupies=
 two
+		 * registers, these two register values will be restored to the origin=
al
+		 * registers.
+		 * mov rsi,QWORD PTR [rbp-0x40]
+		 * mov rdx,QWORD PTR [rbp-0x38]
+		 */
+		s_arg_nregs =3D (m->arg_size[i] + 7) / 8;
+		for (j =3D 0; j < s_arg_nregs; j++) {
+			emit_ldx(prog, bytes_to_bpf_size(8),
+				 curr_reg_idx =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + curr_reg_idx,
+				 BPF_REG_FP,
+				 -(struct_val_off - curr_s_stack_off * 8));
+			curr_reg_idx++;
+			curr_s_stack_off++;
+		}
+	}
 }
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
@@ -2020,6 +2081,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	int struct_val_off, extra_nregs =3D 0;
 	u8 **branches =3D NULL;
 	u8 *prog;
 	bool save_ret;
@@ -2028,6 +2090,20 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	if (nr_args > 6)
 		return -ENOTSUPP;
=20
+	for (i =3D 0; i < MAX_BPF_FUNC_ARGS; i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
+			/* Only support up to 16 bytes struct which should keep
+			 * values in registers.
+			 */
+			if (m->arg_size[i] > 16)
+				return -ENOTSUPP;
+
+			extra_nregs +=3D (m->arg_size[i] + 7) / 8 - 1;
+		}
+	}
+	if (nr_args + extra_nregs > 6)
+		return -ENOTSUPP;
+
 	/* Generated trampoline stack layout:
 	 *
 	 * RBP + 8         [ return address  ]
@@ -2066,6 +2142,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	stack_size +=3D (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
 	run_ctx_off =3D stack_size;
=20
+	/* For structure argument */
+	for (i =3D 0; i < MAX_BPF_FUNC_ARGS; i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+			stack_size +=3D (m->arg_size[i] + 7) & ~0x7;
+	}
+	struct_val_off =3D stack_size;
+
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
@@ -2101,7 +2184,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
 	}
=20
-	save_regs(m, &prog, nr_args, regs_off);
+	save_regs(m, &prog, nr_args, regs_off, struct_val_off);
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -2131,7 +2214,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	}
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_regs(m, &prog, nr_args, regs_off);
+		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
=20
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
@@ -2172,7 +2255,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 		}
=20
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_regs(m, &prog, nr_args, regs_off);
+		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
=20
 	/* This needs to be done regardless. If there were fmod_ret programs,
 	 * the return value is only updated on the stack and still needs to be
--=20
2.30.2

