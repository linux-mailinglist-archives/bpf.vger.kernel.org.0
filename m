Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3022350E624
	for <lists+bpf@lfdr.de>; Mon, 25 Apr 2022 18:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbiDYQwv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Apr 2022 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243579AbiDYQwu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Apr 2022 12:52:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E8F24969
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 09:49:46 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j15so8493300wrb.2
        for <bpf@vger.kernel.org>; Mon, 25 Apr 2022 09:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueXJpQvL2pfynfplxOLCcVOjZIcVvqpX+r8wn9uwNPI=;
        b=DUfEXR7pB451R0llk/iDmWhUQZlHNJ4Q7zbGysozNMINnHO02Z1oMI/cNzFAgURFAA
         QP2xDVa8DeLNMOZBzWIZoI2pQGQWvVHDA1Gm2oobaus+2DgI9SXWDtBp6k7M6efqB/D9
         7SveUQi/xVbUVmcjj2fKMeoK6jsHUOxbCnX6wSrJcqGBv3IzZMi8rPa21fedfcjAi3sf
         BoPIF6BKV4YCVRuM1ujSUan2bYvMfdFVKB0KPakipDEbrR3kN1vbw0HkV5sHPNenwlxb
         qAlHUqg1UJXiGnsHH0uGwKyVX4RASGrJrxjo5oPm/gdJtGdhGmJ5mmovqxNDshBygKTJ
         tIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueXJpQvL2pfynfplxOLCcVOjZIcVvqpX+r8wn9uwNPI=;
        b=MboP+5E47QeAKHSa5lUlx0HPqhbeakYWRaUic3pkCi7gAL0D/jFZeDJVj1fk6KopAU
         5n0LwsGn3JLVb1PiIlAdo/kiXtfCRFj/Vg9vGstY0FL1vF7XzglaMrYp/Zyk2+jL25ev
         OCngiEjxFha6kbDNJ6TTtoc5PwMlPo2LAUVOv529es1VeHxwiTg9STgUTIjJyW/uFxAA
         qfyXwBSEX6YImgCgJelrlsCttKnnKTR6oZskQqgiTSuOjV9/ILz6m0XUvPmnlZtv8YZs
         ouYBhRN/CQbXI5aTvvhgQ0O0x4pLGwZCjIQ37YzuC5aw6WuLiQCikIVz+buWvrrVOD8G
         dAUw==
X-Gm-Message-State: AOAM532qkDgk9JlQYrrsgqGlvqmfxDE/0IRAPWP3hQHAiTVBqU6K4f3J
        Kc5Cda/3juSFLS8Rjuop2rVqkoIiGiv4NEJ7d6f/Ig==
X-Google-Smtp-Source: ABdhPJxDeJE4fGjOcrWIwHWHvs3dKEYgZvAE18I/sclof3Uaf4ZHltoT9ZtbMTMJXPqkLtDAAyGDNTrbHVEN1oFWqYI=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr1153087wro.654.1650905384423; Mon, 25
 Apr 2022 09:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220422053401.208207-1-namhyung@kernel.org> <35121321.B44TWeBT9p@milian-workstation>
 <CAM9d7cjU6RGMStG4YOW5D50Sx4PRia2dfzcPKxb4JLh5Q668mw@mail.gmail.com> <5616892.dGzqbEiDyy@milian-workstation>
In-Reply-To: <5616892.dGzqbEiDyy@milian-workstation>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 25 Apr 2022 09:49:31 -0700
Message-ID: <CAP-5=fVKJ4dYRe288LhJ6B5A5aqkHYwF3VnK8CFv_0oiTvORqA@mail.gmail.com>
Subject: Re: [RFC 0/4] perf record: Implement off-cpu profiling with BPF (v1)
To:     Milian Wolff <milian.wolff@kdab.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Blake Jones <blakejones@google.com>,
        "michael@michaellarabel.com" <michael@michaellarabel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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

I think documenting that off-cpu has a dependency on frame pointers
makes sense. There has been work to make LBR work:
https://lore.kernel.org/bpf/20210818012937.2522409-1-songliubraving@fb.com/
DWARF unwinding is problematic and is probably something best kept in
user land. There is also Intel's CET that may provide an alternate
backtraces.

More recent Intel and AMD cpus have techniques to turn memory
locations into registers, an approach generally called memory
renaming. There is some description here:
https://www.agner.org/forum/viewtopic.php?t=41
In LLVM there is a pass to promote memory locations into registers
called mem2reg. Having the frame pointer as an extra register will
help this pass as there will be 1 more register to replace something
from memory. The memory renaming optimization is similar to mem2reg
except done in the CPU's front-end. It would be interesting to see
benchmark results on modern CPUs with and without omit-frame-pointer.
My expectation is that the performance wins aren't as great, if any,
as they used to be (cc-ed Michael Larabel as I Iove phoronix and it'd
be awesome if someone could do an omit-frame-pointer shoot-out).

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

I agree with your point. Often in cloud environments binaries are
static blobs linking in all their dependencies. This can aid
deployment, bug compatibility, etc. Fwiw, all backtraces gathered in
Google's profiling are frame pointer based. A large motivation for
this is the security aspect of having a privileged application able to
snapshot other threads stacks that happens with dwarf based unwinding.

In summary, your point is that frame pointer based unwinding is
largely broken on all major distributions today limiting the utility
of off-CPU as it is here. I agree, memory renaming in hardware could
hopefully mean that this isn't the case in distributions in the
future. Even if it isn't there are alternate backtraces from sources
like LBR and CET that mean we can fix this other ways.

Thanks,
Ian

> Thanks
> --
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts
