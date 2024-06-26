Return-Path: <bpf+bounces-33118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4040B917617
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 04:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF091F2394C
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 02:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79691CD02;
	Wed, 26 Jun 2024 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgfP92xn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516F20B3E;
	Wed, 26 Jun 2024 02:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719368372; cv=none; b=YPV+f+PUbCdwN+fDL+0EpCUeQ0Cfha1uva3LcCpzlsMlws6k5bh6nJRwGZNLfXZHimgglCOc2sHMNG/wBkgl2344OnEhlDhhXf36dZ9mI3XjBQNpHGyuvPwhaak/Fk9uA41CYjFnYckbYKK4LZR99+T9ij80jkc4kdCZ2Bp28mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719368372; c=relaxed/simple;
	bh=Q45kZTBfiG8hDcatQJuCmoauf4+RaCp3NWUjeVZuF6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iijdgrDc52cVQI3lNM8rc1Z7vxUVx3PFN2hQOnCY0mLVgPseKA2ClxJ1KmAAEtV98i2fhSjoy/HdPZS9xpwLONP3yr8vYMlt5MWSMCbRVzldGIe+MEX72RXvAS4aUuW8B4WCrVEYEl9nlJa57OejLWWtL6GdIxNlo1Ruzr5N6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgfP92xn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c8065e1666so4186011a91.2;
        Tue, 25 Jun 2024 19:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719368370; x=1719973170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMkv31Hr+tnMt0F7HufYJRdmiZYrMI8z3KDOLdXJ2+c=;
        b=KgfP92xnYfnwXMI/YlW3jJtUuvAEN3khkT6+EOPPJ9s/M9mV7AmjwlfQJ/YDy3jy9Y
         ssXx2MqbluaUQRipbq2T7YJQfNOAyWnHJAU8CBnQaWNazL5Spg3f1ynU2BC5RShQttdu
         WmdUkv72IilD3B+REopueOx0VeWnQu2REp4JKbtEBYYhh0kQ6C8Z8jsGYGG+VGw7lZ1l
         c4AXqJBE+8Ox2WrmBfGURTC6YsjQEWJRB36ZPJ5dMU9zgepME1mxdL2Ab15Pi7sqqjNc
         jvbM2GMLmfiv32XZxptGwhR2PZ3TxnsZnnpGgat9M7RAKXwAEEURaj5j7ECPrEyUwUG5
         aqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719368370; x=1719973170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMkv31Hr+tnMt0F7HufYJRdmiZYrMI8z3KDOLdXJ2+c=;
        b=Q+7ehLxkXNej8sNWkW4LIMtE5KHCCOKmVPjdJPKkBZbFZ3ptCFF84yLkR3jJL5K2df
         +/9JC5tL/fv1q33tuVTEmzL6vL7vEdUAyhLhiJAc/brZtoe3i6iGLB0mpTsa86qplp8i
         iAitnAzZwVW/uD0yYALqaZW6a8OWfZ4yu1uCFTSV5ZeTJQ7a61saCpDcaXAHhw/tGDu8
         27yachXPCqnDoWyZtOuZ2CzE3kyUG7XIVdfjADp9YLsuNVf+BF5jtOFPxfO/gzhYNO2F
         8FKX9HLSEnCaDKGplfYqMf4EQbZewp/+Ta6aaolrqVh63cEQfby3iGMuQRQmtiVjjTkm
         EByg==
X-Forwarded-Encrypted: i=1; AJvYcCUqhLN1QMfiRDoZIXRiNW6sKa9zOPyTaWQrGwpvhHdzOqQw3O/fvQsTAfONXM8dU8j0f4Ll7Ew4ngswTKzTd7nY44EmM/WXPYj7N1iHj5pht+PcqPTMBb3lPYBz5NQLiC9y
X-Gm-Message-State: AOJu0YxwSaQk12YFDe+pS3MehSepzFYumrQCzUSDD9QywNusCevycIVW
	2u3VlVinRhL1P0a3LHeHW68a6ZkU3ua+THbSCTaFTnOj/CZDOFs/
X-Google-Smtp-Source: AGHT+IHlIDU4FgJw3S0iNrT3IBgDz72/xf1HWMR6E1bKu+QAnu7UoZuOovVQa42UZY6fekzG4E+2wg==
X-Received: by 2002:a17:90b:4001:b0:2c6:dc3b:d6fd with SMTP id 98e67ed59e1d1-2c850574047mr8986225a91.31.1719368369846;
        Tue, 25 Jun 2024 19:19:29 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c8d807cdd5sm347274a91.44.2024.06.25.19.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 19:19:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 25 Jun 2024 16:19:28 -1000
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
Subject: [PATCH sched_ext/for-6.11] sched_ext: Account for idle policy when
 setting p->scx.weight in scx_ops_enable_task()
Message-ID: <Znt6sLf62JTIdGxR@slm.duckdns.org>
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

When initializing p->scx.weight, scx_ops_enable_task() wasn't considering
whether the task is SCHED_IDLE. Update it to use WEIGHT_IDLEPRIO as the
source weight for SCHED_IDLE tasks. This leaves reweight_task_scx() the sole
user of set_task_scx_weight(). Open code it. @weight is going to be provided
by sched core in the future anyway.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
This is a related fix for sched_ext.

Thanks.

 kernel/sched/ext.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3237,22 +3237,23 @@ static int scx_ops_init_task(struct task
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
@@ -3405,9 +3406,11 @@ void sched_ext_free(struct task_struct *
 
 static void reweight_task_scx(struct rq *rq, struct task_struct *p, int newprio)
 {
+	unsigned long weight = sched_prio_to_weight[newprio];
+
 	lockdep_assert_rq_held(task_rq(p));
 
-	set_task_scx_weight(p);
+	p->scx.weight = sched_weight_to_cgroup(weight);
 	if (SCX_HAS_OP(set_weight))
 		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
 }

