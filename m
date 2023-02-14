Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52A169708A
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjBNWRA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBNWRA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:17:00 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED6C2821B;
        Tue, 14 Feb 2023 14:16:58 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id g9so1294894vst.10;
        Tue, 14 Feb 2023 14:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04jHnhvH+/txwkchWSAMJpUfbKbX/M0Q/tqNfGXy8yI=;
        b=4p+SnwVC6CP6UNMekqVryJomG23C3P0God7dSkPLbFcv3KWjFELdbdkfmQqRGgn9/q
         FpEQB95zRPdZ1zjqpsUNw4OvLXSdACMRCcg5B1uiGrdGD8BLrqjKnbiWPFkMCnU9Gid9
         j2/Ws3+iHvXTDeKUUVz2iSZE36Hy6rTZ/YgM+0l8gudt09X/lMxr9js2KU39p2TwMEJA
         /5FSA5UelHgw6SsCZzBeloDsqzhQPVwWPtAXq2eD6p74CqmjOJqofiN6Vx+WSBHaW3pC
         ygqVQ/yRA4WLjxSf9dFmBbJChQVF12FOQmtnnyE4OOPTk2UE2n5ZEnmZhIeKl8lk8XBf
         OFjQ==
X-Gm-Message-State: AO0yUKXGIHw5R0b9+CLqwpSqaPOe4sujCUCtYvy+mWsm+JVzaG8wKNN3
        WLnGIpaBjACz29kn3NqhAB2u7Ec0xSlsEKC9du0=
X-Google-Smtp-Source: AK7set/GLD9VznI4RvLWRGbDYTchmwGJoLLXeX3Di6BGdKoWdBaGPaM6Pm1nwSsH6aWrw73kvbCa6tE8XO7eNYljXGA=
X-Received: by 2002:a67:e206:0:b0:412:194f:e67b with SMTP id
 g6-20020a67e206000000b00412194fe67bmr89272vsa.15.1676413017443; Tue, 14 Feb
 2023 14:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20230214050452.26390-1-namhyung@kernel.org> <CAP-5=fWG6f_N7PN+A5v61jGsuKobNxCvo4-H0twAZDGQVfa7cQ@mail.gmail.com>
 <Y+veEFQZQ3xy4d6w@kernel.org>
In-Reply-To: <Y+veEFQZQ3xy4d6w@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 14 Feb 2023 14:16:46 -0800
Message-ID: <CAM9d7cj5VgsDEPiyyV82DW5RcR1Q8z73VQgGmHrk+wwXym1O4g@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/7] perf record: Implement BPF sample filter (v1)
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Tue, Feb 14, 2023 at 11:16 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Feb 14, 2023 at 08:57:58AM -0800, Ian Rogers escreveu:
> > On Mon, Feb 13, 2023 at 9:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > There have been requests for more sophisticated perf event sample
> > > filtering based on the sample data.  Recently the kernel added BPF
> > > programs can access perf sample data and this is the userspace part
> > > to enable such a filtering.
>
> > > This still has some rough edges and needs more improvements.  But
> > > I'd like to share the current work and get some feedback for the
> > > directions and idea for further improvements.
>
> > > The kernel changes are in the tip.git tree (perf/core branch) for now.
> > > perf record has --filter option to set filters on the last specified
> > > event in the command line.  It worked only for tracepoints and Intel
> > > PT events so far.  This patchset extends it to have 'bpf:' prefix in
> > > order to enable the general sample filters using BPF for any events.
>
> > > A new filter expression parser was added (using flex/bison) to process
> > > the filter string.  Right now, it only accepts very simple expressions
> > > separated by comma.  I'd like to keep the filter expression as simple
> > > as possible.
>
> > > It requires samples satisfy all the filter expressions otherwise it'd
> > > drop the sample.  IOW filter expressions are connected with logical AND
> > > operations implicitly.
>
> > > Essentially the BPF filter expression is:
>
> > >   "bpf:" <term> <operator> <value> ("," <term> <operator> <value>)*
>
> bpf is the technology used for that, but this really is about filtering
> by fields in the sample type, right? So perhaps we could remove that
> "bpf:" part and simply do:
>
>   sudo ./perf record -e cycles --filter 'period > 10000' -- ./perf test -w noploop
>
> And notice that this requires this new mechanism and just use it? It
> gets more compact and should be unambiguous for non-tracepoint events?
>
> And for tracepoint events if we can use both mechanisms, then use the
> tracepoint one since it requires less setup?

Sure, it'd work if we could select the filter mechanism based on the
event type.  One thing to note is BPF filter requires root permission
even if the event itself does not.  Users might be surprised if it
suddenly requires root for their userspace profiling.

>
> Perhaps use "sample_type.field" to disambiguate if we would like to get a
> field from the sample_type and another in the tracepoint if both have
> the same name?

I think the tracepoint filters are different as they work on the event-
specific data field.  From the sample data's perspective, it's just
RAW data and current BPF filters do nothing with it.

So I'd rather simply delegate it to the tracepoint.

>
> And how difficult it would be to just accept the same syntax (or a
> superset) of what is available for tracepoint filters? I.e. allow || as
> well as &&.

Making the parser accept those syntax would not be that difficult.
But I'm afraid of the BPF program doing the job and how we can
build the map to achieve that.

>
> Great stuff!

Thanks!
Namhyung


>
> > > The <term> can be one of:
> > >   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
> > >   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
> > >   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
> > >   mem_dtlb, mem_blk, mem_hops
> > >
> > > The <operator> can be one of:
> > >   ==, !=, >, >=, <, <=, &
> > >
> > > The <value> can be one of:
> > >   <number> (for any term)
> > >   na, load, store, pfetch, exec (for mem_op)
> > >   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
> > >   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
> > >   remote (for mem_remote)
> > >   na, locked (for mem_locked)
> > >   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
> > >   na, by_data, by_addr (for mem_blk)
> > >   hops0, hops1, hops2, hops3 (for mem_hops)
> > >
> > > I plan to improve it with range expressions like for ip or addr and it
> > > should support symbols like the existing addr-filters.  Also cgroup
> > > should understand and convert cgroup names to IDs.
> > >
> > > Let's take a look at some examples.  The following is to profile a user
> > > program on the command line.  When the frequency mode is used, it starts
> > > with a very small period (i.e. 1) and adjust it on every interrupt (NMI)
> > > to catch up the given frequency.
> > >
> > >   $ ./perf record -- ./perf test -w noploop
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.263 MB perf.data (4006 samples) ]
> > >
> > >   $ ./perf script -F pid,period,event,ip,sym | head
> > >   36695          1 cycles:  ffffffffbab12ddd perf_event_exec
> > >   36695          1 cycles:  ffffffffbab12ddd perf_event_exec
> > >   36695          5 cycles:  ffffffffbab12ddd perf_event_exec
> > >   36695         46 cycles:  ffffffffbab12de5 perf_event_exec
> > >   36695       1163 cycles:  ffffffffba80a0eb x86_pmu_disable_all
> > >   36695       1304 cycles:  ffffffffbaa19507 __hrtimer_get_next_event
> > >   36695       8143 cycles:  ffffffffbaa186f9 __run_timers
> > >   36695      69040 cycles:  ffffffffbaa0c393 rcu_segcblist_ready_cbs
> > >   36695     355117 cycles:            4b0da4 noploop
> > >   36695     321861 cycles:            4b0da4 noploop
> > >
> > > If you want to skip the first few samples that have small periods, you
> > > can do like this (note it requires root due to BPF).
> > >
> > >   $ sudo ./perf record -e cycles --filter 'bpf: period > 10000' -- ./perf test -w noploop
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.262 MB perf.data (3990 samples) ]
> > >
> > >   $ sudo ./perf script -F pid,period,event,ip,sym | head
> > >   39524      58253 cycles:  ffffffffba97dac0 update_rq_clock
> > >   39524     232657 cycles:            4b0da2 noploop
> > >   39524     210981 cycles:            4b0da2 noploop
> > >   39524     282882 cycles:            4b0da4 noploop
> > >   39524     392180 cycles:            4b0da4 noploop
> > >   39524     456058 cycles:            4b0da4 noploop
> > >   39524     415196 cycles:            4b0da2 noploop
> > >   39524     462721 cycles:            4b0da4 noploop
> > >   39524     526272 cycles:            4b0da2 noploop
> > >   39524     565569 cycles:            4b0da4 noploop
> > >
> > > Maybe more useful example is when it deals with precise memory events.
> > > On AMD processors with IBS, you can filter only memory load with L1
> > > dTLB is missed like below.
> > >
> > >   $ sudo ./perf record -ad -e ibs_op//p \
> > >   > --filter 'bpf: mem_op == load, mem_dtlb > l1_hit' sleep 1
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 1.338 MB perf.data (15 samples) ]
> > >
> > >   $ sudo ./perf script -F data_src | head
> > >           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
> > >           49080142 |OP LOAD|LVL L1 hit|SNP N/A|TLB L2 hit|LCK N/A|BLK  N/A
> > >           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
> > >           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
> > >           51088842 |OP LOAD|LVL L3 or Remote Cache (1 hop) hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
> > >           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
> > >           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
> > >           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
> > >           49080442 |OP LOAD|LVL L2 hit|SNP N/A|TLB L2 hit|LCK N/A|BLK  N/A
> > >           51080242 |OP LOAD|LVL LFB/MAB hit|SNP N/A|TLB L2 miss|LCK N/A|BLK  N/A
> > >
> > > You can also check the number of dropped samples in LOST_SAMPLES events
> > > using perf report --stat command.
> > >
> > >   $ sudo ./perf report --stat
> > >
> > >   Aggregated stats:
> > >              TOTAL events:      16066
> > >               MMAP events:         22  ( 0.1%)
> > >               COMM events:       4166  (25.9%)
> > >               EXIT events:          1  ( 0.0%)
> > >           THROTTLE events:        816  ( 5.1%)
> > >         UNTHROTTLE events:        613  ( 3.8%)
> > >               FORK events:       4165  (25.9%)
> > >             SAMPLE events:         15  ( 0.1%)
> > >              MMAP2 events:       6133  (38.2%)
> > >       LOST_SAMPLES events:          1  ( 0.0%)
> > >            KSYMBOL events:         69  ( 0.4%)
> > >          BPF_EVENT events:         57  ( 0.4%)
> > >     FINISHED_ROUND events:          3  ( 0.0%)
> > >           ID_INDEX events:          1  ( 0.0%)
> > >         THREAD_MAP events:          1  ( 0.0%)
> > >            CPU_MAP events:          1  ( 0.0%)
> > >          TIME_CONV events:          1  ( 0.0%)
> > >      FINISHED_INIT events:          1  ( 0.0%)
> > >   ibs_op//p stats:
> > >             SAMPLE events:         15
> > >       LOST_SAMPLES events:       3991
> > >
> > > Note that the total aggregated stats show 1 LOST_SAMPLES event but
> > > per event stats show 3991 events because it's the actual number of
> > > dropped samples while the aggregated stats has the number of record.
> > > Maybe we need to change the per-event stats to 'LOST_SAMPLES count'
> > > to avoid the confusion.
> > >
> > > The code is available at 'perf/bpf-filter-v1' branch in my tree.
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > >
> > > Again, you need tip/perf/core kernel for this to work.
> > > Any feedback is welcome.
> >
> > This is great! I wonder about related clean up:
> >
> >  - can we remove BPF events as this is a better feature?
> >    - I believe BPF events are flaky, seldom used (with the exception
> > of the augmented syscalls for perf trace, which really should move to
> > a BPF skeleton as most people don't know how to use it) and they add a
> > bunch of complexity. A particular complexity I care about is that the
> > path separator forward slash ('/') is also the modifier separator for
> > events.
> >
> >  - what will happen with multiple events/metrics? Perhaps there should
> > be a way of listing filters so that each filter applies to the
> > appropriate event in the event list, like cgroups and -G. For metrics
> > we shuffle the list of events and so maybe the filters need some way
> > to specify which event they apply to.
> >
> >  - It feels like there should be some BPF way of overcoming the fixed
> > length number of filters so it is still bounded but not a hardcoded
> > number.
> >
> > Thanks,
> > Ian
> >
> >
> > > Thanks,
> > > Namhyung
> > >
> > > Namhyung Kim (7):
> > >   perf bpf filter: Introduce basic BPF filter expression
> > >   perf bpf filter: Implement event sample filtering
> > >   perf record: Add BPF event filter support
> > >   perf record: Record dropped sample count
> > >   perf bpf filter: Add 'pid' sample data support
> > >   perf bpf filter: Add more weight sample data support
> > >   perf bpf filter: Add data_src sample data support
> > >
> > >  tools/perf/Documentation/perf-record.txt     |  10 +-
> > >  tools/perf/Makefile.perf                     |   2 +-
> > >  tools/perf/builtin-record.c                  |  46 ++++--
> > >  tools/perf/util/Build                        |  16 ++
> > >  tools/perf/util/bpf-filter.c                 | 117 ++++++++++++++
> > >  tools/perf/util/bpf-filter.h                 |  48 ++++++
> > >  tools/perf/util/bpf-filter.l                 | 146 ++++++++++++++++++
> > >  tools/perf/util/bpf-filter.y                 |  55 +++++++
> > >  tools/perf/util/bpf_counter.c                |   3 +-
> > >  tools/perf/util/bpf_skel/sample-filter.h     |  25 +++
> > >  tools/perf/util/bpf_skel/sample_filter.bpf.c | 152 +++++++++++++++++++
> > >  tools/perf/util/evsel.c                      |   2 +
> > >  tools/perf/util/evsel.h                      |   7 +-
> > >  tools/perf/util/parse-events.c               |   4 +
> > >  tools/perf/util/session.c                    |   3 +-
> > >  15 files changed, 615 insertions(+), 21 deletions(-)
> > >  create mode 100644 tools/perf/util/bpf-filter.c
> > >  create mode 100644 tools/perf/util/bpf-filter.h
> > >  create mode 100644 tools/perf/util/bpf-filter.l
> > >  create mode 100644 tools/perf/util/bpf-filter.y
> > >  create mode 100644 tools/perf/util/bpf_skel/sample-filter.h
> > >  create mode 100644 tools/perf/util/bpf_skel/sample_filter.bpf.c
> > >
> > >
> > > base-commit: 37f322cd58d81a9d46456531281c908de9ef6e42
> > > --
> > > 2.39.1.581.gbfd45094c4-goog
> > >
>
> --
>
> - Arnaldo
