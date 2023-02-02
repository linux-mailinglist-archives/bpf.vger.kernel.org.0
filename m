Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE26874E1
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 06:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBBFFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 00:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBBFFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 00:05:00 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B6813D6F;
        Wed,  1 Feb 2023 21:04:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b5so734530plz.5;
        Wed, 01 Feb 2023 21:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=R0tc7/8E01DSEPlgGlBLAhea+NkOTJGGCeqxDO2l9is=;
        b=aYKDxdFzWm0VsQWWGRFnUmPGy5i3KtoBAa5VGTHfg7T6ts0uICPU4COZjD0ANDl2q7
         sT4hjskqYL+57eAT8sQilzV1p7sNWrseUvS4rgaTcCqsnDfLW0073AZHfBGq5Zsauc3D
         ZFDRC5ew/sj2xrzl+2qdPJpR05ZU5z5MoP08hOI68X/+n/mjWkSG8gHtwDz7W7SJ3r56
         itPamYEmXl7Yp8jhDjiivuY/R/xrYvlEnSH4tTbisrLZ2c0B8+0V7ONFmWd3ulHKoDvo
         hTP1ILuSptmwCJOUZiArTwpvy+/QBKtmspZYaB6aWdzHy7dRceLx5TPXJcN6/gAnrHdN
         AxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0tc7/8E01DSEPlgGlBLAhea+NkOTJGGCeqxDO2l9is=;
        b=AWorGOX7gnOVqRyHdzWSUyOIfgKRcjP4say+RmBXs5hh0G2Yq8RCQoa1ZEVW0Wbsk0
         zEYdqs92zpIYkZ1BpQ+ri2glZEXkUDbcDE9wnMjhVrquX0blorqyvfjLGOl7mjfmEmNx
         nTdJmcFRapNojqQtoeCOAwHips5ZV5NWpr5JCJmcepjQZolo2KTskk8gUNckcmgyWmyQ
         O93Zc7Uh4CGZEzjoIFYhcgi0OXw+ujmOjCZ0Yj0VO97jDw7+yNxvK2RaxD5VIqkKracD
         RPXvtPIkDV3Fm5wbdgba6VETqdBAZ5NlI2mhFUDCGUe3Wu4uqBBW78PD0/vkT0NRIS15
         Fv7A==
X-Gm-Message-State: AO0yUKUrv4xYRjaqFRJLSRSDZMVI3Qs9Apra9o6EqkS3K70flvzKTNkk
        O1jInIyfT7zpEb4M7MC4Pko=
X-Google-Smtp-Source: AK7set/6PXGlxwyxrWotnkRud7UNs3S4vvWO0Nh1F7lFki7c2O8vL8XJnIv/ScKPYPvl6ByiTdnF5Q==
X-Received: by 2002:a17:90b:1b09:b0:22c:8baa:c7e6 with SMTP id nu9-20020a17090b1b0900b0022c8baac7e6mr5166978pjb.20.1675314298419;
        Wed, 01 Feb 2023 21:04:58 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:8899:7288:e54d:8b87])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090aba8300b0022bb3ee9b68sm2238374pjr.13.2023.02.01.21.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 21:04:57 -0800 (PST)
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
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: [PATCH 0/4] perf lock contention: Improve aggr x filter combination (v1)
Date:   Wed,  1 Feb 2023 21:04:51 -0800
Message-Id: <20230202050455.2187592-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
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

Hello,

The callstack filter can be useful to debug lock issues but it has a
limitation that it only works with caller aggregation mode (which is the
default setting).  IOW it cannot filter by callstack when showing tasks
or lock addresses/names.

But sometimes users want to use the filter for other aggregation mode.
Like "show me lock addresses/names from this caller only" or "show me
tasks having these callers".

When it's using tracepoint events from the data file, the situation is
good since the tracepoints have all the necessary info.  But when using
BPF it needs to extend the key of lock stat BPF map to have more than
one info like 'pid + stack_id' or 'lock_addr + stack_id'.  As callstack
filter works in userspace, it should save the both info.

With this change we can now use the -S/--callstack-filter with the
-t/--threads option or -l/--lock-addr option.  It's also possible to use
it with other filter options.

The following example shows the top 5 tasks that have contention
somewhere in the epoll handling.

  $ sudo perf lock con -abt -S epoll -E5 -- sleep 1
   contended   total wait     max wait     avg wait          pid   comm

           2     58.64 us     32.38 us     29.32 us      1514752   Chrome_IOThread
           3     29.31 us     12.65 us      9.77 us         3773   Xorg
           1     17.45 us     17.45 us     17.45 us      1514906   Chrome_ChildIOT
           1     15.41 us     15.41 us     15.41 us      1515382   Chrome_ChildIOT
           1     12.52 us     12.52 us     12.52 us       293878   IPC I/O Parent

You get get the code at 'perf/lock-filter-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung

Namhyung Kim (4):
  perf lock contention: Factor out lock_contention_get_name()
  perf lock contention: Use lock_stat_find{,new}
  perf lock contention: Support filters for different aggregation
  perf test: Add more test cases for perf lock contention

 tools/perf/builtin-lock.c                     |  79 ++++----
 tools/perf/tests/shell/lock_contention.sh     |  66 ++++++-
 tools/perf/util/bpf_lock_contention.c         | 178 +++++++++++-------
 .../perf/util/bpf_skel/lock_contention.bpf.c  |  15 +-
 tools/perf/util/bpf_skel/lock_data.h          |   4 +-
 tools/perf/util/lock-contention.h             |   5 +
 6 files changed, 234 insertions(+), 113 deletions(-)


base-commit: 7cfa9f5e440054db7c7e28e83a045d36993ff958
-- 
2.39.1.456.gfc5497dd1b-goog

