Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EEC6488CF
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 20:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLITHc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 14:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiLITHc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 14:07:32 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4925B1DF28;
        Fri,  9 Dec 2022 11:07:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 4so5887358pli.0;
        Fri, 09 Dec 2022 11:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KXrM2ORadkXpKfT+cxkMFP7lhWcFFSnPfGCXL/1qN8E=;
        b=Ir6LiHW8EG6VKzSzj/thAQhYYTnx3MmaP2R6NN1ZoKIajddttTWyEY59GLL6EU9K2c
         Qkw3/Rd7rMkb2jTrjFIFHguwhk6NVkhWDV2UtQh3YWqRTXj9lCKZ/YHgUufPkWrk6IF9
         wVH9Y/xUjIdm293VZ14dW4611b2N0ylmpNaVNAepmhsYtU5/HdormZmqRQ/KFC0Pw12q
         YQ9917FdBHL/3Z0l2HhjAhivWbK1wNulmORRsSwDEmnurD+4JRm70IVbe1Ngar+NsHxn
         jM7FrWBusAU/LBqpFLgUljJNR7mAVToOsjjyqogAUJc+s50HzZTUHIfQG2X1QDnZMHva
         62fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXrM2ORadkXpKfT+cxkMFP7lhWcFFSnPfGCXL/1qN8E=;
        b=q+oFKXLhRJnfcFLFGQSoTUmHXSXG9Q1rsF/3sag3GK5QCHpFRjM2RH/6/uRjy6j7hy
         4qprOQo0zkklAlDhj1iOPIihbvRmht+0EJHXVMXLILk59CsHlNVlpjq++wlbdpvoaWcd
         hhf8Ou3Qlmi/phA+jdcCf5uSh+M403tJ56o8JK8rUhQ8BRNFUblL3UTaau3oMBjQCI1y
         ePC/X/YNKqYFlZEvDI/6vn2t/ZjTrd68vOr4wIW4UO3SC4zc1L8Q2FmwLQiAk8iyQAJT
         8TXmBOG+zFPJVymlR/HcRq21npK1Z4TzkmTZXEhZTvDIkNEgc9dJnNuxq1nIsOg6TJd8
         i1Mg==
X-Gm-Message-State: ANoB5pnFnjrsQGMMje861FiC50p13SpXmdWA1DTHiHhWADq6V9VmFX6F
        EsU+sGxKrNiRELaUKtVcT0E=
X-Google-Smtp-Source: AA0mqf6ZNjEtRGQQzsAPI8MTTWIQ8Bd/pN3sBLI1fZFeE8LQOHRQdtJEuImqf7bMUmNVK6uJjUlTrw==
X-Received: by 2002:a17:90a:e38a:b0:219:9e19:8259 with SMTP id b10-20020a17090ae38a00b002199e198259mr6957560pjz.46.1670612850547;
        Fri, 09 Dec 2022 11:07:30 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:c952:d848:9e00:3cce])
        by smtp.gmail.com with ESMTPSA id nd17-20020a17090b4cd100b002135de3013fsm1431432pjb.32.2022.12.09.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:07:29 -0800 (PST)
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
Subject: [PATCH 0/4] perf lock contention: Support task/addr aggregation mode (v1)
Date:   Fri,  9 Dec 2022 11:07:23 -0800
Message-Id: <20221209190727.759804-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
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

This patchset adds two more aggregation modes for perf lock contention.

The first one is the per-task mode with -t/--threads option.  The option
was there already but it remained broken with BPF for a while.  Now it
supports the output with and without BPF.

  # perf lock contention -a -b -t -- sleep 1
   contended   total wait     max wait     avg wait          pid   comm

          11     11.85 us      2.23 us      1.08 us            0   swapper
           2     11.13 us     10.22 us      5.56 us       749053   ThreadPoolForeg
           1      8.15 us      8.15 us      8.15 us       321353   Chrome_ChildIOT
           2      2.73 us      1.77 us      1.37 us       320761   Chrome_ChildIOT
           1      1.40 us      1.40 us      1.40 us       320502   chrome
           1       379 ns       379 ns       379 ns       321227   chrome

The other one is the per-lock-instance mode with -l/--lock-addr option.
If the lock has a symbol, it will be displayed as well.

  # perf lock contention -a -b -l -- sleep 1
   contended   total wait     max wait     avg wait            address   symbol

           3      4.79 us      2.33 us      1.60 us   ffffffffbaed50c0   rcu_state
           4      4.19 us      1.62 us      1.05 us   ffffffffbae07a40   jiffies_lock
           1      1.94 us      1.94 us      1.94 us   ffff9262277861e0
           1       387 ns       387 ns       387 ns   ffff9260bfda4f60

It's based on the current acme/tmp.perf/core branch.
You can find the code in the 'perf/lock-con-aggr-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf lock contention: Add lock_data.h for common data
  perf lock contention: Implement -t/--threads option for BPF
  perf lock contention: Add -l/--lock-addr option
  perf test: Update perf lock contention test

 tools/perf/Documentation/perf-lock.txt        |  4 +
 tools/perf/builtin-lock.c                     | 95 ++++++++++++++-----
 tools/perf/tests/shell/lock_contention.sh     | 48 ++++++++++
 tools/perf/util/bpf_lock_contention.c         | 72 ++++++++++----
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 67 +++++++++----
 tools/perf/util/bpf_skel/lock_data.h          | 30 ++++++
 tools/perf/util/lock-contention.h             |  1 +
 7 files changed, 255 insertions(+), 62 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/lock_data.h


base-commit: b22802e295a80ec16e355d7208d2fbbd7bbc1b7a
-- 
2.39.0.rc1.256.g54fd8350bd-goog

