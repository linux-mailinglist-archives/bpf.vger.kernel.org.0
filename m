Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D835906BB
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 21:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiHKSzE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiHKSzB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 14:55:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F49E2E7;
        Thu, 11 Aug 2022 11:55:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l64so17910789pge.0;
        Thu, 11 Aug 2022 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=I8kbWXYGXqQKab1JaNWIVSUdUxluiMJuudx9F7sD27s=;
        b=hwEov3lFlN6qFXbdW5KfpSbNjuxnkCxk8FBCCHJDCsPq+ppzdQoN0cLHbGH/bhWQA9
         6ddYxN4h5pR02aMjx1mvfIuQqq8FVxNNSgbApn+GVVVOCOWrTbPP/yd1s9A+ZymmB6ib
         kMjOS7u48dgtsw/REqnMXQliF59nbVuXMaDZprtLay8u+6JgOsNLiWx5spu7YQlxhzgC
         Yw+dWdig040mfypI9g/mKagPAfPPzNZCKjIJerECNOdfJfOHL78acLl9aDAhX2nr3QEM
         ebbvEUNE9JmWE+aQOh7kQKGD2QaSN5ThSs3JazgbrqiZS8AVQXSYDIMoA1TJmhyhMqxM
         xmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=I8kbWXYGXqQKab1JaNWIVSUdUxluiMJuudx9F7sD27s=;
        b=wv1lT9Dz9RrNRFAhfa6Ce9sW8ihh57hOLmmWDj+RYFyz2umdmeTgKhVTyafL9d8Hxx
         nIkE1D87dXADKSqKUSqqiSdO0OrSpjTRAWDYWKmLZ+mWaPWvVzC3dPoNACke0JTWYuhC
         11/fbawbfeiDNeeAV0B+22cCg//ssTluPSXzuwABqbvZsGSqSRmUpds3RKCt5C5PSdIV
         B6SnWc998fTl9d5+zZs4VWS6vCnrcteITGSOWkA0X+RimO6SChQXypW3eIu/hHgDtwp+
         aS4KncDb2nOux53C08MxFISwcnfa56oBiTaRLeVq8i03sgd+eGeq4IgLWsgCia+ZEikw
         vLNQ==
X-Gm-Message-State: ACgBeo33HLlgYD63ks/Us/6Bw5XUwR6gGxf2ejLp6BaiibLivaXdtMqP
        e4eImPa9G9fui80XSMiJpYA=
X-Google-Smtp-Source: AA6agR48GKgZOibGuvqCdq8cL9Si508urhY1eCI4XPI+ZTONcg28a0y7Kx7lj7fnsLDyLS8YnSVNwA==
X-Received: by 2002:a63:e511:0:b0:41d:2c8d:e9f with SMTP id r17-20020a63e511000000b0041d2c8d0e9fmr321535pgh.404.1660244100482;
        Thu, 11 Aug 2022 11:55:00 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:cefb:475d:dd6d:a1e2])
        by smtp.gmail.com with ESMTPSA id r12-20020a6560cc000000b0041975999455sm66314pgv.75.2022.08.11.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:54:59 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Hao Luo <haoluo@google.com>,
        Blake Jones <blakejones@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org
Subject: [PATCH 0/4] Track processes properly for perf record --off-cpu (v2)
Date:   Thu, 11 Aug 2022 11:54:52 -0700
Message-Id: <20220811185456.194721-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
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

Hello,

This patch series implements inheritance of offcpu events for the
child processes.  Unlike perf events, BPF cannot know which task it
should track except for ones set in a BPF map at the beginning.  Add
another BPF program to the fork path and add the process id to the map
if the parent is tracked.

Changes in v2)
 * drop already merged fixes
 * fix the shell test to omit noises
 
With this change, it can get the correct off-cpu events for child
processes.  I've tested it with perf bench sched messaging which
creates a lot of processes.

  $ sudo perf record -e dummy --off-cpu -- perf bench sched messaging
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

       Total time: 0.196 [sec]
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.178 MB perf.data (851 samples) ]


  $ sudo perf report --stat | grep -A1 offcpu
  offcpu-time stats:
            SAMPLE events:        851

The benchmark passes messages by read/write and it creates off-cpu
events.  With 400 processes, we can see more than 800 events.

The child process tracking is also enabled when -p option is given.
But -t option does NOT as it only cares about the specific threads.
It may be different what perf_event does now, but I think it makes
more sense.

You can get it from 'perf/offcpu-child-v2' branch in my tree

  https://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf offcpu: Check process id for the given workload
  perf offcpu: Parse process id separately
  perf offcpu: Track child processes
  perf offcpu: Update offcpu test for child process

 tools/perf/tests/shell/record_offcpu.sh | 57 ++++++++++++++++++++++---
 tools/perf/util/bpf_off_cpu.c           | 53 ++++++++++++++++++++++-
 tools/perf/util/bpf_skel/off_cpu.bpf.c  | 38 ++++++++++++++++-
 3 files changed, 138 insertions(+), 10 deletions(-)


base-commit: b39c9e1b101d2992de9981673919ae55a088792c
-- 
2.37.1.595.g718a3a8f04-goog

