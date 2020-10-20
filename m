Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4829411F
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395213AbgJTRKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395212AbgJTRKb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Oct 2020 13:10:31 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD38FC0613CE;
        Tue, 20 Oct 2020 10:10:30 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h196so2553348ybg.4;
        Tue, 20 Oct 2020 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o8bJWogw44BNpGh0N1sglmlnpyMYbnS/gX2LPW8mIHU=;
        b=LGgXEMsKKo6KaV6pIFg6AM1v/HwY6IBJTH4Wn0IFoYdwG5YpK/pQICa/DXVfaD9fNe
         0DBG5nRFm6xOo+0zm0nsZvwRy/2xrhp2VQsd8pyjoTHbOZHULs4z6ln5D+UdNxtOES5P
         10XBmyZQfNGuH21C4jzSa9zDRkyZ/PcESo83YrSyHj0tpxiApUCMHbFOIThhYMQx3VLe
         /Icfv2QoLk+rhcJs1MmiGVykI3D19QC0uF2kDG23UQINq5wWT7dxqwP2ID5jT4GSPyOr
         7RkXViMiPSAVhMfZdYw7b2MFEZFRZFhA3jwXJuBBTuX8mdzFlsFGqDd8t4hnepEMemy7
         b1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o8bJWogw44BNpGh0N1sglmlnpyMYbnS/gX2LPW8mIHU=;
        b=JGla488CJjinOko7BTCiIrPmLBh95j4i9toa4aCNIK//i9TE1wbdxqNCv/Ru7WFLzk
         g8HzK2PSBQEbP7HZRvxVdHH+fNgVzxZNt7jZIbpM+Qcqn7dGYFfi/oiQq2XQKQowUexk
         /SZv2zDjFtXto3fOi+4qocLFRHMReoac90Pj6DBrxZCEWqNO4OnEPe6IgG/A8+pmFWfa
         fdgvE5lQu6gam07AirJYff9d8GhpdV8cQBrNt+DpqVX7O5AI0/EcnRdOZ5llZWgX62Rs
         WYQvv/9wK0AcLz8/iELPGDRs+1GLb6gDCoY/D7oEJI2FN+btmWpnXX3l43XehNAnGpS9
         rPmA==
X-Gm-Message-State: AOAM530BuHrG+6yniP9ttaHd7Qbfhk3mRh+ErZfMr8Knk5rupgKthuMb
        QEXtrT16CxJTUXdjepj/BPylYYq+7ps8ggIVS+Y=
X-Google-Smtp-Source: ABdhPJxAMn6WL22yz3j0NiswyRDYh5IymMUCTPm7I0g0TPmvZGXOauVy/NFd+jUmnfUzPKDkWe6zFbv1fW+X4nGRIIs=
X-Received: by 2002:a25:5382:: with SMTP id h124mr5265591ybb.425.1603213829960;
 Tue, 20 Oct 2020 10:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org> <20201020122015.GH2294271@kernel.org>
 <CA+khW7gcDPAw4h=0U9mMxTJoaCyOXCMwyw34dcBp1xBKJG6xkg@mail.gmail.com>
In-Reply-To: <CA+khW7gcDPAw4h=0U9mMxTJoaCyOXCMwyw34dcBp1xBKJG6xkg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 20 Oct 2020 10:10:19 -0700
Message-ID: <CAEf4BzYDvvthK_S7EecsTO3HAVXiAf6AqHaiEWbf9+K7sjMiLA@mail.gmail.com>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     Hao Luo <haoluo@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 20, 2020 at 10:05 AM Hao Luo <haoluo@google.com> wrote:
>
> Thanks for reporting this and cc'ing me. I forgot to update the error
> messages when renaming the flags. I will send a patch to fix the error
> message.
>
> The commit
>
> commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> Author:     Hao Luo <haoluo@google.com>
> AuthorDate: Wed Jul 8 13:44:10 2020 -0700
>
>      btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.
>
> encodes kernel global variables into BTF so that bpf programs can
> directly access them. If there is no need to access kernel global
> variables, it's perfectly fine to use '--btf_encode_force' to skip
> encoding bad symbols into BTF, or '--skip_encoding_btf_vars' to skip
> encoding all global vars all together. I will add these info into the
> updated error message.
>
> Also cc bpf folks for attention of this bug.

I've already fixed the message as part of
2e719cca6672 ("btf_encoder: revamp how per-CPU variables are encoded")

It's currently still in the tmp.libbtf_encoder branch in pahole repo.

>
> Hao
>
> On Tue, Oct 20, 2020 at 5:20 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Oct 20, 2020 at 11:01:39AM +0200, Jiri Slaby escreveu:
> > > Hi,
> > >
> > > On 19. 10. 20, 1:18, =C3=89rico Rolim wrote:
> > > > I'm trying to build kernel 5.9.1 for arm64, and my dotconfig has
> > > > `CONFIG_DEBUG_INFO_BTF=3Dy`, which requires pahole for building. Ho=
wever, pahole
> > > > version 1.18 segfaults during the build, as can be seen below:
> > > >
> > > > PAHOLE: Error: Found symbol of zero size when encoding btf (sym:
> > > > '__kvm_nvhe_arm64_ssbd_callback_required', cu:
> > > > 'arch/arm64/kernel/cpu_errata.c').
> > >
> > > The symbol is an alias coming from arch/arm64/kernel/vmlinux.lds:
> > > __kvm_nvhe_arm64_ssbd_callback_required =3D arm64_ssbd_callback_requi=
red;;
> > >
> > > > PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and for=
ce
> > > > emit the btf.
> > > > scripts/link-vmlinux.sh: line 141: 43837 Segmentation fault
> > > > LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
> > > >    LD      .tmp_vmlinux.kallsyms1
> > > >    KSYM    .tmp_vmlinux.kallsyms1.o
> > > >    LD      .tmp_vmlinux.kallsyms2
> > > >    KSYM    .tmp_vmlinux.kallsyms2.o
> > > >    LD      vmlinux
> > > >    BTFIDS  vmlinux
> > > > FAILED: load BTF from vmlinux: Unknown error -2make: ***
> > > > [Makefile:1162: vmlinux] Error 255
> > > >
> > > > It is possible to force the build to continue if
> > > >
> > > >    LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
> > > >
> > > > in scripts/link-vmlinux.sh is changed to
> > > >
> > > >    LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J --btf_encode_force ${1}
> > > >
> > > > The suggested `-j` or `--force` flags don't exist, since they were =
removed in
> > > > [1]. I believe `--btf_encode_force` should be suggested instead.
> > >
> > > Agreed, '--btf_encode_force' makes pahole to proceed without crashes.
> > >
> > > > It should be noted that the same build, but with pahole version 1.1=
7, works
> > > > without issue, so I think this is either a regression in pahole or =
the script
> > > > will need to be changed for newer versions of pahole.
> > >
> > > Yeah, I observe the very same. I reported it at:
> > > https://bugzilla.suse.com/show_bug.cgi?id=3D1177921
> >
> > Would it be possible to try with
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=3Dtmp.=
libbtf_encoder
> > ?
> >
> > This switches to using libbpf for the BTF encoder and may have fixed
> > this problem.
> >
> > - Arnaldo
> >

[...]

> > >
> > >
> > > I suspect:
> > > commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> > > Author:     Hao Luo <haoluo@google.com>
> > > AuthorDate: Wed Jul 8 13:44:10 2020 -0700
> > >
> > >     btf_encoder: Teach pahole to store percpu variables in vmlinux BT=
F.
> > >
> > >
> > > Which added this machinery (btf_elf__add_datasec_type in particular).
> > >
> > > > - [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit=
/pahole.c?h=3Dv1.18&id=3D1abc001417b579b86a9b27ff88c9095d8f498a46
> > > >
> > > > Thanks,
> > > > =C3=89rico
> > > >
> > >
> > >
> > > --
> > > js
> > > suse labs
> >
> > --
> >
> > - Arnaldo
