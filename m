Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5289209BDE
	for <lists+bpf@lfdr.de>; Thu, 25 Jun 2020 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390875AbgFYJZW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jun 2020 05:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390071AbgFYJZV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jun 2020 05:25:21 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401DC061573
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 02:25:20 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n6so4664636otl.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqbdKwySnCapveBmwZKI21VfpRFARqIv1v+Tr3RNZWo=;
        b=nPpf6dNuW0RWcJE5jHgcREbbnyyu9jMz9k+Ed/lvBEFtOV3/dJ6R+Vrs6LkOPyyhMb
         DFVhGMSafvJvhTGr2S4H+BA3cb+pwUJc0TCTaBpGLn4aGENDiK+EvqzMMKKvaPydvZe4
         MaNP8dEF60ERXqdsotsb6T4qbgVdEuExTMIi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqbdKwySnCapveBmwZKI21VfpRFARqIv1v+Tr3RNZWo=;
        b=X9p8wOVKb3C72RJb7AKIXr+gobKuPE85YyUrl3C56/+FvAqjKJylJSZKSqpJxQDZn9
         uYcNFiES8ZBhs8mAQZQR78gMyvQyfd4SOsfqqrar/fe2g56cb//yvOD9guPDxN19hTd/
         Rs/PIrGtUPzc/Zi2Ue4VC8ghP3lJO0CHdJYWXTibxi6mBkgUn0OSMN8sHi4+b8DI2ruj
         ebbPJVbLTHwHcfpNO3gcV+KletO5dzoT2057ClrqniPYdQ8S7BLXH/W2BUyJPGG8I7W2
         k9tf7ff7gkzxpn0g+FtG2NZBVK2S85TVRQcJUqH5gM9OyjqhdsTvk4UGexZpew/Fc4uL
         wpxg==
X-Gm-Message-State: AOAM531UuzAp2AD9RwakHJcqX+Syjff98AyV+VdAPeDg8xltBYJY0MoJ
        kcKxYZE43Ml+YBRw6HsZ8vhir+CY4Ngi3VBRfGMN1Q==
X-Google-Smtp-Source: ABdhPJwepjm9TvThRXXl1S9VoV2/7LlJM5/csONznP0U3oJqNdz6VPU2jJ0s/WcRwvWPzEGsBt77nzsfxcNdyju+SyY=
X-Received: by 2002:a9d:7f06:: with SMTP id j6mr25219707otq.132.1593077119971;
 Thu, 25 Jun 2020 02:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <CAEf4BzbSc-wykq1_62CQwtszO+76rkudz_B=GkzE6ZheMUAusw@mail.gmail.com>
In-Reply-To: <CAEf4BzbSc-wykq1_62CQwtszO+76rkudz_B=GkzE6ZheMUAusw@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 25 Jun 2020 10:25:08 +0100
Message-ID: <CACAyw98ojwGjQm+Xk+_-B8Ah-hEt-Tgv_LQ1BdH4yBLYgVwpiA@mail.gmail.com>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Jun 2020 at 18:41, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Jun 24, 2020 at 4:07 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > Hi,
> >
> > If pahole -J is used on an ELF that has BTF info from clang, it
> > produces an invalid
> > output. This is because pahole rewrites the .BTF section (which
> > includes a new string
> > table) but it doesn't touch .BTF.ext at all.
>
> Why do you run `pahole -J` on BPF .o file? Clang already generates
> .BTF (and .BTF.ext, of course) for you.

You're missing the point. The kernel build system does it. Try the following:

* Get the v4.19 sources
* Make sure that clang --version is 10
* Make sure you have pahole (I used v1.17)
* Build selftests

The resulting object files will have bogus .BTF.ext sections due the
bug I have described. Does it make sense to run pahole -J on these?
No, but it still happens.

I think it's reasonable to expect to get valid BPF ELFs out of this process.

>
> pahole -J is supposed to be used for vmlinux, not for clang-compiled
> -target BPF object files.
>
> >
> > To demonstrate, on a recent check out of bpf-next:
> >     $ cp connect4_prog.o connect4_pahole.o
> >     $ pahole -J connect4_pahole.o
> >     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> > --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
> >     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> > .BTF.ext=btf-ext.bin connect4_prog.o
> >     $ sha1sum *.bin
> >     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
> >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
> >     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
> >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> >
> > This problem crops up when compiling old kernels like 4.19 which have
> > an extra pahole
> > build step with clang-10.
>
> I was under impression that clang generates .BTF and .BTF.ext only for
> -target BPF. In this case, kernel is compiled for "real" target arch,
> so there shouldn't be .BTF.ext in the first place? If that's not the
> case, then I guess it's a bug in Clang.

connect4_prog.o is BPF:

$ readelf -h connect4_prog.o | grep BPF
  Machine:                           Linux BPF

Maybe I misunderstand what you're trying to say.

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
