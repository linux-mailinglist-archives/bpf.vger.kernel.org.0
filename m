Return-Path: <bpf+bounces-36742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E377394C7CC
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3071F23D11
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 00:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639D09463;
	Fri,  9 Aug 2024 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icd5gUmH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E979D0
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164710; cv=none; b=E2GQ4ifc8wX9cOB+HDxCFKwSxIjpxCIGnYBdeoa3/Wu43/cYsGEr+5r4lN3ZDEpvTA1xoh9ElSCrQwP+B60NZkI0FQyLvrVutXDmzn/KGvhw376TdeQNd9NI20Yw2AsDjUVBi+Kb74PxeBJbHWS+22kpQG1lbFHlqL8ojxxb58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164710; c=relaxed/simple;
	bh=9bVt2RqQHMBiLL+bNtCoVf9m2FTiqTamJTbmrLYY5Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MpSYRUV03Zk2+svyxYNv6zZn2x/hRRGYjYVpW/ZpNVu/k84dSVxQONeSWf0NVn4WeP2HJ21S1DSWjI59cB23XYeP6NQe4SxebCPG2XQn+eOslSZv1iKnQPgk0kg/JOv8ouuz63jLRx4B+aPq5JvcPcWWSZRb5fzYke62getcLvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icd5gUmH; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-493d748ba72so535683137.3
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 17:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723164707; x=1723769507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSdXUIc8I8ipGRJ21IkX+BG97y/uudEncK49JhUrZvI=;
        b=icd5gUmHfRrRYfORlzm4rahd6hUeQQ2GQcuUt/PRpPwEcn3l73v9n22tJHswv1h+eM
         NiUkq4skyrsjCSa1xTy4GNaCx0pqvR4PNDDAiPRqfCaekBIBkmu0LUQda15YPXoGAVOj
         C3LNDGJCqXLAf1Ky44QTLOkoeIfb3OaqqGomP88lJfOhQOi4dp/v9yqnjDG0H4QrGRzR
         B72zUtwk+u0D1eMB0In6oprrB1YvNFhdMTmaoS/Pi54iTo0/loNiBr3QJfcj5heo5XI4
         l2b5/ZG+ccF1y8/VL3aNQRYu9gpmzrfOQ5rMgne/EVvgxr+Yu4IUZnfdCTkJeR2jndjD
         i/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164707; x=1723769507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSdXUIc8I8ipGRJ21IkX+BG97y/uudEncK49JhUrZvI=;
        b=Ull9YK05HabtfEiSywQMetiA1w1ntxWS4y/CxkpvmskKLh4gB18BB13HbLPwhyypsD
         6n2z928XNhzoTKbfD0nlYgHQ81RMsMSn4OHdlaZbdEM4Wt+c3lplMRck175+AKmtGQ6U
         MEbBcn1+np9zO4k0r0bXrf0Vnn7VbvprZajoomaqUKdZKXX87vLLDqewUbvjhO4eYKp4
         MbTvcHF1Q5HhPogseJfK4/tWP0PTC5r63IdrT1oOVzm8nEKKQLiyy+inyMeU5jovzpxx
         onkLNW7cKqGLWzzr09JXnlZFx+HZqPTBE0KxF8GNfheZ4N8OtbgE6vx47ZTXLPBBq8Ae
         9YWg==
X-Gm-Message-State: AOJu0YxuoiCXklnsQhM2p7HRBD2m1fagMbXRDpiNbEK0qCCYw/8daPzO
	Pj6f6DaIaj+u19WC+tFsNiCO6LiS15PpnIzTR+WmS6IsgxRb1ddFj/RyzA==
X-Google-Smtp-Source: AGHT+IF3L+Uf15x4N682FOROoQCjZtCHI9KDfNd/T/dtGD3Y8YdpmMRufLiFEDQFzJHwfVebmx5nkw==
X-Received: by 2002:a05:6102:3052:b0:493:b719:efaf with SMTP id ada2fe7eead31-495c5c33af9mr4201563137.20.1723164706918;
        Thu, 08 Aug 2024 17:51:46 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.99])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c797dbdsm71485826d6.52.2024.08.08.17.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 17:51:46 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	houtao@huaweicloud.com,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v3 bpf-next 4/5] bpf: Support bpf_kptr_xchg into local kptr
Date: Fri,  9 Aug 2024 00:51:30 +0000
Message-Id: <20240809005131.3916464-5-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240809005131.3916464-1-amery.hung@bytedance.com>
References: <20240809005131.3916464-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Currently, users can only stash kptr into map values with bpf_kptr_xchg().
This patch further supports stashing kptr into local kptr by adding local
kptr as a valid destination type.

When stashing into local kptr, btf_record in program BTF is used instead
of btf_record in map to search for the btf_field of the local kptr.

The local kptr specific checks in check_reg_type() only apply when the
source argument of bpf_kptr_xchg() is local kptr. Therefore, we make the
scope of the check explicit as the destination now can also be local kptr.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 include/uapi/linux/bpf.h |  9 ++++----
 kernel/bpf/helpers.c     |  4 ++--
 kernel/bpf/verifier.c    | 44 +++++++++++++++++++++++++++-------------
 3 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 35bcf52dbc65..e2629457d72d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5519,11 +5519,12 @@ union bpf_attr {
  *		**-EOPNOTSUPP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
  *
- * void *bpf_kptr_xchg(void *map_value, void *ptr)
+ * void *bpf_kptr_xchg(void *dst, void *ptr)
  *	Description
- *		Exchange kptr at pointer *map_value* with *ptr*, and return the
- *		old value. *ptr* can be NULL, otherwise it must be a referenced
- *		pointer which will be released when this helper is called.
+ *		Exchange kptr at pointer *dst* with *ptr*, and return the old value.
+ *		*dst* can be map value or local kptr. *ptr* can be NULL, otherwise
+ *		it must be a referenced pointer which will be released when this helper
+ *		is called.
  *	Return
  *		The old value of kptr (which can be NULL). The returned pointer
  *		if not NULL, is a reference which must be released using its
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8ecd8dc95f16..d1a39734894c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1619,9 +1619,9 @@ void bpf_wq_cancel_and_free(void *val)
 	schedule_work(&work->delete_work);
 }
 
-BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
+BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
 {
-	unsigned long *kptr = map_value;
+	unsigned long *kptr = dst;
 
 	/* This helper may be inlined by verifier. */
 	return xchg(kptr, (unsigned long)ptr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f2964b13b46..5a4ca7e29272 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7803,29 +7803,38 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	struct bpf_map *map_ptr = reg->map_ptr;
 	struct btf_field *kptr_field;
+	struct bpf_map *map_ptr;
+	struct btf_record *rec;
 	u32 kptr_off;
 
+	if (type_is_ptr_alloc_obj(reg->type)) {
+		rec = reg_btf_record(reg);
+	} else { /* PTR_TO_MAP_VALUE */
+		map_ptr = reg->map_ptr;
+		if (!map_ptr->btf) {
+			verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
+				map_ptr->name);
+			return -EINVAL;
+		}
+		rec = map_ptr->record;
+		meta->map_ptr = map_ptr;
+	}
+
 	if (!tnum_is_const(reg->var_off)) {
 		verbose(env,
 			"R%d doesn't have constant offset. kptr has to be at the constant offset\n",
 			regno);
 		return -EINVAL;
 	}
-	if (!map_ptr->btf) {
-		verbose(env, "map '%s' has to have BTF in order to use bpf_kptr_xchg\n",
-			map_ptr->name);
-		return -EINVAL;
-	}
-	if (!btf_record_has_field(map_ptr->record, BPF_KPTR)) {
-		verbose(env, "map '%s' has no valid kptr\n", map_ptr->name);
+
+	if (!btf_record_has_field(rec, BPF_KPTR)) {
+		verbose(env, "R%d has no valid kptr\n", regno);
 		return -EINVAL;
 	}
 
-	meta->map_ptr = map_ptr;
 	kptr_off = reg->off + reg->var_off.value;
-	kptr_field = btf_record_find(map_ptr->record, kptr_off, BPF_KPTR);
+	kptr_field = btf_record_find(rec, kptr_off, BPF_KPTR);
 	if (!kptr_field) {
 		verbose(env, "off=%d doesn't point to kptr\n", kptr_off);
 		return -EACCES;
@@ -8399,7 +8408,12 @@ static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
-static const struct bpf_reg_types kptr_xchg_dest_types = { .types = { PTR_TO_MAP_VALUE } };
+static const struct bpf_reg_types kptr_xchg_dest_types = {
+	.types = {
+		PTR_TO_MAP_VALUE,
+		PTR_TO_BTF_ID | MEM_ALLOC
+	}
+};
 static const struct bpf_reg_types dynptr_types = {
 	.types = {
 		PTR_TO_STACK,
@@ -8470,7 +8484,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	if (base_type(arg_type) == ARG_PTR_TO_MEM)
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
-	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type)) {
+	/* Local kptr types are allowed as the source argument of bpf_kptr_xchg */
+	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type) && regno == BPF_REG_2) {
 		type &= ~MEM_ALLOC;
 		type &= ~MEM_PERCPU;
 	}
@@ -8563,7 +8578,8 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
 			return -EFAULT;
 		}
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		/* Check if local kptr in src arg matches kptr in dst arg */
+		if (meta->func_id == BPF_FUNC_kptr_xchg && regno == BPF_REG_2) {
 			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
 				return -EACCES;
 		}
@@ -8874,7 +8890,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->release_regno = regno;
 	}
 
-	if (reg->ref_obj_id) {
+	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
 				regno, reg->ref_obj_id,
-- 
2.20.1


