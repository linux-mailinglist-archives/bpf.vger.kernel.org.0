Return-Path: <bpf+bounces-78139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 994F9CFF42C
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 19:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D9A03045D98
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F6D397AC9;
	Wed,  7 Jan 2026 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cqtv8HvR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145183904EC
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 17:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808191; cv=none; b=trlxoQyXzp6ctS84Za9Ipvci0mVXZzwPiYMQdZsgG1ou7ZfLbm+F0jq7NWlyd7M9suJGeC4n4Uz7tZYBgyham2iVyzkmxgzsCi5Rls70wo6AHN473m8CYuv2SwW8/y33DlXW+DuVv2mwqXuyVuJJHnfpMbEhSVRbBN7ieL5MtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808191; c=relaxed/simple;
	bh=MY+Uz9ws8W69LeX6Iu504BveIBrngyYW0gsgCHAm8sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaT2Vsc1Mbs98VYNbZrjlUMRLIj6rmPErAnja9xZYY4lkA0SHi8EWyB0WyOTlf8Xy+bBlQAgjibTM/7eCedgJTy+viPU+tnWg3V7QKkQbfXJWK1cl4fsRmjTTBg98/Q2XMu2jmT0W69kG1M9S8CCLPyVj58ofrQRmZ4CXPv4r+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cqtv8HvR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so18991265e9.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767808181; x=1768412981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0xhTfxLjnTp1y2rDDAqc+N/J5RHaFm6PD22/HB9bPg=;
        b=Cqtv8HvRZ6DhPZA8HP3vIiKNXoVy6RH6oqNd2WifKWJT+iPPrvy9Az40thcngrq+cZ
         A+fqnLx2cQUOuD0hbFiDw/R56JEu+TbKVsVXKNX2aHKBXjcy65d/GfiGDpnV3uwhsI/v
         Fp8aLgns6Vw2cqINcpLuacjSHahixpvPZOnp7kXtuXfYRt8wFMlECDOYDMSsMz60JimM
         XEL8O0GIJFe2h3DlJ6k4JlWeABz77+4PH3oMaNp0OP/u59q4F3jmkdumnCyJkx85NLjt
         1lOOPp2wX+HM7cNVHW+E3Z/4eWUxcBRffzPTUPwJV7uXb7oS1erV28eYeRhUDGCLcJAI
         8FBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808181; x=1768412981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t0xhTfxLjnTp1y2rDDAqc+N/J5RHaFm6PD22/HB9bPg=;
        b=IyHo8M6M3wWmopvoCiyZwZm4eGbXj3oOAVg1Xg3n1wYm7Vv26DKZ2Jp+fgqm0HHS7+
         suci6RILXOkR4XEFHT9RYHu1BQADAowsiQYNWnTHuNa7oHhzSJuPYi4bT/pRtbRBAp0F
         VVkogwYom50pXW0dFdY/V8gXBzlADI8/zzTLLhIe5TcUB1oaTdqEQt3vk62vTPNokzrB
         gU79jHhRVF8vfcF2dAMcu/R2js9Yqj5XDtcVAeMiYuGolzJmXAAt5gEBC/oXcGN0iMbi
         j7glOHwYaA0mRWEuYa2WmRmQNkq/f/d1QfDtR1gwxarGuVHD32PhXtdYpnBFWaI0xIak
         4VyA==
X-Gm-Message-State: AOJu0Yx3CoWsNanfA7HkTPk9DhnMlhUOFX9ZbEVNSThsEyJWyTP7qUVh
	S7pQmS91KzlcbdiKmhSELpkORt52xhEdJ1/VHeZIblc9o+EEjdpWc6GQ
X-Gm-Gg: AY/fxX5nYFkZ7KgDfwbltGSIH2VGzFyNnJ9hlnuzrBgnRlwftatgxRG8uf7Z/nQHluy
	EOCwr7duv6+G4hoqhZGzW8Vh80YvfFG/ZFl8Ao557Lz/ig61pYihLAYZrTtDl1/ruc5oLjLSZ7P
	aI35wJp6bJAT/azn4xfxs8nhVPcvqxYgPuoPhm9phkSG/oCuBOYMjBxKkbe2vE74jZmIxGhYYYl
	/F+p3G4tj3f+c1Rs0gRu5/X5bfxt9EDykqfiKs/aiwxh3E1HNVucNf/zT7vR2VfEM1lze7B+4Tr
	s7y9m8NEQlnjTV682rnitmZ6xeDvcLmDaGW1jlsVxaLBqwCrpoypODYvo3hYHJDTAsiU/cNEkGY
	teAn9eBt+aGkMmFgw0HtpURf9fhQODReJbSJ7aCMWcbmQfw95vMVsvdUfnRgrBjOd/go=
X-Google-Smtp-Source: AGHT+IHkFxA86Vic3FRZS9v3g0Jv2QIzFdbLVC+dt/QjaYay9DnmcpbYJVADP6V16uigaYjxVgLpkg==
X-Received: by 2002:a05:600c:3152:b0:47a:940a:c972 with SMTP id 5b1f17b1804b1-47d84b18752mr39430665e9.4.1767808180474;
        Wed, 07 Jan 2026 09:49:40 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::5:d4be])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16ffsm11911163f8f.12.2026.01.07.09.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:49:40 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 07 Jan 2026 17:49:08 +0000
Subject: [PATCH RFC v3 06/10] bpf: Add verifier support for bpf_timer
 argument in kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-timer_nolock-v3-6-740d3ec3e5f9@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
In-Reply-To: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767808173; l=4920;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=pbYln8JVIaJRm/60uFGiH2j4vZq8COqms5e5yolFGSI=;
 b=FRoBme5nYrG3zDwk89tfy9YMAx8M9yuaYBrw7rqDocwtnFVEl0VIK8QTux6efOAKrDTNbJHEA
 PwgGATA110PCH88gFqH6HhNDEKv4596xGHfkDDfNLI6KGLvNG7H0rFP
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend the verifier to recognize struct bpf_timer as a valid kfunc
argument type. Previously, bpf_timer was only supported in BPF helpers.

This prepares for adding timer-related kfuncs in subsequent patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9394b0de2ef0085690b0a0052f82cd48d8722e89..f3acd16ccabc81a64cf565ea092419dda6ae3e71 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8569,17 +8569,15 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 }
 
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+			      struct bpf_map *map)
 {
-	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
-	struct bpf_map *map = reg->map_ptr;
 	int err;
 
 	err = check_map_field_pointer(env, regno, BPF_TIMER);
 	if (err)
 		return err;
 
-	if (meta->map_ptr) {
+	if (map) {
 		verifier_bug(env, "Two map pointers in a timer helper");
 		return -EFAULT;
 	}
@@ -8587,8 +8585,36 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
+	return 0;
+}
+
+static int process_timer_helper(struct bpf_verifier_env *env, int regno,
+				struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int err;
+
+	err = process_timer_func(env, regno, meta->map_ptr);
+	if (err)
+		return err;
+
 	meta->map_uid = reg->map_uid;
-	meta->map_ptr = map;
+	meta->map_ptr = reg->map_ptr;
+	return 0;
+}
+
+static int process_timer_kfunc(struct bpf_verifier_env *env, int regno,
+			       struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	int err;
+
+	err = process_timer_func(env, regno, meta->map.ptr);
+	if (err)
+		return err;
+
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = reg->map_ptr;
 	return 0;
 }
 
@@ -9911,7 +9937,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err = process_timer_func(env, regno, meta);
+		err = process_timer_helper(env, regno, meta);
 		if (err)
 			return err;
 		break;
@@ -12164,6 +12190,7 @@ enum {
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
+	KF_ARG_TIMER_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12175,6 +12202,7 @@ BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
+BTF_ID(struct, bpf_timer)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12218,6 +12246,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RB_NODE_ID);
 }
 
+static bool is_kfunc_arg_timer(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TIMER_ID);
+}
+
 static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
 {
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_WORKQUEUE_ID);
@@ -12312,6 +12345,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
+	KF_ARG_PTR_TO_TIMER,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
@@ -12555,6 +12589,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TIMER;
+
 	if (is_kfunc_arg_task_work(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_TASK_WORK;
 
@@ -13334,6 +13371,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_TIMER:
 		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
@@ -13633,6 +13671,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_TIMER:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				return -EINVAL;
+			}
+			ret = process_timer_kfunc(env, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_TASK_WORK:
 			if (reg->type != PTR_TO_MAP_VALUE) {
 				verbose(env, "arg#%d doesn't point to a map value\n", i);

-- 
2.52.0


