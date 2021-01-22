Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5242F2FFB95
	for <lists+bpf@lfdr.de>; Fri, 22 Jan 2021 05:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbhAVEMM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 23:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbhAVEMJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 23:12:09 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E198FC06174A;
        Thu, 21 Jan 2021 20:11:28 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id y128so4223232ybf.10;
        Thu, 21 Jan 2021 20:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJG35WMSmqM+VRxKuEj2T/T+ieSv4pjTz3j8WfKGbMQ=;
        b=Qa4E+8eQU5zlBmCfSRyDXhgNhUFA9i9u/rLglpj7xHaJQb461/P/v4ZWoO5FMB/2h5
         1I30GC1f9YZ/D+revZjOMbQF0HpRdnTC+MbenxUtXkkqI1U+FHmwXDvnXXDx0pi6ReaP
         bZOMiPwHNRRnTE6N3QykGIBmeTGAYKSEFNjq52N7LzQlWwCHDSmnieqKAbhYLjlHPeOJ
         2Ilinv2ZnnpplvjV7fUUBHnwTvNYxISc3dCIHnuFklEML7HS4Bsgv8wAttqYTASvNMLS
         9e79QgtF76YTjghtoA6VJgp15Ew+SP3dz/TDwNKOryMYPEcEBEmDtXT+7byXIgunMJ0t
         nw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJG35WMSmqM+VRxKuEj2T/T+ieSv4pjTz3j8WfKGbMQ=;
        b=gpg7rCko7WzmJJH1vE75d4auO/ZHZMKAyP/p+3qDosOKaE4dp+O3/+3bsWsGxY1R7j
         vEsm6v8jbJz37bkEQ/h6C2tCNVVhWnyE2VTq0z3xwx/iA73bd6Ob9ArfQex/xAOfrEV5
         VNYY1/DpDIZiSxzi10K7+JrqyBSBAOYz3EzOwG/sKe8k8nBMBwo2fjRYz6mA4a8+DjF2
         2nAWUpkc4BDqRrBXHYBMH1Yt/dIRLXC4M3yvumZ15aB05NnVzWF+yK5iFHwHLe02RRET
         J1xJq67Isaq+e4ziITNnHZyXZDw+kyAIMiyUDdV04YYXZEsfiBCU1FLHC+/f9Dxnv6fr
         exzA==
X-Gm-Message-State: AOAM5329X55dz1dmCOd8CbzH2cONdMbL1fFmiC7/26krZppsXvXtEUUz
        bk3brmIcXiZNvwc/H0dtOKaeG+7pPG7t/pg1pEWS/f53NzHL5Z7P
X-Google-Smtp-Source: ABdhPJx4JenJb1YOPYD/A6e7/eucDkBwXNgu6bOnIl5xnsqCfhXsvUUMv63YrpQ8fdFeAbLTvWIieNFce7AQ3OysFTk=
X-Received: by 2002:a25:f40e:: with SMTP id q14mr3772478ybd.230.1611288688074;
 Thu, 21 Jan 2021 20:11:28 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
 <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com> <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
In-Reply-To: <CA+icZUW6g9=sMD3hj5g+ZXOwE_DxfxO3SX2Tb-bFTiWnQLb_EA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Jan 2021 20:11:17 -0800
Message-ID: <CAEf4BzZ-uU3vkMA1RPt1f2HbgaHoenTxeVadyxuLuFGwN9ntyw@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Tom Stellard <tstellar@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 21, 2021 at 6:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Jan 21, 2021 at 9:53 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jan 21, 2021 at 8:09 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Thu, Jan 21, 2021 at 2:38 PM Arnaldo Carvalho de Melo
> > > <arnaldo.melo@gmail.com> wrote:
> > > >
> > > > Em Tue, Jan 12, 2021 at 04:27:59PM -0800, Tom Stellard escreveu:
> > > > > On 1/12/21 10:40 AM, Jiri Olsa wrote:
> > > > > > When processing kernel image build by clang we can
> > > > > > find some functions without the name, which causes
> > > > > > pahole to segfault.
> > > > > >
> > > > > > Adding extra checks to make sure we always have
> > > > > > function's name defined before using it.
> > > > > >
> > > > >
> > > > > I backported this patch to pahole 1.19, and I can confirm it fixes the
> > > > > segfault for me.
> > > >
> > > > I'm applying v2 for this patch and based on your above statement I'm
> > > > adding a:
> > > >
> > > > Tested-by: Tom Stellard <tstellar@redhat.com>
> > > >
> > > > Ok?
> > > >
> > > > Who originally reported this?
> > > >
> > >
> > > The origin was AFAICS the thread where I asked initially [1].
> > >
> > > Tom reported in the same thread in [2] that pahole segfaults.
> > >
> > > Later in the thread Jiri offered a draft of this patch after doing some tests.
> > >
> > > I have tested all diffs and v1 and v2 of Jiri's patch.
> > > ( Anyway, latest pahole ToT plus Jiri's patch did not solve my origin problem. )
> >
> > Your original problem was with DWARF5 or DWARF4? I think you mentioned
> > both at some point, but I remember I couldn't repro DWARF4 problems.
> > If you still have problems, can you start a new thread with steps to
> > repro (including Kconfig, tooling versions, etc). And one for each
> > problem, no all at the same time, please. I honestly lost track of
> > what's still not working among those multiple intertwined email
> > threads, sorry about that.
> >
>
> I love people saying "I have a (one) problem." :-).
>
> The origin was Debian kernel-team enabled BTF-debuginfo Kconfig.
>
> My main focus is to be as close to Debian's kernel-config and if this
> works well with (experimental) Linux DWARF v5 support I am a happy
> guy.

I don't know what kernel config Debian is using, that's why I'm asking
for kernel config that does cause the problem. Because the one I'm
using doesn't. But this problem can be a result of a lot of things,
specific compiler and its version, specific kernel config, who knows
what else.

>
> Do you want Nick's DWARF v5 patch-series as a base?

Arnaldo was going to figure out the DWARF v5 problem, so I'm leaving
it up to him. I'm curious about DWARF v4 problems because no one yet
reported that previously.

> Thinking of DWARF-v4?
> Use Nick's patchset or DWARF-v4 what is in Linux upstream means Linux
> v5.11-rc4+?
> What Git tree to use - Linus or one of your BPF/BTF folks?

I checked both v5.11-rc4 and the latest bpf-next with
CONFIG_DEBUG_INFO_DWARF4=y and CONFIG_DEBUG_INFO_BTF=y. I get no
warnings, everything works.

>
> What version of pahole (latest Git) etc.?

Latest pahole built from Git, yes.

But let's not do it in a backwards manner with me telling you what
works (my environment, my config), rather you telling us what
*doesn't* work (your config, your environment), so that we can try to
reproduce.

>
> - Sedat -
>
> > >
> > > So up to you Arnaldo for the credits.
> > >
> > > - Sedat -
> > >
> > > [1] https://marc.info/?t=161036949500004&r=1&w=2
> > > [2] https://marc.info/?t=161036949500004&r=1&w=2
> > >
> > > > - Arnaldo
> > > >
> > > > > -Tom
> > > > >
> > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > ---
> > > > > >   btf_encoder.c | 8 ++++++--
> > > > > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > > > index 333973054b61..17f7a14f2ef0 100644
> > > > > > --- a/btf_encoder.c
> > > > > > +++ b/btf_encoder.c
> > > > > > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> > > > > >     if (elf_sym__type(sym) != STT_FUNC)
> > > > > >             return 0;
> > > > > > +   if (!elf_sym__name(sym, btfe->symtab))
> > > > > > +           return 0;
> > > > > >     if (functions_cnt == functions_alloc) {
> > > > > >             functions_alloc = max(1000, functions_alloc * 3 / 2);
> > > > > > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > > > >             if (!has_arg_names(cu, &fn->proto))
> > > > > >                     continue;
> > > > > >             if (functions_cnt) {
> > > > > > -                   struct elf_function *func;
> > > > > > +                   const char *name = function__name(fn, cu);
> > > > > > +                   struct elf_function *func = NULL;
> > > > > > -                   func = find_function(btfe, function__name(fn, cu));
> > > > > > +                   if (name)
> > > > > > +                           func = find_function(btfe, name);
> > > > > >                     if (!func || func->generated)
> > > > > >                             continue;
> > > > > >                     func->generated = true;
> > > > > >
> > > > >
> > > >
> > > > --
> > > >
> > > > - Arnaldo
