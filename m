Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD602FEFC7
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 17:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbhAUQHY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 11:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbhAUQHS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 11:07:18 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58186C06174A;
        Thu, 21 Jan 2021 08:06:38 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e22so4981380iog.6;
        Thu, 21 Jan 2021 08:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=oH4AxyJmru8fJ310AloQYqsEc5jq1raAzqRJR56h2F0=;
        b=M5qM7gMGYwOY0ixSUNl557DeZVRSizN3nFJzNd6qQHqd9haJy83Hq8ZF1TTapgpnbC
         RQ4CTsKHKT0sbBmPYzVGNQ4k+QCJdmMYhoKqxwZpVM1NnD4JUKfiR1QVtar1qAzbrUSd
         rB80ITrDDoDCUdrp+S6ErrMh2NPLpeqW5Ss7uTvNEwLLGxCqzm/y2oAUyvp1TsvlBJnQ
         wAqcCJaXZhiu33D2FoCgZxDJ7jQMhPLEAjoAxG+vjDu9NE7Ol2gcgpVyDbqQKSXBiatl
         a7jF8+AeLeXTBcNbXXOlu0NwcZaKIY20B0xTrogjr8BXB/BjoQuUMVCVrpv3/L8q1j4A
         BVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=oH4AxyJmru8fJ310AloQYqsEc5jq1raAzqRJR56h2F0=;
        b=dqIsZJo/4AiIXj2wbeysi3pg2vCdU0sI92069QmVxJvmtJxo0ChhYwdsVMm9SecHff
         sU82n+Uf4KzeF+KVcuGravjrKCAq8KsFszDh3SxgxI7TWN4hFJE+PJt6ClSyZSICPS70
         zF2TlR6UeHboICJhMoaWhZkuXXIEv6Yue0Yhjqwsxk/UXas5h+NRJVntYAAmp6D+uxvc
         GlUPwH9WinBkXas8sfPNvsxhw/pdcfVahMsQ7IhljNe4uKz4n+n8eODA2M0TTmNF88fo
         bYeDGVZybv/juC/CjSSS8aSilDBcR2rLV8K3QBht/JyiEh65oZI7rVulDNUKdILGtPlS
         TT9Q==
X-Gm-Message-State: AOAM5321VxzFDpx2ZpWo/EEij+jBB56+8n1maf3BG2qF+IaVkPqovXj1
        3KDantNAncFsowxlwsOcvg6XEkYRXTPuFWgQWKI=
X-Google-Smtp-Source: ABdhPJyIMxYkfMlIQFURMKaPFbYBRMpNMkD3sea94NhdAm7CLw85p0sq949X1PhX/Cdff3eu62mWGNcLj1rEm/bwsIM=
X-Received: by 2002:a92:c5c8:: with SMTP id s8mr391557ilt.186.1611245197587;
 Thu, 21 Jan 2021 08:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20210112184004.1302879-1-jolsa@kernel.org> <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org>
In-Reply-To: <20210121133825.GB12699@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 21 Jan 2021 17:06:25 +0100
Message-ID: <CA+icZUVsdcTEJjwpB7=05W5-+roKf66qTwP+M6QJKTnuP6TOVQ@mail.gmail.com>
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Tom Stellard <tstellar@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 21, 2021 at 2:38 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Tue, Jan 12, 2021 at 04:27:59PM -0800, Tom Stellard escreveu:
> > On 1/12/21 10:40 AM, Jiri Olsa wrote:
> > > When processing kernel image build by clang we can
> > > find some functions without the name, which causes
> > > pahole to segfault.
> > >
> > > Adding extra checks to make sure we always have
> > > function's name defined before using it.
> > >
> >
> > I backported this patch to pahole 1.19, and I can confirm it fixes the
> > segfault for me.
>
> I'm applying v2 for this patch and based on your above statement I'm
> adding a:
>
> Tested-by: Tom Stellard <tstellar@redhat.com>
>
> Ok?
>
> Who originally reported this?
>

The origin was AFAICS the thread where I asked initially [1].

Tom reported in the same thread in [2] that pahole segfaults.

Later in the thread Jiri offered a draft of this patch after doing some tests.

I have tested all diffs and v1 and v2 of Jiri's patch.
( Anyway, latest pahole ToT plus Jiri's patch did not solve my origin problem. )

So up to you Arnaldo for the credits.

- Sedat -

[1] https://marc.info/?t=161036949500004&r=1&w=2
[2] https://marc.info/?t=161036949500004&r=1&w=2

> - Arnaldo
>
> > -Tom
> >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >   btf_encoder.c | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/btf_encoder.c b/btf_encoder.c
> > > index 333973054b61..17f7a14f2ef0 100644
> > > --- a/btf_encoder.c
> > > +++ b/btf_encoder.c
> > > @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
> > >     if (elf_sym__type(sym) != STT_FUNC)
> > >             return 0;
> > > +   if (!elf_sym__name(sym, btfe->symtab))
> > > +           return 0;
> > >     if (functions_cnt == functions_alloc) {
> > >             functions_alloc = max(1000, functions_alloc * 3 / 2);
> > > @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> > >             if (!has_arg_names(cu, &fn->proto))
> > >                     continue;
> > >             if (functions_cnt) {
> > > -                   struct elf_function *func;
> > > +                   const char *name = function__name(fn, cu);
> > > +                   struct elf_function *func = NULL;
> > > -                   func = find_function(btfe, function__name(fn, cu));
> > > +                   if (name)
> > > +                           func = find_function(btfe, name);
> > >                     if (!func || func->generated)
> > >                             continue;
> > >                     func->generated = true;
> > >
> >
>
> --
>
> - Arnaldo
