Return-Path: <bpf+bounces-35824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B636093E375
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 05:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8A4281ED3
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 03:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FDE1878;
	Sun, 28 Jul 2024 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIAOyvvg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701F1B86DC
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722135706; cv=none; b=b82PLe69QJ1M0XLnV4Ydos8CDAE0Yxl8e9HBUMRpRCt17EfEsd4GjlgU0m1htjOFG+PQe9etri6xGgttpqsHcXepqCfX6jYKDbc/zc+1ntbkXh7/XpDmX9lmg2Ko6xp2LrFJPwP2V6O+i5FjlnXyAWFpVJC8E11Dp5kW+g+ySDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722135706; c=relaxed/simple;
	bh=FmYOYsNEZAG9lENfVu5cohFab+lVJzPyw9ok0H3YQB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ffQYBIhyd5UKGCvhJHSP2GQSMzy4Ah6FD6p+HtXYj1SIpsf6FKUbVEgWEnwAti9Lv+PKqQHVy1/6lsT4Wb6EONC73VjHL217iuDdhHeY8cnft+X8Ks7V8R6DRxSvSQFS1MVVF8SRXez9W2ksheZOy0QId+163acT3IkpIPhXG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIAOyvvg; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7b28442f9so22031016d6.3
        for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 20:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722135703; x=1722740503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md7GflDFfPw9u7WBE5P4rTBb0KC5ivuwZOG/KYaPFVI=;
        b=BIAOyvvgVg75F/fXX2KCqO/O6n5j6W/nTrhcTFO2meU1UI+upCebVGEU6N+CTzHtH6
         OEGn+wBCm37qkd5mVwo7ggIFPAp/Y2b0a7pn0ze3HTvRDvKTX9z6i6E4W35kkV5Rk3bP
         0nrcNHPd5yUdBV9hJ0IXdo2NTm1G+A4ufkc7v8XDLhI6QyE9LUr76j/CCtYF3uAtaYjO
         tJv8bbX9E5CwQ8xRNrWteUQWWu2ZsybS91t0IJ3rpTNKkjri3un2cIjwFSO4RscHyi3B
         17I7BJAuC/KoVVxrX6Vm6TP9DwiIZKKTtaAO6yTtPbjG4AcFATy6VUni6Wn/8PXtNrQw
         ZrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722135703; x=1722740503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md7GflDFfPw9u7WBE5P4rTBb0KC5ivuwZOG/KYaPFVI=;
        b=Noaef/liMm04R0aiOgAesWbEDcaUZf5tNGKGsuxcIh7RfrJI5cdsGrytYt6U/Aq6eX
         PJIwFjI+f5TtYM6xK9EsOVB8s1WsKt6Pl8yBO9Jb+FE1W5hAMxbRRsbCBymzN0DJKltI
         pVSmNbtuhGaKOJCPl0FcO3BrGcrn7FTj0RMa6NKMbzbXa7lPRoRS4HO8sW+/QPkeTTtA
         cKVK86Iav6tyEPOHG13pTs5Ho7QO1Gm1z1ZIO3pAaDsT7bCr5k8o0bCGP+XnXazBTwtU
         YAA/+TshBmaKNfx2gnaM1G7YlaJYN+12mDpXF+QU5WBYqD8B35n/ZA0xzOQcR+vot1QC
         ugJw==
X-Gm-Message-State: AOJu0YxNooZIDsr4oD7mvwVWIpe7bTSjjeFMCiFeU1Fce7sjdZsloUJC
	0mHHDTSsMZPoifckhYoPgHuXhX9wpdBhFZDqEh0a32zEEU7uY/70hLR5Iw==
X-Google-Smtp-Source: AGHT+IEQDyZHO6JBQYpTJGRJMScNiofljymPvQT1NEli300pU/NCoO+V9TXLiw44LfzDOHhdQ7xuRA==
X-Received: by 2002:a05:6214:b65:b0:6b5:97:1796 with SMTP id 6a1803df08f44-6bb559b4d37mr63985946d6.12.1722135703156;
        Sat, 27 Jul 2024 20:01:43 -0700 (PDT)
Received: from n36-183-057.byted.org ([139.177.233.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f90e7b9sm37953306d6.52.2024.07.27.20.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 20:01:42 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 3/4] bpf: Support bpf_kptr_xchg into local kptr
Date: Sun, 28 Jul 2024 03:01:14 +0000
Message-Id: <20240728030115.3970543-4-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240728030115.3970543-1-amery.hung@bytedance.com>
References: <20240728030115.3970543-1-amery.hung@bytedance.com>
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

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/verifier.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f2964b13b46..20094b35053a 100644
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
+	/* local kptr types are allowed as the source argument of bpf_kptr_xchg */
+	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type) && regno == BPF_REG_2) {
 		type &= ~MEM_ALLOC;
 		type &= ~MEM_PERCPU;
 	}
@@ -8563,7 +8578,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 			verbose(env, "verifier internal error: unimplemented handling of MEM_ALLOC\n");
 			return -EFAULT;
 		}
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		if (meta->func_id == BPF_FUNC_kptr_xchg && regno == BPF_REG_2) {
 			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
 				return -EACCES;
 		}
@@ -8874,7 +8889,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		meta->release_regno = regno;
 	}
 
-	if (reg->ref_obj_id) {
+	if (reg->ref_obj_id && base_type(arg_type) != ARG_KPTR_XCHG_DEST) {
 		if (meta->ref_obj_id) {
 			verbose(env, "verifier internal error: more than one arg with ref_obj_id R%d %u %u\n",
 				regno, reg->ref_obj_id,
-- 
2.20.1


