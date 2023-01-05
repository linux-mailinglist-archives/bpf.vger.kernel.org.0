Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4E65E47A
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 05:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjAEEMQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 23:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjAEELm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 23:11:42 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54954107;
        Wed,  4 Jan 2023 20:11:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NnXWt67k0z4f3vW6;
        Thu,  5 Jan 2023 11:48:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgAnG+mqSLZjMHduBA--.6867S2;
        Thu, 05 Jan 2023 11:48:59 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2] bpf, x86: Simplify the parsing logic of structure parameters
Date:   Thu,  5 Jan 2023 11:50:26 +0800
Message-Id: <20230105035026.3091988-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgAnG+mqSLZjMHduBA--.6867S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtry7Zw4rtF4ruw4kKrW3Jrb_yoWxtF4Dpa
        nxu3ZIyF4kXrsrWFZ7Xw4kXF1ayaykXw1akFWfCa4furs8Jr95J3Z5KFWYyrWYkryvyF4a
        9rn0vr95Ar1fJ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wryl
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoO
        J5UUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

Extra_nregs of structure parameters and nr_args can be
added directly at the beginning, and using a flip flag
to identifiy structure parameters. Meantime, renaming
some variables to make them more sense.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Acked-by: Yonghong Song <yhs@fb.com>
---

v2:
- renaming flip flag and add comment for better understanding.
- add ACK by Yonghong.

v1:
https://lore.kernel.org/bpf/20230103013158.1945869-1-pulehui@huaweicloud.com

 arch/x86/net/bpf_jit_comp.c | 101 +++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 53 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3e2b57e4e13..ecdfc7bc45d2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1839,62 +1839,59 @@ st:			if (is_imm8(insn->off))
 	return proglen;
 }
 
-static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
+static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 		      int stack_size)
 {
-	int i, j, arg_size, nr_regs;
+	int i, j, arg_size;
+	bool next_same_struct = false;
+
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * mov QWORD PTR [rbp-0x10],rdi
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
-	for (i = 0, j = 0; i < min(nr_args, 6); i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
-			nr_regs = (m->arg_size[i] + 7) / 8;
+	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
+		/* The arg_size is at most 16 bytes, enforced by the verifier. */
+		arg_size = m->arg_size[j];
+		if (arg_size > 8) {
 			arg_size = 8;
-		} else {
-			nr_regs = 1;
-			arg_size = m->arg_size[i];
+			next_same_struct = !next_same_struct;
 		}
 
-		while (nr_regs) {
-			emit_stx(prog, bytes_to_bpf_size(arg_size),
-				 BPF_REG_FP,
-				 j == 5 ? X86_REG_R9 : BPF_REG_1 + j,
-				 -(stack_size - j * 8));
-			nr_regs--;
-			j++;
-		}
+		emit_stx(prog, bytes_to_bpf_size(arg_size),
+			 BPF_REG_FP,
+			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
+			 -(stack_size - i * 8));
+
+		j = next_same_struct ? j : j + 1;
 	}
 }
 
-static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
+static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_regs,
 			 int stack_size)
 {
-	int i, j, arg_size, nr_regs;
+	int i, j, arg_size;
+	bool next_same_struct = false;
 
 	/* Restore function arguments from stack.
 	 * For a function that accepts two pointers the sequence will be:
 	 * EMIT4(0x48, 0x8B, 0x7D, 0xF0); mov rdi,QWORD PTR [rbp-0x10]
 	 * EMIT4(0x48, 0x8B, 0x75, 0xF8); mov rsi,QWORD PTR [rbp-0x8]
 	 */
-	for (i = 0, j = 0; i < min(nr_args, 6); i++) {
-		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
-			nr_regs = (m->arg_size[i] + 7) / 8;
+	for (i = 0, j = 0; i < min(nr_regs, 6); i++) {
+		/* The arg_size is at most 16 bytes, enforced by the verifier. */
+		arg_size = m->arg_size[j];
+		if (arg_size > 8) {
 			arg_size = 8;
-		} else {
-			nr_regs = 1;
-			arg_size = m->arg_size[i];
+			next_same_struct = !next_same_struct;
 		}
 
-		while (nr_regs) {
-			emit_ldx(prog, bytes_to_bpf_size(arg_size),
-				 j == 5 ? X86_REG_R9 : BPF_REG_1 + j,
-				 BPF_REG_FP,
-				 -(stack_size - j * 8));
-			nr_regs--;
-			j++;
-		}
+		emit_ldx(prog, bytes_to_bpf_size(arg_size),
+			 i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
+			 BPF_REG_FP,
+			 -(stack_size - i * 8));
+
+		j = next_same_struct ? j : j + 1;
 	}
 }
 
@@ -2120,8 +2117,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				struct bpf_tramp_links *tlinks,
 				void *func_addr)
 {
-	int ret, i, nr_args = m->nr_args, extra_nregs = 0;
-	int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
+	int i, ret, nr_regs = m->nr_args, stack_size = 0;
+	int regs_off, nregs_off, ip_off, run_ctx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -2130,17 +2127,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	u8 *prog;
 	bool save_ret;
 
-	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
-	if (nr_args > 6)
-		return -ENOTSUPP;
-
-	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
+	/* extra registers for struct arguments */
+	for (i = 0; i < m->nr_args; i++)
 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
-			extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
-	}
-	if (nr_args + extra_nregs > 6)
+			nr_regs += (m->arg_size[i] + 7) / 8 - 1;
+
+	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
+	if (nr_regs > 6)
 		return -ENOTSUPP;
-	stack_size += extra_nregs * 8;
 
 	/* Generated trampoline stack layout:
 	 *
@@ -2154,7 +2148,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	 *                 [ ...             ]
 	 * RBP - regs_off  [ reg_arg1        ]  program's ctx pointer
 	 *
-	 * RBP - args_off  [ arg regs count  ]  always
+	 * RBP - nregs_off [ regs count	     ]  always
 	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 *
@@ -2166,11 +2160,12 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	if (save_ret)
 		stack_size += 8;
 
+	stack_size += nr_regs * 8;
 	regs_off = stack_size;
 
-	/* args count  */
+	/* regs count  */
 	stack_size += 8;
-	args_off = stack_size;
+	nregs_off = stack_size;
 
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8; /* room for IP address argument */
@@ -2198,11 +2193,11 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	EMIT1(0x53);		 /* push rbx */
 
 	/* Store number of argument registers of the traced function:
-	 *   mov rax, nr_args + extra_nregs
-	 *   mov QWORD PTR [rbp - args_off], rax
+	 *   mov rax, nr_regs
+	 *   mov QWORD PTR [rbp - nregs_off], rax
 	 */
-	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_args + extra_nregs);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -args_off);
+	emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		/* Store IP address of the traced function:
@@ -2213,7 +2208,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
 	}
 
-	save_regs(m, &prog, nr_args, regs_off);
+	save_regs(m, &prog, nr_regs, regs_off);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -2243,7 +2238,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_regs(m, &prog, nr_args, regs_off);
+		restore_regs(m, &prog, nr_regs, regs_off);
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
 			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
@@ -2284,7 +2279,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_regs(m, &prog, nr_args, regs_off);
+		restore_regs(m, &prog, nr_regs, regs_off);
 
 	/* This needs to be done regardless. If there were fmod_ret programs,
 	 * the return value is only updated on the stack and still needs to be
-- 
2.25.1

