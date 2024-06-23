Return-Path: <bpf+bounces-32840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74591398B
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 12:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8A7280D28
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 10:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F5E8614D;
	Sun, 23 Jun 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ca6LqhZp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ioXLibE"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325A323CE;
	Sun, 23 Jun 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719138668; cv=none; b=gzr4s+pnnsPIZPOS4Afra0W3BVWiI5xWQlLdac1EEkLdzSBKgpAw6tkPqQGovUw3Kzf0+/rqja+WRPhNrPpP9bWs77m37gkhTDQQu6YsAIGG5YOpfaVtWbnQVpvsgOLksQyqLOAABOgQdfnQ+6TprRqUJO4yFgKooBeLx4Lz3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719138668; c=relaxed/simple;
	bh=wViZSvXZ2xH06udrWPcq/3gYLrAALiDEpJ3Hk6oseJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a6Ouhe2GXZY5Hjcy+YttRq3F9W8G0X0J2ZpPKEhmhu7aqw7cnCOi53ebAFkIQVXQwgxcE/7Tcq4qKOvceO7Byqn2XvAJc5Y+Jv9/gFhI4Uh/Q+Ux2/5hcQkAp3GWWNFveprAN+mRao4f8NQDbpfmp6X5gHR5FT+9ivAzVW159sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ca6LqhZp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ioXLibE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719138660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gm1PT2B5gcmym7DNOK5dtDaWL67j08PCA1ocDIx73Po=;
	b=Ca6LqhZpmOewYXkcxc+rnoGA2zK0mnFhXt7VwK+M5dLngmVkRzt73Lr5d+WGfAIpNXW+Yk
	RyFp3qn+h88wHgw2TriWzbhwwAHC2NdIlnwkhONOSfd6A35yVFyhyVjiBitzxI2OCIjZux
	UKW0vEdYeJBvFaPh+LTXsg0SC8wiz/7Wv5IZu7rGVozRk8gYra+sWnD+X1frEEl6qe70MK
	up+ehfylvCueBURD/70vzhAE/kfdP7i18zgqcXFMainJIXossYDozOCE/XqdADRwVTfZlL
	MHQ8Bz24rL85FeVK9pcGzVk7NcB81wraGK4Vx03nyubuoeqHpMwcArKCf3YxMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719138660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gm1PT2B5gcmym7DNOK5dtDaWL67j08PCA1ocDIx73Po=;
	b=0ioXLibEpOU+GARTz+GI1P6wvxq5YuPE2Yd2lCqcAFu6DgZljjkUB9haRe5vrLRqe0qrBI
	LSlD2Bkxrn3av6Aw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com,
 haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
 dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com,
 himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
In-Reply-To: <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <CAHk-=wgN6DRks55fsqiJYE3uV=_QTgzdxOvh1ZZNgm_YooKdYA@mail.gmail.com>
 <87v822ocy2.ffs@tglx>
 <CAHk-=wiRgsFsrnTR8XShrS_-aYS--4DSrRPmaWtYJ55-fmjznA@mail.gmail.com>
Date: Sun, 23 Jun 2024 12:31:00 +0200
Message-ID: <8734p4ymqj.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus!

On Fri, Jun 21 2024 at 09:34, Linus Torvalds wrote:
> So if I don't see it, please point it out very very explicitly, and
> using small words to make me understand.

I really let the scheduler people bring up their pain points now. There
is no value in me being the mouthpiece when I want to achieve that folks
talk to each other (again). It's not a me against you thing. If they
fail to explain, so be it.

So I just use one trivial example to illustrate the approach and the
message it emits, i.e. the technical and the social problem which makes
all of this so unpleasant.

It struck my eyes a few days ago when I deciphered the fork maze:

struct sched_ext_entity {
       .....
	/* must be the last field, see init_scx_entity() */
	struct list_head	tasks_node;
};

void init_scx_entity(struct sched_ext_entity *scx)
{
	/*
	 * init_idle() calls this function again after fork sequence is
	 * complete. Don't touch ->tasks_node as it's already linked.
	 */
	memset(scx, 0, offsetof(struct sched_ext_entity, tasks_node));
...

I immediately asked myself the obvious question: Why?

It took me less than 10 minutes to figure out that the double invocation of
__sched_fork() is bogus.

fork_idle()
   copy_process()
      sched_fork()
	__sched_fork()
   init_idle()
     __sched_fork()

There is only one other call site of init_idle():

     sched_init()
       init_idle()

to initialize the idle task of the boot CPU.

Another 10 minutes later I had the obvious patch for this booted and
validated. So overall that took me just 20 minutes and that's not because
I'm the deep scheduler expert, it's because I care. 

It's really not the job of the maintainer to point at that or figure it
out especially not with the knowledge that our maintainer resources are
anything else than abundant. Even if I can't figure it out on my own,
then pointing it out and asking would have been the right thing to do.

Instead of working around it and conveying the message "shrug, it's not in
the scope of my project, why should I care?", it would have:

   1) removed technical debt

   2) not added more technical debt

   3) followed what documentation asks people to do

   4) told the scheduler people "hey, we care about working with you"

It's a trivial detail, but it illustrates the tiny bits which contributed
to the overall rift.

Here I really pick RT, not for comparison, but for reference. RT was
certainly exposed to resistance, ignorance and outright denial. We sorted
it out by working with the people, by going the extra mile of mopping up
technical debt. Setting this as expectation is not asked too much.

As I said before: This is both a technical and a social problem.

As the social problem became prevalent over time the technical problem
solving got nowhere.

As a matter of fact both sides contributed to that, and that cannot be
resolved par ordre du mufti.

The result of that would be a even deeper rift which turns 'work it out in
tree' to 'work around each other in tree' or worse.

There is interest from both sides to get this sorted. At least that's what
was conveyed to me. I'll make sure to hear it from the source.

Thanks,

	tglx

---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4344,7 +4344,8 @@ int wake_up_state(struct task_struct *p,
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
  *
- * __sched_fork() is basic setup used by init_idle() too:
+ * __sched_fork() is basic setup which is also used by sched_init() to
+ * initialize the boot CPU's idle task.
  */
 static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
@@ -7579,8 +7580,6 @@ void __init init_idle(struct task_struct
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	__sched_fork(0, idle);
-
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_rq_lock(rq);
 
@@ -7594,12 +7593,7 @@ void __init init_idle(struct task_struct
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
-	/*
-	 * It's possible that init_idle() gets called multiple times on a task,
-	 * in that case do_set_cpus_allowed() will not do the right thing.
-	 *
-	 * And since this is boot we can forgo the serialization.
-	 */
+	/* No validation and serialization required at boot time. */
 	set_cpus_allowed_common(idle, &ac);
 #endif
 	/*
@@ -8407,6 +8401,7 @@ void __init sched_init(void)
 	 * but because we are the idle thread, we just pick up running again
 	 * when this runqueue becomes "idle".
 	 */
+	__sched_fork(0, current);
 	init_idle(current, smp_processor_id());
 
 	calc_load_update = jiffies + LOAD_FREQ;



