Return-Path: <bpf+bounces-28336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402F8B8C83
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8852838B9
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17123130A52;
	Wed,  1 May 2024 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEKXMxGI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCC1304A2;
	Wed,  1 May 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576411; cv=none; b=e1P3OW/RA3CRd1PI7cbeyt+Y+nBbHxpw0Og6nKb+VUk6emSkEP65oWPJK1+sc7nNV2PPydne56y+9nJNMlAzcjHRBrONJ1ZJr0mbGUUuRBWxOrsPo7MadZ8J/44zYJQBEPq9eY6LJrS4rAuQYDq6T+sCbcED+VU8St9P30L+9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576411; c=relaxed/simple;
	bh=PVYjJ7EUa8gp62XpSakW8jTX7+Y2L1yUib6oSlGuuAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e46/cd+qG6nHJqCkvzMETu7Jwjq/RkxA6O/EPSbeLA/obvM6dj1g+kvYfAm2Lr1Lgq3I5Bpy81kHQ73iaJ71a25aVE/BCICj9HCqXSCYu0U5VyM7PLPn+PSLMh65DZTLGCvCBBvxye8HZk5Rf/ZOQCfN4zcbl+hGf83JT9Eeumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEKXMxGI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso6116419b3a.0;
        Wed, 01 May 2024 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576409; x=1715181209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhNW7yjCScFs2B+27+UAoQnwSXUW8yqRUDLP5oSoy4c=;
        b=bEKXMxGIfIofq4gR1pPGSo2yVr/yvnyxP0Ho2tAzOQc6uLO08XeXYvy4BMavIW8m4E
         NkcWM8xg8m58inpzsVLpseAfFR0T456vJWZxfJ1zaCdGPp0oUQIT+UDQwJBcAOqdwMbT
         fXCXMa10rcZ9IcT5aHx7kebhLgzj1oFMA/bGYsfGpXD4rhV9S5pREVjOfuVuv9pgdh3b
         SCQ2M3zhL9p6E3WNGYmlLM8kz+3KLylPLSBh667srxnhSBIPkHQf08M0efQIczKATJPE
         HufPVt82g184ALrrdYa1NOAhCeYKUSyc+eWZkNVlRBsYGFW0isPoXgIT3HIamewtXiD+
         p5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576409; x=1715181209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qhNW7yjCScFs2B+27+UAoQnwSXUW8yqRUDLP5oSoy4c=;
        b=YM4Sh4Xm5B7El+9wK8p7LMigxqQk1qN+vyS+OztnaIVN8u1ICdHO7rdK9minxhFKRc
         vGYePcesykYLrHy5NJo8CpZ0qnPRFQs0EFN+BmaifFG7gXn76lZiBEsWm3eO5RImF0MQ
         C3OG3ymBF193VDbJZVG/Jc8y6haa6CpDp7lr8NOymwsQo8GBjk+4R/JcvfWP0QloiPyQ
         wfSsG7r7NwhG3QF7bWFNRBeCDsU8JK8rLYTi9tu4wVGqmAQJanlTI775ixYVGwp1fIAb
         9zOvRtVNAsXRKoL0WoaAuOJKEJFplMUvhGXle44Bcs+kOseClMyYfr4G7HlzPc+en39t
         Nw5g==
X-Forwarded-Encrypted: i=1; AJvYcCXKu2sB8u7uiseLPEPeBmONpylWNVY7fCxFGWXcORhPvC27pObWhMJ710C4es67pcei9qY9LKnmvL4MprnsrzuYq4zj
X-Gm-Message-State: AOJu0YwLkGTBmrYzAc55KBCvo0HMwyCELqxIV5oFZzqEYyo1o/hcKp+w
	LODYsqIbJmHwEcgNALDvOgfgIR3IK4tWU3VJiTcvDiqnjE0ZvkFV
X-Google-Smtp-Source: AGHT+IEkh//IhaGufZhcwqzmsYIy2niLfEFLT+vkTSJGcKiomjiyAdjBWq69sLm09LM5KrT83VuCfQ==
X-Received: by 2002:a05:6a00:39a5:b0:6ea:b818:f499 with SMTP id fi37-20020a056a0039a500b006eab818f499mr3307176pfb.19.1714576409228;
        Wed, 01 May 2024 08:13:29 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id a1-20020aa780c1000000b006f3e7dc6416sm8463459pfn.10.2024.05.01.08.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:28 -0700 (PDT)
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
Subject: [PATCH 06/39] sched: Factor out cgroup weight conversion functions
Date: Wed,  1 May 2024 05:09:41 -1000
Message-ID: <20240501151312.635565-7-tj@kernel.org>
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

Factor out sched_weight_from/to_cgroup() which convert between scheduler
shares and cgroup weight. No functional change. The factored out functions
will be used by a new BPF extensible sched_class so that the weights can be
exposed to the BPF programs in a way which is consistent cgroup weights and
easier to interpret.

The weight conversions will be used regardless of cgroup usage. It's just
borrowing the cgroup weight range as it's more intuitive.
CGROUP_WEIGHT_MIN/DFL/MAX constants are moved outside CONFIG_CGROUPS so that
the conversion helpers can always be defined.

v2: The helpers are now defined regardless of COFNIG_CGROUPS.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/cgroup.h |  4 ++--
 kernel/sched/core.c    | 28 +++++++++++++---------------
 kernel/sched/sched.h   | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 509e2e8a1d35..32679fcff0a7 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -29,8 +29,6 @@
 
 struct kernel_clone_args;
 
-#ifdef CONFIG_CGROUPS
-
 /*
  * All weight knobs on the default hierarchy should use the following min,
  * default and max values.  The default value is the logarithmic center of
@@ -40,6 +38,8 @@ struct kernel_clone_args;
 #define CGROUP_WEIGHT_DFL		100
 #define CGROUP_WEIGHT_MAX		10000
 
+#ifdef CONFIG_CGROUPS
+
 enum {
 	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
 	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 311efc00da63..9b60df944263 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11313,29 +11313,27 @@ static int cpu_local_stat_show(struct seq_file *sf,
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
+
+static unsigned long tg_weight(struct task_group *tg)
+{
+	return scale_load_down(tg->shares);
+}
+
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
-	struct task_group *tg = css_tg(css);
-	u64 weight = scale_load_down(tg->shares);
-
-	return DIV_ROUND_CLOSEST_ULL(weight * CGROUP_WEIGHT_DFL, 1024);
+	return sched_weight_to_cgroup(tg_weight(css_tg(css)));
 }
 
 static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
-				struct cftype *cft, u64 weight)
+				struct cftype *cft, u64 cgrp_weight)
 {
-	/*
-	 * cgroup weight knobs should use the common MIN, DFL and MAX
-	 * values which are 1, 100 and 10000 respectively.  While it loses
-	 * a bit of range on both ends, it maps pretty well onto the shares
-	 * value used by scheduler and the round-trip conversions preserve
-	 * the original value over the entire range.
-	 */
-	if (weight < CGROUP_WEIGHT_MIN || weight > CGROUP_WEIGHT_MAX)
+	unsigned long weight;
+
+	if (cgrp_weight < CGROUP_WEIGHT_MIN || cgrp_weight > CGROUP_WEIGHT_MAX)
 		return -ERANGE;
 
-	weight = DIV_ROUND_CLOSEST_ULL(weight * 1024, CGROUP_WEIGHT_DFL);
+	weight = sched_weight_from_cgroup(cgrp_weight);
 
 	return sched_group_set_shares(css_tg(css), scale_load(weight));
 }
@@ -11343,7 +11341,7 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
 				    struct cftype *cft)
 {
-	unsigned long weight = scale_load_down(css_tg(css)->shares);
+	unsigned long weight = tg_weight(css_tg(css));
 	int last_delta = INT_MAX;
 	int prio, delta;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 99e292368d11..24b3d120700b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -221,6 +221,24 @@ static inline void update_avg(u64 *avg, u64 sample)
 #define shr_bound(val, shift)							\
 	(val >> min_t(typeof(shift), shift, BITS_PER_TYPE(typeof(val)) - 1))
 
+/*
+ * cgroup weight knobs should use the common MIN, DFL and MAX values which are
+ * 1, 100 and 10000 respectively. While it loses a bit of range on both ends, it
+ * maps pretty well onto the shares value used by scheduler and the round-trip
+ * conversions preserve the original value over the entire range.
+ */
+static inline unsigned long sched_weight_from_cgroup(unsigned long cgrp_weight)
+{
+	return DIV_ROUND_CLOSEST_ULL(cgrp_weight * 1024, CGROUP_WEIGHT_DFL);
+}
+
+static inline unsigned long sched_weight_to_cgroup(unsigned long weight)
+{
+	return clamp_t(unsigned long,
+		       DIV_ROUND_CLOSEST_ULL(weight * CGROUP_WEIGHT_DFL, 1024),
+		       CGROUP_WEIGHT_MIN, CGROUP_WEIGHT_MAX);
+}
+
 /*
  * !! For sched_setattr_nocheck() (kernel) only !!
  *
-- 
2.44.0


