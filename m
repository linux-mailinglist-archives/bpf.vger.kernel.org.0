Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1519450AF91
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 07:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiDVFkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 01:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444172AbiDVFhA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 01:37:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEACE4F448;
        Thu, 21 Apr 2022 22:34:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u15so5115687ple.4;
        Thu, 21 Apr 2022 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=em5/zodA7layme8bSqQKMP2f6/tfNS7ip5sBkTMrN9A=;
        b=KHZZ22qesd+CEISUYdFzi/FRutHa+q7TOp4ZVXeLvsIlanz8UcRxkz155LV4hu4BPH
         Bh4yu0QLs20Z31QlvRc9CiswHI9xIQ8kujCXzcNmRuqFNUCoFNdTCoEDSNBS3cVUGXJV
         r9gZmPrLoecxN3TjRrF6Cf/LcuYw55cRxLvhK1rnHAreb6E0NrUi4ht2JpCxRHKBriyh
         mDRBE70pOeSd8WvXKJhxLJAaisb/MEO/PJu65Q5dYDTBebmXr1YQ0IXYRmVZ02u/RTWr
         VmRInTKR9xndu4YulM+vyKdBOKwxFeKtvIhmD3PP/BzqxpYGU4rWC3srJ7VnzSAAPvgU
         BPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=em5/zodA7layme8bSqQKMP2f6/tfNS7ip5sBkTMrN9A=;
        b=TXQsmN7wycrFhmgKE91SVXSn1akczCYuXPcNYPVutKyEcXWGZaIWPpPnyzByGx/gL5
         nGjLbQt7LPwwGZ28tPAZKK+BiorfGwnZsejs0cxzRHFhPcx9WzhknsQOugVagbPMUyYY
         FI58TlKZm3gddnok6UWOSLM6gqJbsemobz66M+SfaJq3nq2XLw/EpRDTrT1Xe4MW92Gr
         TS9rp1uD77U1EtDaHNH/+uyY7DEbMJFYL4ldLX4/Ad9WHP0zRoekoVaWy8o+d67v2ZkP
         9ivzKbg5Rrh7FM7u2MrO3De1AUNl2w/+9rqFKzAlqZ3cLumFPJz8nih8ZmASsnJaPmkK
         Ve9Q==
X-Gm-Message-State: AOAM5330MHUQZHVGBjuJtdjW0wEzERQGezlLBtxILhM/yL4u0R7ykqI2
        EEl4UFTt/NnUepm2yLx3LDg=
X-Google-Smtp-Source: ABdhPJzbOYKR6l9hGWbRogqQB/Harv/b9Lyt2KCiBOt6R93CV7V+sDrAIl70df7Bs3CDdP2hKFd+IQ==
X-Received: by 2002:a17:903:28d:b0:158:ee84:e588 with SMTP id j13-20020a170903028d00b00158ee84e588mr2820672plr.60.1650605648233;
        Thu, 21 Apr 2022 22:34:08 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:32e3:a023:46c1:80cd])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm886519pgc.50.2022.04.21.22.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:34:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 3/4] perf record: Implement basic filtering for off-cpu
Date:   Thu, 21 Apr 2022 22:34:00 -0700
Message-Id: <20220422053401.208207-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220422053401.208207-1-namhyung@kernel.org>
References: <20220422053401.208207-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It should honor cpu and task filtering with -a, -C or -p, -t options.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c            |  2 +-
 tools/perf/util/bpf_off_cpu.c          | 78 +++++++++++++++++++++++---
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 52 +++++++++++++++--
 3 files changed, 119 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3d24d528ba8e..592384e058c3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -907,7 +907,7 @@ static int record__config_text_poke(struct evlist *evlist)
 
 static int record__config_off_cpu(struct record *rec)
 {
-	return off_cpu_prepare(rec->evlist);
+	return off_cpu_prepare(rec->evlist, &rec->opts.target);
 }
 
 static bool record__kcore_readable(struct machine *machine)
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 1f87d2a9b86d..89f36229041d 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -6,6 +6,9 @@
 #include "util/off_cpu.h"
 #include "util/perf-hooks.h"
 #include "util/session.h"
+#include "util/target.h"
+#include "util/cpumap.h"
+#include "util/thread_map.h"
 #include <bpf/bpf.h>
 
 #include "bpf_skel/off_cpu.skel.h"
@@ -57,8 +60,23 @@ static int off_cpu_config(struct evlist *evlist)
 	return 0;
 }
 
-static void off_cpu_start(void *arg __maybe_unused)
+static void off_cpu_start(void *arg)
 {
+	struct evlist *evlist = arg;
+
+	/* update task filter for the given workload */
+	if (!skel->bss->has_cpu && !skel->bss->has_task &&
+	    perf_thread_map__pid(evlist->core.threads, 0) != -1) {
+		int fd;
+		u32 pid;
+		u8 val = 1;
+
+		skel->bss->has_task = 1;
+		fd = bpf_map__fd(skel->maps.task_filter);
+		pid = perf_thread_map__pid(evlist->core.threads, 0);
+		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
+	}
+
 	skel->bss->enabled = 1;
 }
 
@@ -68,31 +86,75 @@ static void off_cpu_finish(void *arg __maybe_unused)
 	off_cpu_bpf__destroy(skel);
 }
 
-int off_cpu_prepare(struct evlist *evlist)
+int off_cpu_prepare(struct evlist *evlist, struct target *target)
 {
-	int err;
+	int err, fd, i;
+	int ncpus = 1, ntasks = 1;
 
 	if (off_cpu_config(evlist) < 0) {
 		pr_err("Failed to config off-cpu BPF event\n");
 		return -1;
 	}
 
-	set_max_rlimit();
-
-	skel = off_cpu_bpf__open_and_load();
+	skel = off_cpu_bpf__open();
 	if (!skel) {
 		pr_err("Failed to open off-cpu skeleton\n");
 		return -1;
 	}
 
+	/* don't need to set cpu filter for system-wide mode */
+	if (target->cpu_list) {
+		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
+		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
+	}
+
+	if (target__has_task(target)) {
+		ncpus = perf_thread_map__nr(evlist->core.threads);
+		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+	}
+
+	set_max_rlimit();
+
+	err = off_cpu_bpf__load(skel);
+	if (err) {
+		pr_err("Failed to load off-cpu skeleton\n");
+		goto out;
+	}
+
+	if (target->cpu_list) {
+		u32 cpu;
+		u8 val = 1;
+
+		skel->bss->has_cpu = 1;
+		fd = bpf_map__fd(skel->maps.cpu_filter);
+
+		for (i = 0; i < ncpus; i++) {
+			cpu = perf_cpu_map__cpu(evlist->core.user_requested_cpus, i).cpu;
+			bpf_map_update_elem(fd, &cpu, &val, BPF_ANY);
+		}
+	}
+
+	if (target__has_task(target)) {
+		u32 pid;
+		u8 val = 1;
+
+		skel->bss->has_task = 1;
+		fd = bpf_map__fd(skel->maps.task_filter);
+
+		for (i = 0; i < ntasks; i++) {
+			pid = perf_thread_map__pid(evlist->core.threads, i);
+			bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
+		}
+	}
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu skeleton\n");
 		goto out;
 	}
 
-	if (perf_hooks__set_hook("record_start", off_cpu_start, NULL) ||
-	    perf_hooks__set_hook("record_end", off_cpu_finish, NULL)) {
+	if (perf_hooks__set_hook("record_start", off_cpu_start, evlist) ||
+	    perf_hooks__set_hook("record_end", off_cpu_finish, evlist)) {
 		pr_err("Failed to attach off-cpu skeleton\n");
 		goto out;
 	}
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 2bc6f7cc59ea..27425fe361e2 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -49,12 +49,28 @@ struct {
 	__uint(max_entries, MAX_ENTRIES);
 } off_cpu SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} cpu_filter SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} task_filter SEC(".maps");
+
 /* old kernel task_struct definition */
 struct task_struct___old {
 	long state;
 } __attribute__((preserve_access_index));
 
 int enabled = 0;
+int has_cpu = 0;
+int has_task = 0;
 
 /*
  * recently task_struct->state renamed to __state so it made an incompatible
@@ -74,6 +90,37 @@ static inline int get_task_state(struct task_struct *t)
 	return BPF_CORE_READ(t_old, state);
 }
 
+static inline int can_record(struct task_struct *t, int state)
+{
+	if (has_cpu) {
+		__u32 cpu = bpf_get_smp_processor_id();
+		__u8 *ok;
+
+		ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
+		if (!ok)
+			return 0;
+	}
+
+	if (has_task) {
+		__u8 *ok;
+		__u32 pid = t->pid;
+
+		ok = bpf_map_lookup_elem(&task_filter, &pid);
+		if (!ok)
+			return 0;
+	}
+
+	/* kernel threads don't have user stack */
+	if (t->flags & PF_KTHREAD)
+		return 0;
+
+	if (state != TASK_INTERRUPTIBLE &&
+	    state != TASK_UNINTERRUPTIBLE)
+		return 0;
+
+	return 1;
+}
+
 SEC("tp_btf/sched_switch")
 int on_switch(u64 *ctx)
 {
@@ -92,10 +139,7 @@ int on_switch(u64 *ctx)
 
 	ts = bpf_ktime_get_ns();
 
-	if (prev->flags & PF_KTHREAD)
-		goto next;
-	if (state != TASK_INTERRUPTIBLE &&
-	    state != TASK_UNINTERRUPTIBLE)
+	if (!can_record(prev, state))
 		goto next;
 
 	stack_id = bpf_get_stackid(ctx, &stacks,
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

