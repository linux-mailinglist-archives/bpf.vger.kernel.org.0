Return-Path: <bpf+bounces-4667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C31074E320
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA392281573
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DC617C7;
	Tue, 11 Jul 2023 01:14:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7510F7
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:14:25 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001B1B0;
	Mon, 10 Jul 2023 18:14:24 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666ed230c81so4464996b3a.0;
        Mon, 10 Jul 2023 18:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038064; x=1691630064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qqr4oQDNxltvI38EA+ZVKZsvODn4QRxrH7E17Te6mac=;
        b=N48bd6Wy3fhk8uHORVXcSzA/1KQHwpGX/ipVJtm/b1sxo9BQ8o6dgGqKm0MT2Qy/vP
         2ErezF8AbifScarmDjw725vpQ8cgsluy/JxVG1UADs1bKu7sZsGft68DEIwTHHlbOSb2
         kEDvRe010oRO/r1RBZKuWPk+1WP+dzmYsuUiCKSnzdhvIlRy/owmE0fwh9fQO3D6vEbE
         +Rqq3eRdo4PR+QQKyCUivkFWLPak0zFQTomk0gDt0CeOUiI2PkGCV2T3jfzJGnk4gufY
         Nygwunk4NvAYmPYc4pSESZeyzyhongKZvENQ3QtaXIZQXavmnC5eM//iUJwuJYcx5Kv0
         7ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038064; x=1691630064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qqr4oQDNxltvI38EA+ZVKZsvODn4QRxrH7E17Te6mac=;
        b=gbHGxmPk/dFqNwZBx9zOeveO5ySl/MyqBY8Hp3C+6C1k4c2iF7ooQn9Ok8vtGWj81+
         J2DhuZqAQQTM/ZR1c96BjAte5Al+n1UbMm1on/KBCl0tJDkBwiUyxnCJ8NHYzTTCmcis
         yqsh5m88kVmtC3oXgRToIutaQtiq+JoPOeL5/MV0s9rxs1IIfF9/Fk+/oaJ0coeOt4bP
         ikastvdAfW1bHy6fMfGL5DjGlY5BdxcVl1bJ4fMa1XXHbXWm9cZcxdz9+G2laLwzwuy2
         beMAA/Ry1iyOXhWUWu9lMn48I6ucgJsaNAX/5Q4Hwp7bbgknvcnRSITEQRgTup/qGUvc
         q5Bw==
X-Gm-Message-State: ABy/qLZoKZ9C8/5OXGp0jbPRucVTcp6ErK2hHCHazYZCHzGfdYzDCSfi
	32i6wRocmlP8nddUZ7GACSQ=
X-Google-Smtp-Source: APBJJlF2ZhaCyYNMYRD6xUA3dctpUrLGuaMSj5iKoJMPUryH2WJyXyyXQPku7++wxhCMl0Yd+62nhA==
X-Received: by 2002:a05:6a00:148f:b0:682:4c9f:aa0 with SMTP id v15-20020a056a00148f00b006824c9f0aa0mr16105877pfu.29.1689038064027;
        Mon, 10 Jul 2023 18:14:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id f14-20020aa782ce000000b00682aac1e2b8sm408082pfn.60.2023.07.10.18.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:23 -0700 (PDT)
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
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/34] sched: Add sched_class->reweight_task()
Date: Mon, 10 Jul 2023 15:13:22 -1000
Message-ID: <20230711011412.100319-5-tj@kernel.org>
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
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Currently, during a task weight change, sched core directly calls
reweight_task() defined in fair.c if @p is on CFS. Let's make it a proper
sched_class operation instead. CFS's reweight_task() is renamed to
reweight_task_fair() and now called through sched_class.

While it turns a direct call into an indirect one, set_load_weight() isn't
called from a hot path and this change shouldn't cause any noticeable
difference. This will be used to implement reweight_task for a new BPF
extensible sched_class so that it can keep its cached task weight
up-to-date.

This will be used by a new sched_class to track weight changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/fair.c  | 3 ++-
 kernel/sched/sched.h | 4 ++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a869236d0735..a205d00f0669 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1297,8 +1297,8 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	 * SCHED_OTHER tasks have to update their load when changing their
 	 * weight
 	 */
-	if (update_load && p->sched_class == &fair_sched_class) {
-		reweight_task(p, prio);
+	if (update_load && p->sched_class->reweight_task) {
+		p->sched_class->reweight_task(task_rq(p), p, prio);
 	} else {
 		load->weight = scale_load(sched_prio_to_weight[prio]);
 		load->inv_weight = sched_prio_to_wmult[prio];
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..c0818324a9cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3399,7 +3399,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 }
 
-void reweight_task(struct task_struct *p, int prio)
+static void reweight_task_fair(struct rq *rq, struct task_struct *p, int prio)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -12663,6 +12663,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
+	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..1a12a0d9ea40 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2213,6 +2213,8 @@ struct sched_class {
 	 */
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      int newprio);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      int oldprio);
 
@@ -2369,8 +2371,6 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
-
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.41.0


