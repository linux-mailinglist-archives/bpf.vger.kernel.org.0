Return-Path: <bpf+bounces-43695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB919B89B5
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 04:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6C9B21990
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 03:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46552144D01;
	Fri,  1 Nov 2024 03:10:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1714375D
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430631; cv=none; b=FxYYVFQkJhsrIIuQvHoSuHRa0WODNS2AlBzsZs6A4xtpu0DNafEquCpyZKnwXQweThV02WsEF8q5uSbcWvVpZ9eOfsYBqjI/L+9fNZSy7c63Cq4elx+VAjTWoVaG2aqnSFNrUFlx8+8xtyIamPL+iG0PxnaX9aXpTkQiVM6bPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430631; c=relaxed/simple;
	bh=yGemHCqZpB+JfjrCz1yYHHmGhW+9Mr3xLUKBtAzyyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpCSB/zQGwHqmVMODwbySYJsMocavHXKnilpRrlNAIGKckEs/r+3pL/X4+z9cGuZ6ukkMflrS0bT/ah9a2iKSBkEfEz7BduR7phslneSunb/e2jyyN0d8+vwhHaIhQDX5gMNtT34oVrsmMG5MqvM6laxoUPX39INnRu5l7NSsts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D0F9CAA2EDD4; Thu, 31 Oct 2024 20:10:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v8 6/9] bpf, x86: Support private stack in jit
Date: Thu, 31 Oct 2024 20:10:21 -0700
Message-ID: <20241101031021.2679980-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101030950.2677215-1-yonghong.song@linux.dev>
References: <20241101030950.2677215-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Support private stack in jit. The x86 register 9 (X86_REG_R9) is used to
replace bpf frame register (BPF_REG_10). The private stack is used per
subprog if it is enabled by verifier. The X86_REG_R9 is saved and
restored around every func call (not including tailcall) to maintain
correctness of X86_REG_R9.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 181d9f04418f..4ee69071c26d 100644
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
h, 8);
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
@@ -3563,6 +3619,11 @@ bool bpf_jit_supports_exceptions(void)
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
--=20
2.43.5


