Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152625B3E3E
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 19:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiIIRws (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 13:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiIIRwq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 13:52:46 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58693131BDF;
        Fri,  9 Sep 2022 10:52:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so6048407pjp.2;
        Fri, 09 Sep 2022 10:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=nccN246kEYfk3UGon7MpN8QFDo7wKcoEwjdZMc/8ixo=;
        b=C0nBse47EjnFFj4RXiFv3bLuYED86LZEGJtlmdDiTwsGcUu9jiBnW3+ATHOBcfBgBP
         wd0gKD12QAphskf3+GSP46WEAbHGYA/g/3GUQ8fTwvdbIfxRACTLu0J9SUdOr44jKwmn
         7L5o3NLuEKiTW0Q16PhHnm2Ala9f6HNRIkFSHEWt9EH1VCCN1XUflS4QhJPg9DM/g3aE
         J9zFKCcSz6ocEGvvLCLwRjYFeCvMICWm7+r2Uun5XcFBs6tnJqhsvDt6NYg+sMEXZ2pe
         INJP6fxeCz5DfiEaUnvx/NLwgOixanCYquSEXwgVud1cY/bW5v3c87GTZ5mshYwog2xb
         Cdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=nccN246kEYfk3UGon7MpN8QFDo7wKcoEwjdZMc/8ixo=;
        b=4yiV7qREdRJ0OqDS3NA89JQS/VoF9s8GETMc3QLmV8kJ3LYSx5d8hN5+eadXFLdFcV
         A6Ilvdul1EECCuEz+4Zme4KGR1ELpnlrHpDEI+KNLgNi+fs2gjp7RGFxIGNmeqIrOdTm
         7Jipvy3KJt9wTZ+pcdYsW5IngDbRAOK/t42hDMP3g8o9L5TgEmMEvzw7sGEhl3reT+Yw
         /53bO9qEVkq3iyHCcdpojmKMBWQsBT3yE29GLt9WaEB+N8O3nkVMAweT/CAE6gV6NYqL
         y1xqEgLnU3Sp1bXjym1SQd5Mm52AA0XqpEUYRnfj+9WBfUIsAut/Cu0qIgxI3lcC1cNw
         0R0w==
X-Gm-Message-State: ACgBeo26W18h+uBVV9cssjhTfXrxuIuRYHzsm1g6i06WkjO4NAli3x97
        TujtB7BJ4FZ4nwxd4MtbY+k=
X-Google-Smtp-Source: AA6agR72c8909lrCR5qLSQlF90tm/upGtfs2DtFTL/CKfXgc6poeL020ZplAPKtJ1b+6Z7A5IQ0uUg==
X-Received: by 2002:a17:902:f548:b0:178:44b:4ea9 with SMTP id h8-20020a170902f54800b00178044b4ea9mr5485456plf.77.1662745964748;
        Fri, 09 Sep 2022 10:52:44 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:b77b:e812:1879:ec2f])
        by smtp.gmail.com with ESMTPSA id w207-20020a627bd8000000b0052d46b43006sm4275pfc.156.2022.09.09.10.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 10:52:44 -0700 (PDT)
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
Subject: [PATCH 2/3] perf stat: Fix cpu map index in bperf cgroup code
Date:   Fri,  9 Sep 2022 10:52:38 -0700
Message-Id: <20220909175239.206268-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220909175239.206268-1-namhyung@kernel.org>
References: <20220909175239.206268-1-namhyung@kernel.org>
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
2.37.2.789.g6183377224-goog

