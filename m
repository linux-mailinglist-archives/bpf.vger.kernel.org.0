Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09F949C009
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 01:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiAZAQW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 19:16:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56346 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiAZAQU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 19:16:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6667BB81B8C;
        Wed, 26 Jan 2022 00:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F02C340E9;
        Wed, 26 Jan 2022 00:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643156178;
        bh=nNya5xBFq1T0FSdPlCDjqGLn9d3mBQRG0+SS4LR5nuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CRS+bb8KHILgT4i2AsI0NvilErAf3oO59C68FNNLAFBBLSNqhkynl+3+FdbGpObtp
         veBPpm5A9yFBbWISFqE8HzqJiyLJ4d65ev8koIRkZNTvTuqDPqS1msZX7+kIC30VBJ
         EB/PJ6v3YpAOWTCaskEsRrHMOBYNmTuURXdzaeNWuOA/acLxqqvkoZbP8L8W0EdbZ5
         2zyXUdUP8UMHYH22bIa97yVOOT6Y5qV7Sc3AlVwVlIuX+SII3TXlhjMqNOcQPo0xgF
         PRenasU/9kYcdFSzJJiOUiWIcd3ADwGA8ZCDfSHggV/YzalT05MWW/1ot0ATWkRZBq
         HbuDkFswd6Yag==
Received: by mail-yb1-f171.google.com with SMTP id i62so20160235ybg.5;
        Tue, 25 Jan 2022 16:16:18 -0800 (PST)
X-Gm-Message-State: AOAM533gFsr70Ga7Z8do2DD2jfKwLKO7HUshGimv6b44klWSeZrGvuQ0
        FFbthSnhJziE97Y+PG9E69aks8LSd74c8peeRWo=
X-Google-Smtp-Source: ABdhPJxAilAcenABWiQWnjUGp2g7zXeU4dloPT2KdcBM9tUVfrSg0MHmChiOlDcbLG19RGyrScuW87jCZigCxVfYOLw=
X-Received: by 2002:a25:fd6:: with SMTP id 205mr34295767ybp.654.1643156177185;
 Tue, 25 Jan 2022 16:16:17 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7gh=vO8m-_SVnwWwj7kv+EDeUPcuWFqebf2Zmi9T_oEAQ@mail.gmail.com>
 <CAPhsuW7F4KritXPXixoPSw4zbCsqpfZaYBuw5BgD+KKXaoeGxg@mail.gmail.com> <CA+khW7jx_4K46gH+tyZZn9ApSYGMqYpxCm0ywmuWdSiogv7dqw@mail.gmail.com>
In-Reply-To: <CA+khW7jx_4K46gH+tyZZn9ApSYGMqYpxCm0ywmuWdSiogv7dqw@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 25 Jan 2022 16:16:06 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4JJiMNqvzK+8SKM3=72xgsF+jxB3m-u-Jz9Fe7Z4i9fg@mail.gmail.com>
Message-ID: <CAPhsuW4JJiMNqvzK+8SKM3=72xgsF+jxB3m-u-Jz9Fe7Z4i9fg@mail.gmail.com>
Subject: Re: [Question] How to reliably get BuildIDs from bpf prog
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Blake Jones <blakejones@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Namhyung Kim <namhyung@google.com>,
        Ian Rogers <irogers@google.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 3:54 PM Hao Luo <haoluo@google.com> wrote:
>
> Thanks Song for your suggestion.
>
> On Mon, Jan 24, 2022 at 11:08 PM Song Liu <song@kernel.org> wrote:
> >
> > On Mon, Jan 24, 2022 at 2:43 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > Dear BPF experts,
> > >
> > > I'm working on collecting some kernel performance data using BPF
> > > tracing prog. Our performance profiling team wants to associate the
> > > data with user stack information. One of the requirements is to
> > > reliably get BuildIDs from bpf_get_stackid() and other similar helpers
> > > [1].
> > >
> > > As part of an early investigation, we found that there are a couple
> > > issues that make bpf_get_stackid() much less reliable than we'd like
> > > for our use:
> > >
> > > 1. The first page of many binaries (which contains the ELF headers and
> > > thus the BuildID that we need) is often not in memory. The failure of
> > > find_get_page() (called from build_id_parse()) is higher than we would
> > > want.
> >
> > Our top use case of bpf_get_stack() is called from NMI, so there isn't
> > much we can do. Maybe it is possible to improve it by changing the
> > layout of the binary and the libraries? Specifically, if the text is
> > also in the first page, it is likely to stay in memory?
> >
>
> We are seeing 30-40% of stack frames not able to get build ids due to
> this. This is a place where we could improve the reliability of build
> id.
>
> There were a few proposals coming up when we found this issue. One of
> them is to have userspace mlock the first page. This would be the
> easiest fix, if it works. Another proposal from Ian Rogers (cc'ed) is
> to embed build id in vma. This is an idea similar to [1], but it's
> unclear (at least to me) where to store the string. I'm wondering if
> we can introduce a sleepable version of bpf_get_stack() if it helps.
> When a page is not present, sleepable bpf_get_stack() can bring in the
> page.

I guess it is possible to have different flavors of bpf_get_stack().
However, I am not sure whether the actual use case could use sleepable
BPF programs. Our user of bpf_get_stack() is a profiler. The BPF program
which triggers a perf_event from NMI, where we really cannot sleep.

If we have target use case that could sleep, sleepable bpf_get_stack() sounds
reasonable to me.

>
> [1] https://lwn.net/Articles/867818/
>
> > > 2. When anonymous huge pages are used to hold some regions of process
> > > text, build_id_parse() also fails to get a BuildID because
> > > vma->vm_file is NULL.
> >
> > How did the text get in anonymous memory? I guess it is NOT from JIT?
> > We had a hack to use transparent huge page for application text. The
> > hack looks like:
> >
> > "At run time, the application creates an 8MB temporary buffer and the
> > hot section of the executable memory is copied to it. The 8MB region in
> > the executable memory is then converted to a huge page (by way of an
> > mmap() to anonymous pages and an madvise() to create a huge page), the
> > data is copied back to it, and it is made executable again using
> > mprotect()."
> >
> > If your case is the same (or similar), it can probably be fixed with
> > CONFIG_READ_ONLY_THP_FOR_FS, and modified user space.
> >
>
> In our use cases, we have text mapped to huge pages that are not
> backed by files. vma->vm_file could be null or points some fake file.
> This causes challenges for us on getting build id for these code text.

So, what is the ideal output in these cases? If there isn't a back file, we
don't really have good build-id for it, right?

Thanks,
Song
