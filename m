Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F3B63D069
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiK3IY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiK3IX7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:23:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329105ADE3;
        Wed, 30 Nov 2022 00:23:53 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y17so8057061plp.3;
        Wed, 30 Nov 2022 00:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPSOyYDQAZPjQr3nZNHPmM2AV/KaTKSr8+C9zQ01Fn8=;
        b=ctsgL0qNfr78PSmSyKd17UDDhrhbsslLQCw6oULN9EjajmQ9CwZuJ0pPlTTogyWu5P
         DN8QWkwS9hQ5chL74cvDCOfeY4q6hy3IPIW6bNgqdjZCIwHTOflnBeXxUJa50zdAvL7j
         Hdhz0zlHECfMJ4yjmBnEtaS04/rEbWCwrbFmN/zR2uHg8FWt6h78ItlR3jrgXl5IsahX
         +ddCcitqlzkXgoggWJ1G1G2TiLUGzewyNgJPitEjyC747c2nNbLNOWS8X1DKRPUoBXKl
         esyExhQz6ubqT1pMmW+otKXuDmJePQ5pb35bwVsEPe6YW8SI9XoFQnA7q+RD4Avez03i
         Z2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPSOyYDQAZPjQr3nZNHPmM2AV/KaTKSr8+C9zQ01Fn8=;
        b=E3hQJWd0am7xVi4V2+Oiz5bf74+aYB4x2CmmPJ/06HpSJazQPcbOgH8/LYtaVDQFhF
         qeVniWpcLTj/I8c62GeteZKkugTMvCHgj6DCaNfhgI0SViWEba4fl7UxiUyb0MEXOcxd
         TOQyhWAcYnbxOhFVFEmA4Z+a/HDpdrq3rq9G33pfWcE2RN0telysL4j1BOz64+wib8yW
         VpyMVpVqZMvI9rVprNo0r386l1Pr9DgxLdwXSTFQNQdDanX3xQGTcE8gNwstqqBmuDqr
         swOnzME2X/Rdm7+Lu9g143CrG3wOHPEZug/RiFSh8PSpzaqqSIRP1eoCzOYO8XUoMFQf
         8VgA==
X-Gm-Message-State: ANoB5pmQjAMM6xW2JY0Y9BuiEdhRHRvWoDcr3DDDE9BzkQgV1TxA4tO9
        Pu/U//7TUR+YlRT8eSQjQms=
X-Google-Smtp-Source: AA0mqf6TSiqAsJmOgLB1bR7+c2GdJ5ZMIEeQiHYjyDxdUosSey3eNQ6xWL6FHEbuinS6IAWW5LUeEA==
X-Received: by 2002:a17:90a:8b03:b0:213:16d2:4d4c with SMTP id y3-20020a17090a8b0300b0021316d24d4cmr64678734pjn.70.1669796632491;
        Wed, 30 Nov 2022 00:23:52 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id c29-20020aa7953d000000b0057524960947sm816402pfp.39.2022.11.30.00.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:23:52 -0800 (PST)
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
Subject: [PATCH 07/31] sched: Factor out cgroup weight conversion functions
Date:   Tue, 29 Nov 2022 22:22:49 -1000
Message-Id: <20221130082313.3241517-8-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
will be used by a new sched_class.

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
index d2247e8144e3..cc5d1867bb4c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10977,29 +10977,27 @@ static int cpu_extra_stat_show(struct seq_file *sf,
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
@@ -11007,7 +11005,7 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
 				    struct cftype *cft)
 {
-	unsigned long weight = scale_load_down(css_tg(css)->shares);
+	unsigned long weight = tg_weight(css_tg(css));
 	int last_delta = INT_MAX;
 	int prio, delta;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3f98773d66dd..31f008f1e0cc 100644
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
2.38.1

