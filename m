Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32AA3113C0
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 22:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBEVo3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 16:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhBEVna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 16:43:30 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD1C06174A;
        Fri,  5 Feb 2021 13:42:50 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q7so8753608iob.0;
        Fri, 05 Feb 2021 13:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cUYenjmJ9cKKN2NVNXP7Wjbj+RthPpuIhOcVKNsaAsc=;
        b=po1CWeaX2J8Q7cmzBZN6be5J1NGa6VHuMeofwIS+bVjA+aArYN7tQ++rvgDFolsY6M
         NaYHfG2ztt4gAhMWOoCCubTO6aMKbkPdNzWDlEUGZ0/jtw7t8SwetWIUWhHVZN6PW/TU
         3tAxoUBdoS6RF+QvN143bFKaz+ygTLvXLzFQwKIDANERJzZw3H15hAOBQ0d8xTaRXPyg
         fqRei3Z6PgCJ4DGLi8Sq0+Qg8g5RCOmEhyV3wspZzDZb/osBwjp2z6MMXu7ug6KaZVWB
         JRbW44knp76BueshzLdP7YrxCfDVmiATCyPJ7vHIEpQwUqhTXxCFU56OeKbNNdyHdm0z
         3KTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cUYenjmJ9cKKN2NVNXP7Wjbj+RthPpuIhOcVKNsaAsc=;
        b=lL0dDOBkn0PNkqL44ooTkC+HmApwJKP7Cgw9kpVA58HvrIQLfAGHPinBeA8ohtvhYk
         ndzxEcRnVI72Iuym1T3rVKp8xqZvPoPE1eFEgod3oG3kRRjtEXsEZLplTeJSOtnTkOwB
         8BTr+uYXPOWsIFefiUaK+/1sCuin3SuFA2smsVBTR6u1ZCNSA9+5i59roWRHAv8mhfJt
         O02KsCImlS9aQOO2/fkQbNjJm0hVNGLyrIkr0e3+YqOK1accz4kRQNhWqZoDSPLeX3nD
         Dn1pNb7/VsG4LllvgWOtlW0gli+q8SsQ3t7s9fq11Z8eyWId1sOZvwXDE1OX3QWlXWTW
         yxZA==
X-Gm-Message-State: AOAM532O12sFcLkzy3mF869otD14u28wqL13WITFKGIoJ3aObhMHZiJl
        AgoGv3PFuG+raGb51T/VKWn9qryotiH5MByHydQ=
X-Google-Smtp-Source: ABdhPJxCGJ/umotF2zQhyVzj6yEIvX7MF8RZJ9N/au9I2J5bQE/cuIHcl5T/yIg1NEN6ea3X+uX015q69ZcvkZybWwc=
X-Received: by 2002:a05:6638:2694:: with SMTP id o20mr7051927jat.132.1612561369540;
 Fri, 05 Feb 2021 13:42:49 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <20210205211010.2764627-1-ndesaulniers@google.com> <CA+icZUXkCC9U3PsYzqhzu7BZa-eE2kd53SfX2ODrr+N=QO6VvQ@mail.gmail.com>
 <CAKwvOd=ktdttx5E=_k7B-WuJsic3imOecTUDyaQA9VUpLF45Jw@mail.gmail.com>
In-Reply-To: <CAKwvOd=ktdttx5E=_k7B-WuJsic3imOecTUDyaQA9VUpLF45Jw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 5 Feb 2021 22:42:36 +0100
Message-ID: <CA+icZUU=BJKOfgCbt4bGhy-rG=Yahv1GkOqWLriaYptGqnHWzA@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, arnaldo.melo@gmail.com,
        berrange@redhat.com, bpf <bpf@vger.kernel.org>, cavok@debian.org,
        dwarves@vger.kernel.org, jengelh@inai.de,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Wielaard <mjw@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>, paul@paul-moore.com,
        Tom Stellard <tstellar@redhat.com>, Yonghong Song <yhs@fb.com>,
        zzam@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 5, 2021 at 10:40 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Feb 5, 2021 at 1:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Fri, Feb 5, 2021 at 10:10 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
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
> > > Yes, I observe this error, too.
> > >
> > > https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
> > >
> > > via v9 of my DWARF v5 series, which should help make this easier to
> > > reproduce:
> > > https://lore.kernel.org/lkml/CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com/T/#m45ec7e6df4c4b5e9da034b95d7dfc8e2a0c81dac
> >
> > Thanks Nick for confirming the error.
> >
> > Ah, I see you passed:
> >
> > make LLVM=1 LLVM_IAS=1 ...
> >
> > Can you by chance try with KCFLAGS="-fbinutils-version=2.35"?
>
> $ PATH=/path/to/tot/pahole/build:$PATH make LLVM=1 LLVM_IAS=1 -j72
> KCFLAGS="-fbinutils-version=2.35"
> ...
>   BTF     .btf.vmlinux.bin.o
> [12919] INT DW_ATE_unsigned_1 Error emitting BTF type
> Encountered error while encoding BTF.
> ...
>   LD      vmlinux
>   BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
>

OK, thanks.

I stopped my build:

/usr/bin/perf_5.10 stat make V=1 -j4 LLVM=1 LLVM_IAS=1
PAHOLE=/opt/pahole/bin/pahole KCFLAGS=-fbinutils-version=2.3
5 LOCALVERSION=-13-amd64-clang12-llvm KBUILD_VERBOSE=1
KBUILD_BUILD_HOST=iniza KBUILD_BUILD_USER=sedat.dilek@gmail.com
KBUILD_BUILD_TIMESTAMP=2021-02-05 bindeb-pkg KDE
B_PKGVERSION=5.11.0~rc6-13~bullseye+dileks1

Enjoy weekend.

- Sedat -
