Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4208365CD42
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 07:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbjADGoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 01:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjADGoK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 01:44:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3DA2E5;
        Tue,  3 Jan 2023 22:44:09 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s67so12303129pgs.3;
        Tue, 03 Jan 2023 22:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYyFBSOYl+N37EChskGvYBFRtSPcjv1yDLUNKRSs7MM=;
        b=UxEyTrBRmwjsHTMfS+syQvxgGQTx/wNtXpdL5cuHQwnv9y5GBApVJRFXRBX4qaXd3c
         CwhCtWGNf0BEazBtrSOOwhtX3Dvz4ur/jOWBK9OXMbdOcYgj3FFm4sJUkLqbMSQw7Eqc
         iJMM7atv89+rSMEBWArvTDyEo0rwYtrssbu1saCb4XvzdJowP/7WffiCb78dvuPvNzv9
         bT3C7pAQHqFYHGF+Dchsf8onVKCCoWfcYY5Uh7D+aI4zkMGI4B4B9PW5Ymcyue6X9stj
         YejIXrbKqCJWO9dPG7TbBSIEyBp8vL3y0/fsFRTfg+Snd0+boMjNhPYVxN0Jum3RT7t5
         DsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYyFBSOYl+N37EChskGvYBFRtSPcjv1yDLUNKRSs7MM=;
        b=wIACj2qh0PetSc57r9qphdmRTGZvSiW5IxCZ8iOF3HmWPCkiiLEl7X4n/RLZasZgXY
         pGeCUtzAmSoBMzOCceIolSXrAPzvo2PBILK1t6OhoUhtwxhCLx23KWN2BRc1fE2SeSwL
         9O7VHeeWjTDfTlfvq2/g/PvWdDuwRsvIJtgJJGJ8d/j4bnirtdXNW0k5WvJ+NT6aSlXq
         2XKZkeQp1TXCOiAMqBkqsFg0/Ak6eoESgUH8k8GUJ7mnte659GzglTQqoW+cH0eVhPxM
         INSvcJVnxfg+mGbbMPrcAr3yeoM8IQpcWA/Au6d0WtB/4IfiLb/dKtLef59AWxXmwixR
         I66w==
X-Gm-Message-State: AFqh2kp2V+KvrDuca9QRvWnWanriHJ0eJl0v5Vp29sd9dykIw1BkdIYs
        Y3uq1Jj25uO8/qL99S6+DgU=
X-Google-Smtp-Source: AMrXdXtCnxUS1iLq5maFRNCCpIOOBxtOeCn7BQJMzWYnCTvADviYd1Y3orzjT55h9TvNZsaPnFiVWg==
X-Received: by 2002:a05:6a00:84c:b0:581:1ee0:75a with SMTP id q12-20020a056a00084c00b005811ee0075amr40159114pfk.32.1672814649048;
        Tue, 03 Jan 2023 22:44:09 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:d1f4:a47f:3a41:e1a2])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b00576f7bd92cdsm11829257pfj.14.2023.01.03.22.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 22:44:08 -0800 (PST)
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
Subject: [PATCH 2/4] perf bpf_counter: Increase perf_attr_map entries to 32
Date:   Tue,  3 Jan 2023 22:44:00 -0800
Message-Id: <20230104064402.1551516-3-namhyung@kernel.org>
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

The current size 16 cannot hold all events when user gave -dd or -ddd.
As it's a part of perf stat, let's increase the size to 32.

  # unlink previous map to change the size
  $ sudo unlink /sys/fs/bpf/perf_attr_map

  $ sudo ./perf stat -a --bpf-counters -ddd sleep 1

   Performance counter stats for 'system wide':

           35,927.41 msec cpu-clock                        #   35.802 CPUs utilized
              12,629      context-switches                 #  351.514 /sec
                 209      cpu-migrations                   #    5.817 /sec
                 826      page-faults                      #   22.991 /sec
       2,155,729,621      cycles                           #    0.060 GHz                         (30.43%)
       1,053,849,500      instructions                     #    0.49  insn per cycle              (38.18%)
         232,711,500      branches                         #    6.477 M/sec                       (38.44%)
          10,693,352      branch-misses                    #    4.60% of all branches             (31.27%)
         267,561,655      L1-dcache-loads                  #    7.447 M/sec                       (30.58%)
          27,290,728      L1-dcache-load-misses            #   10.20% of all L1-dcache accesses   (30.48%)
          12,651,208      LLC-loads                        #  352.133 K/sec                       (30.78%)
           1,274,018      LLC-load-misses                  #   10.07% of all LL-cache accesses    (38.70%)
     <not supported>      L1-icache-loads
          75,916,358      L1-icache-load-misses            #    0.00% of all L1-icache accesses   (38.11%)
         273,330,559      dTLB-loads                       #    7.608 M/sec                       (30.54%)
           2,864,458      dTLB-load-misses                 #    1.05% of all dTLB cache accesses  (38.77%)
             361,507      iTLB-loads                       #   10.062 K/sec                       (30.59%)
             848,031      iTLB-load-misses                 #  234.58% of all iTLB cache accesses  (31.30%)
     <not supported>      L1-dcache-prefetches
     <not supported>      L1-dcache-prefetch-misses

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_counter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 7f5cc1aa4903..de6331f5263c 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -28,7 +28,7 @@
 #include "bpf_skel/bperf_leader.skel.h"
 #include "bpf_skel/bperf_follower.skel.h"
 
-#define ATTR_MAP_SIZE 16
+#define ATTR_MAP_SIZE 32
 
 static inline void *u64_to_ptr(__u64 ptr)
 {
-- 
2.39.0.314.g84b9a713c41-goog

