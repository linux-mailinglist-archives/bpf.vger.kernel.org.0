Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D3851E007
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 22:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442345AbiEFUUV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 16:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442229AbiEFUUU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 16:20:20 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D16623A;
        Fri,  6 May 2022 13:16:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e24so7959714pjt.2;
        Fri, 06 May 2022 13:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2EyyhftSoRxaWVuV8cJi4YZ+Ok2YzcnoV0luuIHn0S0=;
        b=oGj4iJ9vqFHoG1R4Pp0EWdZAtUkW3VqrbTKKuGLuzZ86cKqwOdQO/I8mDN0vkqn67U
         vkJviyHizuZ1blNP5dVezLmhkujFdBBvWJGWfKorJD7/vRUuENqspWPWFT/dfenZxvAk
         uLi2XfhOtdA0bOrqYqbUHkvjHtXgpgV7udJMotGnC/tS2/waQETB4vSmKctcPdeNImyW
         h6TTzad1xx6CQCAmmeYPTM+YIEJpVJRNsEsCoYPPorO1RVTjUEUih2wgC2lcerRrrSMA
         zL50j4ZSjB9CmW09WBiGePdHlBleqtXz1VW9nTQkFN4EcVHmYHcXASfNGlhKoK8huYrD
         z6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2EyyhftSoRxaWVuV8cJi4YZ+Ok2YzcnoV0luuIHn0S0=;
        b=BwDGwNRbgSDvmoCyB1TFsr2YiDwPilZyVyXyOZ9ZMG0DW+cbue//cZjwwWU3DT2AMf
         MGBj2ZYwkcZUbMccOX4jqPF6r/1C3SgIoQw81bpqp1nkWWoW4Bw3JeTcbOF0gC/sShd+
         fBQ3q+8XDI3z6sCHyupHehaUTJ7V7FRy8xeaneUa6sbnf3n4zkEfvlzgJjQD4hrU60+I
         8aTU0J4QyPj8MKRmcKsiWAbfWy5IGd+OBFLxES+PQrdHr6NczfaSSfKunYL48GtWJIoK
         rA22xrVO8XaNjiAAD6Gc+DU0xJ7uhZrqFkGou3PhBNthWwqUvQVJfsGf/7wDbDNDKggh
         tAAQ==
X-Gm-Message-State: AOAM531SwvzoPtUce6+NfzvzLFwH5HAKSUB/BcVFwoRN6AEwXHp0g1D+
        M9ItsmNO6nI5MfZY7ZvKZyo=
X-Google-Smtp-Source: ABdhPJwy3PjhjOhTR7pEpj5rSgVPOT4b4d68euOKBFUdZJse214qWoh4Xl5aqEf3EJxk/583tWJmOQ==
X-Received: by 2002:a17:903:240a:b0:14e:dad4:5ce4 with SMTP id e10-20020a170903240a00b0014edad45ce4mr5443166plo.125.1651868194896;
        Fri, 06 May 2022 13:16:34 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:a5d1:d7b7:dd61:c87b])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db8200b0015e8d4eb268sm2160156pld.178.2022.05.06.13.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:16:34 -0700 (PDT)
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
Subject: [PATCH 3/4] perf record: Implement basic filtering for off-cpu
Date:   Fri,  6 May 2022 13:16:26 -0700
Message-Id: <20220506201627.85598-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
In-Reply-To: <20220506201627.85598-1-namhyung@kernel.org>
References: <20220506201627.85598-1-namhyung@kernel.org>
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
index 4e0285ca9a2d..c9b78e2b74bb 100644
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
index 5173ed882fdf..c35106b9e20b 100644
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
index 4113bd19a2e4..864d6148dfd3 100644
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
-static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused)
+static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused,
+				  struct target *target __maybe_unused)
 {
 	return -1;
 }
-- 
2.36.0.512.ge40c2bad7a-goog

