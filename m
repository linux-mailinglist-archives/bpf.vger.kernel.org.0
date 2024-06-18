Return-Path: <bpf+bounces-32440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEB690DE25
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E8E1F24A64
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D2A1891A5;
	Tue, 18 Jun 2024 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8npDF/V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDE185E5B;
	Tue, 18 Jun 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745677; cv=none; b=WfqW/Xh7Pd8UcV2miekoPgMUAdsv8+o3J/z44lv5MBDIODGgeE5utyFsMPG2RqXaRkMx5nO21mN1H4eJZaV9O9TGyfo4NK2uodWndCAjHHfVgl0rY+IkEC/ySCnAwhds7Q03vovIXzXQcluN6adNTltDA9ZLPjq1iUr1mF7iR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745677; c=relaxed/simple;
	bh=NbQ9ylEVoddytVbiZEWXh1IeY5udxOAGIHFEdsQbmJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9OuiNBQ5/tzLPqk3W+oxTmy2IJUJ0lCsm/xf0aQyVyrq4wznvz+I73JTgrAUF65EJFEkfK/j8n5iCbAHLGP7l4pbLsVwNgbstTLPGrl0u0hEJaZTT28kb5ss38gELGjjMDm5bJVB8fcWakMgc0NGSwVKY86f0P86Ok7d40Zbbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8npDF/V; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-701b0b0be38so5322757b3a.0;
        Tue, 18 Jun 2024 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745675; x=1719350475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WO/m5rBk1460qhLUQ7sDRa98WaQxVJpEIcw8tWVOsc=;
        b=V8npDF/VFod++NSoQORC4p88GMH2915zBlZ/vOI23/uXBRuDRqpS5NsYwdAtvElLZH
         KHitMhOTdRHG4l+xyjFhbKm4yswX05buhEzrkW2QiFuI9WUPjUNGFs751jmsatLw2Var
         gOXbmIuodxup2iugxpD1eMpu9FFzxdcJ1TnZiAIcPNsz3Wvc4EySQwvcXKtm+154Bf3h
         E7TsdNXB10PwYt9LNIf7AWTg7g05cszvcgD4I9nJhF9nc2KYpdXWs8n/E6W7myJWycQE
         TzDny3MFa5i50dwpMAVUwqdl4KV4rnily5fV44fA1/JqsgnAJvzfSL1n4BHdPtCL/QfL
         xnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745675; x=1719350475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/WO/m5rBk1460qhLUQ7sDRa98WaQxVJpEIcw8tWVOsc=;
        b=XmWZzFsZSDZaUqlA6JpaDmol05Pd5UkLB804WO4123uoiYa04OTOJjPyhGduY639K+
         MRCeWuUgMoqG9f3ykTT4PjKNmly6uSfw/qp87LcY2fMgPhqbazpth88WnpW/N/mknviA
         QhVhkXsfk8UaGJ0Vjldawu7xJJN136u/TEXI5+DJVJzoDRbEaKm/b7dQ4czAxaZ/Af+E
         Z3JxasOZX1z4WRaMPiS2p3xyjI1+6XXs35Y5arI+CkasBdqP8JSJkVCdDx8wx6DhoFbW
         Hr5GeWD56/V5LNBth5El1SfKWODwaGJFnBrZkWxKs/WEbv+cW4xK6jeA2md1Ow3AAgKC
         /Scw==
X-Forwarded-Encrypted: i=1; AJvYcCVXlpeSlb3Iht3rg2/3GDzEKxMkmwwRm3OUIP0g9hF8ealAbQmizaAXpPWjO95FTxN8ZkIpc/NMhod/ML6/jk/CEXoP
X-Gm-Message-State: AOJu0YxC92pzFfXdRmqe4tnf0Og04tOAi7o6bYbb9IyVBNf2bTzoNrj/
	UX0jq0Nw1RjMlJ7yjJAfs9bsmCGaskqba2wk8vCZ9Eux3A+lVr3/
X-Google-Smtp-Source: AGHT+IFiO3OuFbKDFlkDAL/kycj1BdQoX+Pnnm3V012hdKWjuc6QpXkKPnL+bwHYLQEvwJVjFESM8w==
X-Received: by 2002:a05:6a00:23c7:b0:6e7:4abe:85a0 with SMTP id d2e1a72fcca58-70629c4f3b1mr1149466b3a.14.1718745675527;
        Tue, 18 Jun 2024 14:21:15 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6b110sm9423315b3a.153.2024.06.18.14.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:15 -0700 (PDT)
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
Subject: [PATCH 06/30] sched: Factor out update_other_load_avgs() from __update_blocked_others()
Date: Tue, 18 Jun 2024 11:17:21 -1000
Message-ID: <20240618212056.2833381-7-tj@kernel.org>
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

RT, DL, thermal and irq load and utilization metrics need to be decayed and
updated periodically and before consumption to keep the numbers reasonable.
This is currently done from __update_blocked_others() as a part of the fair
class load balance path. Let's factor it out to update_other_load_avgs().
Pure refactor. No functional changes.

This will be used by the new BPF extensible scheduling class to ensure that
the above metrics are properly maintained.

v2: Refreshed on top of tip:sched/core.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/fair.c     | 16 +++-------------
 kernel/sched/sched.h    |  4 ++++
 kernel/sched/syscalls.c | 19 +++++++++++++++++++
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 18ecd4f908e4..715d7c1f55df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9352,28 +9352,18 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {
 
 static bool __update_blocked_others(struct rq *rq, bool *done)
 {
-	const struct sched_class *curr_class;
-	u64 now = rq_clock_pelt(rq);
-	unsigned long hw_pressure;
-	bool decayed;
+	bool updated;
 
 	/*
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq->curr->sched_class;
-
-	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
-
-	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
-		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(now, rq, hw_pressure) |
-		  update_irq_load_avg(rq, 0);
+	updated = update_other_load_avgs(rq);
 
 	if (others_have_blocked(rq))
 		*done = false;
 
-	return decayed;
+	return updated;
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 656a63c0d393..a5a4f59151db 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3074,6 +3074,8 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) { }
 
 #ifdef CONFIG_SMP
 
+bool update_other_load_avgs(struct rq *rq);
+
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long *min,
 				 unsigned long *max);
@@ -3117,6 +3119,8 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
 
+#else /* !CONFIG_SMP */
+static inline bool update_other_load_avgs(struct rq *rq) { return false; }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_UCLAMP_TASK
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index cf189bc3dd18..050215ef8fa4 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -259,6 +259,25 @@ int sched_core_idle_cpu(int cpu)
 #endif
 
 #ifdef CONFIG_SMP
+/*
+ * Load avg and utiliztion metrics need to be updated periodically and before
+ * consumption. This function updates the metrics for all subsystems except for
+ * the fair class. @rq must be locked and have its clock updated.
+ */
+bool update_other_load_avgs(struct rq *rq)
+{
+	u64 now = rq_clock_pelt(rq);
+	const struct sched_class *curr_class = rq->curr->sched_class;
+	unsigned long hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
+
+	lockdep_assert_rq_held(rq);
+
+	return update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
+		update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		update_hw_load_avg(now, rq, hw_pressure) |
+		update_irq_load_avg(rq, 0);
+}
+
 /*
  * This function computes an effective utilization for the given CPU, to be
  * used for frequency selection given the linear relation: f = u * f_max.
-- 
2.45.2


