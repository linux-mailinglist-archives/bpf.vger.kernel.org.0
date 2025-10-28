Return-Path: <bpf+bounces-72544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DE2C15204
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A1904F46AC
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5E03375C5;
	Tue, 28 Oct 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No9TNUFa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C0336EE4
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660919; cv=none; b=dtn5V/OYslDyCjy9c4Rx/Vpj4gLVfq//O26giLre8uS6LFjEYKLe28mTm6bjCUfcgVKPcVSyOnpBaklYvYjkQqOg09noNkJhn8UkiTqs4Xe686jZb1simNW+5KZZIIMfNtGAr/y24KHHDXWbkHXKfTmJeXrp25hVjWPSlO/yXeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660919; c=relaxed/simple;
	bh=5rGtk6QitpyNWwiMv372/B0uJ4QaFFncdM72JiCY83M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjP9xnv0Frzn6qI1+CUy1GJbSI2IkDP9wgCKrJD3A1CwcZB4AonzA6EbGx1d6pFox7gFzJJTuF3jzEZkoz/Jd2ZlgrWycMCHFQtZXiPcF0H18ugLxOXdIvHE3ili/FHfs9mtZQKiOSK4MWFb80n0KngLkgBRXJrFqe+tnde0yXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=No9TNUFa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4298bada5bdso5528352f8f.2
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660915; x=1762265715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJR4yhqtOSzdOh1FVy/cVEqqPbSwspnnT0k9Zku3FWY=;
        b=No9TNUFaE1OO2OF+KR47Qw6i1KDc3CXnGp9JeyYTCGrAzDADODsjhiwU0RBQvNZ7LH
         mvnYUizKJjpEihUeW7JHx8ev2iVauAqL2IF5Yp40Dp1Ynv82nRgcyQH8qrOopbkv7ymP
         m8zWzaUOLywZjvF8Ebh/UDh/QRk7Ah6Ns8LaDTkZGRRRPCzAILLfdptflpz4MEZgKmoV
         mHZOvQFhsiOSKDZnl7VshgelBIg3Nmos6lCk1EV2nj8WieEmcr2ltbx2ajEBQPhKKE4l
         bb8Tc923LINwZxemTpDaH6Sg9y6hhon0xxoW9eb3py5EF3R5B5igWroENyxe/lUcHk3j
         GoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660915; x=1762265715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJR4yhqtOSzdOh1FVy/cVEqqPbSwspnnT0k9Zku3FWY=;
        b=LpFrphdhu/7TOH13+QKKkKCf2RXw0IbjG9/NpsROnJHJsHN+QLJiMPtLQ9GePgRw/9
         i6Kx7CCRbc0AbIJLAx7g35sGp37rwzClIzkwz87lOFGR0izp7UZERFFiTVeuSweBW3ce
         dbUCiDu9YOIllMB04ZBViFyk/Pdb7imDcrg7n26/1elDYRG4xdz2VRPZMT4MuHzCl52F
         mf4MJhfaLuOfp+3TBcHwc/KCA6m8y3vgRFggINsge2IiF0vzLtgggnfTuN0MmnUf5XKI
         AsNpC/DkppirW57ambExwcId+Z3cuukkN56Gm0lZscuoWHiTCoxDykihDLTw62UQiQ8A
         q6uQ==
X-Gm-Message-State: AOJu0YzwGKqwZ73N2zxg6kjDBPFMNJCME9QE+KIX0uCIWkeVdgIWjDn2
	NLVgHX8lawT4P+0gnc5N535XSNLtVH/Ggqm5W1S42biuKYSmQEPjX5rXVnJNQA==
X-Gm-Gg: ASbGncs2tdAu3hTpV5sqpNFqRWN+smJm3a92XQxeLF/wJkY5EGfSt8OXdLx/xc4zOYT
	7SPtt8nqwL3/isZh+DFsLSJKZqTNkLyQcc36nXG9lWZTvzEDyYEXLSMlf0NAxu6iOa0+OmvkRyO
	xrpTOAlvLsIxrKVsEW8jDWS7HwDlBJZ77/skZMilamOWh/sgf1W94+5jaloqod5pqRBWgsm1Qc+
	6zj/LfdxUJLus11Hn6E1zguasU+XUeZLaoN9b3P0wZRn3mCrlWy9sVWtZdTg8wwK2y7otB9mHcw
	Sed9g+tJvzMZmMblwJxNpb/uhavASe5VolabvQh503s1mYpGsdDOj+9QTc7LMQZJmxSGoYBNtEH
	cfIIami7zLJ/FIr0o0Z2oUEyy88FaJdtGeyB+/Ldd7pvzHYVxRZAspCAygSWurU/2ZSBJgjmxz6
	Az2T9hIqM4Gdu8gtDruFWdBGgl+lIQBw==
X-Google-Smtp-Source: AGHT+IGZ3dBtazZXrBXJ98gxFKxcXvKfj3PHIphgNQ0vM7UwHZ+vA4+ojVLpZPJ9Ph+rvSAJXWPrwA==
X-Received: by 2002:a05:6000:1789:b0:428:55c3:ceda with SMTP id ffacd0b85a97d-429a7e59bc3mr3437314f8f.20.1761660915240;
        Tue, 28 Oct 2025 07:15:15 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:13 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 06/11] bpf, x86: add support for indirect jumps
Date: Tue, 28 Oct 2025 14:20:44 +0000
Message-Id: <20251028142049.1324520-7-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for a new instruction

    BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=0

which does an indirect jump to a location stored in Rx.  The register
Rx should have type PTR_TO_INSN. This new type assures that the Rx
register contains a value (or a range of values) loaded from a
correct jump table – map of type instruction array.

For example, for a C switch LLVM will generate the following code:

    0:   r3 = r1                    # "switch (r3)"
    1:   if r3 > 0x13 goto +0x666   # check r3 boundaries
    2:   r3 <<= 0x3                 # adjust to an index in array of addresses
    3:   r1 = 0xbeef ll             # r1 is PTR_TO_MAP_VALUE, r1->map_ptr=M
    5:   r1 += r3                   # r1 inherits boundaries from r3
    6:   r1 = *(u64 *)(r1 + 0x0)    # r1 now has type INSN_TO_PTR
    7:   gotox r1                   # jit will generate proper code

Here the gotox instruction corresponds to one particular map. This is
possible however to have a gotox instruction which can be loaded from
different maps, e.g.

    0:   r1 &= 0x1
    1:   r2 <<= 0x3
    2:   r3 = 0x0 ll                # load from map M_1
    4:   r3 += r2
    5:   if r1 == 0x0 goto +0x4
    6:   r1 <<= 0x3
    7:   r3 = 0x0 ll                # load from map M_2
    9:   r3 += r1
    A:   r1 = *(u64 *)(r3 + 0x0)
    B:   gotox r1                   # jump to target loaded from M_1 or M_2

During check_cfg stage the verifier will collect all the maps which
point to inside the subprog being verified. When building the config,
the high 16 bytes of the insn_state are used, so this patch
(theoretically) supports jump tables of up to 2^16 slots.

During the later stage, in check_indirect_jump, it is checked that
the register Rx was loaded from a particular instruction array.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c  |   3 +
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |   9 +
 kernel/bpf/bpf_insn_array.c  |  15 ++
 kernel/bpf/core.c            |   1 +
 kernel/bpf/liveness.c        |   3 +
 kernel/bpf/log.c             |   1 +
 kernel/bpf/verifier.c        | 364 ++++++++++++++++++++++++++++++++++-
 8 files changed, 391 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index c1f686df6fbc..a97a1d778a4c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2628,6 +2628,9 @@ st:			if (is_imm8(insn->off))
 
 			break;
 
+		case BPF_JMP | BPF_JA | BPF_X:
+			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
+			break;
 		case BPF_JMP | BPF_JA:
 		case BPF_JMP32 | BPF_JA:
 			if (BPF_CLASS(insn->code) == BPF_JMP) {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9d41a6affcef..09d5dc541d1c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1001,6 +1001,7 @@ enum bpf_reg_type {
 	PTR_TO_ARENA,
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
+	PTR_TO_INSN,		 /* reg points to a bpf program instruction */
 	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
 	__BPF_REG_TYPE_MAX,
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 6b820d8d77af..5441341f1ab9 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -527,6 +527,7 @@ struct bpf_insn_aux_data {
 		struct {
 			u32 map_index;		/* index into used_maps[] */
 			u32 map_off;		/* offset from value base address */
+			struct bpf_iarray *jt;	/* jump table for gotox instruction */
 		};
 		struct {
 			enum bpf_reg_type reg_type;	/* type of pseudo_btf_id */
@@ -840,6 +841,7 @@ struct bpf_verifier_env {
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
+	struct bpf_iarray *gotox_tmp_buf;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1050,6 +1052,13 @@ static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_
 	return !(off % BPF_REG_SIZE);
 }
 
+static inline bool insn_is_gotox(struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_JMP &&
+	       BPF_OP(insn->code) == BPF_JA &&
+	       BPF_SRC(insn->code) == BPF_X;
+}
+
 const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type);
 const char *dynptr_type_str(enum bpf_dynptr_type type);
 const char *iter_type_str(const struct btf *btf, u32 btf_id);
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index dc66154466b3..81b0484e4a2a 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -119,6 +119,20 @@ static u64 insn_array_mem_usage(const struct bpf_map *map)
 	return insn_array_alloc_size(map->max_entries);
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
+	*imm = (unsigned long)insn_array->ips + off;
+
+	return 0;
+}
+
 BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
 
 const struct bpf_map_ops insn_array_map_ops = {
@@ -131,6 +145,7 @@ const struct bpf_map_ops insn_array_map_ops = {
 	.map_delete_elem = insn_array_delete_elem,
 	.map_check_btf = insn_array_check_btf,
 	.map_mem_usage = insn_array_mem_usage,
+	.map_direct_value_addr = insn_array_map_direct_value_addr,
 	.map_btf_id = &insn_array_btf_ids[0],
 };
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4b62a03d6df5..ef4448f18aad 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1708,6 +1708,7 @@ bool bpf_opcode_in_insntable(u8 code)
 		[BPF_LD | BPF_IND | BPF_B] = true,
 		[BPF_LD | BPF_IND | BPF_H] = true,
 		[BPF_LD | BPF_IND | BPF_W] = true,
+		[BPF_JMP | BPF_JA | BPF_X] = true,
 		[BPF_JMP | BPF_JCOND] = true,
 	};
 #undef BPF_INSN_3_TBL
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index bffb495bc933..a7240013fd9d 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -485,6 +485,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 	struct bpf_iarray *succ;
 	int insn_sz;
 
+	if (unlikely(insn_is_gotox(insn)))
+		return env->insn_aux_data[idx].jt;
+
 	/* pre-allocated array of size up to 2; reset cnt, as it may have been used already */
 	succ = env->succ;
 	succ->cnt = 0;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 70221aafc35c..a0c3b35de2ce 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -461,6 +461,7 @@ const char *reg_type_str(struct bpf_verifier_env *env, enum bpf_reg_type type)
 		[PTR_TO_ARENA]		= "arena",
 		[PTR_TO_BUF]		= "buf",
 		[PTR_TO_FUNC]		= "func",
+		[PTR_TO_INSN]		= "insn",
 		[PTR_TO_MAP_KEY]	= "map_key",
 		[CONST_PTR_TO_DYNPTR]	= "dynptr_ptr",
 	};
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2b771e2bf35a..3fdabae07f85 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6006,6 +6006,18 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
 	return 0;
 }
 
+/*
+ * Return the size of the memory region accessible from a pointer to map value.
+ * For INSN_ARRAY maps whole bpf_insn_array->ips array is accessible.
+ */
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
@@ -6015,11 +6027,11 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
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
 
@@ -7481,6 +7493,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
+	bool insn_array = reg->type == PTR_TO_MAP_VALUE &&
+			  reg->map_ptr->map_type == BPF_MAP_TYPE_INSN_ARRAY;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -7488,7 +7502,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		return size;
 
 	/* alignment checks will add in reg->off themselves */
-	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once);
+	err = check_ptr_alignment(env, reg, off, size, strict_alignment_once || insn_array);
 	if (err)
 		return err;
 
@@ -7515,6 +7529,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			verbose(env, "R%d leaks addr into map\n", value_regno);
 			return -EACCES;
 		}
+		if (t == BPF_WRITE && insn_array) {
+			verbose(env, "writes into insn_array not allowed\n");
+			return -EACCES;
+		}
+
 		err = check_map_access_type(env, regno, off, size, t);
 		if (err)
 			return err;
@@ -7543,6 +7562,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 				regs[value_regno].type = SCALAR_VALUE;
 				__mark_reg_known(&regs[value_regno], val);
+			} else if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
+				if (bpf_size != BPF_DW) {
+					verbose(env, "Invalid read of %d bytes from insn_array\n",
+						     size);
+					return -EACCES;
+				}
+				copy_register_state(&regs[value_regno], reg);
+				regs[value_regno].type = PTR_TO_INSN;
 			} else {
 				mark_reg_unknown(env, regs, value_regno);
 			}
@@ -17065,7 +17092,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		WARN_ON_ONCE(map->max_entries != 1);
+		WARN_ON_ONCE(map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
+			     map->max_entries != 1);
 		/* We want reg->id to be same (0) as map_value is not distinct */
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
@@ -17833,6 +17861,197 @@ static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
 	return new;
 }
 
+static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
+{
+	struct bpf_insn_array_value *value;
+	u32 i;
+
+	for (i = start; i <= end; i++) {
+		value = map->ops->map_lookup_elem(map, &i);
+		if (!value)
+			return -EINVAL;
+		items[i - start] = value->xlated_off;
+	}
+	return 0;
+}
+
+static int cmp_ptr_to_u32(const void *a, const void *b)
+{
+	return *(u32 *)a - *(u32 *)b;
+}
+
+static int sort_insn_array_uniq(u32 *items, int cnt)
+{
+	int unique = 1;
+	int i;
+
+	sort(items, cnt, sizeof(items[0]), cmp_ptr_to_u32, NULL);
+
+	for (i = 1; i < cnt; i++)
+		if (items[i] != items[unique - 1])
+			items[unique++] = items[i];
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
+static struct bpf_iarray *jt_from_map(struct bpf_map *map)
+{
+	struct bpf_iarray *jt;
+	int n;
+
+	jt = iarray_realloc(NULL, map->max_entries);
+	if (!jt)
+		return ERR_PTR(-ENOMEM);
+
+	n = copy_insn_array_uniq(map, 0, map->max_entries - 1, jt->items);
+	if (n < 0) {
+		kvfree(jt);
+		return ERR_PTR(n);
+	}
+
+	return jt;
+}
+
+/*
+ * Find and collect all maps which fit in the subprog. Return the result as one
+ * combined jump table in jt->items (allocated with kvcalloc)
+ */
+static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
+					  int subprog_start, int subprog_end)
+{
+	struct bpf_iarray *jt = NULL;
+	struct bpf_map *map;
+	struct bpf_iarray *jt_cur;
+	int i;
+
+	for (i = 0; i < env->insn_array_map_cnt; i++) {
+		/*
+		 * TODO (when needed): collect only jump tables, not static keys
+		 * or maps for indirect calls
+		 */
+		map = env->insn_array_maps[i];
+
+		jt_cur = jt_from_map(map);
+		if (IS_ERR(jt_cur)) {
+			kvfree(jt);
+			return jt_cur;
+		}
+
+		/*
+		 * This is enough to check one element. The full table is
+		 * checked to fit inside the subprog later in create_jt()
+		 */
+		if (jt_cur->items[0] >= subprog_start && jt_cur->items[0] < subprog_end) {
+			u32 old_cnt = jt ? jt->cnt : 0;
+			jt = iarray_realloc(jt, old_cnt + jt_cur->cnt);
+			if (!jt) {
+				kvfree(jt_cur);
+				return ERR_PTR(-ENOMEM);
+			}
+			memcpy(jt->items + old_cnt, jt_cur->items, jt_cur->cnt << 2);
+		}
+
+		kvfree(jt_cur);
+	}
+
+	if (!jt) {
+		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
+		return ERR_PTR(-EINVAL);
+	}
+
+	jt->cnt = sort_insn_array_uniq(jt->items, jt->cnt);
+	return jt;
+}
+
+static struct bpf_iarray *
+create_jt(int t, struct bpf_verifier_env *env)
+{
+	static struct bpf_subprog_info *subprog;
+	int subprog_start, subprog_end;
+	struct bpf_iarray *jt;
+	int i;
+
+	subprog = bpf_find_containing_subprog(env, t);
+	subprog_start = subprog->start;
+	subprog_end = (subprog + 1)->start;
+	jt = jt_from_subprog(env, subprog_start, subprog_end);
+	if (IS_ERR(jt))
+		return jt;
+
+	/* Check that the every element of the jump table fits within the given subprogram */
+	for (i = 0; i < jt->cnt; i++) {
+		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
+			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
+					t, subprog_start, subprog_end);
+			kvfree(jt);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	return jt;
+}
+
+/* "conditional jump with N edges" */
+static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
+{
+	int *insn_stack = env->cfg.insn_stack;
+	int *insn_state = env->cfg.insn_state;
+	bool keep_exploring = false;
+	struct bpf_iarray *jt;
+	int i, w;
+
+	jt = env->insn_aux_data[t].jt;
+	if (!jt) {
+		jt = create_jt(t, env);
+		if (IS_ERR(jt))
+			return PTR_ERR(jt);
+
+		env->insn_aux_data[t].jt = jt;
+	}
+
+	mark_prune_point(env, t);
+	for (i = 0; i < jt->cnt; i++) {
+		w = jt->items[i];
+		if (w < 0 || w >= env->prog->len) {
+			verbose(env, "indirect jump out of range from insn %d to %d\n", t, w);
+			return -EINVAL;
+		}
+
+		mark_jmp_point(env, w);
+
+		/* EXPLORED || DISCOVERED */
+		if (insn_state[w])
+			continue;
+
+		if (env->cfg.cur_stack >= env->prog->len)
+			return -E2BIG;
+
+		insn_stack[env->cfg.cur_stack++] = w;
+		insn_state[w] |= DISCOVERED;
+		keep_exploring = true;
+	}
+
+	return keep_exploring ? KEEP_EXPLORING : DONE_EXPLORING;
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -17925,8 +18144,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
-		if (BPF_SRC(insn->code) != BPF_K)
-			return -EINVAL;
+		if (BPF_SRC(insn->code) == BPF_X)
+			return visit_gotox_insn(t, env);
 
 		if (BPF_CLASS(insn->code) == BPF_JMP)
 			off = insn->off;
@@ -18855,6 +19074,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
 	case PTR_TO_ARENA:
 		return true;
+	case PTR_TO_INSN:
+		return (rold->off == rcur->off && range_within(rold, rcur) &&
+			tnum_in(rold->var_off, rcur->var_off));
 	default:
 		return regs_exact(rold, rcur, idmap);
 	}
@@ -19864,6 +20086,99 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	return PROCESS_BPF_EXIT;
 }
 
+static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
+				       int regno,
+				       struct bpf_map *map,
+				       u32 *pmin_index, u32 *pmax_index)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	u64 min_index, max_index;
+	const u32 size = 8;
+
+	if (check_add_overflow(reg->umin_value, reg->off, &min_index) ||
+		(min_index > (u64) U32_MAX * size)) {
+		verbose(env, "the sum of R%u umin_value %llu and off %u is too big\n",
+			     regno, reg->umin_value, reg->off);
+		return -ERANGE;
+	}
+	if (check_add_overflow(reg->umax_value, reg->off, &max_index) ||
+		(max_index > (u64) U32_MAX * size)) {
+		verbose(env, "the sum of R%u umax_value %llu and off %u is too big\n",
+			     regno, reg->umax_value, reg->off);
+		return -ERANGE;
+	}
+
+	min_index /= size;
+	max_index /= size;
+
+	if (max_index >= map->max_entries) {
+		verbose(env, "R%u points to outside of jump table: [%llu,%llu] max_entries %u\n",
+			     regno, min_index, max_index, map->max_entries);
+		return -EINVAL;
+	}
+
+	*pmin_index = min_index;
+	*pmax_index = max_index;
+	return 0;
+}
+
+/* gotox *dst_reg */
+static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	struct bpf_verifier_state *other_branch;
+	struct bpf_reg_state *dst_reg;
+	struct bpf_map *map;
+	u32 min_index, max_index;
+	int err = 0;
+	int n;
+	int i;
+
+	dst_reg = reg_state(env, insn->dst_reg);
+	if (dst_reg->type != PTR_TO_INSN) {
+		verbose(env, "R%d has type %s, expected PTR_TO_INSN\n",
+			     insn->dst_reg, reg_type_str(env, dst_reg->type));
+		return -EINVAL;
+	}
+
+	map = dst_reg->map_ptr;
+	if (verifier_bug_if(!map, env, "R%d has an empty map pointer", insn->dst_reg))
+		return -EFAULT;
+
+	if (verifier_bug_if(map->map_type != BPF_MAP_TYPE_INSN_ARRAY, env,
+			    "R%d has incorrect map type %d", insn->dst_reg, map->map_type))
+		return -EFAULT;
+
+	err = indirect_jump_min_max_index(env, insn->dst_reg, map, &min_index, &max_index);
+	if (err)
+		return err;
+
+	/* Ensure that the buffer is large enough */
+	if (!env->gotox_tmp_buf || env->gotox_tmp_buf->cnt < max_index - min_index + 1) {
+		env->gotox_tmp_buf = iarray_realloc(env->gotox_tmp_buf,
+						    max_index - min_index + 1);
+		if (!env->gotox_tmp_buf)
+			return -ENOMEM;
+	}
+
+	n = copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_buf->items);
+	if (n < 0)
+		return n;
+	if (n == 0) {
+		verbose(env, "register R%d doesn't point to any offset in map id=%d\n",
+			     insn->dst_reg, map->id);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < n - 1; i++) {
+		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
+					  env->insn_idx, env->cur_state->speculative);
+		if (IS_ERR(other_branch))
+			return PTR_ERR(other_branch);
+	}
+	env->insn_idx = env->gotox_tmp_buf->items[n-1];
+	return 0;
+}
+
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
 	int err;
@@ -19966,6 +20281,15 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			mark_reg_scratched(env, BPF_REG_0);
 		} else if (opcode == BPF_JA) {
+			if (BPF_SRC(insn->code) == BPF_X) {
+				if (insn->src_reg != BPF_REG_0 ||
+				    insn->imm != 0 || insn->off != 0) {
+					verbose(env, "BPF_JA|BPF_X uses reserved fields\n");
+					return -EINVAL;
+				}
+				return check_indirect_jump(env, insn);
+			}
+
 			if (BPF_SRC(insn->code) != BPF_K ||
 			    insn->src_reg != BPF_REG_0 ||
 			    insn->dst_reg != BPF_REG_0 ||
@@ -20482,6 +20806,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_QUEUE:
 		case BPF_MAP_TYPE_STACK:
 		case BPF_MAP_TYPE_ARENA:
+		case BPF_MAP_TYPE_INSN_ARRAY:
 			break;
 		default:
 			verbose(env,
@@ -21039,6 +21364,27 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
 	return 0;
 }
 
+/*
+ * Clean up dynamically allocated fields of aux data for instructions [start, ...]
+ */
+static void clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
+{
+	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	int end = start + len;
+	int i;
+
+	for (i = start; i < end; i++) {
+		if (insn_is_gotox(&insns[i])) {
+			kvfree(aux_data[i].jt);
+			aux_data[i].jt = NULL;
+		}
+
+		if (bpf_is_ldimm64(&insns[i]))
+			i++;
+	}
+}
+
 static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
@@ -21062,6 +21408,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 
 	adjust_insn_arrays_after_remove(env, off, cnt);
 
+	clear_insn_aux_data(env, off, cnt);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -21706,6 +22054,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->used_maps = env->used_maps;
+		func[i]->aux->used_map_cnt = env->used_map_cnt;
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
@@ -24912,12 +25262,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
+	clear_insn_aux_data(env, 0, env->prog->len);
 	vfree(env->insn_aux_data);
 err_free_env:
 	bpf_stack_liveness_free(env);
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env->succ);
+	kvfree(env->gotox_tmp_buf);
 	kvfree(env);
 	return ret;
 }
-- 
2.34.1


