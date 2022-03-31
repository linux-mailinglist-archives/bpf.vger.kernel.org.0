Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA284EDFA8
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 19:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiCaRbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 13:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiCaRbs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 13:31:48 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2141275F4
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 10:30:00 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id g21so257290iom.13
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzRIGsDimf8yBwTV7qM3usvImmlEpLJ0EmnIcC6q54o=;
        b=ObqGtEYjLtAH9tBjf2EMyaaqF/aWNPgOBbixfGQbJiPmC2NxCRa3PVfwBg9IV4i2Cz
         8EJLe+LdFHEY4a1rA3EUqxyKCO7FLbX+akm9BoWjNc1zCLLlwgamOne2DJXaq56G3YTD
         Eoa7tB9dMSfoTz8OaLqfL5GG7eJYf2xanIUIa+oiwnClYejFkMVEyhLFhAQY9OJovOdk
         gLMgDShknfiGu1vQipN2b0792fJEe/XJjaUpvH2rK9zx8emmjq85r9s3QdzwZU+Lb24a
         m5crxpRxJKR8YBuKIU3z3FJ89+xYzQDvJgjBqaxvoR5RGvbruzeSVoxaxWpTJsrne18j
         mHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzRIGsDimf8yBwTV7qM3usvImmlEpLJ0EmnIcC6q54o=;
        b=t9urvWOEDFaJQi18FrwmZrDNuby5Zqhd4+5Q+la4o9Rw/LhBkxIOqJuNbF8bNoNdxW
         rG/AYkvF1sXwkuBgOaoR0RPK2JRr4tZfS43bvl8IE5LcTGx/IfwtK25dOqAxQPAOn9R0
         GajCX0zWFAmxVYv31iPEvLkrXVCanLoIAhEPfwU4d24QnFxKs12PyCeOuvvIpU2ojHIq
         aTkur1Bhvn8gNG8Gzz2ICpnbvwjDmM65lRTB2szAi2RDmbxsqxs5nj6YDvag6LpvZAM8
         5pG2G2KWaytX+Y9sWfJAn7YvfKzxJo9NOEYUBBt6yevlrjCdAcGoSNSbC7tpS6twSW/a
         nUOg==
X-Gm-Message-State: AOAM533JylFTyPvPb2S2HisFj3rReGePE7/uErnZxy1M8S+jweMyup+K
        hsgHPEqtzYw2tnisSzz+Or3uRtoHvX4y3/BXOEU=
X-Google-Smtp-Source: ABdhPJzwrTwTmoM3fbUaQF59rQngH6iRtGbL3Gf1MGsTA9EkZ4NPDt1u3+7a/7YSYFpW4CJUU4klkEqfhI1c2tiSNGs=
X-Received: by 2002:a05:6638:2105:b0:323:68db:2e4e with SMTP id
 n5-20020a056638210500b0032368db2e4emr3723799jaj.234.1648747799538; Thu, 31
 Mar 2022 10:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220326144320.560939-1-hengqi.chen@gmail.com>
 <CAEf4BzZzLy2DjJ4pk_wx8KCsErfZE2-eG6pXO+5WnnRHxcfpiA@mail.gmail.com>
 <5d5a7f05-6c96-49db-6c3f-ae3ca713059a@gmail.com> <CAEf4BzYBzOEDgE+KH9jgUu89=GT7GeMNXx3Rwek4La5wKZZ-AQ@mail.gmail.com>
 <9c3aece7-84d1-9fd6-76f0-acb2dd9597a9@gmail.com>
In-Reply-To: <9c3aece7-84d1-9fd6-76f0-acb2dd9597a9@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 31 Mar 2022 10:29:48 -0700
Message-ID: <CAEf4Bzb=v12ajT5xwwSGwjJu25JX0hWh1WzAxQkBW9+_B-Ynzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow kprobe attach using legacy debugfs interface
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 29, 2022 at 8:03 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
>
>
> On 2022/3/30 10:50 AM, Andrii Nakryiko wrote:
> > On Tue, Mar 29, 2022 at 7:30 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>
> >> Hello, Andrii
> >>
> >> On 2022/3/30 7:18 AM, Andrii Nakryiko wrote:
> >>> On Sat, Mar 26, 2022 at 7:43 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
> >>>>
> >>>> On some old kernels, kprobe auto-attach may fail when attach to symbols
> >>>> like udp_send_skb.isra.52 . This is because the kernel has kprobe PMU
> >>>> but don't allow attach to a symbol with '.' ([0]). Add a new option to
> >>>> bpf_kprobe_opts to allow using the legacy kprobe attach directly.
> >>>> This way, users can use bpf_program__attach_kprobe_opts in a dedicated
> >>>> custom sec handler to handle such case.
> >>>>
> >>>>   [0]: https://github.com/torvalds/linux/blob/v4.18/kernel/trace/trace_kprobe.c#L340-L343
> >>>>
> >>>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> >>>> ---
> >>>
> >>> It's sad, but it makes sense. But, let's have a selftests that
> >>> validates uses legacy option explicitly (e.g., in
> >>> prog_tests/attach_probe.c). Also, let's fix this limitation in the
> >>
> >> OK, will add a selftest to exercise the new option.
> >>
> >>> kernel? It makes no sense to limit attaching to a proper kallsym
> >>> symbol.
> >>
> >> This limitation is lifted in newer kernel. Kernel v5.4 don't have this issue.
> >
> > Oh, ok. So how about another plan of attack then: if kprobe target
> > function has '.' *and* we are on the kernel that doesn't support that,
> > switch to legacy kprobe automatically? No need for a new option,
> > libbpf handles this transparently.
> >
>
> That's better, and also eliminate the need for custom SEC() handler.
>
> > Still need a test for kprobe with '.' in it, though not sure how
> > reliable that will be... We can use kallsyms cache to check if
> > expected xxx.isra.0 (or whatever) is present, and if not - skip
> > subtest?
> >
>
> Not sure how to do that. Even if such symbol exists, how to reliably
> trigger it is another problem.

In addition to what Alan proposed, which relies on compiler to do this
whole isra thingy. I wonder if we can just create an alias symbol with
dots in its name? I haven't tried, but would be curious to see if that
works in bpf_testmod.

>
> >>
> >>>
> >>>>  tools/lib/bpf/libbpf.c | 9 ++++++++-
> >>>>  tools/lib/bpf/libbpf.h | 4 +++-
> >>>>  2 files changed, 11 insertions(+), 2 deletions(-)
> >>>>
> >>>
> >>> [...]
> >>
> >> --
> >> Hengqi
