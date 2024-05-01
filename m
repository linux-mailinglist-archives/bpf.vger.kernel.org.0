Return-Path: <bpf+bounces-28350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA368B8CA6
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0AB1F21587
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E740913442E;
	Wed,  1 May 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XivLhFjW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC913340D;
	Wed,  1 May 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714576441; cv=none; b=uyNLA6rLFJK88CjDauTSh3qdxu6wmCqjhYW8AV6IamOu9XSXYWcROYKWtKU1DBR5TH62E5/MntgM85IGyHFLA36bwBKkHDj+ja2cBTrFhXsaFoxWE1+TETnAlZR/0V2poGa5Mtup4Fol0Rh0V9NH4oDdCSqcmx/myWnZccHYSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714576441; c=relaxed/simple;
	bh=gIF2QrsMHM/B/UDcxk7sbrnEHtEOU99YBgh/AMxu8/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmgJ3TdNcKlcHpx0botLRjcus1YDdxT11i8L7o7RNJvJIKuU2EN3KcMMw8+7vMPz30CTxq+Q1dFXPYCc4zq0vn1xQ2zIbu44Ordvhf6yGCDcgaUKQijWHrpROAWErkHHPCBFhkI5+8ECTsIdpqsfSRZnkT5FIhb2liZ1OYJzevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XivLhFjW; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-613a6bb2947so2315325a12.3;
        Wed, 01 May 2024 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714576437; x=1715181237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OvIoU1oRLEpEy46qbogjdAzeNGp3CqtPIa9rK8TZug=;
        b=XivLhFjWeInfXC05XRNF3adW3O1NGfugWqWT7/d2w8RzNiQJeKf3Cd0lK1trOdNrHV
         FwPZeTR47l0Xp9OqPa8F6UTmJKwKQ6XTqhHx2Hss0SlGem6bEFUduOOI46iFBJFRdHqS
         kmUd7XAEHo7byLeujg1j0wl/02XJk8D5BBEfrujhdP9/jnz5LaejSym47RuC+ffF9Fmt
         FcTL6s+WSUcDhH3Wr9X6IL4KWTEp+5gIjdK6Zg7Eut2mje0XdnKYPiYhLZ4TLlbq/hiZ
         ir4hfBSax53Xl/TsuCp47sZcN6jrHQ1TFU8BGqR14MJ6qoZk67lM63sBoBXpiFlX0bbA
         WG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714576437; x=1715181237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1OvIoU1oRLEpEy46qbogjdAzeNGp3CqtPIa9rK8TZug=;
        b=scmK92QihBInZYwnWdzw03yYGSHGIOlvlQH3kqATCw1eaYB/mL/YNxIYYujpHlGYSN
         qE1Eb9kAe33mQ6rhAQ6UYvLc9qs5K1mZMNtSLb6ktFECHdpyBs/VZ5pnRaLwTGuxq7Ra
         CQq2u1ig8jRdkV/bUABLawQOKvNjgrEUhnFWOIXlUtNKqCh4Rvoclyc24eYVsUgcnVjt
         X128qPozVt2UcXMhH23kbGtwBTmMjswJ0u8i9ojVVpM2szuRi7m8FDvXM37XOA2lkIu1
         XEW8paT2CvbTaFWzs4QBOEx6j5WVJarAd1UFE+9neat1SU8xMVnH0g8qrlHH+jRgLBhE
         wt8w==
X-Forwarded-Encrypted: i=1; AJvYcCXG0MrRSUyoM3eK6RLWMqHw3NmTfonKVTWHVFcchiXDLe2Jli7WZjW51CV4uWFYc+xxjbnV0TumMD5LiIeE5Jypf88w
X-Gm-Message-State: AOJu0YxqY8elq+3xEQCo25jKyskDtMjAocH8ut7BV0RIG/2Px7Dm7XqK
	gtT+gfElXVM0OZOyg4KWgmRPr8dBfSD+Ua1WfEz5fy0llKcBUszP
X-Google-Smtp-Source: AGHT+IEihIMgtvCmRXAbzZiUukfbDjgNDRcPvD+8breDm9CHfzIQNSn1qriPEf8opbcMbTWDPqXbYw==
X-Received: by 2002:a17:90a:d191:b0:2a6:ff2e:dce0 with SMTP id fu17-20020a17090ad19100b002a6ff2edce0mr2783485pjb.5.1714576437139;
        Wed, 01 May 2024 08:13:57 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 100-20020a17090a09ed00b002a2f6da006csm1575238pjo.52.2024.05.01.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 08:13:56 -0700 (PDT)
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
Subject: [PATCH 20/39] sched_ext: Print debug dump after an error exit
Date: Wed,  1 May 2024 05:09:55 -1000
Message-ID: <20240501151312.635565-21-tj@kernel.org>
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

If a BPF scheduler triggers an error, the scheduler is aborted and the
system is reverted to the built-in scheduler. In the process, a lot of
information which may be useful for figuring out what happened can be lost.

This patch adds debug dump which captures information which may be useful
for debugging including runqueue and runnable thread states at the time of
failure. The following shows a debug dump after triggering the watchdog:

  # os/work/tools/sched_ext/build/bin/scx_qmap -t 100
  enq=0, dsp=0, delta=0, deq=0
  enq=21, dsp=21, delta=0, deq=0
  enq=96, dsp=96, delta=0, deq=1

  DEBUG DUMP
  ================================================================================

  kworker/u16:0[11] triggered exit kind 1026:
    runnable task stall (scx_qmap[1524] failed to run for 5.659s)

  Backtrace:
    scx_watchdog_workfn+0x138/0x1c0
    process_scheduled_works+0x245/0x4e0
    worker_thread+0x270/0x360
    kthread+0xeb/0x110
    ret_from_fork+0x36/0x40
    ret_from_fork_asm+0x11/0x20

  Runqueue states
  ---------------

  CPU 2   : nr_run=1 ops_qseq=34
	    curr=kworker/u16:0[11] class=ext_sched_class

   *R kworker/u16:0[11] +0ms
	scx_state/flags=3/0xd ops_state/qseq=0/0
	sticky/holding_cpu=-1/-1 dsq_id=(n/a)
	cpus=ff

      scx_ops_error_irq_workfn+0x25d/0x340
      irq_work_run_list+0x7d/0xc0
      irq_work_run+0x18/0x30
      __sysvec_irq_work+0x38/0x100
      sysvec_irq_work+0x69/0x80
      asm_sysvec_irq_work+0x1b/0x20
      scx_watchdog_workfn+0x15d/0x1c0
      process_scheduled_works+0x245/0x4e0
      worker_thread+0x270/0x360
      kthread+0xeb/0x110
      ret_from_fork+0x36/0x40
      ret_from_fork_asm+0x11/0x20

  CPU 7   : nr_run=1 ops_qseq=11
	    curr=swapper/7[0] class=idle_sched_class

    R scx_qmap[1524] -5659ms
	scx_state/flags=3/0x9 ops_state/qseq=2/3
	sticky/holding_cpu=-1/-1 dsq_id=(n/a)
	cpus=ff

      common_nsleep+0x34/0x50
      __x64_sys_clock_nanosleep+0xd9/0x120
      do_syscall_64+0x7e/0x150
      entry_SYSCALL_64_after_hwframe+0x46/0x4e

  ================================================================================

  EXIT: runnable task stall (scx_qmap[1524] failed to run for 5.659s)

It shows that CPU 2 was running the watchdog when it triggered the error
condition and the scx_qmap thread has been queued on CPU 7 for over 5
seconds but failed to run. This dump has proved pretty useful for developing
and debugging BPF schedulers.

Currently, it uses fixed 32k buffer and doesn't provide any way for the BPF
scheduler to add additional information. These will be improved in the
future.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/ext.c                           | 122 ++++++++++++++++++-
 tools/sched_ext/include/scx/compat.h         |  11 +-
 tools/sched_ext/include/scx/user_exit_info.h |  19 +++
 tools/sched_ext/scx_qmap.c                   |  10 +-
 tools/sched_ext/scx_simple.c                 |   2 +-
 5 files changed, 155 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ff080b5f0330..4ffa42e5d7dd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -12,6 +12,7 @@ enum scx_consts {
 
 	SCX_EXIT_BT_LEN			= 64,
 	SCX_EXIT_MSG_LEN		= 1024,
+	SCX_EXIT_DUMP_DFL_LEN		= 32768,
 };
 
 enum scx_exit_kind {
@@ -48,6 +49,9 @@ struct scx_exit_info {
 
 	/* informational message */
 	char			*msg;
+
+	/* debug dump */
+	char			*dump;
 };
 
 /* sched_ext_ops.flags */
@@ -330,6 +334,12 @@ struct sched_ext_ops {
 	 */
 	u32 timeout_ms;
 
+	/**
+	 * exit_dump_len - scx_exit_info.dump buffer length. If 0, the default
+	 * value of 32768 is used.
+	 */
+	u32 exit_dump_len;
+
 	/**
 	 * name - BPF scheduler's name
 	 *
@@ -2888,12 +2898,13 @@ static void scx_ops_bypass(bool bypass)
 
 static void free_exit_info(struct scx_exit_info *ei)
 {
+	kfree(ei->dump);
 	kfree(ei->msg);
 	kfree(ei->bt);
 	kfree(ei);
 }
 
-static struct scx_exit_info *alloc_exit_info(void)
+static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
 {
 	struct scx_exit_info *ei;
 
@@ -2903,8 +2914,9 @@ static struct scx_exit_info *alloc_exit_info(void)
 
 	ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
 	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
+	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
 
-	if (!ei->bt || !ei->msg) {
+	if (!ei->bt || !ei->msg || !ei->dump) {
 		free_exit_info(ei);
 		return NULL;
 	}
@@ -3104,8 +3116,101 @@ static void scx_ops_disable(enum scx_exit_kind kind)
 	schedule_scx_ops_disable_work();
 }
 
+static void scx_dump_task(struct seq_buf *s, struct task_struct *p, char marker,
+			  unsigned long now)
+{
+	static unsigned long bt[SCX_EXIT_BT_LEN];
+	char dsq_id_buf[19] = "(n/a)";
+	unsigned long ops_state = atomic_long_read(&p->scx.ops_state);
+	unsigned int bt_len;
+	size_t avail, used;
+	char *buf;
+
+	if (p->scx.dsq)
+		scnprintf(dsq_id_buf, sizeof(dsq_id_buf), "0x%llx",
+			  (unsigned long long)p->scx.dsq->id);
+
+	seq_buf_printf(s, "\n %c%c %s[%d] %+ldms\n",
+		       marker, task_state_to_char(p), p->comm, p->pid,
+		       jiffies_delta_msecs(p->scx.runnable_at, now));
+	seq_buf_printf(s, "      scx_state/flags=%u/0x%x ops_state/qseq=%lu/%lu\n",
+		       scx_get_task_state(p),
+		       p->scx.flags & ~SCX_TASK_STATE_MASK,
+		       ops_state & SCX_OPSS_STATE_MASK,
+		       ops_state >> SCX_OPSS_QSEQ_SHIFT);
+	seq_buf_printf(s, "      sticky/holding_cpu=%d/%d dsq_id=%s\n",
+		       p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
+	seq_buf_printf(s, "      cpus=%*pb\n\n", cpumask_pr_args(p->cpus_ptr));
+
+	bt_len = stack_trace_save_tsk(p, bt, SCX_EXIT_BT_LEN, 1);
+
+	avail = seq_buf_get_buf(s, &buf);
+	used = stack_trace_snprint(buf, avail, bt, bt_len, 3);
+	seq_buf_commit(s, used < avail ? used : -1);
+}
+
+static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
+{
+	const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
+	unsigned long now = jiffies;
+	struct seq_buf s;
+	size_t avail, used;
+	char *buf;
+	int cpu;
+
+	if (dump_len <= sizeof(trunc_marker))
+		return;
+
+	seq_buf_init(&s, ei->dump, dump_len - sizeof(trunc_marker));
+
+	seq_buf_printf(&s, "%s[%d] triggered exit kind %d:\n  %s (%s)\n\n",
+		       current->comm, current->pid, ei->kind, ei->reason, ei->msg);
+	seq_buf_printf(&s, "Backtrace:\n");
+	avail = seq_buf_get_buf(&s, &buf);
+	used = stack_trace_snprint(buf, avail, ei->bt, ei->bt_len, 1);
+	seq_buf_commit(&s, used < avail ? used : -1);
+
+	seq_buf_printf(&s, "\nRunqueue states\n");
+	seq_buf_printf(&s, "---------------\n");
+
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+		struct task_struct *p;
+
+		rq_lock(rq, &rf);
+
+		if (list_empty(&rq->scx.runnable_list) &&
+		    rq->curr->sched_class == &idle_sched_class)
+			goto next;
+
+		seq_buf_printf(&s, "\nCPU %-4d: nr_run=%u ops_qseq=%lu\n",
+			       cpu, rq->scx.nr_running, rq->scx.ops_qseq);
+		seq_buf_printf(&s, "          curr=%s[%d] class=%ps\n",
+			       rq->curr->comm, rq->curr->pid,
+			       rq->curr->sched_class);
+
+		if (rq->curr->sched_class == &ext_sched_class)
+			scx_dump_task(&s, rq->curr, '*', now);
+
+		list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
+			scx_dump_task(&s, p, ' ', now);
+	next:
+		rq_unlock(rq, &rf);
+	}
+
+	if (seq_buf_has_overflowed(&s))
+		memcpy(ei->dump + seq_buf_used(&s) - 1, trunc_marker,
+		       sizeof(trunc_marker));
+}
+
 static void scx_ops_error_irq_workfn(struct irq_work *irq_work)
 {
+	struct scx_exit_info *ei = scx_exit_info;
+
+	if (ei->kind >= SCX_EXIT_ERROR)
+		scx_dump_state(ei, scx_ops.exit_dump_len);
+
 	schedule_scx_ops_disable_work();
 }
 
@@ -3131,6 +3236,13 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 	vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
 	va_end(args);
 
+	/*
+	 * Set ei->kind and ->reason for scx_dump_state(). They'll be set again
+	 * in scx_ops_disable_workfn().
+	 */
+	ei->kind = kind;
+	ei->reason = scx_exit_reason(ei->kind);
+
 	irq_work_queue(&scx_ops_error_irq_work);
 }
 
@@ -3192,7 +3304,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 	if (ret < 0)
 		goto err;
 
-	scx_exit_info = alloc_exit_info();
+	scx_exit_info = alloc_exit_info(ops->exit_dump_len);
 	if (!scx_exit_info) {
 		ret = -ENOMEM;
 		goto err_del;
@@ -3572,6 +3684,10 @@ static int bpf_scx_init_member(const struct btf_type *t,
 			return -E2BIG;
 		ops->timeout_ms = *(u32 *)(udata + moff);
 		return 1;
+	case offsetof(struct sched_ext_ops, exit_dump_len):
+		ops->exit_dump_len =
+			*(u32 *)(udata + moff) ?: SCX_EXIT_DUMP_DFL_LEN;
+		return 1;
 	}
 
 	return 0;
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 2a66f3eb87a9..2be79bd88a25 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -126,7 +126,8 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
  * and attach it, backward compatibility is automatically maintained where
  * reasonable.
  *
- * - sched_ext_ops.tick(): Ignored on older kernels with a warning.
+ * - ops.tick(): Ignored on older kernels with a warning.
+ * - ops.exit_dump_len: Cleared to zero on older kernels with a warning.
  */
 #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
 	struct __scx_name *__skel;						\
@@ -136,7 +137,13 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
 	__skel; 								\
 })
 
-#define SCX_OPS_LOAD(__skel, __ops_name, __scx_name) ({				\
+#define SCX_OPS_LOAD(__skel, __ops_name, __scx_name, __uei_name) ({		\
+	UEI_SET_SIZE(__skel, __ops_name, __uei_name);				\
+	if (!__COMPAT_struct_has_field("sched_ext_ops", "exit_dump_len") &&	\
+	    (__skel)->struct_ops.__ops_name->exit_dump_len) {			\
+		fprintf(stderr, "WARNING: kernel doesn't support setting exit dump len\n"); \
+		(__skel)->struct_ops.__ops_name->exit_dump_len = 0;		\
+	}									\
 	if (!__COMPAT_struct_has_field("sched_ext_ops", "tick") &&		\
 	    (__skel)->struct_ops.__ops_name->tick) {				\
 		fprintf(stderr, "WARNING: kernel doesn't support ops.tick()\n"); \
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 8c3b7fac4d05..cf4293cb250e 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -13,6 +13,7 @@
 enum uei_sizes {
 	UEI_REASON_LEN		= 128,
 	UEI_MSG_LEN		= 1024,
+	UEI_DUMP_DFL_LEN	= 32768,
 };
 
 struct user_exit_info {
@@ -28,6 +29,8 @@ struct user_exit_info {
 #include <bpf/bpf_core_read.h>
 
 #define UEI_DEFINE(__name)							\
+	char RESIZABLE_ARRAY(data, __name##_dump);				\
+	const volatile u32 __name##_dump_len;					\
 	struct user_exit_info __name SEC(".data")
 
 #define UEI_RECORD(__uei_name, __ei) ({						\
@@ -35,6 +38,8 @@ struct user_exit_info {
 				  sizeof(__uei_name.reason), (__ei)->reason);	\
 	bpf_probe_read_kernel_str(__uei_name.msg,				\
 				  sizeof(__uei_name.msg), (__ei)->msg);		\
+	bpf_probe_read_kernel_str(__uei_name##_dump,				\
+				  __uei_name##_dump_len, (__ei)->dump);		\
 	if (bpf_core_field_exists((__ei)->exit_code))				\
 		__uei_name.exit_code = (__ei)->exit_code;			\
 	/* use __sync to force memory barrier */				\
@@ -47,6 +52,13 @@ struct user_exit_info {
 #include <stdio.h>
 #include <stdbool.h>
 
+/* no need to call the following explicitly if SCX_OPS_LOAD() is used */
+#define UEI_SET_SIZE(__skel, __ops_name, __uei_name) ({				\
+	u32 __len = (__skel)->struct_ops.__ops_name->exit_dump_len ?: UEI_DUMP_DFL_LEN; \
+	(__skel)->rodata->__uei_name##_dump_len = __len;			\
+	RESIZE_ARRAY(data, __uei_name##_dump, __len);				\
+})
+
 #define UEI_EXITED(__skel, __uei_name) ({					\
 	/* use __sync to force memory barrier */				\
 	__sync_val_compare_and_swap(&(__skel)->data->__uei_name.kind, -1, -1);	\
@@ -54,6 +66,13 @@ struct user_exit_info {
 
 #define UEI_REPORT(__skel, __uei_name) ({					\
 	struct user_exit_info *__uei = &(__skel)->data->__uei_name;		\
+	char *__uei_dump = (__skel)->data_##__uei_name##_dump->__uei_name##_dump; \
+	if (__uei_dump[0] != '\0') {						\
+		fputs("\nDEBUG DUMP\n", stderr);				\
+		fputs("================================================================================\n\n", stderr); \
+		fputs(__uei_dump, stderr);					\
+		fputs("\n================================================================================\n\n", stderr); \
+	}									\
 	fprintf(stderr, "EXIT: %s", __uei->reason);				\
 	if (__uei->msg[0] != '\0')						\
 		fprintf(stderr, " (%s)", __uei->msg);				\
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index d2b98ef3ead2..28fd5aa4e62c 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -20,7 +20,7 @@ const char help_fmt[] =
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
 "Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT] [-b COUNT]\n"
-"       [-d PID] [-p] [-v]\n"
+"       [-d PID] [-D LEN] [-p] [-v]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
@@ -28,6 +28,7 @@ const char help_fmt[] =
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
+"  -D LEN        Set scx_exit_info.dump buffer length\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
@@ -59,7 +60,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:b:d:pvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:b:d:D:pvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -81,6 +82,9 @@ int main(int argc, char **argv)
 			if (skel->rodata->disallow_tgid < 0)
 				skel->rodata->disallow_tgid = getpid();
 			break;
+		case 'D':
+			skel->struct_ops.qmap_ops->exit_dump_len = strtoul(optarg, NULL, 0);
+			break;
 		case 'p':
 			skel->rodata->switch_partial = true;
 			skel->struct_ops.qmap_ops->flags |= __COMPAT_SCX_OPS_SWITCH_PARTIAL;
@@ -94,7 +98,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	SCX_OPS_LOAD(skel, qmap_ops, scx_qmap);
+	SCX_OPS_LOAD(skel, qmap_ops, scx_qmap, uei);
 	link = SCX_OPS_ATTACH(skel, qmap_ops);
 
 	while (!exit_req && !UEI_EXITED(skel, uei)) {
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 08c741f56685..9ffa8d084228 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -80,7 +80,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	SCX_OPS_LOAD(skel, simple_ops, scx_simple);
+	SCX_OPS_LOAD(skel, simple_ops, scx_simple, uei);
 	link = SCX_OPS_ATTACH(skel, simple_ops);
 
 	while (!exit_req && !UEI_EXITED(skel, uei)) {
-- 
2.44.0


