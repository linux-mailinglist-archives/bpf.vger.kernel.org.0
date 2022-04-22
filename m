Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE6950BB0F
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 17:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380545AbiDVPIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449145AbiDVPIH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 11:08:07 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C88522FC;
        Fri, 22 Apr 2022 08:05:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c12so11435112plr.6;
        Fri, 22 Apr 2022 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtTWLu/07PaOqhse6jPfkw/FT33D7RJcBrLdB+qnolI=;
        b=k2h5CsfW2cvMeKAGwWp1BgWfxVsP6MJtJPLAM9uctk5G6UJ93AMkx+KlKOvmYY5xha
         3c+2OdIiViZcO3bWfEIwhLb9npGUN4t1SQMP96btRm7ch2ebJvzNmS0tU6nIgd2mrD4W
         LezwROIYiXq3wAwBAczXOVgxj9EZzNjNlbebeLumaqGZ3jPFddMjA/Mg8wlgvfQb6AHA
         2mdjqsKETwZwoA1daYhb417PzMKzcdJYYtsD3L0Ate9/LWtZCOwBSOT5dU+iEwTChgVX
         OisTgM/ZzM/mGZNdEYbG8kgDOkOGiKtbdgw99Sbaky3DNkhPLqCuB8kTShEFjDxuxXLy
         uETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QtTWLu/07PaOqhse6jPfkw/FT33D7RJcBrLdB+qnolI=;
        b=HiWqJYcVskWxhHRN1emlt6Itx1cKGM932dMtx2X2hQ1py+j0cwWCOe0Ucm+452WD6C
         SZ8xaGWTM1rev5xTORPcJG1tnNHsO8FNLdp1+UlY7VF7b6+M6Ip81+WnsAFJYJb2YFsl
         Runjcj3t2sYCCvWH7CNnduCTkU56XoV6H7qoGEXaKeKpxzD2WarsB1yfvrRQnHfInQ+V
         Dl7i4LhXidWBVB8GawQmEECQ2yukPVkd696ZPKKyM+jA5YtYBhGp5KzaxXukbqAqM87q
         dqctu2ym1I/3bgN5FsCOp25r2XfRM/4ogFCG3TYLyNaTjWHL6muMrQsndWPAtq7ezS24
         Hf5A==
X-Gm-Message-State: AOAM533AZl4bk6SHNq2lzXp7G9qTofOcfvrrguCx/OTxfF46dsTWCPqH
        ITk1Eg5n720P6mXAj4K57XU=
X-Google-Smtp-Source: ABdhPJyG0Bi7wHXakeULUUP8mfqC7vGZ5F3da2juiBy/AM8tA2hacLE7yktHHCjGyKofitzJkCXpqg==
X-Received: by 2002:a17:902:8d8e:b0:159:4f6:c4aa with SMTP id v14-20020a1709028d8e00b0015904f6c4aamr4862995plo.115.1650639909417;
        Fri, 22 Apr 2022 08:05:09 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4f00:3590:5deb:57fb:7322:f9d4])
        by smtp.gmail.com with ESMTPSA id s11-20020a6550cb000000b0039daee7ed0fsm2390279pgp.19.2022.04.22.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 08:05:08 -0700 (PDT)
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
Subject: [RFC RESEND 0/4] perf record: Implement off-cpu profiling with BPF (v1)
Date:   Fri, 22 Apr 2022 08:05:03 -0700
Message-Id: <20220422150507.222488-1-namhyung@kernel.org>
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

(Resending with a quick fix for a missing header.)

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


*** BLURB HERE ***

Namhyung Kim (4):
  perf report: Do not extend sample type of bpf-output event
  perf record: Enable off-cpu analysis with BPF
  perf record: Implement basic filtering for off-cpu
  perf record: Handle argument change in sched_switch

 tools/perf/Makefile.perf               |   1 +
 tools/perf/builtin-record.c            |  21 ++
 tools/perf/util/Build                  |   1 +
 tools/perf/util/bpf_off_cpu.c          | 302 +++++++++++++++++++++++++
 tools/perf/util/bpf_skel/off_cpu.bpf.c | 214 ++++++++++++++++++
 tools/perf/util/evsel.c                |   4 +-
 tools/perf/util/off_cpu.h              |  24 ++
 7 files changed, 565 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/bpf_off_cpu.c
 create mode 100644 tools/perf/util/bpf_skel/off_cpu.bpf.c
 create mode 100644 tools/perf/util/off_cpu.h


base-commit: 41204da4c16071be9090940b18f566832d46becc
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

