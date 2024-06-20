Return-Path: <bpf+bounces-32645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64007911579
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 00:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E95A8281B21
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 22:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F29C13A26B;
	Thu, 20 Jun 2024 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsKoJD6/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AE97FBBD;
	Thu, 20 Jun 2024 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921706; cv=none; b=RDqDRPMHK+3tCiHSwxubDJkhSJax5lbkampJ+PAQq1yf6aJimb1pL00cLzJOZdMLioD6Y2UukDRuD51EoBt/IqerwOYZmHroJdvGSvnGGCnpKhWPMsgCUa3F1hd4Nbx7xd872mAqHqJF9Y2cd7yQNcpFbRrV052PZ+FDaqhQoHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921706; c=relaxed/simple;
	bh=X8IQyYQchUvfPJCwukEzlqRSS/Vjca9WuON89rkPDLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CV2vogLg4jbvsHgL0bYXV4GfPIzFr8LijuRRD9CB8EhzGX/GBo4AS8wNsL1ySgSamenQiek55Wp1zjiTzOfuRLkmsiwRA0N4Q+LNg9l2WWVVG6Qf/xVapNJYj3gjQ7Wm26lev0cn5rZltaoyA8pfwG3XWNIzOn3bQ6yasrdqaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsKoJD6/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f47f07acd3so11303445ad.0;
        Thu, 20 Jun 2024 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718921704; x=1719526504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DKWquAmKhEB/XmbjnFSkp5YHAKMuGRZku6HlwtLOgs=;
        b=JsKoJD6/Nq8Ze5PWRChHMcO2jwS/5YVxruualN/XOCDGnSxeJQ9R8GyObFsF7W0+YD
         9d6XjEFQcuX7itIGgOw58wKp4gl5tOko+eTA1ZL03xz8rly76JJNSUqoaudPA0lqmfdG
         cm0jTIoiffpGzG6bB0iBWhZGM8TKVTPHJjOYAf9t+BEdo5pIj093SZDwtDYkYjEZeEiw
         tSv34FxQMxVv0itOyPZZLqZjW2vkqs1c5JUACPFJY0cS0fz1y90Wz1kEZ3zGmBqTcppE
         ebGK6mXvucbpY8Y0llEyctFPijNTDduYe1Wdem95pNemQwahfT0+1DJ/9pdB66kx5DpK
         61LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921704; x=1719526504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DKWquAmKhEB/XmbjnFSkp5YHAKMuGRZku6HlwtLOgs=;
        b=ozrURdGRDMnMJRCfzfV+Td2x2j+n7r+orpXusR6dmGNbR6sNbyXLheWP4oV13XZ+V3
         fCHdDBKdLpHeNryEulKG2jc0j4L6kKJbyXNvo1zSeJwStZ2xwf0hAyF2/tKxmp8sRCg8
         5QcDyP7uC1kCBSnlyZkYPlCjRWkPhPyKNGTzcjNL9DWsjsIXsPC8eNjMlmEUTBLKoC9u
         dhwxmlq/I8wpyyiD1h4sn86rlrwnL3tTO84bM4bloX5pm739Enk5xK/WzjLMmGzbGZLt
         Q0S3Ub/3eqUwK5xja6rJfIC0WTjWv1wbUGkqZY14Z2VWukoTjAxqWFS89jaF0pbyS0GP
         46WA==
X-Forwarded-Encrypted: i=1; AJvYcCVNWUwhFV3ssMC7AysSddUwINXilvGvElGni5aixzJdooh4ffkzRterxjgitcAcf5yQgCJlsMu8MjKMSwu9ZVimqqqhJ+SdT6NibGflr+XZ3mCJPoJ9tnZIOBx92dzj8bgB
X-Gm-Message-State: AOJu0Yyq8BFU7dFAEdM68cnJmNJ71eE7pCHxTrIF3tV31XYP/RsTAWAo
	pZs/SMLDtbkEmZIh5//WtMspZwTNg1ys7DxfHnd69euKq1FVMtB8
X-Google-Smtp-Source: AGHT+IGE6yQd5jHQgaJUueo6tXcGwDo9MVXIRkY4esyereRuvtL0wBZtDniMigK6w73V5aqRfDNsCw==
X-Received: by 2002:a17:903:2352:b0:1f7:13db:529e with SMTP id d9443c01a7336-1f9aa3a5c41mr69059165ad.4.1718921704336;
        Thu, 20 Jun 2024 15:15:04 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbbdc26sm1032875ad.284.2024.06.20.15.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:15:03 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 20 Jun 2024 12:15:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
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
Subject: [PATCH sched_ext/for-6.11] sched, sched_ext: Replace
 scx_next_task_picked() with sched_class->switch_class()
Message-ID: <ZnSp5mVp3uhYganb@slm.duckdns.org>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnRptXC-ONl-PAyX@slm.duckdns.org>

scx_next_task_picked() is used by sched_ext to notify the BPF scheduler when
a CPU is taken away by a task dispatched from a higher priority sched_class
so that the BPF scheduler can, e.g., punt the task[s] which was running or
were waiting for the CPU to other CPUs.

Replace the sched_ext specific hook scx_next_task_picked() with a new
sched_class operation switch_class().

The changes are straightforward and the code looks better afterwards.
However, when !CONFIG_SCHED_CLASS_EXT, this just ends up adding an unused
hook which is unlikely to be useful to other sched_classes. We can #ifdef
the op with CONFIG_SCHED_CLASS_EXT but then I'm not sure the code
necessarily looks better afterwards.

Please let me know the preference. If adding #ifdef's is preferable, that's
okay too.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/sched/core.c  |    5 ++++-
 kernel/sched/ext.c   |   20 ++++++++++----------
 kernel/sched/ext.h   |    4 ----
 kernel/sched/sched.h |    2 ++
 4 files changed, 16 insertions(+), 15 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5907,7 +5907,10 @@ restart:
 	for_each_active_class(class) {
 		p = class->pick_next_task(rq);
 		if (p) {
-			scx_next_task_picked(rq, p, class);
+			const struct sched_class *prev_class = prev->sched_class;
+
+			if (class != prev_class && prev_class->switch_class)
+				prev_class->switch_class(rq, p);
 			return p;
 		}
 	}
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2749,10 +2749,9 @@ preempt_reason_from_class(const struct s
 	return SCX_CPU_PREEMPT_UNKNOWN;
 }
 
-void scx_next_task_picked(struct rq *rq, struct task_struct *p,
-			  const struct sched_class *active)
+static void switch_class_scx(struct rq *rq, struct task_struct *next)
 {
-	lockdep_assert_rq_held(rq);
+	const struct sched_class *next_class = next->sched_class;
 
 	if (!scx_enabled())
 		return;
@@ -2769,12 +2768,11 @@ void scx_next_task_picked(struct rq *rq,
 
 	/*
 	 * The callback is conceptually meant to convey that the CPU is no
-	 * longer under the control of SCX. Therefore, don't invoke the
-	 * callback if the CPU is is staying on SCX, or going idle (in which
-	 * case the SCX scheduler has actively decided not to schedule any
-	 * tasks on the CPU).
+	 * longer under the control of SCX. Therefore, don't invoke the callback
+	 * if the next class is below SCX (in which case the BPF scheduler has
+	 * actively decided not to schedule any tasks on the CPU).
 	 */
-	if (likely(active >= &ext_sched_class))
+	if (sched_class_above(&ext_sched_class, next_class))
 		return;
 
 	/*
@@ -2789,8 +2787,8 @@ void scx_next_task_picked(struct rq *rq,
 	if (!rq->scx.cpu_released) {
 		if (SCX_HAS_OP(cpu_release)) {
 			struct scx_cpu_release_args args = {
-				.reason = preempt_reason_from_class(active),
-				.task = p,
+				.reason = preempt_reason_from_class(next_class),
+				.task = next,
 			};
 
 			SCX_CALL_OP(SCX_KF_CPU_RELEASE,
@@ -3496,6 +3494,8 @@ DEFINE_SCHED_CLASS(ext) = {
 	.put_prev_task		= put_prev_task_scx,
 	.set_next_task		= set_next_task_scx,
 
+	.switch_class		= switch_class_scx,
+
 #ifdef CONFIG_SMP
 	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -33,8 +33,6 @@ static inline bool task_on_scx(const str
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
-void scx_next_task_picked(struct rq *rq, struct task_struct *p,
-			  const struct sched_class *active);
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
@@ -82,8 +80,6 @@ bool scx_prio_less(const struct task_str
 #define scx_enabled()		false
 #define scx_switched_all()	false
 
-static inline void scx_next_task_picked(struct rq *rq, struct task_struct *p,
-					const struct sched_class *active) {}
 static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2355,6 +2355,8 @@ struct sched_class {
 	void (*put_prev_task)(struct rq *rq, struct task_struct *p);
 	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
 
+	void (*switch_class)(struct rq *rq, struct task_struct *next);
+
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int flags);

