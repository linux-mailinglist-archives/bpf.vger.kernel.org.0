Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCD2F3DC7
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 01:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436691AbhALVhS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 16:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436794AbhALUSe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 15:18:34 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70071C061786;
        Tue, 12 Jan 2021 12:17:54 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id 81so6735070ioc.13;
        Tue, 12 Jan 2021 12:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=IiemNVOJ6z4FCW3AKrYaQiz7YupFYzlzQ4KW6hI/nfE=;
        b=fcTuh0xO7QvZVSHJhAlDADaCOSUfYppyuk2R4GoleNoBZ5+7jtNj9Xwdg8SriF51hQ
         WbUNC4rrYiC2ODV37t67WwZSsYTxVZLILucm0yBLlNwNEGky05ejXnFYXHydK8hIf712
         4a5pr/gXyHBglBf8iViPeMlu5WUVP219MscMFOgGQg5Y2JWFpIRgH4L81R9uVZsR//Eu
         ufSr9jUxsxn/4ujEoHbYZgpyJhQewp7sKOqaZVlTF6usiDD/srDXCITQqNdqRn3Thp1M
         z9Gsi8yl1ju1T0JHrlHf/UnhwjMKXKGIijZQhrzNWIzLZAp/8ZA6wWGv7jjh8DaIyQUb
         +nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=IiemNVOJ6z4FCW3AKrYaQiz7YupFYzlzQ4KW6hI/nfE=;
        b=SGOxdNznY//9IRhPeNAdPRMbErtd72t0cw1Xn2ry4xUiGnyjmy4N9m7WPI+KfRapy/
         2hHP9P0qa8Hky9P8KShZHMzwPjWfGrxxmiDnGNb5rP+v4nwdvfy1fjCkF7IxOY/EIoko
         yzTUMMF1bXEO7AwLtKwIUPA3cNFIQU84i3y+w0dMTfyCkH9RUUstW5iXWOocSCG8G3tV
         IafuobVfFUSPcHlrZqaoiuk4ubUKwoKYRISx3AAzOj6taSIjiqV9GWt5HyXZfo6+I1UF
         JaUmjN//aZLWcZe4r5mFPrHTTUqPhlLnHFDlC/J7PDcmrMPx9MPZEAlBt62b7NYAWJsT
         DvVw==
X-Gm-Message-State: AOAM531V/sfS3Qpibo2ZiaotC4b6LlrX/TO9GZnWxWzyRS6Q6HSwE3be
        Cct/ziK5+cA1FgAwTzUurIg8OVEoioNCKSnVp9M=
X-Google-Smtp-Source: ABdhPJwnmhoHa6mqJpu1PhDiSepIzr/Vy3gEoIYMNd2KDWRl0o8yc5I/CeDooA7boJlOQ3ZRtk+eQOxlQCJX+kO7cdE=
X-Received: by 2002:a92:9e57:: with SMTP id q84mr818073ili.112.1610482673878;
 Tue, 12 Jan 2021 12:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <CAEf4BzZc0-csgmOP=eAvSP5uVYkKiYROAWtp8hwJcYA1awhVJw@mail.gmail.com>
 <20210112194724.GB1291051@krava>
In-Reply-To: <20210112194724.GB1291051@krava>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 12 Jan 2021 21:17:41 +0100
Message-ID: <CA+icZUVPNdTb1U5qGDz1Z05NWng+GEhrFtLgev-OVM_zLhzznQ@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 12, 2021 at 8:47 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 12, 2021 at 11:20:44AM -0800, Andrii Nakryiko wrote:
> > On Tue, Jan 12, 2021 at 10:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > When processing kernel image build by clang we can
> > > find some functions without the name, which causes
> > > pahole to segfault.
> > >
> > > Adding extra checks to make sure we always have
> > > function's name defined before using it.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  btf_encoder.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index 333973054b61..17f7a14f2ef0 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> > >
> > >         if (elf_sym__type(sym) != STT_FUNC)
> > >                 return 0;
> > > +       if (!elf_sym__name(sym, btfe->symtab))
> > > +               return 0;
> >
> > elf_sym__name() is called below again, so might be better to just use
> > local variable to store result?
>
> right, will add
>
> >
> > >
> > >         if (functions_cnt == functions_alloc) {
> > >                 functions_alloc = max(1000, functions_alloc * 3 / 2);
> > > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > >                 if (!has_arg_names(cu, &fn->proto))
> > >                         continue;
> > >                 if (functions_cnt) {
> > > -                       struct elf_function *func;
> > > +                       const char *name = function__name(fn, cu);
> > > +                       struct elf_function *func = NULL;
> > >
> > > -                       func = find_function(btfe, function__name(fn, cu));
> > > +                       if (name)
> > > +                               func = find_function(btfe, name);
> >
> > isn't this a more convoluted way of writing:
> >
> > name = function__name(fn, cu);
> > if (!name)
> >     continue;
> >
> > func = find_function(btfe, name);
> > if (!func || func->generated)
> >     continue
> >
> > ?
>
> convoluted is my middle name ;-) I'll change it
>

OK, a v2 will follow.

Thanks JCO.

- sed@ -

> thanks,
> jirka
>
> >
> > >                         if (!func || func->generated)
> > >                                 continue;
> > >                         func->generated = true;
> > > --
> > > 2.26.2
> > >
> >
>
