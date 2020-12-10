Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828B92D62EB
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 18:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbgLJRDJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 12:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732826AbgLJRC5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Dec 2020 12:02:57 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51FDC0613D6;
        Thu, 10 Dec 2020 09:02:16 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id k78so5337267ybf.12;
        Thu, 10 Dec 2020 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaYcvONBqP/ZnqqdQ38xcrKnElwc1CHM/ix5ks0e3Uk=;
        b=CsPDP5ojpwt4CVXcGL/QMurn5dKSrext3W/8iIps3bwiisECqQQYuIU9h/KvirCijH
         aTQbIa3M+dsoZOYfvBr/8+0HbxqCDD+42tNbUEpkUCa/QU3PZWOEWqUMsDHwG8PPBkQl
         B0jbw9mwWSfcpIwzIqm7/3HM71w1RPcHQ3aNw8kE3zPq/Ir0MyRF2UtSmqcWenjZyRVz
         9DT6+uKUdJLGleSyvM4diU3tjLG6Z6zAZr3M14DQbJak5FKLEMcBtEsL96aQK/NZMDnv
         vfyjOMgV7DBtoHuy85Y8O5GL66TE0BBdxJn/eodqkYRtjf6caGTJQKNkTnkSNqdM2oMi
         WvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaYcvONBqP/ZnqqdQ38xcrKnElwc1CHM/ix5ks0e3Uk=;
        b=YuPWYbM1YJ7g8u8Bulvz22KNkZcbny77BSGRZemIuiypt0YYK4w7ouaUbgU7y2UBCg
         mMsrovxIjxQK5VU+rv6F/tMaXzESx8B8mFQ055YZYsx/c1s/9JuEpC7nOQK/F3n1ObkM
         WbTWDhi7UMOa7ihwEmsIV22lgjxcMy4nurftNs+VH38ByiGDG6EA0j+0ziMECbxADWbz
         +ndEMY66BmvMJiIIp42uVm4istRlvfrB6er/1RMMOevYw8gy1F7I8GOolIEsnk5ZtpcL
         qGZr3dn7pfjVzGUXVWmsfCsKww433qBoG1M4lzv2w38gl+iaLF3a0RS9O6qdJlylst5x
         QllQ==
X-Gm-Message-State: AOAM531Ww+JVpaAEgpR64s/boVR8+HIsyrml5C2icB6n7DDIY0K9DYG7
        b6tVUsoIWqcwNdPd7ZqcS3SlVvr6vu7Efvzplr8/f73KicCOdw==
X-Google-Smtp-Source: ABdhPJyM/295uVE8r+Z9+eQ9iQbSmfOxWH34/+Bh9g885d3jPCiuEAcnMLRUf1WDZEPTFulYfocMroBphmYBoX8MofI=
X-Received: by 2002:a25:f505:: with SMTP id a5mr11898650ybe.425.1607619735888;
 Thu, 10 Dec 2020 09:02:15 -0800 (PST)
MIME-Version: 1.0
References: <CAEf4BzZWabv_hExaANQyQ71L2JHYqXaT4hFj52w-poWoVYWKqQ@mail.gmail.com>
 <20201210164315.GA184880@krava>
In-Reply-To: <20201210164315.GA184880@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Dec 2020 09:02:05 -0800
Message-ID: <CAEf4BzaBOoZsSK8yGZBhwFzAADkQKsGt1quV9RvFk_+WZr=Y=Q@mail.gmail.com>
Subject: Re: Per-CPU variables in modules and pahole
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 10, 2020 at 8:43 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Dec 09, 2020 at 12:53:44PM -0800, Andrii Nakryiko wrote:
> > Hi,
> >
> > I'm working on supporting per-CPU symbols in BPF/libbpf, and the
> > prerequisite for that is BTF data for .data..percpu data section and
> > variables inside that.
> >
> > Turns out, pahole doesn't currently emit any BTF information for such
> > variables in kernel modules. And the reason why is quite confusing and
> > I can't figure it out myself, so was hoping someone else might be able
> > to help.
> >
> > To repro, you can take latest bpf-next tree and add this to
> > bpf_testmod/bpf_testmod.c inside selftests/bpf:
> >
> > $ git diff bpf_testmod/bpf_testmod.c
> >       diff --git
> > a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 2df19d73ca49..b2086b798019 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/error-injection.h>
> >  #include <linux/init.h>
> >  #include <linux/module.h>
> > +#include <linux/percpu-defs.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/tracepoint.h>
> >  #include "bpf_testmod.h"
> > @@ -10,6 +11,10 @@
> >  #define CREATE_TRACE_POINTS
> >  #include "bpf_testmod-events.h"
> >
> > +DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy1) = -1;
> > +DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
> > +DEFINE_PER_CPU(int, bpf_testmod_ksym_dummy2) = -1;
> > +
> >  noinline ssize_t
> >  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> >                       struct bin_attribute *bin_attr,
> >
> > 1. So the very first issue (that I'm going to ignore for now) is that
> > if I just added bpf_testmod_ksym_percpu, it would get addr == 0 and
> > would be ignored by the current pahole logic. So we need to fix that
> > for modules. Adding dummy1 and dummy2 takes care of this for now,
> > bpf_testmod_ksym_percpu has offset 4.
>
> I removed that addr zero check in the modules changes but when
> collecting functions, but it's still there in collect_percpu_var

Hao had some reason to skip per-cpu variables with offset 0, maybe he
can comment on that before we change it.

>
> >
> > 2. Second issue is more interesting. Somehow, when pahole iterates
> > over DWARF variables, the address of bpf_testmod_ksym_percpu is
> > reported as 0x10e74, not 4. Which totally confuses pahole because
> > according to ELF symbols, bpf_testmod_ksym_percpu symbol has value 4.
> > I tracked this down to dwarf_getlocation() returning 10e74 as number
> > field in expr.
>
> in which place do you see that address? when I put displayed
> address from collect_percpu_var it shows 4

yes, ELF symbol's value is 4, but when iterating DWARF variables
(0x10e70 + 4) is returned. It does look like a special handling of
modules. I missed that libdw does some special things for specifically
modules. Further debugging yesterday showed that 0x10e70 roughly
corresponds to the offset of .data..per_cpu if you count all the
allocatable data sections that come before it. So I think you are
right. We should probably centralize the logic of kernel module
detection so that we can handle these module vs non-module differences
properly.

>
> not sure this is related but looks like similar issue I had to
> solve for modules functions, as described in the changelog:
> (not merged yet)
>
>     btf_encoder: Detect kernel module ftrace addresses
>
>     ...
>     There's one tricky point with kernel modules wrt Elf object,
>     which we get from dwfl_module_getelf function. This function
>     performs all possible relocations, including __mcount_loc
>     section.
>
>     So addrs array contains relocated values, which we need take
>     into account when we compare them to functions values which
>     are relative to their sections.
>     ...
>
> The 0x10e74 value could be relocated 4.. but it's me guessing,
> because not sure where you see that address exactly


It comes up in cu__encode_btf(), var->ip.addr is not 4, as we expect it to be.

>
> jirka
>
