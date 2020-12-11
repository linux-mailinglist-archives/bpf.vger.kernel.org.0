Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658A12D6E44
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 03:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403896AbgLKC5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 21:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403848AbgLKC4z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 21:56:55 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6722DC0613CF;
        Thu, 10 Dec 2020 18:56:15 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id j17so6724471ybt.9;
        Thu, 10 Dec 2020 18:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1OgNsXDqy4RHXMYPMntKp+s7RkYqqk2aQMqq723GrM=;
        b=PN5U2cPcvywrBEdalt0lmzRKm1F0DjfRJANnq+zAj48xGqlzov6FeWzT2rZpVdTL5H
         AMQ0kma4ne7xqLfCGBg5G8nQznEqiLBqZSqKSxUfhgF8wYI1wR4MJR3uHXl/kOW5cL1j
         qZgSTVfHaMnITfqj9DagEn7CZeWVaVQ4FiXhhOnotfxjDz1q+WSIMBHx9++/rdTO3c/T
         6XZ7VlBIE+GLrL1DDwOFiXQiH8qnppNEKepzx6ufuiuctF3mgkrPY24F/QUDL02fxE+h
         hTVwFLSpMXe10JZOGs83okr708krgU5hecpgIBPjsSBv/3gASQDLVJq1UguaxWfTLXCM
         vCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1OgNsXDqy4RHXMYPMntKp+s7RkYqqk2aQMqq723GrM=;
        b=IYNDp1Jo8xtiq7LqGVAyYKknYLHPvRbGBRMGKZdLdDp1aKYs1uZVb/rhCjn777TlgB
         b9q6zxvphRlz8tgfpIP/z4+CmOjQCqSCwzSp93M9vtbaagYoii9laHZiJUbYOogPhYqI
         E81ERRP1UT+ENiOqW2ocSaO2Lp4u+Iuj4pVTlrVG3dq+f05lgxtO54yLL1F8txsH4Hfd
         aqf55XiJ6r+LZPGQQNBmrI8OhTfDuo7bh8tJ2A64HZfb3vUxaRjy7eVEqXPgX9oIXCPP
         INp7FEmQSwurvH5N9PqeoIWiaBIz/xjKTvHCr3aFJ9Uo7SJeGfFwo7Rgx3AkvGHPz+4v
         2Scw==
X-Gm-Message-State: AOAM5332PZ4pdKNvEyHW7iIOZpA4UJ+ZgCS+nGp7IHVBjLzYDtjkDnLu
        FZ6ynUXsCGT93Ce9Xl2Oew5P53EEaSL/SA+5EXE=
X-Google-Smtp-Source: ABdhPJzOQ0jJrRGeKPDJc1Br/Q5LHygCNW2Qd0WvXMP8aBw7tnRZeENJ4/nMayeKIriDm7+WTK7FvcdZ9XIQOJCNWC4=
X-Received: by 2002:a25:6a05:: with SMTP id f5mr15568107ybc.459.1607655374568;
 Thu, 10 Dec 2020 18:56:14 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
 <20201210164315.GA184880@krava> <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
 <CA+khW7hU1+Ba+33gxyGWgwUyq8sOQthaLu6tUQP_cGWqS46gDw@mail.gmail.com>
In-Reply-To: <CA+khW7hU1+Ba+33gxyGWgwUyq8sOQthaLu6tUQP_cGWqS46gDw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Dec 2020 18:56:03 -0800
Message-ID: <CAEf4BzZHFcc78YXQbrftPtD7dsMfPrS=A3dBJggAVETrJd3NoQ@mail.gmail.com>
Subject: Re: Per-CPU variables in modules and pahole
To:     Hao Luo <haoluo@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 10, 2020 at 10:29 AM Hao Luo <haoluo@google.com> wrote:
>
> On Thu, Dec 10, 2020 at 9:02 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Dec 10, 2020 at 8:43 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Dec 09, 2020 at 12:53:44PM -0800, Andrii Nakryiko wrote:
> > > > Hi,
> > > >
> > > > I'm working on supporting per-CPU symbols in BPF/libbpf, and the
> > > > prerequisite for that is BTF data for .data..percpu data section and
> > > > variables inside that.
> > > >
> > > > Turns out, pahole doesn't currently emit any BTF information for such
> > > > variables in kernel modules. And the reason why is quite confusing and
> > > > I can't figure it out myself, so was hoping someone else might be able
> > > > to help.
> > > >
> > > > To repro, you can take latest bpf-next tree and add this to
> > > > bpf_testmod/bpf_testmod.c inside selftests/bpf:
> > > >
> > > > $ git diff bpf_testmod/bpf_testmod.c
> > > >       diff --git
> > > > a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > > b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > > index 2df19d73ca49..b2086b798019 100644
> > > > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > > @@ -3,6 +3,7 @@
> > > >  #include <linux/error-injection.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/module.h>
> > > > +#include <linux/percpu-defs.h>
> > > >  #include <linux/sysfs.h>
> > > >  #include <linux/tracepoint.h>
> > > >  #include "bpf_testmod.h"
> > > > @@ -10,6 +11,10 @@
> > > >  #define CREATE_TRACE_POINTS
> > > >  #include "bpf_testmod-events.h"
> > > >
> > > > +DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy1) = -1;
> > > > +DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
> > > > +DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy2) = -1;
> > > > +
> > > >  noinline ssize_t
> > > >  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> > > >                       struct bin_attribute *bin_attr,
> > > >
> > > > 1. So the very first issue (that I'm going to ignore for now) is that
> > > > if I just added bpf_testmod_ksym_percpu, it would get addr == 0 and
> > > > would be ignored by the current pahole logic. So we need to fix that
> > > > for modules. Adding dummy1 and dummy2 takes care of this for now,
> > > > bpf_testmod_ksym_percpu has offset 4.
> > >
> > > I removed that addr zero check in the modules changes but when
> > > collecting functions, but it's still there in collect_percpu_var
> >
> > Hao had some reason to skip per-cpu variables with offset 0, maybe he
> > can comment on that before we change it.
> >
>
> When I initially write that check, I see there are multiple symbols of
> the same name that associate with a single variable, but there is only
> one that has a non-zero address. Besides, there are symbols that don't
> associate to any variable and they have zero address. For example,
> those defined as __ADDRESSABLE(sym) and __UNIQUE_ID(prefix). They are
> quite a lot, I remember. So I filtered out the zero address for the
> purpose of accelerating encoding. I noticed that on x86_64, the first
> page of the percpu section is reserved, so I deem those symbols that
> are of normal interest should have positive addresses.

So I just checked my local vmlinux image, and seems like the only one
with addr == 0 is fixed_percpu_data. Everything else that's detected
as belonging to .data..percpu section looks sane and has non-zero
offset.

So I think this might have been the case before we switched to using
ELF symbols and now it's not? I think I'll just drop this check, will
post the patch, and would really appreciate if you can test it in your
environment. Does that sound ok?

>
> >
> > >
> > > >
> > > > 2. Second issue is more interesting. Somehow, when pahole iterates
> > > > over DWARF variables, the address of bpf_testmod_ksym_percpu is
> > > > reported as 0x10e74, not 4. Which totally confuses pahole because
> > > > according to ELF symbols, bpf_testmod_ksym_percpu symbol has value 4.
> > > > I tracked this down to dwarf_getlocation() returning 10e74 as number
> > > > field in expr.
> > >
> > > in which place do you see that address? when I put displayed
> > > address from collect_percpu_var it shows 4
> >
> > yes, ELF symbol's value is 4, but when iterating DWARF variables
> > (0x10e70 + 4) is returned. It does look like a special handling of
> > modules. I missed that libdw does some special things for specifically
> > modules. Further debugging yesterday showed that 0x10e70 roughly
> > corresponds to the offset of .data..per_cpu if you count all the
> > allocatable data sections that come before it. So I think you are
> > right. We should probably centralize the logic of kernel module
> > detection so that we can handle these module vs non-module differences
> > properly.
> >
> > >
> > > not sure this is related but looks like similar issue I had to
> > > solve for modules functions, as described in the changelog:
> > > (not merged yet)
> > >
> > >     btf_encoder: Detect kernel module ftrace addresses
> > >
> > >     ...
> > >     There's one tricky point with kernel modules wrt Elf object,
> > >     which we get from dwfl_module_getelf function. This function
> > >     performs all possible relocations, including __mcount_loc
> > >     section.
> > >
> > >     So addrs array contains relocated values, which we need take
> > >     into account when we compare them to functions values which
> > >     are relative to their sections.
> > >     ...
> > >
> > > The 0x10e74 value could be relocated 4.. but it's me guessing,
> > > because not sure where you see that address exactly
> >
> >
> > It comes up in cu__encode_btf(), var->ip.addr is not 4, as we expect it to be.
> >
> > >
> > > jirka
> > >
