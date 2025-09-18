Return-Path: <bpf+bounces-68761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B153FB83D0A
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 377217BC229
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A448243371;
	Thu, 18 Sep 2025 09:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgsQtXcu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AE52EB862
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187972; cv=none; b=HFRkqfE8hU+wA82mIKua9GxeyJSH428hmSGxnLoZ3dAJTGTqQwQQVSjuUsAUyHd8k2Caw2rF2DS8eWdj+aZpXFUGOPO+7DtlPOYRf2Q9ENvuEmfME+t84e12Wy+ukXOafIvgjZlze2kS1lXxEgX3ivjEwIz5Cb3IC2ygbu0l6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187972; c=relaxed/simple;
	bh=K6JovJbeuQphPIgdP9bbawDmvqf01czeHlk0rzo34pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rj5TDSrBP3oqBaXfKvXZFNkEAX01MLjXDJYuIG4VY/5FLt67TJLJYXd/SVVOtJW4n0DI7702iXCycKLln1I110ZZA3qC6AUjdU9YmEzASmdV9xgePO2SuTF5uoZPpZYZG7VIZqNCNLqsOsgS6fz7rsC28Q7Q+ZbernWn5JmrSuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgsQtXcu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f29e5e89bso7356565e9.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187966; x=1758792766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMhh667HDJX4zEuWZYl4DPAtfvBd23K4bXWUk9p1uJw=;
        b=UgsQtXcu0Jzl6GpvmZ9GkdPL/vigGZZGP375mkPVYvvxDQhvPv9kMifXffpObWrtr4
         1GGHKFigOhl5UuETwaT6FTqC0dmOuFwmhui9d5kPV2rOz9AYDad/+eKlGyFAzRDLIj4a
         cVER9WVQ4kYOVb8IXXgPE4YD59398oBF/CfXPNr2xm83dtSK1g58EuVZA0IFWFx9wwpo
         NkbtqShcVX+gQgZD+Hw3g8d1K4X10SYQM3JyV19Gl4PzNHIBLAirqe+ZUzULUaQtaQEE
         texOgqYTucxUE2hNRgFGW2ubkAfvkPLKDiCYHjsXm7TrkGmb46eUo5qV4JCfEhZhKpGZ
         HCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187966; x=1758792766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMhh667HDJX4zEuWZYl4DPAtfvBd23K4bXWUk9p1uJw=;
        b=oppHBphaqSuuMGoRIxRy7Y5kFcnrIAKtf2S/eigWEMqywLEr8DxpU4wOzRqBb4XFUg
         rQBGYE0rMwNtWOKPgpjxwhl1gzkcBO2IxerdwXJ4qOnEsDhA5w/sdr7tJ2zyySR7DeeN
         i+Weas5e9N+c62JlUaDkhZTAcza3xPkoNqvRcSXwy/dsjyLy1PEfVdKwbQZIhn3fv0cP
         yF7dDv6oQu3ghKVAXs+jymq2ONa7hsXkzlPmo/vdiO8sygjz90P/8xyYd9WDaalrH2ju
         +0TaqIJvgE2lZIXG+DCx2MNSxRoRWFWPrj6iKpWkr1VFTkPGcce9wzeUUm6LWwtlj9ii
         MoWw==
X-Gm-Message-State: AOJu0YzzOms7uU6m0vuF34agBEoreNKsbfgbZ0qY5tRSKrjDx9jofan0
	12/TFWMDrEKHoBVGYYEn9QfnRVOv5MX57J5lP3kdikLkchJYE6TMTk4Cipayqg==
X-Gm-Gg: ASbGncuklGViQKgxNa9HAdfEhbP2Bdr3vqn6QDZcfgRmbhKg9AUMKuGgFM/y7bX3ZRy
	1rTrd1hpX0PxN4COMGJN/DH7nkZ1h/HvekfssBlozf3ZtW5YxlN5xk6gj9GO3/zCL0IZCnU4gvz
	K7AYKxccY/iiO94DkMMQIm4PtXbX0n61ZaKEeo9dAmpzyT0G4iVUqcWEl/htnfE62JTMBK2RHpI
	KhARs+VvWzadkyKVQiusfSScXbh0DzgUKRVkpY/k60OAbdjPto0Ops/cB7CJh0aev8HNAZruZZE
	hM9onl1yzq4g0VJ/yWzXDB+qm2UntT/dHLEN/n2XPPRdtAnqajjhVGhwIj8IBxq14ILRY18tLZ4
	ALaquy8DK6RLeClwnqbFqN6lQuZsgB5m/Fy95NrSaI0HZ64211iVMuqEMYcJE
X-Google-Smtp-Source: AGHT+IG79l2URCVzhV5E3Nz2Q1p8UOibGfk9BRmdomUbReciuek89B3FIWEmG225ncYaxakbWa736Q==
X-Received: by 2002:a05:600c:198c:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-46206b20089mr43267085e9.29.1758187965599;
        Thu, 18 Sep 2025 02:32:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:45 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 08/13] bpf, x86: add support for indirect jumps
Date: Thu, 18 Sep 2025 09:38:45 +0000
Message-Id: <20250918093850.455051-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
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
 include/linux/bpf_verifier.h |  15 +
 kernel/bpf/bpf_insn_array.c  |  16 +-
 kernel/bpf/core.c            |   1 +
 kernel/bpf/log.c             |   1 +
 kernel/bpf/verifier.c        | 513 ++++++++++++++++++++++++++++++++---
 7 files changed, 514 insertions(+), 36 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index fcebb48742ae..095d249eb235 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2595,6 +2595,9 @@ st:			if (is_imm8(insn->off))
 
 			break;
 
+		case BPF_JMP | BPF_JA | BPF_X:
+			emit_indirect_jump(&prog, insn->dst_reg, image + addrs[i - 1]);
+			break;
 		case BPF_JMP | BPF_JA:
 		case BPF_JMP32 | BPF_JA:
 			if (BPF_CLASS(insn->code) == BPF_JMP) {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ee3967f2a025..be6019bf6a57 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -973,6 +973,7 @@ enum bpf_reg_type {
 	PTR_TO_ARENA,
 	PTR_TO_BUF,		 /* reg points to a read/write buffer */
 	PTR_TO_FUNC,		 /* reg points to a bpf program function */
+	PTR_TO_INSN,		 /* reg points to a bpf program instruction */
 	CONST_PTR_TO_DYNPTR,	 /* reg points to a const struct bpf_dynptr */
 	__BPF_REG_TYPE_MAX,
 
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index aca43c284203..607a684642e5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -533,6 +533,16 @@ struct bpf_map_ptr_state {
 #define BPF_ALU_SANITIZE		(BPF_ALU_SANITIZE_SRC | \
 					 BPF_ALU_SANITIZE_DST)
 
+/*
+ * A structure defining an array of BPF instructions.  Can be used,
+ * for example, as a return value of the insn_successors() function
+ * and in the struct bpf_insn_aux_data below.
+ */
+struct bpf_iarray {
+	int off_cnt;
+	u32 off[];
+};
+
 struct bpf_insn_aux_data {
 	union {
 		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
@@ -542,6 +552,7 @@ struct bpf_insn_aux_data {
 		struct {
 			u32 map_index;		/* index into used_maps[] */
 			u32 map_off;		/* offset from value base address */
+			struct bpf_iarray *jt;	/* jump table for gotox instruction */
 		};
 		struct {
 			enum bpf_reg_type reg_type;	/* type of pseudo_btf_id */
@@ -586,6 +597,9 @@ struct bpf_insn_aux_data {
 	u8 fastcall_spills_num:3;
 	u8 arg_prog:4;
 
+	/* true if jt->off was allocated */
+	bool jt_allocated;
+
 	/* below fields are initialized once */
 	unsigned int orig_idx; /* original instruction index */
 	bool jmp_point;
@@ -847,6 +861,7 @@ struct bpf_verifier_env {
 	/* array of pointers to bpf_scc_info indexed by SCC id */
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
+	struct bpf_iarray *succ;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
index 0c8dac62f457..4b945b7e31b8 100644
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
+	*imm = (unsigned long)insn_array->ips + off;
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
index 90f201a6f51d..1f933857ca1d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1709,6 +1709,7 @@ bool bpf_opcode_in_insntable(u8 code)
 		[BPF_LD | BPF_IND | BPF_B] = true,
 		[BPF_LD | BPF_IND | BPF_H] = true,
 		[BPF_LD | BPF_IND | BPF_W] = true,
+		[BPF_JMP | BPF_JA | BPF_X] = true,
 		[BPF_JMP | BPF_JCOND] = true,
 	};
 #undef BPF_INSN_3_TBL
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index e4983c1303e7..75adfe7914f2 100644
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
index 5c1e4e37d1f8..839260e62fa9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -212,6 +212,7 @@ static int ref_set_non_owning(struct bpf_verifier_env *env,
 static void specialize_kfunc(struct bpf_verifier_env *env,
 			     u32 func_id, u16 offset, unsigned long *addr);
 static bool is_trusted_reg(const struct bpf_reg_state *reg);
+static int add_used_map(struct bpf_verifier_env *env, int fd);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
 {
@@ -2977,14 +2978,13 @@ static int cmp_subprogs(const void *a, const void *b)
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
@@ -2995,7 +2995,19 @@ static struct bpf_subprog_info *find_containing_subprog(struct bpf_verifier_env
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
@@ -6092,6 +6104,18 @@ static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
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
@@ -6101,11 +6125,11 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
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
 
@@ -7620,6 +7644,19 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 				regs[value_regno].type = SCALAR_VALUE;
 				__mark_reg_known(&regs[value_regno], val);
+			} else if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
+				regs[value_regno].type = PTR_TO_INSN;
+				regs[value_regno].map_ptr = map;
+				regs[value_regno].off = reg->off;
+				regs[value_regno].umin_value = reg->umin_value;
+				regs[value_regno].umax_value = reg->umax_value;
+				regs[value_regno].smin_value = reg->smin_value;
+				regs[value_regno].smax_value = reg->smax_value;
+				regs[value_regno].s32_min_value = reg->s32_min_value;
+				regs[value_regno].s32_max_value = reg->s32_max_value;
+				regs[value_regno].u32_min_value = reg->u32_min_value;
+				regs[value_regno].u32_max_value = reg->u32_max_value;
+				regs[value_regno].var_off = reg->var_off;
 			} else {
 				mark_reg_unknown(env, regs, value_regno);
 			}
@@ -7810,6 +7847,11 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
@@ -14487,6 +14529,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg;
 	bool known = tnum_is_const(off_reg->var_off);
+	bool ptr_to_insn_array = base_type(ptr_reg->type) == PTR_TO_MAP_VALUE &&
+				 map_is_insn_array(ptr_reg->map_ptr);
 	s64 smin_val = off_reg->smin_value, smax_val = off_reg->smax_value,
 	    smin_ptr = ptr_reg->smin_value, smax_ptr = ptr_reg->smax_value;
 	u64 umin_val = off_reg->umin_value, umax_val = off_reg->umax_value,
@@ -14628,6 +14672,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
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
@@ -16980,7 +17029,8 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		}
 		dst_reg->type = PTR_TO_MAP_VALUE;
 		dst_reg->off = aux->map_off;
-		WARN_ON_ONCE(map->max_entries != 1);
+		WARN_ON_ONCE(map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
+			     map->max_entries != 1);
 		/* We want reg->id to be same (0) as map_value is not distinct */
 	} else if (insn->src_reg == BPF_PSEUDO_MAP_FD ||
 		   insn->src_reg == BPF_PSEUDO_MAP_IDX) {
@@ -17733,6 +17783,234 @@ static int mark_fastcall_patterns(struct bpf_verifier_env *env)
 	return 0;
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
+static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
+{
+	size_t new_size = sizeof(struct bpf_iarray) + n_elem * 4;
+	struct bpf_iarray *new;
+
+	new = kvrealloc(old, new_size, GFP_KERNEL_ACCOUNT);
+	if (!new) {
+		/* this is what callers always want, so simplify the call site */
+		kvfree(old);
+		return NULL;
+	}
+
+	new->off_cnt = n_elem;
+	return new;
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
+	subprog_idx = find_containing_subprog_idx(env, t);
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
+	struct bpf_iarray *jt = env->insn_aux_data[t].jt;
+
+	if (!jt) {
+		jt = create_jt(t, env, fd);
+		if (IS_ERR(jt))
+			return PTR_ERR(jt);
+	}
+
+	/*
+	 * Mark jt as allocated. Otherwise, this is not possible to check if it
+	 * was allocated or not in the code which frees memory (jt is a part of
+	 * union)
+	 */
+	env->insn_aux_data[t].jt_allocated = true;
+	env->insn_aux_data[t].jt = jt;
+
+	return push_gotox_edge(t, env, jt);
+}
+
 /* Visits the instruction at index t and returns one of the following:
  *  < 0 - an error occurred
  *  DONE_EXPLORING - the instruction was fully explored
@@ -17823,8 +18101,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
 	case BPF_JA:
-		if (BPF_SRC(insn->code) != BPF_K)
-			return -EINVAL;
+		if (BPF_SRC(insn->code) == BPF_X)
+			return visit_gotox_insn(t, env, insn->imm);
 
 		if (BPF_CLASS(insn->code) == BPF_JMP)
 			off = insn->off;
@@ -17855,6 +18133,13 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
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
@@ -18716,6 +19001,10 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		return regs_exact(rold, rcur, idmap) && rold->frameno == rcur->frameno;
 	case PTR_TO_ARENA:
 		return true;
+	case PTR_TO_INSN:
+		/* is rcur a subset of rold? */
+		return (rcur->umin_value >= rold->umin_value &&
+			rcur->umax_value <= rold->umax_value);
 	default:
 		return regs_exact(rold, rcur, idmap);
 	}
@@ -19862,6 +20151,102 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
 	return PROCESS_BPF_EXIT;
 }
 
+static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
+				       int regno,
+				       struct bpf_map *map,
+				       u32 *pmin_index, u32 *pmax_index)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
+	u64 min_index, max_index;
+
+	if (check_add_overflow(reg->umin_value, reg->off, &min_index) ||
+		(min_index > (u64) U32_MAX * sizeof(long))) {
+		verbose(env, "the sum of R%u umin_value %llu and off %u is too big\n",
+			     regno, reg->umin_value, reg->off);
+		return -ERANGE;
+	}
+	if (check_add_overflow(reg->umax_value, reg->off, &max_index) ||
+		(max_index > (u64) U32_MAX * sizeof(long))) {
+		verbose(env, "the sum of R%u umax_value %llu and off %u is too big\n",
+			     regno, reg->umax_value, reg->off);
+		return -ERANGE;
+	}
+
+	min_index /= sizeof(long);
+	max_index /= sizeof(long);
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
+	int err = 0;
+	u32 *xoff;
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
+	xoff = kvcalloc(max_index - min_index + 1, sizeof(u32), GFP_KERNEL_ACCOUNT);
+	if (!xoff)
+		return -ENOMEM;
+
+	n = copy_insn_array_uniq(map, min_index, max_index, xoff);
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
@@ -19964,6 +20349,9 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 
 			mark_reg_scratched(env, BPF_REG_0);
 		} else if (opcode == BPF_JA) {
+			if (BPF_SRC(insn->code) == BPF_X)
+				return check_indirect_jump(env, insn);
+
 			if (BPF_SRC(insn->code) != BPF_K ||
 			    insn->src_reg != BPF_REG_0 ||
 			    insn->dst_reg != BPF_REG_0 ||
@@ -20463,6 +20851,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_QUEUE:
 		case BPF_MAP_TYPE_STACK:
 		case BPF_MAP_TYPE_ARENA:
+		case BPF_MAP_TYPE_INSN_ARRAY:
 			break;
 		default:
 			verbose(env,
@@ -21020,6 +21409,23 @@ static int bpf_adj_linfo_after_remove(struct bpf_verifier_env *env, u32 off,
 	return 0;
 }
 
+/*
+ * Clean up dynamically allocated fields of aux data for instructions [start, ...]
+ */
+static void clear_insn_aux_data(struct bpf_insn_aux_data *aux_data, int start, int len)
+{
+	int end = start + len;
+	int i;
+
+	for (i = start; i < end; i++) {
+		if (aux_data[i].jt_allocated) {
+			kvfree(aux_data[i].jt);
+			aux_data[i].jt = NULL;
+			aux_data[i].jt_allocated = false;
+		}
+	}
+}
+
 static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 {
 	struct bpf_insn_aux_data *aux_data = env->insn_aux_data;
@@ -21043,6 +21449,8 @@ static int verifier_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt)
 
 	adjust_insn_arrays_after_remove(env, off, cnt);
 
+	clear_insn_aux_data(aux_data, off, cnt);
+
 	memmove(aux_data + off,	aux_data + off + cnt,
 		sizeof(*aux_data) * (orig_prog_len - off - cnt));
 
@@ -21683,6 +22091,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 		func[i]->aux->jited_linfo = prog->aux->jited_linfo;
 		func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
 		func[i]->aux->arena = prog->aux->arena;
+		func[i]->aux->used_maps = env->used_maps;
+		func[i]->aux->used_map_cnt = env->used_map_cnt;
 		num_exentries = 0;
 		insn = func[i]->insnsi;
 		for (j = 0; j < func[i]->len; j++, insn++) {
@@ -24215,23 +24625,41 @@ static bool can_jump(struct bpf_insn *insn)
 	return false;
 }
 
-static int insn_successors(struct bpf_prog *prog, u32 idx, u32 succ[2])
+/*
+ * Returns an array of instructions succ, with succ->off[0], ...,
+ * succ->off[n-1] with successor instructions, where n=succ->off_cnt
+ */
+static struct bpf_iarray *
+insn_successors(struct bpf_verifier_env *env, u32 insn_idx)
 {
-	struct bpf_insn *insn = &prog->insnsi[idx];
-	int i = 0, insn_sz;
+	struct bpf_prog *prog = env->prog;
+	struct bpf_insn *insn = &prog->insnsi[insn_idx];
+	struct bpf_iarray *succ;
+	int insn_sz;
 	u32 dst;
 
-	insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
-	if (can_fallthrough(insn) && idx + 1 < prog->len)
-		succ[i++] = idx + insn_sz;
+	if (unlikely(insn_is_gotox(insn))) {
+		succ = env->insn_aux_data[insn_idx].jt;
+		if (verifier_bug_if(!succ, env,
+				    "aux data for insn %u doesn't contain a jump table\n",
+				    insn_idx))
+			return ERR_PTR(-EFAULT);
+	} else {
+		/* pre-allocated array of size up to 2; reset cnt, as it may be used already */
+		succ = env->succ;
+		succ->off_cnt = 0;
 
-	if (can_jump(insn)) {
-		dst = idx + jmp_offset(insn) + 1;
-		if (i == 0 || succ[0] != dst)
-			succ[i++] = dst;
-	}
+		insn_sz = bpf_is_ldimm64(insn) ? 2 : 1;
+		if (can_fallthrough(insn) && insn_idx + 1 < prog->len)
+			succ->off[succ->off_cnt++] = insn_idx + insn_sz;
 
-	return i;
+		if (can_jump(insn)) {
+			dst = insn_idx + jmp_offset(insn) + 1;
+			if (succ->off_cnt == 0 || succ->off[0] != dst)
+				succ->off[succ->off_cnt++] = dst;
+		}
+	}
+	return succ;
 }
 
 /* Each field is a register bitmask */
@@ -24426,14 +24854,18 @@ static int compute_live_registers(struct bpf_verifier_env *env)
 		for (i = 0; i < env->cfg.cur_postorder; ++i) {
 			int insn_idx = env->cfg.insn_postorder[i];
 			struct insn_live_regs *live = &state[insn_idx];
-			int succ_num;
-			u32 succ[2];
+			struct bpf_iarray *succ;
 			u16 new_out = 0;
 			u16 new_in = 0;
 
-			succ_num = insn_successors(env->prog, insn_idx, succ);
-			for (int s = 0; s < succ_num; ++s)
-				new_out |= state[succ[s]].in;
+			succ = insn_successors(env, insn_idx);
+			if (IS_ERR(succ)) {
+				err = PTR_ERR(succ);
+				goto out;
+
+			}
+			for (int s = 0; s < succ->off_cnt; ++s)
+				new_out |= state[succ->off[s]].in;
 			new_in = (new_out & ~live->def) | live->use;
 			if (new_out != live->out || new_in != live->in) {
 				live->in = new_in;
@@ -24489,11 +24921,10 @@ static int compute_scc(struct bpf_verifier_env *env)
 	const u32 insn_cnt = env->prog->len;
 	int stack_sz, dfs_sz, err = 0;
 	u32 *stack, *pre, *low, *dfs;
-	u32 succ_cnt, i, j, t, w;
+	u32 i, j, t, w;
 	u32 next_preorder_num;
 	u32 next_scc_id;
 	bool assign_scc;
-	u32 succ[2];
 
 	next_preorder_num = 1;
 	next_scc_id = 1;
@@ -24592,6 +25023,8 @@ static int compute_scc(struct bpf_verifier_env *env)
 		dfs[0] = i;
 dfs_continue:
 		while (dfs_sz) {
+			struct bpf_iarray *succ;
+
 			w = dfs[dfs_sz - 1];
 			if (pre[w] == 0) {
 				low[w] = next_preorder_num;
@@ -24600,12 +25033,17 @@ static int compute_scc(struct bpf_verifier_env *env)
 				stack[stack_sz++] = w;
 			}
 			/* Visit 'w' successors */
-			succ_cnt = insn_successors(env->prog, w, succ);
-			for (j = 0; j < succ_cnt; ++j) {
-				if (pre[succ[j]]) {
-					low[w] = min(low[w], low[succ[j]]);
+			succ = insn_successors(env, w);
+			if (IS_ERR(succ)) {
+				err = PTR_ERR(succ);
+				goto exit;
+
+			}
+			for (j = 0; j < succ->off_cnt; ++j) {
+				if (pre[succ->off[j]]) {
+					low[w] = min(low[w], low[succ->off[j]]);
 				} else {
-					dfs[dfs_sz++] = succ[j];
+					dfs[dfs_sz++] = succ->off[j];
 					goto dfs_continue;
 				}
 			}
@@ -24622,8 +25060,8 @@ static int compute_scc(struct bpf_verifier_env *env)
 			 * or if component has a self reference.
 			 */
 			assign_scc = stack[stack_sz - 1] != w;
-			for (j = 0; j < succ_cnt; ++j) {
-				if (succ[j] == w) {
+			for (j = 0; j < succ->off_cnt; ++j) {
+				if (succ->off[j] == w) {
 					assign_scc = true;
 					break;
 				}
@@ -24683,6 +25121,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	ret = -ENOMEM;
 	if (!env->insn_aux_data)
 		goto err_free_env;
+	env->succ = iarray_realloc(NULL, 2);
+	if (!env->succ)
+		goto err_free_env;
 	for (i = 0; i < len; i++)
 		env->insn_aux_data[i].orig_idx = i;
 	env->prog = *prog;
@@ -24922,10 +25363,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 err_unlock:
 	if (!is_priv)
 		mutex_unlock(&bpf_verifier_lock);
+	clear_insn_aux_data(env->insn_aux_data, 0, env->prog->len);
 	vfree(env->insn_aux_data);
 err_free_env:
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
+	kvfree(env->succ);
 	kvfree(env);
 	return ret;
 }
-- 
2.34.1


