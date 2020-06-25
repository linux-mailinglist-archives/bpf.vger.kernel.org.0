Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F157820A36B
	for <lists+bpf@lfdr.de>; Thu, 25 Jun 2020 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391050AbgFYQ4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jun 2020 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390448AbgFYQ4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jun 2020 12:56:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A49C08C5C1;
        Thu, 25 Jun 2020 09:56:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so5994644qkg.5;
        Thu, 25 Jun 2020 09:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XntfPp9x/dThHar2Ksm7UlU1IVcMyZZWD0IkWLmVdDk=;
        b=sTR+L0hFppu63nZVax+B8qs+aKnoY7CgGWXmzgmwl2m4LTOcGnnjQ3w91Jen0+i97c
         ZsuXfm1rQ2jCuwDR3wIr36LP7q3g+pXsiaSPZEAfI9x/g4vPVJ09z3+bqx5U62pgDuDe
         1hL8ocdrao3738o+iDRfAZztWOHuSeCNBbfFyyD6qjODmgejN3O5vDFva8FBPlfBxqYO
         2/SYvGisUca/1KdGBP41l9V9YX/9GI4nYqP+Cfs/kslZogn03HuXovIZMDklWvMRpCtz
         lfIxWy02tklUXGUkwxbJAfnaB2dDDyIQtSwiATo/7RGlm9b605RywoBkYlk6M7El7u8N
         QeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XntfPp9x/dThHar2Ksm7UlU1IVcMyZZWD0IkWLmVdDk=;
        b=GfR92i4jttQMs+XLZ/+Y/TvawxMZ4hyFPXsp3aAesMIhSK0RXo5MBcqxyZoxgZ4IbM
         VLhABjfOL1EvDVcz8h09vhTYIWPan2A5HZjXlk7DWOVAWsg0zxX1kJhN8YVeHLgoHC9f
         pLOvrAAoxzvhzn2qQso4Cu+lKBzqIu8Y4yW39b2OlSIuDi3YPgU/BvmWy//i1SCpCNY6
         g67/hisBxtFy2wI4nNB6hX201hE17C0eIOyOGWl+wC/6OikEl9ROXmpT+6vIGIKCa1Fv
         KUDNpcOYdfScqlaOcZSrfwCNv3NTRPOeh/bkimUyAYaK/Z3dLnlEAd7H2KLHpOToZ9BV
         UHkg==
X-Gm-Message-State: AOAM533hF9nCBt3fqU31ZnHP5fmho1BAf69GxCkrfw9cLNKOOcaitny9
        8zNR6bD3IUWqk7zx5H+lQl40fpI/UL0QZNy/OeI=
X-Google-Smtp-Source: ABdhPJxKOpzNOrG8XLFP+i8hISrALbQfOnebx35dTrL6IqS68EUAj+Ork5fBOXVsBxwLHWWt/fX/6IREG4G0WtN21yg=
X-Received: by 2002:a37:d0b:: with SMTP id 11mr33038594qkn.449.1593104183213;
 Thu, 25 Jun 2020 09:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <CAEf4BzbSc-wykq1_62CQwtszO+76rkudz_B=GkzE6ZheMUAusw@mail.gmail.com> <CACAyw98ojwGjQm+Xk+_-B8Ah-hEt-Tgv_LQ1BdH4yBLYgVwpiA@mail.gmail.com>
In-Reply-To: <CACAyw98ojwGjQm+Xk+_-B8Ah-hEt-Tgv_LQ1BdH4yBLYgVwpiA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Jun 2020 09:56:11 -0700
Message-ID: <CAEf4BzYjge6fijFadwuuHf-vr2VUqneT5b0k-GgQSkLMTj=UAA@mail.gmail.com>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 25, 2020 at 2:25 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Wed, 24 Jun 2020 at 18:41, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 4:07 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> > >
> > > Hi,
> > >
> > > If pahole -J is used on an ELF that has BTF info from clang, it
> > > produces an invalid
> > > output. This is because pahole rewrites the .BTF section (which
> > > includes a new string
> > > table) but it doesn't touch .BTF.ext at all.
> >
> > Why do you run `pahole -J` on BPF .o file? Clang already generates
> > .BTF (and .BTF.ext, of course) for you.
>
> You're missing the point. The kernel build system does it. Try the following:

Yeah, I clearly am, because "compiling old kernels like 4.19" made me
think that we are talking about building kernel, not selftests.

>
> * Get the v4.19 sources
> * Make sure that clang --version is 10
> * Make sure you have pahole (I used v1.17)
> * Build selftests
>
> The resulting object files will have bogus .BTF.ext sections due the
> bug I have described. Does it make sense to run pahole -J on these?
> No, but it still happens.
>

Yeah, because back in the day Clang didn't know how to generate .BTF,
so using pahole to generate .BTF for BPF object files was a solution.

> I think it's reasonable to expect to get valid BPF ELFs out of this process.

We should probably update Makefile for old kernel selftest to not call
pahole -J, if Clang is recent enough and/or if .o file already has
.BTF. That shouldn't be hard.

>
> >
> > pahole -J is supposed to be used for vmlinux, not for clang-compiled
> > -target BPF object files.
> >
> > >
> > > To demonstrate, on a recent check out of bpf-next:
> > >     $ cp connect4_prog.o connect4_pahole.o
> > >     $ pahole -J connect4_pahole.o
> > >     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> > > --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
> > >     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> > > .BTF.ext=btf-ext.bin connect4_prog.o
> > >     $ sha1sum *.bin
> > >     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
> > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
> > >     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
> > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> > >
> > > This problem crops up when compiling old kernels like 4.19 which have
> > > an extra pahole
> > > build step with clang-10.
> >
> > I was under impression that clang generates .BTF and .BTF.ext only for
> > -target BPF. In this case, kernel is compiled for "real" target arch,
> > so there shouldn't be .BTF.ext in the first place? If that's not the
> > case, then I guess it's a bug in Clang.
>
> connect4_prog.o is BPF:
>
> $ readelf -h connect4_prog.o | grep BPF
>   Machine:                           Linux BPF
>
> Maybe I misunderstand what you're trying to say.
>

I was talking/thinking about building kernel, you were talking about
building BPF object files in selftests. Just to avoid confusion in the
future, let's not talk about compiling kernel, when we are talking
about compiling selftests. See my suggestion for a fix above. Would
that work?

> Best
> Lorenz
>
> --
> Lorenz Bauer  |  Systems Engineer
> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>
> www.cloudflare.com
