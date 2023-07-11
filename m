Return-Path: <bpf+bounces-4670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE6174E328
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB501C20C75
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8891845;
	Tue, 11 Jul 2023 01:14:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC617D3
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:14:35 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B04E77;
	Mon, 10 Jul 2023 18:14:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a04e5baffcso4221946b6e.3;
        Mon, 10 Jul 2023 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038070; x=1691630070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iisu0eogwyT+XXqvCDr4lGty2Pch5Ifq4UOrbO8zY3o=;
        b=o9/eDCJ410gkR18bZeg9M9uWieax/FIrM7WNdrRsd/DAQlVlUGOJtAjwaGFyklZllq
         BVpFUGz3XBK9p9g7NKKoXyDwqpqIAaZw7HUnc/AOUgGwhKnsGrdA2MDgdfbztSeh9eHt
         htGPIbY0zwnQfI/JjXhQu5njYYRJpPDDeDrO2RJfe09xvFT3xvAtpd+6DYaRK/uTf7HV
         +tD4WAHx5CLdCZGR5KCkN1ZPRtQnGfR8sf8Uwj11D/srNgsi+VRk3vCTv6a+DYQgrFXM
         1Ejq5EfVR79h4dBM/zFvY0kDShfWKmjRrliiWZiE6FxkR4BkMbgujdhek4bD9Uk6OV+V
         B4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038070; x=1691630070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iisu0eogwyT+XXqvCDr4lGty2Pch5Ifq4UOrbO8zY3o=;
        b=Um7PQ9HaXG3brTF0rOmbUi9wKYnNikxWNfN71cUd2EPvG5FtHGpPq6T4oUgk0481Mg
         vTEQP9+V/69Q8iYYHHbR5uJbylUjW9RSePEt03uzHE+PTouYpaBp5GFUrZgY4zduaVon
         ktMNslaH6IMsPhmBqQDC0umcqPxHQr2bE5DSYN0EPLz1Rhi8jhkWE/J6u6YYkWBbMWSZ
         wfxS/LEcIXr9dx8Re78K+ekfDWvWJiJe9e6dNAHyOWATHIByQbQCirhrWjIzD40XNJOo
         SqFYk3gX0dAgLkpnWWyzjYxLa8v1SlPnKc+8uImwzWaU8ViCMlQrk9V1qbWod4B4nlUi
         BU/w==
X-Gm-Message-State: ABy/qLZ9JPU+W+WExt8TpKl1g5iMrlSsgQd2NW3qsHBAOeZv2HbiN/se
	HV1Et+UAyfV5ct8jsLPXGig=
X-Google-Smtp-Source: APBJJlG48qxJ723Jh4qH1HeVCtD2aPMz2RvLwVgOTIA9s3QZChuSGPQ6tyKGYa6CmbDXOMK0AqCatw==
X-Received: by 2002:a05:6808:138c:b0:3a3:9463:ccbf with SMTP id c12-20020a056808138c00b003a39463ccbfmr16743837oiw.15.1689038070048;
        Mon, 10 Jul 2023 18:14:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id fe23-20020a056a002f1700b0066ebaeb149dsm403103pfb.88.2023.07.10.18.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 07/34] sched: Expose css_tg() and __setscheduler_prio()
Date: Mon, 10 Jul 2023 15:13:25 -1000
Message-ID: <20230711011412.100319-8-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These will be used by a new BPF extensible sched_class.

css_tg() will be used in the init and exit paths to visit all task_groups by
walking cgroups.

__setscheduler_prio() is used to pick the sched_class matching the current
prio of the task. For the new BPF extensible sched_class, the mapping from
the task configuration to sched_class isn't static and depends on a few
factors - e.g. whether the BPF progs implementing the scheduler are loaded
and in a serviceable state. That mapping logic will be added to
__setscheduler_prio().

When the BPF scheduler progs get loaded and unloaded, the mapping changes
and the new sched_class will walk the tasks applying the new mapping using
__setscheduler_prio().

v3: Dropped SCHED_CHANGE_BLOCK() as upstream is adding more generic cleanup
    mechanism.

v2: Expose SCHED_CHANGE_BLOCK() too and update the description.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 kernel/sched/core.c  | 7 +------
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 00d6751b0f8d..6818ed1a7a42 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7011,7 +7011,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-static void __setscheduler_prio(struct task_struct *p, int prio)
+void __setscheduler_prio(struct task_struct *p, int prio)
 {
 	if (dl_prio(prio))
 		p->sched_class = &dl_sched_class;
@@ -10523,11 +10523,6 @@ void sched_move_task(struct task_struct *tsk)
 	task_rq_unlock(rq, tsk, &rf);
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2eb5759f4be9..71343472e6b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -469,6 +469,11 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 	return walk_tg_tree_from(&root_task_group, down, up, data);
 }
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 extern int tg_nop(struct task_group *tg, void *data);
 
 extern void free_fair_sched_group(struct task_group *tg);
@@ -2390,6 +2395,8 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
+extern void __setscheduler_prio(struct task_struct *p, int prio);
+
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.41.0


