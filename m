Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADEC6513AB
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 21:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiLSURi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 15:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSURh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 15:17:37 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543FDB20;
        Mon, 19 Dec 2022 12:17:36 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o12so10234485pjo.4;
        Mon, 19 Dec 2022 12:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ydjKG6/uPmWnASJJycB3UT3EMyJQHIq9sn9NT3G23+I=;
        b=HPkvOadAmReZaG0YjRN9WZgLPFIlfmM0EhA+AoMgCYcsD2L4GSoIEu/e+gj5ZZtrAs
         /+jJQ455h5fR2CG1x+/5fT4P/7+/OvRrhvW43PuDYvLAsmckwkx6fOabq4RbUDGZ20ko
         PDjZJMBoVW7VOuLm8LPRwWO11981diGE6nAVCITk9lTnxkvRxjFLYurAi5Oa8SZPS8vM
         Q6sE4HMkiymKH28+kY2BeRuKMSm2SMVC/Zs2TOSrrHj9lDWkxuTIBvcv3KvnmLMTzgL8
         B+dGlfAG5F+4VySpuLlJZjA1Hjj9h4FprSVH3iTJhPab6gwTQpH37K3BfK4NgKVzARJx
         SgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydjKG6/uPmWnASJJycB3UT3EMyJQHIq9sn9NT3G23+I=;
        b=gOg4WK1ykuCfx2868GZSvihW6RiN4Twq6rvRzp66eHQGhQviIhGsqHE0t+90ZCeIR4
         2ufOvm6sSMkRpXduDvSCKmdkVBbFrRiG8XTWyeAhzHl+i9pfGo24w2xOZN3CFj8WzM0r
         jxMFGlYAKE/5C6RT75J8J1nko3K1GAN1gGoVLFi2pv2o/37NNULkR8y+3VKUnZ5dDI5A
         rkuAb9A/Evs5F5EOYB7jxJc8SOVndK9OzQ4v25f4z3k2dTOxw+D6ut9gcTantrfeUXCc
         C1AHvMXR80uPY02jOsuIgdz4R5Wztu6g3Q8EUV9LsoX2qvVqmPrHbxdovpsl60qrLA8n
         5A8g==
X-Gm-Message-State: ANoB5pkmqAVAJPiw3XNQw66i3ByGWXQBJwr4+ZVGHk5f4rnfREeFBRIp
        wlBassUhK+Co98szAMnNOjY=
X-Google-Smtp-Source: AA0mqf4OKj13ZofBFkBbT3y3eGBqxh/6+Z4CA0EyDBZ2E6+p1BAjERR3/JpWgd8THe76BLLhnNas/g==
X-Received: by 2002:a17:90a:7d0f:b0:219:aa6:87f with SMTP id g15-20020a17090a7d0f00b002190aa6087fmr45243319pjl.20.1671481055622;
        Mon, 19 Dec 2022 12:17:35 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:735a:2805:e706:5164])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090ace0a00b00219220edf0dsm6324260pju.48.2022.12.19.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:17:34 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf@vger.kernel.org
Subject: [PATCH 0/6] perf lock contention: Add more filter options (v1)
Date:   Mon, 19 Dec 2022 12:17:26 -0800
Message-Id: <20221219201732.460111-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

This patchset adds a couple of filters to perf lock contention command.

The -Y/--type-filter is to filter by lock types like spinlock or mutex.

  $ sudo ./perf lock con -ab -Y spinlock -E 3 -- ./perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.167 [sec]
   contended   total wait     max wait     avg wait         type   caller

          11    669.31 us    107.17 us     60.85 us     spinlock   remove_wait_queue+0x14
          10    586.85 us     87.62 us     58.68 us     spinlock   prepare_to_wait+0x27
         186    497.36 us     12.94 us      2.67 us     spinlock   try_to_wake_up+0x1f5

For the same workload, you can see the rwlock results only like below.

  $ sudo ./perf lock con -ab -Y rwlock -E 3 -- ./perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.171 [sec]
   contended   total wait     max wait     avg wait         type   caller

          20    142.11 us     17.10 us      7.11 us     rwlock:W   do_exit+0x36d
           3     26.49 us     12.04 us      8.83 us     rwlock:W   release_task+0x6e
           5     12.46 us      5.12 us      2.49 us     rwlock:R   do_wait+0x8b

The -L/--lock-filter is to filter by lock address or name.  You can use
the existing -l/--lock-addr option to get the info.

  $ sudo ./perf lock con -abl -- ./perf bench sched messaging 2>&1 | grep tasklist_lock
          25     39.78 us     16.51 us      1.59 us   ffffffff9d006080   tasklist_lock

And use it with -L option like below.

  $ sudo ./perf lock con -ab -L tasklist_lock -- ./perf bench sched messaging 2>&1
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.174 [sec]
   contended   total wait     max wait     avg wait         type   caller

          22    227.18 us     24.16 us     10.33 us     rwlock:W   do_exit+0x36d
           3     26.12 us     18.03 us      8.71 us     rwlock:W   release_task+0x6e

Passing the address is supported too.

  $ sudo ./perf lock con -ab -L ffffffff9d006080 -- ./perf bench sched messaging 2>&1
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.190 [sec]
   contended   total wait     max wait     avg wait         type   caller

          28    276.62 us     16.90 us      9.88 us     rwlock:W   do_exit+0x36d
           4     22.36 us      7.04 us      5.59 us     rwlock:R   do_wait+0x8b
           2     10.51 us      5.38 us      5.25 us     rwlock:W   release_task+0x6e

You can get it from 'perf/lock-filter-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
  perf lock contention: Factor out lock_type_table
  perf lock contention: Add -Y/--type-filter option
  perf lock contention: Support lock type filtering for BPF
  perf lock contention: Add -L/--lock-filter option
  perf lock contention: Support lock addr/name filtering for BPF
  perf test: Update perf lock contention test

 tools/perf/Documentation/perf-lock.txt        |  27 +-
 tools/perf/builtin-lock.c                     | 305 ++++++++++++++++--
 tools/perf/tests/shell/lock_contention.sh     |  58 +++-
 tools/perf/util/bpf_lock_contention.c         |  55 +++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  38 ++-
 tools/perf/util/lock-contention.h             |  10 +
 6 files changed, 451 insertions(+), 42 deletions(-)


base-commit: 51c4f2bf5397b34b79a6712221606e0ab2e6f7ed
-- 
2.39.0.314.g84b9a713c41-goog

