Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A1752C69D
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 00:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiERWrm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiERWrg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 18:47:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36801F68A7;
        Wed, 18 May 2022 15:47:32 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h186so3428394pgc.3;
        Wed, 18 May 2022 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/vKyzls7syv00DbTMSXJKHt/yE06QGrFeT+BAiim5I=;
        b=B+PqxvLVuo7JR62fdK74JSKwXF0yOd8vPTRoOe7kLQPrv2EAkm8iGEv7UkD9s2Lsaq
         kT3hV15fEuBypK8aZnQfFF8ZLBGGHSKAbpYfymFEC50tLgzx6ORuOZUOE1KFeEaXhz6D
         Xu1UU2K3R38oPWFQIb4M4ffJLWX2dKuZ4tF6BHtUtdcIIkCFlYVTJdlk4lht/NN/OFno
         3J/HxwGmk7hukbcxOIYuzOxvJ8//6bHzhaIypYZrRntxd9osRqYc+XMIDYNiJiwU3f/Y
         BybVYK0MAZPLf1LExTjp0bybT9vWImwmc+EIfK4kcE4e3ZFppgoZ0hn/FEfBnGFvt4Qb
         /v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6/vKyzls7syv00DbTMSXJKHt/yE06QGrFeT+BAiim5I=;
        b=aY5ZJULj4aRrgKSI+HO5mdznOTeKcEDoztmjwRf8HCHdT3x8aCr42MtieMeEo/5BIF
         3lu+Go+gz9svxmUdN/xOOifM8Wip0jETThAiwn3njuKGjYjlJxmjU5UNC6kHWvsQyMak
         Sk2fCvyA4Tt+kOJhmiIFUDFoQk7cBB9CXEW/7w+vMTTwG+7mwmOGzNkiqXxhPJnYwWsH
         0dwyyWHq3HGxhXlf6oHrPLjDB6YtWs6pfG26Q6gT8vNXBCjn9mO/WfsQWW+v54OjHzov
         MN49eym89IUCJrGtOyCjJfo4QEYvYmxmk57Tm7joQw+bMTZupu8aWWJ2dTBAQk+uCBY5
         fRrQ==
X-Gm-Message-State: AOAM53069WcZ7er3mowboEVfXDzzPdGAm227nEMLCascJCxfL5C1gX53
        gPNuoJueHK7kr09tAIqDq7U=
X-Google-Smtp-Source: ABdhPJxv8Q2CtbizcugUZbgc+ae3NHGmBDrEGzA2CQleVUsGJPaMd94wAq20h9xVRFiR6JP4Sopidg==
X-Received: by 2002:a63:5f4a:0:b0:3f5:d34e:dd44 with SMTP id t71-20020a635f4a000000b003f5d34edd44mr1346184pgb.567.1652914051587;
        Wed, 18 May 2022 15:47:31 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:a718:cbfe:31cb:3a04])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b0015e8d4eb2besm2214100plr.264.2022.05.18.15.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:47:31 -0700 (PDT)
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
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 3/6] perf record: Implement basic filtering for off-cpu
Date:   Wed, 18 May 2022 15:47:22 -0700
Message-Id: <20220518224725.742882-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220518224725.742882-1-namhyung@kernel.org>
References: <20220518224725.742882-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
index 91f88501412e..7f60d2eac0b4 100644
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
index 9ed7aca3f4ac..b5e2d038da50 100644
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
@@ -60,8 +63,23 @@ static int off_cpu_config(struct evlist *evlist)
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
 
@@ -71,31 +89,75 @@ static void off_cpu_finish(void *arg __maybe_unused)
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
 		pr_err("Failed to open off-cpu BPF skeleton\n");
 		return -1;
 	}
 
+	/* don't need to set cpu filter for system-wide mode */
+	if (target->cpu_list) {
+		ncpus = perf_cpu_map__nr(evlist->core.user_requested_cpus);
+		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
+	}
+
+	if (target__has_task(target)) {
+		ntasks = perf_thread_map__nr(evlist->core.threads);
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
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
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
index 5173ed882fdf..78cdcc8ff863 100644
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
  * Old kernel used to call it task_struct->state and now it's '__state'.
@@ -74,6 +90,37 @@ static inline int get_task_state(struct task_struct *t)
 	return BPF_CORE_READ(t_old, state);
 }
 
+static inline int can_record(struct task_struct *t, int state)
+{
+	/* kernel threads don't have user stack */
+	if (t->flags & PF_KTHREAD)
+		return 0;
+
+	if (state != TASK_INTERRUPTIBLE &&
+	    state != TASK_UNINTERRUPTIBLE)
+		return 0;
+
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
index 375d03c424ea..f47af0232e55 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -2,15 +2,17 @@
 #define PERF_UTIL_OFF_CPU_H
 
 struct evlist;
+struct target;
 struct perf_session;
 
 #define OFFCPU_EVENT  "offcpu-time"
 
 #ifdef HAVE_BPF_SKEL
-int off_cpu_prepare(struct evlist *evlist);
+int off_cpu_prepare(struct evlist *evlist, struct target *target);
 int off_cpu_write(struct perf_session *session);
 #else
-static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused)
+static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused,
+				  struct target *target __maybe_unused)
 {
 	return -1;
 }
-- 
2.36.1.124.g0e6072fb45-goog

