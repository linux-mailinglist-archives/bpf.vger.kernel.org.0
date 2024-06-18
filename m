Return-Path: <bpf+bounces-32452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD6590DE3E
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 23:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6023285DD7
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23916CD01;
	Tue, 18 Jun 2024 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3M/6hH0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD34199236;
	Tue, 18 Jun 2024 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745702; cv=none; b=RZDAqt2WjFBRz1bqMJI1mhxTH//gD/m/XYT7KvFg/c6BU0IygkEh2d72uGqIR3G7tEF86E8+zewn+PkKnXI+ngOlqzosq/tQprKjFTKYfP/S/YloCtj2t4vKW0dH+hLjrJDXY38y/nuC+Bf8RPB+6HDfaQzlAi9Mrij+3vaYB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745702; c=relaxed/simple;
	bh=Kbef10KEdR+OuFloSxKKm27nDciWGy3oFp+HC+Bq6B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNgcJKF17zwoTIXgdm097yijDV1z7pVuGOLNbyx7CS8AvbjgovINluVrUOOgK2uI7TohjcqyXFviH3QhIH2TjVimRooXvD/CsDeG8p0X/MzvTlPEcm4hoL/23CslhguyyGewFYaP5snrA5FFpJ7IUv1unnDjItirAJfUxG/l5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3M/6hH0; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e3ff7c4cc8so4363558a12.3;
        Tue, 18 Jun 2024 14:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718745700; x=1719350500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdifndTIQr3M1zI7WVTbj+9JWiWTuT2GhvzrMyCix5g=;
        b=E3M/6hH0xWcoJHVkA1rHxxBmwuxbH1VX3Hmoa1wNFjfmiCCVyqBs38Qb4TlQBZiTh/
         4j5oxGcnTeOf29B5/s+oe/b0r+fwE+nmmLVpvosz3XYRWzTt0PUqL1LL9uvnX9clx6ye
         IanPqe1sLvDxyqV/fFC9TCZD8HFnp62b6vRErU5gNZrJXEDixyetRhhzspr40cVo21Py
         o85BcnLzKGFhF5Z6k4RZfP+9/w6uzKgYJ+WlBRM3cse7S5E0/PFy+FdDfEcbwk/V2j4N
         FxU+NP6KUM254v4Qv+p3JadcR+Kgl+kWVcn6uy9uV9OPBnrF1mw7L+K1prJvMoTr4+Vx
         /eNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745700; x=1719350500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GdifndTIQr3M1zI7WVTbj+9JWiWTuT2GhvzrMyCix5g=;
        b=llg//hxdY5yjbKfk4ccTUAFK+Sn8GqCzFB8qBbpJ4xr4vCHt+qFivtrhGru32tbr/t
         XEyocNiQvGIMBoG9nO4EZmno1nFvzAMhUOFrBC6ai+u8N7PNu7ioZUYcFSfFSzuqRz8A
         eyoZW5BdIIuDB8CKdT3vqO61plNkHNgkHJuEo1VkDAIyE3APZfaGgJmVyHLGjHhpTeY6
         gOkRTusUDGetFkR4v61ohOKnUmsR7BhcUXfGJcyb2GrpuHeOeE0XDTyng7gJ/cALUDpx
         VZuyx8bTENwYuJ5joM7m5oSQiFHkUswsFjVjFtvhvDqwKmgBdsabvPkoryFNNEnrGPu7
         BbRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2mfeIGMG/VmW+Io/hZh7W7LTWuxFliRH8mTCa9SSbdenwdWc0uBXKsufvKJMSk2tq1tp66zvfGM0liUW88Be2i+Wc
X-Gm-Message-State: AOJu0YwABBzgY7kUng95Q23Jt6ZKDupTmtT4nPCP7Wf6l6091CUbYa+h
	zrXf4b+wmkWrW8Nu37wihEKtBHdIk4HvERuQaxBJFIB66kYFuF0W
X-Google-Smtp-Source: AGHT+IG5XDu1k+VB0F88iLI7cOUZjtCvTaDN+9IET1C6vZ0B1qrkCQxPpZXqQghA5HnuiG5X0ktwiw==
X-Received: by 2002:a17:902:f549:b0:1f6:7f8f:65b5 with SMTP id d9443c01a7336-1f9aa67d20fmr7952115ad.56.1718745699623;
        Tue, 18 Jun 2024 14:21:39 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55c8bsm102220815ad.48.2024.06.18.14.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 14:21:39 -0700 (PDT)
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
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH 18/30] sched_ext: Add a central scheduler which makes all scheduling decisions on one CPU
Date: Tue, 18 Jun 2024 11:17:33 -1000
Message-ID: <20240618212056.2833381-19-tj@kernel.org>
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

This patch adds a new example scheduler, scx_central, which demonstrates
central scheduling where one CPU is responsible for making all scheduling
decisions in the system using scx_bpf_kick_cpu(). The central CPU makes
scheduling decisions for all CPUs in the system, queues tasks on the
appropriate local dsq's and preempts the worker CPUs. The worker CPUs in
turn preempt the central CPU when it needs tasks to run.

Currently, every CPU depends on its own tick to expire the current task. A
follow-up patch implementing tickless support for sched_ext will allow the
worker CPUs to go full tickless so that they can run completely undisturbed.

v3: - Kumar fixed a bug where the dispatch path could overflow the dispatch
      buffer if too many are dispatched to the fallback DSQ.

    - Use the new SCX_KICK_IDLE to wake up non-central CPUs.

    - Dropped '-p' option.

v2: - Use RESIZABLE_ARRAY() instead of fixed MAX_CPUS and use SCX_BUG[_ON]()
      to simplify error handling.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
 tools/sched_ext/Makefile          |   2 +-
 tools/sched_ext/scx_central.bpf.c | 214 ++++++++++++++++++++++++++++++
 tools/sched_ext/scx_central.c     | 105 +++++++++++++++
 3 files changed, 320 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_central.bpf.c
 create mode 100644 tools/sched_ext/scx_central.c

diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 626782a21375..bf7e108f5ae1 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -176,7 +176,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
 
 SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
 
-c-sched-targets = scx_simple scx_qmap
+c-sched-targets = scx_simple scx_qmap scx_central
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
new file mode 100644
index 000000000000..428b2262faa3
--- /dev/null
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A central FIFO sched_ext scheduler which demonstrates the followings:
+ *
+ * a. Making all scheduling decisions from one CPU:
+ *
+ *    The central CPU is the only one making scheduling decisions. All other
+ *    CPUs kick the central CPU when they run out of tasks to run.
+ *
+ *    There is one global BPF queue and the central CPU schedules all CPUs by
+ *    dispatching from the global queue to each CPU's local dsq from dispatch().
+ *    This isn't the most straightforward. e.g. It'd be easier to bounce
+ *    through per-CPU BPF queues. The current design is chosen to maximally
+ *    utilize and verify various SCX mechanisms such as LOCAL_ON dispatching.
+ *
+ * b. Preemption
+ *
+ *    SCX_KICK_PREEMPT is used to trigger scheduling and CPUs to move to the
+ *    next tasks.
+ *
+ * This scheduler is designed to maximize usage of various SCX mechanisms. A
+ * more practical implementation would likely put the scheduling loop outside
+ * the central CPU's dispatch() path and add some form of priority mechanism.
+ *
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#include <scx/common.bpf.h>
+
+char _license[] SEC("license") = "GPL";
+
+enum {
+	FALLBACK_DSQ_ID		= 0,
+};
+
+const volatile s32 central_cpu;
+const volatile u32 nr_cpu_ids = 1;	/* !0 for veristat, set during init */
+const volatile u64 slice_ns = SCX_SLICE_DFL;
+
+u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
+u64 nr_dispatches, nr_mismatches, nr_retries;
+u64 nr_overflows;
+
+UEI_DEFINE(uei);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 4096);
+	__type(value, s32);
+} central_q SEC(".maps");
+
+/* can't use percpu map due to bad lookups */
+bool RESIZABLE_ARRAY(data, cpu_gimme_task);
+
+s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
+		   s32 prev_cpu, u64 wake_flags)
+{
+	/*
+	 * Steer wakeups to the central CPU as much as possible to avoid
+	 * disturbing other CPUs. It's safe to blindly return the central cpu as
+	 * select_cpu() is a hint and if @p can't be on it, the kernel will
+	 * automatically pick a fallback CPU.
+	 */
+	return central_cpu;
+}
+
+void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
+{
+	s32 pid = p->pid;
+
+	__sync_fetch_and_add(&nr_total, 1);
+
+	if (bpf_map_push_elem(&central_q, &pid, 0)) {
+		__sync_fetch_and_add(&nr_overflows, 1);
+		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, enq_flags);
+		return;
+	}
+
+	__sync_fetch_and_add(&nr_queued, 1);
+
+	if (!scx_bpf_task_running(p))
+		scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+}
+
+static bool dispatch_to_cpu(s32 cpu)
+{
+	struct task_struct *p;
+	s32 pid;
+
+	bpf_repeat(BPF_MAX_LOOPS) {
+		if (bpf_map_pop_elem(&central_q, &pid))
+			break;
+
+		__sync_fetch_and_sub(&nr_queued, 1);
+
+		p = bpf_task_from_pid(pid);
+		if (!p) {
+			__sync_fetch_and_add(&nr_lost_pids, 1);
+			continue;
+		}
+
+		/*
+		 * If we can't run the task at the top, do the dumb thing and
+		 * bounce it to the fallback dsq.
+		 */
+		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+			__sync_fetch_and_add(&nr_mismatches, 1);
+			scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, 0);
+			bpf_task_release(p);
+			/*
+			 * We might run out of dispatch buffer slots if we continue dispatching
+			 * to the fallback DSQ, without dispatching to the local DSQ of the
+			 * target CPU. In such a case, break the loop now as will fail the
+			 * next dispatch operation.
+			 */
+			if (!scx_bpf_dispatch_nr_slots())
+				break;
+			continue;
+		}
+
+		/* dispatch to local and mark that @cpu doesn't need more */
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+
+		if (cpu != central_cpu)
+			scx_bpf_kick_cpu(cpu, SCX_KICK_IDLE);
+
+		bpf_task_release(p);
+		return true;
+	}
+
+	return false;
+}
+
+void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
+{
+	if (cpu == central_cpu) {
+		/* dispatch for all other CPUs first */
+		__sync_fetch_and_add(&nr_dispatches, 1);
+
+		bpf_for(cpu, 0, nr_cpu_ids) {
+			bool *gimme;
+
+			if (!scx_bpf_dispatch_nr_slots())
+				break;
+
+			/* central's gimme is never set */
+			gimme = ARRAY_ELEM_PTR(cpu_gimme_task, cpu, nr_cpu_ids);
+			if (gimme && !*gimme)
+				continue;
+
+			if (dispatch_to_cpu(cpu))
+				*gimme = false;
+		}
+
+		/*
+		 * Retry if we ran out of dispatch buffer slots as we might have
+		 * skipped some CPUs and also need to dispatch for self. The ext
+		 * core automatically retries if the local dsq is empty but we
+		 * can't rely on that as we're dispatching for other CPUs too.
+		 * Kick self explicitly to retry.
+		 */
+		if (!scx_bpf_dispatch_nr_slots()) {
+			__sync_fetch_and_add(&nr_retries, 1);
+			scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+			return;
+		}
+
+		/* look for a task to run on the central CPU */
+		if (scx_bpf_consume(FALLBACK_DSQ_ID))
+			return;
+		dispatch_to_cpu(central_cpu);
+	} else {
+		bool *gimme;
+
+		if (scx_bpf_consume(FALLBACK_DSQ_ID))
+			return;
+
+		gimme = ARRAY_ELEM_PTR(cpu_gimme_task, cpu, nr_cpu_ids);
+		if (gimme)
+			*gimme = true;
+
+		/*
+		 * Force dispatch on the scheduling CPU so that it finds a task
+		 * to run for us.
+		 */
+		scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+	}
+}
+
+int BPF_STRUCT_OPS_SLEEPABLE(central_init)
+{
+	return scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+}
+
+void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
+{
+	UEI_RECORD(uei, ei);
+}
+
+SCX_OPS_DEFINE(central_ops,
+	       /*
+		* We are offloading all scheduling decisions to the central CPU
+		* and thus being the last task on a given CPU doesn't mean
+		* anything special. Enqueue the last tasks like any other tasks.
+		*/
+	       .flags			= SCX_OPS_ENQ_LAST,
+
+	       .select_cpu		= (void *)central_select_cpu,
+	       .enqueue			= (void *)central_enqueue,
+	       .dispatch		= (void *)central_dispatch,
+	       .init			= (void *)central_init,
+	       .exit			= (void *)central_exit,
+	       .name			= "central");
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
new file mode 100644
index 000000000000..5f09fc666a63
--- /dev/null
+++ b/tools/sched_ext/scx_central.c
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Meta Platforms, Inc. and affiliates.
+ * Copyright (c) 2022 Tejun Heo <tj@kernel.org>
+ * Copyright (c) 2022 David Vernet <dvernet@meta.com>
+ */
+#define _GNU_SOURCE
+#include <sched.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <inttypes.h>
+#include <signal.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include <scx/common.h>
+#include "scx_central.bpf.skel.h"
+
+const char help_fmt[] =
+"A central FIFO sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-s SLICE_US] [-c CPU]\n"
+"\n"
+"  -s SLICE_US   Override slice duration\n"
+"  -c CPU        Override the central CPU (default: 0)\n"
+"  -v            Print libbpf debug messages\n"
+"  -h            Display this help and exit\n";
+
+static bool verbose;
+static volatile int exit_req;
+
+static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG && !verbose)
+		return 0;
+	return vfprintf(stderr, format, args);
+}
+
+static void sigint_handler(int dummy)
+{
+	exit_req = 1;
+}
+
+int main(int argc, char **argv)
+{
+	struct scx_central *skel;
+	struct bpf_link *link;
+	__u64 seq = 0;
+	__s32 opt;
+
+	libbpf_set_print(libbpf_print_fn);
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	skel = SCX_OPS_OPEN(central_ops, scx_central);
+
+	skel->rodata->central_cpu = 0;
+	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
+
+	while ((opt = getopt(argc, argv, "s:c:pvh")) != -1) {
+		switch (opt) {
+		case 's':
+			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
+			break;
+		case 'c':
+			skel->rodata->central_cpu = strtoul(optarg, NULL, 0);
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	/* Resize arrays so their element count is equal to cpu count. */
+	RESIZE_ARRAY(skel, data, cpu_gimme_task, skel->rodata->nr_cpu_ids);
+
+	SCX_OPS_LOAD(skel, central_ops, scx_central, uei);
+	link = SCX_OPS_ATTACH(skel, central_ops, scx_central);
+
+	while (!exit_req && !UEI_EXITED(skel, uei)) {
+		printf("[SEQ %llu]\n", seq++);
+		printf("total   :%10" PRIu64 "    local:%10" PRIu64 "   queued:%10" PRIu64 "  lost:%10" PRIu64 "\n",
+		       skel->bss->nr_total,
+		       skel->bss->nr_locals,
+		       skel->bss->nr_queued,
+		       skel->bss->nr_lost_pids);
+		printf("                    dispatch:%10" PRIu64 " mismatch:%10" PRIu64 " retry:%10" PRIu64 "\n",
+		       skel->bss->nr_dispatches,
+		       skel->bss->nr_mismatches,
+		       skel->bss->nr_retries);
+		printf("overflow:%10" PRIu64 "\n",
+		       skel->bss->nr_overflows);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	UEI_REPORT(skel, uei);
+	scx_central__destroy(skel);
+	return 0;
+}
-- 
2.45.2


