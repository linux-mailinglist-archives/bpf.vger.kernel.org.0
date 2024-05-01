Return-Path: <bpf+bounces-28358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A68B8CB8
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DE81F21532
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B02137C38;
	Wed,  1 May 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpMlcBlS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519F13792B;
	Wed,  1 May 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576460; cv=none; b=udmOYfR9GykwGoJcCrf1+OgCDU5gNqUgwITNU6QE/pXxczriZksupvnG0fDYxNNjD3xtR7m6q6AONWpPXTwKDMQhU+3Ik4IV9/rhsSa1WKQnzh4ZoIUZnR/ZFC2VwYOrEvX+8r6zzp00nChqgiWQaXMwfrElAXc4oUgcxp7PLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576460; c=relaxed/simple;
	bh=rr2spKIjHdHoF1iRminffx9dVz6nHhNV03El5Hs0Nfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sx36zQjOwj5ujSxAK9f/LwHvpZaHfXa45J0jZJHKyuM2ePgAH+O/zaKXOdkLkNw35Gwkeqr/Px/WchqRDtjpJHISN1iFfoF3yc8l184wWcYlQ1yVv+qmvZq6oWxoZWKJXgnKhvWleXPikhU2MC4lX/mRSSuW0PWq7maGOAmilv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpMlcBlS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecec796323so6583643b3a.3;
        Wed, 01 May 2024 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576456; x=1715181256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tu4M/q0nb6x/dgY6n5vF84nwmw2UX7EcEdN5LZxjZSM=;
        b=EpMlcBlSvG4mKuhkbo0agMAZjC2rgu6WONSGBPYOUObMOnbW3GSk8pPQaZTymBTSrF
         YinK37S9S2NQeo2dAvO33IOtXYXz+bj7UkRYGh7Zs2b0gsOF1svyhHhHdhDpK3GvyZvC
         VztZiYuMGcnb8t1uDroqG/VJ1r7cuuWjPNAM3rBesjPXw6QzMQBZ6GzhMQR7CKzNVlw8
         FgrYWiiTylrsjOqt95sQ+Z0f2Te42J5JwchmOZIu6tghccwaNw9MjJanqdPt+I6O/Ohg
         gq+0Hn/w0sfQ1xjXc2ug065SRDyGiGzKPzuuPk0gbkAHvKozgLWxUPlrSjYCBCIEC0e9
         NEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576456; x=1715181256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tu4M/q0nb6x/dgY6n5vF84nwmw2UX7EcEdN5LZxjZSM=;
        b=A9fY0hZBJirPVlGxg6LiaQLx1rXmWtZ2OGEOKz79fLeleiJnw8MEdxPlxXfKjCcxW1
         +6eYvdDx90bjEIsEL26YVTbKGS6C6NRt0ibAjuW1dCxLM8MPE0AOdEHZ2EC1a9M2PWF6
         SfrgyTyRjy8yRlSLcgJI3/g3Vdcn9UGKLp/3TrTXyK4Phi+WfvR+3TOioeIwa9JaJ43G
         XEAr4/ylQ+G4e7tFsyeTXviFK57tuiwPFfsHWOtT6+0tcwi1fnVnKPzldmqONPtm7ajW
         ctvR9rjtaKW2Lh2HcgRHPsvf+rkY2IPhD2uDfdSrrRWfnxeiosjRW9zHKQIkk4UcL2yf
         kb7w==
X-Forwarded-Encrypted: i=1; AJvYcCWVcQNs/uKvgB1lVkNN8bPd5In0T6MoCYD1/IeqCOlHQrEaEvvOuY/4HskZ2o32c+Fq18UQekpJkGKC0WBYflVKJF8W
X-Gm-Message-State: AOJu0Yyrd78/T2wYyjfFp0g/Zw9jW/sdsQaW9EaoTG7KVVkkfHcOfCN0
	BiY2AgfuoVEfSvbjOePeb/h2MGzG3XR0xajrhCmzmYds/RtoQ+Wc
X-Google-Smtp-Source: AGHT+IFnoo4O+KB10eNsI4KIvVfff6WzWUhjnpYOX/loICrrXY38hZy92dHTm6CEez3oJwaMLe7WPw==
X-Received: by 2002:a05:6a00:1141:b0:6ed:def7:6ae2 with SMTP id b1-20020a056a00114100b006eddef76ae2mr3432118pfm.6.1714576456306;
        Wed, 01 May 2024 08:14:16 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id g26-20020a63521a000000b005b458aa0541sm22172662pgb.15.2024.05.01.08.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:15 -0700 (PDT)
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
Subject: [PATCH 28/39] sched_ext: Add cgroup support
Date: Wed,  1 May 2024 05:10:03 -1000
Message-ID: <20240501151312.635565-29-tj@kernel.org>
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

Add sched_ext_ops operations to init/exit cgroups, and track task migrations
and config changes. Because different BPF schedulers may implement different
subsets of CPU control features, allow BPF schedulers to pick which cgroup
interface files to enable using SCX_OPS_CGROUP_KNOB_* flags. For now, only
the weight knobs are supported but adding more should be straightforward.

While a BPF scheduler is being enabled and disabled, relevant cgroup
operations are locked out using scx_cgroup_rwsem. This avoids situations
like task prep taking place while the task is being moved across cgroups,
making things easier for BPF schedulers.

v5: - Flipped the locking order between scx_cgroup_rwsem and
      cpus_read_lock() to avoid locking order conflict w/ cpuset. Better
      documentation around locking.

    - sched_move_task() takes an early exit if the source and destination
      are identical. This triggered the warning in scx_cgroup_can_attach()
      as it left p->scx.cgrp_moving_from uncleared. Updated the cgroup
      migration path so that ops.cgroup_prep_move() is skipped for identity
      migrations so that its invocations always match ops.cgroup_move()
      one-to-one.

v4: - Example schedulers moved into their own patches.

    - Fix build failure when !CONFIG_CGROUP_SCHED, reported by Andrea Righi.

v3: - Make scx_example_pair switch all tasks by default.

    - Convert to BPF inline iterators.

    - scx_bpf_task_cgroup() is added to determine the current cgroup from
      CPU controller's POV. This allows BPF schedulers to accurately track
      CPU cgroup membership.

    - scx_example_flatcg added. This demonstrates flattened hierarchy
      implementation of CPU cgroup control and shows significant performance
      improvement when cgroups which are nested multiple levels are under
      competition.

v2: - Build fixes for different CONFIG combinations.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/sched/ext.h                |   3 +
 init/Kconfig                             |   5 +
 kernel/sched/core.c                      |  70 ++-
 kernel/sched/ext.c                       | 524 ++++++++++++++++++++++-
 kernel/sched/ext.h                       |  20 +
 kernel/sched/sched.h                     |  12 +-
 tools/sched_ext/include/scx/common.bpf.h |   1 +
 7 files changed, 614 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index bfff0c6caa55..0a9f8e5a46af 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -157,6 +157,9 @@ struct sched_ext_entity {
 	bool			disallow;	/* reject switching into SCX */
 
 	/* cold fields */
+#ifdef CONFIG_EXT_GROUP_SCHED
+	struct cgroup		*cgrp_moving_from;
+#endif
 	/* must be the last field, see init_scx_entity() */
 	struct list_head	tasks_node;
 };
diff --git a/init/Kconfig b/init/Kconfig
index aa02aec6aa7d..b8fde3e53a77 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1033,6 +1033,11 @@ config RT_GROUP_SCHED
 	  realtime bandwidth for them.
 	  See Documentation/scheduler/sched-rt-group.rst for more information.
 
+config EXT_GROUP_SCHED
+	bool
+	depends on SCHED_CLASS_EXT && CGROUP_SCHED
+	default y
+
 endif #CGROUP_SCHED
 
 config SCHED_MM_CID
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 667527603bea..de49b94844a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10043,6 +10043,9 @@ void __init sched_init(void)
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
 		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+#ifdef CONFIG_EXT_GROUP_SCHED
+		root_task_group.scx_weight = CGROUP_WEIGHT_DFL;
+#endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
@@ -10474,6 +10477,7 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	scx_group_set_weight(tg, CGROUP_WEIGHT_DFL);
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
@@ -10601,6 +10605,7 @@ void sched_move_task(struct task_struct *tsk)
 		put_prev_task(rq, tsk);
 
 	sched_change_group(tsk, group);
+	scx_move_task(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -10638,6 +10643,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -10652,6 +10662,13 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -10669,9 +10686,10 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	sched_unregister_group(tg);
 }
 
-#ifdef CONFIG_RT_GROUP_SCHED
+#if defined(CONFIG_RT_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
+#ifdef CONFIG_RT_GROUP_SCHED
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 
@@ -10679,7 +10697,8 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
-	return 0;
+#endif
+	return scx_cgroup_can_attach(tset);
 }
 #endif
 
@@ -10690,8 +10709,17 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_for_each(task, css, tset)
 		sched_move_task(task);
+
+	scx_cgroup_finish_attach();
 }
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+static void cpu_cgroup_cancel_attach(struct cgroup_taskset *tset)
+{
+	scx_cgroup_cancel_attach(tset);
+}
+#endif
+
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 {
@@ -10870,9 +10898,15 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
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
@@ -11380,11 +11414,15 @@ static int cpu_local_stat_show(struct seq_file *sf,
 	return 0;
 }
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 
 static unsigned long tg_weight(struct task_group *tg)
 {
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	return scale_load_down(tg->shares);
+#else
+	return sched_weight_from_cgroup(tg->scx_weight);
+#endif
 }
 
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
@@ -11397,13 +11435,17 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
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
@@ -11428,7 +11470,7 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
-	int idx;
+	int idx, ret;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
@@ -11437,7 +11479,11 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
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
 
@@ -11499,7 +11545,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 #endif
 
 struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	[CPU_CFTYPE_WEIGHT] = {
 		.name = "weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -11512,6 +11558,8 @@ struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 		.read_s64 = cpu_weight_nice_read_s64,
 		.write_s64 = cpu_weight_nice_write_s64,
 	},
+#endif
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	[CPU_CFTYPE_IDLE] = {
 		.name = "idle",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -11553,14 +11601,18 @@ struct cftype cpu_cftypes[CPU_CFTYPE_CNT + 1] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
 	.css_local_stat_show = cpu_local_stat_show,
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
index 98d977c71a4f..80c313a56958 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -89,10 +89,16 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
 
+	/*
+	 * CPU cgroup knob enable flags
+	 */
+	SCX_OPS_CGROUP_KNOB_WEIGHT = 1LLU << 16,	/* cpu.weight */
+
 	SCX_OPS_ALL_FLAGS	= SCX_OPS_KEEP_BUILTIN_IDLE |
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
-				  SCX_OPS_SWITCH_PARTIAL,
+				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_CGROUP_KNOB_WEIGHT,
 };
 
 /* argument container for ops.init_task() */
@@ -102,6 +108,10 @@ struct scx_init_task_args {
 	 * to the scheduler transition path.
 	 */
 	bool			fork;
+#ifdef CONFIG_EXT_GROUP_SCHED
+	/* the cgroup the task is joining */
+	struct cgroup		*cgroup;
+#endif
 };
 
 /* argument container for ops.exit_task() */
@@ -110,6 +120,12 @@ struct scx_exit_task_args {
 	bool cancelled;
 };
 
+/* argument container for ops->cgroup_init() */
+struct scx_cgroup_init_args {
+	/* the weight of the cgroup [1..10000] */
+	u32			weight;
+};
+
 /**
  * struct sched_ext_ops - Operation table for BPF scheduler implementation
  *
@@ -366,6 +382,79 @@ struct sched_ext_ops {
 	 */
 	void (*disable)(struct task_struct *p);
 
+#ifdef CONFIG_EXT_GROUP_SCHED
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
+#endif	/* CONFIG_CGROUPS */
+
 	/*
 	 * All online ops must come before ops.init().
 	 */
@@ -492,6 +581,11 @@ enum scx_kick_flags {
 	SCX_KICK_PREEMPT	= 1LLU << 1,
 };
 
+enum scx_tg_flags {
+	SCX_TG_ONLINE		= 1U << 0,
+	SCX_TG_INITED		= 1U << 1,
+};
+
 enum scx_ops_enable_state {
 	SCX_OPS_PREPPING,
 	SCX_OPS_ENABLING,
@@ -2539,6 +2633,28 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		resched_curr(rq);
 }
 
+#ifdef CONFIG_EXT_GROUP_SCHED
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
+#define SCX_INIT_TASK_ARGS_CGROUP(tg)		.cgroup = tg_cgrp(tg),
+
+#else	/* CONFIG_EXT_GROUP_SCHED */
+
+#define SCX_INIT_TASK_ARGS_CGROUP(tg)
+
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+
 static enum scx_task_state scx_get_task_state(const struct task_struct *p)
 {
 	return (p->scx.flags & SCX_TASK_STATE_MASK) >> SCX_TASK_STATE_SHIFT;
@@ -2583,6 +2699,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 
 	if (SCX_HAS_OP(init_task)) {
 		struct scx_init_task_args args = {
+			SCX_INIT_TASK_ARGS_CGROUP(tg)
 			.fork = fork,
 		};
 
@@ -2641,7 +2758,7 @@ static void scx_ops_enable_task(struct task_struct *p)
 	scx_set_task_state(p, SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
 }
 
 static void scx_ops_disable_task(struct task_struct *p)
@@ -2851,6 +2968,180 @@ bool scx_can_stop_tick(struct rq *rq)
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
+		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, cgroup_init,
+				      tg->css.cgroup, &args);
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
+		SCX_CALL_OP(SCX_KF_SLEEPABLE, cgroup_exit, tg->css.cgroup);
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
+		struct cgroup *from = tg_cgrp(task_group(p));
+		struct cgroup *to = tg_cgrp(css_tg(css));
+
+		WARN_ON_ONCE(p->scx.cgrp_moving_from);
+
+		/*
+		 * sched_move_task() omits identity migrations. Let's match the
+		 * behavior so that ops.cgroup_prep_move() and ops.cgroup_move()
+		 * always match one-to-one.
+		 */
+		if (from == to)
+			continue;
+
+		if (SCX_HAS_OP(cgroup_prep_move)) {
+			ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, cgroup_prep_move,
+					      p, from, css->cgroup);
+			if (ret)
+				goto err;
+		}
+
+		p->scx.cgrp_moving_from = from;
+	}
+
+	return 0;
+
+err:
+	cgroup_taskset_for_each(p, css, tset) {
+		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
+			SCX_CALL_OP(SCX_KF_SLEEPABLE, cgroup_cancel_move, p,
+				    p->scx.cgrp_moving_from, css->cgroup);
+		p->scx.cgrp_moving_from = NULL;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+	return ops_sanitize_err("cgroup_prep_move", ret);
+}
+
+void scx_move_task(struct task_struct *p)
+{
+	/*
+	 * We're called from sched_move_task() which handles both cgroup and
+	 * autogroup moves. Ignore the latter.
+	 *
+	 * Also ignore exiting tasks, because in the exit path tasks transition
+	 * from the autogroup to the root group, so task_group_is_autogroup()
+	 * alone isn't able to catch exiting autogroup tasks. This is safe for
+	 * cgroup_move(), because cgroup migrations never happen for PF_EXITING
+	 * tasks.
+	 */
+	if (p->flags & PF_EXITING || task_group_is_autogroup(task_group(p)))
+		return;
+
+	if (!scx_enabled())
+		return;
+
+	/*
+	 * @p must have ops.cgroup_prep_move() called on it and thus
+	 * cgrp_moving_from set.
+	 */
+	if (SCX_HAS_OP(cgroup_move) && !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
+		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
+			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
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
+		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
+			SCX_CALL_OP(SCX_KF_SLEEPABLE, cgroup_cancel_move, p,
+				    p->scx.cgrp_moving_from, css->cgroup);
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
+			SCX_CALL_OP(SCX_KF_SLEEPABLE, cgroup_set_weight,
+				    tg_cgrp(tg), weight);
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
@@ -2980,6 +3271,131 @@ static void destroy_dsq(u64 dsq_id)
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
+		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, css->cgroup);
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
+		ret = SCX_CALL_OP_RET(SCX_KF_SLEEPABLE, cgroup_init,
+				      css->cgroup, &args);
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
 
 /********************************************************************************
  * Sysfs interface and ops enable/disable.
@@ -3260,11 +3676,12 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	WRITE_ONCE(scx_switching_all, false);
 
 	/*
-	 * Avoid racing against fork. See scx_ops_enable() for explanation on
-	 * the locking order.
+	 * Avoid racing against fork and cgroup changes. See scx_ops_enable()
+	 * for explanation on the locking order.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
 	cpus_read_lock();
+	scx_cgroup_lock();
 
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
@@ -3295,6 +3712,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
+	scx_cgroup_exit();
+
+	scx_cgroup_unlock();
 	cpus_read_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
@@ -3348,6 +3768,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 	WARN_ON_ONCE(scx_ops_set_enable_state(SCX_OPS_DISABLED) !=
 		     SCX_OPS_DISABLING);
+
+	scx_cgroup_config_knobs();
 done:
 	scx_ops_bypass(false);
 }
@@ -3636,11 +4058,17 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 			   scx_watchdog_timeout / 2);
 
 	/*
-	 * Lock out forks before opening the floodgate so that they don't wander
-	 * into the operations prematurely.
+	 * Lock out forks, cgroup on/offlining and moves before opening the
+	 * floodgate so that they don't wander into the operations prematurely.
 	 *
-	 * We don't need to keep the CPUs stable but grab cpus_read_lock() to
-	 * ease future locking changes for cgroup suport.
+	 * We don't need to keep the CPUs stable but static_branch_*() requires
+	 * cpus_read_lock() and scx_cgroup_rwsem must nest inside
+	 * cpu_hotplug_lock because of the following dependency chain:
+	 *
+	 *   cpu_hotplug_lock --> cgroup_threadgroup_rwsem --> scx_cgroup_rwsem
+	 *
+	 * So, we need to do cpus_read_lock() before scx_cgroup_lock() and use
+	 * static_branch_*_cpuslocked().
 	 *
 	 * Note that cpu_hotplug_lock must nest inside scx_fork_rwsem due to the
 	 * following dependency chain:
@@ -3649,6 +4077,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	 */
 	percpu_down_write(&scx_fork_rwsem);
 	cpus_read_lock();
+	scx_cgroup_lock();
 
 	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
 		if (((void (**)(void))ops)[i])
@@ -3667,6 +4096,14 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	}
 
+	/*
+	 * All cgroups should be initialized before letting in tasks. cgroup
+	 * on/offlining and task migrations are already locked out.
+	 */
+	ret = scx_cgroup_init();
+	if (ret)
+		goto err_disable_unlock_all;
+
 	static_branch_enable_cpuslocked(&__scx_ops_enabled);
 
 	/*
@@ -3750,6 +4187,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 
 	spin_unlock_irq(&scx_tasks_lock);
 	preempt_enable();
+	scx_cgroup_unlock();
 	cpus_read_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
@@ -3766,6 +4204,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	kobject_uevent(scx_root_kobj, KOBJ_ADD);
 	mutex_unlock(&scx_ops_enable_mutex);
 
+	scx_cgroup_config_knobs();
+
 	return 0;
 
 err_del:
@@ -3782,6 +4222,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	return ret;
 
 err_disable_unlock_all:
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 err_disable_unlock_cpus:
 	cpus_read_unlock();
@@ -3973,6 +4414,11 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 	switch (moff) {
 	case offsetof(struct sched_ext_ops, init_task):
+#ifdef CONFIG_EXT_GROUP_SCHED
+	case offsetof(struct sched_ext_ops, cgroup_init):
+	case offsetof(struct sched_ext_ops, cgroup_exit):
+	case offsetof(struct sched_ext_ops, cgroup_prep_move):
+#endif
 	case offsetof(struct sched_ext_ops, init):
 	case offsetof(struct sched_ext_ops, exit):
 		break;
@@ -4041,6 +4487,14 @@ static s32 init_task_stub(struct task_struct *p, struct scx_init_task_args *args
 static void exit_task_stub(struct task_struct *p, struct scx_exit_task_args *args) {}
 static void enable_stub(struct task_struct *p) {}
 static void disable_stub(struct task_struct *p) {}
+#ifdef CONFIG_EXT_GROUP_SCHED
+static s32 cgroup_init_stub(struct cgroup *cgrp, struct scx_cgroup_init_args *args) { return -EINVAL; }
+static void cgroup_exit_stub(struct cgroup *cgrp) {}
+static s32 cgroup_prep_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) { return -EINVAL; }
+static void cgroup_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
+static void cgroup_cancel_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
+static void cgroup_set_weight_stub(struct cgroup *cgrp, u32 weight) {}
+#endif
 static s32 init_stub(void) { return -EINVAL; }
 static void exit_stub(struct scx_exit_info *info) {}
 
@@ -4061,6 +4515,14 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.exit_task = exit_task_stub,
 	.enable = enable_stub,
 	.disable = disable_stub,
+#ifdef CONFIG_EXT_GROUP_SCHED
+	.cgroup_init = cgroup_init_stub,
+	.cgroup_exit = cgroup_exit_stub,
+	.cgroup_prep_move = cgroup_prep_move_stub,
+	.cgroup_move = cgroup_move_stub,
+	.cgroup_cancel_move = cgroup_cancel_move_stub,
+	.cgroup_set_weight = cgroup_set_weight_stub,
+#endif
 	.init = init_stub,
 	.exit = exit_stub,
 };
@@ -4229,7 +4691,8 @@ void __init init_sched_ext_class(void)
 	 * definitions so that BPF scheduler implementations can use them
 	 * through the generated vmlinux.h.
 	 */
-	WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP | SCX_KICK_PREEMPT);
+	WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP | SCX_KICK_PREEMPT |
+		   SCX_TG_ONLINE);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -4251,6 +4714,7 @@ void __init init_sched_ext_class(void)
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
+	scx_cgroup_config_knobs();
 }
 
 
@@ -4266,8 +4730,8 @@ __bpf_kfunc_start_defs();
  * @dsq_id: DSQ to create
  * @node: NUMA node to allocate from
  *
- * Create a custom DSQ identified by @dsq_id. Can be called from ops.init() and
- * ops.init_task().
+ * Create a custom DSQ identified by @dsq_id. Can be called from ops.init(),
+ * ops.init_task(), ops.cgroup_init() and ops.cgroup_prep_move().
  */
 __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
 {
@@ -4941,6 +5405,41 @@ __bpf_kfunc s32 scx_bpf_task_cpu(const struct task_struct *p)
 	return task_cpu(p);
 }
 
+/**
+ * scx_bpf_task_cgroup - Return the sched cgroup of a task
+ * @p: task of interest
+ *
+ * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
+ * from the scheduler's POV. SCX operations should use this function to
+ * determine @p's current cgroup as, unlike following @p->cgroups,
+ * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
+ * rq-locked operations. Can be called on the parameter tasks of rq-locked
+ * operations. The restriction guarantees that @p's rq is locked by the caller.
+ */
+#ifdef CONFIG_CGROUP_SCHED
+__bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
+{
+	struct task_group *tg = p->sched_task_group;
+	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
+
+	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
+		goto out;
+
+	/*
+	 * A task_group may either be a cgroup or an autogroup. In the latter
+	 * case, @tg->css.cgroup is %NULL. A task_group can't become the other
+	 * kind once created.
+	 */
+	if (tg && tg->css.cgroup)
+		cgrp = tg->css.cgroup;
+	else
+		cgrp = &cgrp_dfl_root.cgrp;
+out:
+	cgroup_get(cgrp);
+	return cgrp;
+}
+#endif
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
@@ -4961,6 +5460,9 @@ BTF_ID_FLAGS(func, scx_bpf_pick_idle_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
+#ifdef CONFIG_CGROUP_SCHED
+BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
+#endif
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 954ae4c2b53d..1017439dcc00 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -105,3 +105,23 @@ static inline void scx_update_idle(struct rq *rq, bool idle)
 #else
 static inline void scx_update_idle(struct rq *rq, bool idle) {}
 #endif
+
+#ifdef CONFIG_CGROUP_SCHED
+#ifdef CONFIG_EXT_GROUP_SCHED
+int scx_tg_online(struct task_group *tg);
+void scx_tg_offline(struct task_group *tg);
+int scx_cgroup_can_attach(struct cgroup_taskset *tset);
+void scx_move_task(struct task_struct *p);
+void scx_cgroup_finish_attach(void);
+void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
+void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
+#else	/* CONFIG_EXT_GROUP_SCHED */
+static inline int scx_tg_online(struct task_group *tg) { return 0; }
+static inline void scx_tg_offline(struct task_group *tg) {}
+static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
+static inline void scx_move_task(struct task_struct *p) {}
+static inline void scx_cgroup_finish_attach(void) {}
+static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
+static inline void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight) {}
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+#endif	/* CONFIG_CGROUP_SCHED */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c6c9b46eeacc..0ca2378bb252 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -432,6 +432,11 @@ struct task_group {
 	struct rt_bandwidth	rt_bandwidth;
 #endif
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	u32			scx_flags;	/* SCX_TG_* */
+	u32			scx_weight;
+#endif
+
 	struct rcu_head		rcu;
 	struct list_head	list;
 
@@ -548,6 +553,11 @@ extern void set_task_rq_fair(struct sched_entity *se,
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
@@ -3549,7 +3559,7 @@ extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 #ifdef CONFIG_CGROUP_SCHED
 enum cpu_cftype_id {
-#ifdef CONFIG_FAIR_GROUP_SCHED
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_EXT_GROUP_SCHED)
 	CPU_CFTYPE_WEIGHT,
 	CPU_CFTYPE_WEIGHT_NICE,
 	CPU_CFTYPE_IDLE,
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 8b4052034f93..f0dbaa1826a7 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -51,6 +51,7 @@ s32 scx_bpf_pick_idle_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
+struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym;
 
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_exit_format_checker(const char *fmt, ...) {}
-- 
2.44.0


