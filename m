Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C226F311501
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhBEWW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbhBEOZQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 09:25:16 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA74C061A2A;
        Fri,  5 Feb 2021 07:50:49 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id p15so6191118ilq.8;
        Fri, 05 Feb 2021 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=kiM8WMFjST9dsy9zDah68/XyOF2KBPOv5W+GYkbdeSU=;
        b=ZhDvtHxZgtHTeY5fyZvbph2aXejeBONUjk0laSyWHs/QDFG5LJ9yIUTaOXQcYVmy1/
         WS2CJ0uUMJMdBwp2t4lWN2kSj7CHRJYMY0sCM23/kj5OZH6cDxo7YmwkWXjiK02SLu0Z
         JVwInYdwgJmkye65iGmTfoKn4kplizy4wl5YdYgk0LAsSJbI2La/jY2qjYlo8UZcKqVl
         Xz2SWjCKHDly+bUkdmUAx7IrxoQw4Yf1lMf1tRarksR+aM9oWtJFFNMumodtfZXEWP2S
         JUKXCicBRJQOYYWT0+MBQ7+X1QkKoZihCQ3tRVs212ww4K5xzs+SsxWedJpwe70fOl2q
         smQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=kiM8WMFjST9dsy9zDah68/XyOF2KBPOv5W+GYkbdeSU=;
        b=dR2SwLukGrJS3jjm7A3niy3higIPOv5dRpigFJTzRqWylgLjjZU2awnX0SaP2jlD1I
         FhznNpVeHuYn4xKafYKbC85LzLDQjUqcHzT8BVRPEHkP33XAYb+ut+vO+Ep7uM1zjNPI
         j/dfCixLQygnXDvAlUUw4OdqzOfMKD2OOQXvxsFJ1YDHS+3qmjaG0zBr3G/vx/HAav3P
         dpET5wRoULyaMcBKfP4QAwffJBq23DitHMzLR54tbvEvRNH0nbHif5GuQ37zEp/pj8zN
         t+Hb/wP+l4KSKCAw46GgHfyaWuCJ2QVYDW6X5WlSz44SX+Omn6q96EQ8w/LG98QROFig
         2AdA==
X-Gm-Message-State: AOAM5322IBGtzyH++M+Ag16BaMe5pTjIX1GUJSUr3MrSOo/ZLlDMlup8
        6QvcF5FZziLZBWhHg+jNH8wpMY+KLLZOI429YA+VJHYCfHTXGYcS
X-Google-Smtp-Source: ABdhPJw1QvaGYTrK47b0MkpUdbTRZaKI08TYAO8wf7udS7POZDrIiJ5UECvfvMWbmJe7zrApyTMXW7qOfbFwoG8G4Qw=
X-Received: by 2002:a92:ce46:: with SMTP id a6mr4531229ilr.10.1612538650788;
 Fri, 05 Feb 2021 07:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
In-Reply-To: <CA+icZUU2xmZ=mhVYLRk7nZBRW0+v+YqBzq18ysnd7xN+S7JHyg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 16:23:59 +0100
Message-ID: <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
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

On Fri, Feb 5, 2021 at 3:41 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 3:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > Hi,
> >
> > when building with pahole v1.20 and binutils v2.35.2 plus Clang
> > v12.0.0-rc1 and DWARF-v5 I see:
> > ...
> > + info BTF .btf.vmlinux.bin.o
> > + [  != silent_ ]
> > + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
> >  BTF     .btf.vmlinux.bin.o
> > + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> > .tmp_vmlinux.btf
> > [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> > Encountered error while encoding BTF.
>
> Grepping the pahole sources:
>
> $ git grep DW_ATE
> dwarf_loader.c:         bt->is_bool = encoding == DW_ATE_boolean;
> dwarf_loader.c:         bt->is_signed = encoding == DW_ATE_signed;
>
> Missing DW_ATE_unsigned encoding?
>

Checked the LLVM sources:

clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
llvm::dwarf::DW_ATE_unsigned_char;
clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding = llvm::dwarf::DW_ATE_unsigned;
clang/lib/CodeGen/CGDebugInfo.cpp:    Encoding =
llvm::dwarf::DW_ATE_unsigned_fixed;
clang/lib/CodeGen/CGDebugInfo.cpp:
  ? llvm::dwarf::DW_ATE_unsigned
...
lld/test/wasm/debuginfo.test:CHECK-NEXT:                DW_AT_encoding
 (DW_ATE_unsigned)

So, I will switch from GNU ld.bfd v2.35.2 to LLD-12.

- Sedat -
