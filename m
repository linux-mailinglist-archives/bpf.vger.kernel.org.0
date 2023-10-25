Return-Path: <bpf+bounces-13215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D933A7D6450
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 10:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DEE281C91
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09981C68B;
	Wed, 25 Oct 2023 08:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c63pA3MJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E71C2BA
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 08:00:23 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5902C10E
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 01:00:22 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b2e72fe47fso3592068b6e.1
        for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698220821; x=1698825621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=623dJ/e0dl/9VZB/F0AUPvisvbBwnO9eeoKfg40DawY=;
        b=c63pA3MJG1VO2lYZk8GDp+mZCt1iE8qhQ5+IB54LTPEf0f/k4Sms99qsgZHDegM3U8
         KTH9mYiN73PzC2cswq1qZnVq9OHwJLgV36A8usJRNvaNQ1Ivm3FcKUCTOH6gEicgtRfa
         o4pZuOuXs/7lzH6imA8D/J+/jLiw50A1m3856GkumU719qGHD0n4meBCHzYxJFrYwF1B
         ktkMEuSXuL65oXLgd199xPhdFUdaj5tbVxNj2uorIlTu4xh/p8Sij6xDZCfUFrlA++mV
         tG+hc5wL/tSA5CSWxyRgZ+NWrfz0AVbiSEcZnbBJ0Ne1ixzeYv2Zn+MnI6SMxexFHZQb
         sraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698220821; x=1698825621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=623dJ/e0dl/9VZB/F0AUPvisvbBwnO9eeoKfg40DawY=;
        b=t4GnpcLZglCTkKR+FdZSEznlb82EUbLFUW+YOYrkKUzDnm9Cf8mXjwHGd8aGyipZMf
         L3maEWN6VMrcFm8saYZ2f//xqgPxGZonf2cJIRzOa2mytZV2mzwqP/HkqQbSYfMJVZ06
         bKwaYNY6BSzOybqQNP8UrUqi2Xue5KIFULX+GE/uxBKpDrwQiTMN7aC+DzkOCr2CmtyM
         /nh4HUIEDbiMInVcyXZCLvDYsEm09K9Nk8FoMpFyazKMREfgH4F2yzz8tPy8WIOZ1R+N
         tla+XiR7L9R3s4xUtuPJPZUSmRf7IWWrJ+jVA39NnknkJ/vtpHawivqTXxXaFydgVtim
         GX6g==
X-Gm-Message-State: AOJu0YxmNczC9wDcc4N7C18F1T4gkxEdv95tcOpQ1ansfHV+G8ua62Qh
	GCK2UpycVd1FRHgThwH1Wwb5xRUfgq4B1PJYbPg=
X-Google-Smtp-Source: AGHT+IFNrJ6aGXsfBcfq42K58SlpCq4ESlrfgv2CoCJH4pDIc90B4PFXLHn+X0N/+cKUV52sXWfNgA==
X-Received: by 2002:a05:6808:3ce:b0:3ae:55e5:43b6 with SMTP id o14-20020a05680803ce00b003ae55e543b6mr13588579oie.48.1698220821013;
        Wed, 25 Oct 2023 01:00:21 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id 23-20020a630f57000000b0059cc2f1b7basm8118187pgp.11.2023.10.25.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:00:20 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 1/3] bpf: Relax allowlist for css_task iter
Date: Wed, 25 Oct 2023 15:59:12 +0800
Message-Id: <20231025075914.30979-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231025075914.30979-1-zhouchuyi@bytedance.com>
References: <20231025075914.30979-1-zhouchuyi@bytedance.com>
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
 kernel/bpf/verifier.c                            | 16 ++++++++++++----
 .../selftests/bpf/progs/iters_task_failure.c     |  4 ++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9bc5d4a25a1..9243b6ca4854 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11088,6 +11088,12 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
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
@@ -11095,10 +11101,12 @@ static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
 	switch (prog_type) {
 	case BPF_PROG_TYPE_LSM:
 		return true;
-	case BPF_TRACE_ITER:
-		return env->prog->aux->sleepable;
+	case BPF_PROG_TYPE_TRACING:
+		if (env->prog->expected_attach_type == BPF_TRACE_ITER)
+			return true;
+		fallthrough;
 	default:
-		return false;
+		return env->prog->aux->sleepable;
 	}
 }
 
@@ -11357,7 +11365,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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


