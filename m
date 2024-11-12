Return-Path: <bpf+bounces-44654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AC59C5D97
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 17:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563DD1F229C9
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 16:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7520697E;
	Tue, 12 Nov 2024 16:41:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008ED20694A
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429709; cv=none; b=gQa6oD+ldEsEXwdpFQVK2UT4veTEnzZdvFEhzyAdPOxkmXJeT3exsyupKgOWyt5uSeDJtwb0aQNGaKeN4HDVc0DBVlT2jedY9/GJtS5O8ZLWnNSZT8yc2rBPq6Nyx/UPo5s7el5oyFi5FeqC5mqDLI0I0eITSR8l1N5E1TY8FdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429709; c=relaxed/simple;
	bh=puhJigEer+P44jtcTAx1FZqoCdvu37SAMKDR0Z9YRHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEWxucy7yiipBoZOAMEQkc4bUXGTGm8BcrxIAHGgOuo4ccaKV9VOAuAbIudjqXoEQHND7MEP3LIoOtxXNvVs2gFwe3oI+nobYmWfkJBMnioA4zZxX+/1t0v26fBun73jM+Uzxis/1CH8SwfqtoZ4A3uPXGAOyTX9FzbMfS76zi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id A0F0DAFAF8C6; Tue, 12 Nov 2024 08:39:22 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v12 4/7] bpf, x86: Support private stack in jit
Date: Tue, 12 Nov 2024 08:39:22 -0800
Message-ID: <20241112163922.2224385-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112163902.2223011-1-yonghong.song@linux.dev>
References: <20241112163902.2223011-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Private stack is allocated in function bpf_int_jit_compile() with
alignment 8. Private stack allocation size includes the stack size
determined by verifier and additional space to protect stack overflow
and underflow. See below an illustration:
  ---> memory address increasing
  [8 bytes to protect overflow] [normal stack] [8 bytes to protect underf=
low]
If overflow/underflow is detected, kernel messages will be
emited in dmesg like
  BPF private stack overflow/underflow detected for prog Fx
  BPF Private stack overflow/underflow detected for prog bpf_prog_a41699c=
234a1567a_subprog1x
Those messages are generated when I made some changes to jitted code
to intentially cause overflow for some progs.

For the jited prog, The x86 register 9 (X86_REG_R9) is used to replace
bpf frame register (BPF_REG_10). The private stack is used per
subprog per cpu. The X86_REG_R9 is saved and restored around every
func call (not including tailcall) to maintain correctness of
X86_REG_R9.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 136 ++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h         |   1 +
 2 files changed, 137 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 3ff638c37999..8f896c32172c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -325,6 +325,22 @@ struct jit_context {
 /* Number of bytes that will be skipped on tailcall */
 #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
=20
+static void push_r9(u8 **pprog)
+{
+	u8 *prog =3D *pprog;
+
+	EMIT2(0x41, 0x51);   /* push r9 */
+	*pprog =3D prog;
+}
+
+static void pop_r9(u8 **pprog)
+{
+	u8 *prog =3D *pprog;
+
+	EMIT2(0x41, 0x59);   /* pop r9 */
+	*pprog =3D prog;
+}
+
 static void push_r12(u8 **pprog)
 {
 	u8 *prog =3D *pprog;
@@ -1404,6 +1420,24 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u=
8 src_reg, bool is64, u8 op)
 	*pprog =3D prog;
 }
=20
+static void emit_priv_frame_ptr(u8 **pprog, void __percpu *priv_frame_pt=
r)
+{
+	u8 *prog =3D *pprog;
+
+	/* movabs r9, priv_frame_ptr */
+	emit_mov_imm64(&prog, X86_REG_R9, (__force long) priv_frame_ptr >> 32,
+		       (u32) (__force long) priv_frame_ptr);
+
+#ifdef CONFIG_SMP
+	/* add <r9>, gs:[<off>] */
+	EMIT2(0x65, 0x4c);
+	EMIT3(0x03, 0x0c, 0x25);
+	EMIT((u32)(unsigned long)&this_cpu_off, 4);
+#endif
+
+	*pprog =3D prog;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
=20
 #define __LOAD_TCC_PTR(off)			\
@@ -1412,6 +1446,10 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u=
8 src_reg, bool is64, u8 op)
 #define LOAD_TAIL_CALL_CNT_PTR(stack)				\
 	__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
=20
+/* Memory size/value to protect private stack overflow/underflow */
+#define PRIV_STACK_GUARD_SZ    8
+#define PRIV_STACK_GUARD_VAL   0xEB9F12345678eb9fULL
+
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *=
rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -1421,7 +1459,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 	int insn_cnt =3D bpf_prog->len;
 	bool seen_exit =3D false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
+	void __percpu *priv_frame_ptr =3D NULL;
 	u64 arena_vm_start, user_vm_start;
+	void __percpu *priv_stack_ptr;
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
@@ -1429,6 +1469,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 	int err;
=20
 	stack_depth =3D bpf_prog->aux->stack_depth;
+	priv_stack_ptr =3D bpf_prog->aux->priv_stack_ptr;
+	if (priv_stack_ptr) {
+		priv_frame_ptr =3D priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(sta=
ck_depth, 8);
+		stack_depth =3D 0;
+	}
=20
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
@@ -1457,6 +1502,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 		emit_mov_imm64(&prog, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
=20
+	if (priv_frame_ptr)
+		emit_priv_frame_ptr(&prog, priv_frame_ptr);
+
 	ilen =3D prog - temp;
 	if (rw_image)
 		memcpy(rw_image + proglen, temp, ilen);
@@ -1476,6 +1524,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		u8 *func;
 		int nops;
=20
+		if (priv_frame_ptr) {
+			if (src_reg =3D=3D BPF_REG_FP)
+				src_reg =3D X86_REG_R9;
+
+			if (dst_reg =3D=3D BPF_REG_FP)
+				dst_reg =3D X86_REG_R9;
+		}
+
 		switch (insn->code) {
 			/* ALU */
 		case BPF_ALU | BPF_ADD | BPF_X:
@@ -2136,9 +2192,15 @@ st:			if (is_imm8(insn->off))
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (priv_frame_ptr) {
+				push_r9(&prog);
+				ip +=3D 2;
+			}
 			ip +=3D x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
+			if (priv_frame_ptr)
+				pop_r9(&prog);
 			break;
 		}
=20
@@ -3306,6 +3368,42 @@ int arch_prepare_bpf_dispatcher(void *image, void =
*buf, s64 *funcs, int num_func
 	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs, image, buf);
 }
=20
+static const char *bpf_get_prog_name(struct bpf_prog *prog)
+{
+	if (prog->aux->ksym.prog)
+		return prog->aux->ksym.name;
+	return prog->aux->name;
+}
+
+static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int all=
oc_size)
+{
+	int cpu, underflow_idx =3D (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
+	u64 *stack_ptr;
+
+	for_each_possible_cpu(cpu) {
+		stack_ptr =3D per_cpu_ptr(priv_stack_ptr, cpu);
+		stack_ptr[0] =3D PRIV_STACK_GUARD_VAL;
+		stack_ptr[underflow_idx] =3D PRIV_STACK_GUARD_VAL;
+	}
+}
+
+static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int al=
loc_size,
+				   struct bpf_prog *prog)
+{
+	int cpu, underflow_idx =3D (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
+	u64 *stack_ptr;
+
+	for_each_possible_cpu(cpu) {
+		stack_ptr =3D per_cpu_ptr(priv_stack_ptr, cpu);
+		if (stack_ptr[0] !=3D PRIV_STACK_GUARD_VAL ||
+		    stack_ptr[underflow_idx] !=3D PRIV_STACK_GUARD_VAL) {
+			pr_err("BPF private stack overflow/underflow detected for prog %sx\n"=
,
+			       bpf_get_prog_name(prog));
+			break;
+		}
+	}
+}
+
 struct x64_jit_data {
 	struct bpf_binary_header *rw_header;
 	struct bpf_binary_header *header;
@@ -3323,7 +3421,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
 	struct bpf_binary_header *rw_header =3D NULL;
 	struct bpf_binary_header *header =3D NULL;
 	struct bpf_prog *tmp, *orig_prog =3D prog;
+	void __percpu *priv_stack_ptr =3D NULL;
 	struct x64_jit_data *jit_data;
+	int priv_stack_alloc_sz;
 	int proglen, oldproglen =3D 0;
 	struct jit_context ctx =3D {};
 	bool tmp_blinded =3D false;
@@ -3359,6 +3459,23 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
 		}
 		prog->aux->jit_data =3D jit_data;
 	}
+	priv_stack_ptr =3D prog->aux->priv_stack_ptr;
+	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
+		/* Allocate actual private stack size with verifier-calculated
+		 * stack size plus two memory guards to protect overflow and
+		 * underflow.
+		 */
+		priv_stack_alloc_sz =3D round_up(prog->aux->stack_depth, 8) +
+				      2 * PRIV_STACK_GUARD_SZ;
+		priv_stack_ptr =3D __alloc_percpu_gfp(priv_stack_alloc_sz, 8, GFP_KERN=
EL);
+		if (!priv_stack_ptr) {
+			prog =3D orig_prog;
+			goto out_priv_stack;
+		}
+
+		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
+		prog->aux->priv_stack_ptr =3D priv_stack_ptr;
+	}
 	addrs =3D jit_data->addrs;
 	if (addrs) {
 		ctx =3D jit_data->ctx;
@@ -3494,6 +3611,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
 			bpf_prog_fill_jited_linfo(prog, addrs + 1);
 out_addrs:
 		kvfree(addrs);
+		if (!image && priv_stack_ptr) {
+			free_percpu(priv_stack_ptr);
+			prog->aux->priv_stack_ptr =3D NULL;
+		}
+out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data =3D NULL;
 	}
@@ -3532,6 +3654,8 @@ void bpf_jit_free(struct bpf_prog *prog)
 	if (prog->jited) {
 		struct x64_jit_data *jit_data =3D prog->aux->jit_data;
 		struct bpf_binary_header *hdr;
+		void __percpu *priv_stack_ptr;
+		int priv_stack_alloc_sz;
=20
 		/*
 		 * If we fail the final pass of JIT (from jit_subprogs),
@@ -3547,6 +3671,13 @@ void bpf_jit_free(struct bpf_prog *prog)
 		prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();
 		hdr =3D bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
+		priv_stack_ptr =3D prog->aux->priv_stack_ptr;
+		if (priv_stack_ptr) {
+			priv_stack_alloc_sz =3D round_up(prog->aux->stack_depth, 8) +
+					      2 * PRIV_STACK_GUARD_SZ;
+			priv_stack_check_guard(priv_stack_ptr, priv_stack_alloc_sz, prog);
+			free_percpu(prog->aux->priv_stack_ptr);
+		}
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
 	}
=20
@@ -3562,6 +3693,11 @@ bool bpf_jit_supports_exceptions(void)
 	return IS_ENABLED(CONFIG_UNWINDER_ORC);
 }
=20
+bool bpf_jit_supports_private_stack(void)
+{
+	return true;
+}
+
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie)
 {
 #if defined(CONFIG_UNWINDER_ORC)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 15f20d508174..9cfb8f55d691 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1507,6 +1507,7 @@ struct bpf_prog_aux {
 	u32 max_rdwr_access;
 	struct btf *attach_btf;
 	const struct bpf_ctx_arg_aux *ctx_arg_info;
+	void __percpu *priv_stack_ptr;
 	struct mutex dst_mutex; /* protects dst_* pointers below, *after* prog =
becomes visible */
 	struct bpf_prog *dst_prog;
 	struct bpf_trampoline *dst_trampoline;
--=20
2.43.5


