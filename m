Return-Path: <bpf+bounces-34127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACAE92A9CF
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 21:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9ED71F227E6
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780FB14D2A7;
	Mon,  8 Jul 2024 19:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaFLwqRV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A614AD10;
	Mon,  8 Jul 2024 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720466971; cv=none; b=scrmIGKgJ4lFXY2Q5A996/yyi7HAR0vwQfBHcBQDMLKtu1+J0sLAOr9mUgS9j4+/jAjSzFvvF2C5rjZzoK8aUXlAUy4W5hsihZQLE4eNiEoeYz31bvl/j82fLyIjDf/sVoHLZz9t22FelhYXXkDTI+6kTObCjIy2vYI0WJK2hzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720466971; c=relaxed/simple;
	bh=hvfcFq+RhHBIafO6zqI+Oj5jKR3KEkoCbyXd0TVIjlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAYtGfFMHqSAZ9kpu9geTYZYvusduFOnCsT8S3sF97aaU+t26z392k3hPOIuGCUmQGL8sCy9FzIFI0alne2wtiqA7A1WgxlEd8Hde8hvDXUDCMQ8CzUjX/Xv3MFAmrfzitJLK+XrFpgL0/2tGHN1wIHJ2u9Qh01cnalE3RnUQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaFLwqRV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-77d3f00778cso212888a12.3;
        Mon, 08 Jul 2024 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720466969; x=1721071769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWA69OCwnmf93mOPUresyAYLqJ69nFaplaBAWlh6EJs=;
        b=MaFLwqRVISNjUj2wBTg22YTVhGeSsRvasjXnhz9wIt9NEU3fDVBook5RlAWlg7RULr
         R6+nGpNG4vIHHlokWwzyQHi+yN0XuTSlsTP950JAY3iZ78MbDFCqjLSpP5qz2OLRdAsH
         FlkoOhQoI2OqGF3b8YK4eL6umc+KW3ZT2OZHxi4RdHpWurbP0lGkk85yL918XL3F3jsA
         l7yLLFwyWCQ6R+3nGX7i3UHkk7+M+cvg7eFnvm93wKC/5tst1V27d0RGG+2igXkjk0kX
         KOgG17rku1E9zfHkvNjBARjEiIsiq0CMUvloCICr3uDG1NrVQkSGg3Jx9aCcDxKVjziD
         7OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720466969; x=1721071769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dWA69OCwnmf93mOPUresyAYLqJ69nFaplaBAWlh6EJs=;
        b=gCO+JFS9zNYtUOjjDuciXCf0qFtRTr1HbOZVndTnZQbNwYWqa2F/uoIW5KixflRaAw
         nLgSFpLNhuGN5PQMenMuSBpyvHiHW8Iq71q13rz+TxX8wZcJufcTMu7ePrQwphz0UyYo
         ivGlRVlQ3jM1n9BUKo7YpWsov3K3oENyxFdYUn5TQzS0j6Uu1Tt/wMrWGy+/GwV6BBVG
         w/NYr/f1WLtJIMnz+RuOkzx5A7DiJdkpN20jnzqWH8YyU2IvfcyQQZtza1QSW7Umb304
         Eaw7sq7IKe7dKTBjZFhSryOZrv66m9Jc4BgMDI0e218I8T3v05Q18lb/1hKWIYEFfmLC
         sm2A==
X-Forwarded-Encrypted: i=1; AJvYcCU/Xg2vEh2lSO9+KmTnund3ADdvePsAI0UutS0MtGnJth+aPXjWv7CvxvP7jFP+lV7n9KE4HYKqS6xhlgy7ZrDUetqGII6vPHmZQnCSOwwkwS0qWdyY+cdG1IWxFCUj41/b
X-Gm-Message-State: AOJu0YzxUkDIGhTr6BiymrQfTTZ6kKHuQtG1kIruE1QftZ0tvngV5bvm
	c5NIQAyYNdb4y+/RGka82CT41vR9B2g6YKqtbpxHFcnwDvKH72qP
X-Google-Smtp-Source: AGHT+IFKU0Rv3ZsXkK3+TO67PIvDnwUXwpsZqzgXZ30ovAVccORyIgPePH4wncI7/a3i2Y32/HYc4g==
X-Received: by 2002:a05:6a20:9145:b0:1c0:f594:198c with SMTP id adf61e73a8af0-1c29820c067mr497789637.11.1720466968675;
        Mon, 08 Jul 2024 12:29:28 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b30b9sm240356b3a.178.2024.07.08.12.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:29:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 09:29:27 -1000
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
Subject: [PATCH v2 sched_ext/for-6.11] sched_ext: Account for idle policy
 when setting p->scx.weight in scx_ops_enable_task()
Message-ID: <Zow-F1SsJEGyWttX@slm.duckdns.org>
References: <20240501151312.635565-1-tj@kernel.org>
 <20240501151312.635565-5-tj@kernel.org>
 <20240624102331.GI31592@noisy.programming.kicks-ass.net>
 <ZnoIRnCZaN_oHQ6N@slm.duckdns.org>
 <20240625072954.GQ31592@noisy.programming.kicks-ass.net>
 <ZntZcRgm-zok7kyb@slm.duckdns.org>
 <Znt6sLf62JTIdGxR@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Znt6sLf62JTIdGxR@slm.duckdns.org>

From e98abd22fbcada509f776229af688b7f74d6cdba Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 8 Jul 2024 09:19:14 -1000
Subject: [PATCH] sched_ext: Account for idle policy when setting p->scx.weight
 in scx_ops_enable_task()

When initializing p->scx.weight, scx_ops_enable_task() wasn't considering
whether the task is SCHED_IDLE. Update it to use WEIGHT_IDLEPRIO as the
source weight for SCHED_IDLE tasks. This leaves reweight_task_scx() the sole
user of set_task_scx_weight(). Open code it. @weight is going to be provided
by sched core in the future anyway.

v2: Use the newly available @lw->weight to set @p->scx.weight in
    reweight_task_scx().

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
A slight adjustment in reweight_task_scx() to match the new load_weight
argument. Applied to sched_ext/for-6.11.

Thanks.

 kernel/sched/ext.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 525102f3ff5b..3eb7169e3973 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3237,22 +3237,23 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 	return 0;
 }
 
-static void set_task_scx_weight(struct task_struct *p)
-{
-	u32 weight = sched_prio_to_weight[p->static_prio - MAX_RT_PRIO];
-
-	p->scx.weight = sched_weight_to_cgroup(weight);
-}
-
 static void scx_ops_enable_task(struct task_struct *p)
 {
+	u32 weight;
+
 	lockdep_assert_rq_held(task_rq(p));
 
 	/*
 	 * Set the weight before calling ops.enable() so that the scheduler
 	 * doesn't see a stale value if they inspect the task struct.
 	 */
-	set_task_scx_weight(p);
+	if (task_has_idle_policy(p))
+		weight = WEIGHT_IDLEPRIO;
+	else
+		weight = sched_prio_to_weight[p->static_prio - MAX_RT_PRIO];
+
+	p->scx.weight = sched_weight_to_cgroup(weight);
+
 	if (SCX_HAS_OP(enable))
 		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p);
 	scx_set_task_state(p, SCX_TASK_ENABLED);
@@ -3408,7 +3409,7 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 {
 	lockdep_assert_rq_held(task_rq(p));
 
-	set_task_scx_weight(p);
+	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(set_weight))
 		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
 }
-- 
2.45.2


