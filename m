Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DAA48F1CA
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 22:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiANVA6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 16:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiANVA5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 16:00:57 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50792C061574;
        Fri, 14 Jan 2022 13:00:57 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id i14so9364015ila.11;
        Fri, 14 Jan 2022 13:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/3XZOyIgDP11RoDvk9GWnXC8L5uLhKIajiH8VUBzOo=;
        b=X8Ojmz8Gs8Y1ev7ywHRDPYIEusIcZGYXYqedV5pLiulCBb+Kk45BSZkrOJufxmeFfp
         eX/Y7q/Z6c+IDtJykf7P/+oFOlsE94KCDwKpxdDNkT4+aCd8Y+lrugn7NRINlCKLXa5d
         m1QdNMw9PMc8yX3Dg09TuvGTk1trKLOWAa818UW945AvQ9IpiQ9w/9X36BuwF3dAiv9j
         +O58ddyWz+7jjQad/xh7nRlNhDpdI5+sit7fBuUs0uwUJ/uSCHykihZgi42vADzbl+Ee
         SgVtdqlLN4t19075JS8dKUxrRXJPIZzbIsDKfKmsk0fMpjkNVNeOJEnfLPjruMwwyCOv
         DvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/3XZOyIgDP11RoDvk9GWnXC8L5uLhKIajiH8VUBzOo=;
        b=cTOYWHNF+sp3ESbtR4YcqgZTGZAg3VNqc9OyyglzF3Tk5mEBlaPXF72g2/o3pHvTZg
         7gjUCgfgG3bwOQBxOi/gB3NQVBq1n+YO0fNvqiQDzFAz2S2Uh1vk9VpWziRwNFPoFRNk
         ZViJL3m+yA9V7u1/0q8hH9hzEAiWsRF/mVu9u+TiNk8cwadH9WB/Aj93Nd20oQ9HKFco
         /dj2kdhdyM7hU1F5eEzXhTxzboX1Pfo+rDzP591+Busm8RdUmT4FvgmLcRq2VjgTcohV
         A66wOaObpulQvb2tudTZAbMBGZJcu9nvrJfyIhgiW+w5Ttq/Yu/Dbi2HVLveqDU+87HT
         ahRw==
X-Gm-Message-State: AOAM531apo0b6hOGYBLMbVljb2fC/8AxO5CDrY0fsRIIfK8aMoIaGs+k
        j2bXJbIJylHIiJx9MMKR5LJYtNvQUACXWllWk/lB3MyOl3c=
X-Google-Smtp-Source: ABdhPJxB3tJlKWBbbJ6m7MVMyTBXUprEY+7ohw2BCRFcuAuj+a82nPy0eqzmlbdI8NV6kTBKur5P4tcd49iLauiofCs=
X-Received: by 2002:a05:6e02:1749:: with SMTP id y9mr5373560ill.252.1642194056573;
 Fri, 14 Jan 2022 13:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20211216222108.110518-1-christylee@fb.com> <20211216222108.110518-3-christylee@fb.com>
 <YcGO271nDvfMeSlK@krava> <CAEf4BzZpNvEtfsVHUJGfwi_1xM+7-ohBPKPrRo--X=fYkYLrsw@mail.gmail.com>
 <YcMr1LeP6zUBdCiK@krava> <CAEf4Bzb2HWiuJmeb6WxE2Dift5qQOLBE=j1ZqfpVMjuWV3+EDg@mail.gmail.com>
 <CAPqJDZouQHpUXv4dEGKKe=UjwkZu3=GMQ2M9g2zLYOV6a=gZbw@mail.gmail.com>
 <YdRccTaunl9Fo63X@krava> <YdWhz1qaRncxNC/6@krava> <CAPqJDZpZrrg4UBz19H-HyEMk7rzn+PCe=qpYDR0uHvD3nPr4yw@mail.gmail.com>
 <YeBBzbfjOgE/wfjK@krava>
In-Reply-To: <YeBBzbfjOgE/wfjK@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 13:00:45 -0800
Message-ID: <CAEf4BzatQ-y=kvTYvLj0rdtPTWuhNtep6gfWPj-aru7psfD9AQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] perf: stop using deprecated
 bpf__object_next() API
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Christy Lee <christylee@fb.com>,
        Christy Lee <christyc.y.lee@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        He Kuang <hekuang@huawei.com>, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 13, 2022 at 7:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Jan 06, 2022 at 09:54:38AM -0800, Christy Lee wrote:
> > Thank you so much, I was able to reproduce the original tests after applying
> > the bug fix. I will submit a new patch set with the more detailed comments.
> >
> > The only deprecated functions that need to be removed after this would be
> > bpf_program__set_prep() (how perf sets the bpf prologue) and
> > bpf_program__nth_fd() (how perf leverages multi instance bpf). They look a
> > little more involved and I'm not sure how to approach those. Jiri, would you
> > mind taking a look at those please?
>
> hi,
> I checked and here's the way perf uses this interface:
>
>   - when bpf object/sources is specified on perf command line
>     we use bpf_object__open to load it
>
>   - user can define parameters in the section name for each bpf program
>     like:
>
>       SEC("lock_page=__lock_page page->flags")
>       int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
>       {
>              return 1;
>       }
>
>     which tells perf to 'prepare' some extra bpf code for the program,
>     like to put value of 'page->flags' into 'flags' argument above
>
>   - perf generates extra prologue code to retrieve this data and does
>     that before the program is loaded by using bpf_program__set_prep
>     callback
>
>   - now the reason why we use bpf_program__set_prep for that, is because
>     it allows to create multiple instances for one bpf program
>
>   - we need multiple instances for single program, because probe can
>     result in multiple attach addresses (like for inlined functions)
>     with possible different ways of getting the arguments we need
>     to load
>
> I guess you want to get rid of that whole 'struct instances' related
> stuff, is that right?
>
> perf would need to load all the needed instances for program manually
> and somehow bypass/workaround bpf_object__load.. is there a way to
> manually add extra programs to bpf_object?
>
> thoughts? ;-)

Sigh..

1. SEC("lock_page=__lock_page page->flags") will break in libbpf 1.0.
I'm going to add a way to provide a custom callback to handle such BPF
program sections by your custom code, but... Who's using this? Is
anyone using this? How is this used and for what? Would it be possible
to just kill this feature?

2. For creating multiple instances. I've added bpf_program__insns()
API to fetch exact bytecode as it is sent by libbpf to kernel. If you
fetch those instructions *after* the program is loaded, all the map
FDs and other stuff will be correct and resolved. At that point you
can use that to create as many copies as you want to with low-level
bpf_prog_load() API. You'll need to keep track of those FDs of clones,
but you'll have your multiple instances.

3. Do you really support attaching to inlined functions *and* also
fetching their input arguments? How does that even work, given that
the compiler can spread and reorder inlined function code as it sees
fit?...

But really, why does that feature exist at all? Why BPF program can't
fetch whatever it needs to fetch explicitly, like the rest of BPF
applications in the world do? Too much custom magic :( Especially with
the BPF_KPROBE() macro this is so trivial to do...

Can we kill this feature altogether, maybe? Pretty please? Such a
burden for everyone...

>
> thanks,
> jirka
>
