Return-Path: <bpf+bounces-13094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A117D45A8
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 04:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC09281807
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2232113;
	Tue, 24 Oct 2023 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WYOyOW20"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFD1FB4
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 02:43:02 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59C10C0
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 19:42:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b9af7d41d2so3322468b3a.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 19:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698115377; x=1698720177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L02A/QBPdumxSIFCiWcS+Xrh/jt5GJRec1Sc9c1VZUY=;
        b=WYOyOW20TI0R1RnasiqjflSHaQ6UY+4+M2DT4EkSlN1t7Otv1vCaZ/4VWonBmhYpZT
         OD+TNZIjEdhU60Wjd4pTVUU3WTYsahrTNRc3gnmJ55gZojQYrPz+uekyQXJOAZ4zsvIY
         pE1sTQ7FQgbvUP3/ipi2Os++I8GzuU1bYB21Cx1xMTJUhUNw7FVrvi8u2ZSKW4Bq2OtT
         GilMRT4UsFdP0zFpfF0Yn+WygB3Kgx573UWF4Ou6RUYz4RHqGxOSmuttTB/ZU3wGIPrE
         hiMjmxJkfNNKoVoHW2w4EepMaUFBefV41x5CGjZTn0/dCJuOFNH8+iasZ3h4H4V2CwtZ
         TIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698115377; x=1698720177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L02A/QBPdumxSIFCiWcS+Xrh/jt5GJRec1Sc9c1VZUY=;
        b=VJlxRFTCAFSAl/ABGPFE0C2hwcN8jZtDG8SHKMmhM8FAm298AfR2nGMx/iHXej/D8b
         D4/UCf5wX3KmweNk638aaktqmpfwP09B7CJQy76QijaViMo9X94C5qtyaGVvznAoI/A1
         s7SV9v1ChfnWn3BTkbgrVmUfxCtCVnceDGWYW+mYv3kPmkHrM5qwpwW2Us5c0hfpxWJO
         hjhnTT4N1EUkzFVHNUeOXRxMCBCQtM4UZoev9sPBodaxQc+8vqqUmjBm/KsX18xkxZYn
         KuERr0d11dSPSvohNMp+txlEvz80MSRMihX5idIrGylOSBTP0k+1OZi5P8qqlbzsFm5h
         wJ6g==
X-Gm-Message-State: AOJu0YyBj5vUyyoUE27sJZ0fQ6VnH+IzHgzgFBR3sl/lgbcD+YVRV0u2
	AwtZ4FbQFtU7t3LrV77IzYvpt1vS5lvNhlXv7lU=
X-Google-Smtp-Source: AGHT+IFTQ3TFtKV5k8tLNg+oIEpp+B9uY6OJllKdj9Fisan9UEWllOoaxmRn0bx0fBxkFRITQdt8cg==
X-Received: by 2002:a05:6a21:193:b0:17b:9b0c:f215 with SMTP id le19-20020a056a21019300b0017b9b0cf215mr1931671pzb.37.1698115377035;
        Mon, 23 Oct 2023 19:42:57 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.70])
        by smtp.gmail.com with ESMTPSA id l15-20020a170903244f00b001c62b9a51a4sm6619539pls.239.2023.10.23.19.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:42:56 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Relax allowlist for css_task iter
Date: Tue, 24 Oct 2023 10:42:39 +0800
Message-Id: <20231024024240.42790-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231024024240.42790-1-zhouchuyi@bytedance.com>
References: <20231024024240.42790-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The newly added open-coded css_task iter would try to hold the global
css_set_lock in bpf_iter_css_task_new, so the bpf side has to be careful in
where it allows to use this iter. The mainly concern is dead locking on
css_set_lock. check_css_task_iter_allowlist() in verifier enforced css_task
can only be used in bpf_lsm hooks and sleepable bpf_iter.

This patch relax the allowlist for css_task iter. Any lsm and any iter
(even non-sleepable) and any sleepable are safe since they would not hold
the css_set_lock before entering BPF progs context.

This patch also fixes the misused BPF_TRACE_ITER in
check_css_task_iter_allowlist which compared bpf_prog_type with
bpf_attach_type.

Fixes: 9c66dc94b62ae ("bpf: Introduce css_task open-coded iterator kfuncs")
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 kernel/bpf/verifier.c                         | 21 ++++++++++++-------
 .../selftests/bpf/progs/iters_task_failure.c  |  4 ++--
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9bc5d4a25a1..9f209adc4ccb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11088,18 +11088,23 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
 						  &meta->arg_rbtree_root.field);
 }
 
+/*
+ * css_task iter allowlist is needed to avoid dead locking on css_set_lock.
+ * LSM hooks and iters (both sleepable and non-sleepable) are safe.
+ * Any sleepable progs are also safe since bpf_check_attach_target() enforce
+ * them can only be attached to some specific hook points.
+ */
 static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
 
-	switch (prog_type) {
-	case BPF_PROG_TYPE_LSM:
+	if (prog_type == BPF_PROG_TYPE_LSM)
 		return true;
-	case BPF_TRACE_ITER:
-		return env->prog->aux->sleepable;
-	default:
-		return false;
-	}
+
+	if (env->prog->expected_attach_type == BPF_TRACE_ITER)
+		return true;
+
+	return env->prog->aux->sleepable;
 }
 
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
@@ -11357,7 +11362,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_ITER:
 			if (meta->func_id == special_kfunc_list[KF_bpf_iter_css_task_new]) {
 				if (!check_css_task_iter_allowlist(env)) {
-					verbose(env, "css_task_iter is only allowed in bpf_lsm and bpf iter-s\n");
+					verbose(env, "css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs\n");
 					return -EINVAL;
 				}
 			}
diff --git a/tools/testing/selftests/bpf/progs/iters_task_failure.c b/tools/testing/selftests/bpf/progs/iters_task_failure.c
index c3bf96a67dba..6b1588d70652 100644
--- a/tools/testing/selftests/bpf/progs/iters_task_failure.c
+++ b/tools/testing/selftests/bpf/progs/iters_task_failure.c
@@ -84,8 +84,8 @@ int BPF_PROG(iter_css_lock_and_unlock)
 	return 0;
 }
 
-SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
-__failure __msg("css_task_iter is only allowed in bpf_lsm and bpf iter-s")
+SEC("?fentry/" SYS_PREFIX "sys_getpgid")
+__failure __msg("css_task_iter is only allowed in bpf_lsm, bpf_iter and sleepable progs")
 int BPF_PROG(iter_css_task_for_each)
 {
 	u64 cg_id = bpf_get_current_cgroup_id();
-- 
2.20.1


