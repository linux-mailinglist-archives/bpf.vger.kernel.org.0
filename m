Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B0B5906AA
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 21:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiHKSzJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiHKSzH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 14:55:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9421B9E2E7;
        Thu, 11 Aug 2022 11:55:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q19so17233948pfg.8;
        Thu, 11 Aug 2022 11:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=lCwq5ptfVT6LA/OJ3S7YeqvIhPQ7ZVzO5sJK2ii/XJA=;
        b=PuQje8v+mJN+T9RJtHJg/4IQ6kE3CnrzpBouN5NWQjC1Rkxwdtyp/to31A4iovW4Zx
         PXmk1IBFBXidjjRwPUmJsbzS4ITqDd6Ennt96eyM4xXvkzNMSz1yNKN0xYNZfZIIlKVU
         YqcK9ljrRJ0xn4vEiSqxeo4shdpYEtOrS1VgjZ97JBquwqlRjuxN1ntMsJyVIcUpQ9bx
         zhxMdUbLjrGMJtnp8CO8l5qTyzcs90YF233w6TfVBs377aXQ1VQuyccCKFG8ME/fzjE1
         GeqFj3lKggIMbD98X/vbvP7Xe0JLBT90RKjCh9bMznwqk+hd/4pCq0S+3Fsk4JjTKgEj
         xh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=lCwq5ptfVT6LA/OJ3S7YeqvIhPQ7ZVzO5sJK2ii/XJA=;
        b=VAHy5MCdbzodV4rCflaJKdKjSbgWDOTdoij/z8jc0U5nFjNB6QKNDoRFwUHGLwBajb
         cyTm32/V5gCoGaOyIrvVB/RN0OZwx2TRTMxaN29qJ314yoiGYo8aUjdj7LiIfUiT+rxZ
         4tlyURsLD4eOBST3tILSeJdNypfNO3Wp30pV9ppn34uxezli7lQnILTH9pyg3nNCidk7
         8F3zTkMgIY6bJPJo3avYMX28mOsifa31diWR3Ul8ek0vvaGtocprQZ2RAfos/cOeJqPt
         fS9pSFkrMcYOZbovSdo09z2vVCUnf4s10dM3tItfrZjSFQiKTN0gMLtuJe9HjF5vDJBX
         +iSA==
X-Gm-Message-State: ACgBeo1MnTw0BuvQXmIwBXwptmI3LKWtORfOrbdtme7h6rhimi8b1vxu
        bOf7yEEwoiNfLF1kJ6ZL554=
X-Google-Smtp-Source: AA6agR6CzMsUihjP+aqaSObhyzOI/xQIfPZO3KdsCjV3xCSULFBtq6xYSXZnZojXiCGKh/k1adIfNg==
X-Received: by 2002:a63:8bc8:0:b0:41c:6800:d4e9 with SMTP id j191-20020a638bc8000000b0041c6800d4e9mr300643pge.45.1660244105953;
        Thu, 11 Aug 2022 11:55:05 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cefb:475d:dd6d:a1e2])
        by smtp.gmail.com with ESMTPSA id r12-20020a6560cc000000b0041975999455sm66314pgv.75.2022.08.11.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:55:05 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Blake Jones <blakejones@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org
Subject: [PATCH 3/4] perf offcpu: Track child processes
Date:   Thu, 11 Aug 2022 11:54:55 -0700
Message-Id: <20220811185456.194721-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220811185456.194721-1-namhyung@kernel.org>
References: <20220811185456.194721-1-namhyung@kernel.org>
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
2.37.1.595.g718a3a8f04-goog

