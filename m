Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776750AF96
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 07:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiDVFkB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiDVFg4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 01:36:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC64F445;
        Thu, 21 Apr 2022 22:34:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q1so7326529plx.13;
        Thu, 21 Apr 2022 22:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3WwvYrCiMoXiXB8bkTFdVRHDp/BLWRJVTqviHh1CBQ=;
        b=j24LGTSEVZulAYCf/lkSnkfaRGHDyZ6p+O2hu/4bVvK8fI30rwFK3lBDScOR70vHN0
         sXSR1qzT2C2Fg4R30OUV6By6DT7T26UUj1tEgGE6OAAAnr4dYx4F1x18vnZN4b+XkpZW
         oXtjuslbNU4gYvIguhm/Oh2Hx96JieES23/yw+LuIkvDFifxWYP/McvoZDLi0iXWfAze
         boh0R1Son2MEYNq/RZaiMlJwhwaWf69VuSj7U3QKOUtrOuSgHOLKGKkz5eHdnzh60QWn
         PhXCjjuyFw6RudVN3jm9aTg28LlL0WU9lden6j6cCA77QGcYUl8vEkxOyxzA6WiSQ6iX
         PiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=A3WwvYrCiMoXiXB8bkTFdVRHDp/BLWRJVTqviHh1CBQ=;
        b=0WOonxvOL29JwoiOoXAfyWCtvDb86dgeZkxThZh/N6XjnzMLcTBJxmkwqQxApOJtI7
         9/ej5AgSG3cFKjaSY6Wp1wtRRT0OUQYRH02f0Y6Eh9jUb4vSsduPO1erHfm4I8A/xAqT
         Uv2T6H4y99PYZwXxs3acLfU9BOnXHLoDba2/X0L4dYrzqjMywS3KW9Ktlg5mY/QZ23ij
         mnCrbU/v61w37wpktvLMFKJPtWXZ/0LQN0yXelclFKjMZO1bHLh52ETdUEj93lkNi2TH
         EJxws8veps9cQCG5+fFuQwE0PzCzCGoUnNa8kOAXV25OtKQVjhIlnV/uNSs0lQ5tX06v
         CJWA==
X-Gm-Message-State: AOAM530DmkTCb2MTw9znJEf3t+ZiZn0+bhFjexmrtGjOE1ji9J8C2iut
        Eb0/UVsovcJwweuKGrgKKVQUiUFubOU=
X-Google-Smtp-Source: ABdhPJxh6Cpm3ngQB+oSWcZu103J5MQpio+rtTSaFlo35CS84011RtLat/k7inehKOjm3grGmk8MJw==
X-Received: by 2002:a17:902:6a8a:b0:156:8ff6:daf0 with SMTP id n10-20020a1709026a8a00b001568ff6daf0mr2847853plk.117.1650605643561;
        Thu, 21 Apr 2022 22:34:03 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:32e3:a023:46c1:80cd])
        by smtp.gmail.com with ESMTPSA id 204-20020a6302d5000000b00385f29b02b2sm886519pgc.50.2022.04.21.22.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 22:34:02 -0700 (PDT)
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
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Blake Jones <blakejones@google.com>
Subject: [RFC 0/4] perf record: Implement off-cpu profiling with BPF (v1)
Date:   Thu, 21 Apr 2022 22:33:57 -0700
Message-Id: <20220422053401.208207-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
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

This is the first version of off-cpu profiling support.  Together with
(PMU-based) cpu profiling, it can show holistic view of the performance
characteristics of your application or system.

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

You can get the code from 'perf/offcpu-v1' branch in my tree at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Enjoy! :)

Thanks,
Namhyung


Namhyung Kim (4):
  perf report: Do not extend sample type of bpf-output event
  perf record: Enable off-cpu analysis with BPF
  perf record: Implement basic filtering for off-cpu
  perf record: Handle argument change in sched_switch

 tools/perf/Makefile.perf               |   1 +
 tools/perf/builtin-record.c            |  21 ++
 tools/perf/util/Build                  |   1 +
 tools/perf/util/bpf_off_cpu.c          | 301 +++++++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 214 ++++++++++++++++++
 tools/perf/util/evsel.c                |   4 +-
 6 files changed, 540 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/bpf_off_cpu.c
 create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c


base-commit: 41204da4c16071be9090940b18f566832d46becc
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

