Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874A965CD48
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 07:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjADGoZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 01:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbjADGoL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 01:44:11 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149232E5;
        Tue,  3 Jan 2023 22:44:11 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a30so6550984pfr.6;
        Tue, 03 Jan 2023 22:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cgcHCT3G9N5bTmGeqZ7j5U+CmWU3a6ei0Q30f2GNqI=;
        b=H4XigTn/KLhd6ZcA1McBlsmhzTWkRx7D+UVTw8GwUYTqFDz3RaJToZj0GC9EQNCsl9
         7hNBQ2S0GOYoQYJyZJTz/KLsD0RZwG9XIwHf+5VTu8lx0+YA2LP3u5zumDRUAsf1Qnyi
         FUJZgIGolIhocllM3NyrARFA/PJ2naa4TT4ipJTu4Rv76MOyU6HVPuG8ZEEiBB08wqTz
         gRjKhdzIZVBcH6hgWIYohNzA7Dz20vBQet+V4U0eZ6bDH3kZmJSbMAJKOYViwYeuIffU
         6VR1ypLTxSiAZ40307j6IfxmskOQHHQSOkjfhSWVUgPZO7ND9PTfAbUq7RJBL7tPmxHr
         d99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4cgcHCT3G9N5bTmGeqZ7j5U+CmWU3a6ei0Q30f2GNqI=;
        b=AXt0keKTznIBlU5DvsUcVCV8G3PTb9OC/LM9oMlgyyKcUTjAGtQqQzFu0fiCwsyupx
         a5RHzeHPrN6gzEoxNKJsKGW2MBN6uMveUS5wcylnzSlIfl+afO5TlfrWbLl8eqDe8lQG
         G3W8uHbqXGMGDdT7BnyZO4u6yT22HR0KjQOG3q9g1pwEWtvhO2MRxO20iTWr48nzloKy
         sC0hcF3rpDtVNMbs4lfkVOOclLu10B5NzNzovV7fTBKf8v5eKwbG1GN2sjCJvXCO01BE
         I/2e55Zwpr/DqEjt69dNxx1SIJrpeJT/iqp/wBmaMI+yQwvdJNlWQCMhRUTBn/iBP6Ow
         TlTw==
X-Gm-Message-State: AFqh2kqzQHTvcYuzO/RgryoW6RZINTZSEWzapro/8vbqxATvzSCKT5S/
        UYz6FM4uSPRk3CNYMdnZqWY=
X-Google-Smtp-Source: AMrXdXtMxebpv/nZ2uvkGSrllvMdXKVtPGNELstI0HkNaA27TNkom7A8iCa4bGKDte7kZLdqu3mmFg==
X-Received: by 2002:a62:32c3:0:b0:580:f1b0:2211 with SMTP id y186-20020a6232c3000000b00580f1b02211mr32038887pfy.18.1672814650468;
        Tue, 03 Jan 2023 22:44:10 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:d1f4:a47f:3a41:e1a2])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b00576f7bd92cdsm11829257pfj.14.2023.01.03.22.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:44:09 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Subject: [PATCH 3/4] perf bpf_counter: Handle unsupported cgroup events
Date:   Tue,  3 Jan 2023 22:44:01 -0800
Message-Id: <20230104064402.1551516-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230104064402.1551516-1-namhyung@kernel.org>
References: <20230104064402.1551516-1-namhyung@kernel.org>
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

When --for-each-cgroup option is used, it failed when any of events is not
supported and it exited immediately.  This is not how perf stat handles the
unsupported events.  Let's ignore the failure and proceed with others.

Before:
  $ sudo ./perf stat -a --bpf-counters -e L1-icache-loads,L1-dcache-loads \
  > --for-each-cgroup system.slice,user.slice  sleep 1
  Failed to open first cgroup events

After:
  $ sudo ./perf stat -a --bpf-counters -e L1-icache-loads,L1-dcache-loads \
  > --for-each-cgroup system.slice,user.slice  sleep 1

   Performance counter stats for 'system wide':

     <not supported>      L1-icache-loads                  system.slice
          29,892,418      L1-dcache-loads                  system.slice
     <not supported>      L1-icache-loads                  user.slice
          52,497,220      L1-dcache-loads                  user.slice

Fixes: 944138f048f7d ("perf stat: Enable BPF counter with --for-each-cgroup")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter_cgroup.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 3c2df7522f6f..1c82377ed78b 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -116,27 +116,19 @@ static int bperf_load_program(struct evlist *evlist)
 
 			/* open single copy of the events w/o cgroup */
 			err = evsel__open_per_cpu(evsel, evsel->core.cpus, -1);
-			if (err) {
-				pr_err("Failed to open first cgroup events\n");
-				goto out;
-			}
+			if (err == 0)
+				evsel->supported = true;
 
 			map_fd = bpf_map__fd(skel->maps.events);
 			perf_cpu_map__for_each_cpu(cpu, j, evsel->core.cpus) {
 				int fd = FD(evsel, j);
 				__u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
 
-				err = bpf_map_update_elem(map_fd, &idx, &fd,
-							  BPF_ANY);
-				if (err < 0) {
-					pr_err("Failed to update perf_event fd\n");
-					goto out;
-				}
+				bpf_map_update_elem(map_fd, &idx, &fd, BPF_ANY);
 			}
 
 			evsel->cgrp = leader_cgrp;
 		}
-		evsel->supported = true;
 
 		if (evsel->cgrp == cgrp)
 			continue;
-- 
2.39.0.314.g84b9a713c41-goog

