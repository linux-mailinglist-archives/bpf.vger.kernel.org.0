Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3807B69FC62
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjBVTnO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjBVTnM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:43:12 -0500
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC3432CDF;
        Wed, 22 Feb 2023 11:43:10 -0800 (PST)
Received: by mail-vs1-f47.google.com with SMTP id d7so5302363vsj.2;
        Wed, 22 Feb 2023 11:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677094989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G16wx/2YBGseQ9h6Vt/v5mRzhL85ElXwuJBuYIENYiQ=;
        b=MpyLejdxaLY4GQEc8MPntu/EOVdVao4xNX+pYiLBov0QwwDDpz1TSvcv5zthmvV47T
         W0AN95lawsO4nqDPJjQNCZS7Nr0wEtfhd6zLQYrHghfp0kr4dR8kPEf3vq3sbH3k6qhC
         85TTYkRwk8c6/qQ5c8P9ZsRr5TNd8OqjOG4xitFg0j4yGAa8cgXPKqfTuEnJR01AaLXF
         uI5VA5GqnWs+TjtcH6XgbLCUkvSeLTFOO8e8ENp2h81jJozu7vFybNEwKUuzTb5Y5pTO
         g9Oy1GL7AkpZfMkmKwqTB0C06GYdWVk0fxq6zjN7aCVSovZLEx8WHgrsd4B30SZdTnsw
         qPEg==
X-Gm-Message-State: AO0yUKVc0spa/vfNTItLp4a4RU5SzTJE6+C41n6iZVOPSSqyPHWC+giR
        Rs0MZ46OY3ZkO4C3+TkDc99aa+c5pVv4RH9xW8bCCpky
X-Google-Smtp-Source: AK7set/vWLR2A53VCLEjo9d4OAYvMfdnKXRp9zaCYqEkEI7JjwqPdgG5GHVirIrw5JSj9ex3PRr6+DRLC5TY/ZeVMAQ=
X-Received: by 2002:a05:6122:84a:b0:411:b190:fe5b with SMTP id
 10-20020a056122084a00b00411b190fe5bmr196366vkk.39.1677094988963; Wed, 22 Feb
 2023 11:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20230214050452.26390-1-namhyung@kernel.org> <CAP-5=fWG6f_N7PN+A5v61jGsuKobNxCvo4-H0twAZDGQVfa7cQ@mail.gmail.com>
 <CAM9d7ci8YxEAvzU0+7Q8q9wn+q4eBa=nwcWboh9GWH6PSyQdcg@mail.gmail.com> <Y/Sw4uo7Ma0Ohh9f@krava>
In-Reply-To: <Y/Sw4uo7Ma0Ohh9f@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Feb 2023 11:42:57 -0800
Message-ID: <CAM9d7cjkUJ0wKi30winkDz=MKGB0Fhpp6Qnp2kSxC1eL+ZWNwA@mail.gmail.com>
Subject: Re: [RFC/PATCHSET 0/7] perf record: Implement BPF sample filter (v1)
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

Hi Jiri,

On Tue, Feb 21, 2023 at 3:54 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Feb 14, 2023 at 10:01:41AM -0800, Namhyung Kim wrote:
> > Hi Ian,
> >
> > On Tue, Feb 14, 2023 at 8:58 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Mon, Feb 13, 2023 at 9:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > There have been requests for more sophisticated perf event sample
> > > > filtering based on the sample data.  Recently the kernel added BPF
> > > > programs can access perf sample data and this is the userspace part
> > > > to enable such a filtering.
> > > >
> > > > This still has some rough edges and needs more improvements.  But
> > > > I'd like to share the current work and get some feedback for the
> > > > directions and idea for further improvements.
> > > >
> > > > The kernel changes are in the tip.git tree (perf/core branch) for now.
> > > > perf record has --filter option to set filters on the last specified
> > > > event in the command line.  It worked only for tracepoints and Intel
> > > > PT events so far.  This patchset extends it to have 'bpf:' prefix in
> > > > order to enable the general sample filters using BPF for any events.
> > > >
> > > > A new filter expression parser was added (using flex/bison) to process
> > > > the filter string.  Right now, it only accepts very simple expressions
> > > > separated by comma.  I'd like to keep the filter expression as simple
> > > > as possible.
> > > >
> > > > It requires samples satisfy all the filter expressions otherwise it'd
> > > > drop the sample.  IOW filter expressions are connected with logical AND
> > > > operations implicitly.
> > > >
> > > > Essentially the BPF filter expression is:
> > > >
> > > >   "bpf:" <term> <operator> <value> ("," <term> <operator> <value>)*
> > > >
> > > > The <term> can be one of:
> > > >   ip, id, tid, pid, cpu, time, addr, period, txn, weight, phys_addr,
> > > >   code_pgsz, data_pgsz, weight1, weight2, weight3, ins_lat, retire_lat,
> > > >   p_stage_cyc, mem_op, mem_lvl, mem_snoop, mem_remote, mem_lock,
> > > >   mem_dtlb, mem_blk, mem_hops
> > > >
> > > > The <operator> can be one of:
> > > >   ==, !=, >, >=, <, <=, &
> > > >
> > > > The <value> can be one of:
> > > >   <number> (for any term)
> > > >   na, load, store, pfetch, exec (for mem_op)
> > > >   l1, l2, l3, l4, cxl, io, any_cache, lfb, ram, pmem (for mem_lvl)
> > > >   na, none, hit, miss, hitm, fwd, peer (for mem_snoop)
> > > >   remote (for mem_remote)
> > > >   na, locked (for mem_locked)
> > > >   na, l1_hit, l1_miss, l2_hit, l2_miss, any_hit, any_miss, walk, fault (for mem_dtlb)
> > > >   na, by_data, by_addr (for mem_blk)
> > > >   hops0, hops1, hops2, hops3 (for mem_hops)
> > > >
> > > > I plan to improve it with range expressions like for ip or addr and it
> > > > should support symbols like the existing addr-filters.  Also cgroup
> > > > should understand and convert cgroup names to IDs.
>
> this seems similar to what ftrace is doing in filter_match_preds,
> I checked the code briefly and I wonder if we shoud be able to write
> that function logic in bpf, assuming that the filter is prepared in
> user space
>
> it might solve the 'part' data problem in generic way.. but I might be
> missing some blocker of course.. just an idea ;-)
>
> could replace the tracepoint filters.. if we actually care

I'm not sure about replacing tracepoint filters.  IIRC BPF is optional,
then tracepoints should work without it.  From the BPF's perspective,
it has its own way of handling tracepoints so no need to deal with
perf or event tracing (ftrace) for that.

From the perf's perspective, I think it can use either the existing ftrace
filters or build a new BPF filter for each event.  But it cannot use BTF
for perf tracepoint events at least for now.  Certainly it can use RAW
sample data and parse the event format to access the fields but I'm
not sure it's worth doing that. :)

Thanks,
Namhyung
