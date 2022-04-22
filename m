Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B5150BB2A
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 17:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449113AbiDVPIM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448770AbiDVPIJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 11:08:09 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BE813D67;
        Fri, 22 Apr 2022 08:05:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t12so11433376pll.7;
        Fri, 22 Apr 2022 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eaQvtfLK2dUtC73DrzllpLaXHSgiKs8APVcQ9XyE0yY=;
        b=MzZLpeTQiLlxT5dXf1hHNAoXuVKHmyk6mKu8k6n1m2ozkWgDf9ZGQEVJF9aex9+Tw/
         7MOdyLE+K+BP/9mCPNmJRB8fMPTYnRmVGyqABOhwuxq+IXdCk3hEaN6HlwsncI7Q5sdz
         VSapOdXyGSfAI6KlqkHkgEXixDhTJmm/2+1XhaEJtsISJdTWtT9F/H1KQzAjUayNAMEG
         Zv7hbh4reSDZ6FU99Ki9yZhAp3ccHADPK7qhYEIKlfHQV3yUrdDGaHMr3kGq2l/NwnLa
         saSotVlxbD+nYI4HaDSfnjumC8fmjlsCQrGTdtekqfTtVZ8jLzYYVCyjZn8V8gDyNW0y
         tL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eaQvtfLK2dUtC73DrzllpLaXHSgiKs8APVcQ9XyE0yY=;
        b=CN7Cr1hZClOuhvO6KiVXRGX5u9z6Ymwj8Aaso0uGallRG2JXYNJ6p6WcjXLhNqFBqD
         5oEFk2+dB9oeRY+x+yYGhFhEGRN10QhWX+tIki4udTCumDaTesB1GSQCwbjKOWCG7kzJ
         tz9YS3nxJ8hEm9U5U92j0YQvq2oMndyiid5BD0mGGTQstJuFJtAxom4f0/WhzrvhZ0GC
         e7AVN6Gthy3anbO+AyxHZGKvUGMWvvzmqTIskk8AvuTTbbyLg86txrpcnR8fdSo4V4V+
         OyqtMiBTNfE2j1iqj6dVBCdzp3aPhkkp3qkxDtR85UOefijHma3fVIQtFuMy2/uHUtUJ
         3ONQ==
X-Gm-Message-State: AOAM530IhYZ8jPc6YjCGzmEN/64TP/K1Hgb5jIZdzyfrHopFGMIFQnwh
        xx9bbPSVLoTqBZA4nPOyboE=
X-Google-Smtp-Source: ABdhPJxu+P8IfVf4BSGgDuJr5zuW8t/5lXF7RR+0avvzc+puA/MHEccJyDmyAlMcTJAonWO8cEXspA==
X-Received: by 2002:a17:902:cf0c:b0:15b:63a4:9f47 with SMTP id i12-20020a170902cf0c00b0015b63a49f47mr4963449plg.1.1650639915067;
        Fri, 22 Apr 2022 08:05:15 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:5deb:57fb:7322:f9d4])
        by smtp.gmail.com with ESMTPSA id s11-20020a6550cb000000b0039daee7ed0fsm2390279pgp.19.2022.04.22.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:05:14 -0700 (PDT)
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
Date:   Fri, 22 Apr 2022 08:05:06 -0700
Message-Id: <20220422150507.222488-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
In-Reply-To: <20220422150507.222488-1-namhyung@kernel.org>
References: <20220422150507.222488-1-namhyung@kernel.org>
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
 tools/perf/util/off_cpu.h              |  6 +-
 4 files changed, 123 insertions(+), 15 deletions(-)

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
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index d5e063083bae..9b018d300b6e 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -2,13 +2,15 @@
 #define PERF_UTIL_OFF_CPU_H
 
 struct evlist;
+struct target;
 struct perf_session;
 
 #ifdef HAVE_BPF_SKEL
-int off_cpu_prepare(struct evlist *evlist);
+int off_cpu_prepare(struct evlist *evlist, struct target *target);
 int off_cpu_write(struct perf_session *session);
 #else
-static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused);
+static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused,
+				  struct target *target __maybe_unused);
 {
 	return -1;
 }
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

