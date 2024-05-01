Return-Path: <bpf+bounces-28337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E778B8C87
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E105F283BEC
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EDD130AD3;
	Wed,  1 May 2024 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxnMjhaC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC79D130A45;
	Wed,  1 May 2024 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576413; cv=none; b=SrTJ8EOIJCN/zlflTohwOu231O18a3WJ+YGxJIFY+uJMBq1TYKbTlISAba8gw9KdPCBDH36uOKCUja5gu7ZvdCIJaorCKppAWxadBRzeDEdgwqGa9KByuNswNyA3nidw/Sk6WADSkHut6Nuzmq+7F4EzLf2Q5m+j9mC8LW9sv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576413; c=relaxed/simple;
	bh=j820JoBr7faB1ryPDnWn+se+mO/wYqBjob/dLQlGmdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzIo5ZUtA1qsZhzA4O+XegoFGmZ7NThRJrwrs7nX64FNbLHmUmVTwWaa+Pz1JC5ZgKqJzRX5WwGyuDKDNTc5xdAH7fhzQiBmvvRpzdStv+jhiTS/nSeU/vWvqDr/sPYHFetus40XhGn1NS2ys+kkVHU9pydNAKTordQ1gRFH9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxnMjhaC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so6979338b3a.3;
        Wed, 01 May 2024 08:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576411; x=1715181211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBUuO5H/1ZgZzE9Fv8hIERyARixLKLWiYIZCk6ggwEE=;
        b=lxnMjhaCHNDHTq/T5BwVWysy+5chFCHrebTCSWZRKtkFylXu2lslKUx+eltSGwkIpc
         EznSzxeoBmDWWpUQsgl5/+3mcFqIN/wmnM432xhaHWr15mobfigYFcv9Mu4wukGXbvDZ
         NG6UCDQu/Y2GqcQ/rb2wHLYmLwWaurouOpOz1sAhY26o9d07M0qKdofy8Y1AzELr81hZ
         pRxYL/0u0vD9UoWP6TzB1DwAbtaAeegQaYlYMJ8GlrgeiFQZlxNL2aE/NPi1nsXhZk71
         py3gqGQ+oCyI8iH8Gq1w86gTD5uD2W7G+AZ16kEYwml23gr1QkmMKv5FrBNX3S2QbG0E
         Be5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576411; x=1715181211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBUuO5H/1ZgZzE9Fv8hIERyARixLKLWiYIZCk6ggwEE=;
        b=fQGE2CigMAf/FBcoHW7nilr+78L46E4GcO2sWSsWnoizmw1OcIdurs1/W+8IVW552Q
         MgAVDo0wULfzA8+AvAKJlnqa+2uOzR/w1eL/mY5D+1XLwZRZhkuEAxRpLzYvqbk9aXNr
         jfxb8bWClZtGqNC5Yyy+ys/jU+D16qh47BBookoZD3zNvCfbyQ6k+we/2ycLbCCnuxvs
         IByykKqAF81+8wcjh0h1H8lG8YqwxUAEFovVCcrZ9I7vf95OfsexkVCfWwoBqbnH4hKz
         CN2pllmfTdHEMwa1c8dc06DO5u8QYm26+SsnnS4oKCFpIlIQeiVJggpgErUu8Nthxhpg
         FfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3FyY2Wix5lromS2U9fiKhGvG7oFl04QjsaTI2JPhDsfk5ZmfI6jfKaVENyTePtc+6mmJ1VTU3UUKgySGn7tT/8XO/
X-Gm-Message-State: AOJu0YwirYiMBp+BIBfI1k79GR5ZezU6WyCkTeb29Np68B5duZDJUlGO
	iwau6FsatQ+tnV5DE5+z2xkId9nX14m9uF98MJXIRD3K6EhhIb/I
X-Google-Smtp-Source: AGHT+IGX15KymfOh825bnE3hBAarZqJblEjGweReVbWNmZhYpqzXOVEgeZxu6Aw1ccnTVf1i+IP/fQ==
X-Received: by 2002:a05:6a20:9493:b0:1af:654d:f1ba with SMTP id hs19-20020a056a20949300b001af654df1bamr2860433pzb.40.1714576410903;
        Wed, 01 May 2024 08:13:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id p52-20020a056a0026f400b006ede45680a6sm22718361pfw.59.2024.05.01.08.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:30 -0700 (PDT)
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
	Tejun Heo <tj@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 07/39] sched: Expose css_tg() and __setscheduler_prio()
Date: Wed,  1 May 2024 05:09:42 -1000
Message-ID: <20240501151312.635565-8-tj@kernel.org>
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

These will be used by a new BPF extensible sched_class.

css_tg() will be used in the init and exit paths to visit all task_groups by
walking cgroups.

__setscheduler_prio() is used to pick the sched_class matching the current
prio of the task. For the new BPF extensible sched_class, the mapping from
the task configuration to sched_class isn't static and depends on a few
factors - e.g. whether the BPF progs implementing the scheduler are loaded
and in a serviceable state. That mapping logic will be added to
__setscheduler_prio().

When the BPF scheduler progs get loaded and unloaded, the mapping changes
and the new sched_class will walk the tasks applying the new mapping using
__setscheduler_prio().

v3: Dropped SCHED_CHANGE_BLOCK() as upstream is adding more generic cleanup
    mechanism.

v2: Expose SCHED_CHANGE_BLOCK() too and update the description.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 kernel/sched/core.c  | 7 +------
 kernel/sched/sched.h | 7 +++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9b60df944263..987209c0e672 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7098,7 +7098,7 @@ int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flag
 }
 EXPORT_SYMBOL(default_wake_function);
 
-static void __setscheduler_prio(struct task_struct *p, int prio)
+void __setscheduler_prio(struct task_struct *p, int prio)
 {
 	if (dl_prio(prio))
 		p->sched_class = &dl_sched_class;
@@ -10542,11 +10542,6 @@ void sched_move_task(struct task_struct *tsk)
 	}
 }
 
-static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct task_group, css) : NULL;
-}
-
 static struct cgroup_subsys_state *
 cpu_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24b3d120700b..7e0de4cb5a52 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -477,6 +477,11 @@ static inline int walk_tg_tree(tg_visitor down, tg_visitor up, void *data)
 	return walk_tg_tree_from(&root_task_group, down, up, data);
 }
 
+static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct task_group, css) : NULL;
+}
+
 extern int tg_nop(struct task_group *tg, void *data);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -2481,6 +2486,8 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
+extern void __setscheduler_prio(struct task_struct *p, int prio);
+
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-- 
2.44.0


