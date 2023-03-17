Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC6E6BF445
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCQVgT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCQVgJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:36:09 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C7C38E8A;
        Fri, 17 Mar 2023 14:35:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so6659407pjb.0;
        Fri, 17 Mar 2023 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVdIfb6F5UB3YBDHRdzW1feeALJRZ0rog2R5eaNMiiY=;
        b=RJmQKieuoBpzebcHh2VLzlzU09dKDuNr31pYdWA7spYf07t01yCuqSOO3b1EfKdXuS
         9DeI7YtFajTo1jm29L5bL27jHQnXaSZo3GrFOgc+8+DlhCfAgw6ijtdvHXKwkQC+2+H9
         bdYhVwlbCnu/KkzqRpp5q3Hwtbpk7Ybj6kBaE1wjimDvMBbefdhKh2bQMFQ2pGTCSvic
         HmZpuPOKYKbXydjuERTJT5IselTQ0ZeK2D4Fozjwin0AlMny6cn+ZgI+lfgOMoml39o6
         prWd++S3lMSsL2ZWeQkdy5/XI4Rz3BgvtKR9alGLssQRdmwBG98Mx/ipb40IcnSITpo5
         Fg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVdIfb6F5UB3YBDHRdzW1feeALJRZ0rog2R5eaNMiiY=;
        b=Kf0QZd+bFCiCkGIIXw3ZZikx2YblmpKFZPTue1Bb9IvvZJbkcV6LoKTvlzm9Wi1bxV
         gVIg7vwkJaA1TMj/p5h4/me8nqauSuCgQ5owev91TEKctukqrFJwJ6FqOL18tGdg0oqu
         8Qt+nw0pNu4ATuokD/hK2/kV3RgpFKdSp/1qqvjiXdazAqvYwkZecEdxGwm7WvvC5u4i
         Gs6guhPm77CZwq5SYSB2bHgL8olAk0po5eJEavH9v8t7vGVKiplIfeLRIgFVj99smaeK
         X8U1ORYbDj1+j/20qeqQcB1rUqUSeaMVaItGx822AkiTGmPHAqWucKSQ6xxvtLV0VL64
         IWqQ==
X-Gm-Message-State: AO0yUKW+fenmQ/V/Md8qy1gzS8NLfw+bFq50j4/jzBsm2iJz3k/zQy9J
        VlHXWmyJOTZnCmiblp9ft9c=
X-Google-Smtp-Source: AK7set8CMcaflKZpZ60O6YRH4i/Tr2l2f0XIGipn6UaSEVdu27Xhdu3XvZ+g5ThSz2wF+2JjggkWPg==
X-Received: by 2002:a17:90b:3e8e:b0:234:ba6f:c980 with SMTP id rj14-20020a17090b3e8e00b00234ba6fc980mr9358653pjb.17.1679088835772;
        Fri, 17 Mar 2023 14:33:55 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id q2-20020a63d602000000b00476dc914262sm1949664pgg.1.2023.03.17.14.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/32] sched: Factor out cgroup weight conversion functions
Date:   Fri, 17 Mar 2023 11:33:08 -1000
Message-Id: <20230317213333.2174969-8-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
index a8c6982c2c24..5080dfc8ee48 100644
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
index a378e8e09061..fc7008095249 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11145,29 +11145,27 @@ static int cpu_extra_stat_show(struct seq_file *sf,
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
@@ -11175,7 +11173,7 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
 				    struct cftype *cft)
 {
-	unsigned long weight = scale_load_down(css_tg(css)->shares);
+	unsigned long weight = tg_weight(css_tg(css));
 	int last_delta = INT_MAX;
 	int prio, delta;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1545779c5db8..9a6cba6f9299 100644
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
2.39.2

