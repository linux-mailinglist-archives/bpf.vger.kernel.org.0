Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224DB28906D
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 19:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgJIR7c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 13:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgJIR7c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 13:59:32 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F8C0613D2;
        Fri,  9 Oct 2020 10:59:31 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c3so7907382ybl.0;
        Fri, 09 Oct 2020 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNf+eHAfipT5/lMmEdzU4neAMEwONLyMRP/D8oZqeYc=;
        b=ccI9U5HVeGRbaZSXduvN+ZDiOV6JW5vJ+mHKHxlkfkneoD3SaAF9BB8oaE/OjDfXBe
         rubIM8XSX4ex8ekRkAvv0ksB9WZ6rPsOQZVopfLvOXXgYyksnOwmVbk65ngVIBf3MpxF
         zTRlh8btTZMZx5RSaa55CNvYZbP2Zpk6Lxun1Yw50OsvFeDM39LGV0pQ8gwgeXum78wW
         s+VWeCMpYKWHotMGdajtHUGzQgZYE3mdWRdkojeW8FfCAK7aOjF85XXvnTj+QxZwkWNC
         et9j7RAS4AKt+wozDFpYmJpi0tLQjp/08dt+bYcq/8VfbuucpqFOwU+R6dtKlEJP+MZP
         +6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNf+eHAfipT5/lMmEdzU4neAMEwONLyMRP/D8oZqeYc=;
        b=gnzot6OK4nVG++OWzhAwCffTWEhRtfUotEarTsml2A3rGemwRxDUotbtqnlyZhp1ne
         IAttqZqrG4HJK9JSm4XKZLHSLpA4VDDf0Jxm3V3zdTkgC52lvHxJHzqxnm5PpDxeyVUm
         45jOV2NTH6vBGOcggzC4+Xvvckz6BkTbyXm/LGijBfP4/7GBFD4ibdu0TAJ+cb17IYJ7
         MX2jPwL7ZDcAUPol40vytlN5Ae66zPYfsbYfO9FoukqiX6dQbzW8NxfJFV7KiGaC9BRr
         pYowBUnn8ehWivCBbdFAftqlyKuXhkvxvKtenwWIIRuUi8ARV9VCkWHryaDbeWIR4Fc6
         wP4Q==
X-Gm-Message-State: AOAM530A4clv1vCWXq2JYUPsn6hpmTy5NDihoaoUnF1+8HorpuY9N3pJ
        D7HUdiPlGFSFIwXzgIU2QFXxt08SszjnPPQgrH4=
X-Google-Smtp-Source: ABdhPJx+CptLJ9+mNy/IFL3G9w38nWHK/rE8NXgCF7u1JDy0WcXvfJhkRN7UVnA27QBrGjahfUm8gWc89r+NvuycE3M=
X-Received: by 2002:a25:2596:: with SMTP id l144mr18588863ybl.510.1602266371212;
 Fri, 09 Oct 2020 10:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201008234000.740660-1-andrii@kernel.org> <20201009162243.GD322246@kernel.org>
In-Reply-To: <20201009162243.GD322246@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Oct 2020 10:59:20 -0700
Message-ID: <CAEf4BzZa7WGDpBxHKNvO+SWv2=J2mGyQZuuMTkGWkRWxz+KLgg@mail.gmail.com>
Subject: Re: [PATCH v2 dwarves 0/8] Switch BTF loading and encoding to libbpf APIs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Hao Luo <haoluo@google.com>,
        Oleg Rombakh <olegrom@google.com>, dwarves@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Tony Ambardar <tony.ambardar@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Borna Cafuk <borna.cafuk@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 9, 2020 at 9:22 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Thu, Oct 08, 2020 at 04:39:52PM -0700, Andrii Nakryiko escreveu:
> > This patch set switches pahole to use libbpf-provided BTF loading and encoding
> > APIs. This reduces pahole's own BTF encoding code, speeds up the process,
> > reduces amount of RAM needed for DWARF-to-BTF conversion. Also, pahole finally
> > gets support to generating BTF for cross-compiled ELF binaries with different
> > endianness (patch #8).
> >
> > Additionally, patch #3 fixes previously missed problem with invalid array
> > index type generation.
> >
> > Patches #4-7 are speeding up DWARF-to-BTF convertion/dedup pretty
> > significantly, saving overall about 9 seconds out of current 27 or so.
> >
> > Patch #5 revamps how per-CPU BTF variables are emitted, eliminating repeated
> > and expensive looping over ELF symbols table. The critical detail that took
> > few hours of investigation is that when DW_AT_variable has
> > DW_AT_specification, variable address (to correlate with symbol's address) has
> > to be taken before specification is followed.
> >
> > More details could be found in respective patches.
> >
> > v1->v2:
> >   - rebase on latest dwarves master and fix var->spec's address problem.
>
> Thanks, I applied all of them, tested and reproduced the performance
> gains, great work!

Great, thanks a lot, Arnaldo!

Next step is adding BTF to kernel modules, where module's BTF will be
an "extension" of vmlinux's BTF, with only a minimal set of new types
used/added in the module, that are not available in vmlinux. This
should make per-module BTF really tiny.

>
> I'll do some more testing on encoding a vmlinux for some big endian arch
> on my x86_64 workstation and then push things publicly.
>
> If Hao find any issues we can fix in a follow up patch.
>
> I also added the people involved in the discussion about cross builds
> failing, please take a look, I'm pushing now to a tmp.libbtf_encoder so
> that you can test it from there, ok?
>
> - Arnaldo
>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >
> > Andrii Nakryiko (8):
> >   btf_loader: use libbpf to load BTF
> >   btf_encoder: use libbpf APIs to encode BTF type info
> >   btf_encoder: fix emitting __ARRAY_SIZE_TYPE__ as index range type
> >   btf_encoder: discard CUs after BTF encoding
> >   btf_encoder: revamp how per-CPU variables are encoded
> >   dwarf_loader: increase the size of lookup hash map
> >   strings: use BTF's string APIs for strings management
> >   btf_encoder: support cross-compiled ELF binaries with different
> >     endianness
> >
> >  btf_encoder.c  | 370 +++++++++++++++------------
> >  btf_loader.c   | 244 +++++++-----------
> >  ctf_encoder.c  |   2 +-
> >  dwarf_loader.c |   2 +-
> >  libbtf.c       | 661 +++++++++++++++++++++----------------------------
> >  libbtf.h       |  41 ++-
> >  libctf.c       |  14 +-
> >  libctf.h       |   4 +-
> >  pahole.c       |   2 +-
> >  strings.c      |  91 +++----
> >  strings.h      |  32 +--
> >  11 files changed, 645 insertions(+), 818 deletions(-)
> >
> > --
> > 2.24.1
> >
>
> --
>
> - Arnaldo
