Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682BA50BB14
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 17:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449195AbiDVPFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449198AbiDVPE2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 11:04:28 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE3C5D647;
        Fri, 22 Apr 2022 08:01:28 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w5so9968134lji.4;
        Fri, 22 Apr 2022 08:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fiWLR17VDpLKbRo+43T1nudbmv7jbS4IG24R19EwcNM=;
        b=yMo/T1/vhPe4MnWmd37bbXE6AbI/jeWcL7bTy+LHTuq5eNUjFiQrvkgL+W6vbNsHdF
         vQ93e9ME/4pman1yQ/HS/ySp9FcLlwsXwvr/AaP5Wf9LUb0nA+vBVxhsBzmwB1W3HeAA
         CpH2pcjKl2+C6x4KTB4dZ+neEUS3eP61Ek3TOwby73/qqlYk5JZRRWl6QMZes64T3gxr
         tT2T2o2Athoriy2eWWt8wKfO8J3PEO+93ZSlRP1sDGFFGAjeOGY3eWypIm4enbExtIPb
         /D1l1eHgssnfswiY0JktHn04SB7i014x/iF5Ewupu7NGNGhUTXoNCEzqgNc5FKIQjWPt
         DuVQ==
X-Gm-Message-State: AOAM533LSXNAYLEqTp8jDh5zKJhcN70H/9NP+YYYwsfi8lzSwuYszx1G
        D3Pq19CMqDnRFSG+Kw9hJ8JxpdwKcX1qY4xSfuQ=
X-Google-Smtp-Source: ABdhPJz0aFWprrOW9PDtR3C4kUFYsFk3pNN4qhgIVvgnXXxHQJJWo1vSVKJNqXx7Qu5hvrI65GmkiPmE444yntBOynA=
X-Received: by 2002:a2e:a793:0:b0:24e:e3bd:b3a8 with SMTP id
 c19-20020a2ea793000000b0024ee3bdb3a8mr2949005ljf.457.1650639686346; Fri, 22
 Apr 2022 08:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220422053401.208207-1-namhyung@kernel.org> <35121321.B44TWeBT9p@milian-workstation>
In-Reply-To: <35121321.B44TWeBT9p@milian-workstation>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 22 Apr 2022 08:01:15 -0700
Message-ID: <CAM9d7cjU6RGMStG4YOW5D50Sx4PRia2dfzcPKxb4JLh5Q668mw@mail.gmail.com>
Subject: Re: [RFC 0/4] perf record: Implement off-cpu profiling with BPF (v1)
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>
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

Hi Milian,

On Fri, Apr 22, 2022 at 3:21 AM Milian Wolff <milian.wolff@kdab.com> wrote:
>
> On Freitag, 22. April 2022 07:33:57 CEST Namhyung Kim wrote:
> > Hello,
> >
> > This is the first version of off-cpu profiling support.  Together with
> > (PMU-based) cpu profiling, it can show holistic view of the performance
> > characteristics of your application or system.
>
> Hey Namhyung,
>
> this is awesome news! In hotspot, I've long done off-cpu profiling manually by
> looking at the time between --switch-events. The downside is that we also need
> to track the sched:sched_switch event to get a call stack. But this approach
> also works with dwarf based unwinding, and also includes kernel stacks.

Thanks, I've also briefly thought about the switch event based off-cpu
profiling as it doesn't require root.  But collecting call stacks is hard and
I'd like to do it in kernel/bpf to reduce the overhead.

>
> > With BPF, it can aggregate scheduling stats for interested tasks
> > and/or states and convert the data into a form of perf sample records.
> > I chose the bpf-output event which is a software event supposed to be
> > consumed by BPF programs and renamed it as "offcpu-time".  So it
> > requires no change on the perf report side except for setting sample
> > types of bpf-output event.
> >
> > Basically it collects userspace callstack for tasks as it's what users
> > want mostly.  Maybe we can add support for the kernel stacks but I'm
> > afraid that it'd cause more overhead.  So the offcpu-time event will
> > always have callchains regardless of the command line option, and it
> > enables the children mode in perf report by default.
>
> Has anything changed wrt perf/bpf and user applications not compiled with `-
> fno-omit-frame-pointer`? I.e. does this new utility only work for specially
> compiled applications, or do we also get backtraces for "normal" binaries that
> we can install through package managers?

I am not aware of such changes, it still needs a frame pointer to get
backtraces.

Thanks,
Namhyung
