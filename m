Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3392E3114BE
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhBEWNn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:13:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhBEOiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 09:38:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0758650E8;
        Fri,  5 Feb 2021 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612538906;
        bh=E2Jw4BshaPLVJ9wPxfC66/Uv6q2P/5ZX+rAXq/iyIPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlIPQhSmL4+gt4AYq78Tojxk5QM5rSKspqgbgKPkoDZJu2lW542q7KKUMwlICfYqM
         LpDcBrqqm5RA1rybwKa6To2pnBo3Fkiq7XC0YkJtR68uVT49Tk5ZrgCWdwEyzRozOs
         EC0NwgnB+QXXL3cWQPUXtgtoK9QTtP84KoOYgEkgcn22Jn2czLr2crqAcj+Uq4Rr79
         R33unnJlVvV4CK9d5oALSpCObo8lF1u+ucMGv8Znarg7/5GoY+4U4PEKPcm2Jl+QbJ
         6j+5yJkLKzIX+ITn/psNu1zkaTNTj094yF9Gm+cHLfjm7oc53GmM9oDNrhcIG3pBsL
         VDmzl339xxFyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 63EDC40513; Fri,  5 Feb 2021 12:28:23 -0300 (-03)
Date:   Fri, 5 Feb 2021 12:28:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
Message-ID: <20210205152823.GD920417@kernel.org>
References: <20210204220741.GA920417@kernel.org>
 <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 05, 2021 at 04:23:59PM +0100, Sedat Dilek escreveu:
> On Fri, Feb 5, 2021 at 3:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 3:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > when building with pahole v1.20 and binutils v2.35.2 plus Clang
> > > v12.0.0-rc1 and DWARF-v5 I see:
> > > ...
> > > + info BTF .btf.vmlinux.bin.o
> > > + [  != silent_ ]
> > > + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> > >  BTF     .btf.vmlinux.bin.o
> > > + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> > > .tmp_vmlinux.btf
> > > [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > > Encountered error while encoding BTF.
> >
> > Grepping the pahole sources:
> >
> > $ git grep DW_ATE
> > dwarf_loader.c:         bt->is_bool = encoding == DW_ATE_boolean;
> > dwarf_loader.c:         bt->is_signed = encoding == DW_ATE_signed;
> >
> > Missing DW_ATE_unsigned encoding?
> >
> 
> Checked the LLVM sources:
> 
> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
> llvm::dwarf::DW_ATE_unsigned_char;
> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding = llvm::dwarf::DW_ATE_unsigned;
> clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
> llvm::dwarf::DW_ATE_unsigned_fixed;
> clang/lib/CodeGen/CGDebugInfo.cpp:
>   ? llvm::dwarf::DW_ATE_unsigned
> ...
> lld/test/wasm/debuginfo.test:CHECK-NEXT:                DW_AT_encoding
>  (DW_ATE_unsigned)
> 
> So, I will switch from GNU ld.bfd v2.35.2 to LLD-12.

Thanks for the research, probably your conclusion is correct, can you go
the next step and add that part and check if the end result is the
expected one?

- Arnaldo
