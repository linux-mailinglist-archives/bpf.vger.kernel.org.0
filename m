Return-Path: <bpf+bounces-32946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BAD915846
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5DB1F263A7
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBA219D069;
	Mon, 24 Jun 2024 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFkXWOX0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C38249643;
	Mon, 24 Jun 2024 20:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719262313; cv=none; b=E0d3a5vVUQoI5t8VPE50TQ3JnKmSLr3dWCk5TjfVKiptN1PAbNIpfuBfS+PQsv1ONf+goRp+3yRRNKC7Pjb2y66dr7nMWvHwOY2WumLo6n017zbMs+MFJgH+r8M0L1s00Tz8adpXLnKV042Om0BC3sYas6LaPnLdI9/AU7u5x8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719262313; c=relaxed/simple;
	bh=MT5Wia1i4dZ8rj+Kidfa2cn+Trhp/5ABwO+bHaLIUn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nu0DsoF7uTsxN9L2x5y8gk2qJ2nXVez3XBvv1EYRuGjTBYPFxSqhlG+YULCj1fsmMlL9m2M7EQmVcK5wzCk/hOz0XhhE6c4KwvQ3BfoV5vSn1Mg1550J9isOOYRYlI7wC8nYewyUCImyjW/RBGaWIWUjO5uOgwhCIzg0HPummes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFkXWOX0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6a837e9a3so29423005ad.1;
        Mon, 24 Jun 2024 13:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719262311; x=1719867111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U8ziKKiWGGV++TuxU8QDVnIeJNZ8CIWRoVxMX01grg=;
        b=LFkXWOX0JNrSGLErN4HCvz62IuCesPl75Gc1jVewGc+7GZbIHSSz7U/0V3ZhJTS/qj
         p1DxZK+ODmJQAq5GipqcBT/6XiZoTQhCuzL3T9y5qKq/jifHbMbLjRcp3U+75REg9nQF
         DOlpQruSGta2eVL4Q2ikrUyJizdsr76L0690SjlqfbzNmBFHisg8fkr74CpP5erEnXW3
         GvP6Z5L0vQzmFx+9KI0NPp1i0nJpl0Q9PZ3XZlrpekEN8FG8Aq6Pzcx8SC6wKl0L0j4+
         L80dUvcl0e2nWiPfP0pHEXYeYYS0hoxgCXOeSO2yZ+3/AIZbjw+SjLnGHzZLpE0G7dcn
         ErBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719262311; x=1719867111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5U8ziKKiWGGV++TuxU8QDVnIeJNZ8CIWRoVxMX01grg=;
        b=fEoTwN3Hk9JKx0evwZH859LE9wMk1BdfiHt8zU619oaIiMUrGHkizAvYNNe25vBjN1
         Au5g4Tgcn50IzuAZU8m1i7HUwh0yl+RWtwr/c1jcg5uC6GWq6bK6mh2Wafv4AiQPlxjv
         bLK5RAFugj12zYQJ4PvkkNuBdxQ59ii7zEasowGKnKupHQWAJmAn2YMSAPWQY2MYtrOp
         bR7C1kNszDIM8PXpSOOGp6qvDPcNlAod7Wm1kKHgfOQ+xXGZSlOk7AGeXRSwnp7ctTQZ
         pzGZeydNW5LPIWWBADEWcNdQhtsrCExGogFOt4M/1Yjh1ZZkTYBV/PRrlJyWuEkiOdPV
         3tyw==
X-Forwarded-Encrypted: i=1; AJvYcCUy3BVbz/AQPG+ZDp1kGEG8c5rOa9wvQmlyK8WMZbgDMYTadmTj4gzC2CNNCCYMt9nC74YhJey4lxk9BuTRb8ijifXo2CVIRDgr7fsQteHjbaRLMIMpkC28SaAScGDVNvsG
X-Gm-Message-State: AOJu0Yz784ctL9IBsDodOxSeTZMeQZaeXpTdzoKuiEKsJKDfsYYsdZGI
	mpTE+bJP7LZepAXWKaUaCbmsKN6AAA36X32q/IuPOLQey9T1ImEf
X-Google-Smtp-Source: AGHT+IGgeb91oYN1ua6ArSpKyx0y7hkN231Dlnz9zFyOTmJDR82h5utHo9ody6RaWApIV/nt2Qnpow==
X-Received: by 2002:a17:902:b187:b0:1f4:9138:8178 with SMTP id d9443c01a7336-1fa2408224bmr45126685ad.49.1719262311284;
        Mon, 24 Jun 2024 13:51:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa37e4b5b9sm27308625ad.260.2024.06.24.13.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 13:51:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 24 Jun 2024 10:51:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, andrea.righi@canonical.com,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.11] sched, sched_ext: Simplify dl_prio() case
 handling in sched_fork()
Message-ID: <ZnncZcJFbN86-b4Y@slm.duckdns.org>
References: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
 <871q4rpi2s.ffs@tglx>
 <ZnSJ67xyroVUwIna@slm.duckdns.org>
 <20240624093426.GH31592@noisy.programming.kicks-ass.net>
 <ZnnUZp-_-igk1E3m@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnnUZp-_-igk1E3m@slm.duckdns.org>

From: Tejun Heo <tj@kernel.org>

sched_fork() returns with -EAGAIN if dl_prio(@p). a7a9fc549293 ("sched_ext:
Add boilerplate for extensible scheduler class") added scx_pre_fork() call
before it and then scx_cancel_fork() on the exit path. This is silly as the
dl_prio() block can just be moved above the scx_pre_fork() call.

Move the dl_prio() block above the scx_pre_fork() call and remove the now
unnecessary scx_cancel_fork() invocation.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>
---
Hello,

As this is pretty trivial, if no one objects, I'll apply this to
sched_ext/for-6.11 after a bit.

Thanks.

 kernel/sched/core.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4583,8 +4583,6 @@ late_initcall(sched_core_sysctl_init);
  */
 int sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
-	int ret;
-
 	__sched_fork(clone_flags, p);
 	/*
 	 * We mark the process as NEW here. This guarantees that
@@ -4621,12 +4619,12 @@ int sched_fork(unsigned long clone_flags
 		p->sched_reset_on_fork = 0;
 	}
 
+	if (dl_prio(p->prio))
+		return -EAGAIN;
+
 	scx_pre_fork(p);
 
-	if (dl_prio(p->prio)) {
-		ret = -EAGAIN;
-		goto out_cancel;
-	} else if (rt_prio(p->prio)) {
+	if (rt_prio(p->prio)) {
 		p->sched_class = &rt_sched_class;
 #ifdef CONFIG_SCHED_CLASS_EXT
 	} else if (task_should_scx(p)) {
@@ -4652,10 +4650,6 @@ int sched_fork(unsigned long clone_flags
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 #endif
 	return 0;
-
-out_cancel:
-	scx_cancel_fork(p);
-	return ret;
 }
 
 int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)

