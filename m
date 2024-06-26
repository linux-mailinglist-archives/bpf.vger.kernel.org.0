Return-Path: <bpf+bounces-33116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE879175A2
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 03:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE05E1F227E9
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917BF15EA2;
	Wed, 26 Jun 2024 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZZcPfEt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657D14AAD;
	Wed, 26 Jun 2024 01:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365403; cv=none; b=E1Ff2RpjvW8B88FlOMGLo8TT5esicvujzjpbcZpU9sNwyZsf+ARI70oTVLfMqv++bbInvlArzG0EYRkcT16Isvn09p+CF5TVnX1KSZZb8xrP0k34mNiqkhkOXlALFsi26neOx6FnO5DDK2PpiatMWK0EmM+eSUmMAYcWzXXINJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365403; c=relaxed/simple;
	bh=iknmKhXNGutkLsmVPjGoOiKCXLGQOYlpe4WBibl5F4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwCnHGbTliSdDD0uQRsTt7FRFqIxhGYyrR143eK2UxpZJItZ7Wz3owbjCykis+3xAhZnRKGWPyfgWaGqC8GGY0nRYxH7vnRrAX5hijUo9scHS213rXDdiZuJ4Zs5aJ7qnOLCz/Qk0CwA5/TZtQjzfwTBFWhQDI0//wLIuHbQiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZZcPfEt; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7024d571d8eso4834701b3a.0;
        Tue, 25 Jun 2024 18:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719365401; x=1719970201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xz3ZwvH8uplrWFZnVIemSkwprKalyOlrNxjP8tA2gBA=;
        b=MZZcPfEtVjgeD8U3FgLj2TAh/XrmFIdhObJjy8nYG9/E733P3m9kLNFfV1R3Xe1N3z
         kwpwAZXXj7N50CTCbtAxzLbunrOF4BQVFfYmisPjKK4fdC5mdvEI3oUAlyjC1fHu4vGa
         GAkt+X5Zu9D8p+vsR+ApJwFsnQi85MVHM087vP4H19wnu7Mgh+XnTlrYXzg0qT9GSKgA
         k3uWDw9AhVgjBqarPOpaZRZAwnXvvbsv1m3dq2xxWIY6lhTJcizrE/6QLqSHFz8P9yaj
         l57EzwRUy/iEUhNzKl4QylH+UXlarVSX2ZgHf3lEeBLFo02dUr30KIhN+6Z7jAOx4KqM
         D1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719365401; x=1719970201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xz3ZwvH8uplrWFZnVIemSkwprKalyOlrNxjP8tA2gBA=;
        b=o7tqH10NgwicT/vIArt2u5EauErD23h9ZH8WJ9vA9bl1IfJM8r/2Sw+Vcg1BtqiuQz
         IEIAg6aYZEJnShmA5Zg00fApCCs2Ihdvih/RTMVkrgITmKlQtiPrmhe2JkmmoqD/ZSBS
         YIDGF4hcWgIUMRqFskYaLSLft29TVSFrbD5v//oiQnUYd05Y7WOxQlG/5ur9nyl9Ezuj
         054UlLuwjp29oM1QrpYtvd9dMuXrVjPR3L3EBwF8Y+FaJdee8czXz+tP/XARe5AdN67U
         QiLEEM1H0jWI+0AbL3lP0BXEve052JwvILgL8WM2ISUCSUDQnA73xlvvfJzzpGLRfdJ6
         /6cw==
X-Forwarded-Encrypted: i=1; AJvYcCUTyF8Y6ZWLUT7ay/m6KgpFEm6A8Y0XLMd7P/tyM29w4UM8Wr3LzyIcOhYS5dtwz+8kjV2nZ7VxYiztflB0M9Wq4pn3yU0u00t5A4RN1fc/SMjCR3d0feaLguIlBjJAXP9u
X-Gm-Message-State: AOJu0YweCW1jo46cBpIX27rZKvUH9YsNuBluTGJRvoEQVmONJsTnSudy
	Til91rvayatuK3drcVQDOGNkU0xDEGJITbhXz3X00NzdE62qjBon
X-Google-Smtp-Source: AGHT+IERk91Z4NK+zMUTqy+XbpoYjC7VgtnExWq4cCbXy7lMiZ1rsEXL3iH8fxQPVmszAtH1bQzoFg==
X-Received: by 2002:aa7:87d0:0:b0:706:6771:4a98 with SMTP id d2e1a72fcca58-706747520fcmr9307701b3a.32.1719365400699;
        Tue, 25 Jun 2024 18:30:00 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706a795bebdsm237519b3a.163.2024.06.25.18.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 18:30:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 25 Jun 2024 15:29:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	joshdon@google.com, brho@google.com, pjt@google.com,
	derkling@google.com, haoluo@google.com, dvernet@meta.com,
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
	andrea.righi@canonical.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH sched/urgent] sched/fair: set_load_weight() must also call
 reweight_task() for SCHED_IDLE tasks
Message-ID: <ZntvFkBlLc9CIrpR@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-5-tj@kernel.org>
 <20240624102331.GI31592@noisy.programming.kicks-ass.net>
 <ZnoIRnCZaN_oHQ6N@slm.duckdns.org>
 <20240625072954.GQ31592@noisy.programming.kicks-ass.net>
 <ZntZcRgm-zok7kyb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZntZcRgm-zok7kyb@slm.duckdns.org>

When a task's weight is being changed, set_load_weight() is called with
@update_load set. As weight changes aren't trivial for the fair class,
set_load_weight() calls fair.c::reweight_task() for fair class tasks.

However, set_load_weight() first tests task_has_idle_policy() on entry and
skips calling reweight_task() for SCHED_IDLE tasks. This is buggy as
SCHED_IDLE tasks are just fair tasks with a very low weight and they would
incorrectly skip load, vlag and position updates.

Fix it by updating reweight_task() to take struct load_weight as idle weight
can't be expressed with prio and making set_load_weight() call
reweight_task() for SCHED_IDLE tasks too when @update_load is set.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20240624102331.GI31592@noisy.programming.kicks-ass.net
Fixes: 9059393e4ec1 ("sched/fair: Use reweight_entity() for set_user_nice()")
Cc: stable@vger.kernel.org # v4.15+
---
Hello,

Peter, I took the liberty to use struct load_weight instead of open coding
weight and inv_weight. As it's an obviously user visible bug, I tagged it
with the stable tag but given how long it's been broken, I'm not sure how
urgent it is, so please use your discretion. I verified that the
reweight_task() is called with the right weights on SCHED_IDLE switches.

Thanks.

 kernel/sched/core.c  |   23 ++++++++++-------------
 kernel/sched/fair.c  |    7 +++----
 kernel/sched/sched.h |    2 +-
 3 files changed, 14 insertions(+), 18 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1328,27 +1328,24 @@ int tg_nop(struct task_group *tg, void *
 void set_load_weight(struct task_struct *p, bool update_load)
 {
 	int prio = p->static_prio - MAX_RT_PRIO;
-	struct load_weight *load = &p->se.load;
+	struct load_weight lw;
 
-	/*
-	 * SCHED_IDLE tasks get minimal weight:
-	 */
 	if (task_has_idle_policy(p)) {
-		load->weight = scale_load(WEIGHT_IDLEPRIO);
-		load->inv_weight = WMULT_IDLEPRIO;
-		return;
+		lw.weight = scale_load(WEIGHT_IDLEPRIO);
+		lw.inv_weight = WMULT_IDLEPRIO;
+	} else {
+		lw.weight = scale_load(sched_prio_to_weight[prio]);
+		lw.inv_weight = sched_prio_to_wmult[prio];
 	}
 
 	/*
 	 * SCHED_OTHER tasks have to update their load when changing their
 	 * weight
 	 */
-	if (update_load && p->sched_class == &fair_sched_class) {
-		reweight_task(p, prio);
-	} else {
-		load->weight = scale_load(sched_prio_to_weight[prio]);
-		load->inv_weight = sched_prio_to_wmult[prio];
-	}
+	if (update_load && p->sched_class == &fair_sched_class)
+		reweight_task(p, &lw);
+	else
+		p->se.load = lw;
 }
 
 #ifdef CONFIG_UCLAMP_TASK
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3835,15 +3835,14 @@ static void reweight_entity(struct cfs_r
 	}
 }
 
-void reweight_task(struct task_struct *p, int prio)
+void reweight_task(struct task_struct *p, const struct load_weight *lw)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct load_weight *load = &se->load;
-	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
-	reweight_entity(cfs_rq, se, weight);
-	load->inv_weight = sched_prio_to_wmult[prio];
+	reweight_entity(cfs_rq, se, lw->weight);
+	load->inv_weight = lw->inv_weight;
 }
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2509,7 +2509,7 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
+extern void reweight_task(struct task_struct *p, const struct load_weight *lw);
 
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);

