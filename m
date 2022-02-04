Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E24AA00F
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiBDT3A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 14:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiBDT27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 14:28:59 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C435BC06173D
        for <bpf@vger.kernel.org>; Fri,  4 Feb 2022 11:28:58 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id g3so1533933qvb.8
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvUdSyv4AHEETuOkpKa8AYU99AJ+vHmq6OnHDcdbIU8=;
        b=fGT+Al6jKRABrpuLfbqnm6XPKxGS7b9L/JLvBA9fAuere+nRCcWK8x0tkYF9n+W+JR
         IS0JAG5bIEXor67f+t/MO7IqVr4nOUr/vs6FhCUaJYJU15l0efC0QaR9jUzezLeiNqGK
         Xl+SxDny7GxqBbW+QC0RsgJMqrWxvakkz2KRSx/lW1wIjQI6KwiSPrhUoDq3F/PwFnlb
         uuz4+4jiJspu0dn9SFRlH7KEPqorov1JYBufZTMoXnQvmpjuaShMW3iyalvp93btMUB6
         a2q9uY3JupTZdS7KyEQhCsuO+9RLY/KhSYpNI4UaDGSzbuPdDCCyYffvNdqwzP9nL1i1
         yEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvUdSyv4AHEETuOkpKa8AYU99AJ+vHmq6OnHDcdbIU8=;
        b=xxm25QNJcJ4aN3pTFkfjQnz1RkAOXsnj67jxt4+4b/ATznxFTxzNJrdOkdqgmRMDV0
         XjRKdGUza8B0V0lK5r0gC/rErrFx1wzOdJwrZnzCA7PxCSOQ7AMd9eVmGgqFUXcFbZlh
         wV4XxOlxqjksys73Zwk8MNLivkQKGhKWVPbLydq/6iq6FT/smXyzWe4hF00fvVQmVjFE
         wm9hT3hN70i1jR9w+yTIDSK7EsHSnz2MQZNrD9T/6fNpW44Hcp+0MQDPfpyWTIr/kiIz
         AD13mNSJY1V7w4ZHqaFnR3h5/Er6PV68ki21JCOaa3iHBbZ1C/bQLN44+0XaEX4fnKgt
         jxvg==
X-Gm-Message-State: AOAM5326Rn8Xs04xMMiFPiN/tX5qo7t/k2Jlq+cTcWIE8qFku2HA0C23
        aRRrw3a/npXjiag3BAQryrQSAz4S7NIpIH6y5O+84A==
X-Google-Smtp-Source: ABdhPJz/rX+0dPHg87Q4MmU26z7oDIcRLBPYQVs2/QezJuBT0ix3+DXyrdbp+sWb3hIf31rQwnMT0S5pGUnyhGlO/D0=
X-Received: by 2002:ad4:576f:: with SMTP id r15mr3056183qvx.35.1644002937619;
 Fri, 04 Feb 2022 11:28:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7gh=vO8m-_SVnwWwj7kv+EDeUPcuWFqebf2Zmi9T_oEAQ@mail.gmail.com>
 <CAPhsuW7F4KritXPXixoPSw4zbCsqpfZaYBuw5BgD+KKXaoeGxg@mail.gmail.com>
 <CA+khW7jx_4K46gH+tyZZn9ApSYGMqYpxCm0ywmuWdSiogv7dqw@mail.gmail.com> <CAPhsuW4JJiMNqvzK+8SKM3=72xgsF+jxB3m-u-Jz9Fe7Z4i9fg@mail.gmail.com>
In-Reply-To: <CAPhsuW4JJiMNqvzK+8SKM3=72xgsF+jxB3m-u-Jz9Fe7Z4i9fg@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 4 Feb 2022 11:28:46 -0800
Message-ID: <CA+khW7iaCDcpD7JEg9PB-UbYyUuLaEdryhbfaW5tUQ-SUv2sKQ@mail.gmail.com>
Subject: Re: [Question] How to reliably get BuildIDs from bpf prog
To:     Song Liu <song@kernel.org>
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

On Tue, Jan 25, 2022 at 4:16 PM Song Liu <song@kernel.org> wrote:
>
> On Tue, Jan 25, 2022 at 3:54 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Thanks Song for your suggestion.
> >
> > On Mon, Jan 24, 2022 at 11:08 PM Song Liu <song@kernel.org> wrote:
> > >
> > > On Mon, Jan 24, 2022 at 2:43 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > Dear BPF experts,
> > > >
> > > > I'm working on collecting some kernel performance data using BPF
> > > > tracing prog. Our performance profiling team wants to associate the
> > > > data with user stack information. One of the requirements is to
> > > > reliably get BuildIDs from bpf_get_stackid() and other similar helpers
> > > > [1].
> > > >
> > > > As part of an early investigation, we found that there are a couple
> > > > issues that make bpf_get_stackid() much less reliable than we'd like
> > > > for our use:
> > > >
> > > > 1. The first page of many binaries (which contains the ELF headers and
> > > > thus the BuildID that we need) is often not in memory. The failure of
> > > > find_get_page() (called from build_id_parse()) is higher than we would
> > > > want.
> > >
> > > Our top use case of bpf_get_stack() is called from NMI, so there isn't
> > > much we can do. Maybe it is possible to improve it by changing the
> > > layout of the binary and the libraries? Specifically, if the text is
> > > also in the first page, it is likely to stay in memory?
> > >
> >
> > We are seeing 30-40% of stack frames not able to get build ids due to
> > this. This is a place where we could improve the reliability of build
> > id.
> >
> > There were a few proposals coming up when we found this issue. One of
> > them is to have userspace mlock the first page. This would be the
> > easiest fix, if it works. Another proposal from Ian Rogers (cc'ed) is
> > to embed build id in vma. This is an idea similar to [1], but it's
> > unclear (at least to me) where to store the string. I'm wondering if
> > we can introduce a sleepable version of bpf_get_stack() if it helps.
> > When a page is not present, sleepable bpf_get_stack() can bring in the
> > page.
>
> I guess it is possible to have different flavors of bpf_get_stack().
> However, I am not sure whether the actual use case could use sleepable
> BPF programs. Our user of bpf_get_stack() is a profiler. The BPF program
> which triggers a perf_event from NMI, where we really cannot sleep.
>
> If we have target use case that could sleep, sleepable bpf_get_stack() sounds
> reasonable to me.
>
> >
> > [1] https://lwn.net/Articles/867818/
> >
> > > > 2. When anonymous huge pages are used to hold some regions of process
> > > > text, build_id_parse() also fails to get a BuildID because
> > > > vma->vm_file is NULL.
> > >
> > > How did the text get in anonymous memory? I guess it is NOT from JIT?
> > > We had a hack to use transparent huge page for application text. The
> > > hack looks like:
> > >
> > > "At run time, the application creates an 8MB temporary buffer and the
> > > hot section of the executable memory is copied to it. The 8MB region in
> > > the executable memory is then converted to a huge page (by way of an
> > > mmap() to anonymous pages and an madvise() to create a huge page), the
> > > data is copied back to it, and it is made executable again using
> > > mprotect()."
> > >
> > > If your case is the same (or similar), it can probably be fixed with
> > > CONFIG_READ_ONLY_THP_FOR_FS, and modified user space.
> > >
> >
> > In our use cases, we have text mapped to huge pages that are not
> > backed by files. vma->vm_file could be null or points some fake file.
> > This causes challenges for us on getting build id for these code text.
>
> So, what is the ideal output in these cases? If there isn't a back file, we
> don't really have good build-id for it, right?
>

Right, I don't have a solution for this case unfortunately. Probably
will just discard the failed frames. :(

But in the case where the problem is the page not in mem, Song, do you
also see a similar high rate of build id parsing failure in your use
case (30 ~ 40% of frames)? If no, we may have done something wrong on
our side. If yes, is that a problem for your use case?

> Thanks,
> Song
