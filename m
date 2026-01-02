Return-Path: <bpf+bounces-77678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA48CEED06
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4469E3031CF9
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68A7231829;
	Fri,  2 Jan 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M2RBCzNU"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713F221FCC
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366123; cv=none; b=a9NS3AQrJ/u4O/w+anc6dKkm7r7fcnQjDyMcQHfrf3rTWiBuIXSED5DXkrwjEAVX3L0zWUL8fD/PwQSx7kgFeGVITQD427pkDeq/hsaRQeKQDTbgFeMdcffK+C1q8h9JAugpPUXpZJobsUGUQTUIatmkc5diDa9GCe1qg1hfj7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366123; c=relaxed/simple;
	bh=9z9KwVZl2eIaQzW4nWHUEeGkVv8W+C3AnzDLuPuwvtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9Xgbdc+4hMWmvXbigxGZU7RE+cSo66q1HN7wAhukxVzpzcSz2Jha3RZP6sppOIWQC6DJpmuSp1r6SjJAx5vSwNbzwhpYpb3t9wWSpvCHpTzGT/RGAC9WaSZmwHzKqql65lXf0RC0elfV92ASFk5eQiZc9mOKI4NuYCm4UqZFgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M2RBCzNU; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767366118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBeqdGdvFl1BmWay9YlcRFa2rBrCpDnyHLyz6aMx8E4=;
	b=M2RBCzNUMOTNgFWAb784JlFFJsR2RBXl/a5CTpz/ThH165B1UXHNkl1Z6ivhx0WURExrcQ
	RqglMXX/lbKgQmuIkVZ6ASmLu8QnxeO25eU+6L1LgjYdiiHqDU/JMLP3iFLYDpkyQpNPpc
	IiB2DGVMv8jAJImawbTJkni1y9JeTiU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next 2/4] bpf, x64: tailcall: Eliminate max_entries and bpf_func access at runtime
Date: Fri,  2 Jan 2026 23:00:30 +0800
Message-ID: <20260102150032.53106-3-leon.hwang@linux.dev>
In-Reply-To: <20260102150032.53106-1-leon.hwang@linux.dev>
References: <20260102150032.53106-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Optimize BPF tail calls on x86_64 by eliminating runtime memory accesses
for max_entries and prog->bpf_func when the prog array map is known at
verification time.

The verifier now encodes three fields in the tail call instruction's imm:
  - bits 0-7:   map index in used_maps[] (max 63)
  - bits 8-15:  dynamic array flag (1 if map pointer is poisoned)
  - bits 16-31: poke table index + 1 for direct tail calls (max 1023)

For static tail calls (map known at verification time):
  - max_entries is embedded as an immediate in the comparison instruction
  - The cached target from array->ptrs[max_entries + index] is used
    directly, avoiding the prog->bpf_func dereference

For dynamic tail calls (map pointer poisoned):
  - Fall back to runtime lookup of max_entries and prog->bpf_func

This reduces cache misses and improves tail call performance for the
common case where the prog array is statically known.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 51 +++++++++++++++++++++++++++----------
 kernel/bpf/verifier.c       | 30 ++++++++++++++++++++--
 2 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index e3b1c4b1d550..9fd707612da5 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -733,11 +733,13 @@ static void emit_return(u8 **pprog, u8 *ip)
  * out:
  */
 static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
+					u32 map_index, bool dyn_array,
 					u8 **pprog, bool *callee_regs_used,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
 	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
+	struct bpf_map *map = bpf_prog->aux->used_maps[map_index];
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -752,11 +754,14 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 *	goto out;
 	 */
 	EMIT2(0x89, 0xD2);                        /* mov edx, edx */
-	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], edx */
-	      offsetof(struct bpf_array, map.max_entries));
+	if (dyn_array)
+		EMIT3(0x3B, 0x56,                 /* cmp edx, dword ptr [rsi + 16] */
+		      offsetof(struct bpf_array, map.max_entries));
+	else
+		EMIT2_off32(0x81, 0xFA, map->max_entries); /* cmp edx, imm32 (map->max_entries) */
 
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
-	EMIT2(X86_JBE, offset);                   /* jbe out */
+	EMIT2(X86_JAE, offset);                   /* jae out */
 
 	/*
 	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
@@ -768,9 +773,15 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
 
-	/* prog = array->ptrs[index]; */
-	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
-		    offsetof(struct bpf_array, ptrs));
+	/*
+	 * if (dyn_array)
+	 *	prog = array->ptrs[index];
+	 * else
+	 *	tgt = array->ptrs[max_entries + index];
+	 */
+	offset = offsetof(struct bpf_array, ptrs);
+	offset += dyn_array ? 0 : map->max_entries * sizeof(void *);
+	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6, offset); /* mov rcx, [rsi + rdx * 8 + offset] */
 
 	/*
 	 * if (prog == NULL)
@@ -803,11 +814,14 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
 			    round_up(stack_depth, 8));
 
-	/* goto *(prog->bpf_func + X86_TAIL_CALL_OFFSET); */
-	EMIT4(0x48, 0x8B, 0x49,                   /* mov rcx, qword ptr [rcx + 32] */
-	      offsetof(struct bpf_prog, bpf_func));
-	EMIT4(0x48, 0x83, 0xC1,                   /* add rcx, X86_TAIL_CALL_OFFSET */
-	      X86_TAIL_CALL_OFFSET);
+	if (dyn_array) {
+		/* goto *(prog->bpf_func + X86_TAIL_CALL_OFFSET); */
+		EMIT4(0x48, 0x8B, 0x49,           /* mov rcx, qword ptr [rcx + 32] */
+		      offsetof(struct bpf_prog, bpf_func));
+		EMIT4(0x48, 0x83, 0xC1,           /* add rcx, X86_TAIL_CALL_OFFSET */
+		      X86_TAIL_CALL_OFFSET);
+	}
+
 	/*
 	 * Now we're ready to jump into next BPF program
 	 * rdi == ctx (1st arg)
@@ -2461,15 +2475,21 @@ st:			if (is_imm8(insn->off))
 		}
 
 		case BPF_JMP | BPF_TAIL_CALL:
-			if (imm32)
+			bool dynamic_array = (imm32 >> 8) & 0xFF;
+			u32 map_index = imm32 & 0xFF;
+			s32 imm16 = imm32 >> 16;
+
+			if (imm16)
 				emit_bpf_tail_call_direct(bpf_prog,
-							  &bpf_prog->aux->poke_tab[imm32 - 1],
+							  &bpf_prog->aux->poke_tab[imm16 - 1],
 							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
 							  stack_depth,
 							  ctx);
 			else
 				emit_bpf_tail_call_indirect(bpf_prog,
+							    map_index,
+							    dynamic_array,
 							    &prog,
 							    callee_regs_used,
 							    stack_depth,
@@ -4047,6 +4067,11 @@ void bpf_arch_poke_desc_update(struct bpf_jit_poke_descriptor *poke,
 	}
 }
 
+int bpf_arch_tail_call_prologue_offset(void)
+{
+	return X86_TAIL_CALL_OFFSET;
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return true;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d44c5d06623..ab9c84e76a62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22602,6 +22602,18 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	return 0;
 }
 
+static int tail_call_find_map_index(struct bpf_verifier_env *env, struct bpf_map *map)
+{
+	int i;
+
+	for (i = 0; i < env->used_map_cnt; i++) {
+		if (env->used_maps[i] == map)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -22993,10 +23005,24 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 * call and to prevent accidental JITing by JIT compiler
 			 * that doesn't support bpf_tail_call yet
 			 */
-			insn->imm = 0;
 			insn->code = BPF_JMP | BPF_TAIL_CALL;
 
+			/*
+			 * insn->imm contains 3 fields:
+			 *   map index(8 bits):   6 bits are enough, 63 max
+			 *   poisoned(8 bits):    1 bit is enough
+			 *   poke index(16 bits): 1023 max
+			 */
+
 			aux = &env->insn_aux_data[i + delta];
+			insn->imm = tail_call_find_map_index(env, aux->map_ptr_state.map_ptr);
+			if (insn->imm < 0) {
+				verifier_bug(env, "index not found for prog array map\n");
+				return -EINVAL;
+			}
+
+			insn->imm |= bpf_map_ptr_poisoned(aux) << 8;
+
 			if (env->bpf_capable && !prog->blinding_requested &&
 			    prog->jit_requested &&
 			    !bpf_map_key_poisoned(aux) &&
@@ -23015,7 +23041,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 					return ret;
 				}
 
-				insn->imm = ret + 1;
+				insn->imm |= (ret + 1) << 16;
 				goto next_insn;
 			}
 
-- 
2.52.0


