Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8D351E005
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 22:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442134AbiEFUUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 16:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442115AbiEFUUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 16:20:17 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2684D624;
        Fri,  6 May 2022 13:16:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so7797811pjf.0;
        Fri, 06 May 2022 13:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnVTOmeWJdCW14+Uuj8JCfjLjJAP80qHcxM/0JW5PeM=;
        b=Q17S6sSUCOxqpIi7tYiyZjfz/LZE9iOczEusYqcnh/qTIAK4z0g9ba9B+ZHC7cDO8h
         zdq7bfUqSyiVYofBGVGAcjLSI68sWnISGiF9a7BEKSumngEivjgm+q+x0QenAq/PMmMg
         Cb/9QYkw7lV/497WBHacu+BsKwpResU+vEFAh6vOMLYxBY1DbSI2OpdfyPNrhp2f0p2R
         pEWnZJJZw0ZlcL0IMesBmRB4aKCXeaLwaKv9QAVA9AKp7MzcMQEAyAI6oB0+oPMT7dW3
         koscAj6DLcFGofqU9ZtIWnn9oj4n/DII3dhxUWbWH6c4J4HGbCejSZot50hydHNxh1Xo
         s8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PnVTOmeWJdCW14+Uuj8JCfjLjJAP80qHcxM/0JW5PeM=;
        b=uBPS7eINyPamvFqvEm4FlBcwDJ+ktE673cLD7D35zkO4DmXso65SVEmk0EYfJXcOYi
         xESFhBfE5FuDgCZ+04mBfmu0wzEGWM+DSxVva4tOdHaPpuczXENy1R/PsXnWBRM7UMrS
         jdQVSU+fTtSA+6Vw0qKugArjxHbjwA6XIzIkAOFu45V2wWdaWCjpLYuM8NW4U6cZGJAk
         i+++rBty+J0hf6cQiraGvpyvlP7x7LZpsCaoNJ3imQcCWDNxGa2ro7OECXPFY/JzBJQc
         1axBkCprBLeXCqNkLKD8FLXA958VWCKLYeoViAIX+o+ekKR161WH1h/X0QiYczvjBKNS
         ISoA==
X-Gm-Message-State: AOAM530MWxqufp+rceDV6hGV3janPIA5amccaap46z+FuKnRnKlrSw8U
        FwaMSDiWyyFu1YMRRXp3sYI=
X-Google-Smtp-Source: ABdhPJyLVsfwZY95sq/VCjUFwjdh4dXE1f5LgZRey1ziDDJSCSZVuoavnF4ICtShwhNrA4pGt/6a0w==
X-Received: by 2002:a17:90b:4b0d:b0:1dc:3d21:72c1 with SMTP id lx13-20020a17090b4b0d00b001dc3d2172c1mr14403583pjb.21.1651868190390;
        Fri, 06 May 2022 13:16:30 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:a5d1:d7b7:dd61:c87b])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db8200b0015e8d4eb268sm2160156pld.178.2022.05.06.13.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:16:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Milian Wolff <milian.wolff@kdab.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [RFC 0/4] perf record: Implement off-cpu profiling with BPF (v2)
Date:   Fri,  6 May 2022 13:16:23 -0700
Message-Id: <20220506201627.85598-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
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

This is the second version of off-cpu profiling support.  Together with
(PMU-based) cpu profiling, it can show holistic view of the performance
characteristics of your application or system.

Changes in v2)
 * change sched_switch argument handling (Andrii)
 * use task local storage (Hao)
 * fix build error on !BUILD_BPF_SKEL (kernel test robot)
 * add documentation regard fp callstack (Milian)
 
 
With BPF, it can aggregate scheduling stats for interested tasks
and/or states and convert the data into a form of perf sample records.
I chose the bpf-output event which is a software event supposed to be
consumed by BPF programs and renamed it as "offcpu-time".  So it
requires no change on the perf report side except for setting sample
types of bpf-output event.

Basically it collects userspace callstack for tasks as it's what users
want mostly.  Maybe we can add support for the kernel stacks but I'm
afraid that it'd cause more overhead.  So the offcpu-time event will
always have callchains regardless of the command line option, and it
enables the children mode in perf report by default.

It adds --off-cpu option to perf record like below:

  $ sudo perf record -a --off-cpu -- perf bench sched messaging -l 1000
  # Running 'sched/messaging' benchmark:
  # 20 sender and receiver processes per group
  # 10 groups == 400 processes run

     Total time: 1.518 [sec]
  [ perf record: Woken up 9 times to write data ]
  [ perf record: Captured and wrote 5.313 MB perf.data (53341 samples) ]

Then we can run perf report as usual.  The below is just to skip less
important parts.

  $ sudo perf report --stdio --call-graph=no --percent-limit=2
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 52K of event 'cycles'
  # Event count (approx.): 42522453276
  #
  # Children      Self  Command          Shared Object     Symbol                            
  # ........  ........  ...............  ................  ..................................
  #
       9.58%     9.58%  sched-messaging  [kernel.vmlinux]  [k] audit_filter_rules.constprop.0
       8.46%     8.46%  sched-messaging  [kernel.vmlinux]  [k] audit_filter_syscall
       4.54%     4.54%  sched-messaging  [kernel.vmlinux]  [k] copy_user_enhanced_fast_string
       2.94%     2.94%  sched-messaging  [kernel.vmlinux]  [k] unix_stream_read_generic
       2.45%     2.45%  sched-messaging  [kernel.vmlinux]  [k] memcg_slab_free_hook
  
  
  # Samples: 983  of event 'offcpu-time'
  # Event count (approx.): 684538813464
  #
  # Children      Self  Command          Shared Object         Symbol                    
  # ........  ........  ...............  ....................  ..........................
  #
      83.86%     0.00%  sched-messaging  libc-2.33.so          [.] __libc_start_main
      83.86%     0.00%  sched-messaging  perf                  [.] cmd_bench
      83.86%     0.00%  sched-messaging  perf                  [.] main
      83.86%     0.00%  sched-messaging  perf                  [.] run_builtin
      83.64%     0.00%  sched-messaging  perf                  [.] bench_sched_messaging
      41.35%    41.35%  sched-messaging  libpthread-2.33.so    [.] __read
      38.88%    38.88%  sched-messaging  libpthread-2.33.so    [.] __write
       3.41%     3.41%  sched-messaging  libc-2.33.so          [.] __poll

The perf bench sched messaging created 400 processes to send/receive
messages through unix sockets.  It spent a large portion of cpu cycles
for audit filter and read/copy the messages while most of the
offcpu-time was in read and write calls.

You can get the code from 'perf/offcpu-v2' branch in my tree at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Enjoy! :)

Thanks,
Namhyung


Namhyung Kim (4):
  perf report: Do not extend sample type of bpf-output event
  perf record: Enable off-cpu analysis with BPF
  perf record: Implement basic filtering for off-cpu
  perf record: Handle argument change in sched_switch

 tools/perf/Documentation/perf-record.txt |  10 +
 tools/perf/Makefile.perf                 |   1 +
 tools/perf/builtin-record.c              |  21 ++
 tools/perf/util/Build                    |   1 +
 tools/perf/util/bpf_off_cpu.c            | 298 +++++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c   | 209 ++++++++++++++++
 tools/perf/util/evsel.c                  |   4 +-
 tools/perf/util/off_cpu.h                |  24 ++
 8 files changed, 566 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/bpf_off_cpu.c
 create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c
 create mode 100644 tools/perf/util/off_cpu.h


base-commit: 33cd6928039c6bf18cf0baec936924d908e6c89b
-- 
2.36.0.512.ge40c2bad7a-goog

