Return-Path: <bpf+bounces-61423-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D12AE6F3C
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536163A9F6D
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91F246BB4;
	Tue, 24 Jun 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv6l3goD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856232459C6
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792221; cv=none; b=Pss3dJyhtXvI/MG4cO3j9ta5hpoiq1X5P6r3TpfUGG2q832BPfkQL3rQSpyARBOkADTUJUhxzLjkjnPYoPB9BBM4za/blITP0SwzepGo/d5sE4pMYtwvJ5go33YIQLN2eJKd2TlB1H4n8XGynyt1i2eInEximSTI/tg3yUNiFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792221; c=relaxed/simple;
	bh=dKQ1zQz7/m4jJ9Enj5eafcJPFC+ghDq4z7+X6GmXtMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAxPUo0eLNeQlSQPfwQVWCuVa+426ekhZtWhVsOvcLoiK1leHMSzo5s+DFrSZaOjCdWPxAHr2HfqJEqKAWoa9uASlrPf4XKAKt1Oir+kY2xTO/s32fUCuY9sqbhl5Sz6UsE/UGITPzn9IKEFwX+Q6FRnGZQWZWgxJHs2qgQ13/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv6l3goD; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7db5c13088so186605276.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750792216; x=1751397016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3yHadBkK1erTEvpYo1VEETcJSHid6mRjPziT1Adfwc=;
        b=Kv6l3goD+vNRe/VJw8RaWuIna+EiGPLLGPqZKJO8qbLB05FDJHn8v1gI1NCpwvOsht
         ANoo12+T9wAf4B8muUKQOcIoSLdunpUE6RkM6SX8oElUj+BAC+jXQFGKxIxjmdUxHZOe
         gzhnHbRS8QqHMPiqWyqRRo57rXp2rM0T5qs4c7/h00h/17TR277wE+hgk1wmadfVGI9P
         aJTHqhLE/b2lEf8vgVS9NMoo20CbGjPE4knR7BYztlDE2EYMXF/mhB0VvvPxDsnmfdi3
         RErdXLNhra4Rt7g5Nzs1GiSUnqtXB+FbrEeFCtbNc+aCXFNGGFlxGhZQEJXXJErX+ccn
         Nh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792216; x=1751397016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3yHadBkK1erTEvpYo1VEETcJSHid6mRjPziT1Adfwc=;
        b=bOPqC3gkH/f2uCgisAVELnNUJvNv+HNT8UnpUOFddfqQy0nRIh3hV5uFeSbX1hm/44
         H7qEYeGothk5r3o82S00oJln9wAMhG+ZUpIBAGS17V4168D+nj0NUih9U7clEc7ZnArr
         XzrnMdM7IXf4hnDNUnGngNEnHxweyM+yw2I5bXAUo2nvWvIDVUVjLNG4sIoxC3flO2Ut
         X5TFpL95JXpf0x3YzsXnx5ew8AmD/B/JtZbz5M09unlnxv7fgsG+ah5Rv1oDbrttutt8
         WiBVsKoMlalxrMBbpLRM/0bDw8Fab+nmZYpy7pjpje3AMiVYz6T6Kaj//LRAddgKOyO/
         AoxQ==
X-Gm-Message-State: AOJu0YxzMeNhfB7NVhy3TeqfgoN7f5GbLwj1MQfOh0+SAPTJjrDiwiXQ
	gHxZyvXV/4ymwwUK0HTLkJYsQbcp0IvyhtMUk7PWkDgunMghSqb8+uJK35DjUF6n
X-Gm-Gg: ASbGncsn7djpx9l/yFAppid1q0oDWr8UoRGLPO75Ew/z/Gweo70zJAvxqk5vf1+fP2x
	lJ8Y1N1xgpjYtUoBb/M6/PkLGjswT9HI9jccHaXE6pJHoe63cB4BvdOKWC9H6Bvf1Moa5TvEQcL
	Z89c+usaX3dr2di+ifjKQDiMRPz680NbS1ZRj8ujrodJI1NnI2rmonazfXdL/gISGxMUMiFCA70
	+29c8GpTGkQISfn6SUujNISXDFrof7Dk0Al/y/+it4DLGQa7aTwNAf5aWVmas73r372DZUGTG0K
	M5McpWmnyVt/KRKVQPCSJk7kyj4XmkRZ9Vu7KE6veWU5q1n+gK2O
X-Google-Smtp-Source: AGHT+IF5x8BWCMmb1ZZxejEdasbdSmqu784fRlsEgbZu0ox5c0N3f0D5GSx3vCBb+d0HejzSkBH9WA==
X-Received: by 2002:a05:6902:144f:b0:e85:eccf:58ea with SMTP id 3f1490d57ef6-e86012bda26mr160650276.15.1750792216140;
        Tue, 24 Jun 2025 12:10:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5be1csm3174872276.29.2025.06.24.12.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:10:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/4] bpf: allow void* cast using bpf_rdonly_cast()
Date: Tue, 24 Jun 2025 12:10:06 -0700
Message-ID: <20250624191009.902874-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624191009.902874-1-eddyz87@gmail.com>
References: <20250624191009.902874-1-eddyz87@gmail.com>
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
 kernel/bpf/verifier.c | 72 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..8fd65eb74051 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7535,6 +7535,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		}
 	} else if (base_type(reg->type) == PTR_TO_MEM) {
 		bool rdonly_mem = type_is_rdonly_mem(reg->type);
+		bool rdonly_untrusted = rdonly_mem && (reg->type & PTR_UNTRUSTED);
 
 		if (type_may_be_null(reg->type)) {
 			verbose(env, "R%d invalid mem access '%s'\n", regno,
@@ -7554,8 +7555,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
@@ -13602,16 +13608,24 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
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
@@ -14410,6 +14424,13 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
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
@@ -19567,10 +19588,27 @@ static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
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
@@ -19587,15 +19625,24 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
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
@@ -21203,6 +21250,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		 * for this case.
 		 */
 		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
+		case PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED:
 			if (type == BPF_READ) {
 				if (BPF_MODE(insn->code) == BPF_MEM)
 					insn->code = BPF_LDX | BPF_PROBE_MEM |
-- 
2.47.1


