Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643E5BB250
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiIPSlr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiIPSlp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 14:41:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D55B8A61;
        Fri, 16 Sep 2022 11:41:40 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso1949576pjq.1;
        Fri, 16 Sep 2022 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=S51SKuYdeuTsRRYFc57qnPOm5scEn4uyaX1X5OZJqXg=;
        b=SUYSa3v/Hh/ODahaeWcAlNfsoFCjpIsVcDK/QlgdMmhdeJzHWNalekeCrrX1ajoPFG
         mkufsAHSMQBEV1/7qTzRwYlH+Bwb4Jow22v9+3iF1ZoSmjsrP+9PxzU8I/ZNC0zsqC47
         wA1v0PeCNGAJT/3CNVRw8PZ0AQJtOpRlyFLNxSeA4LvqUHNE+w2fLFgge75vMV7193mv
         8XQsyT4M2Q5PN97qsP30rxuKJukUOehTLOu6Jnq4Yj9ega25UM3KzOIG/k95ydiXwzs0
         t5VXhh7AR33RbjnpMubpKhfIOmmQgaVO9RBenBYJrPSUjUCEt6cpk88yl/ituZkNgtSt
         oRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=S51SKuYdeuTsRRYFc57qnPOm5scEn4uyaX1X5OZJqXg=;
        b=sb9KRi1a5eJMroVRjsjLWjIQv8VG/sia2xkDJkcYfalFA6lqAu8y7nJy6Vh1/mIhEM
         tjfD+ej4s5TlUsaPv4Kz9f3Sj4XAJ5nQQszQF65kxyXnxNxG4xfnhTCZp0SbIw3B+HbH
         dbU6HYXP6mgR+txuwdtFLkkT8pebhb5FjLyTFVie2VbSsvL51HmT58biDI+Vi/uXA3ry
         9MmsKAK4MnSrFFry7c3aIB6UIQCOro07cS6i2uMdwuDDPnm+Wq4wpWjOq9hYjfBVB/w8
         enpeW2COgpY9H8K8jemR5wvgwA8Oe12S16xmolFAr96pQUopxPIdnZtNwrEsQnOKbdvN
         rENg==
X-Gm-Message-State: ACrzQf111DvAiX03svxiiQLdQaup1Ijcks4wS+AgDrNSSmwxwL5vGdBl
        fIL6EEMQukoAbXHf1dcmxq8=
X-Google-Smtp-Source: AMsMyM6Gim4Anfc/fLrNawDc8gKVSjDMZThysib63c8gE8xSEIqrZDwsy1tAsMby93CkY4RxPz2QIw==
X-Received: by 2002:a17:902:e844:b0:178:4930:8aa5 with SMTP id t4-20020a170902e84400b0017849308aa5mr1154677plg.69.1663353699408;
        Fri, 16 Sep 2022 11:41:39 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b0016dcbdf9492sm15093004plr.92.2022.09.16.11.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:41:39 -0700 (PDT)
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
Subject: [PATCH 3/4] perf stat: Use evsel->core.cpus to iterate cpus in BPF cgroup counters
Date:   Fri, 16 Sep 2022 11:41:31 -0700
Message-Id: <20220916184132.1161506-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220916184132.1161506-1-namhyung@kernel.org>
References: <20220916184132.1161506-1-namhyung@kernel.org>
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

If it mixes core and uncore events, each evsel would have different cpu map.
But it assumed they are same with evlist's all_cpus and accessed by the same
index.  This resulted in a crash like below.

  $ perf stat -a --bpf-counters --for-each_cgroup ^. -e cycles,imc/cas_count_read/ sleep 1
  Segmentation fault

While it's not recommended to use uncore events for cgroup aggregation, it
should not crash.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter_cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 97c69a249c6e..3c2df7522f6f 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -115,14 +115,14 @@ static int bperf_load_program(struct evlist *evlist)
 			evsel->cgrp = NULL;
 
 			/* open single copy of the events w/o cgroup */
-			err = evsel__open_per_cpu(evsel, evlist->core.all_cpus, -1);
+			err = evsel__open_per_cpu(evsel, evsel->core.cpus, -1);
 			if (err) {
 				pr_err("Failed to open first cgroup events\n");
 				goto out;
 			}
 
 			map_fd = bpf_map__fd(skel->maps.events);
-			perf_cpu_map__for_each_cpu(cpu, j, evlist->core.all_cpus) {
+			perf_cpu_map__for_each_cpu(cpu, j, evsel->core.cpus) {
 				int fd = FD(evsel, j);
 				__u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
 
@@ -269,7 +269,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 			goto out;
 		}
 
-		perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
+		perf_cpu_map__for_each_cpu(cpu, i, evsel->core.cpus) {
 			counts = perf_counts(evsel->counts, i, 0);
 			counts->val = values[cpu.cpu].counter;
 			counts->ena = values[cpu.cpu].enabled;
-- 
2.37.3.968.ga6b4b080e4-goog

