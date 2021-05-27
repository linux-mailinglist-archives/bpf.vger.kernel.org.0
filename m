Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA9393443
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbhE0Qqu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 12:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbhE0Qqu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 May 2021 12:46:50 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12371C061574;
        Thu, 27 May 2021 09:45:16 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id r7so1529671ybs.10;
        Thu, 27 May 2021 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H8I0YhPDFf+MyadspYUQDfJSC2X1SCenS3HyyI8nvIk=;
        b=YqX3KfJ3/yHm1wIjvBF6ZFqEqaEgiEL3tT02CUNBVcN5RZIXUazvOdlMFIw7gfARjo
         MAMcRIRZDb828mynA0+VyjcAjtpcAlChA1fqmPuVWIjeZuaQsT5O040vRTeLM/SmdUft
         RcYGzKd09i7sg6MPq8kAsrmjROkLCBR/T3tFRCT5LvuAIr9rQbCEex9pxiblDWWpwsRW
         Jv0Rt4TxWfrYvkZDz3Lcvfdz7pl359WzIdizIXqNyTAgZro3HQmXK9xB2nlw/Q+UD4Zq
         BS0l9YzMlK63tXhj+WecrenvXuu2rGKdIjldPvflCCCVetO8eCtgCyWReJSdqsAy8zWH
         5u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H8I0YhPDFf+MyadspYUQDfJSC2X1SCenS3HyyI8nvIk=;
        b=nD16E04LRrcQ9jfc9lvRZXD/NTUAgO4bNrHLLB30F7mUs2nBZBmpywD7JzFbdNkV1p
         RlGxaAFi1grubgO0VFk5XjbdV1DMCjMvEI3hBUeY1q53j/VQNGweXK/HvmZqzfflmh/f
         32JvltNPhF4xM7cS7QoweeHIfhkmiR4EyV4+fHKnF1m6SlnH+TmXFjoqLmZIVdyu3rTn
         aBxMR5RrlBgyfdVGnuhD6Sa5PJr3rmbxgP/+DkqaO2d1Zrzr5LIzJCQVJjpdZyzd4PgD
         uyGKEsO6vb2j9Jb2Qo+vzyNiNsZfcx5HvXX5WwQxPtGJyIQAxpDtWSztPbnpfPEDSL9C
         pirw==
X-Gm-Message-State: AOAM533Ad0+IXsk9rwGBgJs5Or0KHgKgGYSsnRHs+FH6X8xvkHJID5sZ
        v+W8+HuFvaWBjbf8V/4ososkvZ/9PSvKbmxgkMY=
X-Google-Smtp-Source: ABdhPJyIRl0nbH2dToU5gF4MkNn3lKl6n7OrH0oHAGbUI8anfJn6TRwbw45vJtJcAvHn0RAWf2ZFxBnkMeo8jVcB874=
X-Received: by 2002:a5b:286:: with SMTP id x6mr6432343ybl.347.1622133915338;
 Thu, 27 May 2021 09:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210524234222.278676-1-andrii@kernel.org> <YK+yzpPKVhNvm7/n@kernel.org>
 <YK+zkOOAUzFYsLBy@kernel.org> <20210527152758.GI8544@kitsune.suse.cz>
In-Reply-To: <20210527152758.GI8544@kitsune.suse.cz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 May 2021 09:45:03 -0700
Message-ID: <CAEf4BzZYYQCHuCooi_=+rtqW5Z3mE0Fq2dgr2eM-DLR5q17Xgg@mail.gmail.com>
Subject: Re: [PATCH dwarves] btf_encoder: fix and complete filtering out
 zero-sized per-CPU variables
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 27, 2021 at 8:37 AM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
>
> Hello,
>
> On Thu, May 27, 2021 at 11:58:24AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, May 27, 2021 at 11:55:10AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Mon, May 24, 2021 at 04:42:22PM -0700, Andrii Nakryiko escreveu:
> > > > btf_encoder is ignoring zero-sized per-CPU ELF symbols, but the sam=
e has to be
> > > > done for DWARF variables when matching them with ELF symbols. This =
is due to
> > > > zero-sized DWARF variables matching unrelated (non-zero-sized) vari=
able that
> > > > happens to be allocated at the exact same address, leading to a lot=
 of
> > > > confusion in BTF.
> > >
> > > > See [0] for when this causes big problems.
> > >
> > > >   [0] https://lore.kernel.org/bpf/CAEf4BzZ0-sihSL-UAm21JcaCCY92CqfN=
xycHRZYXcoj8OYb=3DwA@mail.gmail.com/
> >
> > I also added this:
> >
> > Reported-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> >
> > Michal, so you tested this patch and verified it fixed the problem? If
> > so please let me know so that I also add:
>
> This is the first time I see this patch.
>

I've posted a link to it in your thread [0].

  [0] https://lore.kernel.org/bpf/CAEf4BzZ9=3DaLVD7ytgCcSxcbOLqFNK-p1mj14Rv=
_TGnOyL3aO_g@mail.gmail.com/

> Given that linux-next does not build for me at the moment
> I don't think I will test it soon.

This patch applied to pahole master will fix linux-next build.

>
> Thanks
>
> Michal
>
> >
> > Tested-by: Michal Such=C3=A1nek <msuchanek@suse.de>
> >
> > Thanks,
> >
> > - Arnaldo
> >
> > > > +++ b/btf_encoder.c
> > > > @@ -550,6 +551,7 @@ int cu__encode_btf(struct cu *cu, int verbose, =
bool force,
> > > >
> > > >           /* addr has to be recorded before we follow spec */
> > > >           addr =3D var->ip.addr;
> > > > +         dwarf_name =3D variable__name(var, cu);
> > > >
> > > >           /* DWARF takes into account .data..percpu section offset
> > > >            * within its segment, which for vmlinux is 0, but for ke=
rnel
> > > > @@ -582,11 +584,9 @@ int cu__encode_btf(struct cu *cu, int verbose,=
 bool force,
> > > >            *  modules per-CPU data section has non-zero offset so a=
ll
> > > >            *  per-CPU symbols have non-zero values.
> > > >            */
> > > > -         if (var->ip.addr =3D=3D 0) {
> > > > -                 dwarf_name =3D variable__name(var, cu);
> > > > +         if (var->ip.addr =3D=3D 0)
> > > >                   if (!dwarf_name || strcmp(dwarf_name, name))
> > > >                           continue;
> > > > -         }
> > > >
> > > >           if (var->spec)
> > > >                   var =3D var->spec;
> > > > @@ -600,6 +600,13 @@ int cu__encode_btf(struct cu *cu, int verbose,=
 bool force,
> > >
> > > I just changed the above hunk to be:
> > >
> > > @@ -583,7 +585,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bo=
ol force,
> > >                  *  per-CPU symbols have non-zero values.
> > >                  */
> > >                 if (var->ip.addr =3D=3D 0) {
> > > -                       dwarf_name =3D variable__name(var, cu);
> > >                         if (!dwarf_name || strcmp(dwarf_name, name))
> > >                                 continue;
> > >                 }
> > >
> > >
> > > Which is shorter and keeps the {} around a multi line if block, ok?
> > >
> > > Thanks, applied!
> > >
> > > - Arnaldo
> >
> > --
> >
> > - Arnaldo
