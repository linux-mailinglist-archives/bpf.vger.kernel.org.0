Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67B15BB24E
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 20:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiIPSlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 14:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiIPSll (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 14:41:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A642B775F;
        Fri, 16 Sep 2022 11:41:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so544399pjq.3;
        Fri, 16 Sep 2022 11:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=aYClvGhuMnA9RUqYwgEhtJ6BEKGPrGUBP0eUxyj+8BA=;
        b=Bv7QI1G3rAnYAjM0CzVR37ATOBMvjLeW+Y2AM/ukkDRYyYdC8xverfBtTVH2w1HC1y
         FZvgjIIAwjRqJtocGyKvv7yJo6E1WIl5d9iWPVw+JvxcSzpXIcu0ama30KrB+1eithAC
         gnQ1qND5noF7Ofd2d2sv/ljNVRaivTDkAx3pEQ7FaBRdjYXWJmeyLIyYBxS+ETd7V/Yc
         8514W0XpksGtMi7TkXOnzt7tdREHuysDsaa6xDCJ0fNKWH2SseY0dAkbDl2/bzJO2iGH
         Ef2XV81y9pvxoiuhky1AvDWSO4jHs6MRZDHj3srLiwyDOntZJqS3ksDRFkXcj/oXf10O
         F7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=aYClvGhuMnA9RUqYwgEhtJ6BEKGPrGUBP0eUxyj+8BA=;
        b=FxMBM+swlP3LRtVMeG4HJJJeBVUPl8TkWxit7DLTD88SdVDZJDtMEVkIsTChZvdMfA
         7/3Oe8WAzd+mN0R5z/bmwjqVh/MajxvESB1L3djlXXKJrzzHx6eWsjnwEpVthP+bh2tR
         MBp+yummv/IIj5FxR7U895prIYf4xOY2We4e98f9i1MqTpWyroR8AkLqsT4856PQVXaE
         Zt3BVAn7EdEMaeNATQwip74l1yhDRoXWZHQ0OT9/5oubn6dZpqE0yXw8qkEdai37o6HF
         WINdnlDGLXsZ7GhRBD820f5tgXv0ux67poAZZWXTMzJR472I0N2+2CfJwaHVyiDqmzSC
         SSmw==
X-Gm-Message-State: ACrzQf1wCim5HhhAeIehk4WTfYh+dEtFplXJnWK7gjefvG9oLIBT+Y+j
        rEjVRdHd2JvdpQszs33r3Lg=
X-Google-Smtp-Source: AMsMyM7SDRjPHoJb2KSCDwfLuaL+o+TvAsxvwzsZcPU69iOE2Kz54jPDdWNx2YH2T0vRyVmhfypLbA==
X-Received: by 2002:a17:90a:c258:b0:202:b93b:cb89 with SMTP id d24-20020a17090ac25800b00202b93bcb89mr17323928pjx.126.1663353698155;
        Fri, 16 Sep 2022 11:41:38 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:2952:dee7:a35e:6428])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b0016dcbdf9492sm15093004plr.92.2022.09.16.11.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:41:37 -0700 (PDT)
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
Subject: [PATCH 2/4] perf stat: Fix cpu map index in bperf cgroup code
Date:   Fri, 16 Sep 2022 11:41:30 -0700
Message-Id: <20220916184132.1161506-3-namhyung@kernel.org>
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

The previous cpu map introduced a bug in the bperf cgroup counter.  This
results in a failure when user gives a partial cpu map starting from
non-zero.

  $ sudo ./perf stat -C 1-2 --bpf-counters --for-each-cgroup ^. sleep 1
  libbpf: prog 'on_cgrp_switch': failed to create BPF link for perf_event FD 0:
                                 -9 (Bad file descriptor)
  Failed to attach cgroup program

To get the FD of an evsel, it should use a map index not the CPU number.

Fixes: 0255571a1605 ("perf cpumap: Switch to using perf_cpu_map API")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter_cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 63b9db657442..97c69a249c6e 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -95,7 +95,7 @@ static int bperf_load_program(struct evlist *evlist)
 
 	perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
 		link = bpf_program__attach_perf_event(skel->progs.on_cgrp_switch,
-						      FD(cgrp_switch, cpu.cpu));
+						      FD(cgrp_switch, i));
 		if (IS_ERR(link)) {
 			pr_err("Failed to attach cgroup program\n");
 			err = PTR_ERR(link);
@@ -123,7 +123,7 @@ static int bperf_load_program(struct evlist *evlist)
 
 			map_fd = bpf_map__fd(skel->maps.events);
 			perf_cpu_map__for_each_cpu(cpu, j, evlist->core.all_cpus) {
-				int fd = FD(evsel, cpu.cpu);
+				int fd = FD(evsel, j);
 				__u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
 
 				err = bpf_map_update_elem(map_fd, &idx, &fd,
-- 
2.37.3.968.ga6b4b080e4-goog

