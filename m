Return-Path: <bpf+bounces-31911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C47E904EAB
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 10:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1991F2685F
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF64916D9B4;
	Wed, 12 Jun 2024 08:59:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 71C2A16D4EF;
	Wed, 12 Jun 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182742; cv=none; b=NbY8TYvPDAZx6Prt3Wg/A8UiilcZUEQqCJbx+O5NOuDwxXR4DkWavIeSS3bbTqN1skxhA4hXsTS5AfLwu7YSpoW65MC/nauPkqTYhE8CeAbxbw/CXyZ/BYP+L3Xz62zgyMyusy8N2KhboxzoEnn6Bpcv3ZEMcg+8BAKCBFWepJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182742; c=relaxed/simple;
	bh=IPCWgpd6c1bFEoB2WSV9QRjQj7pwRw3QVv26rxSLklw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=l+yp1dRdTYARkoG/NkN0SDMxkn2UuxOKAsrAXgzEbatk4s/eY4CYqPMOJVcNTP1d9sDmlAwTOG/fSOO3Qlr/WCRv3knwUTH69M5T8LCp0S50M9IeeRUcmf1Qjt4OxUk82SEEcou5ieLPq7BOG0O0fgJCGp157Vkn3Rg+NxGxAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 6C0126022F9AD;
	Wed, 12 Jun 2024 16:58:36 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: kunyu <kunyu@nfschina.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	udknight@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kunyu <kunyu@nfschina.com>
Subject: [PATCH] x86: net: bpf_jit_comp32: Remove unused 'cnt' variables from most functions
Date: Wed, 12 Jun 2024 16:58:23 +0800
Message-Id: <20240612085823.28133-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

In these functions, the 'cnt' variable is not used or does not require
value checking, so these 'cnt' variables can be removed.

Signed-off-by: kunyu <kunyu@nfschina.com>
---
 arch/x86/net/bpf_jit_comp32.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index de0f9e5f9f73..30f9b8a3faed 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -207,7 +207,6 @@ static inline void emit_ia32_mov_i(const u8 dst, const u32 val, bool dstk,
 				   u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 
 	if (dstk) {
 		if (val == 0) {
@@ -235,7 +234,6 @@ static inline void emit_ia32_mov_r(const u8 dst, const u8 src, bool dstk,
 				   bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 sreg = sstk ? IA32_EAX : src;
 
 	if (sstk)
@@ -286,7 +284,6 @@ static inline void emit_ia32_mul_r(const u8 dst, const u8 src, bool dstk,
 				   bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 sreg = sstk ? IA32_ECX : src;
 
 	if (sstk)
@@ -319,7 +316,6 @@ static inline void emit_ia32_to_le_r64(const u8 dst[], s32 val,
 					 const struct bpf_prog_aux *aux)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -367,7 +363,6 @@ static inline void emit_ia32_to_be_r64(const u8 dst[], s32 val,
 				       const struct bpf_prog_aux *aux)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -436,7 +431,6 @@ static inline void emit_ia32_div_mod_r(const u8 op, const u8 dst, const u8 src,
 				       bool dstk, bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 
 	if (sstk)
 		/* mov ecx,dword ptr [ebp+off] */
@@ -483,7 +477,6 @@ static inline void emit_ia32_shift_r(const u8 op, const u8 dst, const u8 src,
 				     bool dstk, bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg = dstk ? IA32_EAX : dst;
 	u8 b2;
 
@@ -525,7 +518,6 @@ static inline void emit_ia32_alu_r(const bool is64, const bool hi, const u8 op,
 				   bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 sreg = sstk ? IA32_EAX : src;
 	u8 dreg = dstk ? IA32_EDX : dst;
 
@@ -599,7 +591,6 @@ static inline void emit_ia32_alu_i(const bool is64, const bool hi, const u8 op,
 				   u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg = dstk ? IA32_EAX : dst;
 	u8 sreg = IA32_EDX;
 
@@ -698,7 +689,6 @@ static inline void emit_ia32_alu_i64(const bool is64, const u8 op,
 static inline void emit_ia32_neg64(const u8 dst[], bool dstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -732,7 +722,6 @@ static inline void emit_ia32_lsh_r64(const u8 dst[], const u8 src[],
 				     bool dstk, bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -785,7 +774,6 @@ static inline void emit_ia32_arsh_r64(const u8 dst[], const u8 src[],
 				      bool dstk, bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -838,7 +826,6 @@ static inline void emit_ia32_rsh_r64(const u8 dst[], const u8 src[], bool dstk,
 				     bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -891,7 +878,6 @@ static inline void emit_ia32_lsh_i64(const u8 dst[], const u32 val,
 				     bool dstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -939,7 +925,6 @@ static inline void emit_ia32_rsh_i64(const u8 dst[], const u32 val,
 				     bool dstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -988,7 +973,6 @@ static inline void emit_ia32_arsh_i64(const u8 dst[], const u32 val,
 				      bool dstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u8 dreg_lo = dstk ? IA32_EAX : dst_lo;
 	u8 dreg_hi = dstk ? IA32_EDX : dst_hi;
 
@@ -1036,7 +1020,6 @@ static inline void emit_ia32_mul_r64(const u8 dst[], const u8 src[], bool dstk,
 				     bool sstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 
 	if (dstk)
 		/* mov eax,dword ptr [ebp+off] */
@@ -1113,7 +1096,6 @@ static inline void emit_ia32_mul_i64(const u8 dst[], const u32 val,
 				     bool dstk, u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	u32 hi;
 
 	hi = val & (1<<31) ? (u32)~0 : 0;
@@ -1200,7 +1182,6 @@ struct jit_context {
 static void emit_prologue(u8 **pprog, u32 stack_depth)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 	const u8 *r1 = bpf2ia32[BPF_REG_1];
 	const u8 fplo = bpf2ia32[BPF_REG_FP][0];
 	const u8 fphi = bpf2ia32[BPF_REG_FP][1];
@@ -1237,7 +1218,6 @@ static void emit_prologue(u8 **pprog, u32 stack_depth)
 	EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EBX), STACK_VAR(tcc[0]));
 	EMIT3(0x89, add_2reg(0x40, IA32_EBP, IA32_EBX), STACK_VAR(tcc[1]));
 
-	BUILD_BUG_ON(cnt != PROLOGUE_SIZE);
 	*pprog = prog;
 }
 
@@ -1246,7 +1226,6 @@ static void emit_epilogue(u8 **pprog, u32 stack_depth)
 {
 	u8 *prog = *pprog;
 	const u8 *r0 = bpf2ia32[BPF_REG_0];
-	int cnt = 0;
 
 	/* mov eax,dword ptr [ebp+off]*/
 	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EAX), STACK_VAR(r0[0]));
@@ -1391,7 +1370,6 @@ static void emit_bpf_tail_call(u8 **pprog, u8 *ip)
 static inline void emit_push_r64(const u8 src[], u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 
 	/* mov ecx,dword ptr [ebp+off] */
 	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src_hi));
@@ -1409,7 +1387,6 @@ static inline void emit_push_r64(const u8 src[], u8 **pprog)
 static void emit_push_r32(const u8 src[], u8 **pprog)
 {
 	u8 *prog = *pprog;
-	int cnt = 0;
 
 	/* mov ecx,dword ptr [ebp+off] */
 	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ECX), STACK_VAR(src_lo));
@@ -1570,7 +1547,7 @@ static int emit_kfunc_call(const struct bpf_prog *bpf_prog, u8 *end_addr,
 			   const struct bpf_insn *insn, u8 **pprog)
 {
 	const u8 arg_regs[] = { IA32_EAX, IA32_EDX, IA32_ECX };
-	int i, cnt = 0, first_stack_regno, last_stack_regno;
+	int i, first_stack_regno, last_stack_regno;
 	int free_arg_regs = ARRAY_SIZE(arg_regs);
 	const struct btf_func_model *fm;
 	int bytes_in_stack = 0;
@@ -1663,7 +1640,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 	int insn_cnt = bpf_prog->len;
 	bool seen_exit = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
-	int i, cnt = 0;
+	int i;
 	int proglen = 0;
 	u8 *prog = temp;
 
-- 
2.18.2


