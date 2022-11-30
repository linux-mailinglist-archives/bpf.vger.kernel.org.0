Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD9263D090
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbiK3I1J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiK3I0D (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:26:03 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A942C5C748;
        Wed, 30 Nov 2022 00:24:29 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id h193so15372074pgc.10;
        Wed, 30 Nov 2022 00:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuV9L30JoCh7E6KY+umYFNLMi3zgwK6bilplbHB6nTg=;
        b=nNeZ3+CuWBpHcc8GovH9fZ6ZO7yZF7T+Pxc92A4+yD99l6tipQFB+cQ0MT2/GSTi8I
         oP3XTHdSpjhzUVZ0TMJ+B4FFMUORjuw1i71sjqHeDFnGwulIESX27EHqys9hiwsmegXI
         QG0Yf/dj4ZgoRQgsY6Qxuf3oohwtz5J8PfhLsdxQ+qCN2Do1jl/pnjxwq4WOL7GJXL9b
         4xb53909SmaDK8KL6r8l8Qp0wIpRKHMl+1KFw36AXwzi/H+q6+ITGwjo6bFayGqdYAwG
         Azx8WCKVmVcSMRGlVFxo39BlejLFfu/IgbizKdKgzXlzHncTeOkRXY54cjV2GBeal5eE
         FUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuV9L30JoCh7E6KY+umYFNLMi3zgwK6bilplbHB6nTg=;
        b=LonLCpnngo9XdJq5vW+8t+wWC7rHqQWz9cOselVm/DGq133tVTW5nyTMjs38nh/f+H
         tcdZQmdEt+2Y9BDDHyWMANailtxN5A2OxeypnvgfaSPWuDPL82CahrQ/Y0CCgKdA24Yh
         b4Sxveiqmp648uSjHpyULtwuDYqLFDsn7DgtIs21B6ukY+HpTnAxL1wK+DG+qMBO38wM
         THRgHBo/K6EoprMdCBppFmQPVjxd8VpuNsRzfNLtzeMkjbw0sF9oI8pWb600My7ZmAD/
         NKMwEZ2gvzSRZUmnE7w3lSqlPm/O9cUpTRZELF7tKGr61K8qOA67RUxUUMO1Wp6CdQad
         F2Pg==
X-Gm-Message-State: ANoB5plmG5aceKuQs+zUOAz0/jBLM1lcOOzK1AB4G2tJRoGopD3JTCNr
        uSN3e/n4ct32i7D5KnF4pGw=
X-Google-Smtp-Source: AA0mqf4be4E5yI+mi8uXByXVy6y277w04ISWZrgQ7mHvSwpumST0dLMCwVj1gjJntmzcgFtAwkXdiQ==
X-Received: by 2002:a63:d34e:0:b0:477:650a:705c with SMTP id u14-20020a63d34e000000b00477650a705cmr34616401pgi.588.1669796668533;
        Wed, 30 Nov 2022 00:24:28 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b0018869119e37sm756024plk.142.2022.11.30.00.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:28 -0800 (PST)
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
Subject: [PATCH 24/31] sched_ext: Add cgroup support
Date:   Tue, 29 Nov 2022 22:23:06 -1000
Message-Id: <20221130082313.3241517-25-tj@kernel.org>
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

Add sched_ext_ops operations to init/exit cgroups, and track task migrations
and config changes. Because different BPF schedulers may implement different
subsets of CPU control features, allow BPF schedulers to pick which cgroup
interface files to enable using SCX_OPS_CGROUP_KNOB_* flags. For now, only
the weight knobs are supported but adding more should be straightforward.

While a BPF scheduler is being enabled and disabled, relevant cgroup
operations are locked out using scx_cgroup_rwsem. This avoids situations
like task prep taking place while the task is being moved across cgroups,
making things easier for BPF schedulers.

This patch also adds scx_example_pair which implements a variant of core
scheduling where a hyperthread pair only run tasks from the same cgroup. The
BPF scheduler achieves this by putting tasks into per-cgroup queues,
time-slicing the cgroup to run for each pair first, and then scheduling
within the cgroup. See the header comment in scx_example_pair.bpf.c for more
details.

Note that scx_example_pair's cgroup-boundary guarantee breaks down for tasks
running in higher priority scheduler classes. This will be addressed by a
followup patch which implements a mechanism to track CPU preemption.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h              |  96 ++++-
 init/Kconfig                           |   5 +
 kernel/sched/core.c                    |  69 ++-
 kernel/sched/ext.c                     | 326 ++++++++++++++-
 kernel/sched/ext.h                     |  23 +
 kernel/sched/sched.h                   |  12 +-
 tools/sched_ext/.gitignore             |   1 +
 tools/sched_ext/Makefile               |   9 +-
 tools/sched_ext/scx_example_pair.bpf.c | 554 +++++++++++++++++++++++++
 tools/sched_ext/scx_example_pair.c     | 143 +++++++
 tools/sched_ext/scx_example_pair.h     |  10 +
 11 files changed, 1226 insertions(+), 22 deletions(-)
 create mode 100644 tools/sched_ext/scx_example_pair.bpf.c
 create mode 100644 tools/sched_ext/scx_example_pair.c
 create mode 100644 tools/sched_ext/scx_example_pair.h

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index b1c95fb11c8d..dc51304b6599 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -12,6 +12,8 @@
 #include <linux/rhashtable.h>
 #include <linux/llist.h>
 
+struct cgroup;
+
 enum scx_consts {
 	SCX_OPS_NAME_LEN	= 128,
 	SCX_EXIT_REASON_LEN	= 128,
@@ -109,14 +111,27 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_ENQ_EXITING	= 1LLU << 2,
 
+	/*
+	 * CPU cgroup knob enable flags
+	 */
+	SCX_OPS_CGROUP_KNOB_WEIGHT = 1LLU << 16,	/* cpu.weight */
+
 	SCX_OPS_ALL_FLAGS	= SCX_OPS_KEEP_BUILTIN_IDLE |
 				  SCX_OPS_ENQ_LAST |
-				  SCX_OPS_ENQ_EXITING,
+				  SCX_OPS_ENQ_EXITING |
+				  SCX_OPS_CGROUP_KNOB_WEIGHT,
 };
 
 /* argument container for ops.enable() and friends */
 struct scx_enable_args {
-	/* empty for now */
+	/* the cgroup the task is joining */
+	struct cgroup		*cgroup;
+};
+
+/* argument container for ops->cgroup_init() */
+struct scx_cgroup_init_args {
+	/* the weight of the cgroup [1..10000] */
+	u32			weight;
 };
 
 /**
@@ -341,7 +356,8 @@ struct sched_ext_ops {
 	 * @p: task to enable BPF scheduling for
 	 * @args: enable arguments, see the struct definition
 	 *
-	 * Enable @p for BPF scheduling. @p will start running soon.
+	 * Enable @p for BPF scheduling. @p is now in the cgroup specified for
+	 * the preceding prep_enable() and will start running soon.
 	 */
 	void (*enable)(struct task_struct *p, struct scx_enable_args *args);
 
@@ -365,6 +381,77 @@ struct sched_ext_ops {
 	 */
 	void (*disable)(struct task_struct *p);
 
+	/**
+	 * cgroup_init - Initialize a cgroup
+	 * @cgrp: cgroup being initialized
+	 * @args: init arguments, see the struct definition
+	 *
+	 * Either the BPF scheduler is being loaded or @cgrp created, initialize
+	 * @cgrp for sched_ext. This operation may block.
+	 *
+	 * Return 0 for success, -errno for failure. An error return while
+	 * loading will abort loading of the BPF scheduler. During cgroup
+	 * creation, it will abort the specific cgroup creation.
+	 */
+	s32 (*cgroup_init)(struct cgroup *cgrp,
+			   struct scx_cgroup_init_args *args);
+
+	/**
+	 * cgroup_exit - Exit a cgroup
+	 * @cgrp: cgroup being exited
+	 *
+	 * Either the BPF scheduler is being unloaded or @cgrp destroyed, exit
+	 * @cgrp for sched_ext. This operation my block.
+	 */
+	void (*cgroup_exit)(struct cgroup *cgrp);
+
+	/**
+	 * cgroup_prep_move - Prepare a task to be moved to a different cgroup
+	 * @p: task being moved
+	 * @from: cgroup @p is being moved from
+	 * @to: cgroup @p is being moved to
+	 *
+	 * Prepare @p for move from cgroup @from to @to. This operation may
+	 * block and can be used for allocations.
+	 *
+	 * Return 0 for success, -errno for failure. An error return aborts the
+	 * migration.
+	 */
+	s32 (*cgroup_prep_move)(struct task_struct *p,
+				struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_move - Commit cgroup move
+	 * @p: task being moved
+	 * @from: cgroup @p is being moved from
+	 * @to: cgroup @p is being moved to
+	 *
+	 * Commit the move. @p is dequeued during this operation.
+	 */
+	void (*cgroup_move)(struct task_struct *p,
+			    struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_cancel_move - Cancel cgroup move
+	 * @p: task whose cgroup move is being canceled
+	 * @from: cgroup @p was being moved from
+	 * @to: cgroup @p was being moved to
+	 *
+	 * @p was cgroup_prep_move()'d but failed before reaching cgroup_move().
+	 * Undo the preparation.
+	 */
+	void (*cgroup_cancel_move)(struct task_struct *p,
+				   struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_set_weight - A cgroup's weight is being changed
+	 * @cgrp: cgroup whose weight is being updated
+	 * @weight: new weight [1..10000]
+	 *
+	 * Update @tg's weight to @weight.
+	 */
+	void (*cgroup_set_weight)(struct cgroup *cgrp, u32 weight);
+
 	/*
 	 * All online ops must come before ops.init().
 	 */
@@ -481,6 +568,9 @@ struct sched_ext_entity {
 
 	/* cold fields */
 	struct list_head	tasks_node;
+#ifdef CONFIG_EXT_GROUP_SCHED
+	struct cgroup		*cgrp_moving_from;
+#endif
 };
 
 void sched_ext_free(struct task_struct *p);
diff --git a/init/Kconfig b/init/Kconfig
index abf65098f1b6..826624ec8925 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1037,6 +1037,11 @@ config RT_GROUP_SCHED
 	  realtime bandwidth for them.
 	  See Documentation/scheduler/sched-rt-group.rst for more information.
 
+config EXT_GROUP_SCHED
+	bool
+	depends on SCHED_CLASS_EXT && CGROUP_SCHED
+	default y
+
 endif #CGROUP_SCHED
 
 config UCLAMP_TASK_GROUP
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 89d2421809da..79560641a61f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9720,6 +9720,9 @@ void __init sched_init(void)
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
 		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+#ifdef CONFIG_EXT_GROUP_SCHED
+		root_task_group.scx_weight = CGROUP_WEIGHT_DFL;
+#endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
@@ -10175,6 +10178,7 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	scx_group_set_weight(tg, CGROUP_WEIGHT_DFL);
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
@@ -10286,6 +10290,8 @@ void sched_move_task(struct task_struct *tsk, enum sched_move_task_reason reason
 		put_prev_task(rq, tsk);
 
 	sched_change_group(tsk);
+	if (reason == SCHED_MOVE_TASK_CGROUP)
+		scx_cgroup_move_task(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10325,6 +10331,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
 	struct task_group *parent = css_tg(css->parent);
+	int ret;
+
+	ret = scx_tg_online(tg);
+	if (ret)
+		return ret;
 
 	if (parent)
 		sched_online_group(tg, parent);
@@ -10341,6 +10352,13 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+	struct task_group *tg = css_tg(css);
+
+	scx_tg_offline(tg);
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
@@ -10358,9 +10376,10 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	sched_unregister_group(tg);
 }
 
-#ifdef CONFIG_RT_GROUP_SCHED
+#if defined(CONFIG_RT_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
+#ifdef CONFIG_RT_GROUP_SCHED
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 
@@ -10368,7 +10387,8 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
-	return 0;
+#endif
+	return scx_cgroup_can_attach(tset);
 }
 #endif
 
@@ -10379,7 +10399,16 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_for_each(task, css, tset)
 		sched_move_task(task, SCHED_MOVE_TASK_CGROUP);
+
+	scx_cgroup_finish_attach();
+}
+
+#ifdef CONFIG_EXT_GROUP_SCHED
+static void cpu_cgroup_cancel_attach(struct cgroup_taskset *tset)
+{
+	scx_cgroup_cancel_attach(tset);
 }
+#endif
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static void cpu_util_update_eff(struct cgroup_subsys_state *css)
@@ -10562,9 +10591,15 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
+	int ret;
+
 	if (shareval > scale_load_down(ULONG_MAX))
 		shareval = MAX_SHARES;
-	return sched_group_set_shares(css_tg(css), scale_load(shareval));
+	ret = sched_group_set_shares(css_tg(css), scale_load(shareval));
+	if (!ret)
+		scx_group_set_weight(css_tg(css),
+				     sched_weight_to_cgroup(shareval));
+	return ret;
 }
 
 static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
@@ -11028,11 +11063,15 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 	return 0;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 
 static unsigned long tg_weight(struct task_group *tg)
 {
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	return scale_load_down(tg->shares);
+#else
+	return sched_weight_from_cgroup(tg->cgrp_weight);
+#endif
 }
 
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
@@ -11045,13 +11084,17 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cft, u64 cgrp_weight)
 {
 	unsigned long weight;
+	int ret;
 
 	if (cgrp_weight < CGROUP_WEIGHT_MIN || cgrp_weight > CGROUP_WEIGHT_MAX)
 		return -ERANGE;
 
 	weight = sched_weight_from_cgroup(cgrp_weight);
 
-	return sched_group_set_shares(css_tg(css), scale_load(weight));
+	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	if (!ret)
+		scx_group_set_weight(css_tg(css), cgrp_weight);
+	return ret;
 }
 
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
@@ -11076,7 +11119,7 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
-	int idx;
+	int idx, ret;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
@@ -11085,7 +11128,11 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 	idx = array_index_nospec(idx, 40);
 	weight = sched_prio_to_weight[idx];
 
-	return sched_group_set_shares(css_tg(css), scale_load(weight));
+	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	if (!ret)
+		scx_group_set_weight(css_tg(css),
+				     sched_weight_to_cgroup(weight));
+	return ret;
 }
 #endif
 
@@ -11147,7 +11194,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 #endif
 
 struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	[CPU_CFTYPE_WEIGHT] = {
 		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -11201,13 +11248,17 @@ struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
-#ifdef CONFIG_RT_GROUP_SCHED
+#if defined(CONFIG_RT_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	.can_attach	= cpu_cgroup_can_attach,
 #endif
 	.attach		= cpu_cgroup_attach,
+#ifdef CONFIG_EXT_GROUP_SCHED
+	.cancel_attach	= cpu_cgroup_cancel_attach,
+#endif
 	.legacy_cftypes	= cpu_legacy_cftypes,
 	.dfl_cftypes	= cpu_cftypes,
 	.early_init	= true,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index cf6493f684f3..bd03b55fbcf5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1561,6 +1561,19 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		resched_curr(rq);
 }
 
+static struct cgroup *tg_cgrp(struct task_group *tg)
+{
+	/*
+	 * If CGROUP_SCHED is disabled, @tg is NULL. If @tg is an autogroup,
+	 * @tg->css.cgroup is NULL. In both cases, @tg can be treated as the
+	 * root cgroup.
+	 */
+	if (tg && tg->css.cgroup)
+		return tg->css.cgroup;
+	else
+		return &cgrp_dfl_root.cgrp;
+}
+
 static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 {
 	int ret;
@@ -1570,7 +1583,7 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 	p->scx.disallow = false;
 
 	if (SCX_HAS_OP(prep_enable)) {
-		struct scx_enable_args args = { };
+		struct scx_enable_args args = { .cgroup = tg_cgrp(tg) };
 
 		ret = scx_ops.prep_enable(p, &args);
 		if (unlikely(ret)) {
@@ -1610,7 +1623,8 @@ static void scx_ops_enable_task(struct task_struct *p)
 	WARN_ON_ONCE(!(p->scx.flags & SCX_TASK_OPS_PREPPED));
 
 	if (SCX_HAS_OP(enable)) {
-		struct scx_enable_args args = { };
+		struct scx_enable_args args =
+			{ .cgroup = tg_cgrp(p->sched_task_group) };
 		scx_ops.enable(p, &args);
 	}
 	p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
@@ -1623,7 +1637,8 @@ static void scx_ops_disable_task(struct task_struct *p)
 
 	if (p->scx.flags & SCX_TASK_OPS_PREPPED) {
 		if (SCX_HAS_OP(cancel_enable)) {
-			struct scx_enable_args args = { };
+			struct scx_enable_args args =
+				{ .cgroup = tg_cgrp(task_group(p)) };
 			scx_ops.cancel_enable(p, &args);
 		}
 		p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
@@ -1777,6 +1792,156 @@ bool scx_can_stop_tick(struct rq *rq)
 }
 #endif
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+
+DEFINE_STATIC_PERCPU_RWSEM(scx_cgroup_rwsem);
+
+int scx_tg_online(struct task_group *tg)
+{
+	int ret = 0;
+
+	WARN_ON_ONCE(tg->scx_flags & (SCX_TG_ONLINE | SCX_TG_INITED));
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (SCX_HAS_OP(cgroup_init)) {
+		struct scx_cgroup_init_args args = { .weight = tg->scx_weight };
+
+		ret = scx_ops.cgroup_init(tg->css.cgroup, &args);
+		if (!ret)
+			tg->scx_flags |= SCX_TG_ONLINE | SCX_TG_INITED;
+		else
+			ret = ops_sanitize_err("cgroup_init", ret);
+	} else {
+		tg->scx_flags |= SCX_TG_ONLINE;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+	return ret;
+}
+
+void scx_tg_offline(struct task_group *tg)
+{
+	WARN_ON_ONCE(!(tg->scx_flags & SCX_TG_ONLINE));
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (SCX_HAS_OP(cgroup_exit) && (tg->scx_flags & SCX_TG_INITED))
+		scx_ops.cgroup_exit(tg->css.cgroup);
+	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
+
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+int scx_cgroup_can_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *p;
+	int ret;
+
+	/* released in scx_finish/cancel_attach() */
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (!scx_enabled())
+		return 0;
+
+	cgroup_taskset_for_each(p, css, tset) {
+		struct cgroup *from = tg_cgrp(p->sched_task_group);
+
+		if (SCX_HAS_OP(cgroup_prep_move)) {
+			ret = scx_ops.cgroup_prep_move(p, from, css->cgroup);
+			if (ret)
+				goto err;
+		}
+
+		WARN_ON_ONCE(p->scx.cgrp_moving_from);
+		p->scx.cgrp_moving_from = from;
+	}
+
+	return 0;
+
+err:
+	cgroup_taskset_for_each(p, css, tset) {
+		if (!p->scx.cgrp_moving_from)
+			break;
+		if (SCX_HAS_OP(cgroup_cancel_move))
+			scx_ops.cgroup_cancel_move(p, p->scx.cgrp_moving_from,
+						   css->cgroup);
+		p->scx.cgrp_moving_from = NULL;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+	return ops_sanitize_err("cgroup_prep_move", ret);
+}
+
+void scx_cgroup_move_task(struct task_struct *p)
+{
+	if (!scx_enabled())
+		return;
+
+	if (SCX_HAS_OP(cgroup_move)) {
+		WARN_ON_ONCE(!p->scx.cgrp_moving_from);
+		scx_ops.cgroup_move(p, p->scx.cgrp_moving_from,
+				    tg_cgrp(p->sched_task_group));
+	}
+	p->scx.cgrp_moving_from = NULL;
+}
+
+void scx_cgroup_finish_attach(void)
+{
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *p;
+
+	if (!scx_enabled())
+		goto out_unlock;
+
+	cgroup_taskset_for_each(p, css, tset) {
+		if (SCX_HAS_OP(cgroup_cancel_move)) {
+			WARN_ON_ONCE(!p->scx.cgrp_moving_from);
+			scx_ops.cgroup_cancel_move(p, p->scx.cgrp_moving_from,
+						   css->cgroup);
+		}
+		p->scx.cgrp_moving_from = NULL;
+	}
+out_unlock:
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+void scx_group_set_weight(struct task_group *tg, unsigned long weight)
+{
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (tg->scx_weight != weight) {
+		if (SCX_HAS_OP(cgroup_set_weight))
+			scx_ops.cgroup_set_weight(tg_cgrp(tg), weight);
+		tg->scx_weight = weight;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+static void scx_cgroup_lock(void)
+{
+	percpu_down_write(&scx_cgroup_rwsem);
+}
+
+static void scx_cgroup_unlock(void)
+{
+	percpu_up_write(&scx_cgroup_rwsem);
+}
+
+#else	/* CONFIG_EXT_GROUP_SCHED */
+
+static inline void scx_cgroup_lock(void) {}
+static inline void scx_cgroup_unlock(void) {}
+
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+
 /*
  * Omitted operations:
  *
@@ -1916,6 +2081,130 @@ static void destroy_dsq(u64 dsq_id)
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+static void scx_cgroup_exit(void)
+{
+	struct cgroup_subsys_state *css;
+
+	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
+
+	/*
+	 * scx_tg_on/offline() are excluded through scx_cgroup_rwsem. If we walk
+	 * cgroups and exit all the inited ones, all online cgroups are exited.
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_post(css, &root_task_group.css) {
+		struct task_group *tg = css_tg(css);
+
+		if (!(tg->scx_flags & SCX_TG_INITED))
+			continue;
+		tg->scx_flags &= ~SCX_TG_INITED;
+
+		if (!scx_ops.cgroup_exit)
+			continue;
+
+		if (WARN_ON_ONCE(!css_tryget(css)))
+			continue;
+		rcu_read_unlock();
+
+		scx_ops.cgroup_exit(css->cgroup);
+
+		rcu_read_lock();
+		css_put(css);
+	}
+	rcu_read_unlock();
+}
+
+static int scx_cgroup_init(void)
+{
+	struct cgroup_subsys_state *css;
+	int ret;
+
+	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
+
+	/*
+	 * scx_tg_on/offline() are excluded thorugh scx_cgroup_rwsem. If we walk
+	 * cgroups and init, all online cgroups are initialized.
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, &root_task_group.css) {
+		struct task_group *tg = css_tg(css);
+		struct scx_cgroup_init_args args = { .weight = tg->scx_weight };
+
+		if ((tg->scx_flags &
+		     (SCX_TG_ONLINE | SCX_TG_INITED)) != SCX_TG_ONLINE)
+			continue;
+
+		if (!scx_ops.cgroup_init) {
+			tg->scx_flags |= SCX_TG_INITED;
+			continue;
+		}
+
+		if (WARN_ON_ONCE(!css_tryget(css)))
+			continue;
+		rcu_read_unlock();
+
+		ret = scx_ops.cgroup_init(css->cgroup, &args);
+		if (ret) {
+			css_put(css);
+			return ret;
+		}
+		tg->scx_flags |= SCX_TG_INITED;
+
+		rcu_read_lock();
+		css_put(css);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static void scx_cgroup_config_knobs(void)
+{
+	static DEFINE_MUTEX(cgintf_mutex);
+	DECLARE_BITMAP(mask, CPU_CFTYPE_CNT) = { };
+	u64 knob_flags;
+	int i;
+
+	/*
+	 * Called from both class switch and ops enable/disable paths,
+	 * synchronize internally.
+	 */
+	mutex_lock(&cgintf_mutex);
+
+	/* if fair is in use, all knobs should be shown */
+	if (!scx_switched_all()) {
+		bitmap_fill(mask, CPU_CFTYPE_CNT);
+		goto apply;
+	}
+
+	/*
+	 * On ext, only show the supported knobs. Otherwise, show all possible
+	 * knobs so that configuration attempts succeed and the states are
+	 * remembered while ops is not loaded.
+	 */
+	if (scx_enabled())
+		knob_flags = scx_ops.flags;
+	else
+		knob_flags = SCX_OPS_ALL_FLAGS;
+
+	if (knob_flags & SCX_OPS_CGROUP_KNOB_WEIGHT) {
+		__set_bit(CPU_CFTYPE_WEIGHT, mask);
+		__set_bit(CPU_CFTYPE_WEIGHT_NICE, mask);
+	}
+apply:
+	for (i = 0; i < CPU_CFTYPE_CNT; i++)
+		cgroup_show_cftype(&cpu_cftypes[i], test_bit(i, mask));
+
+	mutex_unlock(&cgintf_mutex);
+}
+
+#else
+static void scx_cgroup_exit(void) {}
+static int scx_cgroup_init(void) { return 0; }
+static void scx_cgroup_config_knobs(void) {}
+#endif
+
 /*
  * Used by sched_fork() and __setscheduler_prio() to pick the matching
  * sched_class. dl/rt are already handled.
@@ -2071,9 +2360,10 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable(&__scx_switched_all);
 	WRITE_ONCE(scx_switching_all, false);
 
-	/* avoid racing against fork */
+	/* avoid racing against fork and cgroup changes */
 	cpus_read_lock();
 	percpu_down_write(&scx_fork_rwsem);
+	scx_cgroup_lock();
 
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
@@ -2108,6 +2398,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
+	scx_cgroup_exit();
+
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 	cpus_read_unlock();
 
@@ -2137,6 +2430,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_DISABLED) !=
 		     SCX_OPS_DISABLING);
+
+	scx_cgroup_config_knobs();
 }
 
 static DEFINE_KTHREAD_WORK(scx_ops_disable_work, scx_ops_disable_workfn);
@@ -2293,10 +2588,11 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 			   task_runnable_timeout_ms / 2);
 
 	/*
-	 * Lock out forks before opening the floodgate so that they don't wander
-	 * into the operations prematurely.
+	 * Lock out forks, cgroup on/offlining and moves before opening the
+	 * floodgate so that they don't wander into the operations prematurely.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
+	scx_cgroup_lock();
 
 	for (i = 0; i < SCX_NR_ONLINE_OPS; i++)
 		if (((void (**)(void))ops)[i])
@@ -2315,6 +2611,14 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	}
 
+	/*
+	 * All cgroups should be initialized before letting in tasks. cgroup
+	 * on/offlining and task migrations are already locked out.
+	 */
+	ret = scx_cgroup_init();
+	if (ret)
+		goto err_disable_unlock;
+
 	static_branch_enable_cpuslocked(&__scx_ops_enabled);
 
 	/*
@@ -2397,6 +2701,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 
 	spin_unlock_irq(&scx_tasks_lock);
 	preempt_enable();
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
 	if (!scx_ops_tryset_enable_state(SCX_OPS_ENABLED, SCX_OPS_ENABLING)) {
@@ -2410,6 +2715,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	cpus_read_unlock();
 	mutex_unlock(&scx_ops_enable_mutex);
 
+	scx_cgroup_config_knobs();
+
 	return 0;
 
 err_unlock:
@@ -2417,6 +2724,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	return ret;
 
 err_disable_unlock:
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
 	cpus_read_unlock();
@@ -2578,6 +2886,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 	switch (moff) {
 	case offsetof(struct sched_ext_ops, prep_enable):
+	case offsetof(struct sched_ext_ops, cgroup_init):
+	case offsetof(struct sched_ext_ops, cgroup_exit):
+	case offsetof(struct sched_ext_ops, cgroup_prep_move):
 	case offsetof(struct sched_ext_ops, init):
 	case offsetof(struct sched_ext_ops, exit):
 		/*
@@ -2704,6 +3015,7 @@ void __init init_sched_ext_class(void)
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 	INIT_DELAYED_WORK(&check_timeout_work, scx_check_timeout_workfn);
+	scx_cgroup_config_knobs();
 }
 
 
@@ -2745,7 +3057,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_init = {
  * @node: NUMA node to allocate from
  *
  * Create a dsq identified by @dsq_id. Can be called from sleepable operations
- * including ops.init() and .prep_enable().
+ * including ops.init(), .prep_enable() and .cgroup_prep_move().
  */
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
 {
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index e9ec267f13d5..470b2224cdfa 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -59,6 +59,11 @@ enum scx_deq_flags {
 	SCX_DEQ_SLEEP		= DEQUEUE_SLEEP,
 };
 
+enum scx_tg_flags {
+	SCX_TG_ONLINE		= 1U << 0,
+	SCX_TG_INITED		= 1U << 1,
+};
+
 enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 0,	/* force scheduling on the CPU */
 };
@@ -185,3 +190,21 @@ static inline void scx_update_idle(struct rq *rq, bool idle)
 #else
 static inline void scx_update_idle(struct rq *rq, bool idle) {}
 #endif
+
+#ifdef CONFIG_EXT_GROUP_SCHED
+int scx_tg_online(struct task_group *tg);
+void scx_tg_offline(struct task_group *tg);
+int scx_cgroup_can_attach(struct cgroup_taskset *tset);
+void scx_cgroup_move_task(struct task_struct *p);
+void scx_cgroup_finish_attach(void);
+void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
+void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
+#else	/* CONFIG_EXT_GROUP_SCHED */
+static inline int scx_tg_online(struct task_group *tg) { return 0; }
+static inline void scx_tg_offline(struct task_group *tg) {}
+static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
+static inline void scx_cgroup_move_task(struct task_struct *p) {}
+static inline void scx_cgroup_finish_attach(void) {}
+static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
+static inline void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight) {}
+#endif	/* CONFIG_EXT_GROUP_SCHED */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a95aae3bc69a..a2ffa94ede02 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -406,6 +406,11 @@ struct task_group {
 	struct rt_bandwidth	rt_bandwidth;
 #endif
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	u32			scx_flags;	/* SCX_TG_* */
+	u32			scx_weight;
+#endif
+
 	struct rcu_head		rcu;
 	struct list_head	list;
 
@@ -535,6 +540,11 @@ extern void set_task_rq_fair(struct sched_entity *se,
 static inline void set_task_rq_fair(struct sched_entity *se,
 			     struct cfs_rq *prev, struct cfs_rq *next) { }
 #endif /* CONFIG_SMP */
+#else /* CONFIG_FAIR_GROUP_SCHED */
+static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares)
+{
+	return 0;
+}
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #else /* CONFIG_CGROUP_SCHED */
@@ -3260,7 +3270,7 @@ static inline void update_current_exec_runtime(struct task_struct *curr,
 
 #ifdef CONFIG_CGROUP_SCHED
 enum cpu_cftype_id {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	CPU_CFTYPE_WEIGHT,
 	CPU_CFTYPE_WEIGHT_NICE,
 	CPU_CFTYPE_IDLE,
diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
index 389f0e5b0970..ebc34dcf925b 100644
--- a/tools/sched_ext/.gitignore
+++ b/tools/sched_ext/.gitignore
@@ -1,6 +1,7 @@
 scx_example_dummy
 scx_example_qmap
 scx_example_central
+scx_example_pair
 *.skel.h
 *.subskel.h
 /tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index d406b7586e08..45ab39139afc 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -114,7 +114,7 @@ BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH)					\
 	     -Wno-compare-distinct-pointer-types				\
 	     -O2 -mcpu=v3
 
-all: scx_example_dummy scx_example_qmap scx_example_central
+all: scx_example_dummy scx_example_qmap scx_example_central scx_example_pair
 
 # sort removes libbpf duplicates when not cross-building
 MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf		\
@@ -177,10 +177,15 @@ scx_example_central: scx_example_central.c scx_example_central.skel.h user_exit_
 	$(CC) $(CFLAGS) -c $< -o $@.o
 	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
 
+scx_example_pair: scx_example_pair.c scx_example_pair.skel.h user_exit_info.h
+	$(CC) $(CFLAGS) -c $< -o $@.o
+	$(CC) -o $@ $@.o $(HOST_BPFOBJ) $(LDFLAGS)
+
 clean:
 	rm -rf $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)
 	rm -f *.o *.bpf.o *.skel.h *.subskel.h
-	rm -f scx_example_dummy scx_example_qmap scx_example_central
+	rm -f scx_example_dummy scx_example_qmap scx_example_central		\
+	      scx_example_pair
 
 .PHONY: all clean
 
diff --git a/tools/sched_ext/scx_example_pair.bpf.c b/tools/sched_ext/scx_example_pair.bpf.c
new file mode 100644
index 000000000000..7694d2169383
--- /dev/null
+++ b/tools/sched_ext/scx_example_pair.bpf.c
@@ -0,0 +1,554 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A demo sched_ext core-scheduler which always makes every sibling CPU pair
+ * execute from the same CPU cgroup.
+ *
+ * Each CPU in the system is paired with exactly one other CPU, according to a
+ * "stride" value that can be specified when the BPF scheduler program is first
+ * loaded. Throughout the runtime of the scheduler, these CPU pairs guarantee
+ * that they will only ever schedule tasks that belong to the same CPU cgroup.
+ *
+ * Scheduler Initialization
+ * ------------------------
+ *
+ * The scheduler BPF program is first initialized from user space, before it is
+ * enabled. During this initialization process, each CPU on the system is
+ * assigned several values that are constant throughout its runtime:
+ *
+ * 1. *Pair CPU*: The CPU that it synchronizes with when making scheduling
+ *		  decisions. Paired CPUs always schedule tasks from the same
+ *		  CPU cgroup, and synchronize with each other to guarantee
+ *		  that this constraint is not violated.
+ * 2. *Pair ID*:  Each CPU pair is assigned a Pair ID, which is used to access
+ *		  a struct pair_ctx object that is shared between the pair.
+ * 3. *In-pair-index*: An index, 0 or 1, that is assigned to each core in the
+ *		       pair. Each struct pair_ctx has an active_mask field,
+ *		       which is a bitmap used to indicate whether each core
+ *		       in the pair currently has an actively running task.
+ *		       This index specifies which entry in the bitmap corresponds
+ *		       to each CPU in the pair.
+ *
+ * During this initialization, the CPUs are paired according to a "stride" that
+ * may be specified when invoking the user space program that initializes and
+ * loads the scheduler. By default, the stride is 1/2 the total number of CPUs.
+ *
+ * Tasks and cgroups
+ * -----------------
+ *
+ * Every cgroup in the system is registered with the scheduler using the
+ * pair_cgroup_init() callback, and every task in the system is associated with
+ * exactly one cgroup. At a high level, the idea with the pair scheduler is to
+ * always schedule tasks from the same cgroup within a given CPU pair. When a
+ * task is enqueued (i.e. passed to the pair_enqueue() callback function), its
+ * cgroup ID is read from its task struct, and then a corresponding queue map
+ * is used to FIFO-enqueue the task for that cgroup.
+ *
+ * If you look through the implementation of the scheduler, you'll notice that
+ * there is quite a bit of complexity involved with looking up the per-cgroup
+ * FIFO queue that we enqueue tasks in. For example, there is a cgrp_q_idx_hash
+ * BPF hash map that is used to map a cgroup ID to a globally unique ID that's
+ * allocated in the BPF program. This is done because we use separate maps to
+ * store the FIFO queue of tasks, and the length of that map, per cgroup. This
+ * complexity is only present because of current deficiencies in BPF that will
+ * soon be addressed. The main point to keep in mind is that newly enqueued
+ * tasks are added to their cgroup's FIFO queue.
+ *
+ * Dispatching tasks
+ * -----------------
+ *
+ * This section will describe how enqueued tasks are dispatched and scheduled.
+ * Tasks are dispatched in pair_dispatch(), and at a high level the workflow is
+ * as follows:
+ *
+ * 1. Fetch the struct pair_ctx for the current CPU. As mentioned above, this is
+ *    the structure that's used to synchronize amongst the two pair CPUs in their
+ *    scheduling decisions. After any of the following events have occurred:
+ *
+ * - The cgroup's slice run has expired, or
+ * - The cgroup becomes empty, or
+ * - Either CPU in the pair is preempted by a higher priority scheduling class
+ *
+ * The cgroup transitions to the draining state and stops executing new tasks
+ * from the cgroup.
+ *
+ * 2. If the pair is still executing a task, mark the pair_ctx as draining, and
+ *    wait for the pair CPU to be preempted.
+ *
+ * 3. Otherwise, if the pair CPU is not running a task, we can move onto
+ *    scheduling new tasks. Pop the next cgroup id from the top_q queue.
+ *
+ * 4. Pop a task from that cgroup's FIFO task queue, and begin executing it.
+ *
+ * Note again that this scheduling behavior is simple, but the implementation
+ * is complex mostly because this it hits several BPF shortcomings and has to
+ * work around in often awkward ways. Most of the shortcomings are expected to
+ * be resolved in the near future which should allow greatly simplifying this
+ * scheduler.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include "scx_common.bpf.h"
+#include "scx_example_pair.h"
+
+char _license[] SEC("license") = "GPL";
+
+const volatile bool switch_all;
+
+const volatile u32 nr_cpu_ids;
+
+/* a pair of CPUs stay on a cgroup for this duration */
+const volatile u32 pair_batch_dur_ns = SCX_SLICE_DFL;
+
+/* cpu ID -> pair cpu ID */
+const volatile s32 pair_cpu[MAX_CPUS] = { [0 ... MAX_CPUS - 1] = -1 };
+
+/* cpu ID -> pair_id */
+const volatile u32 pair_id[MAX_CPUS];
+
+/* CPU ID -> CPU # in the pair (0 or 1) */
+const volatile u32 in_pair_idx[MAX_CPUS];
+
+struct pair_ctx {
+	struct bpf_spin_lock	lock;
+
+	/* the cgroup the pair is currently executing */
+	u64			cgid;
+
+	/* the pair started executing the current cgroup at */
+	u64			started_at;
+
+	/* whether the current cgroup is draining */
+	bool			draining;
+
+	/* the CPUs that are currently active on the cgroup */
+	u32			active_mask;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, MAX_CPUS / 2);
+	__type(key, u32);
+	__type(value, struct pair_ctx);
+} pair_ctx SEC(".maps");
+
+/* queue of cgrp_q's possibly with tasks on them */
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	/*
+	 * Because it's difficult to build strong synchronization encompassing
+	 * multiple non-trivial operations in BPF, this queue is managed in an
+	 * opportunistic way so that we guarantee that a cgroup w/ active tasks
+	 * is always on it but possibly multiple times. Once we have more robust
+	 * synchronization constructs and e.g. linked list, we should be able to
+	 * do this in a prettier way but for now just size it big enough.
+	 */
+	__uint(max_entries, 4 * MAX_CGRPS);
+	__type(value, u64);
+} top_q SEC(".maps");
+
+/* per-cgroup q which FIFOs the tasks from the cgroup */
+struct cgrp_q {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, MAX_QUEUED);
+	__type(value, u32);
+};
+
+/*
+ * Ideally, we want to allocate cgrp_q and cgrq_q_len in the cgroup local
+ * storage; however, a cgroup local storage can only be accessed from the BPF
+ * progs attached to the cgroup. For now, work around by allocating array of
+ * cgrp_q's and then allocating per-cgroup indices.
+ *
+ * Another caveat: It's difficult to populate a large array of maps statically
+ * or from BPF. Initialize it from userland.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, MAX_CGRPS);
+	__type(key, s32);
+	__array(values, struct cgrp_q);
+} cgrp_q_arr SEC(".maps");
+
+static u64 cgrp_q_len[MAX_CGRPS];
+
+/*
+ * This and cgrp_q_idx_hash combine into a poor man's IDR. This likely would be
+ * useful to have as a map type.
+ */
+static u32 cgrp_q_idx_cursor;
+static u64 cgrp_q_idx_busy[MAX_CGRPS];
+
+/*
+ * All added up, the following is what we do:
+ *
+ * 1. When a cgroup is enabled, RR cgroup_q_idx_busy array doing cmpxchg looking
+ *    for a free ID. If not found, fail cgroup creation with -EBUSY.
+ *
+ * 2. Hash the cgroup ID to the allocated cgrp_q_idx in the following
+ *    cgrp_q_idx_hash.
+ *
+ * 3. Whenever a cgrp_q needs to be accessed, first look up the cgrp_q_idx from
+ *    cgrp_q_idx_hash and then access the corresponding entry in cgrp_q_arr.
+ *
+ * This is sadly complicated for something pretty simple. Hopefully, we should
+ * be able to simplify in the future.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, MAX_CGRPS);
+	__uint(key_size, sizeof(u64));		/* cgrp ID */
+	__uint(value_size, sizeof(s32));	/* cgrp_q idx */
+} cgrp_q_idx_hash SEC(".maps");
+
+/* statistics */
+u64 nr_total, nr_dispatched, nr_missing, nr_kicks, nr_preemptions;
+u64 nr_exps, nr_exp_waits, nr_exp_empty;
+u64 nr_cgrp_next, nr_cgrp_coll, nr_cgrp_empty;
+
+struct user_exit_info uei;
+
+static bool time_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
+void BPF_STRUCT_OPS(pair_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	s32 pid = p->pid;
+	u64 cgid = p->sched_task_group->css.cgroup->kn->id;
+	u32 *q_idx;
+	struct cgrp_q *cgq;
+	u64 *cgq_len;
+
+	__sync_fetch_and_add(&nr_total, 1);
+
+	/* find the cgroup's q and push @p into it */
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!q_idx) {
+		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
+		return;
+	}
+
+	cgq = bpf_map_lookup_elem(&cgrp_q_arr, q_idx);
+	if (!cgq) {
+		scx_bpf_error("failed to lookup q_arr for cgroup[%llu] q_idx[%u]",
+			      cgid, *q_idx);
+		return;
+	}
+
+	if (bpf_map_push_elem(cgq, &pid, 0)) {
+		scx_bpf_error("cgroup[%llu] queue overflow", cgid);
+		return;
+	}
+
+	/* bump q len, if going 0 -> 1, queue cgroup into the top_q */
+	cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+	if (!cgq_len) {
+		scx_bpf_error("MEMBER_VTPR malfunction");
+		return;
+	}
+
+	if (!__sync_fetch_and_add(cgq_len, 1) &&
+	    bpf_map_push_elem(&top_q, &cgid, 0)) {
+		scx_bpf_error("top_q overflow");
+		return;
+	}
+}
+
+/* find the next cgroup to execute and return it in *data */
+static int next_cgid_loopfn(u32 idx, void *data)
+{
+	u64 cgid;
+	u32 *q_idx;
+	u64 *cgq_len;
+
+	if (bpf_map_pop_elem(&top_q, &cgid))
+		return 1;
+
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!q_idx)
+		return 0;
+
+	/* this is the only place where empty cgroups are taken off the top_q */
+	cgq_len = MEMBER_VPTR(cgrp_q_len, [*q_idx]);
+	if (!cgq_len || !*cgq_len)
+		return 0;
+
+	/* if it has any tasks, requeue as we may race and not execute it */
+	bpf_map_push_elem(&top_q, &cgid, 0);
+	*(u64 *)data = cgid;
+	return 1;
+}
+
+struct claim_task_loopctx {
+	u32		q_idx;
+	bool		claimed;
+};
+
+/* claim one task from the specified cgq */
+static int claim_task_loopfn(u32 idx, void *data)
+{
+	struct claim_task_loopctx *claimc = data;
+	u64 *cgq_len;
+	u64 len;
+
+	cgq_len = MEMBER_VPTR(cgrp_q_len, [claimc->q_idx]);
+	if (!cgq_len)
+		return 1;
+
+	len = *cgq_len;
+	if (!len)
+		return 1;
+
+	if (__sync_val_compare_and_swap(cgq_len, len, len - 1) != len)
+		return 0;
+
+	claimc->claimed = true;
+	return 1;
+}
+
+static int lookup_pairc_and_mask(s32 cpu, struct pair_ctx **pairc, u32 *mask)
+{
+	u32 *vptr, in_pair_mask;
+	int err;
+
+	vptr = (u32 *)MEMBER_VPTR(pair_id, [cpu]);
+	if (!vptr)
+		return -EINVAL;
+
+	*pairc = bpf_map_lookup_elem(&pair_ctx, vptr);
+	if (!(*pairc))
+		return -EINVAL;
+
+	vptr = (u32 *)MEMBER_VPTR(in_pair_idx, [cpu]);
+	if (!vptr)
+		return -EINVAL;
+
+	*mask = 1U << *vptr;
+
+	return 0;
+}
+
+static int dispatch_loopfn(u32 idx, void *data)
+{
+	s32 cpu = *(s32 *)data;
+	struct pair_ctx *pairc;
+	struct bpf_map *cgq_map;
+	struct claim_task_loopctx claimc;
+	struct task_struct *p;
+	u64 now = bpf_ktime_get_ns();
+	bool kick_pair = false;
+	bool expired;
+	u32 *vptr, in_pair_mask;
+	s32 pid;
+	u64 cgid;
+	int ret;
+
+	ret = lookup_pairc_and_mask(cpu, &pairc, &in_pair_mask);
+	if (ret) {
+		scx_bpf_error("failed to lookup pairc and in_pair_mask for cpu[%d]",
+			      cpu);
+		return 1;
+	}
+
+	bpf_spin_lock(&pairc->lock);
+	pairc->active_mask &= ~in_pair_mask;
+
+	expired = time_before(pairc->started_at + pair_batch_dur_ns, now);
+	if (expired || pairc->draining) {
+		u64 new_cgid = 0;
+
+		__sync_fetch_and_add(&nr_exps, 1);
+
+		/*
+		 * We're done with the current cgid. An obvious optimization
+		 * would be not draining if the next cgroup is the current one.
+		 * For now, be dumb and always expire.
+		 */
+		pairc->draining = true;
+
+		if (pairc->active_mask) {
+			/*
+			 * The other CPU is still active We want to wait until
+			 * this cgroup expires.
+			 *
+			 * If the pair controls its CPU, and the time already
+			 * expired, kick.  When the other CPU arrives at
+			 * dispatch and clears its active mask, it'll push the
+			 * pair to the next cgroup and kick this CPU.
+			 */
+			__sync_fetch_and_add(&nr_exp_waits, 1);
+			bpf_spin_unlock(&pairc->lock);
+			if (expired)
+				kick_pair = true;
+			goto out_maybe_kick;
+		}
+
+		bpf_spin_unlock(&pairc->lock);
+
+		/*
+		 * Pick the next cgroup. It'd be easier / cleaner to not drop
+		 * pairc->lock and use stronger synchronization here especially
+		 * given that we'll be switching cgroups significantly less
+		 * frequently than tasks. Unfortunately, bpf_spin_lock can't
+		 * really protect anything non-trivial. Let's do opportunistic
+		 * operations instead.
+		 */
+		bpf_loop(1 << 23, next_cgid_loopfn, &new_cgid, 0);
+		/* no active cgroup, go idle */
+		if (!new_cgid) {
+			__sync_fetch_and_add(&nr_exp_empty, 1);
+			return 1;
+		}
+
+		bpf_spin_lock(&pairc->lock);
+
+		/*
+		 * The other CPU may already have started on a new cgroup while
+		 * we dropped the lock. Make sure that we're still draining and
+		 * start on the new cgroup.
+		 */
+		if (pairc->draining && !pairc->active_mask) {
+			__sync_fetch_and_add(&nr_cgrp_next, 1);
+			pairc->cgid = new_cgid;
+			pairc->started_at = now;
+			pairc->draining = false;
+			kick_pair = true;
+		} else {
+			__sync_fetch_and_add(&nr_cgrp_coll, 1);
+		}
+	}
+
+	cgid = pairc->cgid;
+	pairc->active_mask |= in_pair_mask;
+	bpf_spin_unlock(&pairc->lock);
+
+	/* again, it'd be better to do all these with the lock held, oh well */
+	vptr = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (!vptr) {
+		scx_bpf_error("failed to lookup q_idx for cgroup[%llu]", cgid);
+		return 1;
+	}
+
+	claimc = (struct claim_task_loopctx){ .q_idx = *vptr };
+	bpf_loop(1 << 23, claim_task_loopfn, &claimc, 0);
+	if (!claimc.claimed) {
+		/* the cgroup must be empty, expire and repeat */
+		__sync_fetch_and_add(&nr_cgrp_empty, 1);
+		bpf_spin_lock(&pairc->lock);
+		pairc->draining = true;
+		pairc->active_mask &= ~in_pair_mask;
+		bpf_spin_unlock(&pairc->lock);
+		return 0;
+	}
+
+	cgq_map = bpf_map_lookup_elem(&cgrp_q_arr, &claimc.q_idx);
+	if (!cgq_map) {
+		scx_bpf_error("failed to lookup cgq_map for cgroup[%llu] q_idx[%d]",
+			      cgid, claimc.q_idx);
+		return 1;
+	}
+
+	if (bpf_map_pop_elem(cgq_map, &pid)) {
+		scx_bpf_error("cgq_map is empty for cgroup[%llu] q_idx[%d]",
+			      cgid, claimc.q_idx);
+		return 1;
+	}
+
+	p = scx_bpf_find_task_by_pid(pid);
+	if (p) {
+		__sync_fetch_and_add(&nr_dispatched, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, 0);
+	} else {
+		/* we don't handle dequeues, retry on lost tasks */
+		__sync_fetch_and_add(&nr_missing, 1);
+		return 0;
+	}
+
+out_maybe_kick:
+	if (kick_pair) {
+		s32 *pair = (s32 *)MEMBER_VPTR(pair_cpu, [cpu]);
+		if (pair) {
+			__sync_fetch_and_add(&nr_kicks, 1);
+			scx_bpf_kick_cpu(*pair, SCX_KICK_PREEMPT);
+		}
+	}
+	return 1;
+}
+
+void BPF_STRUCT_OPS(pair_dispatch, s32 cpu, struct task_struct *prev)
+{
+	s32 cpu_on_stack = cpu;
+
+	bpf_loop(1 << 23, dispatch_loopfn, &cpu_on_stack, 0);
+}
+
+static int alloc_cgrp_q_idx_loopfn(u32 idx, void *data)
+{
+	u32 q_idx;
+
+	q_idx = __sync_fetch_and_add(&cgrp_q_idx_cursor, 1) % MAX_CGRPS;
+	if (!__sync_val_compare_and_swap(&cgrp_q_idx_busy[q_idx], 0, 1)) {
+		*(s32 *)data = q_idx;
+		return 1;
+	}
+	return 0;
+}
+
+s32 BPF_STRUCT_OPS(pair_cgroup_init, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+	s32 q_idx = -1;
+
+	bpf_loop(MAX_CGRPS, alloc_cgrp_q_idx_loopfn, &q_idx, 0);
+	if (q_idx < 0)
+		return -EBUSY;
+
+	if (bpf_map_update_elem(&cgrp_q_idx_hash, &cgid, &q_idx, BPF_ANY)) {
+		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [q_idx]);
+		if (busy)
+			*busy = 0;
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_cgroup_exit, struct cgroup *cgrp)
+{
+	u64 cgid = cgrp->kn->id;
+	s32 *q_idx;
+
+	q_idx = bpf_map_lookup_elem(&cgrp_q_idx_hash, &cgid);
+	if (q_idx) {
+		u64 *busy = MEMBER_VPTR(cgrp_q_idx_busy, [*q_idx]);
+		if (busy)
+			*busy = 0;
+		bpf_map_delete_elem(&cgrp_q_idx_hash, &cgid);
+	}
+}
+
+s32 BPF_STRUCT_OPS(pair_init)
+{
+	if (switch_all)
+		scx_bpf_switch_all();
+	return 0;
+}
+
+void BPF_STRUCT_OPS(pair_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops")
+struct sched_ext_ops pair_ops = {
+	.enqueue		= (void *)pair_enqueue,
+	.dispatch		= (void *)pair_dispatch,
+	.cgroup_init		= (void *)pair_cgroup_init,
+	.cgroup_exit		= (void *)pair_cgroup_exit,
+	.init			= (void *)pair_init,
+	.exit			= (void *)pair_exit,
+	.name			= "pair",
+};
diff --git a/tools/sched_ext/scx_example_pair.c b/tools/sched_ext/scx_example_pair.c
new file mode 100644
index 000000000000..255ea7b1235d
--- /dev/null
+++ b/tools/sched_ext/scx_example_pair.c
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <assert.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "user_exit_info.h"
+#include "scx_example_pair.h"
+#include "scx_example_pair.skel.h"
+
+const char help_fmt[] =
+"A demo sched_ext core-scheduler which always makes every sibling CPU pair\n"
+"execute from the same CPU cgroup.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-a] [-S STRIDE]\n"
+"\n"
+"  -a            Switch all tasks\n"
+"  -S STRIDE     Override CPU pair stride (default: nr_cpus_ids / 2)\n"
+"  -h            Display this help and exit\n";
+
+static volatile int exit_req;
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_example_pair *skel;
+	struct bpf_link *link;
+	u64 seq = 0;
+	s32 stride, i, opt, outer_fd;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_example_pair__open();
+	assert(skel);
+
+	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
+
+	/* pair up the earlier half to the latter by default, override with -s */
+	stride = skel->rodata->nr_cpu_ids / 2;
+
+	while ((opt = getopt(argc, argv, "ahS:")) != -1) {
+		switch (opt) {
+		case 'a':
+			skel->rodata->switch_all = true;
+			break;
+		case 'S':
+			stride = strtoul(optarg, NULL, 0);
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	for (i = 0; i < skel->rodata->nr_cpu_ids; i++) {
+		if (skel->rodata->pair_cpu[i] < 0) {
+			skel->rodata->pair_cpu[i] = i + stride;
+			skel->rodata->pair_cpu[i + stride] = i;
+			skel->rodata->pair_id[i] = i;
+			skel->rodata->pair_id[i + stride] = i;
+			skel->rodata->in_pair_idx[i] = 0;
+			skel->rodata->in_pair_idx[i + stride] = 1;
+		}
+	}
+
+	assert(!scx_example_pair__load(skel));
+
+	/*
+	 * Populate the cgrp_q_arr map which is an array containing per-cgroup
+	 * queues. It'd probably be better to do this from BPF but there are too
+	 * many to initialize statically and there's no way to dynamically
+	 * populate from BPF.
+	 */
+	outer_fd = bpf_map__fd(skel->maps.cgrp_q_arr);
+	assert(outer_fd >= 0);
+
+	printf("Initializing");
+        for (i = 0; i < MAX_CGRPS; i++) {
+		s32 inner_fd;
+
+		if (exit_req)
+			break;
+
+		inner_fd = bpf_map_create(BPF_MAP_TYPE_QUEUE, NULL, 0,
+					  sizeof(u32), MAX_QUEUED, NULL);
+		assert(inner_fd >= 0);
+		assert(!bpf_map_update_elem(outer_fd, &i, &inner_fd, BPF_ANY));
+		close(inner_fd);
+
+		if (!(i % 10))
+			printf(".");
+		fflush(stdout);
+        }
+	printf("\n");
+
+	/*
+	 * Fully initialized, attach and run.
+	 */
+	link = bpf_map__attach_struct_ops(skel->maps.pair_ops);
+	assert(link);
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		printf("[SEQ %lu]\n", seq++);
+		printf(" total:%10lu dispatch:%10lu   missing:%10lu\n",
+		       skel->bss->nr_total,
+		       skel->bss->nr_dispatched,
+		       skel->bss->nr_missing);
+		printf(" kicks:%10lu preemptions:%7lu\n",
+		       skel->bss->nr_kicks,
+		       skel->bss->nr_preemptions);
+		printf("   exp:%10lu exp_wait:%10lu exp_empty:%10lu\n",
+		       skel->bss->nr_exps,
+		       skel->bss->nr_exp_waits,
+		       skel->bss->nr_exp_empty);
+		printf("cgnext:%10lu   cgcoll:%10lu   cgempty:%10lu\n",
+		       skel->bss->nr_cgrp_next,
+		       skel->bss->nr_cgrp_coll,
+		       skel->bss->nr_cgrp_empty);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_example_pair__destroy(skel);
+	return 0;
+}
diff --git a/tools/sched_ext/scx_example_pair.h b/tools/sched_ext/scx_example_pair.h
new file mode 100644
index 000000000000..f60b824272f7
--- /dev/null
+++ b/tools/sched_ext/scx_example_pair.h
@@ -0,0 +1,10 @@
+#ifndef __SCX_EXAMPLE_PAIR_H
+#define __SCX_EXAMPLE_PAIR_H
+
+enum {
+	MAX_CPUS		= 4096,
+	MAX_QUEUED		= 4096,
+	MAX_CGRPS		= 4096,
+};
+
+#endif /* __SCX_EXAMPLE_PAIR_H */
-- 
2.38.1

