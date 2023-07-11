Return-Path: <bpf+bounces-4669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4BA74E325
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA521C20C87
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9710D17F7;
	Tue, 11 Jul 2023 01:14:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929317D3
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:14:31 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB4E64;
	Mon, 10 Jul 2023 18:14:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b89cfb4571so38557265ad.3;
        Mon, 10 Jul 2023 18:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038068; x=1691630068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4+VbIeEfVwr20uG8gTLNcC3Z+mkzkGxgxXAmQeKdtM=;
        b=pkCKjnovq8uY4CapKGy+dh08FLGhT0DHbARTbykFluBi/Vv0wECWvvFhuIesG2fFcE
         r8XgIPCsaObjkVDolPtVo3wgMH7tMb9SvWP7uxAqP17DK9yXYd+XNXsB+0hEDJE3cNgI
         LFaR2ig/+dQmoZyx3wF16bhbtW4UYK/YO6KOzI4PBDeCHTEZlVFjXCFf12P2J8z1nAar
         wo4PP9jWfV8HatGz86mNiMxjMTHNtJggzl287/2Ue1GDsOXAGU3qlNB7yuinHL+ENrvg
         TmRe19bE/bfYKpul2FbBohoCFYLVt4Dr1kr/T5NutUJdp9aDqcgycU3pFV2yMwx+DSAf
         QhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038068; x=1691630068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t4+VbIeEfVwr20uG8gTLNcC3Z+mkzkGxgxXAmQeKdtM=;
        b=e+3ippNhwr+pMRCTRmUlWN3QHA2s4YiGD4yhAzMoEMFcuDs2q3up5/9C2hcXuQIZjz
         BuCOebq8b0o1ANxEHnvig59CQFmpKwufhd9ZSpAYkdAbokETqGLVo/D1ljflScYKXjHp
         X+sH0yb6acDA55eEslCmta+MHPT0afGfU3DZdpfzccqieGajMhG5KXwmIbfHGLL/IoqP
         qhpZflwlKwcbl4Vf2ZOgymPCy1RB0RqallXTDnI64z9BYSdtUXmKJLGKO9D/LKaCdwEe
         SkFvQc6lgr29iLVSWpG4fwMUPC9rG+1pBO4c59ijOUwJ+3GhNA8pcW4aVXWVTvF+dg62
         yTQw==
X-Gm-Message-State: ABy/qLaS3n8tGkXbqkJccJ/O4QVKGUxNSpEFeCZClH8Qnm5GbLqcLktf
	cXLbJgMEn5FBSDasXdtzG7k=
X-Google-Smtp-Source: APBJJlF2wIN8L++ddUjxtGFMZu5SL3ByX3Wk6dlZJliysbwqjn8Igwejp0U996sDO9fRbSt94d/EOg==
X-Received: by 2002:a17:903:1d0:b0:1b9:d961:69b7 with SMTP id e16-20020a17090301d000b001b9d96169b7mr6732223plh.10.1689038068008;
        Mon, 10 Jul 2023 18:14:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cb8c00b001b05e96d859sm510814ply.135.2023.07.10.18.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:27 -0700 (PDT)
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
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/34] sched: Factor out cgroup weight conversion functions
Date: Mon, 10 Jul 2023 15:13:24 -1000
Message-ID: <20230711011412.100319-7-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 5d1e8432d9af..96d81dfb143f 100644
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
 /* walk only threadgroup leaders */
 #define CSS_TASK_ITER_PROCS		(1U << 0)
 /* walk all threaded css_sets in the domain */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 29f75a31b414..00d6751b0f8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11255,29 +11255,27 @@ static int cpu_extra_stat_show(struct seq_file *sf,
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
@@ -11285,7 +11283,7 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
 				    struct cftype *cft)
 {
-	unsigned long weight = scale_load_down(css_tg(css)->shares);
+	unsigned long weight = tg_weight(css_tg(css));
 	int last_delta = INT_MAX;
 	int prio, delta;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0a25bcd8d9d1..2eb5759f4be9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -232,6 +232,24 @@ static inline void update_avg(u64 *avg, u64 sample)
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
2.41.0


