Return-Path: <bpf+bounces-32760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7749F912E1F
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A1EB21812
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C6E17B423;
	Fri, 21 Jun 2024 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHxNRryk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA75664;
	Fri, 21 Jun 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718999550; cv=none; b=bqrdBiNIMLNz5CGeZdy3eL5slVG7M6GJui0d61fzHEhmrnyXCJ+h3fUY6d8PA3CjHG7cdhUcW9LFVa+fabcNMlkkahdhyO47FaaMC8Yrda2H3XKAtMGdCm3LBPVS5cnqlA44fKpVWer8/BU5YvQ2dYIyxaZxyqklBuzLV+aX/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718999550; c=relaxed/simple;
	bh=mbDTRYewWKN1yM/XYOg/MmIXNhPo4QLWCjVwir+awD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPaAC1ETedWQt/XGj4jDw5268pCwrxeui20ZGYEqzy6bU23ZmJkQYqZ5gT9jElFi+yVG2rTVSXGtjOKE2u8IpDvMbINKl0rF32KGYCe3LMk6CkAAbCu70BYIR2oEs7UXbEJepIuYAnF5UxHp89jrV+Pnkq0gKmNxOUlGTC8h63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHxNRryk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-681bc7f50d0so2526716a12.0;
        Fri, 21 Jun 2024 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718999548; x=1719604348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjkik/3XL/G5m00jILuBxm5N7shcQAH7kSL/k0oIZZU=;
        b=HHxNRrykD4iz4PDPAPTZAJ/1wqiMJrCHvEdwsd900FVdb8mm83D9+41Sh69HJDKZ4J
         g4BmLklJmS10a1VTku6Gnr6SDHDH0/WVB7pWCo/JOcvwqKBtLtH7pO9zyAV6OWK/BKWj
         RQgAsKcsqfo4jiewJJf2oQbD8prnnbDQ92PsOQDLrhfe9CT/G5mzhHTrAWXnulsOTx28
         EDSYcyvf//H+6sESufm0qoLuYRezvT2ZTF6c8z6PuEkmb4WscZN00BMqSL7qR0d97waT
         1SRM/gP1wA6r8tFVeW2V2AdDJcpHlpewoVMa1LeLZbrkTil+nrnkuUQCsI9/h8RbKY35
         Ohhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718999548; x=1719604348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjkik/3XL/G5m00jILuBxm5N7shcQAH7kSL/k0oIZZU=;
        b=CYGo4001Tpcu67dYocH4mfH+TfNena+YMaGqYIv/JWgz9j7bTslrTmJoI5CuBoCe20
         4+mFAfD7AZFmA6q3MVPuZJeGE9E/2iPL1MRDLen6R8E4aZNFNrbK23G7YTef1wGK+OuJ
         0chH4fBWv9W9dHd1HRehprkTkpyxIdtd71SnTuvFl8Nf/ks35y5FHRzoykPOoo9nj1Xd
         TwYP9MzNY8goX8h/0T87rIZPksk76Y/UNRTo5/01BOlDqOMO0jkhYeNK2E9Ym6DXiqdM
         /Vrdp74rAX1x5LFrvWh9CnLu6Hyf5Oeg1+Wqql7hq2UH9RYaxW/Zn0qExxIE+uVRomE5
         nCeg==
X-Forwarded-Encrypted: i=1; AJvYcCX4Sy4JYNyxEXYKGFS4hMt/gKrHLyne1b55ywPuazL4n8nzU86x6JZydkfkZRUrJxPRdmAvGSFn5xzO+VeSodffkibOT0aEh5LPuUMEvXq+eKE0hZPIoRk3af859tYxjpZl
X-Gm-Message-State: AOJu0Yx0Jb1ZMJj1f6QO66RVh3TjtzHRzJrHXbbIEKJGZbERLELMdGdR
	D6CN8Eik+JMSUx0L5n5bvFWyptkLG+wjNIdJw0dGk+ESBnv+uiYU
X-Google-Smtp-Source: AGHT+IGGvHYmwg6vw009jL9LiKBxVitJ8s5iCBIL2NAu/1k9ddEIOZ3sk2kPzOVULQIzlgsg69gsYg==
X-Received: by 2002:a17:90a:d494:b0:2c2:c3f5:33c3 with SMTP id 98e67ed59e1d1-2c83c1d4e6cmr980857a91.6.1718999547844;
        Fri, 21 Jun 2024 12:52:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dcf1a7sm1975713a91.50.2024.06.21.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:52:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 21 Jun 2024 09:52:26 -1000
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
Message-ID: <ZnXZ-inMW0zif3Xe@slm.duckdns.org>
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx>
 <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
 <ZnRptXC-ONl-PAyX@slm.duckdns.org>
 <ZnSp5mVp3uhYganb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnSp5mVp3uhYganb@slm.duckdns.org>

From b999e365c2982dbd50f01fec520215d3c61ea2aa Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 20 Jun 2024 12:15:02 -1000

scx_next_task_picked() is used by sched_ext to notify the BPF scheduler when
a CPU is taken away by a task dispatched from a higher priority sched_class
so that the BPF scheduler can, e.g., punt the task[s] which was running or
were waiting for the CPU to other CPUs.

Replace the sched_ext specific hook scx_next_task_picked() with a new
sched_class operation switch_class().

The changes are straightforward and the code looks better afterwards.
However, when !CONFIG_SCHED_CLASS_EXT, this ends up adding an unused hook
which is unlikely to be useful to other sched_classes. For further
discussion on this subject, please refer to the following:

  http://lkml.kernel.org/r/CAHk-=wjFPLqo7AXu8maAGEGnOy6reUg-F4zzFhVB0Kyu22h7pw@mail.gmail.com

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
Hello,

Applied to sched_ext/for-6.11. The only difference from the previous posting
is the description.

Thanks.

 kernel/sched/core.c  |  5 ++++-
 kernel/sched/ext.c   | 20 ++++++++++----------
 kernel/sched/ext.h   |  4 ----
 kernel/sched/sched.h |  2 ++
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5eec6639773b..1092955a7d6e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5907,7 +5907,10 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f814e84ceeb3..390623a4a376 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2749,10 +2749,9 @@ preempt_reason_from_class(const struct sched_class *class)
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
@@ -2769,12 +2768,11 @@ void scx_next_task_picked(struct rq *rq, struct task_struct *p,
 
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
@@ -2789,8 +2787,8 @@ void scx_next_task_picked(struct rq *rq, struct task_struct *p,
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
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index c41d742b5d62..bf6f2cfa49d5 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -33,8 +33,6 @@ static inline bool task_on_scx(const struct task_struct *p)
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
-void scx_next_task_picked(struct rq *rq, struct task_struct *p,
-			  const struct sched_class *active);
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
@@ -82,8 +80,6 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 #define scx_enabled()		false
 #define scx_switched_all()	false
 
-static inline void scx_next_task_picked(struct rq *rq, struct task_struct *p,
-					const struct sched_class *active) {}
 static inline void scx_tick(struct rq *rq) {}
 static inline void scx_pre_fork(struct task_struct *p) {}
 static inline int scx_fork(struct task_struct *p) { return 0; }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c0d6e42c99cc..3989bf8f2a1b 100644
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
-- 
2.45.2


