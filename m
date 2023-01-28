Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6672067F2E7
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjA1ARh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjA1ARQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:17:16 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3CE8715D;
        Fri, 27 Jan 2023 16:17:06 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id be8so6560590plb.7;
        Fri, 27 Jan 2023 16:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0ISkd2T3J7+l1Hznoksx6Dz5SLKHYAGnyxSr5SorAg=;
        b=MK1SussAVC9VsvXsIZvk0OjW/ed1lvSvUxGixEar2Sy0RF/cl4fhxsD+2NdXlImBty
         VR7iXwvd4TZvPFnKOYjHy57B//qYEC+aLMnzKUmovL9+3smuVjKt/DtE32tpmYdYnexj
         DchV2Kxh8kk8QrckTp0Pq6hBc3nFu2lC7i6u76IIfWiqCHYNpuGHmaR6IS0/b+cn8mSa
         +GKAqofMJd2abEuMyzFcPhjtU2F8lFxZCdBvzae+GN7ThvT0OCsc66OSyXvrsQKkIQWq
         lHSh+ufkLX/NmOxxuhpmwpKwTpQmF+IhKwcahtRGm5iOMF9ofN0CHZe7QRF5w+tTqQQG
         7bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p0ISkd2T3J7+l1Hznoksx6Dz5SLKHYAGnyxSr5SorAg=;
        b=pTs+0vYLbnyIfmmHbmajmHi8ZlTiXM1oCaygi46tV7snclGzoXKil7FHuIbNRIK600
         8y4eugmFIMz77aqS4O3Ntat3DSgXOOamUHMPQmUTZr2dFt3cN5R9QCQiCiwNBwMVDZ67
         KIx1yOFjWFOUF5hhPESL0Uibh8UzLp25q6afY25RtiuClols4j3ZdBv31+j8nks/52BM
         HXFfxW+bOY47KUWlvHgcQweB7CUEOcOG4iau1bQ/iAFRJiZROfAj+MxLh1/L4FgVJUkb
         qaeBbyG7AfJhle6v6xSHCVQSrMFS9cG7vHNWjdZAboFMADDGTqAMoCLl2geOeR7sWFuz
         X18g==
X-Gm-Message-State: AO0yUKVLOFoG+n/BXEq6dWtLf7jAqO1mIKaxesYZX69jeyIX4e4dr537
        3gMxDXhKvctqKa7sWPu3hhE=
X-Google-Smtp-Source: AK7set9j6RBMzGQqGuJwGP5rOysHXD9GY3gpPgKfEM3VsY2nKvk1CydU6zeWE2koA2ZJ1OWgnmJf2A==
X-Received: by 2002:a17:902:dacf:b0:196:2bf1:b68d with SMTP id q15-20020a170902dacf00b001962bf1b68dmr14009108plx.14.1674865025163;
        Fri, 27 Jan 2023 16:17:05 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ik26-20020a170902ab1a00b001895f7c8a71sm3408287plb.97.2023.01.27.16.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:04 -0800 (PST)
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
Subject: [PATCH 07/30] sched: Factor out cgroup weight conversion functions
Date:   Fri, 27 Jan 2023 14:16:16 -1000
Message-Id: <20230128001639.3510083-8-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/core.c  | 28 +++++++++++++---------------
 kernel/sched/sched.h | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e6d5374edf58..70698725f6de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11072,29 +11072,27 @@ static int cpu_extra_stat_show(struct seq_file *sf,
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
@@ -11102,7 +11100,7 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
 				    struct cftype *cft)
 {
-	unsigned long weight = scale_load_down(css_tg(css)->shares);
+	unsigned long weight = tg_weight(css_tg(css));
 	int last_delta = INT_MAX;
 	int prio, delta;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c083395c5477..946fdb51b6e6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -435,6 +435,24 @@ struct task_group {
 #define MAX_SHARES		(1UL << 18)
 #endif
 
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
 typedef int (*tg_visitor)(struct task_group *, void *);
 
 extern int walk_tg_tree_from(struct task_group *from,
-- 
2.39.1

