Return-Path: <bpf+bounces-14849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0677C7E889D
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62B9EB20BB6
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFA75242;
	Sat, 11 Nov 2023 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahb5iozS"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4C538B
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:51:03 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A0469B;
	Fri, 10 Nov 2023 18:49:34 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b4145e887bso1440355b6e.3;
        Fri, 10 Nov 2023 18:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670974; x=1700275774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sq8GyvoIEofxUpR267Y+YixlpovSFfXXEypQbgqNtE=;
        b=Ahb5iozSeSK+KqNf+ANuUhgYwA7gcA3LtHz7ITYTVLPbYgyZhKtpTbu30wB34OTI52
         m4Ss5rDSbbzq+wUQIaz4TUPXhJyXqGB21ZWcfvXRNUs/VAScFs7ZUbGcRIcgGJWNroiE
         pat1T1RgPJFV/8NCTXPyR5gP0pA03LH98po0oZ7U5Q9/WZ5rt0fHvNFOSVNrkvsG9Enm
         33mgKxm15J2q0D2Ocw52pUJs+zQOzO+2iM6QkpgIF2jDD4fwkM/RDitUsq7/1BGaiaHD
         V6SbukmMvo6UaAvZy44ToSO/ZVKUtiTFu+dVQpbw44lY9X5VuUcHnNzoGLpvNnb9tjb+
         +uNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670974; x=1700275774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+sq8GyvoIEofxUpR267Y+YixlpovSFfXXEypQbgqNtE=;
        b=hYa/WjWcP9k2fhBI00xxCj/lCUb8n16s/eX/3H9l5rKlAZagevpQVLU8Mq89ubcZYc
         gR/etnLmhk2jw1D4mK2BaEdAHcKgUd0/uo2u7eDRuIC50xYJq3cGzOulWEAVK+rfRTLu
         79Qqqoa1Aw7M0Gvnab7Wkg62iTq6C4X3x+PNi5ZUFbJDk4J8QuMa7BpqLtMkPcCCPgEn
         SmhaqmqyxJoWXpj7W8t3gJBpVTNQfYu9sMM2WFbe4eACGUSsFThNqWZgQ6liJvCDrhYt
         LztWiOgwB7CcOFRcUwej2dPcxHKkrOfoSPUeLe1SUs7xV85o1gGWUtWAyfMn5L8jOYr7
         3Rbg==
X-Gm-Message-State: AOJu0Yw/CnZaJZTNBDWKn/OFcRkdzksxi8ghwWL1VfdQUPC8H/7UeX5E
	k35YsNUrMDk6iD5HA/Lha8k=
X-Google-Smtp-Source: AGHT+IGNBLqhamcANUP2JujoKHSlPA81AEDgYyi8cvg6fYMxcaiuU+cJeYMtV0MTCVTixERvrvngqg==
X-Received: by 2002:a05:6808:1413:b0:3ad:f866:39bd with SMTP id w19-20020a056808141300b003adf86639bdmr1571626oiv.27.1699670973745;
        Fri, 10 Nov 2023 18:49:33 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id bq4-20020a056a02044400b0059d6f5196fasm325516pgb.78.2023.11.10.18.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:33 -0800 (PST)
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
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH 20/36] sched_ext: Add a central scheduler which makes all scheduling decisions on one CPU
Date: Fri, 10 Nov 2023 16:47:46 -1000
Message-ID: <20231111024835.2164816-21-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
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

v2: * Use RESIZABLE_ARRAY() instead of fixed MAX_CPUS and use SCX_BUG[_ON]()
      to simplify error handling.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
 tools/sched_ext/.gitignore        |   1 +
 tools/sched_ext/Makefile          |   2 +-
 tools/sched_ext/scx_central.bpf.c | 212 ++++++++++++++++++++++++++++++
 tools/sched_ext/scx_central.c     | 100 ++++++++++++++
 4 files changed, 314 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_central.bpf.c
 create mode 100644 tools/sched_ext/scx_central.c

diff --git a/tools/sched_ext/.gitignore b/tools/sched_ext/.gitignore
index 00e0eef67b7b..c2deba4909bf 100644
--- a/tools/sched_ext/.gitignore
+++ b/tools/sched_ext/.gitignore
@@ -1,5 +1,6 @@
 scx_simple
 scx_qmap
+scx_central
 *.skel.h
 *.subskel.h
 /tools/
diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
index 1f306d54fdc8..bb5dab64cca7 100644
--- a/tools/sched_ext/Makefile
+++ b/tools/sched_ext/Makefile
@@ -179,7 +179,7 @@ SCX_COMMON_DEPS := scx_common.h user_exit_info.h | $(BINDIR)
 ################
 # C schedulers #
 ################
-c-sched-targets = scx_simple scx_qmap
+c-sched-targets = scx_simple scx_qmap scx_central
 
 $(addprefix $(BINDIR)/,$(c-sched-targets)): \
 	$(BINDIR)/%: \
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
new file mode 100644
index 000000000000..e3f7a7afa5cb
--- /dev/null
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -0,0 +1,212 @@
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
+#include "scx_common.bpf.h"
+
+char _license[] SEC("license") = "GPL";
+
+enum {
+	FALLBACK_DSQ_ID		= 0,
+};
+
+const volatile bool switch_partial;
+const volatile s32 central_cpu;
+const volatile u32 nr_cpu_ids = 1;	/* !0 for veristat, set during init */
+const volatile u64 slice_ns = SCX_SLICE_DFL;
+
+u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
+u64 nr_dispatches, nr_mismatches, nr_retries;
+u64 nr_overflows;
+
+struct user_exit_info uei;
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
+			continue;
+		}
+
+		/* dispatch to local and mark that @cpu doesn't need more */
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+
+		if (cpu != central_cpu)
+			scx_bpf_kick_cpu(cpu, 0);
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
+	if (!switch_partial)
+		scx_bpf_switch_all();
+
+	return scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+}
+
+void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
+{
+	uei_record(&uei, ei);
+}
+
+SEC(".struct_ops.link")
+struct sched_ext_ops central_ops = {
+	/*
+	 * We are offloading all scheduling decisions to the central CPU and
+	 * thus being the last task on a given CPU doesn't mean anything
+	 * special. Enqueue the last tasks like any other tasks.
+	 */
+	.flags			= SCX_OPS_ENQ_LAST,
+
+	.select_cpu		= (void *)central_select_cpu,
+	.enqueue		= (void *)central_enqueue,
+	.dispatch		= (void *)central_dispatch,
+	.init			= (void *)central_init,
+	.exit			= (void *)central_exit,
+	.name			= "central",
+};
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
new file mode 100644
index 000000000000..d832d55b756e
--- /dev/null
+++ b/tools/sched_ext/scx_central.c
@@ -0,0 +1,100 @@
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
+#include <signal.h>
+#include <libgen.h>
+#include <bpf/bpf.h>
+#include "scx_common.h"
+#include "scx_central.skel.h"
+
+const char help_fmt[] =
+"A central FIFO sched_ext scheduler.\n"
+"\n"
+"See the top-level comment in .bpf.c for more details.\n"
+"\n"
+"Usage: %s [-s SLICE_US] [-c CPU] [-p]\n"
+"\n"
+"  -s SLICE_US   Override slice duration\n"
+"  -c CPU        Override the central CPU (default: 0)\n"
+"  -p            Switch only tasks on SCHED_EXT policy intead of all\n"
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
+	struct scx_central *skel;
+	struct bpf_link *link;
+	__u64 seq = 0;
+	__s32 opt;
+
+	signal(SIGINT, sigint_handler);
+	signal(SIGTERM, sigint_handler);
+
+	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
+
+	skel = scx_central__open();
+	SCX_BUG_ON(!skel, "Failed to open skel");
+
+	skel->rodata->central_cpu = 0;
+	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
+
+	while ((opt = getopt(argc, argv, "s:c:ph")) != -1) {
+		switch (opt) {
+		case 's':
+			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
+			break;
+		case 'c':
+			skel->rodata->central_cpu = strtoul(optarg, NULL, 0);
+			break;
+		case 'p':
+			skel->rodata->switch_partial = true;
+			break;
+		default:
+			fprintf(stderr, help_fmt, basename(argv[0]));
+			return opt != 'h';
+		}
+	}
+
+	/* Resize arrays so their element count is equal to cpu count. */
+	RESIZE_ARRAY(data, cpu_gimme_task, skel->rodata->nr_cpu_ids);
+
+	SCX_BUG_ON(scx_central__load(skel), "Failed to load skel");
+
+	link = bpf_map__attach_struct_ops(skel->maps.central_ops);
+	SCX_BUG_ON(!link, "Failed to attach struct_ops");
+
+	while (!exit_req && !uei_exited(&skel->bss->uei)) {
+		printf("[SEQ %llu]\n", seq++);
+		printf("total   :%10lu    local:%10lu   queued:%10lu  lost:%10lu\n",
+		       skel->bss->nr_total,
+		       skel->bss->nr_locals,
+		       skel->bss->nr_queued,
+		       skel->bss->nr_lost_pids);
+		printf("                    dispatch:%10lu mismatch:%10lu retry:%10lu\n",
+		       skel->bss->nr_dispatches,
+		       skel->bss->nr_mismatches,
+		       skel->bss->nr_retries);
+		printf("overflow:%10lu\n",
+		       skel->bss->nr_overflows);
+		fflush(stdout);
+		sleep(1);
+	}
+
+	bpf_link__destroy(link);
+	uei_print(&skel->bss->uei);
+	scx_central__destroy(skel);
+	return 0;
+}
-- 
2.42.0


