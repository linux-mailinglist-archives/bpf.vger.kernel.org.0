Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D5355A4B0
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 01:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiFXXNW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 19:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiFXXNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 19:13:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E70568C65;
        Fri, 24 Jun 2022 16:13:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p5so4084632pjt.2;
        Fri, 24 Jun 2022 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KnJPmaWlDToBQM9U1zQwBdQVyYPeGOmIGquterwrDgQ=;
        b=NyHJ6KnqeEYbiRDXNNwB/Hl99JnyaaKg+UeEor8xdy8cxSXKYN5YBhBjeHJnwF3Oql
         es5pT1vWqm7Uo12Dm+k1RVxfr8g+Kdyvm1qKSKvMSodtYUMFthY3smGCzGTLVpPOeHMO
         84Vj0crGq5REhD0bNeEmIMyLJSZQQF0G5DRClun6esMJPAdAj3ZZKgiPNEPgclRdrMHY
         4x4E9eF+TFKlYimZ8TuB6PmtOBn3HPM2a0iqxAZ+A+w3pv0hFNLi7dyVV7FO/RxrSIKz
         tz8Ohlmq1JEJzwqOhO+7NUXDsByX2cJB089ZO1Zuo338fShojIWb+llpt72oHRdE5TeK
         6t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KnJPmaWlDToBQM9U1zQwBdQVyYPeGOmIGquterwrDgQ=;
        b=CmNcVX3qaSCacGiBixEjkbqT0atGejlaWgH3eGeIuCTbkkbT3jaNLB9RJbpQR67prT
         mY2yCW5+OI7twTY7A4CX2lksg6GIc5+ngAp38/0wl2DrP0sTzYpzQR/5xd66gZxW67+A
         qzQo1yVbQSutok5r1JmAC+yy5Yj+a6yyYToQJb8sS3mtB8dkhpk8H/QJyE3J63X18wr7
         2NRmoeh8gjEtXn4wg8bCCrLr1Od9wqHgSs9PlQLcPrSFb3C86ZxajQGLyNVtspOTWcBm
         u89nWPu7Ytpoo/rccDxI6LQdoGsN5axv07soPckAuSDDH+tJMf/lQSE8T4vcgdXOxVDc
         +zaA==
X-Gm-Message-State: AJIora8C5rgPw7VEr0Tti8rG5McAHe7jiHvkkirdGZcbnVJcpOkgbAxy
        g+pY07H5M3DFknJb4CLoDGA=
X-Google-Smtp-Source: AGRyM1vC1y8UQDdJI2oy2FLHKigAIUXDcRpHOl/PFjAWrSkCf/tXEt5wZ/xlwQ880SPuHRl/Lb7Bqg==
X-Received: by 2002:a17:902:d586:b0:16a:24de:1964 with SMTP id k6-20020a170902d58600b0016a24de1964mr1519723plh.4.1656112399024;
        Fri, 24 Jun 2022 16:13:19 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:eeb0:3156:8fd:28f6])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b0050dc76281e0sm2242439pfe.186.2022.06.24.16.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:13:18 -0700 (PDT)
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
Subject: [PATCH 3/6] perf offcpu: Check process id for the given workload
Date:   Fri, 24 Jun 2022 16:13:10 -0700
Message-Id: <20220624231313.367909-4-namhyung@kernel.org>
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
2.37.0.rc0.161.g10f37bed90-goog

