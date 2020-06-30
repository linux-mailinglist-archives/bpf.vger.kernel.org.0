Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6120F8DE
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 17:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbgF3Pwa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 11:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389646AbgF3Pwa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 11:52:30 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976BEC061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:52:28 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id f2so663446ooo.5
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBhtVZcKXe99ELAL/kOP9BrylbK9OH0jDbcr2FDtuCg=;
        b=DNEBekS2VWaYP0EaJRAQEe7yXIROKTrxdyVjNgSH9falF3EqkNaQfKqm9QGYzTQRf3
         8XrrAU3huhFb66dVSZ+E0Oyoeki4kNEmnyCUoqkc+xNRCSWPi0PSHhScceNhXIS5Suvo
         kMq6e0EZfFAeABIq5GXyMrHjok4yLsHAmMgH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBhtVZcKXe99ELAL/kOP9BrylbK9OH0jDbcr2FDtuCg=;
        b=G253xW18SCMnoBB3CLFW0aRL6ZFSYD87AdG+lHd/rm/u0d2+L2PBTaWCzSQ2QB+ss1
         3nBnxVZmrqZaxxUojv5UjB5CqIlFTR6YmlmzaI6itpfZga8XAhTPYg4ZLTT+jjT3FEDK
         rMF2Q2OSZvP9IkSY5qnQs96cpI4NrkSXqM0pVErajDZ3BelG95QjAMhYdsqDTIFoUv1z
         gexN4n3P6TaefYBCVS6N0NRy9HHUM5TixGbQpu5lVZMics4/AOn0OIXqyTYVD73eDN+v
         rv40hVj+2e+C8ZoPApAA1931xm99r+05fB+8SyR6I4Py63jtoQK33K/CJaHBIfXsZ9Ix
         Da6w==
X-Gm-Message-State: AOAM5311p8jBaSe+AbDpj4wRN7xkffA+MhS4bv0C0dECl0xA99Yyn1Vx
        nhB4RXgXwefO1aSEwMxOCMpKeG9aesn8YHXaZtFzzA==
X-Google-Smtp-Source: ABdhPJw1Btgo6QE9dEXH25YL+mwJi8HDcP5A0tewqsN+1Bhjmbf6oSZXFsoiPRozEwo+V+hiYbn6FjtlBEwD//ifK4M=
X-Received: by 2002:a4a:3105:: with SMTP id k5mr18636588ooa.6.1593532347907;
 Tue, 30 Jun 2020 08:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <CAEf4BzbSc-wykq1_62CQwtszO+76rkudz_B=GkzE6ZheMUAusw@mail.gmail.com>
 <CACAyw98ojwGjQm+Xk+_-B8Ah-hEt-Tgv_LQ1BdH4yBLYgVwpiA@mail.gmail.com> <CAEf4BzYjge6fijFadwuuHf-vr2VUqneT5b0k-GgQSkLMTj=UAA@mail.gmail.com>
In-Reply-To: <CAEf4BzYjge6fijFadwuuHf-vr2VUqneT5b0k-GgQSkLMTj=UAA@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 30 Jun 2020 16:52:16 +0100
Message-ID: <CACAyw9-pPbTVwQ0AM=1-7SQmFdU6EF127vcqy5pmPqL7gQP3nQ@mail.gmail.com>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Jun 2020 at 17:56, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 25, 2020 at 2:25 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > On Wed, 24 Jun 2020 at 18:41, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Jun 24, 2020 at 4:07 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > If pahole -J is used on an ELF that has BTF info from clang, it
> > > > produces an invalid
> > > > output. This is because pahole rewrites the .BTF section (which
> > > > includes a new string
> > > > table) but it doesn't touch .BTF.ext at all.
> > >
> > > Why do you run `pahole -J` on BPF .o file? Clang already generates
> > > .BTF (and .BTF.ext, of course) for you.
> >
> > You're missing the point. The kernel build system does it. Try the following:
>
> Yeah, I clearly am, because "compiling old kernels like 4.19" made me
> think that we are talking about building kernel, not selftests.
>
> >
> > * Get the v4.19 sources
> > * Make sure that clang --version is 10
> > * Make sure you have pahole (I used v1.17)
> > * Build selftests
> >
> > The resulting object files will have bogus .BTF.ext sections due the
> > bug I have described. Does it make sense to run pahole -J on these?
> > No, but it still happens.
> >
>
> Yeah, because back in the day Clang didn't know how to generate .BTF,
> so using pahole to generate .BTF for BPF object files was a solution.
>
> > I think it's reasonable to expect to get valid BPF ELFs out of this process.
>
> We should probably update Makefile for old kernel selftest to not call
> pahole -J, if Clang is recent enough and/or if .o file already has
> .BTF. That shouldn't be hard.

Yeah, I think that would work!

>
> >
> > >
> > > pahole -J is supposed to be used for vmlinux, not for clang-compiled
> > > -target BPF object files.
> > >
> > > >
> > > > To demonstrate, on a recent check out of bpf-next:
> > > >     $ cp connect4_prog.o connect4_pahole.o
> > > >     $ pahole -J connect4_pahole.o
> > > >     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> > > > --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
> > > >     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> > > > .BTF.ext=btf-ext.bin connect4_prog.o
> > > >     $ sha1sum *.bin
> > > >     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
> > > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
> > > >     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
> > > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> > > >
> > > > This problem crops up when compiling old kernels like 4.19 which have
> > > > an extra pahole
> > > > build step with clang-10.
> > >
> > > I was under impression that clang generates .BTF and .BTF.ext only for
> > > -target BPF. In this case, kernel is compiled for "real" target arch,
> > > so there shouldn't be .BTF.ext in the first place? If that's not the
> > > case, then I guess it's a bug in Clang.
> >
> > connect4_prog.o is BPF:
> >
> > $ readelf -h connect4_prog.o | grep BPF
> >   Machine:                           Linux BPF
> >
> > Maybe I misunderstand what you're trying to say.
> >
>
> I was talking/thinking about building kernel, you were talking about
> building BPF object files in selftests. Just to avoid confusion in the
> future, let's not talk about compiling kernel, when we are talking
> about compiling selftests.

Point taken :)

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
