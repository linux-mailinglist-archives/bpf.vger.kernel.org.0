Return-Path: <bpf+bounces-61470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805CAE739C
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965681885610
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126DCCA5E;
	Wed, 25 Jun 2025 00:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYvix87j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1C1FDA
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809926; cv=none; b=E6WnabEwZlb+HNIro3sXYqdgS/F5mTf9MByrnJmyCJB5gAQJjom5HogQ7cvR20Vw7KG1phoSA9fJyouW/UzYBw5K1Z6bPPk6WUXBJwa4nKymE2wDcvwRGgRrkpFusVEsyoyxdPEekBdoqw6lxJ4Hv2DkkB8s0Xbqu89ObJzgZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809926; c=relaxed/simple;
	bh=Mq2VPpoIa4ENszVwKOJTJg1Mqt2kz+dPMoCIHaS1vpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PliVzGvuo6NhDpbqGhqzZ4faoUTh3vRhS47F0vdalV7Kw30ZBMDGnhaGadOi4+IpROSWS+jLRbZgDfJshAO0yykdYDvybhvttn04vC/i5+5pDgl2TNJUJo2GE8XmIcp1+cqIdyRXPuAwWdKzl17zSe4F314+vk2QiKPndEnNKUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYvix87j; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e81f8679957so4892635276.2
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750809924; x=1751414724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvWVstUQQspYVOSCXJ3vWMw5INmJo2WYvgS5PeuRtmc=;
        b=AYvix87jJRJcJAugFO5cr6A1n05ifyVNBsxyeJSCP8OXeJv1jpK1kGeT3JkGvw4rzS
         95pI1LbAp0OidSKmjR2pKCJ49Rwyo1RQEYWYZNB14DhlVPlUyFGRb4TvslfEkMPM09ON
         JskP++7o0KbhQRd/GoPWCIj0V5cxhgiAinhFdRpS0+SOl4a/PORa03DAekOJ+6f3WM9x
         UdEh2cb7h1sWmnvD8geFRbwixZSSn1KF8iLmH1knklhvvq201eFWCkere2OGguXwHShf
         zLAvA/osbZZ/mIHrNGprVogG3XPmaAUCY13HzFaA3NVqMlvrpJNi0bNjTY3vrCYpGK/D
         5mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750809924; x=1751414724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvWVstUQQspYVOSCXJ3vWMw5INmJo2WYvgS5PeuRtmc=;
        b=Du71K9oxGxBxjI6zigB0I2k87UAep5bYejYhj7Uyxqt7aT1yAU+XDkNBiH0JUyEAOG
         qrRv0kCwDYetpCNSweieOsI2fYZG5XVpCcTMHBKEipZVfJ0nwszdWb5zHp/YUhRE5000
         GovceYUop8K7vzM/ZlldDkwYJLH+rZU/cI5pZewSOWTMHpDae9mFgyR5XrJ59e4soyNv
         m5R5kmBBGalUzy9e7+EHdyFa0Eu7ZVxJZsHYEw4KuwfS6bZIQDQiW+dyM4SfI7v1I1rE
         EmJG9G0qt0/XRyKdIQdQaBsOjFAN/9InMkR/Q2YSmZ1EPijQdfY605V/4U02I0kmmv3o
         zVoA==
X-Gm-Message-State: AOJu0YxMMOUiXd69TMIEYKwFJiGLs3jb2Bml0iulheWfX5PHKDKuIg+o
	KQZTYdepsBFdzH86aLT0Um9C+nFUiuZfJNfkDCQ38uczrAt7I0YQExAHosTw/hzR
X-Gm-Gg: ASbGncsONIG+p2q5MZY3A56iEXqGBEuAn74Rc/6MexmK0EBfXYqmO+k/yJzXnmoKEHp
	Mo3Fom0V7ij9tHO0T+lrQyJVltyHEUfWZRWwq7o/00VcuPCQ4S0VzxJ+VHYnXyDhM4nlot5FZv7
	tInJu87eYkpqB4SIskglj2lZE8lwOxqOyyuLqtNP64AWklBbhnenUOxZ0jzbqK10yalRtIqh1mg
	O60MZS85oIPELIPHsnJnM9ybPjQuJwyNrJEPl5Ljl7knFitApCiqQjRhP38wITeQy5zVAXO+WRx
	+8QF6K6jWXB1ZP61vwZ9q1xQ1/9UqI46DzwDk1LXOGdaZD7majFX0A==
X-Google-Smtp-Source: AGHT+IGtlZi9o+SYccIZgQHHG/IoD2OOy34WlnVwXgkk1e2x8UhxmJnis30LpYAZ+wnnFT3qqOkyYA==
X-Received: by 2002:a05:6902:260c:b0:e85:ff1a:1a53 with SMTP id 3f1490d57ef6-e86017884e6mr1034828276.14.1750809923633;
        Tue, 24 Jun 2025 17:05:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:46::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb7b1esm3306648276.57.2025.06.24.17.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:05:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 2/3] bpf: allow void* cast using bpf_rdonly_cast()
Date: Tue, 24 Jun 2025 17:05:19 -0700
Message-ID: <20250625000520.2700423-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625000520.2700423-1-eddyz87@gmail.com>
References: <20250625000520.2700423-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c | 75 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71de4c9487d5..6b2c38b7a7b6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -45,7 +45,8 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 };
 
 enum bpf_features {
-	__MAX_BPF_FEAT = 0,
+	BPF_FEAT_RDONLY_CAST_TO_VOID = 0,
+	__MAX_BPF_FEAT = 1,
 };
 
 struct bpf_mem_alloc bpf_global_percpu_ma;
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


