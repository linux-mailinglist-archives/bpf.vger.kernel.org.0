Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0752C692
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 00:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiERWrt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiERWrk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 18:47:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12DB14FC8F;
        Wed, 18 May 2022 15:47:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id bh5so3142102plb.6;
        Wed, 18 May 2022 15:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNIxSJPL7uksAJMx/pU2JN81C2HBSsM0y7AnkRhp5zw=;
        b=IFb54PswqhNMOfbXf8vQPkueUIJZnvCMw2Ngi/rD581GYDmAzgUEDLtSx0792bhzbx
         e+pve0X9t8Eek8JFR1A598HKALYuWNDgFlHPiYhL8VYrYLzqNaL8JrlfwnhNjtIFk1Np
         4X3I1+bo3U9TH6Gdndr8E1Bl/cDAwXWPeIiRn8xqzNlQ2Fc+1OLQ2YIKOVkgiHG14WQo
         2VHnABsB/XKkTRwW8BfI/Ow46I+iU/V8trr80amOEyBmoCpCFkkQkxy0ndEouoYKh33L
         1teumz6CmlwuMR7x4/hIA2urAZrG+USvO2ZVPNlEvZ2NjgqBMmGWiKwyTnB7386n1AXd
         lcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GNIxSJPL7uksAJMx/pU2JN81C2HBSsM0y7AnkRhp5zw=;
        b=kV7ESi1jDKriDTNbKWAfYWNRcsB+4gf6ZIkebzPEXP1BLVKM2ezxxk27zwmcTsL0pT
         swnVxWCPJnfcLhKfkWfc+lVHNBCt02LowLazlz620rgScUx+XIzTHp1t5VMMtZrCJVO9
         eya7OyOlNAQbOqeUU0U4COOV58tZ2hnuB1xDWMgylquAq2rjse41mQmNILyXEDYE89ng
         U5ifoJBGByTmsS9p5jZXF7P93AAj/tur/P+P6GT14rSqGGjX9l0Q9l1IPyYM9tpTJNZL
         ZZzKZNxIvzIwHbdJTDqLritfscQVT3zC0OvxqKWoOuGnaGFhHVGNKqWMlneoK4JJaO5J
         qQTQ==
X-Gm-Message-State: AOAM530uiWPLJXoxxJEHityZWOKj0aRJlVAtxG3nu3H578KGgHhXawZh
        coQirM+TnZaL74Ui/zRK/q4=
X-Google-Smtp-Source: ABdhPJyBJDY0NlTKLSW6molk6ZiYvE+eLuBn/Y5rQKWZn4OcGjEsDEca0xpRqvsmPCfXHXoeqb3Ssg==
X-Received: by 2002:a17:902:e74d:b0:15e:94f7:611e with SMTP id p13-20020a170902e74d00b0015e94f7611emr1641543plf.37.1652914054133;
        Wed, 18 May 2022 15:47:34 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:a718:cbfe:31cb:3a04])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b0015e8d4eb2besm2214100plr.264.2022.05.18.15.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:47:33 -0700 (PDT)
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
Subject: [PATCH 5/6] perf record: Add cgroup support for off-cpu profiling
Date:   Wed, 18 May 2022 15:47:24 -0700
Message-Id: <20220518224725.742882-6-namhyung@kernel.org>
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

This covers two different use cases.  The first one is cgroup
filtering given by -G/--cgroup option which controls the off-cpu
profiling for tasks in the given cgroups only.

The other use case is cgroup sampling which is enabled by
--all-cgroups option and it adds PERF_SAMPLE_CGROUP to the sample_type
to set the cgroup id of the task in the sample data.

Example output.

  $ sudo perf record -a --off-cpu --all-cgroups sleep 1

  $ sudo perf report --stdio -s comm,cgroup --call-graph=no
  ...
  # Samples: 144  of event 'offcpu-time'
  # Event count (approx.): 48452045427
  #
  # Children      Self  Command          Cgroup
  # ........  ........  ...............  ..........................................
  #
      61.57%     5.60%  Chrome_ChildIOT  /user.slice/user-657345.slice/user@657345.service/app.slice/...
      29.51%     7.38%  Web Content      /user.slice/user-657345.slice/user@657345.service/app.slice/...
      17.48%     1.59%  Chrome_IOThread  /user.slice/user-657345.slice/user@657345.service/app.slice/...
      16.48%     4.12%  pipewire-pulse   /user.slice/user-657345.slice/user@657345.service/session.slice/...
      14.48%     2.07%  perf             /user.slice/user-657345.slice/user@657345.service/app.slice/...
      14.30%     7.15%  CompositorTileW  /user.slice/user-657345.slice/user@657345.service/app.slice/...
      13.33%     6.67%  Timer            /user.slice/user-657345.slice/user@657345.service/app.slice/...
  ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c            |  2 +-
 tools/perf/util/bpf_off_cpu.c          | 48 ++++++++++++++++++++++++--
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 33 ++++++++++++++++++
 tools/perf/util/off_cpu.h              |  7 ++--
 4 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7f60d2eac0b4..77fa21c2c69f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -907,7 +907,7 @@ static int record__config_text_poke(struct evlist *evlist)
 
 static int record__config_off_cpu(struct record *rec)
 {
-	return off_cpu_prepare(rec->evlist, &rec->opts.target);
+	return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
 }
 
 static bool record__kcore_readable(struct machine *machine)
diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 874856c55101..b73e84a02264 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -5,10 +5,12 @@
 #include "util/evlist.h"
 #include "util/off_cpu.h"
 #include "util/perf-hooks.h"
+#include "util/record.h"
 #include "util/session.h"
 #include "util/target.h"
 #include "util/cpumap.h"
 #include "util/thread_map.h"
+#include "util/cgroup.h"
 #include <bpf/bpf.h>
 
 #include "bpf_skel/off_cpu.skel.h"
@@ -24,6 +26,7 @@ struct off_cpu_key {
 	u32 tgid;
 	u32 stack_id;
 	u32 state;
+	u64 cgroup_id;
 };
 
 union off_cpu_data {
@@ -116,10 +119,11 @@ static void check_sched_switch_args(void)
 	}
 }
 
-int off_cpu_prepare(struct evlist *evlist, struct target *target)
+int off_cpu_prepare(struct evlist *evlist, struct target *target,
+		    struct record_opts *opts)
 {
 	int err, fd, i;
-	int ncpus = 1, ntasks = 1;
+	int ncpus = 1, ntasks = 1, ncgrps = 1;
 
 	if (off_cpu_config(evlist) < 0) {
 		pr_err("Failed to config off-cpu BPF event\n");
@@ -143,6 +147,21 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target)
 		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
 	}
 
+	if (evlist__first(evlist)->cgrp) {
+		ncgrps = evlist->core.nr_entries - 1; /* excluding a dummy */
+		bpf_map__set_max_entries(skel->maps.cgroup_filter, ncgrps);
+
+		if (!cgroup_is_v2("perf_event"))
+			skel->rodata->uses_cgroup_v1 = true;
+	}
+
+	if (opts->record_cgroup) {
+		skel->rodata->needs_cgroup = true;
+
+		if (!cgroup_is_v2("perf_event"))
+			skel->rodata->uses_cgroup_v1 = true;
+	}
+
 	set_max_rlimit();
 	check_sched_switch_args();
 
@@ -178,6 +197,29 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target)
 		}
 	}
 
+	if (evlist__first(evlist)->cgrp) {
+		struct evsel *evsel;
+		u8 val = 1;
+
+		skel->bss->has_cgroup = 1;
+		fd = bpf_map__fd(skel->maps.cgroup_filter);
+
+		evlist__for_each_entry(evlist, evsel) {
+			struct cgroup *cgrp = evsel->cgrp;
+
+			if (cgrp == NULL)
+				continue;
+
+			if (!cgrp->id && read_cgroup_id(cgrp) < 0) {
+				pr_err("Failed to read cgroup id of %s\n",
+				       cgrp->name);
+				goto out;
+			}
+
+			bpf_map_update_elem(fd, &cgrp->id, &val, BPF_ANY);
+		}
+	}
+
 	err = off_cpu_bpf__attach(skel);
 	if (err) {
 		pr_err("Failed to attach off-cpu BPF skeleton\n");
@@ -275,6 +317,8 @@ int off_cpu_write(struct perf_session *session)
 			/* calculate sample callchain data array length */
 			n += len + 2;
 		}
+		if (sample_type & PERF_SAMPLE_CGROUP)
+			data.array[n++] = key.cgroup_id;
 		/* TODO: handle more sample types */
 
 		size = n * sizeof(u64);
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 986d7db6e75d..792ae2847080 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -26,6 +26,7 @@ struct offcpu_key {
 	__u32 tgid;
 	__u32 stack_id;
 	__u32 state;
+	__u64 cgroup_id;
 };
 
 struct {
@@ -63,6 +64,13 @@ struct {
 	__uint(max_entries, 1);
 } task_filter SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u64));
+	__uint(value_size, sizeof(__u8));
+	__uint(max_entries, 1);
+} cgroup_filter SEC(".maps");
+
 /* old kernel task_struct definition */
 struct task_struct___old {
 	long state;
@@ -71,8 +79,11 @@ struct task_struct___old {
 int enabled = 0;
 int has_cpu = 0;
 int has_task = 0;
+int has_cgroup = 0;
 
 const volatile bool has_prev_state = false;
+const volatile bool needs_cgroup = false;
+const volatile bool uses_cgroup_v1 = false;
 
 /*
  * Old kernel used to call it task_struct->state and now it's '__state'.
@@ -92,6 +103,18 @@ static inline int get_task_state(struct task_struct *t)
 	return BPF_CORE_READ(t_old, state);
 }
 
+static inline __u64 get_cgroup_id(struct task_struct *t)
+{
+	struct cgroup *cgrp;
+
+	if (uses_cgroup_v1)
+		cgrp = BPF_CORE_READ(t, cgroups, subsys[perf_event_cgrp_id], cgroup);
+	else
+		cgrp = BPF_CORE_READ(t, cgroups, dfl_cgrp);
+
+	return BPF_CORE_READ(cgrp, kn, id);
+}
+
 static inline int can_record(struct task_struct *t, int state)
 {
 	/* kernel threads don't have user stack */
@@ -120,6 +143,15 @@ static inline int can_record(struct task_struct *t, int state)
 			return 0;
 	}
 
+	if (has_cgroup) {
+		__u8 *ok;
+		__u64 cgrp_id = get_cgroup_id(t);
+
+		ok = bpf_map_lookup_elem(&cgroup_filter, &cgrp_id);
+		if (!ok)
+			return 0;
+	}
+
 	return 1;
 }
 
@@ -156,6 +188,7 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 			.tgid = next->tgid,
 			.stack_id = pelem->stack_id,
 			.state = pelem->state,
+			.cgroup_id = needs_cgroup ? get_cgroup_id(next) : 0,
 		};
 		__u64 delta = ts - pelem->timestamp;
 		__u64 *total;
diff --git a/tools/perf/util/off_cpu.h b/tools/perf/util/off_cpu.h
index f47af0232e55..548008f74d42 100644
--- a/tools/perf/util/off_cpu.h
+++ b/tools/perf/util/off_cpu.h
@@ -4,15 +4,18 @@
 struct evlist;
 struct target;
 struct perf_session;
+struct record_opts;
 
 #define OFFCPU_EVENT  "offcpu-time"
 
 #ifdef HAVE_BPF_SKEL
-int off_cpu_prepare(struct evlist *evlist, struct target *target);
+int off_cpu_prepare(struct evlist *evlist, struct target *target,
+		    struct record_opts *opts);
 int off_cpu_write(struct perf_session *session);
 #else
 static inline int off_cpu_prepare(struct evlist *evlist __maybe_unused,
-				  struct target *target __maybe_unused)
+				  struct target *target __maybe_unused,
+				  struct record_opts *opts __maybe_unused)
 {
 	return -1;
 }
-- 
2.36.1.124.g0e6072fb45-goog

