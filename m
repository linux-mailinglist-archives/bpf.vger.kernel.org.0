Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077403113BA
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 22:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhBEVmB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 16:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBEVlA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 16:41:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E6C0613D6
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 13:40:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v24so11933514lfr.7
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZYn5Ce+L0yx8LnAN5tmPGD2JqoQJUOBT07GkqQWBng=;
        b=MK6YRXtYAchkAyJlAy7ambep9El1MPm8OChMY/h3gMlXkqEQJFXa+cWdqi+VQV3fsa
         JFGtm4w92co/kRBkTNlHeYHmNRGRyZZLjlV426BAhsxb7dhe1W7ZaVH4+Nu+bdUH7U0X
         nYaCuFGCGKpcVQ5mUS/PcT5PdA5a0ul28nbQVvmT5OcM3EQJrYl+PO9W/slCPpr/MPxX
         RxQI4l2IU0P4n6MmUIdxWn1QexU0loIFZ/23M7LxAAshOGUkBW3+d3JcPO1fD+lFII08
         +HnLb52xHtz1z0Sg4MiD7Qa7gdiwrdxK86kBTHHObCC9gF7hHO7bJELwjnraYCGBzPpG
         Pybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZYn5Ce+L0yx8LnAN5tmPGD2JqoQJUOBT07GkqQWBng=;
        b=M/C47u/NL/9BuFrEl1G/F3+irt1A2aeGc2Lqc6eV8tjEpDh/vxWU/uvC49S8MrGF7v
         zrj08rJFJCKfkzbVF2isDFCHTSrjZs8h/GN8EdqSJwWg6ybDZYjnATAJKvtZ1/xhDohy
         tLDU8kOXVaiI2p0ezjUosbW6YmPabt5LkrspV1rlYQof9Mk15BJpHl4hYY7eK33++TEY
         jWZ5BoQi3mPqR2Emva4i2e8qWfJDOH5xTG/w09FO+Smh5wZB/xkaaOWFudV0xwD8Bj8O
         vq5V1GNGouzSTCGclxqHLVB30Iv2HgvoJMNYSImxNkQFW3FafCmNa86mREVoHJtH98QD
         llAw==
X-Gm-Message-State: AOAM530FCpLlFSFC8DPfe9Cf+QG+c4GJTxZqNLj1wPB0++f/lP1gc4HC
        /DI+GvHnyslf15w9XPj0MdW4bI1FSA/8wk+ODS+FzQ==
X-Google-Smtp-Source: ABdhPJyG5EKrUDm90MbScH/89VdYI31kchDTGyATQSzF9IWc/r5yRiq8+wws2poKBu0xdKkbolfeGMMlibLyZuzKnYc=
X-Received: by 2002:ac2:5e90:: with SMTP id b16mr3431873lfq.122.1612561218365;
 Fri, 05 Feb 2021 13:40:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
 <20210205211010.2764627-1-ndesaulniers@google.com> <CA+icZUXkCC9U3PsYzqhzu7BZa-eE2kd53SfX2ODrr+N=QO6VvQ@mail.gmail.com>
In-Reply-To: <CA+icZUXkCC9U3PsYzqhzu7BZa-eE2kd53SfX2ODrr+N=QO6VvQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Feb 2021 13:40:05 -0800
Message-ID: <CAKwvOd=ktdttx5E=_k7B-WuJsic3imOecTUDyaQA9VUpLF45Jw@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Sedat Dilek <sedat.dilek@gmail.com>
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

On Fri, Feb 5, 2021 at 1:17 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 10:10 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
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
> > Yes, I observe this error, too.
> >
> > https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781
> >
> > via v9 of my DWARF v5 series, which should help make this easier to
> > reproduce:
> > https://lore.kernel.org/lkml/CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com/T/#m45ec7e6df4c4b5e9da034b95d7dfc8e2a0c81dac
>
> Thanks Nick for confirming the error.
>
> Ah, I see you passed:
>
> make LLVM=1 LLVM_IAS=1 ...
>
> Can you by chance try with KCFLAGS="-fbinutils-version=2.35"?

$ PATH=/path/to/tot/pahole/build:$PATH make LLVM=1 LLVM_IAS=1 -j72
KCFLAGS="-fbinutils-version=2.35"
...
  BTF     .btf.vmlinux.bin.o
[12919] INT DW_ATE_unsigned_1 Error emitting BTF type
Encountered error while encoding BTF.
...
  LD      vmlinux
  BTFIDS  vmlinux
FAILED: load BTF from vmlinux: Invalid argument
-- 
Thanks,
~Nick Desaulniers
