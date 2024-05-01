Return-Path: <bpf+bounces-28335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 925818B8C81
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B071C22535
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02012F588;
	Wed,  1 May 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxB9NPB1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365CB12FF89;
	Wed,  1 May 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576409; cv=none; b=ddrTFMszjzOjk2dTb4wU3xXrPToTP53N+29MfoQhK1yLUfi7WYYBc+y+O/z3fwSWO7ynZk3klVna820J1N5t9GCGo/xzn9IBzySnvqix4PfHR76582r19TMaN1zo/NEKArf9Taz2faw7aomXFVInE6gr0gg1MCE1kr0MSXaSIZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576409; c=relaxed/simple;
	bh=QETFN8ReXoUCqSAtsQ5nhUm2pZ34ROUijurolnbm5bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwPYkYkqJa+6/UbUvEIDt6gga7jZtEJdrsFSq66nyArLWxlAEfxKZY/A4FnmRuutoGHIY3P1Zr1vO+NYKTUbyt1sbXkgR+mZ4mKaPfJ7B4NGPHXssu16H6WbTIhybl/+icnJ1qLJnC5FZMVR2J8ghZdCegXZmq0jH8cLaW7JbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxB9NPB1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed32341906so6337205b3a.1;
        Wed, 01 May 2024 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576407; x=1715181207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1Bg2c28eANvtESgwHQ8Qb1Sjn/8FqBUHZEAGXT4a1Y=;
        b=WxB9NPB1ZVP7Z2Ns1DiXdezjXDCZInrpwxUXTL7uhtNamM9u3/2UgyhrJuReZL4jjI
         9z1LIUeo2yxGLMLJE2BZdqiNFcw/zs630ZBy9/7nHMACFiSK7sVly5mt4QZTpcfoNGce
         oq/zlvMoz4FaPEK7yi8NKEGlMNG28xDL2UiE2Ct72odcjsiYr4gNI8qNGp5Sq56JzjqM
         h+1wgLmDtysgfcet+IbyO583+xs5btEnja6TiwvR7nqJLJWlibVWRLSIu/usDydv1vzf
         r+d2TNPe9W9u0kvIJ3NBTvyaeH/ZWapat/7GhVua1D9rZbNHZqc9u73wxu0te87iFv4S
         McfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576407; x=1715181207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u1Bg2c28eANvtESgwHQ8Qb1Sjn/8FqBUHZEAGXT4a1Y=;
        b=aOJ6dmoSLA0HsroLdHGPkCTibBtUYUjE+g9gZuKOHSkcTIOBFpha4kV+BblzlPrlOL
         utZtZIW30GUu5LBT6Te+dP6ZMooKjBjp/YSUxplFE/yoo8E67xw0e3V1ua53+2I+s5SJ
         caPvoKI9S/uxjjGMZsGtWSxVzKQYyU2wPxk0bT6YYD0ycxgVkJjtPa0r7U4y1yS3lqmL
         txFVYLgrUlpqaTb9D1uRAoPcFrIRARglrpRk5+AwKwNKAjIuFuDtwxu5VB5khsKcMaTJ
         UTJriohF/UfpwEHh5U/uWxLK/TppzWHWUIvdxB2hpd9u3qnkkSl1n0+s5W1eZ2spATA0
         YQZA==
X-Forwarded-Encrypted: i=1; AJvYcCW08GEwDPHvbe50lG/0XOBzbL1CWZQnwssA36vTycmE5gWLPCDB1i8dP17sWas3QEc/LV9WLXrXKeigcEBzERqU4t7J
X-Gm-Message-State: AOJu0YwZqP3BFkSsAwiK21U8YDm64TXKn8u1GgC2MHLBQmBfAvw+ROZs
	dUxpbzPZSIlKj9Vztyy+smohOHmNEnxJupTwajhsJNdNwYv8UEQw
X-Google-Smtp-Source: AGHT+IHZ61jpFi4JYvK6dvUaOZoksuoyhBLi+gttgVrAVt4tkRehwyaGGWRotmjI8u/R4zM2ergmgQ==
X-Received: by 2002:a05:6a21:394b:b0:1a9:8152:511c with SMTP id ac11-20020a056a21394b00b001a98152511cmr3649575pzc.62.1714576407338;
        Wed, 01 May 2024 08:13:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7839a000000b006e53cc789c3sm22809773pfm.107.2024.05.01.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:27 -0700 (PDT)
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
Subject: [PATCH 05/39] sched: Add sched_class->switching_to() and expose check_class_changing/changed()
Date: Wed,  1 May 2024 05:09:40 -1000
Message-ID: <20240501151312.635565-6-tj@kernel.org>
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

When a task switches to a new sched_class, the prev and new classes are
notified through ->switched_from() and ->switched_to(), respectively, after
the switching is done.

A new BPF extensible sched_class will have callbacks that allow the BPF
scheduler to keep track of relevant task states (like priority and cpumask).
Those callbacks aren't called while a task is on a different sched_class.
When a task comes back, we wanna tell the BPF progs the up-to-date state
before the task gets enqueued, so we need a hook which is called before the
switching is committed.

This patch adds ->switching_to() which is called during sched_class switch
through check_class_changing() before the task is restored. Also, this patch
exposes check_class_changing/changed() in kernel/sched/sched.h. They will be
used by the new BPF extensible sched_class to implement implicit sched_class
switching which is used e.g. when falling back to CFS when the BPF scheduler
fails or unloads.

This is a prep patch and doesn't cause any behavior changes. The new
operation and exposed functions aren't used yet.

v2: Improve patch description w/ details on planned use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 19 ++++++++++++++++---
 kernel/sched/sched.h |  7 +++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4b9cb2228b04..311efc00da63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2214,6 +2214,17 @@ inline int task_curr(const struct task_struct *p)
 	return cpu_curr(task_cpu(p)) == p;
 }
 
+/*
+ * ->switching_to() is called with the pi_lock and rq_lock held and must not
+ * mess with locking.
+ */
+void check_class_changing(struct rq *rq, struct task_struct *p,
+			  const struct sched_class *prev_class)
+{
+	if (prev_class != p->sched_class && p->sched_class->switching_to)
+		p->sched_class->switching_to(rq, p);
+}
+
 /*
  * switched_from, switched_to and prio_changed must _NOT_ drop rq->lock,
  * use the balance_callback list if you want balancing.
@@ -2221,9 +2232,9 @@ inline int task_curr(const struct task_struct *p)
  * this means any call to check_class_changed() must be followed by a call to
  * balance_callback().
  */
-static inline void check_class_changed(struct rq *rq, struct task_struct *p,
-				       const struct sched_class *prev_class,
-				       int oldprio)
+void check_class_changed(struct rq *rq, struct task_struct *p,
+			 const struct sched_class *prev_class,
+			 int oldprio)
 {
 	if (prev_class != p->sched_class) {
 		if (prev_class->switched_from)
@@ -7253,6 +7264,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	}
 
 	__setscheduler_prio(p, prio);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued)
 		enqueue_task(rq, p, queue_flag);
@@ -7898,6 +7910,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		__setscheduler_prio(p, newprio);
 	}
 	__setscheduler_uclamp(p, attr);
+	check_class_changing(rq, p, prev_class);
 
 	if (queued) {
 		/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8e23f19e8096..99e292368d11 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2301,6 +2301,7 @@ struct sched_class {
 	 * cannot assume the switched_from/switched_to pair is serialized by
 	 * rq->lock. They are however serialized by p->pi_lock.
 	 */
+	void (*switching_to) (struct rq *this_rq, struct task_struct *task);
 	void (*switched_from)(struct rq *this_rq, struct task_struct *task);
 	void (*switched_to)  (struct rq *this_rq, struct task_struct *task);
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
@@ -2540,6 +2541,12 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 
+extern void check_class_changing(struct rq *rq, struct task_struct *p,
+				 const struct sched_class *prev_class);
+extern void check_class_changed(struct rq *rq, struct task_struct *p,
+				const struct sched_class *prev_class,
+				int oldprio);
+
 extern void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags);
 
 #ifdef CONFIG_PREEMPT_RT
-- 
2.44.0


