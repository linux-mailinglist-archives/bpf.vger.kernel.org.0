Return-Path: <bpf+bounces-32436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCAE90DE1C
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C927E28477C
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373BF17A902;
	Tue, 18 Jun 2024 21:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9cVlf0F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD75178378;
	Tue, 18 Jun 2024 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745670; cv=none; b=WbOtUN2BENqtvwc2TrsoU2VIyzrUyca6qwOavgnutzsr6scaVsEiqWzkymkLk9ERG7OMJ2t4TO1Nn7l87Vwx9e/4YMT/6RWbEcAU+zo4oYy7Um/EAridgcIBvdSiyvvlFOSjaV+wglQe+cobIsMGV/cutrUlrUZ5a+AJdEN/Nss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745670; c=relaxed/simple;
	bh=+QtwKi+kP89WvlcLiOTExzVBZl4ggmDSoaoDB94028Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CX+vn7Do6YPaWKWMWgmgnwkt9nwdVRFYIEadd6s0RltcIVK4rpsZj06SLIEg3lQ2LF/mdWACmBnWqdFkLuVoLnwq4+DgEnOKSpzPySHh3DbVf7hRvh8+IVlCluUX4PdKuPL6N4Spp3uBGXLRM4aJQY8N3lwfvqrbPkVxua9Y9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9cVlf0F; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4c7b022f8so52264495ad.1;
        Tue, 18 Jun 2024 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745668; x=1719350468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EYU0KXc2hKPzGb5/drkRJI6mvXb3y/6Fnv2smccico=;
        b=J9cVlf0FVM1Z1VLQE11O6FaRgoT5BOVFMTGp7l9mSFG1wkZ+/Sb3yrM/QWp+A1tMH3
         1aA5pi0l+zyCgmLDuDwsF73ODtSBt39BNvwzPLURP26sOGtKFM0yAY2O160mfQb4t37H
         VdH2vF5t0THrOj9+pWdaY4YB+lK6zzA9nm0aJPQK3oqIhGduJB6xIxcM5o6Qo06DR7cS
         05tzjVOZBxB3C72JVJdhtUu/tuAzqfEObxp2P7B9gRinyObtg+Cyg9tVPP6KXKQSzYHa
         VDbsTlZV6TAxKgJkD9Jr00WinKS0Dt/gA4uOGnW86V+L+FV0syXl9uMZ2k06U8gKWcmU
         QqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745668; x=1719350468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7EYU0KXc2hKPzGb5/drkRJI6mvXb3y/6Fnv2smccico=;
        b=qyvxaPtpmQqThIEHw0VC1LAU3uqaahhEGtX8fuWdwD6Um7+QKDMCY93u8Xe3TU4UjM
         zD2zOoBB9wHgXOLTQztXewZHX1t+kZ4iKlSLVFRs+cklqtxKnqGOyDbUCZ0R7BuOs9pF
         ZRFNCwdSTRH47yt+ZfV+TWIezZRXfrgDX9tj9kIyBsens5gh2jCqKagiW/JIakBVNpWb
         ugTqhdggJCUZAW+GlPi7xH1CVopDEbHFmNfh5n48iA7VytF4mjEV1ruCJQgcyJHkntoJ
         poAN1+PNn+8xog9SAmcM5UHKDmkLGoBlUGgFqGtrQEx4iyMhzu2pD4oZRrKu+KNr0UZw
         Cmng==
X-Forwarded-Encrypted: i=1; AJvYcCW8x8qpYgAsRRx6ojykLAjYxDg8+sAsnLucJAy4d8glGG81hi92NulyZTp94+fmI1srfmrMJXamYMSrckzfuU3ZpmEN
X-Gm-Message-State: AOJu0Yx8qnby6GZcrgjRSAkSghcsyyEuyPUNnsROk1DssRMzwt9v5aCn
	LoMlYz+akbydDBd/J52GiS5f0RpRcf19w+jyQvK6qc+VmvL0eNa2
X-Google-Smtp-Source: AGHT+IGL+JoYwoL6EkDLE+jQvN9sj8/y2dO1Vdjz55x7YoGqmUJCDAUyhQZdWt+UnGjv5X+ndVqBOg==
X-Received: by 2002:a17:902:c106:b0:1f6:ef4f:19b8 with SMTP id d9443c01a7336-1f9aa3bc6d0mr7893525ad.1.1718745668436;
        Tue, 18 Jun 2024 14:21:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e74c49sm101957275ad.104.2024.06.18.14.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:08 -0700 (PDT)
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
Subject: [PATCH 02/30] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date: Tue, 18 Jun 2024 11:17:17 -1000
Message-ID: <20240618212056.2833381-3-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new BPF extensible sched_class will need more control over the forking
process. It wants to be able to fail from sched_cgroup_fork() after the new
task's sched_task_group is initialized so that the loaded BPF program can
prepare the task with its cgroup association is established and reject fork
if e.g. allocation fails.

Allow sched_cgroup_fork() to fail by making it return int instead of void
and adding sched_cancel_fork() to undo sched_fork() in the error path.

sched_cgroup_fork() doesn't fail yet and this patch shouldn't cause any
behavior changes.

v2: Patch description updated to detail the expected use.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/task.h |  3 ++-
 kernel/fork.c              | 15 ++++++++++-----
 kernel/sched/core.c        |  8 +++++++-
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index d362aacf9f89..4df2f9055587 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -63,7 +63,8 @@ extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
 extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
-extern void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
+extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..e601fdf787c3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2363,7 +2363,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2496,7 +2496,9 @@ __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2542,13 +2544,13 @@ __latent_entropy struct task_struct *copy_process(
 	/* Don't start children in a dying pid namespace */
 	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
 		retval = -ENOMEM;
-		goto bad_fork_cancel_cgroup;
+		goto bad_fork_core_free;
 	}
 
 	/* Let kill terminate clone/fork in the middle */
 	if (fatal_signal_pending(current)) {
 		retval = -EINTR;
-		goto bad_fork_cancel_cgroup;
+		goto bad_fork_core_free;
 	}
 
 	/* No more failure paths after this point. */
@@ -2622,10 +2624,11 @@ __latent_entropy struct task_struct *copy_process(
 
 	return p;
 
-bad_fork_cancel_cgroup:
+bad_fork_core_free:
 	sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+bad_fork_cancel_cgroup:
 	cgroup_cancel_fork(p, args);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
@@ -2664,6 +2667,8 @@ __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b4d4551bc7f2..095604490c26 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4609,7 +4609,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4636,6 +4636,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	if (p->sched_class->task_fork)
 		p->sched_class->task_fork(p);
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	return 0;
+}
+
+void sched_cancel_fork(struct task_struct *p)
+{
 }
 
 void sched_post_fork(struct task_struct *p)
-- 
2.45.2


