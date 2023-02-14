Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A73696A7F
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 17:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjBNQ6t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 11:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjBNQ6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 11:58:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738E02E0E7
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 08:58:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id k3so8722245wrv.5
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 08:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/xX8Rrfbzbh+06jOFfFCCqOSJT7x1zNnFCotkZrUAQ=;
        b=r+xPbOljCcT4EyVmsIC3KVV6n71WKLYNfkcS16nQkknZb0StC/w63QRYIl1rUQARqS
         XWOVg9KuFBaVJsDAi+BpU1fW/kdYi7e/AEceoXgqlNf5IOWfPRAdVNXf4WM9JGOBBC88
         GcbartN1e55D7D0O+/UHUCnV2GS2hnvtlXtGBA2+FqedQg9hHuIvEq8Uck539l86GZMg
         /RRWAzlJnY+j+zXcvodzq4HaqPmLV41tzrSgZUuPwt8k3o8hML0kmOpx6+lSyxSVo9LD
         MN2Sn9joDzfFQ4UO6AZ5VqywpnHCwdn/jUqQ8naDqPJiRWKjdYg7bMdxyGbCVg8KjRhp
         3l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/xX8Rrfbzbh+06jOFfFCCqOSJT7x1zNnFCotkZrUAQ=;
        b=AnXAlVcazxMLwF7pv0owEwHNMji7cABYY4/o7ezvhwm3fhR66ibDlXSEmEH4mB6inn
         80vyRmGPEsZ70QrNCHlOOz3Frf2dQ+E8jI0542sue+Jmmuim90odVlb9Gf+4kyV/wc5T
         zglk0wch6SGFw2Pis29xJeGgdH/nNCVS7AQSW4topvSMI8GqvnoUf8cuFQPx09OmB9Fd
         5dCI3gR0zLk9A7Cr1f+raPfrrpwDDYEE6jUH1VVAg6LCTTCMRC+12yKYamRS2EVs6oyM
         Cprzb1mZ18dRa7NiiOX497nb1cP0CZLlOhlncN6JXGhaUMuQ57W90ThYuFko39xixH+w
         51bA==
X-Gm-Message-State: AO0yUKUeJ1zKwBHo67txWejNtHNHQ11v5iBpFXEwyIeSEQ4JgmDPseEW
        +cXRjFGUsfmI1mQSj1kAS80f5++d1Ym5RbklN+Vaxg==
X-Google-Smtp-Source: AK7set+37FrULhwk/P5yRsTnwdL99a1cBk48c5GMJp96S1bDqGaZ6CFXI+hQhDXNhFppR2kv2Wcio3yKEnx7Cd4MLHE=
X-Received: by 2002:adf:f508:0:b0:2c5:4ce4:94c9 with SMTP id
 q8-20020adff508000000b002c54ce494c9mr144354wro.627.1676393890857; Tue, 14 Feb
 2023 08:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20230214050452.26390-1-namhyung@kernel.org>
In-Reply-To: <20230214050452.26390-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Feb 2023 08:57:58 -0800
Message-ID: <CAP-5=fWG6f_N7PN+A5v61jGsuKobNxCvo4-H0twAZDGQVfa7cQ@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/7] perf record: Implement BPF sample filter (v1)
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 9:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> There have been requests for more sophisticated perf event sample
> filtering based on the sample data.  Recently the kernel added BPF
> programs can access perf sample data and this is the userspace part
> to enable such a filtering.
>
> This still has some rough edges and needs more improvements.  But
> I'd like to share the current work and get some feedback for the
> directions and idea for further improvements.
>
> The kernel changes are in the tip.git tree (perf/core branch) for now.
> perf record has --filter option to set filters on the last specified
> event in the command line.  It worked only for tracepoints and Intel
> PT events so far.  This patchset extends it to have 'bpf:' prefix in
> order to enable the general sample filters using BPF for any events.
>
> A new filter expression parser was added (using flex/bison) to process
> the filter string.  Right now, it only accepts very simple expressions
> separated by comma.  I'd like to keep the filter expression as simple
> as possible.
>
> It requires samples satisfy all the filter expressions otherwise it'd
> drop the sample.  IOW filter expressions are connected with logical AND
> operations implicitly.
>
> Essentially the BPF filter expression is:
>
>   "bpf:" <term> <operator> <value> ("," <term> <operator> <value>)*
>
> The <term> can be one of:
>   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
>   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
>   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
>   mem_dtlb, mem_blk, mem_hops
>
> The <operator> can be one of:
>   ==, !=, >, >=, <, <=, &
>
> The <value> can be one of:
>   <number> (for any term)
>   na, load, store, pfetch, exec (for mem_op)
>   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
>   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
>   remote (for mem_remote)
>   na, locked (for mem_locked)
>   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
>   na, by_data, by_addr (for mem_blk)
>   hops0, hops1, hops2, hops3 (for mem_hops)
>
> I plan to improve it with range expressions like for ip or addr and it
> should support symbols like the existing addr-filters.  Also cgroup
> should understand and convert cgroup names to IDs.
>
> Let's take a look at some examples.  The following is to profile a user
> program on the command line.  When the frequency mode is used, it starts
> with a very small period (i.e. 1) and adjust it on every interrupt (NMI)
> to catch up the given frequency.
>
>   $ ./perf record -- ./perf test -w noploop
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.263 MB perf.data (4006 samples) ]
>
>   $ ./perf script -F pid,period,event,ip,sym | head
>   36695          1 cycles:  ffffffffbab12ddd perf_event_exec
>   36695          1 cycles:  ffffffffbab12ddd perf_event_exec
>   36695          5 cycles:  ffffffffbab12ddd perf_event_exec
>   36695         46 cycles:  ffffffffbab12de5 perf_event_exec
>   36695       1163 cycles:  ffffffffba80a0eb x86_pmu_disable_all
>   36695       1304 cycles:  ffffffffbaa19507 __hrtimer_get_next_event
>   36695       8143 cycles:  ffffffffbaa186f9 __run_timers
>   36695      69040 cycles:  ffffffffbaa0c393 rcu_segcblist_ready_cbs
>   36695     355117 cycles:            4b0da4 noploop
>   36695     321861 cycles:            4b0da4 noploop
>
> If you want to skip the first few samples that have small periods, you
> can do like this (note it requires root due to BPF).
>
>   $ sudo ./perf record -e cycles --filter 'bpf: period > 10000' -- ./perf test -w noploop
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.262 MB perf.data (3990 samples) ]
>
>   $ sudo ./perf script -F pid,period,event,ip,sym | head
>   39524      58253 cycles:  ffffffffba97dac0 update_rq_clock
>   39524     232657 cycles:            4b0da2 noploop
>   39524     210981 cycles:            4b0da2 noploop
>   39524     282882 cycles:            4b0da4 noploop
>   39524     392180 cycles:            4b0da4 noploop
>   39524     456058 cycles:            4b0da4 noploop
>   39524     415196 cycles:            4b0da2 noploop
>   39524     462721 cycles:            4b0da4 noploop
>   39524     526272 cycles:            4b0da2 noploop
>   39524     565569 cycles:            4b0da4 noploop
>
> Maybe more useful example is when it deals with precise memory events.
> On AMD processors with IBS, you can filter only memory load with L1
> dTLB is missed like below.
>
>   $ sudo ./perf record -ad -e ibs_op//p \
>   > --filter 'bpf: mem_op == load, mem_dtlb > l1_hit' sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.338 MB perf.data (15 samples) ]
>
>   $ sudo ./perf script -F data_src | head
>           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
>           49080142 |OP LOAD|LVL L1 hit|SNP N/A|TLB L2 hit|LCK N/A|BLK  N/A
>           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
>           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
>           51088842 |OP LOAD|LVL L3 or Remote Cache (1 hop) hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
>           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
>           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
>           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
>           49080442 |OP LOAD|LVL L2 hit|SNP N/A|TLB L2 hit|LCK N/A|BLK  N/A
>           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
>
> You can also check the number of dropped samples in LOST_SAMPLES events
> using perf report --stat command.
>
>   $ sudo ./perf report --stat
>
>   Aggregated stats:
>              TOTAL events:      16066
>               MMAP events:         22  ( 0.1%)
>               COMM events:       4166  (25.9%)
>               EXIT events:          1  ( 0.0%)
>           THROTTLE events:        816  ( 5.1%)
>         UNTHROTTLE events:        613  ( 3.8%)
>               FORK events:       4165  (25.9%)
>             SAMPLE events:         15  ( 0.1%)
>              MMAP2 events:       6133  (38.2%)
>       LOST_SAMPLES events:          1  ( 0.0%)
>            KSYMBOL events:         69  ( 0.4%)
>          BPF_EVENT events:         57  ( 0.4%)
>     FINISHED_ROUND events:          3  ( 0.0%)
>           ID_INDEX events:          1  ( 0.0%)
>         THREAD_MAP events:          1  ( 0.0%)
>            CPU_MAP events:          1  ( 0.0%)
>          TIME_CONV events:          1  ( 0.0%)
>      FINISHED_INIT events:          1  ( 0.0%)
>   ibs_op//p stats:
>             SAMPLE events:         15
>       LOST_SAMPLES events:       3991
>
> Note that the total aggregated stats show 1 LOST_SAMPLES event but
> per event stats show 3991 events because it's the actual number of
> dropped samples while the aggregated stats has the number of record.
> Maybe we need to change the per-event stats to 'LOST_SAMPLES count'
> to avoid the confusion.
>
> The code is available at 'perf/bpf-filter-v1' branch in my tree.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
>
> Again, you need tip/perf/core kernel for this to work.
> Any feedback is welcome.

This is great! I wonder about related clean up:

 - can we remove BPF events as this is a better feature?
   - I believe BPF events are flaky, seldom used (with the exception
of the augmented syscalls for perf trace, which really should move to
a BPF skeleton as most people don't know how to use it) and they add a
bunch of complexity. A particular complexity I care about is that the
path separator forward slash ('/') is also the modifier separator for
events.

 - what will happen with multiple events/metrics? Perhaps there should
be a way of listing filters so that each filter applies to the
appropriate event in the event list, like cgroups and -G. For metrics
we shuffle the list of events and so maybe the filters need some way
to specify which event they apply to.

 - It feels like there should be some BPF way of overcoming the fixed
length number of filters so it is still bounded but not a hardcoded
number.

Thanks,
Ian


> Thanks,
> Namhyung
>
> Namhyung Kim (7):
>   perf bpf filter: Introduce basic BPF filter expression
>   perf bpf filter: Implement event sample filtering
>   perf record: Add BPF event filter support
>   perf record: Record dropped sample count
>   perf bpf filter: Add 'pid' sample data support
>   perf bpf filter: Add more weight sample data support
>   perf bpf filter: Add data_src sample data support
>
>  tools/perf/Documentation/perf-record.txt     |  10 +-
>  tools/perf/Makefile.perf                     |   2 +-
>  tools/perf/builtin-record.c                  |  46 ++++--
>  tools/perf/util/Build                        |  16 ++
>  tools/perf/util/bpf-filter.c                 | 117 ++++++++++++++
>  tools/perf/util/bpf-filter.h                 |  48 ++++++
>  tools/perf/util/bpf-filter.l                 | 146 ++++++++++++++++++
>  tools/perf/util/bpf-filter.y                 |  55 +++++++
>  tools/perf/util/bpf_counter.c                |   3 +-
>  tools/perf/util/bpf_skel/sample-filter.h     |  25 +++
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 152 +++++++++++++++++++
>  tools/perf/util/evsel.c                      |   2 +
>  tools/perf/util/evsel.h                      |   7 +-
>  tools/perf/util/parse-events.c               |   4 +
>  tools/perf/util/session.c                    |   3 +-
>  15 files changed, 615 insertions(+), 21 deletions(-)
>  create mode 100644 tools/perf/util/bpf-filter.c
>  create mode 100644 tools/perf/util/bpf-filter.h
>  create mode 100644 tools/perf/util/bpf-filter.l
>  create mode 100644 tools/perf/util/bpf-filter.y
>  create mode 100644 tools/perf/util/bpf_skel/sample-filter.h
>  create mode 100644 tools/perf/util/bpf_skel/sample_filter.bpf.c
>
>
> base-commit: 37f322cd58d81a9d46456531281c908de9ef6e42
> --
> 2.39.1.581.gbfd45094c4-goog
>
