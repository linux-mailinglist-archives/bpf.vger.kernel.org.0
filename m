Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF58452C696
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 00:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiERWrk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 18:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiERWre (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 18:47:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B5115E488;
        Wed, 18 May 2022 15:47:28 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so7060441pjb.0;
        Wed, 18 May 2022 15:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PofGANH0wSKuN3MxZLGBlu0sJUi3OAWzZl6QDp0WGeY=;
        b=bxrg4DeP9YtzmamFGAv1nr70QDxbQuWWxG3x87lMwVjsLpNAlMas4QHCJX8wdQyJCJ
         3uuU9g+t5zRXwHBsxlYehvW/Op0mbM5VyMLw1OOQq7yamHKY8NNK9iYdMoLNoYd4IaJy
         JbIteynHQrjrSsYB74lzLQy/kC7B0sApnuY+sWrjuB9/6S+cNEo0GRq9LbTVTRNk0Vh8
         gs8sbsguvT2MRGSCqmt9J6tkkS7gvHuDKmzUiSEjmfxxkq8BxAhdKk+Vh9fAdqoQUFKk
         girM/I6aENvKA13SPsHX7hHYQksFFC8FixvCetsuOGTO8NI1crl0JbjH4cZoc3teQKe1
         oORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PofGANH0wSKuN3MxZLGBlu0sJUi3OAWzZl6QDp0WGeY=;
        b=Ypad2AzqwPgIGP5kp6NSePXiTOSwBsQf6Xq3/SKD1eSkAOBejYSxo+OpFVC0uOFEXL
         7j6i2KrQfDKXF5mNWRwI5ByScOnwwbILBXmOOUxR9FImGJBO0FLUIijSlT9Jl6QaNM/J
         qRGSNcsBcV+4AAX2taInQQ1fx6bbwuZe5EK8EtfY7lF5A4qQftUXTcC3CXrxIxK46U1u
         GDPwpHoC9FGAb4++5E8hEnfA5UIO0eC+sSevTQ0S+x/MX9HY2YRDBAbjnudFtP3o2UoC
         dDCWboPm/aLtGTUkedK7rpLqfljsRP9e/v3YnJC5b3YqwiUMwV1xrcW9AzWmkwftOqs+
         6LNw==
X-Gm-Message-State: AOAM530UB8xFcTnw7C7u9r9A/7aZ9rS6XvgnESVmT+Ho+meWsUJJzFnm
        eOsdoJB8MD4IcI3jTmPnTxU=
X-Google-Smtp-Source: ABdhPJwq0Ng6QG1p3vpFLMXLcA8syHFLqpbDtRggyx6XOOz+Vqkyz1ZO2Ho9a//RawE/1RLW38YNBg==
X-Received: by 2002:a17:90a:f28e:b0:1df:311b:66ae with SMTP id fs14-20020a17090af28e00b001df311b66aemr1711430pjb.185.1652914047810;
        Wed, 18 May 2022 15:47:27 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:a718:cbfe:31cb:3a04])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b0015e8d4eb2besm2214100plr.264.2022.05.18.15.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:47:27 -0700 (PDT)
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
Subject: [RFC 0/6] perf record: Implement off-cpu profiling with BPF (v3)
Date:   Wed, 18 May 2022 15:47:19 -0700
Message-Id: <20220518224725.742882-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
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

Changes in v3)
 * address most of review comments from Arnaldo
 * handle the new sched_switch argument ordering
 * add cgroup filter/sampling support
 * add a shell test

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

You can get the code from 'perf/offcpu-v3' branch in my tree at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Enjoy! :)

Thanks,
Namhyung


Namhyung Kim (6):
  perf report: Do not extend sample type of bpf-output event
  perf record: Enable off-cpu analysis with BPF
  perf record: Implement basic filtering for off-cpu
  perf record: Handle argument change in sched_switch
  perf record: Add cgroup support for off-cpu profiling
  perf test: Add a basic offcpu profiling test

 tools/perf/Documentation/perf-record.txt |  10 +
 tools/perf/Makefile.perf                 |   1 +
 tools/perf/builtin-record.c              |  25 ++
 tools/perf/tests/shell/record_offcpu.sh  |  60 ++++
 tools/perf/util/Build                    |   1 +
 tools/perf/util/bpf_off_cpu.c            | 338 +++++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c   | 229 +++++++++++++++
 tools/perf/util/evsel.c                  |   4 +-
 tools/perf/util/off_cpu.h                |  29 ++
 9 files changed, 695 insertions(+), 2 deletions(-)
 create mode 100755 tools/perf/tests/shell/record_offcpu.sh
 create mode 100644 tools/perf/util/bpf_off_cpu.c
 create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c
 create mode 100644 tools/perf/util/off_cpu.h


base-commit: 6a973e291978bfd1ff8bb3184e337309acc16d69
-- 
2.36.1.124.g0e6072fb45-goog

