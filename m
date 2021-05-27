Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B46393440
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 18:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhE0Qo6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 12:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbhE0Qo5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 12:44:57 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E59C061574;
        Thu, 27 May 2021 09:43:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r7so1521383ybs.10;
        Thu, 27 May 2021 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/cl0HGCAjx/ymKGvQuwe9IGoh9Ly0AjNo9p8OoIdS8=;
        b=r9eZddWlEpSCHHNOByMpd6uvEd4wHxW9qUb8AWlJ+dB8Y/5DMb86sbeEZp2+SA76++
         QiNKZHx3q5TAfgzAv0Mi3l9cO6PRR/DhkrP3yhv/HyfyAs1IdrkDgNIWjMkfPc1NEKe5
         yjUronjx3FpUxH540K7ClEl0CEz17OJm528WL/MXotqjjzdOIZa4TkBivnr1Oi49paMT
         bAkNoONvVDE+8GTUzkpEnzWPrPDQ8NSpl41ZUVduBbktsgMOTGqMIUXO56n/RbgnMhA1
         I2zRdRcS8Kjw5Q+PEf+OijMVN+Y0iGcPKlYlKpwpAbLa7LQshcHUoyurBfM7WEGE1oMF
         1ALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/cl0HGCAjx/ymKGvQuwe9IGoh9Ly0AjNo9p8OoIdS8=;
        b=d/e8+pOFXPdlEUkqZkls87tVigYPZ+4QLRcvUa8Ef56C4ECOQgRPSFrG3oadgzqOH2
         Ne9UZt8vHKckMVpW1RpheSsx/gTAX2YjJhQ2eSqlCL/yI/SpPwE4f5ZwEZfkB1rtFHgV
         /e9it8UP6cxA4oUcMr7SF85ThQbA3Hb57gtnOHKbaSj+2YSMnkvfB58wuK+KpCuIwaos
         NlHr31X6Ebev0cCKlgjjMhAGycggjOKb3x82EkbaY3lh6kSr79oCmEJj/5mgdaLCn2kG
         ZbPIYMNW7KfNuC6IKv9JMDyKBh+ab2HnwMX5WFRdTwwLSSptio1d39E9EDXh7z6OXzpC
         wPKw==
X-Gm-Message-State: AOAM533R+S5oZiL/DjUQaL5B72E7M7e/fajt4FPc+iCjA0C3EMBa6pvT
        l6uB1Y90uCNfxWfQmcUJoAisOvQ1Cwrq98CsyzE=
X-Google-Smtp-Source: ABdhPJwTtrYabaw7836H63f9PQNo9M5rFYzA0vmT8+zrGrz2xtG5R6zE2ihdLcHUgxLxlyODgy8DEN+cDdYhvSmG3Ng=
X-Received: by 2002:a25:1455:: with SMTP id 82mr6077598ybu.403.1622133802399;
 Thu, 27 May 2021 09:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210524234222.278676-1-andrii@kernel.org> <YK+yzpPKVhNvm7/n@kernel.org>
In-Reply-To: <YK+yzpPKVhNvm7/n@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 09:43:11 -0700
Message-ID: <CAEf4BzaSa+VGKRzVD9hWc1Zg8O0D3UokYY9j2FZtERa0gAnnYA@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: fix and complete filtering out
 zero-sized per-CPU variables
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 7:55 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, May 24, 2021 at 04:42:22PM -0700, Andrii Nakryiko escreveu:
> > btf_encoder is ignoring zero-sized per-CPU ELF symbols, but the same has to be
> > done for DWARF variables when matching them with ELF symbols. This is due to
> > zero-sized DWARF variables matching unrelated (non-zero-sized) variable that
> > happens to be allocated at the exact same address, leading to a lot of
> > confusion in BTF.
>
> > See [0] for when this causes big problems.
>
> >   [0] https://lore.kernel.org/bpf/CAEf4BzZ0-sihSL-UAm21JcaCCY92CqfNxycHRZYXcoj8OYb=wA@mail.gmail.com/
>
> > +++ b/btf_encoder.c
> > @@ -550,6 +551,7 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >
> >               /* addr has to be recorded before we follow spec */
> >               addr = var->ip.addr;
> > +             dwarf_name = variable__name(var, cu);
> >
> >               /* DWARF takes into account .data..percpu section offset
> >                * within its segment, which for vmlinux is 0, but for kernel
> > @@ -582,11 +584,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
> >                *  modules per-CPU data section has non-zero offset so all
> >                *  per-CPU symbols have non-zero values.
> >                */
> > -             if (var->ip.addr == 0) {
> > -                     dwarf_name = variable__name(var, cu);
> > +             if (var->ip.addr == 0)
> >                       if (!dwarf_name || strcmp(dwarf_name, name))
> >                               continue;
> > -             }
> >
> >               if (var->spec)
> >                       var = var->spec;
> > @@ -600,6 +600,13 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>
> I just changed the above hunk to be:
>
> @@ -583,7 +585,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>                  *  per-CPU symbols have non-zero values.
>                  */
>                 if (var->ip.addr == 0) {
> -                       dwarf_name = variable__name(var, cu);
>                         if (!dwarf_name || strcmp(dwarf_name, name))
>                                 continue;
>                 }
>
>
> Which is shorter and keeps the {} around a multi line if block, ok?

yeah, no problem

>
> Thanks, applied!

Thanks!
>
> - Arnaldo
