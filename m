Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3450C2F3
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiDVWhX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 18:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiDVWhH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754024766C;
        Fri, 22 Apr 2022 14:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7235EB831F5;
        Fri, 22 Apr 2022 19:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E8C385A0;
        Fri, 22 Apr 2022 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650654261;
        bh=/hQTHTPZ+8EMV0t0+BWR+cNB6HkAVNSrcB0f4XxB0uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e7W3PV+GoD7Ha2W0fT29yk3eI7sObxvOyea9pB3TA1nfeWcqBP30+4EL8qO0cddDL
         1naoJHDmxy8N+1iTy+DK01hyZyG7fz0Pfl8lyLTvmXcJ5P6WtI/pXOrx6M2NqEUNW6
         Nf7Rt5g13AQ71tnz7xlxL7k/vLzfMc6qetAcK1+7xVHwqYUcVsKHGe3ezcwCpn4j/1
         2jvX2cOBgJ/tot0Yee12YrzrbowKIv+JPWSFbV55/P3oJqt/a69YITOULv1f7WtRGT
         jJYEqX/oSDbivZ6hFmiZpsMCUeM8iRAkEAgWNRPpYvftLAIgEALjYJb9yzvv/mnck1
         K+eT13/x+c1TA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CACD9400B1; Fri, 22 Apr 2022 16:04:18 -0300 (-03)
Date:   Fri, 22 Apr 2022 16:04:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
Subject: Re: [RFC 0/4] perf record: Implement off-cpu profiling with BPF (v1)
Message-ID: <YmL8MlTX12zHtzbd@kernel.org>
References: <20220422053401.208207-1-namhyung@kernel.org>
 <35121321.B44TWeBT9p@milian-workstation>
 <CAM9d7cjU6RGMStG4YOW5D50Sx4PRia2dfzcPKxb4JLh5Q668mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjU6RGMStG4YOW5D50Sx4PRia2dfzcPKxb4JLh5Q668mw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Apr 22, 2022 at 08:01:15AM -0700, Namhyung Kim escreveu:
> Hi Milian,
 
> On Fri, Apr 22, 2022 at 3:21 AM Milian Wolff <milian.wolff@kdab.com> wrote:
> > On Freitag, 22. April 2022 07:33:57 CEST Namhyung Kim wrote:
> > > This is the first version of off-cpu profiling support.  Together with
> > > (PMU-based) cpu profiling, it can show holistic view of the performance
> > > characteristics of your application or system.

> > Hey Namhyung,

> > this is awesome news! In hotspot, I've long done off-cpu profiling manually by
> > looking at the time between --switch-events. The downside is that we also need
> > to track the sched:sched_switch event to get a call stack. But this approach
> > also works with dwarf based unwinding, and also includes kernel stacks.
> 
> Thanks, I've also briefly thought about the switch event based off-cpu
> profiling as it doesn't require root.  But collecting call stacks is hard and
> I'd like to do it in kernel/bpf to reduce the overhead.

It would be great to have both in perf. Right now since we have one in
hotspot that is working, perfecting the other method, Namhyung's, using
BPF to reduce the amount of data to postprocess in userspace, looks
great.
 
> > > With BPF, it can aggregate scheduling stats for interested tasks
> > > and/or states and convert the data into a form of perf sample records.
> > > I chose the bpf-output event which is a software event supposed to be
> > > consumed by BPF programs and renamed it as "offcpu-time".  So it
> > > requires no change on the perf report side except for setting sample
> > > types of bpf-output event.
> > >
> > > Basically it collects userspace callstack for tasks as it's what users
> > > want mostly.  Maybe we can add support for the kernel stacks but I'm
> > > afraid that it'd cause more overhead.  So the offcpu-time event will
> > > always have callchains regardless of the command line option, and it
> > > enables the children mode in perf report by default.
> >
> > Has anything changed wrt perf/bpf and user applications not compiled with `-
> > fno-omit-frame-pointer`? I.e. does this new utility only work for specially
> > compiled applications, or do we also get backtraces for "normal" binaries that
> > we can install through package managers?
> 
> I am not aware of such changes, it still needs a frame pointer to get
> backtraces.

I see this as an initial limitation, one that we can lift later?

- Arnaldo
