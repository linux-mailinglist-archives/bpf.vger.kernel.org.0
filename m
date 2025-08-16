Return-Path: <bpf+bounces-65825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D8B29001
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332FFAA14AF
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21AE2F9C23;
	Sat, 16 Aug 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDqepdxe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7443019D0
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367332; cv=none; b=Muk85lfQOlLBn4L3bqa7M/5LZYaqa/evxsA5oIb0f8PrdJf2Ld90eTI6mUQA0qn9uEeDTLxshOV5v+UiSNkQeobIJCp53iPJ6F2caZ5EwKPOxnKuWOkTAHkalCY2qyMSoyoTdh2yk0wlPRxZAh6gfURO75J23Ddxe4AxK5VOtc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367332; c=relaxed/simple;
	bh=2c9zNChE3gMMJSNETnndVYDgIwjtZmXi9OC6YziG4xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaiFn4IVpSIBjhXvb6QyWbdYjkeZPmtLEN5RA2QYThRQJZbKsVVWyLcC0fKyjBMOwvmLxxz1fNxUhzShT1cUOP3aFG7MafxdnK//8dLgCnPeg10NrtHqFtUIqJxYauwqAhvSdarkw10OblsZahCaC11imHZG08uL4jaX3hceOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDqepdxe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9e4148134so1441177f8f.2
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367327; x=1755972127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppvaPhZLO/xS9okJ5Zivtgf7uz0pAOQhWHp2bJz0Cfs=;
        b=FDqepdxeGFetPHL+6CZtnmYvs0pOTjT8Fteem30kGBc1X9iezaYhyRLcVbGCDXl7Jp
         3T/VflQ4KoBUYpAahUrSOM0B51jUIlcM73uc9Oczk1nrhePmqw89bpcNJUWoOGL+aASC
         3ovxTm6VRaDS7+ywDJFziq23XCCeIFRfRThpaqCOsokyDYuD9WUGDOFv6LXU6CU64ITT
         8bCTzH/vtVpOoMTHRaO15MziGHNs95djS2LS2u0rG6qkMRFg97e5XrJlV9EvkcziuQhA
         Mb/0WAFgeYykmeAluyYytcfnSrV0ti+PepHj6vmLaNg0DdN4HukSvcqZLUFUnTh2I/1Z
         fTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367327; x=1755972127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppvaPhZLO/xS9okJ5Zivtgf7uz0pAOQhWHp2bJz0Cfs=;
        b=asdVF6C2AJoL1nZBQVqsopeeziWsN7jk/WDe89qCibDLk0CvqRzQKcKFVaLyt0U8S7
         d764qn8avcjmmf2GYJIuIPSkYiOzhYGgj3ne8wtBOc7RqgIxG9t54+atBccDiUNT913d
         ulZe68+yX4RmvMwghFhWXayl4r/YMYA1Y8dcLMUl9nf5b0Gx6y2SwYtCNIWw1X5zC6O9
         6UdIZIJqWxDU+EbL5j3QcLGWibu5Y0Mv2ojUutm7gxBYSej4FK0CwgB7M5hXAEVNfhn7
         GCZXEvaPG61S2IkpS2SBNgwchhPcwAoBEXVUPiZChkCCockQ1yYqb/i5MUygYaqARiOL
         B9Vg==
X-Gm-Message-State: AOJu0Yw3AkSl9IZRQzkrNFCAjKON9LUFjKOiIZueWNjsLiZLvT2vOWgM
	TkqSUOsx1TuOVO/ub0slpFeT+xkktpsMSDQtsyo4hxBLmX1wABdU8LrDbHlrwg==
X-Gm-Gg: ASbGncvgWcr//zarDqh2oDcNBwd0Iug5EHXspejmhrJCaWpNTkTL8/TnCZEdBgHqXpP
	2cua2JFhwc4SSnW/ipr4x6vujoeVqbBeA9Q8X7cx9fSzDCsSWprrOfG1FrGkdj0eQCGo+xSP6eB
	ssLCkEhsexKB8DCIVsgkDhSXa4KDpfIXz1M2eQwQt50nEF6/dMKTjqGWzTe7o5GtckPlYuVYIYb
	LbxT75WEr5wxMDW3jIP37x3akZYLvIoZqxfCmyIe/JSW+LOPc4atxcAiySDpCQSvdK0VT0ZMmc5
	R6JnpDU3wFMDeLjKQG0SG8KZRS/TakbfZkdcYhKUe1LphDdMv3b9pc2ADo5h/76EIqnxhYl/LDa
	0vRv83uwqXc169xNXxC059MbDIidwRQuq3+9M9TPF9Aw=
X-Google-Smtp-Source: AGHT+IHA4SyClcwjpaV5DSxO8xlJBK9yhPTD4feV0aRTaVi6eyG+9JrsEBFTgm4lXbowy+K9m7OKsQ==
X-Received: by 2002:a5d:64ee:0:b0:3b8:f8e7:7fea with SMTP id ffacd0b85a97d-3bb6646103dmr4612618f8f.7.1755367327295;
        Sat, 16 Aug 2025 11:02:07 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:02:06 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v1 bpf-next 08/11] bpf, x86: add support for indirect jumps
Date: Sat, 16 Aug 2025 18:06:28 +0000
Message-Id: <20250816180631.952085-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for a new instruction

    BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0[, imm=fd(M)]

which does an indirect jump to a location stored in Rx.  The register
Rx should have type PTR_TO_INSN. This new type assures that the Rx
register contains a value (or a range of values) loaded from a
correct jump table – map of type instruction array.  The optional map
M can be used to associate the jump with a particular map. If not
given, then the verifier will collect all the possible maps with
targets withing the current subprogram.

Example: for a C switch LLVM will generate the following code:

    0:   r3 = r1                    # "switch (r3)"
    1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
    2:   r3 <<= 0x3                 # adjust to an index in array of addresses
    3:   r1 = 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_ptr=M
    5:   r1 += r3                   # r1 inherits boundaries from r3
    6:   r1 = *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
    7:   gotox r1[,imm=fd(M)]       # jit will generate proper code

Here the gotox instruction corresponds to one particular map. This is
possible however to have a gotox instruction which can be loaded from
different maps, e.g.

    0:	 r1 &= 0x1
    1:	 r2 <<= 0x3
    2:	 r3 = 0x0 ll                # load from map M_1
    4:	 r3 += r2
    5:	 if r1 == 0x0 goto +0x4
    6:	 r1 <<= 0x3
    7:	 r3 = 0x0 ll                # load from map M_2
    9:	 r3 += r1
    A:	 r1 = *(u64 *)(r3 + 0x0)
    B:	 gotox r1                   # jump to target loaded from M_1 or M_2

During check_cfg stage, if map M is not given inside the gotox
instruction, the verifier will collect all the maps which point to
inside the subprog being verified.  When building the config, the
high 16 bytes of the insn_state are used, so this patch
(theoretically) supports jump tables of up to 2^16 slots.

During the verification stage, in check_indirect_jump, it is checked
that the register Rx was loaded from a particular instruction array.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c  |  11 +-
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |  18 +-
 kernel/bpf/bpf_insn_array.c  |  16 +-
 kernel/bpf/core.c            |   1 +
 kernel/bpf/verifier.c        | 491 +++++++++++++++++++++++++++++++++--
 6 files changed, 515 insertions(+), 23 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 4bfb4faab4d7..f419a89b0147 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -671,9 +671,11 @@ static void __emit_indirect_jump(u8 **pprog, int reg, bool ereg)
 	*pprog = prog;
 }
 
-static void emit_indirect_jump(u8 **pprog, int reg, bool ereg, u8 *ip)
+static void emit_indirect_jump(u8 **pprog, int bpf_reg, u8 *ip)
 {
 	u8 *prog = *pprog;
+	int reg = reg2hex[bpf_reg];
+	bool ereg = is_ereg(bpf_reg);
 
 	if (cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS)) {
 		OPTIMIZER_HIDE_VAR(reg);
@@ -808,7 +810,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * rdi == ctx (1st arg)
 	 * rcx == prog->bpf_func + X86_TAIL_CALL_OFFSET
 	 */
-	emit_indirect_jump(&prog, 1 /* rcx */, false, ip + (prog - start));
+	emit_indirect_jump(&prog, BPF_REG_4 /* R4 -> rcx */, ip + (prog - start));
 
 	/* out: */
 	ctx->tail_call_indirect_label = prog - start;
@@ -2518,6 +2520,9 @@ st:			if (is_imm8(insn->off))
 
 			break;
 
+		case BPF_JMP | BPF_JA | BPF_X:
+			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
+			break;
 		case BPF_JMP | BPF_JA:
 		case BPF_JMP32 | BPF_JA:
 			if (BPF_CLASS(insn->code) == BPF_JMP) {
@@ -3454,7 +3459,7 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
 		if (err)
 			return err;
 
-		emit_indirect_jump(&prog, 2 /* rdx */, false, image + (prog - buf));
+		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
 
 		*pprog = prog;
 		return 0;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 534ce7733277..77d7f78315ea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -970,6 +970,7 @@ enum bpf_reg_type {
 	PTR_TO_ARENA,
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
+	PTR_TO_INSN,		 /* reg points to a bpf program instruction */
 	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
 	__BPF_REG_TYPE_MAX,
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index aca43c284203..6e68e0082c81 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -77,7 +77,15 @@ struct bpf_reg_state {
 			 * the map_uid is non-zero for registers
 			 * pointing to inner maps.
 			 */
-			u32 map_uid;
+			union {
+				u32 map_uid;
+
+				/* Used to track boundaries of a PTR_TO_INSN */
+				struct {
+					u32 min_index;
+					u32 max_index;
+				};
+			};
 		};
 
 		/* for PTR_TO_BTF_ID */
@@ -542,6 +550,11 @@ struct bpf_insn_aux_data {
 		struct {
 			u32 map_index;		/* index into used_maps[] */
 			u32 map_off;		/* offset from value base address */
+
+			struct jt {		/* jump table for gotox instruction */
+				u32 *off;
+				int off_cnt;
+			} jt;
 		};
 		struct {
 			enum bpf_reg_type reg_type;	/* type of pseudo_btf_id */
@@ -586,6 +599,9 @@ struct bpf_insn_aux_data {
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
 
+	/* true if jt->off was allocated */
+	bool jt_allocated;
+
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
 	bool jmp_point;
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 0c8dac62f457..d077a5aa2c7c 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/bpf.h>
-#include <linux/sort.h>
 
 #define MAX_INSN_ARRAY_ENTRIES 256
 
@@ -173,6 +172,20 @@ static u64 insn_array_mem_usage(const struct bpf_map *map)
 	return insn_array_alloc_size(map->max_entries) + extra_size;
 }
 
+static int insn_array_map_direct_value_addr(const struct bpf_map *map, u64 *imm, u32 off)
+{
+	struct bpf_insn_array *insn_array = cast_insn_array(map);
+
+	if ((off % sizeof(long)) != 0 ||
+	    (off / sizeof(long)) >= map->max_entries)
+		return -EINVAL;
+
+	/* from BPF's point of view, this map is a jump table */
+	*imm = (unsigned long)insn_array->ips + off / sizeof(long);
+
+	return 0;
+}
+
 BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
 
 const struct bpf_map_ops insn_array_map_ops = {
@@ -185,6 +198,7 @@ const struct bpf_map_ops insn_array_map_ops = {
 	.map_delete_elem = insn_array_delete_elem,
 	.map_check_btf = insn_array_check_btf,
 	.map_mem_usage = insn_array_mem_usage,
+	.map_direct_value_addr = insn_array_map_direct_value_addr,
 	.map_btf_id = &insn_array_btf_ids[0],
 };
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 27e9c30ad6dc..1ecd2362f4ce 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1739,6 +1739,7 @@ bool bpf_opcode_in_insntable(u8 code)
 		[BPF_LD | BPF_IND | BPF_B] = true,
 		[BPF_LD | BPF_IND | BPF_H] = true,
 		[BPF_LD | BPF_IND | BPF_W] = true,
+		[BPF_JMP | BPF_JA | BPF_X] = true,
 		[BPF_JMP | BPF_JCOND] = true,
 	};
 #undef BPF_INSN_3_TBL
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 863b7114866b..c2cfa55913f8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -212,6 +212,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 static void specialize_kfunc(struct bpf_verifier_env *env,
 			     u32 func_id, u16 offset, unsigned long *addr);
 static bool is_trusted_reg(const struct bpf_reg_state *reg);
+static int add_used_map(struct bpf_verifier_env *env, int fd);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -2957,14 +2958,13 @@ static int cmp_subprogs(const void *a, const void *b)
 	       ((struct bpf_subprog_info *)b)->start;
 }
 
-/* Find subprogram that contains instruction at 'off' */
-static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env *env, int off)
+static int find_containing_subprog_idx(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *vals = env->subprog_info;
 	int l, r, m;
 
 	if (off >= env->prog->len || off < 0 || env->subprog_cnt == 0)
-		return NULL;
+		return -1;
 
 	l = 0;
 	r = env->subprog_cnt - 1;
@@ -2975,7 +2975,19 @@ static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env
 		else
 			r = m - 1;
 	}
-	return &vals[l];
+	return l;
+}
+
+/* Find subprogram that contains instruction at 'off' */
+static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env *env, int off)
+{
+	int subprog_idx;
+
+	subprog_idx = find_containing_subprog_idx(env, off);
+	if (subprog_idx < 0)
+		return NULL;
+
+	return &env->subprog_info[subprog_idx];
 }
 
 /* Find subprogram that starts exactly at 'off' */
@@ -6072,6 +6084,14 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+static u32 map_mem_size(const struct bpf_map *map)
+{
+	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY)
+		return map->max_entries * sizeof(long);
+
+	return map->value_size;
+}
+
 /* check read/write into a map element with possible variable offset */
 static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 			    int off, int size, bool zero_size_allowed,
@@ -6081,11 +6101,11 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *reg = &state->regs[regno];
 	struct bpf_map *map = reg->map_ptr;
+	u32 mem_size = map_mem_size(map);
 	struct btf_record *rec;
 	int err, i;
 
-	err = check_mem_region_access(env, regno, off, size, map->value_size,
-				      zero_size_allowed);
+	err = check_mem_region_access(env, regno, off, size, mem_size, zero_size_allowed);
 	if (err)
 		return err;
 
@@ -7790,12 +7810,18 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
+static bool map_is_insn_array(struct bpf_map *map)
+{
+	return map && map->map_type == BPF_MAP_TYPE_INSN_ARRAY;
+}
+
 static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			  bool strict_alignment_once, bool is_ldsx,
 			  bool allow_trust_mismatch, const char *ctx)
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	enum bpf_reg_type src_reg_type;
+	struct bpf_map *map_ptr_copy = NULL;
 	int err;
 
 	/* check src operand */
@@ -7810,6 +7836,9 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 	src_reg_type = regs[insn->src_reg].type;
 
+	if (src_reg_type == PTR_TO_MAP_VALUE && map_is_insn_array(regs[insn->src_reg].map_ptr))
+		map_ptr_copy = regs[insn->src_reg].map_ptr;
+
 	/* Check if (src_reg + off) is readable. The state of dst_reg will be
 	 * updated by this call.
 	 */
@@ -7820,6 +7849,13 @@ static int check_load_mem(struct bpf_verifier_env *env, struct bpf_insn *insn,
 				       allow_trust_mismatch);
 	err = err ?: reg_bounds_sanity_check(env, &regs[insn->dst_reg], ctx);
 
+	if (map_ptr_copy) {
+		regs[insn->dst_reg].type = PTR_TO_INSN;
+		regs[insn->dst_reg].map_ptr = map_ptr_copy;
+		regs[insn->dst_reg].min_index = regs[insn->src_reg].min_index;
+		regs[insn->dst_reg].max_index = regs[insn->src_reg].max_index;
+	}
+
 	return err;
 }
 
@@ -14457,6 +14493,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg;
 	bool known = tnum_is_const(off_reg->var_off);
+	bool ptr_to_insn_array = base_type(ptr_reg->type) == PTR_TO_MAP_VALUE &&
+				 map_is_insn_array(ptr_reg->map_ptr);
 	s64 smin_val = off_reg->smin_value, smax_val = off_reg->smax_value,
 	    smin_ptr = ptr_reg->smin_value, smax_ptr = ptr_reg->smax_value;
 	u64 umin_val = off_reg->umin_value, umax_val = off_reg->umax_value,
@@ -14554,6 +14592,36 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 
 	switch (opcode) {
 	case BPF_ADD:
+		if (ptr_to_insn_array) {
+			u32 min_index = dst_reg->min_index;
+			u32 max_index = dst_reg->max_index;
+
+			if ((umin_val + ptr_reg->off) > (u64) U32_MAX * sizeof(long)) {
+				verbose(env, "umin_value %llu + offset %u is too big to convert to index\n",
+					     umin_val, ptr_reg->off);
+				return -EACCES;
+			}
+			if ((umax_val + ptr_reg->off) > (u64) U32_MAX * sizeof(long)) {
+				verbose(env, "umax_value %llu + offset %u is too big to convert to index\n",
+					     umax_val, ptr_reg->off);
+				return -EACCES;
+			}
+
+			min_index += (umin_val + ptr_reg->off) / sizeof(long);
+			max_index += (umax_val + ptr_reg->off) / sizeof(long);
+
+			if (min_index >= ptr_reg->map_ptr->max_entries) {
+				verbose(env, "min_index %u points to outside of map\n", min_index);
+				return -EACCES;
+			}
+			if (max_index >= ptr_reg->map_ptr->max_entries) {
+				verbose(env, "max_index %u points to outside of map\n", max_index);
+				return -EACCES;
+			}
+
+			dst_reg->min_index = min_index;
+			dst_reg->max_index = max_index;
+		}
 		/* We can take a fixed offset as long as it doesn't overflow
 		 * the s32 'off' field
 		 */
@@ -14598,6 +14666,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		}
 		break;
 	case BPF_SUB:
+		if (ptr_to_insn_array) {
+			verbose(env, "Operation %s on ptr to instruction set map is prohibited\n",
+				bpf_alu_string[opcode >> 4]);
+			return -EACCES;
+		}
 		if (dst_reg == off_reg) {
 			/* scalar -= pointer.  Creates an unknown scalar */
 			verbose(env, "R%d tried to subtract pointer from scalar\n",
@@ -16943,7 +17016,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		WARN_ON_ONCE(map->max_entries != 1);
+		WARN_ON_ONCE(map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
+			     map->max_entries != 1);
 		/* We want reg->id to be same (0) as map_value is not distinct */
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
@@ -17696,6 +17770,246 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 	return 0;
 }
 
+#define SET_HIGH(STATE, LAST)	STATE = (STATE & 0xffffU) | ((LAST) << 16)
+#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
+
+static int push_goto_x_edge(int t, struct bpf_verifier_env *env, struct jt *jt)
+{
+	int *insn_stack = env->cfg.insn_stack;
+	int *insn_state = env->cfg.insn_state;
+	u16 prev;
+	int w;
+
+	for (prev = GET_HIGH(insn_state[t]); prev < jt->off_cnt; prev++) {
+		w = jt->off[prev];
+
+		/* EXPLORED || DISCOVERED */
+		if (insn_state[w])
+			continue;
+
+		break;
+	}
+
+	if (prev == jt->off_cnt)
+		return DONE_EXPLORING;
+
+	mark_prune_point(env, t);
+
+	if (env->cfg.cur_stack >= env->prog->len)
+		return -E2BIG;
+	insn_stack[env->cfg.cur_stack++] = w;
+
+	mark_jmp_point(env, w);
+
+	SET_HIGH(insn_state[t], prev + 1);
+	return KEEP_EXPLORING;
+}
+
+static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *off)
+{
+	struct bpf_insn_array_value *value;
+	u32 i;
+
+	for (i = start; i <= end; i++) {
+		value = map->ops->map_lookup_elem(map, &i);
+		if (!value)
+			return -EINVAL;
+		off[i - start] = value->xlated_off;
+	}
+	return 0;
+}
+
+static int cmp_ptr_to_u32(const void *a, const void *b)
+{
+	return *(u32 *)a - *(u32 *)b;
+}
+
+static int sort_insn_array_uniq(u32 *off, int off_cnt)
+{
+	int unique = 1;
+	int i;
+
+	sort(off, off_cnt, sizeof(off[0]), cmp_ptr_to_u32, NULL);
+
+	for (i = 1; i < off_cnt; i++)
+		if (off[i] != off[unique - 1])
+			off[unique++] = off[i];
+
+	return unique;
+}
+
+/*
+ * sort_unique({map[start], ..., map[end]}) into off
+ */
+static int copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off)
+{
+	u32 n = end - start + 1;
+	int err;
+
+	err = copy_insn_array(map, start, end, off);
+	if (err)
+		return err;
+
+	return sort_insn_array_uniq(off, n);
+}
+
+/*
+ * Copy all unique offsets from the map
+ */
+static int jt_from_map(struct bpf_map *map, struct jt *jt)
+{
+	u32 *off;
+	int n;
+
+	off = kvcalloc(map->max_entries, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	if (!off)
+		return -ENOMEM;
+
+	n = copy_insn_array_uniq(map, 0, map->max_entries - 1, off);
+	if (n < 0) {
+		kvfree(off);
+		return n;
+	}
+
+	jt->off = off;
+	jt->off_cnt = n;
+	return 0;
+}
+
+/*
+ * Find and collect all maps which fit in the subprog. Return the result as one
+ * combined jump table in jt->off (allocated with kvcalloc
+ */
+static int jt_from_subprog(struct bpf_verifier_env *env,
+			   int subprog_start,
+			   int subprog_end,
+			   struct jt *jt)
+{
+	struct bpf_map *map;
+	struct jt jt_cur;
+	u32 *off;
+	int err;
+	int i;
+
+	jt->off = NULL;
+	jt->off_cnt = 0;
+
+	for (i = 0; i < env->insn_array_map_cnt; i++) {
+		/*
+		 * TODO (when needed): collect only jump tables, not static keys
+		 * or maps for indirect calls
+		 */
+		map = env->insn_array_maps[i];
+
+		err = jt_from_map(map, &jt_cur);
+		if (err) {
+			kvfree(jt->off);
+			return err;
+		}
+
+		/*
+		 * This is enough to check one element. The full table is
+		 * checked to fit inside the subprog later in create_jt()
+		 */
+		if (jt_cur.off[0] >= subprog_start && jt_cur.off[0] < subprog_end) {
+			off = kvrealloc(jt->off, (jt->off_cnt + jt_cur.off_cnt) << 2, GFP_KERNEL_ACCOUNT);
+			if (!off) {
+				kvfree(jt_cur.off);
+				kvfree(jt->off);
+				return -ENOMEM;
+			}
+			memcpy(off + jt->off_cnt, jt_cur.off, jt_cur.off_cnt << 2);
+			jt->off = off;
+			jt->off_cnt += jt_cur.off_cnt;
+		}
+
+		kvfree(jt_cur.off);
+	}
+
+	if (jt->off == NULL) {
+		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
+		return -EINVAL;
+	}
+
+	jt->off_cnt = sort_insn_array_uniq(jt->off, jt->off_cnt);
+	return 0;
+}
+
+static int create_jt(int t, struct bpf_verifier_env *env, int fd, struct jt *jt)
+{
+	static struct bpf_subprog_info *subprog;
+	int subprog_idx, subprog_start, subprog_end;
+	struct bpf_map *map;
+	int map_idx;
+	int ret;
+	int i;
+
+	if (env->subprog_cnt == 0)
+		return -EFAULT;
+
+	subprog_idx = find_containing_subprog_idx(env, t);
+	if (subprog_idx < 0) {
+		verbose(env, "can't find subprog containing instruction %d\n", t);
+		return -EFAULT;
+	}
+	subprog = &env->subprog_info[subprog_idx];
+	subprog_start = subprog->start;
+	subprog_end = (subprog + 1)->start;
+
+	map_idx = add_used_map(env, fd);
+	if (map_idx >= 0) {
+		map = env->used_maps[map_idx];
+		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
+			verbose(env, "map type %d in the gotox insn %d is incorrect\n",
+				     map->map_type, t);
+			return -EINVAL;
+		}
+
+		env->insn_aux_data[t].map_index = map_idx;
+
+		ret = jt_from_map(map, jt);
+		if (ret)
+			return ret;
+	} else {
+		ret = jt_from_subprog(env, subprog_start, subprog_end, jt);
+		if (ret)
+			return ret;
+	}
+
+	/* Check that the every element of the jump table fits within the given subprogram */
+	for (i = 0; i < jt->off_cnt; i++) {
+		if (jt->off[i] < subprog_start || jt->off[i] >= subprog_end) {
+			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]",
+					t, subprog_start, subprog_end);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* "conditional jump with N edges" */
+static int visit_goto_x_insn(int t, struct bpf_verifier_env *env, int fd)
+{
+	struct jt *jt = &env->insn_aux_data[t].jt;
+	int ret;
+
+	if (jt->off == NULL) {
+		ret = create_jt(t, env, fd, jt);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Mark jt as allocated. Otherwise, this is not possible to check if it
+	 * was allocated or not in the code which frees memory (jt is a part of
+	 * union)
+	 */
+	env->insn_aux_data[t].jt_allocated = true;
+
+	return push_goto_x_edge(t, env, jt);
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -17786,8 +18100,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
-		if (BPF_SRC(insn->code) != BPF_K)
-			return -EINVAL;
+		if (BPF_SRC(insn->code) == BPF_X)
+			return visit_goto_x_insn(t, env, insn->imm);
 
 		if (BPF_CLASS(insn->code) == BPF_JMP)
 			off = insn->off;
@@ -17818,6 +18132,13 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 	}
 }
 
+static bool insn_is_gotox(struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_JMP &&
+	       BPF_OP(insn->code) == BPF_JA &&
+	       BPF_SRC(insn->code) == BPF_X;
+}
+
 /* non-recursive depth-first-search to detect loops in BPF program
  * loop == back-edge in directed graph
  */
@@ -18679,6 +19000,10 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
 	case PTR_TO_ARENA:
 		return true;
+	case PTR_TO_INSN:
+		/* cur ⊆ old */
+		return (rcur->min_index >= rold->min_index &&
+			rcur->max_index <= rold->max_index);
 	default:
 		return regs_exact(rold, rcur, idmap);
 	}
@@ -19825,6 +20150,67 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	return PROCESS_BPF_EXIT;
 }
 
+/* gotox *dst_reg */
+static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	struct bpf_verifier_state *other_branch;
+	struct bpf_reg_state *dst_reg;
+	struct bpf_map *map;
+	int err = 0;
+	u32 *xoff;
+	int n;
+	int i;
+
+	dst_reg = reg_state(env, insn->dst_reg);
+	if (dst_reg->type != PTR_TO_INSN) {
+		verbose(env, "BPF_JA|BPF_X R%d has type %d, expected PTR_TO_INSN\n",
+				insn->dst_reg, dst_reg->type);
+		return -EINVAL;
+	}
+
+	map = dst_reg->map_ptr;
+	if (!map)
+		return -EINVAL;
+
+	if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY)
+		return -EINVAL;
+
+	if (dst_reg->max_index >= map->max_entries) {
+		verbose(env, "BPF_JA|BPF_X R%d is out of map boundaries: index=%u, max_index=%u\n",
+				insn->dst_reg, dst_reg->max_index, map->max_entries-1);
+		return -EINVAL;
+	}
+
+	xoff = kvcalloc(dst_reg->max_index - dst_reg->min_index + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	if (!xoff)
+		return -ENOMEM;
+
+	n = copy_insn_array_uniq(map, dst_reg->min_index, dst_reg->max_index, xoff);
+	if (n < 0) {
+		err = n;
+		goto free_off;
+	}
+	if (n == 0) {
+		verbose(env, "register R%d doesn't point to any offset in map id=%d\n",
+			     insn->dst_reg, map->id);
+		err = -EINVAL;
+		goto free_off;
+	}
+
+	for (i = 0; i < n - 1; i++) {
+		other_branch = push_stack(env, xoff[i], env->insn_idx, false);
+		if (IS_ERR(other_branch)) {
+			err = PTR_ERR(other_branch);
+			goto free_off;
+		}
+	}
+	env->insn_idx = xoff[n-1];
+
+free_off:
+	kvfree(xoff);
+	return err;
+}
+
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
 	int err;
@@ -19927,6 +20313,9 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			mark_reg_scratched(env, BPF_REG_0);
 		} else if (opcode == BPF_JA) {
+			if (BPF_SRC(insn->code) == BPF_X)
+				return check_indirect_jump(env, insn);
+
 			if (BPF_SRC(insn->code) != BPF_K ||
 			    insn->src_reg != BPF_REG_0 ||
 			    insn->dst_reg != BPF_REG_0 ||
@@ -20423,6 +20812,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_QUEUE:
 		case BPF_MAP_TYPE_STACK:
 		case BPF_MAP_TYPE_ARENA:
+		case BPF_MAP_TYPE_INSN_ARRAY:
 			break;
 		default:
 			verbose(env,
@@ -20981,6 +21371,23 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
 	return 0;
 }
 
+/*
+ * Clean up dynamically allocated fields of aux data for instructions [start, ..., end]
+ */
+static void clear_insn_aux_data(struct bpf_insn_aux_data *aux_data, int start, int end)
+{
+	int i;
+
+	for (i = start; i <= end; i++) {
+		if (aux_data[i].jt_allocated) {
+			kvfree(aux_data[i].jt.off);
+			aux_data[i].jt.off = NULL;
+			aux_data[i].jt.off_cnt = 0;
+			aux_data[i].jt_allocated = false;
+		}
+	}
+}
+
 static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
@@ -21004,6 +21411,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 
 	adjust_insn_arrays_after_remove(env, off, cnt);
 
+	clear_insn_aux_data(aux_data, off, off + cnt - 1);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -21643,6 +22052,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->used_maps = env->used_maps;
+		func[i]->aux->used_map_cnt = env->used_map_cnt;
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
@@ -24175,18 +24586,18 @@ static bool can_jump(struct bpf_insn *insn)
 	return false;
 }
 
-static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+static int insn_successors_regular(struct bpf_prog *prog, u32 insn_idx, u32 *succ)
 {
-	struct bpf_insn *insn = &prog->insnsi[idx];
+	struct bpf_insn *insn = &prog->insnsi[insn_idx];
 	int i = 0, insn_sz;
 	u32 dst;
 
 	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
-	if (can_fallthrough(insn) && idx + 1 < prog->len)
-		succ[i++] = idx + insn_sz;
+	if (can_fallthrough(insn) && insn_idx + 1 < prog->len)
+		succ[i++] = insn_idx + insn_sz;
 
 	if (can_jump(insn)) {
-		dst = idx + jmp_offset(insn) + 1;
+		dst = insn_idx + jmp_offset(insn) + 1;
 		if (i == 0 || succ[0] != dst)
 			succ[i++] = dst;
 	}
@@ -24194,6 +24605,36 @@ static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
 	return i;
 }
 
+static int insn_successors_gotox(struct bpf_verifier_env *env,
+				 struct bpf_prog *prog,
+				 u32 insn_idx, u32 **succ)
+{
+	struct jt *jt = &env->insn_aux_data[insn_idx].jt;
+
+	if (WARN_ON_ONCE(!jt->off || !jt->off_cnt))
+		return -EFAULT;
+
+	*succ = jt->off;
+	return jt->off_cnt;
+}
+
+/*
+ * Fill in *succ[0],...,*succ[n-1] with successors. The default *succ
+ * pointer (of size 2) may be replaced with a custom one if more
+ * elements are required (i.e., an indirect jump).
+ */
+static int insn_successors(struct bpf_verifier_env *env,
+			   struct bpf_prog *prog,
+			   u32 insn_idx, u32 **succ)
+{
+	struct bpf_insn *insn = &prog->insnsi[insn_idx];
+
+	if (unlikely(insn_is_gotox(insn)))
+		return insn_successors_gotox(env, prog, insn_idx, succ);
+
+	return insn_successors_regular(prog, insn_idx, *succ);
+}
+
 /* Each field is a register bitmask */
 struct insn_live_regs {
 	u16 use;	/* registers read by instruction */
@@ -24387,11 +24828,17 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 			int insn_idx = env->cfg.insn_postorder[i];
 			struct insn_live_regs *live = &state[insn_idx];
 			int succ_num;
-			u32 succ[2];
+			u32 _succ[2];
+			u32 *succ = &_succ[0];
 			u16 new_out = 0;
 			u16 new_in = 0;
 
-			succ_num = insn_successors(env->prog, insn_idx, succ);
+			succ_num = insn_successors(env, env->prog, insn_idx, &succ);
+			if (succ_num < 0) {
+				err = succ_num;
+				goto out;
+
+			}
 			for (int s = 0; s < succ_num; ++s)
 				new_out |= state[succ[s]].in;
 			new_in = (new_out & ~live->def) | live->use;
@@ -24453,7 +24900,6 @@ static int compute_scc(struct bpf_verifier_env *env)
 	u32 next_preorder_num;
 	u32 next_scc_id;
 	bool assign_scc;
-	u32 succ[2];
 
 	next_preorder_num = 1;
 	next_scc_id = 1;
@@ -24552,6 +24998,9 @@ static int compute_scc(struct bpf_verifier_env *env)
 		dfs[0] = i;
 dfs_continue:
 		while (dfs_sz) {
+			u32 _succ[2];
+			u32 *succ = &_succ[0];
+
 			w = dfs[dfs_sz - 1];
 			if (pre[w] == 0) {
 				low[w] = next_preorder_num;
@@ -24560,7 +25009,12 @@ static int compute_scc(struct bpf_verifier_env *env)
 				stack[stack_sz++] = w;
 			}
 			/* Visit 'w' successors */
-			succ_cnt = insn_successors(env->prog, w, succ);
+			succ_cnt = insn_successors(env, env->prog, w, &succ);
+			if (succ_cnt < 0) {
+				err = succ_cnt;
+				goto exit;
+
+			}
 			for (j = 0; j < succ_cnt; ++j) {
 				if (pre[succ[j]]) {
 					low[w] = min(low[w], low[succ[j]]);
@@ -24882,6 +25336,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
+	clear_insn_aux_data(env->insn_aux_data, 0, env->prog->len - 1);
 	vfree(env->insn_aux_data);
 err_free_env:
 	kvfree(env->cfg.insn_postorder);
-- 
2.34.1


