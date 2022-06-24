Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA2055A4B1
	for <lists+bpf@lfdr.de>; Sat, 25 Jun 2022 01:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiFXXNX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiFXXNV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 19:13:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B77668E;
        Fri, 24 Jun 2022 16:13:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c205so3758013pfc.7;
        Fri, 24 Jun 2022 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkmjmN6FSfnJmt1stt/Bkpj+lZFeEf2ciR698Soh71w=;
        b=kcNAwSdGS5B3ObxhoRUCdgUdB4mir2HdpBJLtpiXUlHUBSBjpTC+3IC/UDbBuOnKCu
         yrJMn+I7cTuPil+3OhcFZDQOYICZVG61ck1C3a15nE5D/t0oZRooo0/4hyWG4yc/To6t
         TvqdOB0LUycVxXv7xbLfGeGudUIXQxrzSZL35s57N9EDD+EhxQyaLl5JxltR7zyiLpsi
         v+FYQIAwHAuQL4s+yk9ge4CFABEegBweVKPFL5AA0fm3N7MUoS6p2QLNXC19T4VmBLXh
         USifhSrNXdCcrCvzA9E7KxAuTQAXa2SZ0YHDe0sqXVHM6am3ySyPxC+CTG5UkKXZIMVJ
         9+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NkmjmN6FSfnJmt1stt/Bkpj+lZFeEf2ciR698Soh71w=;
        b=rG9NxDh/rI+Z0439DsDCOYfa2D03z9blJePOVbXTUYiHTi6XFmUHn8rfyV6WIANp1c
         kHZ969N4ESZxzuTb6LlufXMX2XIfXsE8/KW5cq/d5o7NWu5n0e8haG/6C6v2crongoXK
         JyWgLGs8RCVqIfOGIZAoou5zJe/hWctH05N/fZWmel0IKIh4f868Xa7/BOiv0TeqyKvO
         xK8pjcL/D/6AK7a+Us6DmwOi9fgxdzUNv3ENR2bhdf5yPnxQV6dDFJfmuJPyhnvoD3zr
         g2+vn50kwZFSCursJUGebLTi5sO9vlSQ0TlfhdG3kQJ/SyNFWAgBPFpekOAPDC3rCzds
         4AcA==
X-Gm-Message-State: AJIora+ygj60/0qM9Na8m48yQwwKx3+FiTMRIRjPzV0YQ6i5i7r2pNnW
        BFkTt1jjWj365Y3pIqhLQzg=
X-Google-Smtp-Source: AGRyM1sayYWpHceCnF7iUf4+huMUBB9FIaWEm+yuQFAXbepaGDm1CsdFqkkbXwisPPjJM3n9MtmhgA==
X-Received: by 2002:a63:380f:0:b0:40c:67ae:91ad with SMTP id f15-20020a63380f000000b0040c67ae91admr1047766pga.544.1656112400193;
        Fri, 24 Jun 2022 16:13:20 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:480:eeb0:3156:8fd:28f6])
        by smtp.gmail.com with ESMTPSA id z19-20020aa78893000000b0050dc76281e0sm2242439pfe.186.2022.06.24.16.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:13:19 -0700 (PDT)
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
Subject: [PATCH 4/6] perf offcpu: Parse process id separately
Date:   Fri, 24 Jun 2022 16:13:11 -0700
Message-Id: <20220624231313.367909-5-namhyung@kernel.org>
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

The current target code uses thread id for tracking tasks because
perf_events need to be opened for each task.  But we can use tgid in
BPF maps and check it easily.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_off_cpu.c | 45 +++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cpu.c
index 7dbcb025da87..f7ee0c7a53f0 100644
--- a/tools/perf/util/bpf_off_cpu.c
+++ b/tools/perf/util/bpf_off_cpu.c
@@ -11,6 +11,7 @@
 #include "util/cpumap.h"
 #include "util/thread_map.h"
 #include "util/cgroup.h"
+#include "util/strlist.h"
 #include <bpf/bpf.h>
 
 #include "bpf_skel/off_cpu.skel.h"
@@ -125,6 +126,8 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 {
 	int err, fd, i;
 	int ncpus = 1, ntasks = 1, ncgrps = 1;
+	struct strlist *pid_slist = NULL;
+	struct str_node *pos;
 
 	if (off_cpu_config(evlist) < 0) {
 		pr_err("Failed to config off-cpu BPF event\n");
@@ -143,7 +146,26 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		bpf_map__set_max_entries(skel->maps.cpu_filter, ncpus);
 	}
 
-	if (target__has_task(target)) {
+	if (target->pid) {
+		pid_slist = strlist__new(target->pid, NULL);
+		if (!pid_slist) {
+			pr_err("Failed to create a strlist for pid\n");
+			return -1;
+		}
+
+		ntasks = 0;
+		strlist__for_each_entry(pos, pid_slist) {
+			char *end_ptr;
+			int pid = strtol(pos->s, &end_ptr, 10);
+
+			if (pid == INT_MIN || pid == INT_MAX ||
+			    (*end_ptr != '\0' && *end_ptr != ','))
+				continue;
+
+			ntasks++;
+		}
+		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
+	} else if (target__has_task(target)) {
 		ntasks = perf_thread_map__nr(evlist->core.threads);
 		bpf_map__set_max_entries(skel->maps.task_filter, ntasks);
 	}
@@ -185,7 +207,26 @@ int off_cpu_prepare(struct evlist *evlist, struct target *target,
 		}
 	}
 
-	if (target__has_task(target)) {
+	if (target->pid) {
+		u8 val = 1;
+
+		skel->bss->has_task = 1;
+		skel->bss->uses_tgid = 1;
+		fd = bpf_map__fd(skel->maps.task_filter);
+
+		strlist__for_each_entry(pos, pid_slist) {
+			char *end_ptr;
+			u32 tgid;
+			int pid = strtol(pos->s, &end_ptr, 10);
+
+			if (pid == INT_MIN || pid == INT_MAX ||
+			    (*end_ptr != '\0' && *end_ptr != ','))
+				continue;
+
+			tgid = pid;
+			bpf_map_update_elem(fd, &tgid, &val, BPF_ANY);
+		}
+	} else if (target__has_task(target)) {
 		u32 pid;
 		u8 val = 1;
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

