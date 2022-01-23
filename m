Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEECE49765D
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 00:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiAWXuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Jan 2022 18:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60788 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240470AbiAWXuT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 Jan 2022 18:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642981818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfrf32ebUcI4fzNTSsB+v8qDSQo+mJTSIXb8h4iPDuo=;
        b=H4UQMmJPVYonSIGfyETyEjZwNZ8cxNB//ooq07A0DFctjNTOyyYkYQ9IaI/gXxdgULtYBC
        8OIaVDkHcxdSuou4xqowo/mwcyQA35L228SxsICrLk7YEDulFG9HL51+/ANghVyjJhb2WN
        D+VyvN4BbXjz5w8S50amri9hPa0vh4o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529-mjO63gwlMMyuPxytBoTEaA-1; Sun, 23 Jan 2022 18:50:17 -0500
X-MC-Unique: mjO63gwlMMyuPxytBoTEaA-1
Received: by mail-ed1-f71.google.com with SMTP id h11-20020a05640250cb00b003fa024f87c2so11988453edb.4
        for <bpf@vger.kernel.org>; Sun, 23 Jan 2022 15:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfrf32ebUcI4fzNTSsB+v8qDSQo+mJTSIXb8h4iPDuo=;
        b=lnYs4yLHozKV3zQmBwSNVYTwExzYkdBX/6UNcjVUf5ALT3J2tqpRw3r8hnFA1n0MQZ
         rs1f9SLB0dmYMseP8DiLETihFvG2sKB6FF3Y9cHJ+mWvlR01PDglStxoTaXWBGn1MGy5
         MWn0JabewtLmntIXMDjwgbIlwTDIaqCrR50pA6MpzWqi/iSBWOuj+YhGFc1+vsU1lLnj
         o8pOuwZFh7DEOGFsRqM1A0ehbisFqNv/m2cX81rLURF0zrUyO2lf4Wg7fdLAUqymmI+X
         KAwcmbFxP44Xd4XtVPBqpJVabPyMnxahd3MzBJaVf9RF+N2dcxgXDmoZI5iM2QBhCxxB
         69/Q==
X-Gm-Message-State: AOAM531SUYzSAHT9btIhhznvLmNOQB+mXzum5McT88ERrVkH2LubFEVK
        x+2KoKbXKtEx8X4wv1U4cH+YEiK+eDgMmB0KCiVZgEgp85Z38bgGfpDa8NHuLY8KwcBS7/Ointh
        PiXarQ1x5U/dj
X-Received: by 2002:a17:906:150c:: with SMTP id b12mr10315372ejd.284.1642981816123;
        Sun, 23 Jan 2022 15:50:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyI8gSDYyfKUB5y85emmByYt4UvTUbXDVOoEsmUF4APQ5/ZGGjg8scmXOsHaagfRzzgthnSA==
X-Received: by 2002:a17:906:150c:: with SMTP id b12mr10315356ejd.284.1642981815887;
        Sun, 23 Jan 2022 15:50:15 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id w25sm5594985edv.68.2022.01.23.15.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 15:50:15 -0800 (PST)
Date:   Mon, 24 Jan 2022 00:50:13 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH v3 0/9] fprobe: Introduce fprobe function entry/exit
 probe
Message-ID: <Ye3ptcW0eAFRYm58@krava>
References: <164260419349.657731.13913104835063027148.stgit@devnote2>
 <CAEf4Bzbbimea3ydwafXSHFiEffYx5zAcwGNKk8Zi6QZ==Vn0Ug@mail.gmail.com>
 <20220121135510.7cfa6540e31824aa39b1c1b8@kernel.org>
 <CAEf4Bza0eTft2kjcm9HhKpAm=AuXnGwZfZ+sYpVVBvj93PBreQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza0eTft2kjcm9HhKpAm=AuXnGwZfZ+sYpVVBvj93PBreQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 21, 2022 at 09:29:00AM -0800, Andrii Nakryiko wrote:
> On Thu, Jan 20, 2022 at 8:55 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Thu, 20 Jan 2022 14:24:15 -0800
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > On Wed, Jan 19, 2022 at 6:56 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > > >
> > > > Hello Jiri,
> > > >
> > > > Here is the 3rd version of fprobe. I added some comments and
> > > > fixed some issues. But I still saw some problems when I add
> > > > your selftest patches.
> > > >
> > > > This series introduces the fprobe, the function entry/exit probe
> > > > with multiple probe point support. This also introduces the rethook
> > > > for hooking function return as same as kretprobe does. This
> > > > abstraction will help us to generalize the fgraph tracer,
> > > > because we can just switch it from rethook in fprobe, depending
> > > > on the kernel configuration.
> > > >
> > > > The patch [1/9] and [7/9] are from Jiri's series[1]. Other libbpf
> > > > patches will not be affected by this change.
> > > >
> > > > [1] https://lore.kernel.org/all/20220104080943.113249-1-jolsa@kernel.org/T/#u
> > > >
> > > > However, when I applied all other patches on top of this series,
> > > > I saw the "#8 bpf_cookie" test case has been stacked (maybe related
> > > > to the bpf_cookie issue which Andrii and Jiri talked?) And when I
> > > > remove the last selftest patch[2], the selftest stopped at "#112
> > > > raw_tp_test_run".
> > > >
> > > > [2] https://lore.kernel.org/all/20220104080943.113249-1-jolsa@kernel.org/T/#m242d2b3a3775eeb5baba322424b15901e5e78483
> > > >
> > > > Note that I used tools/testing/selftests/bpf/vmtest.sh to check it.
> > > >
> > > > This added 2 more out-of-tree patches. [8/9] is for adding wildcard
> > > > support to the sample program, [9/9] is a testing patch for replacing
> > > > kretprobe trampoline with rethook.
> > > > According to this work, I noticed that using rethook in kretprobe
> > > > needs 2 steps.
> > > >  1. port the rethook on all architectures which supports kretprobes.
> > > >     (some arch requires CONFIG_KPROBES for rethook)
> > > >  2. replace kretprobe trampoline with rethook for all archs, at once.
> > > >     This must be done by one treewide patch.
> > > >
> > > > Anyway, I'll do the kretprobe update in the next step as another series.
> > > > (This testing patch is just for confirming the rethook is correctly
> > > >  implemented.)
> > > >
> > > > BTW, on the x86, ftrace (with fentry) location address is same as
> > > > symbol address. But on other archs, it will be different (e.g. arm64
> > > > will need 2 instructions to save link-register and call ftrace, the
> > > > 2nd instruction will be the ftrace location.)
> > > > Does libbpf correctly handle it?

hm, I'm probably missing something, but should this be handled by arm
specific kernel code? user passes whatever is found in kallsyms, right?


> > >
> > > libbpf doesn't do anything there. The interface for kprobe is based on
> > > function name and kernel performs name lookups internally to resolve
> > > IP. For fentry it's similar (kernel handles IP resolution), but
> > > instead of function name we specify BTF ID of a function type.
> >
> > Hmm, according to Jiri's original patch, it seems to pass an array of
> > addresses. So I thought that has been resolved by libbpf.
> >
> > +                       struct {
> > +                               __aligned_u64   addrs;
> 
> I think this is a pointer to an array of pointers to zero-terminated C strings

I used direct addresses, because bpftrace already has them, so there was
no point passing strings, I cann add support for that

jirka

> 
> > +                               __u32           cnt;
> > +                               __u64           bpf_cookie;
> > +                       } kprobe;
> >
> > Anyway, fprobe itself also has same issue. I'll try to fix it.
> >
> > Thank you!
> >
> > >
> > > >
> > > > Thank you,
> > > >
> > > > ---
> > > >
> > > > Jiri Olsa (2):
> > > >       ftrace: Add ftrace_set_filter_ips function
> > > >       bpf: Add kprobe link for attaching raw kprobes
> > > >
> > > > Masami Hiramatsu (7):
> > > >       fprobe: Add ftrace based probe APIs
> > > >       rethook: Add a generic return hook
> > > >       rethook: x86: Add rethook x86 implementation
> > > >       fprobe: Add exit_handler support
> > > >       fprobe: Add sample program for fprobe
> > > >       [DO NOT MERGE] Out-of-tree: Support wildcard symbol option to sample
> > > >       [DO NOT MERGE] out-of-tree: kprobes: Use rethook for kretprobe
> > > >
> > > >
> > > >  arch/x86/Kconfig                |    1
> > > >  arch/x86/include/asm/unwind.h   |    8 +
> > > >  arch/x86/kernel/Makefile        |    1
> > > >  arch/x86/kernel/kprobes/core.c  |  106 --------------
> > > >  arch/x86/kernel/rethook.c       |  115 +++++++++++++++
> > > >  include/linux/bpf_types.h       |    1
> > > >  include/linux/fprobe.h          |   84 +++++++++++
> > > >  include/linux/ftrace.h          |    3
> > > >  include/linux/kprobes.h         |   85 +----------
> > > >  include/linux/rethook.h         |   99 +++++++++++++
> > > >  include/linux/sched.h           |    4 -
> > > >  include/uapi/linux/bpf.h        |   12 ++
> > > >  kernel/bpf/syscall.c            |  195 +++++++++++++++++++++++++-
> > > >  kernel/exit.c                   |    3
> > > >  kernel/fork.c                   |    4 -
> > > >  kernel/kallsyms.c               |    1
> > > >  kernel/kprobes.c                |  265 +++++------------------------------
> > > >  kernel/trace/Kconfig            |   22 +++
> > > >  kernel/trace/Makefile           |    2
> > > >  kernel/trace/fprobe.c           |  179 ++++++++++++++++++++++++
> > > >  kernel/trace/ftrace.c           |   54 ++++++-
> > > >  kernel/trace/rethook.c          |  295 +++++++++++++++++++++++++++++++++++++++
> > > >  kernel/trace/trace_kprobe.c     |    4 -
> > > >  kernel/trace/trace_output.c     |    2
> > > >  samples/Kconfig                 |    7 +
> > > >  samples/Makefile                |    1
> > > >  samples/fprobe/Makefile         |    3
> > > >  samples/fprobe/fprobe_example.c |  154 ++++++++++++++++++++
> > > >  tools/include/uapi/linux/bpf.h  |   12 ++
> > > >  29 files changed, 1283 insertions(+), 439 deletions(-)
> > > >  create mode 100644 arch/x86/kernel/rethook.c
> > > >  create mode 100644 include/linux/fprobe.h
> > > >  create mode 100644 include/linux/rethook.h
> > > >  create mode 100644 kernel/trace/fprobe.c
> > > >  create mode 100644 kernel/trace/rethook.c
> > > >  create mode 100644 samples/fprobe/Makefile
> > > >  create mode 100644 samples/fprobe/fprobe_example.c
> > > >
> > > > --
> > > > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
> 

