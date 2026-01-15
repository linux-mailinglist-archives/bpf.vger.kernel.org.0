Return-Path: <bpf+bounces-79114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E6CD27B3A
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A557630908C4
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E23D1CBB;
	Thu, 15 Jan 2026 18:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUGRjxT1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB63D1CAA
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501754; cv=none; b=DygGiOmbCzf+hQRxKsJUJCPJaGhqaLEPKOQ+OUmdz6yOOneNz7rR7F+oQGfpVGYZS1vH1bfrdgOrvt8h95/Zc12B+b7x6IRjrK0xhHDe8ueicw3g3X+CZZyzFN0q4QdoC/Nc7+8zhif4ndLQ6i4YJsY+24xGoTHfJuM5KboQyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501754; c=relaxed/simple;
	bh=JgnsAaPOFybCPl4u0eC0Rkb2xyxN+/FdvWFrIDGIHNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W980ODPhrQv8TWKY9ZvVNSV92Ho2aLDk74gyjLeyVAO2E+1SG8qd3skzQBsgl0sLhoUUmqh1eATDivBWSc2fV3LOmU4jEkdOcdBYuB6TFAz2927h5i3Y3H7mfVN1EvfLr5zEfuD5smS63dcDrBboEJi1V6YFPbt82maOVBMhZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUGRjxT1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee974e230so11608815e9.2
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501751; x=1769106551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDKW4myo8R4Zh/Nlsw2MYWNYtcg5d/vdYq16IXmYqis=;
        b=mUGRjxT10Fpn1hVB0wbNMKY07o2uhf0vsw5vW9ypWPpXKkjQmQBjmmDssXJ8vh53y2
         l3BisH7k05hWPCVyF8/zWSOdNPJ7OlIdXqvNJF4KMt7UR6WE+jKwJ+Fc2oiGgmzZlRu2
         8RAUydZ1OdmluUplVnGzOYLDPAKp/wXsNN88b6eTuHoAe08JT7IEYgt96RENEDsJZAPR
         /wjO3Wmnt1OMsAVjj0dPt4SKfcO3te2ttbqYMur5ASSordlLM0Nlp0o50RrOgl82IgTT
         BcIevihnL18ahWNtzraa4RUrTZCs2Dw+BFqTansjUSH3c8K5RqiVqnKiyCg9LJGqQFdd
         YCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501751; x=1769106551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KDKW4myo8R4Zh/Nlsw2MYWNYtcg5d/vdYq16IXmYqis=;
        b=Bm6HxkNLKo82xfQP4hEB3nNjxvDGNjcp4CpBpWClDZvdvDkKWcxlynlmn4d7EUGeIw
         H9w6ZzE/eesy5VquT/3t3Tmm/6O1gPHqQmFJYAVRYsJSU+panDWphUdm1jYqbYnjg3lp
         f2IjCO6tKpxdYDMBbPZsKuc/fGD3cdC34DWiOucu9nCA8paK235yXG6nyUmFBLYhtPLN
         g1/HixyMLCKbPW9l5qWrhsNV0qSpTMv1vXcmHsip0Va8Iy9wLHdd25WUkIhclYMDvwLo
         CoiQmDKXyqirNIDfNPK4Y9//oCgIJ6friuuGLAh4kMa/9xk46/uUSnShJyy1ifbizMRB
         BYGA==
X-Gm-Message-State: AOJu0YyT35MYvo7ORJh70fPTpyDWFcJ7VbaTxGOpWIkE8mYAuKtPt1Za
	qkrd17eewvaJ3GS3PqtM1Bowx4Fn9KofFE6bh7UdAgCnAC0kjV/lFYPTUuFKLA==
X-Gm-Gg: AY/fxX52H0PSfgnOE61ODyfgNSbo0MBMU+e25PFV2EsVV2weua6rNJIDNr2ocAN9c9k
	QU3woB77V42PNEWaXFjZqQz/saFZTuJ/i9nMbTkz67+WD6CuA18wIfQVWvQMRcl+q+AJHakYQ/w
	guJv86GJ8tDm+APDS3APeKL/FAqIGzFnjbdMZ003GdHaL+fn+HxO2N/ZRq1z1+hzs1J6DR1z/kr
	8HBIPvtvzDy4Z+ciHyDi+cPHYCgDvODGVqkx2ItL8yjNYbEZmmHhCvq5cPJWcUYST05sLEUvgEM
	LJKkGePrZr0uBrBIWPKbC44d0FMC6DK9q0z2HxjLoY7+MRUW48XZDiATGOLG+yxDWcO2//WsCe6
	1eu+5UC4K/sPhTWBs0Nb77N0TQN5lJwSl74rijZ31UovfjBtZZ60qGdfv4368OKLaePwmSouK06
	Ns
X-Received: by 2002:a05:600c:8716:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-4801e308df6mr8676815e9.9.1768501750648;
        Thu, 15 Jan 2026 10:29:10 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6cdsm426595f8f.31.2026.01.15.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:29:10 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 15 Jan 2026 18:27:53 +0000
Subject: [PATCH RFC v5 06/10] bpf: Add verifier support for bpf_timer
 argument in kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-timer_nolock-v5-6-15e3aef2703d@meta.com>
References: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
In-Reply-To: <20260115-timer_nolock-v5-0-15e3aef2703d@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768501743; l=4925;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=3VzXyigSSTG7rKiuwiJXkMM/fTynDoTJDmMAnJFZ+RI=;
 b=Gi2Y/BjbYDUbBE2okLafOW8nX23V79VT9XhrbfvSpMfwdQ7Qa1p3wtlMYTv1Dk6BJc1AS6t53
 yRnEB6j2wf3DpdlqMedyc3dvzC6HLASCbRkM+X6dCAALZYKBYHspNJH
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Extend the verifier to recognize struct bpf_timer as a valid kfunc
argument type. Previously, bpf_timer was only supported in BPF helpers.

This prepares for adding timer-related kfuncs in subsequent patches.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index faa1ecc1fe9d753325ac6b8c255c8885a77102d4..98cb8be76eb5da878b0e391cf52e20a8dd6f9b24 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8566,17 +8566,15 @@ static int check_map_field_pointer(struct bpf_verifier_env *env, u32 regno,
 }
 
 static int process_timer_func(struct bpf_verifier_env *env, int regno,
-			      struct bpf_call_arg_meta *meta)
+			      struct bpf_map *map)
 {
-	struct bpf_reg_state *reg = reg_state(env, regno);
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
@@ -8584,8 +8582,36 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
 		verbose(env, "bpf_timer cannot be used for PREEMPT_RT.\n");
 		return -EOPNOTSUPP;
 	}
+	return 0;
+}
+
+static int process_timer_helper(struct bpf_verifier_env *env, int regno,
+				struct bpf_call_arg_meta *meta)
+{
+	struct bpf_reg_state *reg = reg_state(env, regno);
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
+	struct bpf_reg_state *reg = reg_state(env, regno);
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
 
@@ -9908,7 +9934,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		}
 		break;
 	case ARG_PTR_TO_TIMER:
-		err = process_timer_func(env, regno, meta);
+		err = process_timer_helper(env, regno, meta);
 		if (err)
 			return err;
 		break;
@@ -12161,6 +12187,7 @@ enum {
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
 	KF_ARG_TASK_WORK_ID,
+	KF_ARG_TIMER_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12172,6 +12199,7 @@ BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
 BTF_ID(struct, bpf_task_work)
+BTF_ID(struct, bpf_timer)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12215,6 +12243,11 @@ static bool is_kfunc_arg_rbtree_node(const struct btf *btf, const struct btf_par
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
@@ -12309,6 +12342,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_NULL,
 	KF_ARG_PTR_TO_CONST_STR,
 	KF_ARG_PTR_TO_MAP,
+	KF_ARG_PTR_TO_TIMER,
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
@@ -12554,6 +12588,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_timer(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TIMER;
+
 	if (is_kfunc_arg_task_work(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_TASK_WORK;
 
@@ -13340,6 +13377,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_TIMER:
 		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
@@ -13639,6 +13677,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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


