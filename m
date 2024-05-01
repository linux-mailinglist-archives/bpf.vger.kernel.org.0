Return-Path: <bpf+bounces-28334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF58B8C7F
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0041C224A4
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E0F12FF8E;
	Wed,  1 May 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZr8u8qX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C5512FB37;
	Wed,  1 May 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576407; cv=none; b=ssW3LcN5/dfzexxPFWLBkcP3O5/HsNBM2OXub/DHvsFJgBbr5xs7bt+m9p/GcbnAdTsHSyyRvXi4NdEKgiPhLIEDY+3TwV70dAG/JB3X9Bmy6oaf13SDqd5FD09bmJ6S8BIvUHdKUN4w380KoKhA0jItIhvn9e4mkspjaIASFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576407; c=relaxed/simple;
	bh=xprpo1L6NVoqJ4YOBIdrghwZw+/iuKJEQ0TyP3e8xr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRryQNcOBRPvQY4OFkQTSXl498fmsch5fk6Mg2Es2wVomrdHsNKJJt79RqREB/PZavZC/E/zZozWfrxP0AakxXY7p8lqwDqp9/T8BL5v9IhnfRGjM4ZbJlLOi1/TaZhYeVz2Wz52CUsx3pFcBRW+EY6z1MB7e/M14e227WLgWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZr8u8qX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so6509455ad.0;
        Wed, 01 May 2024 08:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576405; x=1715181205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5hNXTjBxLowgydR4+B61MIhqeUyqlOt40T3p29P4vQ=;
        b=EZr8u8qXko3oQ8/n4su9ZiMJsaW9RJckHIND1krjdqUuVFi5WCbNcAFD6ZqRzxNZz/
         sR4/OL+TGyMPYYzvbcpUpo+ZnI7J2oSPPZpTfXDP2uAAoh9S/oxSz6G3TviRFIKnNe15
         bFRmpI+SBSqbmbfbop87FOsJ/Eew/VAf3iOnO1BmROLvEvikG6TFMuJxhKdt3yhpPg27
         OwANLgYd8zRLGvdZz8b+9F3SP/Ss02g3F4FsJhize3fjvj2hpK6PDt4N3ZT7k8uVLzCx
         v18dVFC4pOwfkq3gHaXKAvR543EfEqV4JLcjvQcINHrVNAb7TZxVea2K/vO4GjAgy8zD
         BSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576405; x=1715181205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J5hNXTjBxLowgydR4+B61MIhqeUyqlOt40T3p29P4vQ=;
        b=qye1S7gQdDm2qj+cH6IB8aPn5a0xxKVIg/Iy/TM2+H6PqVooXWvHa9j+mpV8uy0jcV
         FRIk66YQAV03AVyQKRlsLt7/DmqEio3Kf5kF2/vDvJu7XDjyg+D7A8xVgGgjsGc86Au5
         5oPdpSPPo+oVbN6FdVluwCzdDHDAxvIOAdqS4xPi9WUZhzmiqrNDTVm0ACSYKSMgUISN
         0BAQ4SECV/ibl1RXPJ/HBBXYbPYJDzJmtN6ZzO/krN/UGArBoeZcN7qv60ad4bVLE4Lr
         56YPc+MCvh16uJNy4E3nAf8XgYsCaxfB1Le4ecF0wwaMedK7ir7mRl5dOHZdHM0xYwLD
         t1XA==
X-Forwarded-Encrypted: i=1; AJvYcCWMhoueGt2UeZ5YVMFxx7/O2xNrWoROpUFcffj3e7KvZGQt+Ecjp5cPlGrNbFTIGIKi+vptGyJlLNm0cQ/AeYXUd6B6
X-Gm-Message-State: AOJu0YyoNKcZT7DyZ2e9tBsosMPW2jXHUy2Jvsclws5v6YdezA227G6R
	CYNVUikEajZkJ1qBqFNwCc7sZlZWD8v54/OxfYQqljRezHFyVLrr
X-Google-Smtp-Source: AGHT+IHdAdHWGNDnnjOOXZ1S9dJ5xqkgutlilBZVfeUQoY++klY5/UcLdf0OG8zlmJYQYnJdfDJwnQ==
X-Received: by 2002:a17:902:ea02:b0:1e4:6253:2f15 with SMTP id s2-20020a170902ea0200b001e462532f15mr4404311plg.16.1714576405447;
        Wed, 01 May 2024 08:13:25 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902a50a00b001e0da190a07sm24385261plq.167.2024.05.01.08.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:25 -0700 (PDT)
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
	memxor@gmail.com,
	andrea.righi@canonical.com,
	joel@joelfernandes.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/39] sched: Add sched_class->reweight_task()
Date: Wed,  1 May 2024 05:09:39 -1000
Message-ID: <20240501151312.635565-5-tj@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240501151312.635565-1-tj@kernel.org>
References: <20240501151312.635565-1-tj@kernel.org>
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
index b12b1b7405fd..4b9cb2228b04 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1342,8 +1342,8 @@ static void set_load_weight(struct task_struct *p, bool update_load)
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
index 03be0d1330a6..5d7cffee1a4e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3835,7 +3835,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	}
 }
 
-void reweight_task(struct task_struct *p, int prio)
+static void reweight_task_fair(struct rq *rq, struct task_struct *p, int prio)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
@@ -13135,6 +13135,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.task_tick		= task_tick_fair,
 	.task_fork		= task_fork_fair,
 
+	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2242679239e..8e23f19e8096 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2303,6 +2303,8 @@ struct sched_class {
 	 */
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
+	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
+			      int newprio);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
 			      int oldprio);
 
@@ -2460,8 +2462,6 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
-
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.44.0


