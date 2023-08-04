Return-Path: <bpf+bounces-6978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF1C76FD80
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 11:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627782825B3
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D77A958;
	Fri,  4 Aug 2023 09:38:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D1A94C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 09:38:24 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E40F30EB
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 02:38:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686bea20652so1785883b3a.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691141902; x=1691746702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnVxinOLSDbVFQcoUFkv5fif4kt7MH5yiiDW0k4Isz4=;
        b=SnYq7pN1xKt+8a/z1C+XFiuu2Ak1e5y+1Mhw4KDi+FAv5ci79AUGSFoPX+kdGaVg+F
         ljIZlgKY99++RUbA5xeIKLBsHHuwqQptGQ6yHf0MZ+5awXqsZx8LSY7v2Jeb702P0gGy
         aSNqUTc0vxHv3ZjhTdhYeX04dsH34jOpByFF8IwXYFZXrLOqi/Y1A0nxMr48P2Mked+W
         lRhz4HZu79RK7uZdHXLNBgFvOnMSLWkjTr8zn1WtUyr6KDzyoSKWOQMC6Rzh/DpUgiOJ
         HwIl5c3AZ3RSsOFH/IRN44JBRMBmMiVnj4F2MzK87P7LwMhl5vt40rFY7T6HqGGit5ae
         fJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141902; x=1691746702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnVxinOLSDbVFQcoUFkv5fif4kt7MH5yiiDW0k4Isz4=;
        b=kVII9/xiYgVXOacGTCXOKylw7XEJV8p0Ub8sF+dLpN1OElNzc+uQTw477gtjY+StT6
         kz/2LMlPIyiabOpnEJ7DPFKhO50hv8b0MYlKFYsyH6+Z6/Sk/wAx58Ps6tLb5t4T4qZP
         NrPYtp+LQ7ROvPLtg3UCcDOD9plh5xF7E5rERMtR0CJ+ykRVrf3Q2ncFJkn47RJOc0bU
         gIb+0PdLtTqxHMl/J865HAsEAKLQ4iHdR4ILDVF8vQUCsJkuyYVy8V/qFKOO/2SLK/c8
         GmuvhqmZ90cVlbtx5uzGBWpGy/0vF4vWp2lSMkTkB+qS2ZEr4TbAKX6oifyi8kerJ5Qo
         XIHQ==
X-Gm-Message-State: AOJu0Yyygf7+fhKOKy/oQwB2uwRVMlIK6Csjj2lsRCrnIXzpVpHJx+Dh
	cgJ6EvUZKtFdv1lI/b0e/oH05SteOHR7EQOuKsU=
X-Google-Smtp-Source: AGHT+IGEaGrIQSMdjLRn7q18dfEfbuGihr94UXKQ14pGWU3sdMqgmFT3kieIlgr3NWLWA4FqGTqF2Q==
X-Received: by 2002:a05:6a21:789a:b0:133:7276:324b with SMTP id bf26-20020a056a21789a00b001337276324bmr1346719pzc.23.1691141902614;
        Fri, 04 Aug 2023 02:38:22 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id c23-20020aa78817000000b00687933946ddsm1214837pfo.23.2023.08.04.02.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:38:22 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	muchun.song@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 1/2] mm, oom: Introduce bpf_select_task
Date: Fri,  4 Aug 2023 17:38:03 +0800
Message-Id: <20230804093804.47039-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230804093804.47039-1-zhouchuyi@bytedance.com>
References: <20230804093804.47039-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new hook bpf_select_task in oom_evaluate_task. It
takes oc and current iterating task as parameters and returns a result
indicating which one is selected by bpf program.

Although bpf_select_task is used to bypass the default method, there are
some existing rules should be obeyed. Specifically, we skip these
"unkillable" tasks(e.g., kthread, MMF_OOM_SKIP, in_vfork()).So we do not
consider tasks with lowest score returned by oom_badness except it was
caused by OOM_SCORE_ADJ_MIN.

If we attach a prog to the hook, the interface is enabled only when we have
successfully chosen at least one valid candidate in previous iteraion. This
is to avoid that we find nothing if bpf program rejects all tasks.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 mm/oom_kill.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 612b5597d3af..aec4c55ed49a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -18,6 +18,7 @@
  *  kernel subsystems and hints as to where to find out what things do.
  */
 
+#include <linux/bpf.h>
 #include <linux/oom.h>
 #include <linux/mm.h>
 #include <linux/err.h>
@@ -210,6 +211,16 @@ long oom_badness(struct task_struct *p, unsigned long totalpages)
 	if (!p)
 		return LONG_MIN;
 
+	/*
+	 * If task is allocating a lot of memory and has been marked to be
+	 * killed first if it triggers an oom, then set points to LONG_MAX.
+	 * It will be selected unless we keep oc->chosen through bpf interface.
+	 */
+	if (oom_task_origin(p)) {
+		task_unlock(p);
+		return LONG_MAX;
+	}
+
 	/*
 	 * Do not even consider tasks which are explicitly marked oom
 	 * unkillable or have been already oom reaped or the are in
@@ -305,8 +316,30 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	return CONSTRAINT_NONE;
 }
 
+enum bpf_select_ret {
+	BPF_SELECT_DISABLE,
+	BPF_SELECT_TASK,
+	BPF_SELECT_CHOSEN,
+};
+
+__weak noinline int bpf_select_task(struct oom_control *oc,
+				struct task_struct *task, long badness_points)
+{
+	return BPF_SELECT_DISABLE;
+}
+
+BTF_SET8_START(oom_bpf_fmodret_ids)
+BTF_ID_FLAGS(func, bpf_select_task)
+BTF_SET8_END(oom_bpf_fmodret_ids)
+
+static const struct btf_kfunc_id_set oom_bpf_fmodret_set = {
+	.owner = THIS_MODULE,
+	.set   = &oom_bpf_fmodret_ids,
+};
+
 static int oom_evaluate_task(struct task_struct *task, void *arg)
 {
+	enum bpf_select_ret bpf_ret = BPF_SELECT_DISABLE;
 	struct oom_control *oc = arg;
 	long points;
 
@@ -329,17 +362,23 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto abort;
 	}
 
+	points = oom_badness(task, oc->totalpages);
+
 	/*
-	 * If task is allocating a lot of memory and has been marked to be
-	 * killed first if it triggers an oom, then select it.
+	 * Do not consider tasks with lowest score value except it was caused
+	 * by OOM_SCORE_ADJ_MIN. Give these tasks a chance to be selected by
+	 * bpf interface.
 	 */
-	if (oom_task_origin(task)) {
-		points = LONG_MAX;
+	if (points == LONG_MIN && task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN)
+		goto next;
+
+	if (oc->chosen)
+		bpf_ret = bpf_select_task(oc, task, points);
+
+	if (bpf_ret == BPF_SELECT_TASK)
 		goto select;
-	}
 
-	points = oom_badness(task, oc->totalpages);
-	if (points == LONG_MIN || points < oc->chosen_points)
+	if (bpf_ret == BPF_SELECT_CHOSEN || points == LONG_MIN || points < oc->chosen_points)
 		goto next;
 
 select:
@@ -732,10 +771,14 @@ static struct ctl_table vm_oom_kill_table[] = {
 
 static int __init oom_init(void)
 {
+	int err;
 	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
 #ifdef CONFIG_SYSCTL
 	register_sysctl_init("vm", vm_oom_kill_table);
 #endif
+	err = register_btf_fmodret_id_set(&oom_bpf_fmodret_set);
+	if (err)
+		pr_warn("error while registering oom fmodret entrypoints: %d", err);
 	return 0;
 }
 subsys_initcall(oom_init)
-- 
2.20.1


