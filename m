Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3069FF1C
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 00:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjBVXBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 18:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjBVXBr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 18:01:47 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE4410AE;
        Wed, 22 Feb 2023 15:01:45 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z10so4975754pgr.8;
        Wed, 22 Feb 2023 15:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UINcpy434SfhopxdYyHr2G9QMCc2YVPa4kQ0VAtxtDE=;
        b=JPCEuOTAnInQd+Bhfd+BxAc8MI1m9hn+jQD7fQkEpJNaZo4yiAspAYYSAY0A4rU20d
         7PAv4mO4QMWTB5+HQap0F/NaAytB3aDAwfI/D99hPE/VXOkpHc1cxft8cNqrX9/lP3cZ
         BQjVCuL+mP9mu1lEUkW07xOcU8AiIxDHEN7ZxIKu9CgXPnY8fLcAK/gqznJmGTmepHKv
         GliqaQ7FjIjOryPQZygqWzhhMNdIjV3OY4lhGJDWC9uuUp8Bm0GejkzTpVmeKrFe/4uU
         hs7wYoS1eEuWkA7d9vW1xJFvmwrMb+jQJy3HQ8YUlvES3aisLGv3f1dhou7wM2mGpuNr
         WP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UINcpy434SfhopxdYyHr2G9QMCc2YVPa4kQ0VAtxtDE=;
        b=YxhhUbIqcOnoGaWyoKhFtWXhzQbDH3GHmC2dElF+zMYtrnD5ixhjUtApwGYykz1cHz
         eC/pShv81dVZScXaOXvRz2pGXmrSsz/gUcJlS0dqr0sXoOSkrrbsHs4hYyvX5dSzqtc6
         Zj3ja5Wz8RAAWpPevXHWrgbj3lx8J9kQ1nP7RslXajNLcEsKVNYRV1QZ7bRWBNpbCxf1
         17LpbqpnVFLV9fy6BZ7eY9is1N3SgRBdSq05yT2PAalectNhQqIJY0w+noXhHTzTz5tR
         RUzIoqNJT1cZAQeYcRDWt2aNBQEckpWPLKz5yJhXViRFx2PiGujTwKXnBJ8MYHGx+xMb
         2lnw==
X-Gm-Message-State: AO0yUKUk1u2mGzaoBFJnQro5sXM66YUVTs8N7JM2++ng3jUc01yGIOx9
        TXLv1zwCcHMVh7UcaBn3YRo=
X-Google-Smtp-Source: AK7set94wsCqhcUOg601Zmcr0TbdbA01IviNTaS7o0wvyVvMhpYSZswHaeagU+HlWV3JTIHI9nz+Lw==
X-Received: by 2002:aa7:96c9:0:b0:5a9:c682:831d with SMTP id h9-20020aa796c9000000b005a9c682831dmr9003149pfq.13.1677106904735;
        Wed, 22 Feb 2023 15:01:44 -0800 (PST)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:8f76:587d:f250:fecf])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b005ccbe5346ebsm3895127pfm.163.2023.02.22.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:01:44 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>, Hao Luo <haoluo@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC/PATCHSET 0/8] perf record: Implement BPF sample filter (v3)
Date:   Wed, 22 Feb 2023 15:01:33 -0800
Message-Id: <20230222230141.1729048-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
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

There have been requests for more sophisticated perf event sample
filtering based on the sample data.  Recently the kernel added BPF
programs can access perf sample data and this is the userspace part
to enable such a filtering.

This still has some rough edges and needs more improvements.  But
I'd like to share the current work and get some feedback for the
directions and idea for further improvements.

v3 changes)
 * fix build error on old kernels/vmlinux  (Arnaldo)
 * move the logic to evlist__apply_filters  (Jiri)
 * improve error message for bad input

v2 changes)
 * fix build error with the misc field  (Jiri)
 * add a destructor for filter expr  (Ian)
 * remove 'bpf:' prefix  (Arnaldo)
 * add '||' operator

The required kernel changes are now in the mainline tree (for v6.3).
perf record has --filter option to set filters on the last specified
event in the command line.  It worked only for tracepoints and Intel
PT events so far.  This patchset extends it to use BPF in order to
enable the general sample filters for any events.

A new filter expression parser was added (using flex/bison) to process
the filter string.  Right now, it only accepts very simple expressions
separated by comma.  I'd like to keep the filter expression as simple
as possible.

It requires samples satisfy all the filter expressions otherwise it'd
drop the sample.  IOW filter expressions are connected with logical AND
operations unless they used "||" explicitly.  So if user has something
like 'A, B || C, D', then BOTH A and D should be true AND either B or C
also needs to be true.

Essentially the BPF filter expression is:

  <term> <operator> <value> (("," | "||") <term> <operator> <value>)*

The <term> can be one of:
  ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
  code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
  p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
  mem_dtlb, mem_blk, mem_hops

The <operator> can be one of:
  ==, !=, >, >=, <, <=, &

The <value> can be one of:
  <number> (for any term)
  na, load, store, pfetch, exec (for mem_op)
  l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
  na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
  remote (for mem_remote)
  na, locked (for mem_locked)
  na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
  na, by_data, by_addr (for mem_blk)
  hops0, hops1, hops2, hops3 (for mem_hops)

I plan to improve it with range expressions like for ip or addr and it
should support symbols like the existing addr-filters.  Also cgroup
should understand and convert cgroup names to IDs.

Let's take a look at some examples.  The following is to profile a user
program on the command line.  When the frequency mode is used, it starts
with a very small period (i.e. 1) and adjust it on every interrupt (NMI)
to catch up the given frequency.

  $ ./perf record -- ./perf test -w noploop
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.263 MB perf.data (4006 samples) ]

  $ ./perf script -F pid,period,event,ip,sym | head
  36695          1 cycles:  ffffffffbab12ddd perf_event_exec
  36695          1 cycles:  ffffffffbab12ddd perf_event_exec
  36695          5 cycles:  ffffffffbab12ddd perf_event_exec
  36695         46 cycles:  ffffffffbab12de5 perf_event_exec
  36695       1163 cycles:  ffffffffba80a0eb x86_pmu_disable_all
  36695       1304 cycles:  ffffffffbaa19507 __hrtimer_get_next_event
  36695       8143 cycles:  ffffffffbaa186f9 __run_timers
  36695      69040 cycles:  ffffffffbaa0c393 rcu_segcblist_ready_cbs
  36695     355117 cycles:            4b0da4 noploop
  36695     321861 cycles:            4b0da4 noploop

If you want to skip the first few samples that have small periods, you
can do like this (note it requires root due to BPF).

  $ sudo ./perf record -e cycles --filter 'period > 10000' -- ./perf test -w noploop
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.262 MB perf.data (3990 samples) ]

  $ sudo ./perf script -F pid,period,event,ip,sym | head
  39524      58253 cycles:  ffffffffba97dac0 update_rq_clock
  39524     232657 cycles:            4b0da2 noploop
  39524     210981 cycles:            4b0da2 noploop
  39524     282882 cycles:            4b0da4 noploop
  39524     392180 cycles:            4b0da4 noploop
  39524     456058 cycles:            4b0da4 noploop
  39524     415196 cycles:            4b0da2 noploop
  39524     462721 cycles:            4b0da4 noploop
  39524     526272 cycles:            4b0da2 noploop
  39524     565569 cycles:            4b0da4 noploop

Maybe more useful example is when it deals with precise memory events.
On AMD processors with IBS, you can filter only memory load with L1
dTLB is missed like below.

  $ sudo ./perf record -ad -e ibs_op//p \
  > --filter 'mem_op == load, mem_dtlb > l1_hit' sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.338 MB perf.data (15 samples) ]

  $ sudo ./perf script -F data_src | head
          51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
          49080142 |OP LOAD|LVL L1 hit|SNP N/A|TLB L2 hit|LCK N/A|BLK  N/A
          51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
          51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
          51088842 |OP LOAD|LVL L3 or Remote Cache (1 hop) hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
          51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
          51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
          51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
          49080442 |OP LOAD|LVL L2 hit|SNP N/A|TLB L2 hit|LCK N/A|BLK  N/A
          51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A

You can also check the number of dropped samples in LOST_SAMPLES events
using perf report --stat command.

  $ sudo ./perf report --stat

  Aggregated stats:
             TOTAL events:      16066
              MMAP events:         22  ( 0.1%)
              COMM events:       4166  (25.9%)
              EXIT events:          1  ( 0.0%)
          THROTTLE events:        816  ( 5.1%)
        UNTHROTTLE events:        613  ( 3.8%)
              FORK events:       4165  (25.9%)
            SAMPLE events:         15  ( 0.1%)
             MMAP2 events:       6133  (38.2%)
      LOST_SAMPLES events:          1  ( 0.0%)
           KSYMBOL events:         69  ( 0.4%)
         BPF_EVENT events:         57  ( 0.4%)
    FINISHED_ROUND events:          3  ( 0.0%)
          ID_INDEX events:          1  ( 0.0%)
        THREAD_MAP events:          1  ( 0.0%)
           CPU_MAP events:          1  ( 0.0%)
         TIME_CONV events:          1  ( 0.0%)
     FINISHED_INIT events:          1  ( 0.0%)
  ibs_op//p stats:
            SAMPLE events:         15
      LOST_SAMPLES events:       3991

Note that the total aggregated stats show 1 LOST_SAMPLES event but
per event stats show 3991 events because it's the actual number of
dropped samples while the aggregated stats has the number of record.
Maybe we need to change the per-event stats to 'LOST_SAMPLES count'
to avoid the confusion.

The code is available at 'perf/bpf-filter-v3' branch in my tree.

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Any feedback is welcome.

Thanks,
Namhyung

Namhyung Kim (8):
  perf bpf filter: Introduce basic BPF filter expression
  perf bpf filter: Implement event sample filtering
  perf record: Add BPF event filter support
  perf record: Record dropped sample count
  perf bpf filter: Add 'pid' sample data support
  perf bpf filter: Add more weight sample data support
  perf bpf filter: Add data_src sample data support
  perf bpf filter: Add logical OR operator

 tools/lib/perf/include/perf/event.h          |   2 +
 tools/perf/Documentation/perf-record.txt     |  15 +-
 tools/perf/Makefile.perf                     |   2 +-
 tools/perf/builtin-record.c                  |  38 ++--
 tools/perf/util/Build                        |  16 ++
 tools/perf/util/bpf-filter.c                 | 135 +++++++++++++++
 tools/perf/util/bpf-filter.h                 |  49 ++++++
 tools/perf/util/bpf-filter.l                 | 159 +++++++++++++++++
 tools/perf/util/bpf-filter.y                 |  78 +++++++++
 tools/perf/util/bpf_counter.c                |   3 +-
 tools/perf/util/bpf_skel/sample-filter.h     |  27 +++
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 172 +++++++++++++++++++
 tools/perf/util/evlist.c                     |  25 ++-
 tools/perf/util/evsel.c                      |   2 +
 tools/perf/util/evsel.h                      |   7 +-
 tools/perf/util/parse-events.c               |   8 +-
 tools/perf/util/session.c                    |   3 +-
 17 files changed, 706 insertions(+), 35 deletions(-)
 create mode 100644 tools/perf/util/bpf-filter.c
 create mode 100644 tools/perf/util/bpf-filter.h
 create mode 100644 tools/perf/util/bpf-filter.l
 create mode 100644 tools/perf/util/bpf-filter.y
 create mode 100644 tools/perf/util/bpf_skel/sample-filter.h
 create mode 100644 tools/perf/util/bpf_skel/sample_filter.bpf.c


base-commit: f9fa0778ee7349a9aa3d2ea10e9f2ab843a0b44e
-- 
2.39.2.637.g21b0678d19-goog

