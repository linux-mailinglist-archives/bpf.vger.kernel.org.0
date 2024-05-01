Return-Path: <bpf+bounces-28367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C758B8CCA
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B051C20C3B
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A9F13B2BA;
	Wed,  1 May 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqDuK+n8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C381384A3;
	Wed,  1 May 2024 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576477; cv=none; b=cczWJdwhRhOpX0nKZt5Qh3ApJDTvypqAgoLag2Oy+Ky3i/1RHc3WRdOli8PWcR+GtyFAsXEmP2SyB6sJM0Z+AeHG6GtGNM8cc6TjwGO5PE/onhAkm6xD1aQa0ZbLHKhj04HdeG/JEewLEpG5rnNZGM3W30CK+l04KBYRZB/witc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576477; c=relaxed/simple;
	bh=nMIXSBoKvniWGESPS5Uh47Eotbh3hmc3i6CVrGxqUOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlAtZHBCJ57Vbkdr0FGU/qEF9iTziSaD1clpDVBmka3pHhRyZs2WNwsIvMvVh8RlRJFk0sYg3ZXiM4QqHPE/PP+6fhRABPnfZL+zgpE5gGqnBy6fAernEc61Q/ZAjk8uLNR+UiV0xPOeFy4l/39oAV5LA3EmZsNkh7PJlRq4OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqDuK+n8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so6418613b3a.3;
        Wed, 01 May 2024 08:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576475; x=1715181275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlW0Y/YHuaT/2QKXGoK9M3u0rs4rrJBxL/mOXy7/PGs=;
        b=mqDuK+n8kpPK1XsleI3pn8YvAVlUYaTK3C68DLc6n4dBJIFPcSRxytWktiCYjLeLTl
         YXbYYpXOLSmKRpxaVLb6h0nMUXvWFc/YC+VElQeTHohJefiRyPjlM+w+An17duvYFFfF
         h1GZYxO/AGW5fpIzFUBGT7E4vioJrVQ+CspoRAONMzPsbqCfhgSQtXVJalX7emq/Zb/9
         JY0vkAYH85TCkyYrM7Tzg9KzNSX6rhUEeX4f0maE4z/6NZNs7GoE0qA0rmh+AZ6h65dn
         W0/bCpm+7eWd5bGjjCCXMp4qDvw3anHHMyHetYrgORVYV5/soiVqdtOzAtayD5Dtqw2G
         q6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576475; x=1715181275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qlW0Y/YHuaT/2QKXGoK9M3u0rs4rrJBxL/mOXy7/PGs=;
        b=tkUfu5seSK+9cnwSaBUUy8d/SIpjJBjsxZe4RjkPf9szHtGMvcB1tw+43IqGq5h/Ez
         oy05e7v7/estICTCjIIdHfaW2C0IGkASwaysxlerICIhFy0w3RlvFFwzyY6CNeZau74Z
         rZ0j4B2cYq09X4dVXBkuFdDLZ57vldjaT645W18usQ6b4MNm7XQLgdM78JrK3sWWjqgu
         SMH702CtTCj3N1ySu3l+k4Bt3wl3hKJVD6l0GHi4cUnz0STvuzK4hU+pnhDfpcLyBZhK
         aJv1O3CvvPdcwxJKbfHqYWjX0p4fyCLfw5Id/e+BxbnoFkqXzVg6kxlNfthhCLtzXknl
         LgPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvi1qEZ/B/vQ1rBs7UK5D1pA7rZKq//BYsvHVHfQ3vAyzclKNOv7fgrTE10UFnHzy9EMd6tcB5qUPh1YlZ4QQuzjyX
X-Gm-Message-State: AOJu0YxM7+HJWzTDILfBA+GUCDzxvqC27MXmVtmgL8gIDj2f07F1MhyP
	JBrANYq8t5dUTJ1qg90HX3hw0ezAkCnTWS5ZyrNH/zZ3OYW2RbWk
X-Google-Smtp-Source: AGHT+IHQpeNETnlZqGQJIGW2F/MsUSqY0XVyRBiPOC7+3d1RWR1XJF84Y1IQiHWnSi/Tr+2aW+nznQ==
X-Received: by 2002:a05:6a00:3919:b0:6ea:e2fd:6100 with SMTP id fh25-20020a056a00391900b006eae2fd6100mr3176801pfb.30.1714576472996;
        Wed, 01 May 2024 08:14:32 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id fi33-20020a056a0039a100b006e65d66bb3csm22724565pfb.21.2024.05.01.08.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:32 -0700 (PDT)
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 37/39] sched_ext: Add cpuperf support
Date: Wed,  1 May 2024 05:10:12 -1000
Message-ID: <20240501151312.635565-38-tj@kernel.org>
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

This patch adds CPU performance monitoring and scaling support by
integrating into schedutil. The following kfuncs are added:

- scx_bpf_cpuperf_cap(): Query the relative performance capacity of
  different CPUs in the system.

- scx_bpf_cpuperf_cur(): Query the current performance level of a CPU
  relative to its max performance.

- scx_bpf_cpuperf_set(): Set the current target performance level of a CPU.

This gives direct control over CPU performance setting to the BPF scheduler.
The only change on the schedutil side is disabling frequency holding
heuristics as it doesn't apply well to sched_ext schedulers which may have a
lot weaker conneciton between tasks and their current / last CPU.

A toy implementation of cpuperf is added to scx_qmap as a demonstration of
the feature.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/cpufreq_schedutil.c         |   8 ++
 kernel/sched/ext.c                       |  83 +++++++++++++++++-
 kernel/sched/ext.h                       |   3 +-
 kernel/sched/sched.h                     |   1 +
 tools/sched_ext/include/scx/common.bpf.h |   3 +
 tools/sched_ext/include/scx/compat.bpf.h |  26 ++++++
 tools/sched_ext/scx_qmap.bpf.c           | 106 +++++++++++++++++++++++
 tools/sched_ext/scx_qmap.c               |   8 ++
 8 files changed, 234 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 0827864c35ff..12174c0137a5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -332,6 +332,14 @@ static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
 	unsigned long idle_calls;
 	bool ret;
 
+	/*
+	 * The heuristics in this function is for the fair class. For SCX, the
+	 * performance target comes directly from the BPF scheduler. Let's just
+	 * follow it.
+	 */
+	if (scx_switched_all())
+		return false;
+
 	/* if capped by uclamp_max, always update to be in compliance */
 	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
 		return false;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fb4849fb7afd..6b7990f56845 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -14,6 +14,8 @@ enum scx_consts {
 	SCX_EXIT_BT_LEN			= 64,
 	SCX_EXIT_MSG_LEN		= 1024,
 	SCX_EXIT_DUMP_DFL_LEN		= 32768,
+
+	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
 };
 
 enum scx_exit_kind {
@@ -3810,7 +3812,7 @@ DEFINE_SCHED_CLASS(ext) = {
 	.update_curr		= update_curr_scx,
 
 #ifdef CONFIG_UCLAMP_TASK
-	.uclamp_enabled		= 0,
+	.uclamp_enabled		= 1,
 #endif
 };
 
@@ -4628,7 +4630,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	unsigned long timeout;
-	int i, ret;
+	int i, cpu, ret;
 
 	mutex_lock(&scx_ops_enable_mutex);
 
@@ -4677,6 +4679,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 
 	atomic_long_set(&scx_nr_rejected, 0);
 
+	for_each_possible_cpu(cpu)
+		cpu_rq(cpu)->scx.cpuperf_target = SCX_CPUPERF_ONE;
+
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
 	 * online CPUs by watching ->on/offline_cpu() after ->init().
@@ -6227,6 +6232,77 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 			     data__sz);
 }
 
+/**
+ * scx_bpf_cpuperf_cap - Query the maximum relative capacity of a CPU
+ * @cpu: CPU of interest
+ *
+ * Return the maximum relative capacity of @cpu in relation to the most
+ * performant CPU in the system. The return value is in the range [1,
+ * %SCX_CPUPERF_ONE]. See scx_bpf_cpuperf_cur().
+ */
+__bpf_kfunc u32 scx_bpf_cpuperf_cap(s32 cpu)
+{
+	if (ops_cpu_valid(cpu, NULL))
+		return arch_scale_cpu_capacity(cpu);
+	else
+		return SCX_CPUPERF_ONE;
+}
+
+/**
+ * scx_bpf_cpuperf_cur - Query the current relative performance of a CPU
+ * @cpu: CPU of interest
+ *
+ * Return the current relative performance of @cpu in relation to its maximum.
+ * The return value is in the range [1, %SCX_CPUPERF_ONE].
+ *
+ * The current performance level of a CPU in relation to the maximum performance
+ * available in the system can be calculated as follows:
+ *
+ *   scx_bpf_cpuperf_cap() * scx_bpf_cpuperf_cur() / %SCX_CPUPERF_ONE
+ *
+ * The result is in the range [1, %SCX_CPUPERF_ONE].
+ */
+__bpf_kfunc u32 scx_bpf_cpuperf_cur(s32 cpu)
+{
+	if (ops_cpu_valid(cpu, NULL))
+		return arch_scale_freq_capacity(cpu);
+	else
+		return SCX_CPUPERF_ONE;
+}
+
+/**
+ * scx_bpf_cpuperf_set - Set the relative performance target of a CPU
+ * @cpu: CPU of interest
+ * @perf: target performance level [0, %SCX_CPUPERF_ONE]
+ * @flags: %SCX_CPUPERF_* flags
+ *
+ * Set the target performance level of @cpu to @perf. @perf is in linear
+ * relative scale between 0 and %SCX_CPUPERF_ONE. This determines how the
+ * schedutil cpufreq governor chooses the target frequency.
+ *
+ * The actual performance level chosen, CPU grouping, and the overhead and
+ * latency of the operations are dependent on the hardware and cpufreq driver in
+ * use. Consult hardware and cpufreq documentation for more information. The
+ * current performance level can be monitored using scx_bpf_cpuperf_cur().
+ */
+__bpf_kfunc void scx_bpf_cpuperf_set(u32 cpu, u32 perf)
+{
+	if (unlikely(perf > SCX_CPUPERF_ONE)) {
+		scx_ops_error("Invalid cpuperf target %u for CPU %d", perf, cpu);
+		return;
+	}
+
+	if (ops_cpu_valid(cpu, NULL)) {
+		struct rq *rq = cpu_rq(cpu);
+
+		rq->scx.cpuperf_target = perf;
+
+		rcu_read_lock_sched_notrace();
+		cpufreq_update_util(cpu_rq(cpu), 0);
+		rcu_read_unlock_sched_notrace();
+	}
+}
+
 /**
  * scx_bpf_nr_cpu_ids - Return the number of possible CPU IDs
  *
@@ -6474,6 +6550,9 @@ BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur)
+BTF_ID_FLAGS(func, scx_bpf_cpuperf_set)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 6fd646450065..f555395d9783 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -46,9 +46,8 @@ void init_sched_ext_class(void);
 
 static inline u32 scx_cpuperf_target(s32 cpu)
 {
-	/* for now, peg cpus at max performance while enabled */
 	if (scx_enabled())
-		return SCHED_CAPACITY_SCALE;
+		return cpu_rq(cpu)->scx.cpuperf_target;
 	else
 		return 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e8ef7309f347..d31db189977a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -732,6 +732,7 @@ struct scx_rq {
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
 	u32			flags;
+	u32			cpuperf_target;		/* [0, SCHED_CAPACITY_SCALE] */
 	bool			cpu_released;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_kick_if_idle;
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 17c76919e450..20ebb407148e 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -45,6 +45,9 @@ struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __
 void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
+u32 scx_bpf_cpuperf_cap(s32 cpu) __ksym __weak;
+u32 scx_bpf_cpuperf_cur(s32 cpu) __ksym __weak;
+void scx_bpf_cpuperf_set(s32 cpu, u32 perf) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index c17ef3757b31..8fcba2505ad5 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -56,6 +56,32 @@ static inline void __COMPAT_scx_bpf_switch_all(void)
 #define __COMPAT_HAS_CPUMASKS							\
 	bpf_ksym_exists(scx_bpf_nr_cpu_ids)
 
+/*
+ * cpuperf is new. The followings become noop on older kernels. Callers can be
+ * updated to call cpuperf kfuncs directly in the future.
+ */
+static inline u32 __COMPAT_scx_bpf_cpuperf_cap(s32 cpu)
+{
+	if (bpf_ksym_exists(scx_bpf_cpuperf_cap))
+		return scx_bpf_cpuperf_cap(cpu);
+	else
+		return 1024;
+}
+
+static inline u32 __COMPAT_scx_bpf_cpuperf_cur(s32 cpu)
+{
+	if (bpf_ksym_exists(scx_bpf_cpuperf_cur))
+		return scx_bpf_cpuperf_cur(cpu);
+	else
+		return 1024;
+}
+
+static inline void __COMPAT_scx_bpf_cpuperf_set(s32 cpu, u32 perf)
+{
+	if (bpf_ksym_exists(scx_bpf_cpuperf_set))
+		return scx_bpf_cpuperf_set(cpu, perf);
+}
+
 /*
  * Iteration and scx_bpf_consume_task() are new. The following become noop on
  * older kernels. The users can switch to bpf_for_each(scx_dsq) and directly
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 924e7e2b8c4c..977c7cff7b34 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -71,6 +71,18 @@ struct {
 	},
 };
 
+/*
+ * If enabled, CPU performance target is set according to the queue index
+ * according to the following table.
+ */
+static const u32 qidx_to_cpuperf_target[] = {
+	[0] = SCX_CPUPERF_ONE * 0 / 4,
+	[1] = SCX_CPUPERF_ONE * 1 / 4,
+	[2] = SCX_CPUPERF_ONE * 2 / 4,
+	[3] = SCX_CPUPERF_ONE * 3 / 4,
+	[4] = SCX_CPUPERF_ONE * 4 / 4,
+};
+
 /*
  * Per-queue sequence numbers to implement core-sched ordering.
  *
@@ -98,6 +110,8 @@ struct {
 struct cpu_ctx {
 	u64	dsp_idx;	/* dispatch index */
 	u64	dsp_cnt;	/* remaining count */
+	u32	avg_weight;
+	u32	cpuperf_target;
 };
 
 struct {
@@ -110,6 +124,8 @@ struct {
 /* Statistics */
 u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
 u64 nr_core_sched_execed, nr_expedited;
+u32 cpuperf_min, cpuperf_avg, cpuperf_max;
+u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
 
 s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -347,6 +363,29 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+void BPF_STRUCT_OPS(qmap_tick, struct task_struct *p)
+{
+	struct cpu_ctx *cpuc;
+	u32 zero = 0;
+	int idx;
+
+	if (!(cpuc = bpf_map_lookup_elem(&cpu_ctx_stor, &zero))) {
+		scx_bpf_error("failed to look up cpu_ctx");
+		return;
+	}
+
+	/*
+	 * Use the running avg of weights to select the target cpuperf level.
+	 * This is a demonstration of the cpuperf feature rather than a
+	 * practical strategy to regulate CPU frequency.
+	 */
+	cpuc->avg_weight = cpuc->avg_weight * 3 / 4 + p->scx.weight / 4;
+	idx = weight_to_idx(cpuc->avg_weight);
+	cpuc->cpuperf_target = qidx_to_cpuperf_target[idx];
+
+	scx_bpf_cpuperf_set(scx_bpf_task_cpu(p), cpuc->cpuperf_target);
+}
+
 /*
  * The distance from the head of the queue scaled by the weight of the queue.
  * The lower the number, the older the task and the higher the priority.
@@ -490,6 +529,70 @@ struct {
 	__type(value, struct monitor_timer);
 } central_timer SEC(".maps");
 
+/*
+ * Print out the min, avg and max performance levels of CPUs every second to
+ * demonstrate the cpuperf interface.
+ */
+static void monitor_cpuperf(void)
+{
+	u32 zero = 0, nr_cpu_ids;
+	u64 cap_sum = 0, cur_sum = 0, cur_min = SCX_CPUPERF_ONE, cur_max = 0;
+	u64 target_sum = 0, target_min = SCX_CPUPERF_ONE, target_max = 0;
+	const struct cpumask *online;
+	int i, nr_online_cpus = 0;
+
+	if (!__COMPAT_HAS_CPUMASKS)
+		return;
+
+	nr_cpu_ids = scx_bpf_nr_cpu_ids();
+	online = scx_bpf_get_online_cpumask();
+
+	bpf_for(i, 0, nr_cpu_ids) {
+		struct cpu_ctx *cpuc;
+		u32 cap, cur;
+
+		if (!bpf_cpumask_test_cpu(i, online))
+			continue;
+		nr_online_cpus++;
+
+		/* collect the capacity and current cpuperf */
+		cap = scx_bpf_cpuperf_cap(i);
+		cur = scx_bpf_cpuperf_cur(i);
+
+		cur_min = cur < cur_min ? cur : cur_min;
+		cur_max = cur > cur_max ? cur : cur_max;
+
+		/*
+		 * $cur is relative to $cap. Scale it down accordingly so that
+		 * it's in the same scale as other CPUs and $cur_sum/$cap_sum
+		 * makes sense.
+		 */
+		cur_sum += cur * cap / SCX_CPUPERF_ONE;
+		cap_sum += cap;
+
+		if (!(cpuc = bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, i))) {
+			scx_bpf_error("failed to look up cpu_ctx");
+			goto out;
+		}
+
+		/* collect target */
+		cur = cpuc->cpuperf_target;
+		target_sum += cur;
+		target_min = cur < target_min ? cur : target_min;
+		target_max = cur > target_max ? cur : target_max;
+	}
+
+	cpuperf_min = cur_min;
+	cpuperf_avg = cur_sum * SCX_CPUPERF_ONE / cap_sum;
+	cpuperf_max = cur_max;
+
+	cpuperf_target_min = target_min;
+	cpuperf_target_avg = target_sum / nr_online_cpus;
+	cpuperf_target_max = target_max;
+out:
+	scx_bpf_put_cpumask(online);
+}
+
 /*
  * Dump the currently queued tasks in the shared DSQ to demonstrate the usage of
  * scx_bpf_dsq_nr_queued() and DSQ iterator. Raise the dispatch batch count to
@@ -513,6 +616,8 @@ static void dump_shared_dsq(void)
 
 static int monitor_timerfn(void *map, int *key, struct bpf_timer *timer)
 {
+	monitor_cpuperf();
+
 	if (print_shared_dsq)
 		dump_shared_dsq();
 
@@ -555,6 +660,7 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .enqueue			= (void *)qmap_enqueue,
 	       .dequeue			= (void *)qmap_dequeue,
 	       .dispatch		= (void *)qmap_dispatch,
+	       .tick			= (void *)qmap_tick,
 	       .core_sched_before	= (void *)qmap_core_sched_before,
 	       .cpu_release		= (void *)qmap_cpu_release,
 	       .init_task		= (void *)qmap_init_task,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 1b8cd2993ee2..eb221f0a0580 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -127,6 +127,14 @@ int main(int argc, char **argv)
 		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
 		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
 		       skel->bss->nr_core_sched_execed, skel->bss->nr_expedited);
+		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
+			printf("cpuperf: cur min/avg/max=%u/%u/%u target min/avg/max=%u/%u/%u\n",
+			       skel->bss->cpuperf_min,
+			       skel->bss->cpuperf_avg,
+			       skel->bss->cpuperf_max,
+			       skel->bss->cpuperf_target_min,
+			       skel->bss->cpuperf_target_avg,
+			       skel->bss->cpuperf_target_max);
 		fflush(stdout);
 		sleep(1);
 	}
-- 
2.44.0


