Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6111207C20
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 21:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbgFXT0F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 15:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbgFXT0F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jun 2020 15:26:05 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137DC061573;
        Wed, 24 Jun 2020 12:26:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f18so3010194qkh.1;
        Wed, 24 Jun 2020 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJzD23XP+N+oVXCfa5f5yROYzZhuKcdi0skLPrhl3W4=;
        b=rkLDTlmkAkoCm1KcE36aMQqcmc6CmtNRoJQHQun7bgldwm0vOqEFlVI4Kq53VeLvCS
         sVhln3Or3Wkhur3Bhryj76CbG2CGQbuNfFSHDSCQwKp0c1fxKS1VO62BzYoR0GpmstQb
         cMiYEa4HdEa3gRrLjrhx+vhY7mfENHRtcRAAfoIozAoW28Jukh/PaCmLokwl2XtiY4tn
         QRDkoDOag/UOtIgAnW0UqYnsKHkqwZthbtZaZLo8Pv4XwGciRWXkaT+z1XjXpBxfWujU
         GFfDLgqSc2MfKVl3Q/LoTJyiTXZ3d47G3u4eo+sqQ5lUE3mfbT8+M/+BJtVaHK/9Mezp
         om9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJzD23XP+N+oVXCfa5f5yROYzZhuKcdi0skLPrhl3W4=;
        b=P6BprV7Z2z19cWfm5TmIWK22UH1xOcjcc2SWLrcEHe1TJR96bmt+N3Q/HRwHXaUGf2
         CnbDcpXvZlZvwmBUiRaLfcarsbi5UOy60qRSVeLGqWdv0bO0nvG9DR9l8ubzxMW7WKd3
         S3R+Ow16eGBQyJlW1Xyhixb4tC/ZXiYI3uwrrexEE+qUCwR9wkdylGnmnnVAS4LC30o5
         aRi38fIOF9W59AuCfXptJkI/C8UccuCJUXwfVvUAIjpKVaplDydGJ9GQqyuV9Lsw3I5R
         xAJUebMZT2hVehSpMVMj4G8qBb3mDAdtN/omLUbRUrER8DptpelOBuzhu2kZyC/ogEP9
         YQlg==
X-Gm-Message-State: AOAM530x020TckyNyhkzXUiyS1G7x7Xr2kOdUDWYHryPUCVUHFf0hvQA
        +eBJMH3FaPoxcxhlAnubnZZ2+S+Pt1G4LNsY9tZ+hA==
X-Google-Smtp-Source: ABdhPJxAL1vTKfbKpnj3dXD9F5LsrzE4kB7CFbFCfCyiW4Udidj6krdKwzC7Bc5Of2ri2AB2PlpC9xiVNcdX9QXeT1I=
X-Received: by 2002:a05:620a:b84:: with SMTP id k4mr26929091qkh.39.1593026762842;
 Wed, 24 Jun 2020 12:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <CAEf4BzbSc-wykq1_62CQwtszO+76rkudz_B=GkzE6ZheMUAusw@mail.gmail.com>
 <20200624175754.GD20203@kernel.org> <CAEf4BzY8b71tE5B4rw5sfy=xajtgqUGHVaoHNf_YzVtQ9aLCBg@mail.gmail.com>
 <20200624185737.GA25807@kernel.org> <CAEf4Bza=ZT1yZvoJNMK72pYm6VGwGp22detc7kgC_24OBt4-FA@mail.gmail.com>
 <20200624191159.GB25807@kernel.org>
In-Reply-To: <20200624191159.GB25807@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Jun 2020 12:25:51 -0700
Message-ID: <CAEf4BzYABe7++b8mKESWZCV3gsJ2TgZKyVPhqW0uoQO29qwxsg@mail.gmail.com>
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        dwarves@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 24, 2020 at 12:12 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Jun 24, 2020 at 12:06:24PM -0700, Andrii Nakryiko escreveu:
> > On Wed, Jun 24, 2020 at 11:57 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Wed, Jun 24, 2020 at 11:40:21AM -0700, Andrii Nakryiko escreveu:
> > > > On Wed, Jun 24, 2020 at 10:57 AM Arnaldo Carvalho de Melo
> > > > <arnaldo.melo@gmail.com> wrote:
> > > > >
> > > > > Em Wed, Jun 24, 2020 at 10:41:10AM -0700, Andrii Nakryiko escreveu:
> > > > > > On Wed, Jun 24, 2020 at 4:07 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > If pahole -J is used on an ELF that has BTF info from clang, it
> > > > > > > produces an invalid
> > > > > > > output. This is because pahole rewrites the .BTF section (which
> > > > > > > includes a new string
> > > > > > > table) but it doesn't touch .BTF.ext at all.
> > > > > >
> > > > > > Why do you run `pahole -J` on BPF .o file? Clang already generates
> > > > > > .BTF (and .BTF.ext, of course) for you.
> > > > > >
> > > > > > pahole -J is supposed to be used for vmlinux, not for clang-compiled
> > > > > > -target BPF object files.
> > > > >
> > > > > yeah, I was thinking this was for a vmlinux generated by clang, which,
> > > > > from the commands below (the suffix _prog.o) should have told me this is
> > > > > a target BPF object file.
> > > > >
> > > > > But then, if one insists for some reason in generating BTF from the
> > > > > DWARF in a BPF target object file, stripping .BTF.ext, if present, is
> > > > > the right thing to do at this point.
> > > >
> > > > I disagree. Those who insist probably have some wrong conceptual
> > > > understanding and it's better to fix that (understanding), rather than
> > > > lose focus and bend tool to do what it's not supposed to do and
> > > > ultimately cause more confusion.
> > >
> > > So we can instead notice the presence of .BTF.ext when the user calls
> > > 'pahole -J' on a target BPF object file and bail out, only allowing it
> > > to convert from DWARF to BTF and thus encode the .BTF elf section when
> > > .BTF.ext isn't present, as we can't easily figure out if the present of
> > > just .BTF section was done by clang or pahole on a BTF target object
> > > file built without -g.
> >
> > Can't we check ELF's target machine and reject if it's a BPF one?
>
> I think there is value in allowing pahole to convert DWARF to BTF even
> for a BPF target object file, say in some case people may think clang is
> not generating correct BTF so one may want to see what pahole generates
> and compare.

sure, and will the warning for wrong architecture would give a hint
that it's not the right thing to do, probably. Or we could have more
specific message for BPF target. I don't care all that much.


>
> > Someday we might also support "cross-compilation" to be able to dedup
> > arm ELF from x86 machine. It's sort of ok today for little-endian
> > ARMs, so maybe not outright reject if architecture is not the same as
> > the local one?
>
> I think outright reject if arch is not t he same it not necessary.
>
> We may warn the user that using -g in clang is the preferred method for
> generating BTF, wdyt?
>

sounds reasonable

> - Arnaldo
>
> > >
> > > - Arnaldo
> > >
> > > > pahole's BTF conversion is really driven towards kernel use-case
> > > > (e.g., with global variables, etc). I wouldn't distract ourselves with
> > > > supporting de-duplicating BPF object files. Single .o's BTF is already
> > > > deduplicated as produced by Clang. Once we add static linking of
> > > > multiple BPF .o's (which I hope to start working on very soon), that
> > > > de-duplication will be handled automatically by libbpf (and hopefully
> > > > integrated into lld as well), among many other things that need to
> > > > happen to make static linking work.
> > > >
> > > > >
> > > > > - Arnaldo
> > > > >
> > > > > > >
> > > > > > > To demonstrate, on a recent check out of bpf-next:
> > > > > > >     $ cp connect4_prog.o connect4_pahole.o
> > > > > > >     $ pahole -J connect4_pahole.o
> > > > > > >     $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
> > > > > > > --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
> > > > > > >     $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
> > > > > > > .BTF.ext=btf-ext.bin connect4_prog.o
> > > > > > >     $ sha1sum *.bin
> > > > > > >     1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
> > > > > > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
> > > > > > >     2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
> > > > > > >     4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
> > > > > > >
> > > > > > > This problem crops up when compiling old kernels like 4.19 which have
> > > > > > > an extra pahole
> > > > > > > build step with clang-10.
> > > > > >
> > > > > > I was under impression that clang generates .BTF and .BTF.ext only for
> > > > > > -target BPF. In this case, kernel is compiled for "real" target arch,
> > > > > > so there shouldn't be .BTF.ext in the first place? If that's not the
> > > > > > case, then I guess it's a bug in Clang.
> > > > > >
> > > > > > >
> > > > > > > I think a possible fix is to strip .BTF.ext if .BTF is rewritten.
> > > > > > >
> > > > > > > Best
> > > > > > > Lorenz
> > > > > > >
> > > > > > > --
> > > > > > > Lorenz Bauer  |  Systems Engineer
> > > > > > > 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
> > > > > > >
> > > > > > > www.cloudflare.com
> > > > >
> > > > > --
> > > > >
> > > > > - Arnaldo
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
