Return-Path: <bpf+bounces-12945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95D47D239A
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F5E2815CA
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E610950;
	Sun, 22 Oct 2023 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EhuJOH9a"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2093D6B
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 15:45:43 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8904DB4
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 08:45:41 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5ad5178d1bfso1799881a12.2
        for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697989541; x=1698594341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GGyfh+aKWvGCG4k2jaPd37bFIq+IpE0RtBXZgW8v20=;
        b=EhuJOH9aptDiVYftAuJmORpJPgrzDefiSs5HtTUMtmCiTA3MXrglEJ34XcZX2OUg+I
         7S1KNHaAlD7WWYpwEEVWAlbsefFrrOK3CKh0qA4WJ4YTOcYSwh85AaF4/va3Rs6uX4cc
         rSwV59GgWWGaE7EqLzes75NcDrBdy+ox/9rmvnJe8ZtDzaBaRDMXjuZ7D8bt09EpAShV
         NwY37oMka9/JOyk3Vyoc0oNtZGayXIShHD0e78pzQiaGuHrsKMAQW3/i3V+PTqBw6Kbd
         E0x4L5d/4dmervMnqcMhh7ag+YqqCTSvwHuDkZd9xiuAn5n9Ngt/9n9QJKDhFhBeK/RU
         j8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697989541; x=1698594341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GGyfh+aKWvGCG4k2jaPd37bFIq+IpE0RtBXZgW8v20=;
        b=iF0ZZgzUvrGmjx4VPI1/U10pw0T4BwHNZfFKsBkEM+Z6TCatdvl+gUwqPZkuIvAagJ
         tsq3viM6Ldjobmts/K6ZB69RWXdLDTG/Vh92vQKFX4bsIZSDa2i8CoQgR8Ts8nStR1Zh
         QsyYdcU0WKuDY6lRrxpDAuss3jHHAvEnvz9HB8cqcMZDI5ofoFceYZzYQpAuJFglh/KD
         7/q4pg5zmrV7Fr/+0ZATNQt/5nxbglA/6WpTZ7Z6jDAwRlY9U3RipW6hwUQTr1RUm2SX
         h/n4nZD28/2r7jz0KUDDfPqbtmutNJBMfMd8SJUzoFmPrTrjVrehlRefxaouy4EwUA80
         2DRQ==
X-Gm-Message-State: AOJu0YyWaw22jwv8BBwPeUA4euEhzjm7GVUJNs/cHgHH/Y9hJ/QB64HI
	RWJdQkuc0LwsSubZ9bOQWoOtRtUocWJLkDhObfudJw==
X-Google-Smtp-Source: AGHT+IGKMEs4q9CS5ZZrpi1jgS9Yq1U9mCk7eBuxH0i1DXmeNOFq4B7xceyPETqz5tNmaxQF0Q+xsw==
X-Received: by 2002:a17:902:eb8e:b0:1c9:cc88:502c with SMTP id q14-20020a170902eb8e00b001c9cc88502cmr8897886plg.69.1697989540897;
        Sun, 22 Oct 2023 08:45:40 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.49.4])
        by smtp.gmail.com with ESMTPSA id l2-20020a170902d34200b001bbdd44bbb6sm4551996plk.136.2023.10.22.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 08:45:40 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next 1/2] bpf: Relax allowlist for css_task iter
Date: Sun, 22 Oct 2023 23:45:26 +0800
Message-Id: <20231022154527.229117-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231022154527.229117-1-zhouchuyi@bytedance.com>
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
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
 kernel/bpf/verifier.c                             | 15 ++++++++++-----
 .../selftests/bpf/progs/iters_task_failure.c      |  4 ++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9bc5d4a25a1..cc79cd555337 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11088,17 +11088,22 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
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
-
 	switch (prog_type) {
 	case BPF_PROG_TYPE_LSM:
 		return true;
-	case BPF_TRACE_ITER:
-		return env->prog->aux->sleepable;
+	case BPF_PROG_TYPE_TRACING:
+		return env->prog->expected_attach_type == BPF_TRACE_ITER;
 	default:
-		return false;
+		return env->prog->aux->sleepable;
 	}
 }
 
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


