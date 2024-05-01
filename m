Return-Path: <bpf+bounces-28362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125368B8CC0
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359C11C21EA6
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48A1386D5;
	Wed,  1 May 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrWlml9Z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C591384A3;
	Wed,  1 May 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576466; cv=none; b=cKQwq9T90GiuHKigQUVEaaewPmOMM7s1B742NEU0D5wV8L0aQP5h/G/5VnLN51kPVASdCEgZgwjoThzw91QOJDt3qPNmqstFTJs+2NdNB1QzKz+7jDZjO30E02DJg8HnrRID2OpLJpcpfFvKMs3AoZkSix6MTe0kLCTXvq/+YkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576466; c=relaxed/simple;
	bh=retGCjtTk4hGf8NTfQt1bFjJN8vEYhewsVdL9WPuRIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCydV0GoBFbSiMSogrndlTWSOlfW9Lu/M14T7W/MwZbSvd+qMl9WCri3bhKRY5WeNe4lRuquAykCUiu7AZ9MTmfvCdeIEFxsY/f5Z66VSxQ+DH4tjsM7FkiaeFPlmCBZ6XF6cS/btiWb+10kt9asbfAPE/Q8gRKQOhdOm/IJlLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrWlml9Z; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so5946427b3a.0;
        Wed, 01 May 2024 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576463; x=1715181263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNU6AB23Y7SjdFetr5oMDfmCIpiADScOnXYt4JvzS9c=;
        b=YrWlml9Z90NEaPm4ahI1EK+ocyAl/gzuaZOYWvL+Rmnnc80EwsNkBTy0AC4ASE0YvK
         Y3mDc2OeO9TzjaN6rZQlA2QM2XSmdQB8T/GjoP2GxxhHQ2T0iowniOUGJkrImDZXA91O
         sH7m8Mo1l9Dn+O0r0t68vVyo6ih3QQfgx9HpZLpup1N3w9+szMfDZhBVibpfWbU6Eoew
         5pka0WobpGwMd/Mj8CgTdV7W5EwQXlj4cCopyE1kid4Tf5NwCDoMdf+doFOiD+ZmxA5C
         uq/h2r2Aieph4YLG/kxy97a14uNJ14prfz9HqvXdi8ajLdpbXED4MgId/ZnL3pWHrm4D
         b8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576463; x=1715181263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNU6AB23Y7SjdFetr5oMDfmCIpiADScOnXYt4JvzS9c=;
        b=XXq0CbBS4UDVFRiUF4yqjCJTVvwe5ISG0UEsO28CLOfznWsfpTZBAePAl6t2FJAKOc
         OUA9imOUry/RdhE1QMlHA5LAMZxpxxZXRIDOIWK/Dd43Qgjp3d6+EBl25hYzIubjNS/c
         /Zy4ucIofEJcvqg2X5gf1EhHaHDGsGcORlYwtYyRCJZeZODErZiczEC0S9gIAKfGqTD5
         7ktR6P7QZiWySbFsZ+L9hR7bSMxxcgYWS4YRUDbgK5hAihOMMWfP3RUn+G/+jVixtsL4
         h0IkdxuiINTF0+XXcXoQKbhxOZsIjET2pzmEUtTqXIDOKIvyKwtn7TACZsv/xmuhTgQz
         3OAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtNrpfAfdkm+/NSiR6aoyn4DNvS5Cr43WepcfvihDcVarYNkhpOEg2DZsjQj85hDEytF9dncPx3YDddnk/fej3UYAg
X-Gm-Message-State: AOJu0YzE7z3FB69cR1fztiy79nLvhunPy6CWoamN87/T0JpxUlPB6A7m
	9MdkvH6Apla1zxz+VNfPgJJ9eU9C9PPaygQPCOfqadsKeMFSujKu
X-Google-Smtp-Source: AGHT+IHEb0GWcUEsY7tnpDz3GSxxsi7W1HczzGpwRqpg2ywDtzZO9ExMmzNl3lUe/VMKY71oHx5thg==
X-Received: by 2002:a05:6a00:10d0:b0:6f0:b53c:dfb4 with SMTP id d16-20020a056a0010d000b006f0b53cdfb4mr3413710pfu.22.1714576463173;
        Wed, 01 May 2024 08:14:23 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id n7-20020aa78a47000000b006edd9339917sm22718281pfa.58.2024.05.01.08.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:14:22 -0700 (PDT)
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
Subject: [PATCH 32/39] sched_ext: Implement sched_ext_ops.cpu_online/offline()
Date: Wed,  1 May 2024 05:10:07 -1000
Message-ID: <20240501151312.635565-33-tj@kernel.org>
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

Add ops.cpu_online/offline() which are invoked when CPUs come online and
offline respectively. As the enqueue path already automatically bypasses
tasks to the local dsq on a deactivated CPU, BPF schedulers are guaranteed
to see tasks only on CPUs which are between online() and offline().

If the BPF scheduler doesn't implement ops.cpu_online/offline(), the
scheduler is automatically exited with SCX_ECODE_RESTART |
SCX_ECODE_RSN_HOTPLUG. Userspace can implement CPU hotpplug support
trivially by simply reinitializing and reloading the scheduler.

scx_qmap is updated to print out online CPUs on hotplug events. Other
schedulers are updated to restart based on ecode.

v2: - To accommodate lock ordering change between scx_cgroup_rwsem and
      cpus_read_lock(), CPU hotplug operations are put into its own SCX_OPI
      block and enabled eariler during scx_ope_enable() so that
      cpus_read_lock() can be dropped before acquiring scx_cgroup_rwsem.

    - Auto exit with ECODE added.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 kernel/sched/ext.c                           | 135 ++++++++++++++++++-
 tools/sched_ext/include/scx/compat.h         |  29 ++++
 tools/sched_ext/include/scx/user_exit_info.h |  28 ++++
 tools/sched_ext/scx_central.c                |   9 +-
 tools/sched_ext/scx_flatcg.c                 |   8 +-
 tools/sched_ext/scx_qmap.bpf.c               |  60 +++++++++
 tools/sched_ext/scx_qmap.c                   |   4 +
 tools/sched_ext/scx_simple.c                 |   8 +-
 8 files changed, 271 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9bc03533cf5e..ed2452d42862 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -30,6 +30,29 @@ enum scx_exit_kind {
 	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
 };
 
+/*
+ * An exit code can be specified when exiting with scx_bpf_exit() or
+ * scx_ops_exit(), corresponding to exit_kind UNREG_BPF and UNREG_KERN
+ * respectively. The codes are 64bit of the format:
+ *
+ *   Bits: [63  ..  48 47   ..  32 31 .. 0]
+ *         [ SYS ACT ] [ SYS RSN ] [ USR  ]
+ *
+ *   SYS ACT: System-defined exit actions
+ *   SYS RSN: System-defined exit reasons
+ *   USR    : User-defined exit codes and reasons
+ *
+ * Using the above, users may communicate intention and context by ORing system
+ * actions and/or system reasons with a user-defined exit code.
+ */
+enum scx_exit_code {
+	/* Reasons */
+	SCX_ECODE_RSN_HOTPLUG	= 1LLU << 32,
+
+	/* Actions */
+	SCX_ECODE_ACT_RESTART	= 1LLU << 48,
+};
+
 /*
  * scx_exit_info is passed to ops.exit() to describe why the BPF scheduler is
  * being disabled.
@@ -504,7 +527,29 @@ struct sched_ext_ops {
 #endif	/* CONFIG_CGROUPS */
 
 	/*
-	 * All online ops must come before ops.init().
+	 * All online ops must come before ops.cpu_online().
+	 */
+
+	/**
+	 * cpu_online - A CPU became online
+	 * @cpu: CPU which just came up
+	 *
+	 * @cpu just came online. @cpu doesn't call ops.enqueue() or run tasks
+	 * associated with other CPUs beforehand.
+	 */
+	void (*cpu_online)(s32 cpu);
+
+	/**
+	 * cpu_offline - A CPU is going offline
+	 * @cpu: CPU which is going offline
+	 *
+	 * @cpu is going offline. @cpu doesn't call ops.enqueue() or run tasks
+	 * associated with other CPUs afterwards.
+	 */
+	void (*cpu_offline)(s32 cpu);
+
+	/*
+	 * All CPU hotplug ops must come before ops.init().
 	 */
 
 	/**
@@ -543,6 +588,15 @@ struct sched_ext_ops {
 	 */
 	u32 exit_dump_len;
 
+	/**
+	 * hotplug_seq - A sequence number that may be set by the scheduler to
+	 * detect when a hotplug event has occurred during the loading process.
+	 * If 0, no detection occurs. Otherwise, the scheduler will fail to
+	 * load if the sequence number does not match @scx_hotplug_seq on the
+	 * enable path.
+	 */
+	u64 hotplug_seq;
+
 	/**
 	 * name - BPF scheduler's name
 	 *
@@ -556,7 +610,9 @@ struct sched_ext_ops {
 enum scx_opi {
 	SCX_OPI_BEGIN			= 0,
 	SCX_OPI_NORMAL_BEGIN		= 0,
-	SCX_OPI_NORMAL_END		= SCX_OP_IDX(init),
+	SCX_OPI_NORMAL_END		= SCX_OP_IDX(cpu_online),
+	SCX_OPI_CPU_HOTPLUG_BEGIN	= SCX_OP_IDX(cpu_online),
+	SCX_OPI_CPU_HOTPLUG_END		= SCX_OP_IDX(init),
 	SCX_OPI_END			= SCX_OP_IDX(init),
 };
 
@@ -746,6 +802,7 @@ static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
 static struct scx_exit_info *scx_exit_info;
 
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
+static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
 /*
  * The maximum amount of time in jiffies that a task may be runnable without
@@ -2172,7 +2229,8 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		 * emitted in scx_next_task_picked().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_acquire, cpu_of(rq),
+				    NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -2700,6 +2758,34 @@ void __scx_update_idle(struct rq *rq, bool idle)
 #endif
 }
 
+static void handle_hotplug(struct rq *rq, bool online)
+{
+	int cpu = cpu_of(rq);
+
+	atomic_long_inc(&scx_hotplug_seq);
+
+	if (online && SCX_HAS_OP(cpu_online))
+		SCX_CALL_OP(SCX_KF_REST, cpu_online, cpu);
+	else if (!online && SCX_HAS_OP(cpu_offline))
+		SCX_CALL_OP(SCX_KF_REST, cpu_offline, cpu);
+	else
+		scx_ops_exit(SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
+			     "cpu %d going %s, exiting scheduler", cpu,
+			     online ? "online" : "offline");
+}
+
+static void rq_online_scx(struct rq *rq, enum rq_onoff_reason reason)
+{
+	if (reason == RQ_ONOFF_HOTPLUG)
+		handle_hotplug(rq, true);
+}
+
+static void rq_offline_scx(struct rq *rq, enum rq_onoff_reason reason)
+{
+	if (reason == RQ_ONOFF_HOTPLUG)
+		handle_hotplug(rq, false);
+}
+
 #else	/* CONFIG_SMP */
 
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
@@ -3328,6 +3414,9 @@ DEFINE_SCHED_CLASS(ext) = {
 	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
+
+	.rq_online		= rq_online_scx,
+	.rq_offline		= rq_offline_scx,
 #endif
 
 	.task_tick		= task_tick_scx,
@@ -3584,10 +3673,18 @@ static ssize_t scx_attr_nr_rejected_show(struct kobject *kobj,
 }
 SCX_ATTR(nr_rejected);
 
+static ssize_t scx_attr_hotplug_seq_show(struct kobject *kobj,
+					 struct kobj_attribute *ka, char *buf)
+{
+	return sysfs_emit(buf, "%ld\n", atomic_long_read(&scx_hotplug_seq));
+}
+SCX_ATTR(hotplug_seq);
+
 static struct attribute *scx_global_attrs[] = {
 	&scx_attr_state.attr,
 	&scx_attr_switch_all.attr,
 	&scx_attr_nr_rejected.attr,
+	&scx_attr_hotplug_seq.attr,
 	NULL,
 };
 
@@ -4110,6 +4207,25 @@ static struct kthread_worker *scx_create_rt_helper(const char *name)
 	return helper;
 }
 
+static void check_hotplug_seq(const struct sched_ext_ops *ops)
+{
+	unsigned long long global_hotplug_seq;
+
+	/*
+	 * If a hotplug event has occurred between when a scheduler was
+	 * initialized, and when we were able to attach, exit and notify user
+	 * space about it.
+	 */
+	if (ops->hotplug_seq) {
+		global_hotplug_seq = atomic_long_read(&scx_hotplug_seq);
+		if (ops->hotplug_seq != global_hotplug_seq) {
+			scx_ops_exit(SCX_ECODE_ACT_RESTART | SCX_ECODE_RSN_HOTPLUG,
+				     "expected hotplug seq %llu did not match actual %llu",
+				     ops->hotplug_seq, global_hotplug_seq);
+		}
+	}
+}
+
 static int validate_ops(const struct sched_ext_ops *ops)
 {
 	/*
@@ -4192,6 +4308,10 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		}
 	}
 
+	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
+		if (((void (**)(void))ops)[i])
+			static_branch_enable_cpuslocked(&scx_has_op[i]);
+
 	cpus_read_unlock();
 
 	ret = validate_ops(ops);
@@ -4239,6 +4359,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	cpus_read_lock();
 	scx_cgroup_lock();
 
+	check_hotplug_seq(ops);
+
 	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
 		if (((void (**)(void))ops)[i])
 			static_branch_enable_cpuslocked(&scx_has_op[i]);
@@ -4563,6 +4685,9 @@ static int bpf_scx_init_member(const struct btf_type *t,
 		ops->exit_dump_len =
 			*(u32 *)(udata + moff) ?: SCX_EXIT_DUMP_DFL_LEN;
 		return 1;
+	case offsetof(struct sched_ext_ops, hotplug_seq):
+		ops->hotplug_seq = *(u64 *)(udata + moff);
+		return 1;
 	}
 
 	return 0;
@@ -4659,6 +4784,8 @@ static void cgroup_move_stub(struct task_struct *p, struct cgroup *from, struct
 static void cgroup_cancel_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
 static void cgroup_set_weight_stub(struct cgroup *cgrp, u32 weight) {}
 #endif
+static void cpu_online_stub(s32 cpu) {}
+static void cpu_offline_stub(s32 cpu) {}
 static s32 init_stub(void) { return -EINVAL; }
 static void exit_stub(struct scx_exit_info *info) {}
 
@@ -4689,6 +4816,8 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.cgroup_cancel_move = cgroup_cancel_move_stub,
 	.cgroup_set_weight = cgroup_set_weight_stub,
 #endif
+	.cpu_online = cpu_online_stub,
+	.cpu_offline = cpu_offline_stub,
 	.init = init_stub,
 	.exit = exit_stub,
 };
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 2be79bd88a25..7155b69150ff 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -8,6 +8,9 @@
 #define __SCX_COMPAT_H
 
 #include <bpf/btf.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
 
 struct btf *__COMPAT_vmlinux_btf __attribute__((weak));
 
@@ -120,6 +123,28 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 #define __COMPAT_HAS_CPUMASKS							\
 	__COMPAT_has_ksym("scx_bpf_nr_cpu_ids")
 
+static inline long scx_hotplug_seq(void)
+{
+	int fd;
+	char buf[32];
+	ssize_t len;
+	long val;
+
+	fd = open("/sys/kernel/sched_ext/hotplug_seq", O_RDONLY);
+	if (fd < 0)
+		return -ENOENT;
+
+	len = read(fd, buf, sizeof(buf) - 1);
+	SCX_BUG_ON(len <= 0, "read failed (%ld)", len);
+	buf[len] = 0;
+	close(fd);
+
+	val = strtoul(buf, NULL, 10);
+	SCX_BUG_ON(val < 0, "invalid num hotplug events: %lu", val);
+
+	return val;
+}
+
 /*
  * struct sched_ext_ops can change over time. If compat.bpf.h::SCX_OPS_DEFINE()
  * is used to define ops and compat.h::SCX_OPS_LOAD/ATTACH() are used to load
@@ -128,12 +153,16 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
  *
  * - ops.tick(): Ignored on older kernels with a warning.
  * - ops.exit_dump_len: Cleared to zero on older kernels with a warning.
+ * - ops.hotplug_seq: Ignored on older kernels.
  */
 #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
 	struct __scx_name *__skel;						\
 										\
 	__skel = __scx_name##__open();						\
 	SCX_BUG_ON(!__skel, "Could not open " #__scx_name);			\
+										\
+	if (__COMPAT_struct_has_field("sched_ext_ops", "hotplug_seq"))		\
+		__skel->struct_ops.__ops_name->hotplug_seq = scx_hotplug_seq();	\
 	__skel; 								\
 })
 
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index cf4293cb250e..2d86d01a9575 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -77,7 +77,35 @@ struct user_exit_info {
 	if (__uei->msg[0] != '\0')						\
 		fprintf(stderr, " (%s)", __uei->msg);				\
 	fputs("\n", stderr);							\
+	__uei->exit_code;							\
 })
 
+/*
+ * We can't import vmlinux.h while compiling user C code. Let's duplicate
+ * scx_exit_code definition.
+ */
+enum scx_exit_code {
+	/* Reasons */
+	SCX_ECODE_RSN_HOTPLUG		= 1LLU << 32,
+
+	/* Actions */
+	SCX_ECODE_ACT_RESTART		= 1LLU << 48,
+};
+
+enum uei_ecode_mask {
+	UEI_ECODE_USER_MASK		= ((1LLU << 32) - 1),
+	UEI_ECODE_SYS_RSN_MASK		= ((1LLU << 16) - 1) << 32,
+	UEI_ECODE_SYS_ACT_MASK		= ((1LLU << 16) - 1) << 48,
+};
+
+/*
+ * These macro interpret the ecode returned from UEI_REPORT().
+ */
+#define UEI_ECODE_USER(__ecode)		((__ecode) & UEI_ECODE_USER_MASK)
+#define UEI_ECODE_SYS_RSN(__ecode)	((__ecode) & UEI_ECODE_SYS_RSN_MASK)
+#define UEI_ECODE_SYS_ACT(__ecode)	((__ecode) & UEI_ECODE_SYS_ACT_MASK)
+
+#define UEI_ECODE_RESTART(__ecode)	(UEI_ECODE_SYS_ACT((__ecode)) == SCX_ECODE_ACT_RESTART)
+
 #endif	/* __bpf__ */
 #endif	/* __USER_EXIT_INFO_H */
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 2908add16880..df692dc0ccb1 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -46,14 +46,14 @@ int main(int argc, char **argv)
 {
 	struct scx_central *skel;
 	struct bpf_link *link;
-	__u64 seq = 0;
+	__u64 seq = 0, ecode;
 	__s32 opt;
 	cpu_set_t *cpuset;
 
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
-
+restart:
 	skel = SCX_OPS_OPEN(central_ops, scx_central);
 
 	skel->rodata->central_cpu = 0;
@@ -126,7 +126,10 @@ int main(int argc, char **argv)
 	}
 
 	bpf_link__destroy(link);
-	UEI_REPORT(skel, uei);
+	ecode = UEI_REPORT(skel, uei);
 	scx_central__destroy(skel);
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_flatcg.c b/tools/sched_ext/scx_flatcg.c
index bb0a832a0cfd..20c5a132b610 100644
--- a/tools/sched_ext/scx_flatcg.c
+++ b/tools/sched_ext/scx_flatcg.c
@@ -127,11 +127,12 @@ int main(int argc, char **argv)
 	__u64 last_stats[FCG_NR_STATS] = {};
 	unsigned long seq = 0;
 	__s32 opt;
+	__u64 ecode;
 
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
-
+restart:
 	skel = SCX_OPS_OPEN(flatcg_ops, scx_flatcg);
 
 	skel->rodata->nr_cpus = libbpf_num_possible_cpus();
@@ -219,7 +220,10 @@ int main(int argc, char **argv)
 	}
 
 	bpf_link__destroy(link);
-	UEI_REPORT(skel, uei);
+	ecode = UEI_REPORT(skel, uei);
 	scx_flatcg__destroy(skel);
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
 	return 0;
 }
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 7c3b0dcae1e0..c2edc080d7e5 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -308,11 +308,69 @@ s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
 		return -ENOMEM;
 }
 
+/*
+ * Print out the online and possible CPU map using bpf_printk() as a
+ * demonstration of using the cpumask kfuncs and ops.cpu_on/offline().
+ */
+static void print_cpus(void)
+{
+	const struct cpumask *possible, *online;
+	s32 cpu;
+	char buf[128] = "", *p;
+	int idx;
+
+	if (!__COMPAT_HAS_CPUMASKS)
+		return;
+
+	possible = scx_bpf_get_possible_cpumask();
+	online = scx_bpf_get_online_cpumask();
+
+	idx = 0;
+	bpf_for(cpu, 0, scx_bpf_nr_cpu_ids()) {
+		if (!(p = MEMBER_VPTR(buf, [idx++])))
+			break;
+		if (bpf_cpumask_test_cpu(cpu, online))
+			*p++ = 'O';
+		else if (bpf_cpumask_test_cpu(cpu, possible))
+			*p++ = 'X';
+		else
+			*p++ = ' ';
+
+		if ((cpu & 7) == 7) {
+			if (!(p = MEMBER_VPTR(buf, [idx++])))
+				break;
+			*p++ = '|';
+		}
+	}
+	buf[sizeof(buf) - 1] = '\0';
+
+	scx_bpf_put_cpumask(online);
+	scx_bpf_put_cpumask(possible);
+
+	bpf_printk("CPUS: |%s", buf);
+}
+
+void BPF_STRUCT_OPS(qmap_cpu_online, s32 cpu)
+{
+	bpf_printk("CPU %d coming online", cpu);
+	/* @cpu is already online at this point */
+	print_cpus();
+}
+
+void BPF_STRUCT_OPS(qmap_cpu_offline, s32 cpu)
+{
+	bpf_printk("CPU %d going offline", cpu);
+	/* @cpu is still online at this point */
+	print_cpus();
+}
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
 	if (!switch_partial)
 		__COMPAT_scx_bpf_switch_all();
 
+	print_cpus();
+
 	return scx_bpf_create_dsq(SHARED_DSQ, -1);
 }
 
@@ -328,6 +386,8 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dispatch		= (void *)qmap_dispatch,
 	       .cpu_release		= (void *)qmap_cpu_release,
 	       .init_task		= (void *)qmap_init_task,
+	       .cpu_online		= (void *)qmap_cpu_online,
+	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
 	       .timeout_ms		= 5000U,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index 048b31eed17d..e82f58b5c131 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -119,5 +119,9 @@ int main(int argc, char **argv)
 	bpf_link__destroy(link);
 	UEI_REPORT(skel, uei);
 	scx_qmap__destroy(skel);
+	/*
+	 * scx_qmap implements ops.cpu_on/offline() and doesn't need to restart
+	 * on CPU hotplug events.
+	 */
 	return 0;
 }
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 9ffa8d084228..acee683a3ec9 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -62,11 +62,12 @@ int main(int argc, char **argv)
 	struct scx_simple *skel;
 	struct bpf_link *link;
 	__u32 opt;
+	__u64 ecode;
 
 	libbpf_set_print(libbpf_print_fn);
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
-
+restart:
 	skel = SCX_OPS_OPEN(simple_ops, scx_simple);
 
 	while ((opt = getopt(argc, argv, "vh")) != -1) {
@@ -93,7 +94,10 @@ int main(int argc, char **argv)
 	}
 
 	bpf_link__destroy(link);
-	UEI_REPORT(skel, uei);
+	ecode = UEI_REPORT(skel, uei);
 	scx_simple__destroy(skel);
+
+	if (UEI_ECODE_RESTART(ecode))
+		goto restart;
 	return 0;
 }
-- 
2.44.0


