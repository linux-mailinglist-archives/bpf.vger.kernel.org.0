Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CE13114FF
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBEWWT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbhBEOWu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 09:22:50 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816AC061226;
        Fri,  5 Feb 2021 07:48:17 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g15so4797821pgu.9;
        Fri, 05 Feb 2021 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=pEagqi62HNqjEDuovFOO2JjM1Kr7t2Jo4q/MNI9nB24=;
        b=d+2AkdJ5YK/R4OEm1F9w9ooTMwZ/Vt+mJeEK9vh6KYl4J3TC/O5aR8pligor7UGdow
         rTCeeXWc2j9KJ+o9LJX44mo5XXzp9ZogHdoTaldeuDMa6UcWd+mcdCw2atlcxCwoWqu+
         +OxUbmrGZ765RoDSL8fDC4pPz4+WS3GbHGdvTiMhjzLYbzSmLAqfWvX5dO6wEmx/ho1t
         vWuxRohupI2Un0Kww6hDdU9YgUYU8+v+KSJhU6iRmyZBxMEeWcxpo4L1qhhppRmlVl0U
         WWIBsW9tAjoJzJ3+0yQz2WqCCoUyv6q5XW80AxPxur/9KI3e6d9M9Qa03a+dccPGI4e/
         1U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pEagqi62HNqjEDuovFOO2JjM1Kr7t2Jo4q/MNI9nB24=;
        b=RWr7bwUjGmnPvlwBtpd0QY4mG+hICaBqGE9rJKFIg72WVv6P01G+rf3qU7bMTd5+nE
         FpWc6O+lM1/QE+PHMzXNmS/1sFAx3sE6NtLgou6ZBz5iMA3OpvhSuUwWWibaSiz9vsD0
         Ji23WlxBVN7f+4IvaApUGxWIq9C8UaJw7exmIdEYrdY1wr/D8r/h8jBEJIR9uLgxeQb9
         WT8Fbf+cYFZ0vouwEoBm1bX5n8ppTWGgK9NCs9XEgJcwwRePEOnCGbBofGeTJx5d+t+P
         K3yGNq/dA+WQ5ttDFj8sp7oqZmtR3KkznSMkFBptcubE24GBFAin/Oz+YROfuldnnzsc
         tyHQ==
X-Gm-Message-State: AOAM530b2t+zI3cwLTjRdg2sHINn7HJLT0E1K+3RovSVZ4g1tytbtaz9
        epwp/EE2MU89tZKqdfCDUzrLbr18eTWknR5EV/jtmLT/6UhW8vSi
X-Google-Smtp-Source: ABdhPJyrzvmSgLmdsKyKFyvusDR+QofbAQpPKPcvpRRCE7XydDr33WsaT2aqAPYK9i/NCs+K9n6P4hAfVoIw1Sw3vdQ=
X-Received: by 2002:a92:58ce:: with SMTP id z75mr4514066ilf.209.1612539662400;
 Fri, 05 Feb 2021 07:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
 <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com> <20210205152823.GD920417@kernel.org>
In-Reply-To: <20210205152823.GD920417@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 16:40:51 +0100
Message-ID: <CA+icZUUNhtbv3sNkPd4Ac9rd5ZZ7DfNEqRKEHKWXEcpHd63c2g@mail.gmail.com>
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

Started a new build:

$ ps -ef | grep p[e]rf
dileks    529807  529775  0 16:32 pts/1    00:00:00 /usr/bin/perf_5.10
stat make V=1 -j4 LLVM=1 PAHOLE=/opt/pahole/bin/pahole
LOCALVERSION=-12-amd64-clang12-llvm KBUIL
D_VERBOSE=1 KBUILD_BUILD_HOST=iniza
KBUILD_BUILD_USER=sedat.dilek@gmail.com
KBUILD_BUILD_TIMESTAMP=2021-02-05 bindeb-pkg
KDEB_PKGVERSION=5.11.0~rc6-12~bullseye+dileks1

$ scripts/diffconfig /boot/config-5.11.0-rc6-10-amd64-clang12-bfd .config
BUILD_SALT "5.11.0-rc6-10-amd64-clang12-bfd" ->
"5.11.0-rc6-11-amd64-clang12-llvm"
DEBUG_INFO_DWARF4 y -> n
LD_VERSION 235020000 -> 0
LLD_VERSION 0 -> 120000
+DEBUG_INFO_DWARF5 y
+LD_IS_LLD y
+TOOLS_SUPPORT_RELR y

Will take approx. 03:15 [hh:mm] and report later.

- Sedat -
