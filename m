Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9DF581829
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 19:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiGZRMD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 13:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238775AbiGZRMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 13:12:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107415A1E
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:00 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26QFpfNJ014605
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=yqDliBKARQey+qZ/zzMUVjifcWs9Z++TBYZsvT8UWUU=;
 b=gW8aC3SCeNvZUVebkB16OaMw94UQTsxYqv2XnjO6kz6w6WQIB8FRBGjqUonqmiRqvRZi
 xcDBO1QBKWCA/CFPQUyV1m+Vzv84QV15+ODB0BbViNC5juwUfx8bCYFnfqmZDOdwV899
 jmlFDOOg1hiFTyPWQzZFcqwktDnPJqvWMYE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hj2r0wyxm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 10:12:00 -0700
Received: from twshared6324.05.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 26 Jul 2022 10:11:58 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 9205BD40E9CE; Tue, 26 Jul 2022 10:11:51 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [RFC PATCH bpf-next 4/7] bpf: x86: Support in-register struct arguments
Date:   Tue, 26 Jul 2022 10:11:51 -0700
Message-ID: <20220726171151.712242-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726171129.708371-1-yhs@fb.com>
References: <20220726171129.708371-1-yhs@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Bd0AVM22rV4UbQMRJp6aq1zOk42BKMzE
X-Proofpoint-GUID: Bd0AVM22rV4UbQMRJp6aq1zOk42BKMzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-26_05,2022-07-26_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
    noinline void
    bpf_testmod_test_struct_arg_2(int a, struct bpf_testmod_struct_arg_2 =
b, int c) {
        bpf_testmod_test_struct_arg_result =3D a + b.a + b.b + c;
    }

When a bpf program is attached to the bpf_testmod function
bpf_testmod_test_struct_arg_2(), the bpf program may look like
    SEC("fentry/bpf_testmod_test_struct_arg_2")
    int BPF_PROG(test_struct_arg_2, int a, struct bpf_testmod_struct_arg_=
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
to that argument.

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
 arch/x86/net/bpf_jit_comp.c | 173 ++++++++++++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 17 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2657b58001cf..55521964ee3c 100644
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
@@ -1748,37 +1753,156 @@ st:			if (is_imm8(insn->off))
 	return proglen;
 }
=20
-static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_=
args,
-		      int regs_off)
+static void __save_normal_arg_regs(const struct btf_func_model *m, u8 **=
prog,
+				   int curr_arg_idx, int nr_args,
+				   int curr_reg_idx, int regs_off)
 {
-	int i;
+	int i, arg_idx;
+
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i =3D 0; i < min(nr_args, 6); i++)
-		emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
+	for (i =3D 0; i < nr_args; i++) {
+		arg_idx =3D curr_arg_idx + i;
+		emit_stx(prog, bytes_to_bpf_size(m->arg_size[arg_idx]),
 			 BPF_REG_FP,
-			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
-			 -(regs_off - i * 8));
+			 curr_reg_idx =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + curr_reg_idx,
+			 -(regs_off - arg_idx * 8));
+		curr_reg_idx++;
+	}
 }
=20
-static void restore_regs(const struct btf_func_model *m, u8 **prog, int =
nr_args,
-			 int regs_off)
+static void __save_struct_arg_regs(u8 **prog, int curr_reg_idx, int nr_r=
egs,
+				   int struct_val_off, int stack_start_idx)
 {
-	int i;
+	int i, reg_idx;
+
+	/* Save struct registers to stack.
+	 * For example, argument 1 (second argument) size is 16 which occupies =
two
+	 * registers, these two register values will be saved in stack.
+	 * mov QWORD PTR [rbp-0x40],rsi
+	 * mov QWORD PTR [rbp-0x38],rdx
+	 */
+	for (i =3D 0; i < nr_regs; i++) {
+		reg_idx =3D curr_reg_idx + i;
+		emit_stx(prog, bytes_to_bpf_size(8),
+			 BPF_REG_FP,
+			 reg_idx =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + reg_idx,
+			 -(struct_val_off - stack_start_idx * 8));
+		stack_start_idx++;
+	}
+}
+
+static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_=
args,
+		      int regs_off, int struct_val_off)
+{
+	int curr_arg_idx, curr_reg_idx, curr_s_stack_off;
+	int s_size, s_arg_idx, s_arg_nregs;
+
+	curr_arg_idx =3D curr_reg_idx =3D curr_s_stack_off =3D 0;
+	for (int i =3D 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++) {
+		s_size =3D m->struct_arg_bsize[i];
+		if (!s_size)
+			return __save_normal_arg_regs(m, prog, curr_arg_idx, nr_args - curr_a=
rg_idx,
+						      curr_reg_idx, regs_off);
+
+		s_arg_idx =3D m->struct_arg_idx[i];
+		s_arg_nregs =3D (s_size + 7) / 8;
+
+		__save_normal_arg_regs(m, prog, curr_arg_idx, s_arg_idx - curr_arg_idx=
,
+				       curr_reg_idx, regs_off);
+
+		/* lea rax, [rbp - struct_val_off] */
+		EMIT4_UPDATE_PROG(0x48, 0x8D, 0x45, -(struct_val_off - curr_s_stack_of=
f * 8));
+		/* The struct value is converted to a pointer argument.
+		 * mov QWORD PTR [rbp - s_arg_idx * 8],rax
+		 */
+		emit_stx(prog, bytes_to_bpf_size(8),
+			 BPF_REG_FP, BPF_REG_0, -(regs_off - s_arg_idx * 8));
+
+		__save_struct_arg_regs(prog, curr_reg_idx + s_arg_idx - curr_arg_idx, =
s_arg_nregs,
+				       struct_val_off, curr_s_stack_off);
+		curr_reg_idx +=3D s_arg_idx - curr_arg_idx + s_arg_nregs;
+		curr_s_stack_off +=3D s_arg_nregs;
+		curr_arg_idx =3D s_arg_idx + 1;
+	}
+
+	__save_normal_arg_regs(m, prog, curr_arg_idx, nr_args - curr_arg_idx, c=
urr_reg_idx,
+			       regs_off);
+}
+
+static void __restore_normal_arg_regs(const struct btf_func_model *m, u8=
 **prog, int curr_arg_idx,
+				      int nr_args, int curr_reg_idx, int regs_off)
+{
+	int i, arg_idx;
=20
 	/* Restore function arguments from stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
 	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
 	 */
-	for (i =3D 0; i < min(nr_args, 6); i++)
-		emit_ldx(prog, bytes_to_bpf_size(m->arg_size[i]),
-			 i =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + i,
+	for (i =3D 0; i < nr_args; i++) {
+		arg_idx =3D curr_arg_idx + i;
+		emit_ldx(prog, bytes_to_bpf_size(m->arg_size[arg_idx]),
+			 curr_reg_idx  =3D=3D 5 ? X86_REG_R9 : BPF_REG_1 + curr_reg_idx,
+			 BPF_REG_FP,
+			 -(regs_off - arg_idx * 8));
+		curr_reg_idx++;
+	}
+}
+
+static void __restore_struct_arg_regs(u8 **prog, int curr_reg_idx, int n=
r_regs,
+				      int struct_val_off, int stack_start_idx)
+{
+	int i, reg_idx;
+
+	/* Restore struct values from stack.
+	 * For example, argument 1 (second argument) size is 16 which occupies =
two
+	 * registers, these two register values will be restored to the origina=
l
+	 * registers.
+	 * mov rsi,QWORD PTR [rbp-0x40]
+	 * mov rdx,QWORD PTR [rbp-0x38]
+	 */
+	for (i =3D 0; i < nr_regs; i++) {
+		reg_idx =3D curr_reg_idx + i;
+		emit_ldx(prog, bytes_to_bpf_size(8),
+			 i =3D=3D reg_idx ? X86_REG_R9 : BPF_REG_1 + reg_idx,
 			 BPF_REG_FP,
-			 -(regs_off - i * 8));
+			 -(struct_val_off - stack_start_idx * 8));
+		stack_start_idx++;
+	}
+}
+
+static void restore_regs(const struct btf_func_model *m, u8 **prog, int =
nr_args,
+			 int regs_off, int struct_val_off)
+{
+	int curr_arg_idx, curr_reg_idx, curr_s_stack_off;
+	int s_size, s_arg_idx, s_arg_nregs;
+
+	curr_arg_idx =3D curr_reg_idx =3D curr_s_stack_off =3D 0;
+	for (int i =3D 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++) {
+		s_size =3D m->struct_arg_bsize[i];
+		if (!s_size)
+			return __restore_normal_arg_regs(m, prog, curr_arg_idx,
+							 nr_args - curr_arg_idx,
+							 curr_reg_idx, regs_off);
+
+		s_arg_idx =3D m->struct_arg_idx[i];
+		s_arg_nregs =3D (s_size + 7) / 8;
+
+		__restore_normal_arg_regs(m, prog, curr_arg_idx, s_arg_idx - curr_arg_=
idx,
+					  curr_reg_idx, regs_off);
+		__restore_struct_arg_regs(prog, curr_reg_idx + s_arg_idx - curr_arg_id=
x,
+					  s_arg_nregs, struct_val_off, curr_s_stack_off);
+		curr_reg_idx +=3D s_arg_idx - curr_arg_idx + s_arg_nregs;
+		curr_s_stack_off +=3D s_arg_nregs;
+		curr_arg_idx =3D s_arg_idx + 1;
+	}
+
+	__restore_normal_arg_regs(m, prog, curr_arg_idx, nr_args - curr_arg_idx=
, curr_reg_idx,
+				  regs_off);
 }
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
@@ -2020,6 +2144,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	int struct_val_off, extra_nregs =3D 0, s_bsize;
 	u8 **branches =3D NULL;
 	u8 *prog;
 	bool save_ret;
@@ -2028,6 +2153,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	if (nr_args > 6)
 		return -ENOTSUPP;
=20
+	for (i =3D 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++) {
+		s_bsize =3D m->struct_arg_bsize[i];
+		if (!s_bsize)
+			break;
+		extra_nregs +=3D (s_bsize + 7) / 8 - 1;
+	}
+	if (nr_args + extra_nregs > 6)
+		return -ENOTSUPP;
+
 	/* Generated trampoline stack layout:
 	 *
 	 * RBP + 8         [ return address  ]
@@ -2066,6 +2200,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_i=
mage *im, void *image, void *i
 	stack_size +=3D (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
 	run_ctx_off =3D stack_size;
=20
+	/* For structure argument */
+	for (i =3D 0; i < MAX_BPF_FUNC_STRUCT_ARGS; i++)
+		stack_size +=3D (m->struct_arg_bsize[i] + 7) & ~0x7;
+	struct_val_off =3D stack_size;
+
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
@@ -2101,7 +2240,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
 	}
=20
-	save_regs(m, &prog, nr_args, regs_off);
+	save_regs(m, &prog, nr_args, regs_off, struct_val_off);
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -2131,7 +2270,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
age *im, void *image, void *i
 	}
=20
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_regs(m, &prog, nr_args, regs_off);
+		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
=20
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
@@ -2172,7 +2311,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_im=
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

