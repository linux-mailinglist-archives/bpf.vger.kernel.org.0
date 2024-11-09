Return-Path: <bpf+bounces-44414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B59C2995
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 03:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19CDFB22D0B
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FDF1272A6;
	Sat,  9 Nov 2024 02:53:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C22E83F
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731120826; cv=none; b=HWVbqhqKUSEWKOhQ8YrfNuSykkrBFbsgCZh32JlHIOWyfsiRNq4c8beEGtCaBAA2qjuZEE7nnEz+G7W+e9Gwa9Rwmbtl9Hu/riSXIRTqBZQm0Su+0ALzhUCYQTfCqCcuodWTmjoyf9v88aCfYwJDW5BY7C1BV5VY9+Va+qmvCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731120826; c=relaxed/simple;
	bh=3F9zQatzPucCkRSyckr5pGBQ5ra3UpymGDqeN3eRFZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfsaWQCG47Q0OpkG5iPF7MK0BmGB7tbzlWxZ8VdCmSNp1LrguRjHN8B78ffYwYMv48vNRmh7QqKsYZe5jyaelLJNRab47RZdmlMjJkxa7MaQ8F6m3ja1eJ28gRCnSGoGQCAgO2gIeTcMMMcuKsMuXKNx/0XZcSf0ZwXtgXHDoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id B1C52AE0759B; Fri,  8 Nov 2024 18:53:32 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v11 4/7] bpf, x86: Support private stack in jit
Date: Fri,  8 Nov 2024 18:53:32 -0800
Message-ID: <20241109025332.150019-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241109025312.148539-1-yonghong.song@linux.dev>
References: <20241109025312.148539-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Private stack is allocated in function bpf_int_jit_compile() with
alignment 16. The x86 register 9 (X86_REG_R9) is used to replace
bpf frame register (BPF_REG_10). The private stack is used per
subprog per cpu. The X86_REG_R9 is saved and restored around every
func call (not including tailcall) to maintain correctness of
X86_REG_R9.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 77 +++++++++++++++++++++++++++++++++++++
 include/linux/bpf.h         |  1 +
 2 files changed, 78 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 3ff638c37999..55556a64f776 100644
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
@@ -1421,6 +1455,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 	int insn_cnt =3D bpf_prog->len;
 	bool seen_exit =3D false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
+	void __percpu *priv_frame_ptr =3D NULL;
 	u64 arena_vm_start, user_vm_start;
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
@@ -1429,6 +1464,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 	int err;
=20
 	stack_depth =3D bpf_prog->aux->stack_depth;
+	if (bpf_prog->aux->priv_stack_ptr) {
+		priv_frame_ptr =3D bpf_prog->aux->priv_stack_ptr + round_up(stack_dept=
h, 16);
+		stack_depth =3D 0;
+	}
=20
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
@@ -1457,6 +1496,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
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
@@ -1476,6 +1518,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
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
@@ -2136,9 +2186,15 @@ st:			if (is_imm8(insn->off))
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
@@ -3323,6 +3379,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
 	struct bpf_binary_header *rw_header =3D NULL;
 	struct bpf_binary_header *header =3D NULL;
 	struct bpf_prog *tmp, *orig_prog =3D prog;
+	void __percpu *priv_stack_ptr =3D NULL;
 	struct x64_jit_data *jit_data;
 	int proglen, oldproglen =3D 0;
 	struct jit_context ctx =3D {};
@@ -3359,6 +3416,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
 		}
 		prog->aux->jit_data =3D jit_data;
 	}
+	priv_stack_ptr =3D prog->aux->priv_stack_ptr;
+	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
+		priv_stack_ptr =3D __alloc_percpu_gfp(prog->aux->stack_depth, 16, GFP_=
KERNEL);
+		if (!priv_stack_ptr) {
+			prog =3D orig_prog;
+			goto out_priv_stack;
+		}
+		prog->aux->priv_stack_ptr =3D priv_stack_ptr;
+	}
 	addrs =3D jit_data->addrs;
 	if (addrs) {
 		ctx =3D jit_data->ctx;
@@ -3494,6 +3560,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
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
@@ -3547,6 +3618,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();
 		hdr =3D bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
+		free_percpu(prog->aux->priv_stack_ptr);
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
 	}
=20
@@ -3562,6 +3634,11 @@ bool bpf_jit_supports_exceptions(void)
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


