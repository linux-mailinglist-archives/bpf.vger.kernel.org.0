Return-Path: <bpf+bounces-28340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCA48B8C8E
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0DC1C22712
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52E1311BA;
	Wed,  1 May 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWL4fQJZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20551311A3;
	Wed,  1 May 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576420; cv=none; b=miPmJPu7HcFN4rDN81wTCaHw3Dl6/zW3VFZi3qfPuogjLhq51TVEYvv0ezSybFYM1DVJgkNhfjgvV5hqwK2IIGTlMENXe1UZYeijLQjdVKX+ogvNX1s+Bk6CylSOG4xqZP29uTLUCI+z6gftiEzQCL2pltEdIll/9sbSWo6zA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576420; c=relaxed/simple;
	bh=P0O+cHVKqzmeTTfPHOScr8Fm/OW2mvaU5BrHKVks43A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2JyiURTesc6NuqvVmpQ2KDHuURRi7yjFl0QBm5vbG8LhoR469fTolqMsFqJFrX4VXQKuptKFkmw/ZffHY27rVC/UVDhXlQ9Pfhbf6BhoTnfO9z8e2vTvhUI9ANCSTGbuxL1iHG38Xy2L7K5tWSgYiVmoyRHjVgSYhyl3qMODJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWL4fQJZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso4672720b3a.1;
        Wed, 01 May 2024 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576418; x=1715181218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICIINeNNGIWapDIPelhrVVJQptAEolERW6ebpcBXUO4=;
        b=YWL4fQJZ+1XlG4XMrjOfTOSze1g0LlErCTRydlzUrxo6OSMFlIG1MEvCglYSx6JVYM
         eh0P9QF/tHTH33xXYsXsjb7FeQR0gXDhZ9IkekHMNq2h/AWvviBlGjLylq/EepRgiqEs
         lVfp1zofbKSo2pfhvOe0v1GvvTXD1idoTUxUdA26uySnGlGEOoKoRFkKy6CKjzA86+0O
         zXa4aFShjpkj936A/5CKTCYNMTkEXMntVRVHu2VCGziG9IzrJFqTxV3Ou8tVmFeeA8EF
         uo+h0ARzxlytyLylx+6irauY28YyBzQl4jT0BVjp9c7vRJxnq634SUUrhwRNDSZYF0r+
         H99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576418; x=1715181218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ICIINeNNGIWapDIPelhrVVJQptAEolERW6ebpcBXUO4=;
        b=PKNLonFBEXewLe7M8FOfJz9dGCnwpKfC9OF8+zBY19vglSHW1OUwMoBmntlRoqw5ba
         GKgS+QwH3FcxyNZheiDi+lJb6pEzA+lEwgPE5wbtPu9H0NDAxUI6kCKWth0P0MqoaeuU
         7X+9Fco4ODXe2d3yu8OKI0ZTExz2IrXT3MtZWZRbHAfop3wT6UEJM8M4VKDUHt4nDif4
         xXC/nv019UNyakBZ0E0rUksvM/s8Jn33YgMwjVzyL4AnlbCD83vIrft62wgpN9KEagBT
         NQpqHiSNFPvchb78jPEM3z78SRYy3l0NniusA8gLhVgBcwkGAbebyimX5p6OxW2i6lym
         nmtA==
X-Forwarded-Encrypted: i=1; AJvYcCVMjZvh18jN6IF0+ZVAXeGLW+EH3rxhlmsesvR/rEm4Sqo0ZHvN6wkDVXxa/5hsdV+QF8Vn6k4iUF5PLzHI/QIuvb50
X-Gm-Message-State: AOJu0YxmNVFudSzBaeuoofGI7WyKAmbkqX7wHQ0iImdbocC6i00ItMun
	b9NCCc/Fb0qOgnAgCxgQ29Pt141zMExcEJ/J8fph93hIzQLAd62a
X-Google-Smtp-Source: AGHT+IHMbK2Aho62n+b9/PEQylKkvQ0C7iHMAsGU4fHU3JDoQJ2yB9XMM/aXrs/pWGxerLdX28XpWA==
X-Received: by 2002:a05:6a20:394c:b0:1aa:755f:1746 with SMTP id r12-20020a056a20394c00b001aa755f1746mr4212661pzg.22.1714576415939;
        Wed, 01 May 2024 08:13:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id b12-20020a056a00114c00b006ecfc3a8d6csm22645257pfm.124.2024.05.01.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:35 -0700 (PDT)
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
Subject: [PATCH 10/39] sched: Factor out update_other_load_avgs() from __update_blocked_others()
Date: Wed,  1 May 2024 05:09:45 -1000
Message-ID: <20240501151312.635565-11-tj@kernel.org>
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

RT, DL, thermal and irq load and utilization metrics need to be decayed and
updated periodically and before consumption to keep the numbers reasonable.
This is currently done from __update_blocked_others() as a part of the fair
class load balance path. Let's factor it out to update_other_load_avgs().
Pure refactor. No functional changes.

This will be used by the new BPF extensible scheduling class to ensure that
the above metrics are properly maintained.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/core.c  | 19 +++++++++++++++++++
 kernel/sched/fair.c  | 16 +++-------------
 kernel/sched/sched.h |  3 +++
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 90b505fbb488..7542a39f1fde 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7486,6 +7486,25 @@ int sched_core_idle_cpu(int cpu)
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
+	unsigned long thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
+
+	lockdep_assert_rq_held(rq);
+
+	return update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
+		update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
+		update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
+		update_irq_load_avg(rq, 0);
+}
+
 /*
  * This function computes an effective utilization for the given CPU, to be
  * used for frequency selection given the linear relation: f = u * f_max.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8032256d3972..51301ae13725 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9283,28 +9283,18 @@ static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {
 
 static bool __update_blocked_others(struct rq *rq, bool *done)
 {
-	const struct sched_class *curr_class;
-	u64 now = rq_clock_pelt(rq);
-	unsigned long thermal_pressure;
-	bool decayed;
+	bool updated;
 
 	/*
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq->curr->sched_class;
-
-	thermal_pressure = arch_scale_thermal_pressure(cpu_of(rq));
-
-	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
-		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_thermal_load_avg(rq_clock_thermal(rq), rq, thermal_pressure) |
-		  update_irq_load_avg(rq, 0);
+	updated = update_other_load_avgs(rq);
 
 	if (others_have_blocked(rq))
 		*done = false;
 
-	return decayed;
+	return updated;
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bcc8056acadb..ccf2fff0e2ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3042,6 +3042,7 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_SMP
+bool update_other_load_avgs(struct rq *rq);
 unsigned long effective_cpu_util(int cpu, unsigned long util_cfs,
 				 unsigned long *min,
 				 unsigned long *max);
@@ -3084,6 +3085,8 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
+#else
+static inline bool update_other_load_avgs(struct rq *rq) { return false; }
 #endif
 
 #ifdef CONFIG_UCLAMP_TASK
-- 
2.44.0


