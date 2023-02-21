Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FEF69DF51
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjBULyR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 06:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjBULyQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 06:54:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93141E1ED;
        Tue, 21 Feb 2023 03:54:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h16so16271038edz.10;
        Tue, 21 Feb 2023 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HMIn6HD3Mjuns5NjXurh8sk6cHvSghEOiYl5WXfp6mA=;
        b=RH7UUrdAzd1/iTJLktcDhULqfb1b/uTYEhMK9K0Hww3CPjBPCckbJ4Os1W7qHogrNy
         PBr6ysDC8vEYg0hK4JXWIM2IB63WnmQGa33Ciho3B7bg8pQkisgk0fBGtj7ySeLqmB1D
         kbrvSMRaBI9ZnhBiFQMYnPnyXwkmyAnxRd2j7Oh0yjtVYYyZvaNYjXLQUHraz70PxJHl
         HeqDUopkUBUTSVe/jK+rvQ9MC4mm6+XGYw4eu5YXKJnqgjF2Tzw17AAzGkV2gpAuUVJB
         PLMm6zkTdVjfpRnqKajZ6LcLdn0lT3oY7tdZ56Awmz2YlGo46AODXWemGiv+ZV5fIPJb
         XUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMIn6HD3Mjuns5NjXurh8sk6cHvSghEOiYl5WXfp6mA=;
        b=0yf+B5x8QSq5dN9J3zjv2u5h9QqQRVyIvIWZT0I7wdc4pGZlVcNDYqv7Lj5QyE3F8B
         7bCJdO+cnhHKwpPcBMSYeXfdyJhANiQIhPYHoy8p72Skfz4r1hrrsB2yXB60EX674fx+
         uMjsYLsJjpiI7h+tTSmGURB+iDB9MduK2VyahHyfr43MqSW7K+FDnHaJk5sqXAO/D+oI
         VPIwy4U5XDl4jYHc57r3IjkkGxBwzB0NCHbIiHQfcxU3Bqu4QzReH5zSf2rWT6X6mK9F
         FDVv+SU2+X8YXXuxyg+cdMHi6IAMFRkq+83sW4wUNrPpIGRK8NiWbppsl7KE3lLdtdam
         a3hw==
X-Gm-Message-State: AO0yUKUFR9qJb0S4QArePOU12dPT4xV+qlTfFKt6lDeLYiuXJYOrOBda
        PmjMUih91cpt6DOjFidwgpw=
X-Google-Smtp-Source: AK7set/tljIzkucLfBiGJP6N1k0dZfzc1HHCzmKPuYIPkSJ6LtvahgXAkG1BatcKLTwUsbmfv+iVzg==
X-Received: by 2002:a17:906:230b:b0:878:625c:c8ff with SMTP id l11-20020a170906230b00b00878625cc8ffmr12067129eja.54.1676980453286;
        Tue, 21 Feb 2023 03:54:13 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id de40-20020a1709069be800b008b1fc5abd0esm5831527ejc.71.2023.02.21.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 03:54:12 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Feb 2023 12:54:10 +0100
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [RFC/PATCHSET 0/7] perf record: Implement BPF sample filter (v1)
Message-ID: <Y/Sw4uo7Ma0Ohh9f@krava>
References: <20230214050452.26390-1-namhyung@kernel.org>
 <CAP-5=fWG6f_N7PN+A5v61jGsuKobNxCvo4-H0twAZDGQVfa7cQ@mail.gmail.com>
 <CAM9d7ci8YxEAvzU0+7Q8q9wn+q4eBa=nwcWboh9GWH6PSyQdcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ci8YxEAvzU0+7Q8q9wn+q4eBa=nwcWboh9GWH6PSyQdcg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 10:01:41AM -0800, Namhyung Kim wrote:
> Hi Ian,
> 
> On Tue, Feb 14, 2023 at 8:58 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Feb 13, 2023 at 9:05 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > Hello,
> > >
> > > There have been requests for more sophisticated perf event sample
> > > filtering based on the sample data.  Recently the kernel added BPF
> > > programs can access perf sample data and this is the userspace part
> > > to enable such a filtering.
> > >
> > > This still has some rough edges and needs more improvements.  But
> > > I'd like to share the current work and get some feedback for the
> > > directions and idea for further improvements.
> > >
> > > The kernel changes are in the tip.git tree (perf/core branch) for now.
> > > perf record has --filter option to set filters on the last specified
> > > event in the command line.  It worked only for tracepoints and Intel
> > > PT events so far.  This patchset extends it to have 'bpf:' prefix in
> > > order to enable the general sample filters using BPF for any events.
> > >
> > > A new filter expression parser was added (using flex/bison) to process
> > > the filter string.  Right now, it only accepts very simple expressions
> > > separated by comma.  I'd like to keep the filter expression as simple
> > > as possible.
> > >
> > > It requires samples satisfy all the filter expressions otherwise it'd
> > > drop the sample.  IOW filter expressions are connected with logical AND
> > > operations implicitly.
> > >
> > > Essentially the BPF filter expression is:
> > >
> > >   "bpf:" <term> <operator> <value> ("," <term> <operator> <value>)*
> > >
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

this seems similar to what ftrace is doing in filter_match_preds,
I checked the code briefly and I wonder if we shoud be able to write
that function logic in bpf, assuming that the filter is prepared in
user space

it might solve the 'part' data problem in generic way.. but I might be
missing some blocker of course.. just an idea ;-)

could replace the tracepoint filters.. if we actually care

SNIP

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

+1

> >
> >  - can we remove BPF events as this is a better feature?
> >    - I believe BPF events are flaky, seldom used (with the exception
> > of the augmented syscalls for perf trace, which really should move to
> > a BPF skeleton as most people don't know how to use it) and they add a
> > bunch of complexity. A particular complexity I care about is that the
> > path separator forward slash ('/') is also the modifier separator for
> > events.
> 
> Well.. I actually never tried the BPF events myself :)
> I think we can deprecate it and get rid of it once the perf trace
> conversion is done.

+1 ;-) would be awesome

jirka
