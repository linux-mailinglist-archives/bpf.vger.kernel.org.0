Return-Path: <bpf+bounces-14823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582847E886A
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0907F281387
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348AC5258;
	Sat, 11 Nov 2023 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiXgQNtn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D027569F
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:49:03 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5A64695;
	Fri, 10 Nov 2023 18:49:02 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-282e3beb418so2519978a91.0;
        Fri, 10 Nov 2023 18:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670942; x=1700275742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MM//pMBlM4GuAAmAj+tt8tgOSwOthT3D7HBNuCDy30=;
        b=hiXgQNtnva67FnrFokQ2LyzhexqwjxTw1xmr+06qntH5hTE9OVq4wEham/V9RRraJT
         1NXv0fOl4kwiXWlJD0q+L0Y1wfNoeJ6NBgP6a6lBPOv4iFgr/YhY6G/kcvO5/SXFgFf8
         0qMJ9O9y3qslKEqVatpIGKrE5APv2TjgIK8tUVKsGYy/vWS6g18gyNL6rHBpJodgehN6
         a4g7dGbtEKb4Wu2e0gBOf8RYl+g0Ku1Qi72yaXWKQl03iMECHwIMdE8Lr7w+FL611u+B
         hTN3YbbnsomlNNbimiORn8DSh/fUowoD0VxkqN3rMjzThTdiGSSFHi/xq1ap5KnWnuFw
         nD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670942; x=1700275742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7MM//pMBlM4GuAAmAj+tt8tgOSwOthT3D7HBNuCDy30=;
        b=Qd47Nhnou/gmUwROvy57HxV3kziXMfHkDG50DigWwSFVEk5smZS+xfUb02daj72/R6
         2IqLbuJQ4pj1bcM5Iksj/befnYapVj/52qb8qKpBDE4ZatrcUMYYJDyybLvcPfKeYE+1
         bfd+83mS4Y1XHIynzfyBg+7qtHyas733ROSrPK59tVI88izhCNd7j8sakw0e5pXK3UWh
         V5121yC3NmUcRxc60HnN/pj9rElv5VyABI1GyU8TZmJx9AkVOcURW16Il9vKpVP3V8Jx
         ECxv+gXtpIKOKPeGsJeaPfo7bIcEbvYLsbc0Oy7hre7WfftkN60rmICPSiwhGPeQw2No
         UEtQ==
X-Gm-Message-State: AOJu0Yy16Dq4K0SP/P80Yp9HLj6oOKWjmjgNEn1UMNDg+wzAacVqYjLk
	5Ej57tXBIQMasSiJL1tqlF4=
X-Google-Smtp-Source: AGHT+IEB115bUvoSNdGOFPRlM4qdOvbtXR/o4Rr/HjPysjUYromP3qNqbNUvWFzBQjE6+Riw4en8aQ==
X-Received: by 2002:a17:90b:4b0c:b0:279:2dac:80b3 with SMTP id lx12-20020a17090b4b0c00b002792dac80b3mr845348pjb.44.1699670942155;
        Fri, 10 Nov 2023 18:49:02 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b001c5f7e06256sm351779plf.152.2023.11.10.18.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:01 -0800 (PST)
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
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/36] sched: Add sched_class->reweight_task()
Date: Fri, 10 Nov 2023 16:47:30 -1000
Message-ID: <20231111024835.2164816-5-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index b5fb4b894477..09e6ce45e65a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1319,8 +1319,8 @@ static void set_load_weight(struct task_struct *p, bool update_load)
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
index 8767988242ee..8ec0c040e9e8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3717,7 +3717,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 }
 
-void reweight_task(struct task_struct *p, int prio)
+static void reweight_task_fair(struct rq *rq, struct task_struct *p, int prio)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -12990,6 +12990,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
+	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e5a95486a42..a66b48bc45ba 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2259,6 +2259,8 @@ struct sched_class {
 	 */
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      int newprio);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      int oldprio);
 
@@ -2416,8 +2418,6 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
-
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.42.0


