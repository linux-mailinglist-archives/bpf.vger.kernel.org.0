Return-Path: <bpf+bounces-78945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA9D20C65
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C62BB301869C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D4336EC9;
	Wed, 14 Jan 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry3jbkGI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D2336ECB
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 18:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414991; cv=none; b=Wz782kS6neEdGUGskZtZafr8yxAH7uxgMu4KZ2Qk44yxDHK0zwkjE7vSXS6iqEJkf78zBujQ4ZAhPeA/4GXSxDaTYN60zLL7VDzPgvQtC+cfDoYu9L2+C38iJnMDEqEpFHYhOJcz+x1n4gFRHOPTP0Vj37neaoDgONhKjnlX/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414991; c=relaxed/simple;
	bh=JgnsAaPOFybCPl4u0eC0Rkb2xyxN+/FdvWFrIDGIHNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbtRFwUEBgGmHBbl/HC3VVqA4GX+cv1qNvxMfpqTpx65o+4VSr+QlwRp/yiL3XIpQEH3UcS0/w3QApqaB3EKF7IMw3xfFDaKuS99MIA1jJ3wyVKnusoy/p52azGCmZaMVcxg10sOXP1ziQvQRn81B9uSE+Hz9cTeThnwZRPRVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ry3jbkGI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so1010545e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 10:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414988; x=1769019788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDKW4myo8R4Zh/Nlsw2MYWNYtcg5d/vdYq16IXmYqis=;
        b=Ry3jbkGI5GBXRGSIUrBN9KNI4l6EyB838zx0AOmsxLX2ddBdZkhYAw5UqSVNoPzL7H
         GFr1ECOQx+H2Q6s58MJhMKvCYM83m2kJkwrk/OWcFs3Gxf9GG/6iik7Taa+RM88C1/KP
         rMLpXVDqXUnmZZaPRr3OZTSNhS2vCUIv9/rDgZWdNZ5MB1XLiNnvKfv6CgxZtBWuqotn
         S0W2Hm9IS+6p80aXbkaOVDToLZ1nK2BDak4YofvBmOFJj8xEjqxTilba/dPzntIk1O8c
         m8AdwXcpi8nAtu4LFKxov534D3n0mZv54X/TZIDLgD9fNHggNA+KXl7U+ItbGSqyvXO2
         9YUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414988; x=1769019788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KDKW4myo8R4Zh/Nlsw2MYWNYtcg5d/vdYq16IXmYqis=;
        b=ZnoBZhkumD1VSnp2LEMZvvwoVgcqklFnQsM1K+Ssjl0W9oHfUJB+KZ5YFuNtmkUn5H
         cec4wWoT9GYw1xsR0JNOH3enV345JaxRHm7Y+o8/0NC4E5pLGJlkSadXh+1F43krS/iT
         In/mRmqm2KwgoW4MZsEMd+A909txetkDJLt2c0Hsyj9i1j/Gnw+NNcPuLUlhatjmIzIa
         JGyk4P1DNQhk8hCPjxQjtD+AtxsRma2ZspCFEBamklLl9KKglYgDbWDuAJvUNXwZrVHC
         Jv4BZjretS6kyw5xh2/B3ri8J6NmuXYf8pHG1+BCK7812KubBcp+Kt+KDd5pRlgjIqw5
         UXrg==
X-Gm-Message-State: AOJu0Yz/419S0WLPWjNLJlkvV4XXHZ+gp6csXhtl0FjMnTBpP8yHE5Sq
	NLZkE/ktBx/QXMcKHCq/LZLDfAk1sp3EKHAiB9bpCOAIR6jSDfVXb5r8
X-Gm-Gg: AY/fxX6cUoXdi2M50u2V0YzgETFDwnPo26zEZ3DAPWoi/deyp1ytij25qa8SdUg4AMO
	kst50TV+pFoV9zFybYYk33nHVZz42oLcPWrRidsxmZ+JSeLUc0Hlh1V/Kq9dw2T5X80JCl/BbDh
	tDqqXzpBgFM0DjSY0Ip0/S5RMSEZUrdpcnuZJ3/YmBQ3U0HtWwF3uhzHs8JJSraWAELpD5tvDvr
	oWU1lMsieNNV7SzeKZbhs38O7FmmvM+iY4TbUVd530R90FrkEkvJm/TbQdn5vKyKr/gv0QyH11j
	8zM9uyvgycXd1KIqizO/Zj/c2JM4LgQxG8GBg+pPai/o4llhLlk2nkmvXJpT5D3iMSB22jpiFtn
	hUuie2LcQdRtav0O0yn4THMlCvhW1v2i6K6v7/KkUdh1EtXUXRTny3VmlG/Fr2vZgVhczz+zyQA
	KO9Vk/U4yFlA==
X-Received: by 2002:a05:600c:3e8d:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-47ee33a1907mr42706535e9.29.1768414988338;
        Wed, 14 Jan 2026 10:23:08 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee283fdcesm24338525e9.15.2026.01.14.10.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:23:08 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 14 Jan 2026 18:22:48 +0000
Subject: [PATCH RFC v4 4/8] bpf: Add verifier support for bpf_timer
 argument in kfuncs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-timer_nolock-v4-4-fa6355f51fa7@meta.com>
References: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
In-Reply-To: <20260114-timer_nolock-v4-0-fa6355f51fa7@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768414982; l=4925;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=3VzXyigSSTG7rKiuwiJXkMM/fTynDoTJDmMAnJFZ+RI=;
 b=cmJQ0atKwV9BHx5sbLA6f5frAgObXPijJpANPpDWCEaDhdP0Y8cVKXeti+n1bU5A7J+2ovEdx
 OXjGG1EjQMUBOm6JpGUHiv9aJVqXYtWtl5GKTFZtxycQglGV7s6ETtH
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


