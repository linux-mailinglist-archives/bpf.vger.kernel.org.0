Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823EE55A4B6
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 01:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiFXXNa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 19:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiFXXNX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 19:13:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDAA69999;
        Fri, 24 Jun 2022 16:13:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l2so2888048pjf.1;
        Fri, 24 Jun 2022 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dazC7TPyX4UMs7r+xqJJNBPVEDPVKb6BSLrk7hWQB1s=;
        b=Cn1BUdNqjGwnV6Ct77HE2u31hBD0aEauc1RcVcUw5C997bVzfHnJRVNb5EUxpwxjc2
         VNKL5E4DFLMjXL/9HIk3XdOPxWKYye7gou97s10dttVQAJY4upglVa+BT6vtRpwLC/av
         clqYxzVK/XTUlpTIUUbCpUoI5l6tMQkKmwHRFthZqP4AXLGjz6uUsAFAlRxCroFM8g7Y
         dAUMVDVbAHiUyj9V7dL194TjW0anFxVzMHm8MADtqqcbfvpQTXAl6QFUnBq72by14Zih
         NQVa55oFDNe0niQ0AGprN+TvJy2K+5m47GtaIAb56iBenviyj2xp810VvSs8GjN8E/yl
         g3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dazC7TPyX4UMs7r+xqJJNBPVEDPVKb6BSLrk7hWQB1s=;
        b=jymjZS8qW+WksIDkz62N+Y7y1UbgTGCGFFnwjKv1CsPbPpxZ/T2GfTLr0dtAchlMyo
         7C7+JK7pN1GP+ZpYec06uz/m3/MUTTJC9yPO6749IyB0rhv3KyvZt91KejRLfpIYAJnR
         iuinRuZLrtgogjY/VVemj+WWaobYd1BX8y9WYHl+FoZc+m5zxQj+VLun58owhoCdeKBM
         sHXTLR28C+GOZp5JW2L/V3T2+H9yOkwPH7A7K/GWTkJtSYDmmLOWrhbLs9zeum1moE8O
         KNRq+dV4xGBNByQ0jZLoEPcJ6BYx5Mxs896qjNcYSuyKuEdDwjldwbhY2L0e+C61L2aJ
         YnBw==
X-Gm-Message-State: AJIora/1ORH1MF6fdB+QhoDjy0Zw63lsrgFw4EAT3PCmzEQveVMKZpPH
        MqHCIWT2IKo2b1fTFLmktEw=
X-Google-Smtp-Source: AGRyM1vyBynoQjkTMnlXV2HF0vYM2fkcbLXBHJu+/G0mnw5G4tHCHEhOh8+zMQ7ldm8mPl8yXx8WMw==
X-Received: by 2002:a17:903:2447:b0:16a:3b58:48dd with SMTP id l7-20020a170903244700b0016a3b5848ddmr1467413pls.120.1656112401325;
        Fri, 24 Jun 2022 16:13:21 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:eeb0:3156:8fd:28f6])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b0050dc76281e0sm2242439pfe.186.2022.06.24.16.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:13:21 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [PATCH 5/6] perf offcpu: Track child processes
Date:   Fri, 24 Jun 2022 16:13:12 -0700
Message-Id: <20220624231313.367909-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220624231313.367909-1-namhyung@kernel.org>
References: <20220624231313.367909-1-namhyung@kernel.org>
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

When -p option used or a workload is given, it needs to handle child
processes.  The perf_event can inherit those task events
automatically.  We can add a new BPF program in task_newtask
tracepoint to track child processes.

Before:
  $ sudo perf record --off-cpu -- perf bench sched messaging
  $ sudo perf report --stat | grep -A1 offcpu
  offcpu-time stats:
            SAMPLE events:        1

After:
  $ sudo perf record -a --off-cpu -- perf bench sched messaging
  $ sudo perf report --stat | grep -A1 offcpu
  offcpu-time stats:
            SAMPLE events:      856

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c          |  7 ++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 30 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index f7ee0c7a53f0..c257813e674e 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -17,6 +17,7 @@
 #include "bpf_skel/off_cpu.skel.h"
 
 #define MAX_STACKS  32
+#define MAX_PROC  4096
 /* we don't need actual timestamp, just want to put the samples at last */
 #define OFF_CPU_TIMESTAMP  (~0ull << 32)
 
@@ -164,10 +165,16 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 
 			ntasks++;
 		}
+
+		if (ntasks < MAX_PROC)
+			ntasks = MAX_PROC;
+
 		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
 	} else if (target__has_task(target)) {
 		ntasks = perf_thread_map__nr(evlist->core.threads);
 		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+	} else if (target__none(target)) {
+		bpf_map__set_max_entries(skel->maps.task_filter, MAX_PROC);
 	}
 
 	if (evlist__first(evlist)->cgrp) {
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index 143a8b7acf87..c4ba2bcf179f 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -12,6 +12,9 @@
 #define TASK_INTERRUPTIBLE	0x0001
 #define TASK_UNINTERRUPTIBLE	0x0002
 
+/* create a new thread */
+#define CLONE_THREAD  0x10000
+
 #define MAX_STACKS   32
 #define MAX_ENTRIES  102400
 
@@ -220,6 +223,33 @@ static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+int on_newtask(u64 *ctx)
+{
+	struct task_struct *task;
+	u64 clone_flags;
+	u32 pid;
+	u8 val = 1;
+
+	if (!uses_tgid)
+		return 0;
+
+	task = (struct task_struct *)bpf_get_current_task();
+
+	pid = BPF_CORE_READ(task, tgid);
+	if (!bpf_map_lookup_elem(&task_filter, &pid))
+		return 0;
+
+	task = (struct task_struct *)ctx[0];
+	clone_flags = ctx[1];
+
+	pid = task->tgid;
+	if (!(clone_flags & CLONE_THREAD))
+		bpf_map_update_elem(&task_filter, &pid, &val, BPF_NOEXIST);
+
+	return 0;
+}
+
 SEC("tp_btf/sched_switch")
 int on_switch(u64 *ctx)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

