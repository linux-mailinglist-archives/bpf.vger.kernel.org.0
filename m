Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B035F6DA45A
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 23:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjDFVGQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 17:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFVGQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 17:06:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F087683;
        Thu,  6 Apr 2023 14:06:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so41898369pjb.0;
        Thu, 06 Apr 2023 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815174; x=1683407174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=77xFIxaHotOoGijURFHYGuwuVpW5zvnZZQ6buk6G1sQ=;
        b=lZKJfU1kGC8tlys7kHkPZW7ZXdM/pljaH268fj8z+3ntZ7vZ+4Y2LWbAwWf7L26Y4p
         dU7McUVlbs5XKMflYZ1wq49QjxELaTbhHGiRlGNqd890KFWX88JXG+rmIWtyU6fyZY3Y
         97AHn58UIy7kj9LCnP6atw+8lMnde4EwcNdep7hvPrPmzxicVPjkx+jCMIKsh8X7eifV
         LAdroGr5W9t5v0HMNtVgGtu8GuKMMlj78nvbKnGQXVAZV8RkID2jFQ4VLBL4l7zF8S51
         OIg4UuAwEFUZ86t9U+vpc7JNNyhWLJwtIJ6MDUVGtadTUbkkmQ/qANRMZXtaOeZaZEUn
         Fgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815174; x=1683407174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77xFIxaHotOoGijURFHYGuwuVpW5zvnZZQ6buk6G1sQ=;
        b=1U9koKF1wnxQLUgCS6/ZKBL/WEyvdiE0yx1kNdDvH7wCkchX5BlLYxL9TH5q/km3tt
         o2CrwJcUvKbPAVmn9KbR65xIkSH9umwRG660qPihOMWydOW6OaErNBtXoCi7dY8QJuFq
         yYbjsQLNmG0PUBnTR9EqnvOoJkjkNww5HWl7fUP4ZVfAaZqXbpFebF2xgtKOlz/WYoVZ
         XofLTbhWr4Sto3lod1/Tgf62eXQNI2iS5DJaNC35vMe+tKrqA1w7R/bpRv089Rh58yNc
         a3aFP6ZY7RF0YTGuMKxyqPS5pH8SPQg90bAmQmfeN3E5IAiUlVTgMMLScpsRg3LmtHy2
         zkEQ==
X-Gm-Message-State: AAQBX9fOlnfQfrzcDEibEk3RpggKP870/QZ/ir0b9amLDYsIMcOH5tLw
        uZHn+ekixP65/wgXXLwOGi+NcoHMDF4=
X-Google-Smtp-Source: AKy350aald8y8/pqPcS4eFE0Qpvib0HFsmE+sr4A25zNdS190jIldlbWnINsi9MwB8NzzxUgcGUHFg==
X-Received: by 2002:a17:902:da81:b0:1a5:206:4c90 with SMTP id j1-20020a170902da8100b001a502064c90mr610780plx.30.1680815174473;
        Thu, 06 Apr 2023 14:06:14 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:3301:38fe:e39e:3d51])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902868500b001a0667822c8sm1777837plo.94.2023.04.06.14.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:06:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCHSET 0/7] perf lock contention: Improve performance if map is full (v1)
Date:   Thu,  6 Apr 2023 14:06:04 -0700
Message-Id: <20230406210611.1622492-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

I got a report that the overhead of perf lock contention is too big in
some cases.  It was running the task aggregation mode (-t) at the moment
and there were lots of tasks contending each other.

It turned out that the hash map update is a problem.  The result is saved
in the lock_stat hash map which is pre-allocated.  The BPF program never
deletes data in the map, but just adds.  But if the map is full, (try to)
update the map becomes a very heavy operation - since it needs to check
every CPU's freelist to get a new node to save the result.  But we know
it'd fail when the map is full.  No need to update then.

I've checked it on my 64 CPU machine with this.

    $ perf bench sched messaging -g 1000
    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver processes per group
    # 1000 groups == 40000 processes run

         Total time: 2.825 [sec]

And I used the task mode, so that it can guarantee the map is full.
The default map entry size is 16K and this workload has 40K tasks.

Before:
    $ sudo ./perf lock con -abt -E3 -- perf bench sched messaging -g 1000
    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver processes per group
    # 1000 groups == 40000 processes run

         Total time: 11.299 [sec]
     contended   total wait     max wait     avg wait          pid   comm

         19284      3.51 s       3.70 ms    181.91 us      1305863   sched-messaging
           243     84.09 ms    466.67 us    346.04 us      1336608   sched-messaging
           177     66.35 ms     12.08 ms    374.88 us      1220416   node

After:
    $ sudo ./perf lock con -abt -E3 -- perf bench sched messaging -g 1000
    # Running 'sched/messaging' benchmark:
    # 20 sender and receiver processes per group
    # 1000 groups == 40000 processes run

         Total time: 3.044 [sec]
     contended   total wait     max wait     avg wait          pid   comm

         18743    591.92 ms    442.96 us     31.58 us      1431454   sched-messaging
            51    210.64 ms    207.45 ms      4.13 ms      1468724   sched-messaging
            81     68.61 ms     65.79 ms    847.07 us      1463183   sched-messaging

    === output for debug ===

    bad: 1164137, total: 2253341
    bad rate: 51.66 %
    histogram of failure reasons
           task: 0
          stack: 0
           time: 0
           data: 1164137

The first few patches are small cleanups and fixes.  You can get the code
from 'perf/lock-map-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (7):
  perf lock contention: Simplify parse_lock_type()
  perf lock contention: Use -M for --map-nr-entries
  perf lock contention: Update default map size to 16384
  perf lock contention: Add data failure stat
  perf lock contention: Update total/bad stats for hidden entries
  perf lock contention: Revise needs_callstack() condition
  perf lock contention: Do not try to update if hash map is full

 tools/perf/Documentation/perf-lock.txt        |  4 +-
 tools/perf/builtin-lock.c                     | 64 ++++++++-----------
 tools/perf/util/bpf_lock_contention.c         |  7 +-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 29 +++++++--
 tools/perf/util/bpf_skel/lock_data.h          |  3 +
 tools/perf/util/lock-contention.h             |  2 +
 6 files changed, 60 insertions(+), 49 deletions(-)


base-commit: e5116f46d44b72ede59a6923829f68a8b8f84e76
-- 
2.40.0.577.gac1e443424-goog

