Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966822FF68C
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 21:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbhAUU4Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 15:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbhAUUzs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 15:55:48 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C32FC0698C0;
        Thu, 21 Jan 2021 12:53:48 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id z1so3387285ybr.4;
        Thu, 21 Jan 2021 12:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Nh9i0Rn2q2vM47aLvZ+VSaju+rMHG+d3GINmjhrKpU=;
        b=sVOeg3A3D3RbLBXWWQ9qSYhy91SASnu0+4QfdNhpqo2lKIBDNM5AuUzHyue2ExtCZF
         ytQ0iJMRnzsZ0fye3xflgRjMqGfZDUZ4PqF2uanO+xqH++3ePbU4FvXt4ljoQiKRNWds
         7RmerZu+HlY/JNGRP9QCr4DIyKrb2l98bthlsMpfS4XvulIJTX9AvIrdxOmW+rdroPUo
         hmjZ2Zpb1M1I9bP0fdceY+s23avVbDntAG3NudhGeylIf0HYls2fZfeThKH+rLAzOaMJ
         nlnD6BNi29r4eScKy3CV8rrLEurfsyHCzuE09fi4n7hNwJVs1dKPwisuIlbNaiJmH7Iv
         r7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Nh9i0Rn2q2vM47aLvZ+VSaju+rMHG+d3GINmjhrKpU=;
        b=CN1/vgjATXPPe+dcJXCUvADZK9i+lvh37g3FlCzd9eYOFJAUs7qR1rwrbXTVwKPppT
         nNNR/wTdRMc7oYPbqsN0XGMbM+r7h087ubiXEwLsxZqUfvz9H4jVByUHXCIHt042l7KE
         HScmzMiMk+EQsZK6sYihpRPsa2p/sdJQr+HAeg+v4ZUH/JQvQ65wyW8t1KHX4cKfNGWK
         lu6KZAJCGoDlW1/wc8XBPuw58MoB0gyH9w9CEvrZWShOjyIzlWi8sYWnjxev6xBHf6v3
         kvxsYO7GNbqBupfFcAXk8zQZO1zHxcI26r+UesZjbrALWm0PZMvzQkkx86Bh4zga0Qfp
         +JFA==
X-Gm-Message-State: AOAM5321t0ebwvbSHysByn5Pmp5Q3PPn4yCHKSUui9XlT/wlDSPUS+OB
        lv6Xcb4BvNRGVc1lXY4zNnXWnfCIqA6vogBkqtQ=
X-Google-Smtp-Source: ABdhPJxZKFbQtvIz8521cbPOPBiVn0VBuBUsuoaUH3IJcKihXdakxLSVKeB5ZNBzzA4TQAqCclAfxTmvpVxH2uHQ1lI=
X-Received: by 2002:a25:b195:: with SMTP id h21mr1706483ybj.347.1611262427414;
 Thu, 21 Jan 2021 12:53:47 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org> <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
In-Reply-To: <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Jan 2021 12:53:36 -0800
Message-ID: <CAEf4BzaVAp=W47KmMsfpj_wuJR-Gvmav=tdKdoHKAC3AW-976w@mail.gmail.com>
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

On Thu, Jan 21, 2021 at 8:09 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Jan 21, 2021 at 2:38 PM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Tue, Jan 12, 2021 at 04:27:59PM -0800, Tom Stellard escreveu:
> > > On 1/12/21 10:40 AM, Jiri Olsa wrote:
> > > > When processing kernel image build by clang we can
> > > > find some functions without the name, which causes
> > > > pahole to segfault.
> > > >
> > > > Adding extra checks to make sure we always have
> > > > function's name defined before using it.
> > > >
> > >
> > > I backported this patch to pahole 1.19, and I can confirm it fixes the
> > > segfault for me.
> >
> > I'm applying v2 for this patch and based on your above statement I'm
> > adding a:
> >
> > Tested-by: Tom Stellard <tstellar@redhat.com>
> >
> > Ok?
> >
> > Who originally reported this?
> >
>
> The origin was AFAICS the thread where I asked initially [1].
>
> Tom reported in the same thread in [2] that pahole segfaults.
>
> Later in the thread Jiri offered a draft of this patch after doing some tests.
>
> I have tested all diffs and v1 and v2 of Jiri's patch.
> ( Anyway, latest pahole ToT plus Jiri's patch did not solve my origin problem. )

Your original problem was with DWARF5 or DWARF4? I think you mentioned
both at some point, but I remember I couldn't repro DWARF4 problems.
If you still have problems, can you start a new thread with steps to
repro (including Kconfig, tooling versions, etc). And one for each
problem, no all at the same time, please. I honestly lost track of
what's still not working among those multiple intertwined email
threads, sorry about that.

>
> So up to you Arnaldo for the credits.
>
> - Sedat -
>
> [1] https://marc.info/?t=161036949500004&r=1&w=2
> [2] https://marc.info/?t=161036949500004&r=1&w=2
>
> > - Arnaldo
> >
> > > -Tom
> > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >   btf_encoder.c | 8 ++++++--
> > > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > > index 333973054b61..17f7a14f2ef0 100644
> > > > --- a/btf_encoder.c
> > > > +++ b/btf_encoder.c
> > > > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> > > >     if (elf_sym__type(sym) != STT_FUNC)
> > > >             return 0;
> > > > +   if (!elf_sym__name(sym, btfe->symtab))
> > > > +           return 0;
> > > >     if (functions_cnt == functions_alloc) {
> > > >             functions_alloc = max(1000, functions_alloc * 3 / 2);
> > > > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > > >             if (!has_arg_names(cu, &fn->proto))
> > > >                     continue;
> > > >             if (functions_cnt) {
> > > > -                   struct elf_function *func;
> > > > +                   const char *name = function__name(fn, cu);
> > > > +                   struct elf_function *func = NULL;
> > > > -                   func = find_function(btfe, function__name(fn, cu));
> > > > +                   if (name)
> > > > +                           func = find_function(btfe, name);
> > > >                     if (!func || func->generated)
> > > >                             continue;
> > > >                     func->generated = true;
> > > >
> > >
> >
> > --
> >
> > - Arnaldo
