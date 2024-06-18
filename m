Return-Path: <bpf+bounces-32449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F0790DE37
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98241F22680
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975C3194C74;
	Tue, 18 Jun 2024 21:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9KeD70O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92418EFFB;
	Tue, 18 Jun 2024 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745697; cv=none; b=COk+QCu80MqXvBwTZtXnVXEoZjsv53FMb2L1KoaFTTUlRaL7gPXnuVcJo0NyCa4cKnb37UsMFTas+/FhKjIr12QmXJW2fykY1wOI4fqIaMZzaJL8cUuhcD7zdoL/6qXcbEy9RJfrkCw6rEU4vlZCXTxRmMsWkWhmwUueMa7tEbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745697; c=relaxed/simple;
	bh=Vfim59NVHPdaQP/5zt3zV8CAs1WEMX73Q7IhyvVBCVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsG8swaWnhzkfvlLIVA8P34M+vP08t4jU7yxxc6Bq+iaPk+6XlqrU9QkPO4QHHwyJtImp/OOzvU2KkcrnAaPPU0XdRFNOYqhIG68JzsMKxoP7JjPjbTXtlSSSNhkjUcnFbOIjKLupNbcL45xPNl/P2cBqD0H7GS3fpDz7hjk5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9KeD70O; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-705c739b878so214591b3a.1;
        Tue, 18 Jun 2024 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745694; x=1719350494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF0ndI2Ge31OTEhpu1QiQRGr4C1nWwfnpnhF0gWnabM=;
        b=Y9KeD70O+JDi7ZAl16x4grwtjJmzKoiwRqTADB77OkEA//pV04ifomKqrEZ05Vc4XG
         UgD/x1KLL9TuQ/rYOkAAAOIAwQaSkTkW8GH/6JVn1XLSL7osCDqxu8wyCxdKemP6oqRy
         nFRRo1GHDBYYAM3KBcYnkRzNEksrCQhjs9j8oxmsM7skfEUAl3Pgm64WZoQ4YnsXvoIA
         mIEwNrd+NJRnAmykTyN8lVObI4Wd97GDRfl+BHeL6i8fSmJpy/WCGxrJJHvpf4yjWjHH
         9QoKWi+wPmLLn95CFioo0D21wSh5iPJVUB+rxm9TCodb7AJQjs4AdGdZlX0dp3bcGJww
         S6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745694; x=1719350494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EF0ndI2Ge31OTEhpu1QiQRGr4C1nWwfnpnhF0gWnabM=;
        b=Wh/HCUD9p6h453bgVHGkb2lURMXhVJRhR+QZ3KxhJQl/ojFVldmZaGEDqPqHBTaOBF
         iPIEOgbSYMcD6z2AP3/nB3ZCYWI4QRtdoXcg99owusKxCfAecz1Ycmc2n1Sgu038Q5uG
         /NABbyPvdow2W6av58cAzPqKKueM1N2lKnVD0GA2arnU1bo4Icg3sKJ+gtok34I1t0sm
         BdGiLLz+lK66DV9iZVJBEtNG660Q9nSY+NOre4CnOtMIC7Ea6/jwQA8lpzf5YR6dlv7/
         hppUCKG5xQjzNIHixdMvfXF3UlnLRAdNC8KaUXbRohl+IBgrjo8bCjjQ5B7dm+cQDLfH
         dciw==
X-Forwarded-Encrypted: i=1; AJvYcCUgxvVrLSJ/f7yo35EboygkrFf9lGKvRCkOhCpJeeo/0lg5Bo5zSqa1RqTLhG0XOm7X1HqlaaZDOTp0vNLTWaj6zTnB
X-Gm-Message-State: AOJu0YyWEfkjJRuJPPzg12OHQlgQLB5y2QVuRknSk2zMSobJWeE5RChF
	yUIOEw5mlvU3Vhp+8Hq9gqTOUJVFLqoURqpA+jJ3V5M0SF5tTaMlAYNngw==
X-Google-Smtp-Source: AGHT+IE98DKgoBXVJyKNeaJdPluO/vMTlrH84b+5mPs9DWP3+kvy/lS/MNqcdHgIZMssxOSNz0p4Gw==
X-Received: by 2002:a05:6a20:12cf:b0:1b4:a478:2275 with SMTP id adf61e73a8af0-1bcba236e54mr1655998637.29.1718745693318;
        Tue, 18 Jun 2024 14:21:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc967334sm9397593b3a.57.2024.06.18.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:33 -0700 (PDT)
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
Subject: [PATCH 15/30] sched_ext: Print debug dump after an error exit
Date: Tue, 18 Jun 2024 11:17:30 -1000
Message-ID: <20240618212056.2833381-16-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618212056.2833381-1-tj@kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
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

  root@test ~# os/work/tools/sched_ext/build/bin/scx_qmap -t 100
  stats  : enq=1 dsp=0 delta=1 deq=0
  stats  : enq=90 dsp=90 delta=0 deq=0
  stats  : enq=156 dsp=156 delta=0 deq=0
  stats  : enq=218 dsp=218 delta=0 deq=0
  stats  : enq=255 dsp=255 delta=0 deq=0
  stats  : enq=271 dsp=271 delta=0 deq=0
  stats  : enq=284 dsp=284 delta=0 deq=0
  stats  : enq=293 dsp=293 delta=0 deq=0

  DEBUG DUMP
  ================================================================================

  kworker/u32:12[320] triggered exit kind 1026:
    runnable task stall (stress[1530] failed to run for 6.841s)

  Backtrace:
    scx_watchdog_workfn+0x136/0x1c0
    process_scheduled_works+0x2b5/0x600
    worker_thread+0x269/0x360
    kthread+0xeb/0x110
    ret_from_fork+0x36/0x40
    ret_from_fork_asm+0x1a/0x30

  QMAP FIFO[0]:
  QMAP FIFO[1]:
  QMAP FIFO[2]: 1436
  QMAP FIFO[3]:
  QMAP FIFO[4]:

  CPU states
  ----------

  CPU 0   : nr_run=1 ops_qseq=244
	    curr=swapper/0[0] class=idle_sched_class

    QMAP: dsp_idx=1 dsp_cnt=0

    R stress[1530] -6841ms
	scx_state/flags=3/0x1 ops_state/qseq=2/20
	sticky/holding_cpu=-1/-1 dsq_id=(n/a)
	cpus=ff

      QMAP: force_local=0

      asm_sysvec_apic_timer_interrupt+0x16/0x20

  CPU 2   : nr_run=2 ops_qseq=142
	    curr=swapper/2[0] class=idle_sched_class

    QMAP: dsp_idx=1 dsp_cnt=0

    R sshd[1703] -5905ms
	scx_state/flags=3/0x9 ops_state/qseq=2/88
	sticky/holding_cpu=-1/-1 dsq_id=(n/a)
	cpus=ff

      QMAP: force_local=1

      __x64_sys_ppoll+0xf6/0x120
      do_syscall_64+0x7b/0x150
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

    R fish[1539] -4141ms
	scx_state/flags=3/0x9 ops_state/qseq=2/124
	sticky/holding_cpu=-1/-1 dsq_id=(n/a)
	cpus=ff

      QMAP: force_local=1

      futex_wait+0x60/0xe0
      do_futex+0x109/0x180
      __x64_sys_futex+0x117/0x190
      do_syscall_64+0x7b/0x150
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

  CPU 3   : nr_run=2 ops_qseq=162
	    curr=kworker/u32:12[320] class=ext_sched_class

    QMAP: dsp_idx=1 dsp_cnt=0

   *R kworker/u32:12[320] +0ms
	scx_state/flags=3/0xd ops_state/qseq=0/0
	sticky/holding_cpu=-1/-1 dsq_id=(n/a)
	cpus=ff

      QMAP: force_local=0

      scx_dump_state+0x613/0x6f0
      scx_ops_error_irq_workfn+0x1f/0x40
      irq_work_run_list+0x82/0xd0
      irq_work_run+0x14/0x30
      __sysvec_irq_work+0x40/0x140
      sysvec_irq_work+0x60/0x70
      asm_sysvec_irq_work+0x16/0x20
      scx_watchdog_workfn+0x15f/0x1c0
      process_scheduled_works+0x2b5/0x600
      worker_thread+0x269/0x360
      kthread+0xeb/0x110
      ret_from_fork+0x36/0x40
      ret_from_fork_asm+0x1a/0x30

    R kworker/3:2[1436] +0ms
	scx_state/flags=3/0x9 ops_state/qseq=2/160
	sticky/holding_cpu=-1/-1 dsq_id=(n/a)
	cpus=08

      QMAP: force_local=0

      kthread+0xeb/0x110
      ret_from_fork+0x36/0x40
      ret_from_fork_asm+0x1a/0x30

  CPU 7   : nr_run=0 ops_qseq=76
	    curr=swapper/7[0] class=idle_sched_class


  ================================================================================

  EXIT: runnable task stall (stress[1530] failed to run for 6.841s)

It shows that CPU 3 was running the watchdog when it triggered the error
condition and the scx_qmap thread has been queued on CPU 0 for over 5
seconds but failed to run. It also prints out scx_qmap specific information
- e.g. which tasks are queued on each FIFO and so on using the dump_*() ops.
This dump has proved pretty useful for developing and debugging BPF
schedulers.

Debug dump is generated automatically when the BPF scheduler exits due to an
error. The debug buffer used in such cases is determined by
sched_ext_ops.exit_dump_len and defaults to 32k. If the debug dump overruns
the available buffer, the output is truncated and marked accordingly.

Debug dump output can also be read through the sched_ext_dump tracepoint.
When read through the tracepoint, there is no length limit.

SysRq-D can be used to trigger debug dump at any time while a BPF scheduler
is loaded. This is non-destructive - the scheduler keeps running afterwards.
The output can be read through the sched_ext_dump tracepoint.

v2: - The size of exit debug dump buffer can now be customized using
      sched_ext_ops.exit_dump_len.

    - sched_ext_ops.dump*() added to enable dumping of BPF scheduler
      specific information.

    - Tracpoint output and SysRq-D triggering added.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 include/trace/events/sched_ext.h             |  32 ++
 kernel/sched/ext.c                           | 421 ++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h     |  12 +
 tools/sched_ext/include/scx/compat.h         |   9 +-
 tools/sched_ext/include/scx/user_exit_info.h |  19 +
 tools/sched_ext/scx_qmap.bpf.c               |  54 +++
 tools/sched_ext/scx_qmap.c                   |  14 +-
 tools/sched_ext/scx_simple.c                 |   2 +-
 8 files changed, 555 insertions(+), 8 deletions(-)
 create mode 100644 include/trace/events/sched_ext.h

diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
new file mode 100644
index 000000000000..fe19da7315a9
--- /dev/null
+++ b/include/trace/events/sched_ext.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM sched_ext
+
+#if !defined(_TRACE_SCHED_EXT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SCHED_EXT_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(sched_ext_dump,
+
+	TP_PROTO(const char *line),
+
+	TP_ARGS(line),
+
+	TP_STRUCT__entry(
+		__string(line, line)
+	),
+
+	TP_fast_assign(
+		__assign_str(line);
+	),
+
+	TP_printk("%s",
+		__get_str(line)
+	)
+);
+
+#endif /* _TRACE_SCHED_EXT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6f4de29d7372..66bb9cf075f0 100644
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
@@ -105,6 +109,17 @@ struct scx_exit_task_args {
 	bool cancelled;
 };
 
+/*
+ * Informational context provided to dump operations.
+ */
+struct scx_dump_ctx {
+	enum scx_exit_kind	kind;
+	s64			exit_code;
+	const char		*reason;
+	u64			at_ns;
+	u64			at_jiffies;
+};
+
 /**
  * struct sched_ext_ops - Operation table for BPF scheduler implementation
  *
@@ -296,6 +311,36 @@ struct sched_ext_ops {
 	 */
 	void (*disable)(struct task_struct *p);
 
+	/**
+	 * dump - Dump BPF scheduler state on error
+	 * @ctx: debug dump context
+	 *
+	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump.
+	 */
+	void (*dump)(struct scx_dump_ctx *ctx);
+
+	/**
+	 * dump_cpu - Dump BPF scheduler state for a CPU on error
+	 * @ctx: debug dump context
+	 * @cpu: CPU to generate debug dump for
+	 * @idle: @cpu is currently idle without any runnable tasks
+	 *
+	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump for
+	 * @cpu. If @idle is %true and this operation doesn't produce any
+	 * output, @cpu is skipped for dump.
+	 */
+	void (*dump_cpu)(struct scx_dump_ctx *ctx, s32 cpu, bool idle);
+
+	/**
+	 * dump_task - Dump BPF scheduler state for a runnable task on error
+	 * @ctx: debug dump context
+	 * @p: runnable task to generate debug dump for
+	 *
+	 * Use scx_bpf_dump() to generate BPF scheduler specific debug dump for
+	 * @p.
+	 */
+	void (*dump_task)(struct scx_dump_ctx *ctx, struct task_struct *p);
+
 	/*
 	 * All online ops must come before ops.init().
 	 */
@@ -330,6 +375,12 @@ struct sched_ext_ops {
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
@@ -567,10 +618,27 @@ struct scx_bstr_buf {
 static DEFINE_RAW_SPINLOCK(scx_exit_bstr_buf_lock);
 static struct scx_bstr_buf scx_exit_bstr_buf;
 
+/* ops debug dump */
+struct scx_dump_data {
+	s32			cpu;
+	bool			first;
+	s32			cursor;
+	struct seq_buf		*s;
+	const char		*prefix;
+	struct scx_bstr_buf	buf;
+};
+
+struct scx_dump_data scx_dump_data = {
+	.cpu			= -1,
+};
+
 /* /sys/kernel/sched_ext interface */
 static struct kset *scx_kset;
 static struct kobject *scx_root_kobj;
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/sched_ext.h>
+
 static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
 					     s64 exit_code,
 					     const char *fmt, ...);
@@ -2897,12 +2965,13 @@ static void scx_ops_bypass(bool bypass)
 
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
 
@@ -2912,8 +2981,9 @@ static struct scx_exit_info *alloc_exit_info(void)
 
 	ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
 	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
+	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
 
-	if (!ei->bt || !ei->msg) {
+	if (!ei->bt || !ei->msg || !ei->dump) {
 		free_exit_info(ei);
 		return NULL;
 	}
@@ -3125,8 +3195,274 @@ static void scx_ops_disable(enum scx_exit_kind kind)
 	schedule_scx_ops_disable_work();
 }
 
+static void dump_newline(struct seq_buf *s)
+{
+	trace_sched_ext_dump("");
+
+	/* @s may be zero sized and seq_buf triggers WARN if so */
+	if (s->size)
+		seq_buf_putc(s, '\n');
+}
+
+static __printf(2, 3) void dump_line(struct seq_buf *s, const char *fmt, ...)
+{
+	va_list args;
+
+#ifdef CONFIG_TRACEPOINTS
+	if (trace_sched_ext_dump_enabled()) {
+		/* protected by scx_dump_state()::dump_lock */
+		static char line_buf[SCX_EXIT_MSG_LEN];
+
+		va_start(args, fmt);
+		vscnprintf(line_buf, sizeof(line_buf), fmt, args);
+		va_end(args);
+
+		trace_sched_ext_dump(line_buf);
+	}
+#endif
+	/* @s may be zero sized and seq_buf triggers WARN if so */
+	if (s->size) {
+		va_start(args, fmt);
+		seq_buf_vprintf(s, fmt, args);
+		va_end(args);
+
+		seq_buf_putc(s, '\n');
+	}
+}
+
+static void dump_stack_trace(struct seq_buf *s, const char *prefix,
+			     const unsigned long *bt, unsigned int len)
+{
+	unsigned int i;
+
+	for (i = 0; i < len; i++)
+		dump_line(s, "%s%pS", prefix, (void *)bt[i]);
+}
+
+static void ops_dump_init(struct seq_buf *s, const char *prefix)
+{
+	struct scx_dump_data *dd = &scx_dump_data;
+
+	lockdep_assert_irqs_disabled();
+
+	dd->cpu = smp_processor_id();		/* allow scx_bpf_dump() */
+	dd->first = true;
+	dd->cursor = 0;
+	dd->s = s;
+	dd->prefix = prefix;
+}
+
+static void ops_dump_flush(void)
+{
+	struct scx_dump_data *dd = &scx_dump_data;
+	char *line = dd->buf.line;
+
+	if (!dd->cursor)
+		return;
+
+	/*
+	 * There's something to flush and this is the first line. Insert a blank
+	 * line to distinguish ops dump.
+	 */
+	if (dd->first) {
+		dump_newline(dd->s);
+		dd->first = false;
+	}
+
+	/*
+	 * There may be multiple lines in $line. Scan and emit each line
+	 * separately.
+	 */
+	while (true) {
+		char *end = line;
+		char c;
+
+		while (*end != '\n' && *end != '\0')
+			end++;
+
+		/*
+		 * If $line overflowed, it may not have newline at the end.
+		 * Always emit with a newline.
+		 */
+		c = *end;
+		*end = '\0';
+		dump_line(dd->s, "%s%s", dd->prefix, line);
+		if (c == '\0')
+			break;
+
+		/* move to the next line */
+		end++;
+		if (*end == '\0')
+			break;
+		line = end;
+	}
+
+	dd->cursor = 0;
+}
+
+static void ops_dump_exit(void)
+{
+	ops_dump_flush();
+	scx_dump_data.cpu = -1;
+}
+
+static void scx_dump_task(struct seq_buf *s, struct scx_dump_ctx *dctx,
+			  struct task_struct *p, char marker)
+{
+	static unsigned long bt[SCX_EXIT_BT_LEN];
+	char dsq_id_buf[19] = "(n/a)";
+	unsigned long ops_state = atomic_long_read(&p->scx.ops_state);
+	unsigned int bt_len;
+
+	if (p->scx.dsq)
+		scnprintf(dsq_id_buf, sizeof(dsq_id_buf), "0x%llx",
+			  (unsigned long long)p->scx.dsq->id);
+
+	dump_newline(s);
+	dump_line(s, " %c%c %s[%d] %+ldms",
+		  marker, task_state_to_char(p), p->comm, p->pid,
+		  jiffies_delta_msecs(p->scx.runnable_at, dctx->at_jiffies));
+	dump_line(s, "      scx_state/flags=%u/0x%x ops_state/qseq=%lu/%lu",
+		  scx_get_task_state(p), p->scx.flags & ~SCX_TASK_STATE_MASK,
+		  ops_state & SCX_OPSS_STATE_MASK,
+		  ops_state >> SCX_OPSS_QSEQ_SHIFT);
+	dump_line(s, "      sticky/holding_cpu=%d/%d dsq_id=%s",
+		  p->scx.sticky_cpu, p->scx.holding_cpu, dsq_id_buf);
+	dump_line(s, "      cpus=%*pb", cpumask_pr_args(p->cpus_ptr));
+
+	if (SCX_HAS_OP(dump_task)) {
+		ops_dump_init(s, "    ");
+		SCX_CALL_OP(SCX_KF_REST, dump_task, dctx, p);
+		ops_dump_exit();
+	}
+
+	bt_len = stack_trace_save_tsk(p, bt, SCX_EXIT_BT_LEN, 1);
+	if (bt_len) {
+		dump_newline(s);
+		dump_stack_trace(s, "    ", bt, bt_len);
+	}
+}
+
+static void scx_dump_state(struct scx_exit_info *ei, size_t dump_len)
+{
+	static DEFINE_SPINLOCK(dump_lock);
+	static const char trunc_marker[] = "\n\n~~~~ TRUNCATED ~~~~\n";
+	struct scx_dump_ctx dctx = {
+		.kind = ei->kind,
+		.exit_code = ei->exit_code,
+		.reason = ei->reason,
+		.at_ns = ktime_get_ns(),
+		.at_jiffies = jiffies,
+	};
+	struct seq_buf s;
+	unsigned long flags;
+	char *buf;
+	int cpu;
+
+	spin_lock_irqsave(&dump_lock, flags);
+
+	seq_buf_init(&s, ei->dump, dump_len);
+
+	if (ei->kind == SCX_EXIT_NONE) {
+		dump_line(&s, "Debug dump triggered by %s", ei->reason);
+	} else {
+		dump_line(&s, "%s[%d] triggered exit kind %d:",
+			  current->comm, current->pid, ei->kind);
+		dump_line(&s, "  %s (%s)", ei->reason, ei->msg);
+		dump_newline(&s);
+		dump_line(&s, "Backtrace:");
+		dump_stack_trace(&s, "  ", ei->bt, ei->bt_len);
+	}
+
+	if (SCX_HAS_OP(dump)) {
+		ops_dump_init(&s, "");
+		SCX_CALL_OP(SCX_KF_UNLOCKED, dump, &dctx);
+		ops_dump_exit();
+	}
+
+	dump_newline(&s);
+	dump_line(&s, "CPU states");
+	dump_line(&s, "----------");
+
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+		struct task_struct *p;
+		struct seq_buf ns;
+		size_t avail, used;
+		bool idle;
+
+		rq_lock(rq, &rf);
+
+		idle = list_empty(&rq->scx.runnable_list) &&
+			rq->curr->sched_class == &idle_sched_class;
+
+		if (idle && !SCX_HAS_OP(dump_cpu))
+			goto next;
+
+		/*
+		 * We don't yet know whether ops.dump_cpu() will produce output
+		 * and we may want to skip the default CPU dump if it doesn't.
+		 * Use a nested seq_buf to generate the standard dump so that we
+		 * can decide whether to commit later.
+		 */
+		avail = seq_buf_get_buf(&s, &buf);
+		seq_buf_init(&ns, buf, avail);
+
+		dump_newline(&ns);
+		dump_line(&ns, "CPU %-4d: nr_run=%u ops_qseq=%lu",
+			  cpu, rq->scx.nr_running, rq->scx.ops_qseq);
+		dump_line(&ns, "          curr=%s[%d] class=%ps",
+			  rq->curr->comm, rq->curr->pid,
+			  rq->curr->sched_class);
+
+		used = seq_buf_used(&ns);
+		if (SCX_HAS_OP(dump_cpu)) {
+			ops_dump_init(&ns, "  ");
+			SCX_CALL_OP(SCX_KF_REST, dump_cpu, &dctx, cpu, idle);
+			ops_dump_exit();
+		}
+
+		/*
+		 * If idle && nothing generated by ops.dump_cpu(), there's
+		 * nothing interesting. Skip.
+		 */
+		if (idle && used == seq_buf_used(&ns))
+			goto next;
+
+		/*
+		 * $s may already have overflowed when $ns was created. If so,
+		 * calling commit on it will trigger BUG.
+		 */
+		if (avail) {
+			seq_buf_commit(&s, seq_buf_used(&ns));
+			if (seq_buf_has_overflowed(&ns))
+				seq_buf_set_overflow(&s);
+		}
+
+		if (rq->curr->sched_class == &ext_sched_class)
+			scx_dump_task(&s, &dctx, rq->curr, '*');
+
+		list_for_each_entry(p, &rq->scx.runnable_list, scx.runnable_node)
+			scx_dump_task(&s, &dctx, p, ' ');
+	next:
+		rq_unlock(rq, &rf);
+	}
+
+	if (seq_buf_has_overflowed(&s) && dump_len >= sizeof(trunc_marker))
+		memcpy(ei->dump + dump_len - sizeof(trunc_marker),
+		       trunc_marker, sizeof(trunc_marker));
+
+	spin_unlock_irqrestore(&dump_lock, flags);
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
 
@@ -3152,6 +3488,13 @@ static __printf(3, 4) void scx_ops_exit_kind(enum scx_exit_kind kind,
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
 
@@ -3213,7 +3556,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret < 0)
 		goto err;
 
-	scx_exit_info = alloc_exit_info();
+	scx_exit_info = alloc_exit_info(ops->exit_dump_len);
 	if (!scx_exit_info) {
 		ret = -ENOMEM;
 		goto err_del;
@@ -3592,6 +3935,10 @@ static int bpf_scx_init_member(const struct btf_type *t,
 			return -E2BIG;
 		ops->timeout_ms = *(u32 *)(udata + moff);
 		return 1;
+	case offsetof(struct sched_ext_ops, exit_dump_len):
+		ops->exit_dump_len =
+			*(u32 *)(udata + moff) ?: SCX_EXIT_DUMP_DFL_LEN;
+		return 1;
 	}
 
 	return 0;
@@ -3723,6 +4070,21 @@ static const struct sysrq_key_op sysrq_sched_ext_reset_op = {
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+static void sysrq_handle_sched_ext_dump(u8 key)
+{
+	struct scx_exit_info ei = { .kind = SCX_EXIT_NONE, .reason = "SysRq-D" };
+
+	if (scx_enabled())
+		scx_dump_state(&ei, 0);
+}
+
+static const struct sysrq_key_op sysrq_sched_ext_dump_op = {
+	.handler	= sysrq_handle_sched_ext_dump,
+	.help_msg	= "dump-sched-ext(D)",
+	.action_msg	= "Trigger sched_ext debug dump",
+	.enable_mask	= SYSRQ_ENABLE_RTNICE,
+};
+
 /**
  * print_scx_info - print out sched_ext scheduler state
  * @log_lvl: the log level to use when printing
@@ -3793,6 +4155,7 @@ void __init init_sched_ext_class(void)
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
+	register_sysrq_key('D', &sysrq_sched_ext_dump_op);
 	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
 }
 
@@ -4218,6 +4581,57 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
 
+/**
+ * scx_bpf_dump - Generate extra debug dump specific to the BPF scheduler
+ * @fmt: format string
+ * @data: format string parameters packaged using ___bpf_fill() macro
+ * @data__sz: @data len, must end in '__sz' for the verifier
+ *
+ * To be called through scx_bpf_dump() helper from ops.dump(), dump_cpu() and
+ * dump_task() to generate extra debug dump specific to the BPF scheduler.
+ *
+ * The extra dump may be multiple lines. A single line may be split over
+ * multiple calls. The last line is automatically terminated.
+ */
+__bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
+				   u32 data__sz)
+{
+	struct scx_dump_data *dd = &scx_dump_data;
+	struct scx_bstr_buf *buf = &dd->buf;
+	s32 ret;
+
+	if (raw_smp_processor_id() != dd->cpu) {
+		scx_ops_error("scx_bpf_dump() must only be called from ops.dump() and friends");
+		return;
+	}
+
+	/* append the formatted string to the line buf */
+	ret = __bstr_format(buf->data, buf->line + dd->cursor,
+			    sizeof(buf->line) - dd->cursor, fmt, data, data__sz);
+	if (ret < 0) {
+		dump_line(dd->s, "%s[!] (\"%s\", %p, %u) failed to format (%d)",
+			  dd->prefix, fmt, data, data__sz, ret);
+		return;
+	}
+
+	dd->cursor += ret;
+	dd->cursor = min_t(s32, dd->cursor, sizeof(buf->line));
+
+	if (!dd->cursor)
+		return;
+
+	/*
+	 * If the line buf overflowed or ends in a newline, flush it into the
+	 * dump. This is to allow the caller to generate a single line over
+	 * multiple calls. As ops_dump_flush() can also handle multiple lines in
+	 * the line buf, the only case which can lead to an unexpected
+	 * truncation is when the caller keeps generating newlines in the middle
+	 * instead of the end consecutively. Don't do that.
+	 */
+	if (dd->cursor >= sizeof(buf->line) || buf->line[dd->cursor - 1] == '\n')
+		ops_dump_flush();
+}
+
 /**
  * scx_bpf_nr_cpu_ids - Return the number of possible CPU IDs
  *
@@ -4426,6 +4840,7 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_nr_cpu_ids)
 BTF_ID_FLAGS(func, scx_bpf_get_possible_cpumask, KF_ACQUIRE)
 BTF_ID_FLAGS(func, scx_bpf_get_online_cpumask, KF_ACQUIRE)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 833fe1bdccf9..3ea5cdf58bc7 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -38,6 +38,7 @@ s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
 void scx_bpf_exit_bstr(s64 exit_code, char *fmt, unsigned long long *data, u32 data__sz) __ksym __weak;
 void scx_bpf_error_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym;
+void scx_bpf_dump_bstr(char *fmt, unsigned long long *data, u32 data_len) __ksym __weak;
 u32 scx_bpf_nr_cpu_ids(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_possible_cpumask(void) __ksym __weak;
 const struct cpumask *scx_bpf_get_online_cpumask(void) __ksym __weak;
@@ -97,6 +98,17 @@ void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
 	___scx_bpf_bstr_format_checker(fmt, ##args);				\
 })
 
+/*
+ * scx_bpf_dump() wraps the scx_bpf_dump_bstr() kfunc with variadic arguments
+ * instead of an array of u64. To be used from ops.dump() and friends.
+ */
+#define scx_bpf_dump(fmt, args...)						\
+({										\
+	scx_bpf_bstr_preamble(fmt, args)					\
+	scx_bpf_dump_bstr(___fmt, ___param, sizeof(___param));			\
+	___scx_bpf_bstr_format_checker(fmt, ##args);				\
+})
+
 #define BPF_STRUCT_OPS(name, args...)						\
 SEC("struct_ops/"#name)								\
 BPF_PROG(name, ##args)
diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index a7fdaf8a858e..c58024c980c8 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -111,16 +111,23 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
  * is used to define ops and compat.h::SCX_OPS_LOAD/ATTACH() are used to load
  * and attach it, backward compatibility is automatically maintained where
  * reasonable.
+ *
+ * ec7e3b0463e1 ("implement-ops") in https://github.com/sched-ext/sched_ext is
+ * the current minimum required kernel version.
  */
 #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
 	struct __scx_name *__skel;						\
 										\
+	SCX_BUG_ON(!__COMPAT_struct_has_field("sched_ext_ops", "dump"),		\
+		   "sched_ext_ops.dump() missing, kernel too old?");		\
+										\
 	__skel = __scx_name##__open();						\
 	SCX_BUG_ON(!__skel, "Could not open " #__scx_name);			\
 	__skel; 								\
 })
 
-#define SCX_OPS_LOAD(__skel, __ops_name, __scx_name) ({				\
+#define SCX_OPS_LOAD(__skel, __ops_name, __scx_name, __uei_name) ({		\
+	UEI_SET_SIZE(__skel, __ops_name, __uei_name);				\
 	SCX_BUG_ON(__scx_name##__load((__skel)), "Failed to load skel");	\
 })
 
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 8c3b7fac4d05..c2ef85c645e1 100644
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
+#define UEI_SET_SIZE(__skel, __ops_name, __uei_name) ({					\
+	u32 __len = (__skel)->struct_ops.__ops_name->exit_dump_len ?: UEI_DUMP_DFL_LEN;	\
+	(__skel)->rodata->__uei_name##_dump_len = __len;				\
+	RESIZE_ARRAY((__skel), data, __uei_name##_dump, __len);				\
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
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 5ff217c4bfa0..5b3da28bf042 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -33,6 +33,7 @@ const volatile u32 stall_user_nth;
 const volatile u32 stall_kernel_nth;
 const volatile u32 dsp_batch;
 const volatile s32 disallow_tgid;
+const volatile bool suppress_dump;
 
 u32 test_error_cnt;
 
@@ -258,6 +259,56 @@ s32 BPF_STRUCT_OPS(qmap_init_task, struct task_struct *p,
 		return -ENOMEM;
 }
 
+void BPF_STRUCT_OPS(qmap_dump, struct scx_dump_ctx *dctx)
+{
+	s32 i, pid;
+
+	if (suppress_dump)
+		return;
+
+	bpf_for(i, 0, 5) {
+		void *fifo;
+
+		if (!(fifo = bpf_map_lookup_elem(&queue_arr, &i)))
+			return;
+
+		scx_bpf_dump("QMAP FIFO[%d]:", i);
+		bpf_repeat(4096) {
+			if (bpf_map_pop_elem(fifo, &pid))
+				break;
+			scx_bpf_dump(" %d", pid);
+		}
+		scx_bpf_dump("\n");
+	}
+}
+
+void BPF_STRUCT_OPS(qmap_dump_cpu, struct scx_dump_ctx *dctx, s32 cpu, bool idle)
+{
+	u32 zero = 0;
+	struct cpu_ctx *cpuc;
+
+	if (suppress_dump || idle)
+		return;
+	if (!(cpuc = bpf_map_lookup_percpu_elem(&cpu_ctx_stor, &zero, cpu)))
+		return;
+
+	scx_bpf_dump("QMAP: dsp_idx=%llu dsp_cnt=%llu",
+		     cpuc->dsp_idx, cpuc->dsp_cnt);
+}
+
+void BPF_STRUCT_OPS(qmap_dump_task, struct scx_dump_ctx *dctx, struct task_struct *p)
+{
+	struct task_ctx *taskc;
+
+	if (suppress_dump)
+		return;
+	if (!(taskc = bpf_task_storage_get(&task_ctx_stor, p, 0, 0)))
+		return;
+
+	scx_bpf_dump("QMAP: force_local=%d",
+		     taskc->force_local);
+}
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
 	return scx_bpf_create_dsq(SHARED_DSQ, -1);
@@ -274,6 +325,9 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .dequeue			= (void *)qmap_dequeue,
 	       .dispatch		= (void *)qmap_dispatch,
 	       .init_task		= (void *)qmap_init_task,
+	       .dump			= (void *)qmap_dump,
+	       .dump_cpu		= (void *)qmap_dump_cpu,
+	       .dump_task		= (void *)qmap_dump_task,
 	       .init			= (void *)qmap_init,
 	       .exit			= (void *)qmap_exit,
 	       .timeout_ms		= 5000U,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index a2614994cfaa..a1123a17581b 100644
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
@@ -28,6 +28,8 @@ const char help_fmt[] =
 "  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -b COUNT      Dispatch upto COUNT tasks together\n"
 "  -d PID        Disallow a process from switching into SCHED_EXT (-1 for self)\n"
+"  -D LEN        Set scx_exit_info.dump buffer length\n"
+"  -S            Suppress qmap-specific debug dump\n"
 "  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
 "  -v            Print libbpf debug messages\n"
 "  -h            Display this help and exit\n";
@@ -59,7 +61,7 @@ int main(int argc, char **argv)
 
 	skel = SCX_OPS_OPEN(qmap_ops, scx_qmap);
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:b:d:pvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:b:d:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -81,6 +83,12 @@ int main(int argc, char **argv)
 			if (skel->rodata->disallow_tgid < 0)
 				skel->rodata->disallow_tgid = getpid();
 			break;
+		case 'D':
+			skel->struct_ops.qmap_ops->exit_dump_len = strtoul(optarg, NULL, 0);
+			break;
+		case 'S':
+			skel->rodata->suppress_dump = true;
+			break;
 		case 'p':
 			skel->struct_ops.qmap_ops->flags |= SCX_OPS_SWITCH_PARTIAL;
 			break;
@@ -93,7 +101,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	SCX_OPS_LOAD(skel, qmap_ops, scx_qmap);
+	SCX_OPS_LOAD(skel, qmap_ops, scx_qmap, uei);
 	link = SCX_OPS_ATTACH(skel, qmap_ops, scx_qmap);
 
 	while (!exit_req && !UEI_EXITED(skel, uei)) {
diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 789ac62fea8e..7f500d1d56ac 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -80,7 +80,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	SCX_OPS_LOAD(skel, simple_ops, scx_simple);
+	SCX_OPS_LOAD(skel, simple_ops, scx_simple, uei);
 	link = SCX_OPS_ATTACH(skel, simple_ops, scx_simple);
 
 	while (!exit_req && !UEI_EXITED(skel, uei)) {
-- 
2.45.2


