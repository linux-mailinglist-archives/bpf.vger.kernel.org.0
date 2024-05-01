Return-Path: <bpf+bounces-28333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DB48B8C7D
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EDA1F232F9
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2E812FF63;
	Wed,  1 May 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9bb51/p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A312FB09;
	Wed,  1 May 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576406; cv=none; b=ZCTp31MfAnOTmegUbEDotDy4eY604LXyl3EoG6dQ5J05cu9K/le4PATAwtuw223C8Yag0LA7YY/3TTk/Qibw/MuxabAtKGLdosLiHkP/cW5RQMZmPcwgA+kbmCGyyEydgeREJiIKR38sqY0sVWeDI69y0hqvYg5Yf30sCfws8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576406; c=relaxed/simple;
	bh=6nIutmRNFd0r49yfIngp+M0hG56ty8wRFB/PjeZKWbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2bBKurhKzYR7Dm190dRMzIp1zKZnAwjge5nPWqXEgXBm+WtbBt8WEHsu5X7T0jxYpMYQRNjhJVDWqoRSg+Oc8ddPBEn0J/h5GZBRP99hLKOFpv4vrudIiTT3YkUI/L4udkilG8zImAaSKJcrFEYZn2+qWe/fj74NSW7jynEhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9bb51/p; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3f17c6491so57021745ad.2;
        Wed, 01 May 2024 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576404; x=1715181204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3ZT9Rw/39D/TLYwSmpsvTvswHfmxEgGNOtx5e567jg=;
        b=H9bb51/p4eicTajgMkXGOOmxolHS6JPkXxnfYC1DjvWjv24cljF/ciPtDXc1ctlICA
         1Wy3q1SUASf+nz9P5bsGw+zvS1yTug5RT+BA0pbmXo4jOiPZ8O45KRZl13Qdms4+n8Or
         8etEWA/KRJ7ee5mADKFjtiUQLiubq/5djvn337qT6UJn3k3QLfPUg4gXHmJldmcbbEGc
         5Z0pirov0J9LGqdRQH5B1CmvznWDd52I90v9mJIRMvKy293Lkg9DBkfYrZH0USqGgNiy
         iOFcZX6EUkVvfVijeZCalhPllHPuHeQ2IYF3f+9VmC676jcc2a6X/hgAerf6eEqbnUnh
         S8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576404; x=1715181204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3ZT9Rw/39D/TLYwSmpsvTvswHfmxEgGNOtx5e567jg=;
        b=QIPWmae7Fdu5T5KmTWu3NpM9WjnTIPUVoyV9mK6lfUIxI4SLhFe96TBJvbV27N8ba8
         WY6TwWMdRT+017SzqE/h28v/ptU2xQapI6vJpq3PNYEhHI5rEMtzmuFHfrSbXFW/6fcW
         rkInkL221WscNn9VXxjVCb1LByxl/Nl6gq8045DN7iFRoA1oZnIthReNPE0qTFFuMkPC
         bI8iA8xqzwVpQWmEXRe5tAWgLWD0XBEDnA+pWnAtfWj0NmGccLyB9opfJOsb1aZK1BMs
         wOrrAcJHQfp5ebpmOpDzv/oes+22NpOUd1PWS9IDj+cez03b52IhqWx0xvwj7aH2FYW5
         im9A==
X-Forwarded-Encrypted: i=1; AJvYcCW6GsKywcsSXJD3BUIOBoOdzftr+8VHg1a6Dn16PYjRG9sYznefOxM8Bn7PDzV3BVTQ+2z0Etep6xaN/xoc2KbXr1QL
X-Gm-Message-State: AOJu0YwGpSf8E3h1KvSja8ygP2TkAnd8toCDk1hK15XxFIINTReD57es
	Jdvw/PcUodACplBmJwD2GlxXPFt437mcnAO/eAK5nqdllL1VzV3O
X-Google-Smtp-Source: AGHT+IGZG/SLu4hiMtEBOS8RnmvQ3FPpmDYipPU4/WJ2UP9IVJT1euOuBbbITM+ELKyk0WpiXyTs0Q==
X-Received: by 2002:a17:902:bc42:b0:1e2:a5b3:e5 with SMTP id t2-20020a170902bc4200b001e2a5b300e5mr2481342plz.32.1714576403660;
        Wed, 01 May 2024 08:13:23 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001e512537a5fsm24318600plf.9.2024.05.01.08.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:23 -0700 (PDT)
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
Subject: [PATCH 03/39] sched: Allow sched_cgroup_fork() to fail and introduce sched_cancel_fork()
Date: Wed,  1 May 2024 05:09:38 -1000
Message-ID: <20240501151312.635565-4-tj@kernel.org>
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
index 39a5046c2f0b..02f12033db9c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2362,7 +2362,7 @@ __latent_entropy struct task_struct *copy_process(
 
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
-		goto bad_fork_cleanup_policy;
+		goto bad_fork_sched_cancel_fork;
 	retval = audit_alloc(p);
 	if (retval)
 		goto bad_fork_cleanup_perf;
@@ -2495,7 +2495,9 @@ __latent_entropy struct task_struct *copy_process(
 	 * cgroup specific, it unconditionally needs to place the task on a
 	 * runqueue.
 	 */
-	sched_cgroup_fork(p, args);
+	retval = sched_cgroup_fork(p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2541,13 +2543,13 @@ __latent_entropy struct task_struct *copy_process(
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
@@ -2621,10 +2623,11 @@ __latent_entropy struct task_struct *copy_process(
 
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
@@ -2663,6 +2666,8 @@ __latent_entropy struct task_struct *copy_process(
 	audit_free(p);
 bad_fork_cleanup_perf:
 	perf_event_free_task(p);
+bad_fork_sched_cancel_fork:
+	sched_cancel_fork(p);
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c166c506244f..b12b1b7405fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4817,7 +4817,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	return 0;
 }
 
-void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
+int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
 
@@ -4844,6 +4844,12 @@ void sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
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
2.44.0


