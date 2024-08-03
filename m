Return-Path: <bpf+bounces-36333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7420F946668
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 02:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ADE6282C36
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26906322B;
	Sat,  3 Aug 2024 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlR1hIw9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379C196
	for <bpf@vger.kernel.org>; Sat,  3 Aug 2024 00:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643921; cv=none; b=uTh5k3WdYtDXuh5K7r4qNFfhCX8VAjHXQ4//RxiiJvON3e+SqzXVmgS7wvhcufSpFH8ZYK/nTyFxfi0lm+SRNzriYfncZukIqN8KOiEzNH69nth/o+UBS/4Lx+gBD/UNkDCveOzub1pOoLm1KQkpWAGxP4UvyEbVmvlJ/it4X60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643921; c=relaxed/simple;
	bh=9bVt2RqQHMBiLL+bNtCoVf9m2FTiqTamJTbmrLYY5Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HVyVw2Bo/vZvgxXHjsGDFRNRakIz/aEo7JFs3dVMjIm47tPeeXEC+SKwXvJH9afkJdRLLu28xv0MHsH1ph7/Tr4zarVXMbSqllVMjaY/1BCUtf67aYjhHQEC7+f8M7+JcwXZtryUIiPRjHUFLo26hO0LTn7dn3x9ZI0rfFQQh1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlR1hIw9; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1e0ff6871so486984585a.2
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 17:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722643916; x=1723248716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSdXUIc8I8ipGRJ21IkX+BG97y/uudEncK49JhUrZvI=;
        b=IlR1hIw96yGm7CGnDq/T/IXSLVfI1aad33S0BE1GLDJigZB8tC6/P7sRMZ/b4qJmHM
         PaM6/SETmiU8iWdPQDb9JrPjTuJ/IER4mha/xPp6RIO/ulG74iFp+hs4b47rL+oGaXdt
         tv6W9B41AFRFpRbQxenJIJQ6Jx1QG6RkC+tDv/KIrSAf7E3fBrEyNzyqRZCoi/gAePmM
         mJjvgou01td5i/2Ykk4yrj948V0hTLWqGQ0o58D4YRIjrGz7wvpnIRKLeidzQJ282Ez2
         WVxILskfKXnWBrwjrvThLPMsLOYJdsDCxCiDRXtczNjqAOp88JxUVZAwd+HWhboRT/nU
         BAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722643916; x=1723248716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSdXUIc8I8ipGRJ21IkX+BG97y/uudEncK49JhUrZvI=;
        b=WoTjzJk2315syWZNVondKBBZ0VBsZhJzUeqi+Xj5Yk6e/vir43qckG6xG+oZpsLH1f
         wCpa3EWhMyU0SIqMnXGpmSHtF89CRJclzjmH2Wo6228LT2P+JBA4on7QIrYztXEg6mC6
         A8hI7lU30G4ppM9c+l2E3JAipbBtoS7SIH12FR4TiJw+yP2GCh/Xl41cslLTLS4DdjXW
         YUm6rQ60YGrTfhkR1H2WV6DukKiJIbPOfslC+0Y7VxYfjOjRF4/m/qNp9IZyKFM8Xy3t
         M5Fh3CQDt5P5NS+RkZ6UYlQMrxM6U977asJtAAx3o83hewvYowpFjM4WHQCuAJzWPv/I
         LdBg==
X-Gm-Message-State: AOJu0YxN0lGSSJKmdlYR2wewniYdBqCoqxZ2T0YvSS9b+jN2/wbgXAkW
	lgIKwU/Hn1UduAlIcugKBDRe01bHObHVm3DjTXFva/Xb74i8mPR4P40zGA==
X-Google-Smtp-Source: AGHT+IGkIVa/kWzvCmYtUGWHHe319nOl/vY19G5SmdGUiKoivVidlHhC7arwWE9nxjUUygnT8Kk+xA==
X-Received: by 2002:a05:620a:f01:b0:79d:5c31:718c with SMTP id af79cd13be357-7a34ef032f5mr561246085a.27.1722643915683;
        Fri, 02 Aug 2024 17:11:55 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dce75sm129547485a.14.2024.08.02.17.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:11:55 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v2 bpf-next 3/4] bpf: Support bpf_kptr_xchg into local kptr
Date: Sat,  3 Aug 2024 00:11:44 +0000
Message-Id: <20240803001145.635887-4-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240803001145.635887-1-amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
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


