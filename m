Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF315906A5
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 21:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiHKSzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 14:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiHKSzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 14:55:03 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68DF9E2E5;
        Thu, 11 Aug 2022 11:55:02 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r69so11319691pgr.2;
        Thu, 11 Aug 2022 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=WtJpt6VjUpmNbd0Og7BJIOmYxw2DFH3snhDEN9l99a0=;
        b=TKvT2eZoIF4Er8ODkh9Scdq5A7tQtynpOVTBi0Yfc/eP0ohZ9E+jTc1rMZzqXgp0ku
         CgD6Z1ZO3IeHH1l9rsN077LAV/GVipoxncuWpqJaOzQoFhCxKcblvIa66mam3riG4jpn
         qBw2xSPd+1G/6cGrPb2/Cpnr/PCcDNDy+s1oE72ooyeA0tGjGO0DHJt6pa1y+qQGZhmk
         ugiDvX9bEJL5lwWEGKCFLhgb8+luyRPIlWW6ZoDngSM0H7XaXXTroq2MAqcELleVPNbG
         p3jK/bM1/nVuhh9D7bTIvqeqe5yb185088cRlCXF37HUytrBLB8UfKHejduMtWQ95oYL
         zotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=WtJpt6VjUpmNbd0Og7BJIOmYxw2DFH3snhDEN9l99a0=;
        b=ZQ9G7abceKPbKMyFtMhttEQQVZDrzNrSX8p5aDktvU14B74d4HHNTAWIE/rOQygPEB
         O8U9Rl0eg9hoGiL5IYjeNWFEAJnmDKV9kMHGVETW+mYifye0jiVdQe2XVFJ2qF8w78NH
         4TuY2X+1A40H1F10T8pYlECYPYdcKSOygAp9jLMJMAseKxA26xFz9UPzW0/yVb2ki1in
         EZKu0CFkGeRd2fab7EQDM6RkouIvp6CcVn6l/Ws+pa0M5Izf54w92TQ8Qk7EidYYxt+M
         IpKmP8zBWZtr3qSfALN6kUgZWOpGJXCXUIgsfrwvKImdyoT2cxq9Nb9FT6Ps/aBjts3n
         O5gQ==
X-Gm-Message-State: ACgBeo2c2X+SLgsrs7/VN5vM3vbI3d7YU2Evji1jdyq6jLHh0eG741YJ
        kqZfS6Xm/vOqfOOU1zFYBh8=
X-Google-Smtp-Source: AA6agR7+6aoUVKsVdYjJMX77vmkDYuDzq2vWas4Rjt3TB6S1REeANJI2K+AMGJHrCStnpj9MJ5bW1w==
X-Received: by 2002:a63:4948:0:b0:41c:d9ed:72d7 with SMTP id y8-20020a634948000000b0041cd9ed72d7mr324892pgk.246.1660244102266;
        Thu, 11 Aug 2022 11:55:02 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cefb:475d:dd6d:a1e2])
        by smtp.gmail.com with ESMTPSA id r12-20020a6560cc000000b0041975999455sm66314pgv.75.2022.08.11.11.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:55:01 -0700 (PDT)
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
Subject: [PATCH 1/4] perf offcpu: Check process id for the given workload
Date:   Thu, 11 Aug 2022 11:54:53 -0700
Message-Id: <20220811185456.194721-2-namhyung@kernel.org>
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

Current task filter checks task->pid which is different for each
thread.  But we want to profile all the threads in the process.  So
let's compare process id (or thread-group id: tgid) instead.

Before:
  $ sudo perf record --off-cpu -- perf bench sched messaging -t
  $ sudo perf report --stat | grep -A1 offcpu
  offcpu-time stats:
            SAMPLE events:        2

After:
  $ sudo perf record --off-cpu -- perf bench sched messaging -t
  $ sudo perf report --stat | grep -A1 offcpu
  offcpu-time stats:
            SAMPLE events:      850

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c          | 1 +
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index f289b7713598..7dbcb025da87 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -78,6 +78,7 @@ static void off_cpu_start(void *arg)
 		u8 val = 1;
 
 		skel->bss->has_task = 1;
+		skel->bss->uses_tgid = 1;
 		fd = bpf_map__fd(skel->maps.task_filter);
 		pid = perf_thread_map__pid(evlist->core.threads, 0);
 		bpf_map_update_elem(fd, &pid, &val, BPF_ANY);
diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf_skel/off_cpu.bpf.c
index cc6d7fd55118..143a8b7acf87 100644
--- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
+++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
@@ -85,6 +85,7 @@ int enabled = 0;
 int has_cpu = 0;
 int has_task = 0;
 int has_cgroup = 0;
+int uses_tgid = 0;
 
 const volatile bool has_prev_state = false;
 const volatile bool needs_cgroup = false;
@@ -144,7 +145,12 @@ static inline int can_record(struct task_struct *t, int state)
 
 	if (has_task) {
 		__u8 *ok;
-		__u32 pid = t->pid;
+		__u32 pid;
+
+		if (uses_tgid)
+			pid = t->tgid;
+		else
+			pid = t->pid;
 
 		ok = bpf_map_lookup_elem(&task_filter, &pid);
 		if (!ok)
-- 
2.37.1.595.g718a3a8f04-goog

