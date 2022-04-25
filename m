Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE450E8F5
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiDYTBa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 15:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbiDYTB1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 15:01:27 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF8DB8239;
        Mon, 25 Apr 2022 11:58:22 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 16so3891567lju.13;
        Mon, 25 Apr 2022 11:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uh705JoKTDQRQJusLSsjTMb0HHI0Eet0wNuabBGRfZY=;
        b=aeuiUQIt3A/93O5ddRACPCbF5H4ILMrGTyMupYAKSulLDswuGcErEiHcnNBvmUThBz
         p1eyMh/Yav8JBaLS7ygmAAAGi8SIZ2ABSL3rOqBnha3gAU4fCOwTBCVs3EmKJ0YmgKFw
         fTCBiCmEAoEfa9BbYwZmTQvo3WCrmRXQ4upby84qOnmMfpYDznYwv6kYitlPx/7efbPk
         IeLhDtuW2lS2rYTmQ3x5xpYcpfQb6AZy8UKKEB+sHRu5/Zkt0Nr6YRrxiR+OlPUbN2FP
         rjSriquQKoNct1n/O1yfgg2n56oKe1Er84lPKtQV6Ryd2JJrceOZ0IDXhMl2s9MsifKQ
         ye3g==
X-Gm-Message-State: AOAM532wi5jzbf/tndYnMjk1KRK1JHMyB0stUoXbko9wq5BzXMzIHws7
        M3HN5ncqZplQy26f+lLBoWEvc8itiVIf3LuQU0Y=
X-Google-Smtp-Source: ABdhPJwpX3kYyNLe4gGWlgl0x87nw1uxFMKjnKa7O35yPOrnRenGrreh8fpgJHeXe06kZCMfSMwLBSK1bpGXcYe9JLg=
X-Received: by 2002:a2e:b98c:0:b0:24f:f63:913a with SMTP id
 p12-20020a2eb98c000000b0024f0f63913amr4903381ljp.366.1650913100520; Mon, 25
 Apr 2022 11:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220422053401.208207-1-namhyung@kernel.org> <35121321.B44TWeBT9p@milian-workstation>
 <CAM9d7cjU6RGMStG4YOW5D50Sx4PRia2dfzcPKxb4JLh5Q668mw@mail.gmail.com> <5616892.dGzqbEiDyy@milian-workstation>
In-Reply-To: <5616892.dGzqbEiDyy@milian-workstation>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 25 Apr 2022 11:58:09 -0700
Message-ID: <CAM9d7cgxkQ3x_to9W7N8bd18s-0SJbL7bNre++tJfvF8AqiETA@mail.gmail.com>
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

On Mon, Apr 25, 2022 at 5:42 AM Milian Wolff <milian.wolff@kdab.com> wrote:
>
> On Freitag, 22. April 2022 17:01:15 CEST Namhyung Kim wrote:
> > Hi Milian,
> >
> > On Fri, Apr 22, 2022 at 3:21 AM Milian Wolff <milian.wolff@kdab.com> wrote:
> > > On Freitag, 22. April 2022 07:33:57 CEST Namhyung Kim wrote:
> > > > Hello,
> > > >
> > > > This is the first version of off-cpu profiling support.  Together with
> > > > (PMU-based) cpu profiling, it can show holistic view of the performance
> > > > characteristics of your application or system.
> > >
> > > Hey Namhyung,
> > >
> > > this is awesome news! In hotspot, I've long done off-cpu profiling
> > > manually by looking at the time between --switch-events. The downside is
> > > that we also need to track the sched:sched_switch event to get a call
> > > stack. But this approach also works with dwarf based unwinding, and also
> > > includes kernel stacks.
> >
> > Thanks, I've also briefly thought about the switch event based off-cpu
> > profiling as it doesn't require root.  But collecting call stacks is hard
> > and I'd like to do it in kernel/bpf to reduce the overhead.
>
> I'm all for reducing the overhead, I just wonder about the practicality. At
> the very least, please make sure to note this limitation explicitly to end
> users. As a preacher for perf, I have come across lots of people stumbling
> over `perf record -g` not producing any sensible output because they are
> simply not aware that this requires frame pointers which are basically non
> existing on most "normal" distributions. Nowadays `man perf record` tries to
> educate people, please do the same for the new `--off-cpu` switch.

Good point, will add it .

>
> > > > With BPF, it can aggregate scheduling stats for interested tasks
> > > > and/or states and convert the data into a form of perf sample records.
> > > > I chose the bpf-output event which is a software event supposed to be
> > > > consumed by BPF programs and renamed it as "offcpu-time".  So it
> > > > requires no change on the perf report side except for setting sample
> > > > types of bpf-output event.
> > > >
> > > > Basically it collects userspace callstack for tasks as it's what users
> > > > want mostly.  Maybe we can add support for the kernel stacks but I'm
> > > > afraid that it'd cause more overhead.  So the offcpu-time event will
> > > > always have callchains regardless of the command line option, and it
> > > > enables the children mode in perf report by default.
> > >
> > > Has anything changed wrt perf/bpf and user applications not compiled with
> > > `- fno-omit-frame-pointer`? I.e. does this new utility only work for
> > > specially compiled applications, or do we also get backtraces for
> > > "normal" binaries that we can install through package managers?
> >
> > I am not aware of such changes, it still needs a frame pointer to get
> > backtraces.
>
> May I ask what kind of setup you are using this on? Do you use something like
> Gentoo or yocto where you compile your whole system with `-fno-omit-frame-
> pointer`? Because otherwise, any kind of off-cpu time in system libraries will
> not be resolved properly, no?

In my work environment, everything is built with the frame pointer.
It's unfortunate most distros build without it, but as Ian said, I hope
we can lift the limitation with recent technologies soon.

Thanks,
Namhyung
