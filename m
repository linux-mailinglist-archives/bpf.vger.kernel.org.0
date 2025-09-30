Return-Path: <bpf+bounces-70039-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC087BACE9E
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357B81893D99
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265F302159;
	Tue, 30 Sep 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve++/XVF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB53019A1
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236352; cv=none; b=j0XLWyULAEQoqbOoWo6PjQvqTxBdclYYK8F0toxZ9staMt3wCIhR9hN/V/H62TOl4CTh7MkFbBJv/nuIwC4IcF2jVXuyrIV/vt7KVkRksU7aisAtjgB3vhaQc4oei5FODFZ/scMMQ9rLniZjJukZ77NcExHn82Am163zshtbHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236352; c=relaxed/simple;
	bh=o+cEGNVk8EjStUPJMLa/7XUEDqZ/2OAoXELZ3pM7d+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVrvfm2xjZJsLiEbUxfQjZR03BMeJfBHMXpf2FEgkI+Bcxf2c/bii6lGLAesrxldCKDp70Nd5+PAmDs0mN/FsTp9pbDmzdUnSA+xbsjS9lMnbGo0tdMNyv/tVjvmlLjlM7jk1MvNWD0ot7o7ldtBimvUDvVbJj96lMQlEICYlTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ve++/XVF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3950076f8f.0
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236346; x=1759841146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pw3zAmE+Lyt24MDrBu3uaHPCmWMa1xMU5TaA+3SaDzk=;
        b=Ve++/XVFmWqtSA73YLVIDcDVZmf0qsBWELocXNBlyJf2oO1jvY+mXmMoW+me66HO8K
         Iixe5JZlbb+UDeSxMYHimNkjiC0vsSewFc6EUfTYJMqmj57BQhrk4Hp7PjfZv43DtOjz
         ooNXCCiT80h3Vlb89UCVuROIePqy+sVaaziz3GbUMHTV0wIrD8fyXgp4ovtIYG/3LnYs
         42Ip/cE1ViL0E1t6bBoGo16tAFjTcAf4cnEkQDePSKiK1tyY4drBlfqck7aD5ld/nUYB
         Jcq0+cFvUk3EYxKTm9HXJujiNo+1nlBNe5I9Eah0UIHJ3itP8FOeTEWJXgcEpQITiEWU
         4jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236346; x=1759841146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pw3zAmE+Lyt24MDrBu3uaHPCmWMa1xMU5TaA+3SaDzk=;
        b=NqMpi5EDRooh8C12Iw7HRyqIn0gV+9QyuWbsG0e9gXL6XJSgVdyXs72ucsbzAEbtFq
         8s5XAXvhWC/oMWZ9vKMm+s5wW9ZYfpHX9PwGQniOyKle08+pPSXY1KDvBxJDnxJXXLoI
         Z88ge9chMzrjW0oRDb7AYGJzci9mWpWzsXmz8pOtJgD8m8csG5YPC4gz0lYaiigP9oBP
         mKqmG1UQxilVO+qpdDpt6tMDbi18rVxF3qUsaAcSRJcjAtR91j5Zpg1V6i326/ySkk0O
         5+rFyiEPVQa/rX3ayhBBSC8wY+lWGEO7C9vbWV0UjexokEq9cN/QTE8UR/e5i8PprTAp
         m7eg==
X-Gm-Message-State: AOJu0YybcQymiOyE8D6L6+6YuzX7GSKeq+7JMnq3ZvEy6a9L9X+IpjOZ
	Q2+MLfoLa5ysfylO5w/e++z8Zv6sBkYUc9eOQpp6Md7qi4C0tHUSUuGtu9HN9A==
X-Gm-Gg: ASbGnct+we0UXyaJamfgdIASwDgIBE2lkYAk/IXL8YNGHGw0qgq+fkbH8s3q5ARveAm
	jVBWK1rVSGG/9YQl/LVzmsP8smocuhmNI58m7wFKo5o2gR6iLAQaNf3iMPLVMyjWpCtVWM/j0iF
	YNM9+V+252ukGjmLFT3ugj2qxGC2sRFw0ArpdJQlv0EGeXS7m5sEnBn9oVlGwHbOQJe79vxO0Sk
	ziiY3F/PvTLT9/OUmnlfpxUazDlSCdLeexNwewheOpss7uVjTFzESkeoJH08SqMIZDPoC9cKL8O
	Rn2emG4XcYqsqxsgG9XH4miL4OsAqBIHUbJWiMjvrSPHx6EF1+EQSqxJB/yqTk6FgM5wPDnUvZ/
	5hLlAOduiIeFhId1HDWyknest1I26+nVeyHqc8HpZ5Ug+gl6wOOyEB689CIlTuZMz5Q==
X-Google-Smtp-Source: AGHT+IF1UPgyu/leaBpOnLZIC/cu0OYiql/TRo5zxW+nSD6NqejRylUAUyTw2RkCQpzQJY7JXfIKaA==
X-Received: by 2002:a05:6000:4210:b0:3e4:5717:368e with SMTP id ffacd0b85a97d-40e498b7705mr18862489f8f.2.1759236346145;
        Tue, 30 Sep 2025 05:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:45 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 10/15] bpf, x86: add support for indirect jumps
Date: Tue, 30 Sep 2025 12:51:06 +0000
Message-Id: <20250930125111.1269861-11-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
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
---
 arch/x86/net/bpf_jit_comp.c  |   3 +
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |  13 ++
 kernel/bpf/bpf_insn_array.c  |  15 ++
 kernel/bpf/core.c            |   1 +
 kernel/bpf/liveness.c        |   3 +
 kernel/bpf/log.c             |   1 +
 kernel/bpf/verifier.c        | 413 +++++++++++++++++++++++++++++++++--
 8 files changed, 431 insertions(+), 19 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f79ac77e5a39..53feed4889f1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2629,6 +2629,9 @@ st:			if (is_imm8(insn->off))
 
 			break;
 
+		case BPF_JMP | BPF_JA | BPF_X:
+			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
+			break;
 		case BPF_JMP | BPF_JA:
 		case BPF_JMP32 | BPF_JA:
 			if (BPF_CLASS(insn->code) == BPF_JMP) {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f878d94593e3..132f1cb3b0a4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -988,6 +988,7 @@ enum bpf_reg_type {
 	PTR_TO_ARENA,
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
+	PTR_TO_INSN,		 /* reg points to a bpf program instruction */
 	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
 	__BPF_REG_TYPE_MAX,
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 19d579f1f829..52e8dc652260 100644
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
@@ -571,6 +572,9 @@ struct bpf_insn_aux_data {
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
 
+	/* true if jt->off was allocated */
+	bool jt_allocated;
+
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
 	bool jmp_point;
@@ -840,6 +844,8 @@ struct bpf_verifier_env {
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
+	u32 *gotox_tmp_buf;
+	size_t gotox_tmp_buf_size;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
@@ -1050,6 +1056,13 @@ static inline bool bpf_stack_narrow_access_ok(int off, int fill_size, int spill_
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
index ac0243b78169..e771bc433351 100644
--- a/kernel/bpf/bpf_insn_array.c
+++ b/kernel/bpf/bpf_insn_array.c
@@ -126,6 +126,20 @@ static u64 insn_array_mem_usage(const struct bpf_map *map)
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
+	*imm = (unsigned long)insn_array->ips + off;
+
+	return 0;
+}
+
 BTF_ID_LIST_SINGLE(insn_array_btf_ids, struct, bpf_insn_array)
 
 const struct bpf_map_ops insn_array_map_ops = {
@@ -138,6 +152,7 @@ const struct bpf_map_ops insn_array_map_ops = {
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
index 9312cd6b24d3..b8edc5b45290 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -483,6 +483,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32 idx)
 	struct bpf_iarray *succ;
 	int insn_sz;
 
+	if (unlikely(insn_is_gotox(insn)))
+		return env->insn_aux_data[idx].jt;
+
 	/* pre-allocated array of size up to 2; reset cnt, as it may have been used already */
 	succ = env->succ;
 	succ->off_cnt = 0;
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index f50533169cc3..3fb56617af36 100644
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
index 6c742d2f4c04..aebd01029d6d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2948,14 +2948,13 @@ static int cmp_subprogs(const void *a, const void *b)
 	       ((struct bpf_subprog_info *)b)->start;
 }
 
-/* Find subprogram that contains instruction at 'off' */
-struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off)
+static int bpf_find_containing_subprog_idx(struct bpf_verifier_env *env, int off)
 {
 	struct bpf_subprog_info *vals = env->subprog_info;
 	int l, r, m;
 
 	if (off >= env->prog->len || off < 0 || env->subprog_cnt == 0)
-		return NULL;
+		return -1;
 
 	l = 0;
 	r = env->subprog_cnt - 1;
@@ -2966,7 +2965,19 @@ struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *en
 		else
 			r = m - 1;
 	}
-	return &vals[l];
+	return l;
+}
+
+/* Find subprogram that contains instruction at 'off' */
+struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off)
+{
+	int subprog_idx;
+
+	subprog_idx = bpf_find_containing_subprog_idx(env, off);
+	if (subprog_idx < 0)
+		return NULL;
+
+	return &env->subprog_info[subprog_idx];
 }
 
 /* Find subprogram that starts exactly at 'off' */
@@ -5988,6 +5999,18 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
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
@@ -5997,11 +6020,11 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
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
 
@@ -7516,6 +7539,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
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
@@ -7706,6 +7737,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
@@ -14529,6 +14565,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg;
 	bool known = tnum_is_const(off_reg->var_off);
+	bool ptr_to_insn_array = base_type(ptr_reg->type) == PTR_TO_MAP_VALUE &&
+				 map_is_insn_array(ptr_reg->map_ptr);
 	s64 smin_val = off_reg->smin_value, smax_val = off_reg->smax_value,
 	    smin_ptr = ptr_reg->smin_value, smax_ptr = ptr_reg->smax_value;
 	u64 umin_val = off_reg->umin_value, umax_val = off_reg->umax_value,
@@ -14685,6 +14723,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				dst);
 			return -EACCES;
 		}
+		if (ptr_to_insn_array) {
+			verbose(env, "R%d subtraction from pointer to instruction prohibited\n",
+				dst);
+			return -EACCES;
+		}
 		if (known && (ptr_reg->off - smin_val ==
 			      (s64)(s32)(ptr_reg->off - smin_val))) {
 			/* pointer -= K.  Subtract it from fixed offset */
@@ -17018,7 +17061,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		WARN_ON_ONCE(map->max_entries != 1);
+		WARN_ON_ONCE(map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
+			     map->max_entries != 1);
 		/* We want reg->id to be same (0) as map_value is not distinct */
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
@@ -17786,6 +17830,210 @@ static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
 	return new;
 }
 
+#define SET_HIGH(STATE, LAST)	STATE = (STATE & 0xffffU) | ((LAST) << 16)
+#define GET_HIGH(STATE)		((u16)((STATE) >> 16))
+
+static int push_gotox_edge(int t, struct bpf_verifier_env *env, struct bpf_iarray *jt)
+{
+	int *insn_stack = env->cfg.insn_stack;
+	int *insn_state = env->cfg.insn_state;
+	u16 prev;
+	int w;
+
+	for (prev = GET_HIGH(insn_state[t]); prev < jt->off_cnt; prev++) {
+		w = jt->off[prev];
+		mark_jmp_point(env, w);
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
+	if (env->cfg.cur_stack >= env->prog->len)
+		return -E2BIG;
+	insn_stack[env->cfg.cur_stack++] = w;
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
+static struct bpf_iarray *jt_from_map(struct bpf_map *map)
+{
+	struct bpf_iarray *jt;
+	int n;
+
+	jt = iarray_realloc(NULL, map->max_entries);
+	if (!jt)
+		return ERR_PTR(-ENOMEM);
+
+	n = copy_insn_array_uniq(map, 0, map->max_entries - 1, jt->off);
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
+ * combined jump table in jt->off (allocated with kvcalloc
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
+		if (jt_cur->off[0] >= subprog_start && jt_cur->off[0] < subprog_end) {
+			u32 old_cnt = jt ? jt->off_cnt : 0;
+			jt = iarray_realloc(jt, old_cnt + jt_cur->off_cnt);
+			if (!jt) {
+				kvfree(jt_cur);
+				return ERR_PTR(-ENOMEM);
+			}
+			memcpy(jt->off + old_cnt, jt_cur->off, jt_cur->off_cnt << 2);
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
+	jt->off_cnt = sort_insn_array_uniq(jt->off, jt->off_cnt);
+	return jt;
+}
+
+static struct bpf_iarray *
+create_jt(int t, struct bpf_verifier_env *env, int fd)
+{
+	static struct bpf_subprog_info *subprog;
+	int subprog_idx, subprog_start, subprog_end;
+	struct bpf_iarray *jt;
+	int i;
+
+	if (env->subprog_cnt == 0)
+		return ERR_PTR(-EFAULT);
+
+	subprog_idx = bpf_find_containing_subprog_idx(env, t);
+	if (subprog_idx < 0) {
+		verbose(env, "can't find subprog containing instruction %d\n", t);
+		return ERR_PTR(-EFAULT);
+	}
+	subprog = &env->subprog_info[subprog_idx];
+	subprog_start = subprog->start;
+	subprog_end = (subprog + 1)->start;
+	jt = jt_from_subprog(env, subprog_start, subprog_end);
+	if (IS_ERR(jt))
+		return jt;
+
+	/* Check that the every element of the jump table fits within the given subprogram */
+	for (i = 0; i < jt->off_cnt; i++) {
+		if (jt->off[i] < subprog_start || jt->off[i] >= subprog_end) {
+			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]",
+					t, subprog_start, subprog_end);
+			return ERR_PTR(-EINVAL);
+		}
+	}
+
+	return jt;
+}
+
+/* "conditional jump with N edges" */
+static int visit_gotox_insn(int t, struct bpf_verifier_env *env, int fd)
+{
+	struct bpf_iarray *jt;
+
+	jt = env->insn_aux_data[t].jt;
+	if (!jt) {
+		jt = create_jt(t, env, fd);
+		if (IS_ERR(jt))
+			return PTR_ERR(jt);
+	}
+	env->insn_aux_data[t].jt = jt;
+
+	mark_prune_point(env, t);
+	return push_gotox_edge(t, env, jt);
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -17878,8 +18126,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
-		if (BPF_SRC(insn->code) != BPF_K)
-			return -EINVAL;
+		if (BPF_SRC(insn->code) == BPF_X)
+			return visit_gotox_insn(t, env, insn->imm);
 
 		if (BPF_CLASS(insn->code) == BPF_JMP)
 			off = insn->off;
@@ -18808,6 +19056,9 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
 	case PTR_TO_ARENA:
 		return true;
+	case PTR_TO_INSN:
+		return (rold->off == rcur->off && range_within(rold, rcur) &&
+			tnum_in(rold->var_off, rcur->var_off));
 	default:
 		return regs_exact(rold, rcur, idmap);
 	}
@@ -19817,6 +20068,103 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
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
+	if (min_index >= map->max_entries || max_index >= map->max_entries) {
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
+	size_t new_size;
+	u32 *new_buf;
+	int err = 0;
+	int n;
+	int i;
+
+	dst_reg = reg_state(env, insn->dst_reg);
+	if (dst_reg->type != PTR_TO_INSN) {
+		verbose(env, "R%d has type %d, expected PTR_TO_INSN\n",
+			     insn->dst_reg, dst_reg->type);
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
+	new_size = sizeof(u32) * (max_index - min_index + 1);
+	if (env->gotox_tmp_buf_size < new_size) {
+		new_buf = kvrealloc(env->gotox_tmp_buf, new_size, GFP_KERNEL_ACCOUNT);
+		if (!new_buf)
+			return -ENOMEM;
+		env->gotox_tmp_buf = new_buf;
+		env->gotox_tmp_buf_size = new_size;
+	}
+
+	n = copy_insn_array_uniq(map, min_index, max_index, env->gotox_tmp_buf);
+	if (n < 0)
+		return n;
+	if (n == 0) {
+		verbose(env, "register R%d doesn't point to any offset in map id=%d\n",
+			     insn->dst_reg, map->id);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < n - 1; i++) {
+		other_branch = push_stack(env, env->gotox_tmp_buf[i],
+					  env->insn_idx, env->cur_state->speculative);
+		if (IS_ERR(other_branch))
+			return PTR_ERR(other_branch);
+	}
+	env->insn_idx = env->gotox_tmp_buf[n-1];
+	return 0;
+}
+
 static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 {
 	int err;
@@ -19919,6 +20267,15 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
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
@@ -20435,6 +20792,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_QUEUE:
 		case BPF_MAP_TYPE_STACK:
 		case BPF_MAP_TYPE_ARENA:
+		case BPF_MAP_TYPE_INSN_ARRAY:
 			break;
 		default:
 			verbose(env,
@@ -20992,6 +21350,27 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
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
@@ -21015,6 +21394,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 
 	adjust_insn_arrays_after_remove(env, off, cnt);
 
+	clear_insn_aux_data(env, off, cnt);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -21659,6 +22040,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->used_maps = env->used_maps;
+		func[i]->aux->used_map_cnt = env->used_map_cnt;
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
@@ -24347,11 +24730,6 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 			u16 new_in = 0;
 
 			succ = bpf_insn_successors(env, insn_idx);
-			if (IS_ERR(succ)) {
-				err = PTR_ERR(succ);
-				goto out;
-
-			}
 			for (int s = 0; s < succ->off_cnt; ++s)
 				new_out |= state[succ->off[s]].in;
 			new_in = (new_out & ~live->def) | live->use;
@@ -24518,11 +24896,6 @@ static int compute_scc(struct bpf_verifier_env *env)
 			}
 			/* Visit 'w' successors */
 			succ = bpf_insn_successors(env, w);
-			if (IS_ERR(succ)) {
-				err = PTR_ERR(succ);
-				goto exit;
-
-			}
 			for (j = 0; j < succ->off_cnt; ++j) {
 				if (pre[succ->off[j]]) {
 					low[w] = min(low[w], low[succ->off[j]]);
@@ -24855,12 +25228,14 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
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


