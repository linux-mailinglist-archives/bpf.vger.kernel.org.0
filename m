Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4581310F1E
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhBEQIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 11:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhBEQGc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 11:06:32 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8105C06178A;
        Fri,  5 Feb 2021 09:48:14 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id a16so6574787ilq.5;
        Fri, 05 Feb 2021 09:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Nzg2Y6oVl+tLUz3k5gFodM3ChMzuciBTFCA8xI93+E4=;
        b=mzh3bA4P1GVt2poO+pGX1uSo08aLxLImENFo2eSBX4r53MeU/8TValwGQTeFEgDtU7
         lKHDmzQxxcByjhX2sqUModDOkxjFskCKrRHDVW2JxmsZJ6e46wTYssM2hUibPy3D575B
         +jiGZSpMJopbVXsVGES4zUpKbTO120TxkYuoCr1N+71+l1IoBgUEYm9J0MAvHIb3xQYN
         U02XCrB+fqb8iKbZUeZlydA5JBo6bn2lTQbFCFqBghzYs0XSkzuag28jmlcAFPL7pJBs
         A1emkUP1XvbD0fvgbbf4yBI0E9pfs/zBPtHcjpiQvb6DuSgFfLhXIIDmOpVzHTvXxBxz
         hfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Nzg2Y6oVl+tLUz3k5gFodM3ChMzuciBTFCA8xI93+E4=;
        b=BB36qj54RZFrwS2IObITEL9B3w8Kn+NRdUCNvQ8ph2yExjztrRUlijrASxDee0ESNE
         xKHAV26hSKhs5avat208HdfIPBROq6W9+/jIZhDTpNYaI5YAhCuh4dvOIz7d1PwR/x4R
         87/D8Z3CdKPDp4CiiF26apYY83/jiJboBp5c33c9cq8wHkOagQ/IDbzpYXpVB8Syy7q4
         DPTT5/o2m9j2QgON7Bau/rdSjRQQexEDY5kel6biKUSR/PY61ZxHcmsxKpkH4vfkWSDb
         SxMaFWPJxdy4EiXYwkY9qRG8BQpEUEspheokaO+jTxFavRkJGfSPju6F1VDSo0u+8cmF
         UP4A==
X-Gm-Message-State: AOAM533soWQgcbQnSbmdvH/BOt+eCHxD7I0CCaGriEEhAfuq+y20khvS
        nE0YaMv5+DwLd6Wr+wvTLAHIp+zIawZUgMdX8J4=
X-Google-Smtp-Source: ABdhPJzobqn7E2KduFsjD69vXwZuE2qkuShXvhD42PLKIrCEKwFrkYSvozWmQwUT8xJtc1AHzxZCoN9XFC6rq//XVWg=
X-Received: by 2002:a92:58ce:: with SMTP id z75mr5018753ilf.209.1612547294004;
 Fri, 05 Feb 2021 09:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com> <20210205152823.GD920417@kernel.org>
In-Reply-To: <20210205152823.GD920417@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 18:48:02 +0100
Message-ID: <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 4:28 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Feb 05, 2021 at 04:23:59PM +0100, Sedat Dilek escreveu:
> > On Fri, Feb 5, 2021 at 3:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Fri, Feb 5, 2021 at 3:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > when building with pahole v1.20 and binutils v2.35.2 plus Clang
> > > > v12.0.0-rc1 and DWARF-v5 I see:
> > > > ...
> > > > + info BTF .btf.vmlinux.bin.o
> > > > + [  != silent_ ]
> > > > + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> > > >  BTF     .btf.vmlinux.bin.o
> > > > + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> > > > .tmp_vmlinux.btf
> > > > [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > > > Encountered error while encoding BTF.
> > >
> > > Grepping the pahole sources:
> > >
> > > $ git grep DW_ATE
> > > dwarf_loader.c:         bt->is_bool = encoding == DW_ATE_boolean;
> > > dwarf_loader.c:         bt->is_signed = encoding == DW_ATE_signed;
> > >
> > > Missing DW_ATE_unsigned encoding?
> > >
> >
> > Checked the LLVM sources:
> >
> > clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
> > llvm::dwarf::DW_ATE_unsigned_char;
> > clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding = llvm::dwarf::DW_ATE_unsigned;
> > clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
> > llvm::dwarf::DW_ATE_unsigned_fixed;
> > clang/lib/CodeGen/CGDebugInfo.cpp:
> >   ? llvm::dwarf::DW_ATE_unsigned
> > ...
> > lld/test/wasm/debuginfo.test:CHECK-NEXT:                DW_AT_encoding
> >  (DW_ATE_unsigned)
> >
> > So, I will switch from GNU ld.bfd v2.35.2 to LLD-12.
>
> Thanks for the research, probably your conclusion is correct, can you go
> the next step and add that part and check if the end result is the
> expected one?
>

Still building...

Can you give me a hand on what has to be changed in dwarves/pahole?

I guess switching from ld.bfd to ld.lld will show the same ERROR.

- Sedat -
