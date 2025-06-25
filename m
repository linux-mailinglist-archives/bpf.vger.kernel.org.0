Return-Path: <bpf+bounces-61564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CAAAE8C51
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9A33A9F69
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3132DA775;
	Wed, 25 Jun 2025 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPSeCjdD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422B2DAFA6
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875871; cv=none; b=IB1s/kB6LI1iQzTJ0/azASBnSTGepsaog2uv03lBIQwFNZx6VnatOEIRUWckE2bVSaKztNrNQf1NaBB3v1Oqe+SqYoULgrmiR2QMOopmHwNmvG7dudqinIlBT7nqENbXATTbk21q1ZhITdlKtmLdvc7nsaXJMeVbZx5GE0jior4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875871; c=relaxed/simple;
	bh=cxZOI+ORwPpVcBmTSTv3WX7wgxXMnBsBVJLD8gPPNPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pViOet0Zd70cxJxBzsVcGK5kq8WQYhtZ2wbNhWslyTW6Wt98RLbUef0xtRehJKNdcbfLgMLimqiP1cq6dhf8q/DrvRdrDh/KDjaSRenReCuDsFbozpFoyAY7xlCrcWidBaj2KKHePiFKMCRRsSCANdwlJCRO8Csb9yvotmQKhvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPSeCjdD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74264d1832eso397090b3a.0
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750875869; x=1751480669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFOhh2OYzhDwJNd3NFmvsqGbVMf7JWImQym8u3yFy3w=;
        b=jPSeCjdDQQ5qPCK44FYYbBDoxa5ZC5Rzxr2xz5Ias907p7WoliIf18j29KGek6yf5g
         5Fm/DmpbR+lIGrP4nYCC3Rw8k4LMVSXVhy8Rmrg1CTSiCfqZFYfrg8vgIkzSztqdx7tv
         na+xEHRI8G8pfUareESOZkI80M9d3qSYuK6s/XMbzWPs0rA9cz9KZcdOZcIFaI6xOpcv
         Du1QBOPvjofWT7Lt/kZOdAOvEpzXCYoAVGwOvf28ZmX68WGV7E0bdXLg8HlpEwZ2t9rl
         DcS3OvrO39qciBrQwmzJf4vOhkaBcngFv6kom9KQUG+DiSRsBtUsc9CJknWgeusv127a
         dcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750875869; x=1751480669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFOhh2OYzhDwJNd3NFmvsqGbVMf7JWImQym8u3yFy3w=;
        b=rTwVUPSlkSH1KgrOm1ZDtOOLlLoSwtMc/9WEko7Xsva4AG3ydUtXJtziUH8p/6RPo6
         9I1C96cSnmEpFWntZ8UIeAzN9bm01yMAfrd5KJ8pn0FE1v1JHwU0yFkGEeBqbYzpLwq4
         0sNFf3xlBmYlEL1ZGrWTcLezNGNoe4Abk5zC2jGk86EIaDngDHCK9m+79ilzamUnGiqj
         UEanUmL5S0ptCDcSr22aGD/kF+EwjcNvUJLpXlTLcNZDw3FjzJHiULSM9NGFdmBkSZTb
         cBGiQArJ29LwjAUrFyHBXwAqYBSCTUfRE5YFyeX3WFHbF2Z9oMV7yGthfWTjE5pj7qJS
         wypA==
X-Gm-Message-State: AOJu0Yx0V7bhRU6+GRyjpahsNYMFSaxxHh2Lppgny6fVECl9n3RHf0TQ
	8eq0YZBI0mojnv10dCS9hbE9rhR+xpDi/oNsZ4FhFjkbV0A/4eoY1pecAptyDIOXfnw=
X-Gm-Gg: ASbGncudeesr4WawhrIKbnaf63TL7/WdiVCy97bRHaJcKRRty85AVFtu9e1MvTkIiuT
	fwLKVsOX951JE5w6JfAaypnqtIkfA/bBfkrLlDaB5hkURfnAQGbarjD0Rs9Jv2uoMT1Pgs/PCcb
	fO+CICxlrUs9+JNV3PbBfapdhPQpfZqetgZFVQL1YprLtSp7q0AhMZTZ5fkBaWu20duuv6FBuFJ
	yjNVWdseQ/+8/h4hsTXpiXXVwyDdhdwGYmlTn5ctyklzRfd95osWb0kUWx8QGV/MQ2KYWD41rrr
	dTXFveHu9LyANDSTSnLERkgmolALYnTx2cFi33KyO8ZJxWiEs/APaRPKYOy54ex10I2aA47BIFv
	7T3BrMzgu73rYunBYi5OG
X-Google-Smtp-Source: AGHT+IEtaFzwS1fo/WikQ0+oMaW4FEqRGSQWi9zRJxbTiWxjpLAe1+bSEhqadcCjcH/AFfTaPWeGqA==
X-Received: by 2002:a05:6a21:329c:b0:215:ead1:b867 with SMTP id adf61e73a8af0-2207f1d8071mr7268524637.14.1750875868651;
        Wed, 25 Jun 2025 11:24:28 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1734])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1258b4asm13322939a12.60.2025.06.25.11.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 11:24:28 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v3 2/3] bpf: allow void* cast using bpf_rdonly_cast()
Date: Wed, 25 Jun 2025 11:24:13 -0700
Message-ID: <20250625182414.30659-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250625182414.30659-1-eddyz87@gmail.com>
References: <20250625182414.30659-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for `bpf_rdonly_cast(v, 0)`, which casts the value
`v` to an untyped, untrusted pointer, logically similar to a `void *`.
The memory pointed to by such a pointer is treated as read-only.
As with other untrusted pointers, memory access violations on loads
return zero instead of causing a fault.

Technically:
- The resulting pointer is represented as a register of type
  `PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED` with size zero.
- Offsets within such pointers are not tracked.
- Same load instructions are allowed to have both
  `PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED` and `PTR_TO_BTF_ID`
  as the base pointer types.
  In such cases, `bpf_insn_aux_data->ptr_type` is considered the
  weaker of the two: `PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED`.

The following constraints apply to the new pointer type:
- can be used as a base for LDX instructions;
- can't be used as a base for ST/STX or atomic instructions;
- can't be used as parameter for kfuncs or helpers.

These constraints are enforced by existing handling of `MEM_RDONLY`
flag and `PTR_TO_MEM` of size zero.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 73 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a55bd95a762e..97d69a1e5948 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -45,6 +45,7 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 };
 
 enum bpf_features {
+	BPF_FEAT_RDONLY_CAST_TO_VOID = 0,
 	__MAX_BPF_FEAT,
 };
 
@@ -7539,6 +7540,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		}
 	} else if (base_type(reg->type) == PTR_TO_MEM) {
 		bool rdonly_mem = type_is_rdonly_mem(reg->type);
+		bool rdonly_untrusted = rdonly_mem && (reg->type & PTR_UNTRUSTED);
 
 		if (type_may_be_null(reg->type)) {
 			verbose(env, "R%d invalid mem access '%s'\n", regno,
@@ -7558,8 +7560,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = check_mem_region_access(env, regno, off, size,
-					      reg->mem_size, false);
+		/*
+		 * Accesses to untrusted PTR_TO_MEM are done through probe
+		 * instructions, hence no need to check bounds in that case.
+		 */
+		if (!rdonly_untrusted)
+			err = check_mem_region_access(env, regno, off, size,
+						      reg->mem_size, false);
 		if (!err && value_regno >= 0 && (t == BPF_READ || rdonly_mem))
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (reg->type == PTR_TO_CTX) {
@@ -13606,16 +13613,24 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		regs[BPF_REG_0].btf_id = meta->ret_btf_id;
 	} else if (meta->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		ret_t = btf_type_by_id(desc_btf, meta->arg_constant.value);
-		if (!ret_t || !btf_type_is_struct(ret_t)) {
+		if (!ret_t) {
+			verbose(env, "Unknown type ID %lld passed to kfunc bpf_rdonly_cast\n",
+				meta->arg_constant.value);
+			return -EINVAL;
+		} else if (btf_type_is_struct(ret_t)) {
+			mark_reg_known_zero(env, regs, BPF_REG_0);
+			regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
+			regs[BPF_REG_0].btf = desc_btf;
+			regs[BPF_REG_0].btf_id = meta->arg_constant.value;
+		} else if (btf_type_is_void(ret_t)) {
+			mark_reg_known_zero(env, regs, BPF_REG_0);
+			regs[BPF_REG_0].type = PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED;
+			regs[BPF_REG_0].mem_size = 0;
+		} else {
 			verbose(env,
-				"kfunc bpf_rdonly_cast type ID argument must be of a struct\n");
+				"kfunc bpf_rdonly_cast type ID argument must be of a struct or void\n");
 			return -EINVAL;
 		}
-
-		mark_reg_known_zero(env, regs, BPF_REG_0);
-		regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
-		regs[BPF_REG_0].btf = desc_btf;
-		regs[BPF_REG_0].btf_id = meta->arg_constant.value;
 	} else if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice] ||
 		   meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
 		enum bpf_type_flag type_flag = get_dynptr_type_flag(meta->initialized_dynptr.type);
@@ -14414,6 +14429,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	/*
+	 * Accesses to untrusted PTR_TO_MEM are done through probe
+	 * instructions, hence no need to track offsets.
+	 */
+	if (base_type(ptr_reg->type) == PTR_TO_MEM && (ptr_reg->type & PTR_UNTRUSTED))
+		return 0;
+
 	switch (base_type(ptr_reg->type)) {
 	case PTR_TO_CTX:
 	case PTR_TO_MAP_VALUE:
@@ -19571,10 +19593,27 @@ static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
 			       !reg_type_mismatch_ok(prev));
 }
 
+static bool is_ptr_to_mem_or_btf_id(enum bpf_reg_type type)
+{
+	switch (base_type(type)) {
+	case PTR_TO_MEM:
+	case PTR_TO_BTF_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool is_ptr_to_mem(enum bpf_reg_type type)
+{
+	return base_type(type) == PTR_TO_MEM;
+}
+
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch)
 {
 	enum bpf_reg_type *prev_type = &env->insn_aux_data[env->insn_idx].ptr_type;
+	enum bpf_reg_type merged_type;
 
 	if (*prev_type == NOT_INIT) {
 		/* Saw a valid insn
@@ -19591,15 +19630,24 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
 		 * Reject it.
 		 */
 		if (allow_trust_mismatch &&
-		    base_type(type) == PTR_TO_BTF_ID &&
-		    base_type(*prev_type) == PTR_TO_BTF_ID) {
+		    is_ptr_to_mem_or_btf_id(type) &&
+		    is_ptr_to_mem_or_btf_id(*prev_type)) {
 			/*
 			 * Have to support a use case when one path through
 			 * the program yields TRUSTED pointer while another
 			 * is UNTRUSTED. Fallback to UNTRUSTED to generate
 			 * BPF_PROBE_MEM/BPF_PROBE_MEMSX.
+			 * Same behavior of MEM_RDONLY flag.
 			 */
-			*prev_type = PTR_TO_BTF_ID | PTR_UNTRUSTED;
+			if (is_ptr_to_mem(type) || is_ptr_to_mem(*prev_type))
+				merged_type = PTR_TO_MEM;
+			else
+				merged_type = PTR_TO_BTF_ID;
+			if ((type & PTR_UNTRUSTED) || (*prev_type & PTR_UNTRUSTED))
+				merged_type |= PTR_UNTRUSTED;
+			if ((type & MEM_RDONLY) || (*prev_type & MEM_RDONLY))
+				merged_type |= MEM_RDONLY;
+			*prev_type = merged_type;
 		} else {
 			verbose(env, "same insn cannot be used with different pointers\n");
 			return -EINVAL;
@@ -21207,6 +21255,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		 * for this case.
 		 */
 		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
+		case PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				if (BPF_MODE(insn->code) == BPF_MEM)
 					insn->code = BPF_LDX | BPF_PROBE_MEM |
-- 
2.47.1


