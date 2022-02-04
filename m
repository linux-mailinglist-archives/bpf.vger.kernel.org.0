Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F754AA049
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 20:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiBDTmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 14:42:39 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:42878 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiBDTmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Feb 2022 14:42:39 -0500
Received: by mail-qt1-f177.google.com with SMTP id s1so6597073qtw.9
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JbC8+naqmMGFLTWyMj3cT1mIuHoa6H6nQOCtbEqKg3M=;
        b=q7qWg8FNGY9UBDZDBZn99g/etbMeDQ72KcwFlWHN0TnqmhD3NAFtahRpeGCbbcCzeX
         vPqicZ7LvR7kuPArucxPFhLPulyHjzMKgWixlInSbhgp7E/TE+rvQ2rCUWGeIY4ohHpq
         3PADSbc3euSF3ZS7pc6Dygap6BMSjIUZ+Z6Xq5T5ODAPp9n7LvFDmiotkrfyUwtpIZhZ
         g55YSvXqpvJZkR5X68ri41MWT18rAR3RtHis7BDCGJBl4pLz4vIqrxapkDLXA695Y4Sv
         FbhQTU5BAQ2GnJlQV9C0DAi2S63hQrbffOgaKv54ndUvvNHrIQcN8/eIpif6TYte6JiM
         uW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JbC8+naqmMGFLTWyMj3cT1mIuHoa6H6nQOCtbEqKg3M=;
        b=WsZFxPbr4iZ8zayMKLI+FUCTR2Ir2q44TDuiSxh/fzNmR7h9Bhi50tC8KURDqQBshS
         uc1ab9rczhteDnxsXzH7XFI0NEDFrHDWYIOPwlAHV1C1gZQ02BOD2+0P7x9p800+nVKt
         3UwFb1TMbWEtdN/qYrkMLJZ2+ldmcEUUBdkfrtYvVZfnap1wFFovCf0lTPKoi3zxAQmm
         G/7R/hN0habgJfi3LGuVb/h6SIU9rDcnqlGaJkolAmuy89pAmcusmalAdjNfqA1f2fim
         jd5YJh/djjAf9kwgURa6+IST7WW6haDYMCC/lRFMbB3+0QlTwpHSgh+0wxVHv6BF/qKp
         qK9g==
X-Gm-Message-State: AOAM533CyC5oHZd2x4xFSRFWmzEf3Ldd3GnYQ0m6FXVeldeGGX5oxTuE
        Z+YlwEin+Ez+JmmnXHGyVYZ5NfRIDGXksl5EetUW+w==
X-Google-Smtp-Source: ABdhPJxrv4h/4iWWl4riwPirpNZczdI8YDtShQ2SED6pPsfgef/eYLZ/fRNSmBMe7hD8Ti77VEc6TPDXMN6LKAI4PvA=
X-Received: by 2002:ac8:58ce:: with SMTP id u14mr425194qta.299.1644003756857;
 Fri, 04 Feb 2022 11:42:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+khW7gh=vO8m-_SVnwWwj7kv+EDeUPcuWFqebf2Zmi9T_oEAQ@mail.gmail.com>
 <CAPhsuW7F4KritXPXixoPSw4zbCsqpfZaYBuw5BgD+KKXaoeGxg@mail.gmail.com>
 <CA+khW7jx_4K46gH+tyZZn9ApSYGMqYpxCm0ywmuWdSiogv7dqw@mail.gmail.com>
 <CAPhsuW4JJiMNqvzK+8SKM3=72xgsF+jxB3m-u-Jz9Fe7Z4i9fg@mail.gmail.com>
 <CA+khW7iaCDcpD7JEg9PB-UbYyUuLaEdryhbfaW5tUQ-SUv2sKQ@mail.gmail.com> <CAPhsuW7g+hj1jsFLeHTucZWrq+eB_qwu8bgkd+ObpbktF0t+DA@mail.gmail.com>
In-Reply-To: <CAPhsuW7g+hj1jsFLeHTucZWrq+eB_qwu8bgkd+ObpbktF0t+DA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 4 Feb 2022 11:42:25 -0800
Message-ID: <CA+khW7iW2TRK_RXOJnJVnAApeBHBp+KZRvowdB1wZB=T4jCL+g@mail.gmail.com>
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

On Fri, Feb 4, 2022 at 11:37 AM Song Liu <song@kernel.org> wrote:
>
> On Fri, Feb 4, 2022 at 11:29 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Tue, Jan 25, 2022 at 4:16 PM Song Liu <song@kernel.org> wrote:
> > >
> > > On Tue, Jan 25, 2022 at 3:54 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > Thanks Song for your suggestion.
> > > >
> > > > On Mon, Jan 24, 2022 at 11:08 PM Song Liu <song@kernel.org> wrote:
> > > > >
> > > > > On Mon, Jan 24, 2022 at 2:43 PM Hao Luo <haoluo@google.com> wrote:
> > > > > >
> > > > > > Dear BPF experts,
> > > > > >
> > > > > > I'm working on collecting some kernel performance data using BPF
> > > > > > tracing prog. Our performance profiling team wants to associate the
> > > > > > data with user stack information. One of the requirements is to
> > > > > > reliably get BuildIDs from bpf_get_stackid() and other similar helpers
> > > > > > [1].
> > > > > >
> > > > > > As part of an early investigation, we found that there are a couple
> > > > > > issues that make bpf_get_stackid() much less reliable than we'd like
> > > > > > for our use:
> > > > > >
> > > > > > 1. The first page of many binaries (which contains the ELF headers and
> > > > > > thus the BuildID that we need) is often not in memory. The failure of
> > > > > > find_get_page() (called from build_id_parse()) is higher than we would
> > > > > > want.
> > > > >
> > > > > Our top use case of bpf_get_stack() is called from NMI, so there isn't
> > > > > much we can do. Maybe it is possible to improve it by changing the
> > > > > layout of the binary and the libraries? Specifically, if the text is
> > > > > also in the first page, it is likely to stay in memory?
> > > > >
> > > >
> > > > We are seeing 30-40% of stack frames not able to get build ids due to
> > > > this. This is a place where we could improve the reliability of build
> > > > id.
> > > >
> > > > There were a few proposals coming up when we found this issue. One of
> > > > them is to have userspace mlock the first page. This would be the
> > > > easiest fix, if it works. Another proposal from Ian Rogers (cc'ed) is
> > > > to embed build id in vma. This is an idea similar to [1], but it's
> > > > unclear (at least to me) where to store the string. I'm wondering if
> > > > we can introduce a sleepable version of bpf_get_stack() if it helps.
> > > > When a page is not present, sleepable bpf_get_stack() can bring in the
> > > > page.
> > >
> > > I guess it is possible to have different flavors of bpf_get_stack().
> > > However, I am not sure whether the actual use case could use sleepable
> > > BPF programs. Our user of bpf_get_stack() is a profiler. The BPF program
> > > which triggers a perf_event from NMI, where we really cannot sleep.
> > >
> > > If we have target use case that could sleep, sleepable bpf_get_stack() sounds
> > > reasonable to me.
> > >
> > > >
> > > > [1] https://lwn.net/Articles/867818/
> > > >
> > > > > > 2. When anonymous huge pages are used to hold some regions of process
> > > > > > text, build_id_parse() also fails to get a BuildID because
> > > > > > vma->vm_file is NULL.
> > > > >
> > > > > How did the text get in anonymous memory? I guess it is NOT from JIT?
> > > > > We had a hack to use transparent huge page for application text. The
> > > > > hack looks like:
> > > > >
> > > > > "At run time, the application creates an 8MB temporary buffer and the
> > > > > hot section of the executable memory is copied to it. The 8MB region in
> > > > > the executable memory is then converted to a huge page (by way of an
> > > > > mmap() to anonymous pages and an madvise() to create a huge page), the
> > > > > data is copied back to it, and it is made executable again using
> > > > > mprotect()."
> > > > >
> > > > > If your case is the same (or similar), it can probably be fixed with
> > > > > CONFIG_READ_ONLY_THP_FOR_FS, and modified user space.
> > > > >
> > > >
> > > > In our use cases, we have text mapped to huge pages that are not
> > > > backed by files. vma->vm_file could be null or points some fake file.
> > > > This causes challenges for us on getting build id for these code text.
> > >
> > > So, what is the ideal output in these cases? If there isn't a back file, we
> > > don't really have good build-id for it, right?
> > >
> >
> > Right, I don't have a solution for this case unfortunately. Probably
> > will just discard the failed frames. :(
> >
> > But in the case where the problem is the page not in mem, Song, do you
> > also see a similar high rate of build id parsing failure in your use
> > case (30 ~ 40% of frames)? If no, we may have done something wrong on
> > our side. If yes, is that a problem for your use case?
>
> The latest data I found (which is not too recent) is about 3 % missing symbols.
> I think there must be something different here.
>

Thanks Song! This is interesting. I'll go look at our user cases.

> Thanks,
> Song
