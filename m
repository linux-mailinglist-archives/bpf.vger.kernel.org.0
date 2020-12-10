Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FA22D6500
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 19:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390329AbgLJS36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 13:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389128AbgLJS3l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 13:29:41 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10251C0613D6
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 10:29:01 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n4so6543730iow.12
        for <bpf@vger.kernel.org>; Thu, 10 Dec 2020 10:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNE/BHkW6DlVzWL1ezPxZSD39LGAT96NfgLIIKU+T+U=;
        b=oHo0cD8NjoCZBKGXficJtyifqk3JLHRnBAirkJiHOVsAKC1iTEi55ie1bpJXsqZTJX
         6YrXMiYr/lcduxqFarqAdrNbJL0/Yzn3istkPZyG2Usfqn6dHZ+pDvSrfdyJpFJ4Xh2G
         GQbG7GNMdk0eUTmnuGxdJzqlSOz9ooJRwAgdpV9Hd/RP2xsZThAG1d6ZbcRGsfyiXHAA
         njJ3TFCyZwW/RfYud/Bv7/5lQ+P92ePKFvXKlmg2aY9PuUAF22FrXKU1MpmoEiBphONV
         oPerJv++Ipf23jOJbtjgNFcFr3OUN2F2GfJ4iMGbvekZxWdPbjulVDvqewn0EgRsc28U
         P6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNE/BHkW6DlVzWL1ezPxZSD39LGAT96NfgLIIKU+T+U=;
        b=drNNsH5zPPHKYQ0v7ncya96BjIzlz71POSDFvSYZD8jpjdng2bmWtsgWhVIB/VwqAN
         sWt06zbGzTb5gHDXlBb+isEKLhj/dRNk4urLdGU0P34PisPO3yunXJuhFpDjMedIKKIG
         XeSfN6tIz6APQB6A04n//Hs3mEAgJUUy9VNnXI06K69yIPbOuAo8t1AlFHvOGiDg474n
         9+ZKnl3Lj6aKy39wzb+MpGrNmWJkoNNjS+5OZnOf2n9WwvZMja9xq3HNAPzRWCUcH9Lu
         RdSHt2s6OV9pO7ZP5cjuUXRvG5gutayasHiEdOaz3pA3Xuam1bCCcpefrcksiCHD1A4r
         x1lg==
X-Gm-Message-State: AOAM531IfZgZfnv+kdAkeASqZ+0EXN1a1SBQeq2nUF+qNepJeF1vZZYJ
        PgLeXqLPJ3oIb7ywl1P6tNOL7ZBCboqj2LAX1NMYtRT28Hp191am
X-Google-Smtp-Source: ABdhPJzobFCStS8tNN/CX2ne9EpIsM7A8q5y44OZIAN8rhvbCzLi5V7rVgVsq0TFdNmZMHB0qZ3rDcy02I0P6YegPZU=
X-Received: by 2002:a5e:a614:: with SMTP id q20mr9581890ioi.198.1607624940019;
 Thu, 10 Dec 2020 10:29:00 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
 <20201210164315.GA184880@krava> <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
In-Reply-To: <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 10 Dec 2020 10:28:43 -0800
Message-ID: <CA+khW7hU1+Ba+33gxyGWgwUyq8sOQthaLu6tUQP_cGWqS46gDw@mail.gmail.com>
Subject: Re: Per-CPU variables in modules and pahole
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 10, 2020 at 9:02 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 10, 2020 at 8:43 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Dec 09, 2020 at 12:53:44PM -0800, Andrii Nakryiko wrote:
> > > Hi,
> > >
> > > I'm working on supporting per-CPU symbols in BPF/libbpf, and the
> > > prerequisite for that is BTF data for .data..percpu data section and
> > > variables inside that.
> > >
> > > Turns out, pahole doesn't currently emit any BTF information for such
> > > variables in kernel modules. And the reason why is quite confusing and
> > > I can't figure it out myself, so was hoping someone else might be able
> > > to help.
> > >
> > > To repro, you can take latest bpf-next tree and add this to
> > > bpf_testmod/bpf_testmod.c inside selftests/bpf:
> > >
> > > $ git diff bpf_testmod/bpf_testmod.c
> > >       diff --git
> > > a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > index 2df19d73ca49..b2086b798019 100644
> > > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > @@ -3,6 +3,7 @@
> > >  #include <linux/error-injection.h>
> > >  #include <linux/init.h>
> > >  #include <linux/module.h>
> > > +#include <linux/percpu-defs.h>
> > >  #include <linux/sysfs.h>
> > >  #include <linux/tracepoint.h>
> > >  #include "bpf_testmod.h"
> > > @@ -10,6 +11,10 @@
> > >  #define CREATE_TRACE_POINTS
> > >  #include "bpf_testmod-events.h"
> > >
> > > +DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy1) = -1;
> > > +DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
> > > +DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy2) = -1;
> > > +
> > >  noinline ssize_t
> > >  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> > >                       struct bin_attribute *bin_attr,
> > >
> > > 1. So the very first issue (that I'm going to ignore for now) is that
> > > if I just added bpf_testmod_ksym_percpu, it would get addr == 0 and
> > > would be ignored by the current pahole logic. So we need to fix that
> > > for modules. Adding dummy1 and dummy2 takes care of this for now,
> > > bpf_testmod_ksym_percpu has offset 4.
> >
> > I removed that addr zero check in the modules changes but when
> > collecting functions, but it's still there in collect_percpu_var
>
> Hao had some reason to skip per-cpu variables with offset 0, maybe he
> can comment on that before we change it.
>

When I initially write that check, I see there are multiple symbols of
the same name that associate with a single variable, but there is only
one that has a non-zero address. Besides, there are symbols that don't
associate to any variable and they have zero address. For example,
those defined as __ADDRESSABLE(sym) and __UNIQUE_ID(prefix). They are
quite a lot, I remember. So I filtered out the zero address for the
purpose of accelerating encoding. I noticed that on x86_64, the first
page of the percpu section is reserved, so I deem those symbols that
are of normal interest should have positive addresses.

>
> >
> > >
> > > 2. Second issue is more interesting. Somehow, when pahole iterates
> > > over DWARF variables, the address of bpf_testmod_ksym_percpu is
> > > reported as 0x10e74, not 4. Which totally confuses pahole because
> > > according to ELF symbols, bpf_testmod_ksym_percpu symbol has value 4.
> > > I tracked this down to dwarf_getlocation() returning 10e74 as number
> > > field in expr.
> >
> > in which place do you see that address? when I put displayed
> > address from collect_percpu_var it shows 4
>
> yes, ELF symbol's value is 4, but when iterating DWARF variables
> (0x10e70 + 4) is returned. It does look like a special handling of
> modules. I missed that libdw does some special things for specifically
> modules. Further debugging yesterday showed that 0x10e70 roughly
> corresponds to the offset of .data..per_cpu if you count all the
> allocatable data sections that come before it. So I think you are
> right. We should probably centralize the logic of kernel module
> detection so that we can handle these module vs non-module differences
> properly.
>
> >
> > not sure this is related but looks like similar issue I had to
> > solve for modules functions, as described in the changelog:
> > (not merged yet)
> >
> >     btf_encoder: Detect kernel module ftrace addresses
> >
> >     ...
> >     There's one tricky point with kernel modules wrt Elf object,
> >     which we get from dwfl_module_getelf function. This function
> >     performs all possible relocations, including __mcount_loc
> >     section.
> >
> >     So addrs array contains relocated values, which we need take
> >     into account when we compare them to functions values which
> >     are relative to their sections.
> >     ...
> >
> > The 0x10e74 value could be relocated 4.. but it's me guessing,
> > because not sure where you see that address exactly
>
>
> It comes up in cu__encode_btf(), var->ip.addr is not 4, as we expect it to be.
>
> >
> > jirka
> >
