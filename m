Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A044829410C
	for <lists+bpf@lfdr.de>; Tue, 20 Oct 2020 19:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395124AbgJTRFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Oct 2020 13:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395092AbgJTRFE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Oct 2020 13:05:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBCDC0613CE
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 10:05:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so3820943ejw.7
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2020 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C3MYOAyER7eRaYplTmQSfHj/vWn2iuqLFvr+uBlCcqo=;
        b=V/PAKYc4GxLuXpfbfMJ0VbWKyR+7WMwU1gnH/2YMxkbSDus2F5e2kUtOPOxVoC8ZT8
         9opgnVcA6VPuNqboTwrxIqtb5hjkW48s8OtJ/zJ8t+NRCaa5LQM9yC5ONYmtVU3Q6GUU
         mUvklSgRgWxehghpVoRtCUSbLLAk/9e3gxvbiH5DVnaHE4OxUZyeQd2/i+x2d6gwMNM+
         mh3ZvufUXbZyG9uA8NR096OFziC3Fpj3ssV+svvNfvLNiybSLx7RV7wcnOnwtbbnUtiI
         4addjtvIv6hf+ooUbEpB6GD/qhE1nyN6d4TqRjxQp/zE4WZPCwAMncWphqcYGYhZDtuO
         Nvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C3MYOAyER7eRaYplTmQSfHj/vWn2iuqLFvr+uBlCcqo=;
        b=uJ3oPqwUX6lNeFK6PlLc1qh8gUGnuRUK1XnzrouMux+Y9IbpTHqpft5Af+eMJQPD1T
         SWFry5/e7WdFNnag+/9W6avUV6aZDUCBHZe5bc2chZCbf5BaTKtGbtnAR8Wlru8hYZei
         AyuK4rJCMuwJreuzkSuyETQNOZ4aqiwpj+vBSb+SC4o5OcW+VnWH7hEUdcgLs2MAdpKB
         5/9b8xP/jvNJVP8Bwe80KLmxmF9pcGuyoqIAgwoit2WwJ9YYaEzd+clgvc4dASOWZET9
         oFD3BviVZ5SXfFLx8LgcwCq4oEp5lHnoYpwUqU5bg/uDHT4DoFqg3ujMJS5NR5G0OaP6
         raPw==
X-Gm-Message-State: AOAM530lvcFs7bAbIZrP3qlqP7Ns7ipVmDllusf20v302QyhkR8R0H6s
        LRGDNS1d8XghyJ1hZuig+7W2pJgoBX/RVNpErM04XQ==
X-Google-Smtp-Source: ABdhPJyt73d14bElB4Yml6R/uQKVIY6si4kfCKZNS+rE/uUq0/7JvG6q54/gPiIEvdHlSx8R8jv2pJht0NAHu9RBG+s=
X-Received: by 2002:a17:906:4e19:: with SMTP id z25mr4369995eju.44.1603213501911;
 Tue, 20 Oct 2020 10:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFDeuWM7D-Upi84-JovKa3g8Y_4fjv65jND3--e9u-tER3WmVA@mail.gmail.com>
 <82b757bb-1f49-ab02-2f4b-89577d56fec9@kernel.org> <20201020122015.GH2294271@kernel.org>
In-Reply-To: <20201020122015.GH2294271@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 20 Oct 2020 10:04:50 -0700
Message-ID: <CA+khW7gcDPAw4h=0U9mMxTJoaCyOXCMwyw34dcBp1xBKJG6xkg@mail.gmail.com>
Subject: Re: Segfault in pahole 1.18 when building kernel 5.9.1 for arm64
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?B?w4lyaWNvIFJvbGlt?= <erico.erc@gmail.com>,
        dwarves@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for reporting this and cc'ing me. I forgot to update the error
messages when renaming the flags. I will send a patch to fix the error
message.

The commit

commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
Author:     Hao Luo <haoluo@google.com>
AuthorDate: Wed Jul 8 13:44:10 2020 -0700

     btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.

encodes kernel global variables into BTF so that bpf programs can
directly access them. If there is no need to access kernel global
variables, it's perfectly fine to use '--btf_encode_force' to skip
encoding bad symbols into BTF, or '--skip_encoding_btf_vars' to skip
encoding all global vars all together. I will add these info into the
updated error message.

Also cc bpf folks for attention of this bug.

Hao

On Tue, Oct 20, 2020 at 5:20 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Oct 20, 2020 at 11:01:39AM +0200, Jiri Slaby escreveu:
> > Hi,
> >
> > On 19. 10. 20, 1:18, =C3=89rico Rolim wrote:
> > > I'm trying to build kernel 5.9.1 for arm64, and my dotconfig has
> > > `CONFIG_DEBUG_INFO_BTF=3Dy`, which requires pahole for building. Howe=
ver, pahole
> > > version 1.18 segfaults during the build, as can be seen below:
> > >
> > > PAHOLE: Error: Found symbol of zero size when encoding btf (sym:
> > > '__kvm_nvhe_arm64_ssbd_callback_required', cu:
> > > 'arch/arm64/kernel/cpu_errata.c').
> >
> > The symbol is an alias coming from arch/arm64/kernel/vmlinux.lds:
> > __kvm_nvhe_arm64_ssbd_callback_required =3D arm64_ssbd_callback_require=
d;;
> >
> > > PAHOLE: Error: Use '-j' or '--force' to ignore such symbols and force
> > > emit the btf.
> > > scripts/link-vmlinux.sh: line 141: 43837 Segmentation fault
> > > LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
> > >    LD      .tmp_vmlinux.kallsyms1
> > >    KSYM    .tmp_vmlinux.kallsyms1.o
> > >    LD      .tmp_vmlinux.kallsyms2
> > >    KSYM    .tmp_vmlinux.kallsyms2.o
> > >    LD      vmlinux
> > >    BTFIDS  vmlinux
> > > FAILED: load BTF from vmlinux: Unknown error -2make: ***
> > > [Makefile:1162: vmlinux] Error 255
> > >
> > > It is possible to force the build to continue if
> > >
> > >    LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J ${1}
> > >
> > > in scripts/link-vmlinux.sh is changed to
> > >
> > >    LLVM_OBJCOPY=3D${OBJCOPY} ${PAHOLE} -J --btf_encode_force ${1}
> > >
> > > The suggested `-j` or `--force` flags don't exist, since they were re=
moved in
> > > [1]. I believe `--btf_encode_force` should be suggested instead.
> >
> > Agreed, '--btf_encode_force' makes pahole to proceed without crashes.
> >
> > > It should be noted that the same build, but with pahole version 1.17,=
 works
> > > without issue, so I think this is either a regression in pahole or th=
e script
> > > will need to be changed for newer versions of pahole.
> >
> > Yeah, I observe the very same. I reported it at:
> > https://bugzilla.suse.com/show_bug.cgi?id=3D1177921
>
> Would it be possible to try with
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=3Dtmp.li=
bbtf_encoder
> ?
>
> This switches to using libbpf for the BTF encoder and may have fixed
> this problem.
>
> - Arnaldo
>
> > The backtrace:
> > > (gdb) where
> > > #0  __memmove_sse2_unaligned_erms () at
> > ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:300
> > > #1  0x00007ffff7f78346 in memcpy (__len=3D<optimized out>, __src=3D<o=
ptimized
> > out>, __dest=3D<optimized out>, __dest=3D<optimized out>, __src=3D<opti=
mized out>,
> > __len=3D<optimized out>) at /usr/include/bits/string_fortified.h:34
> > > #2  gobuffer__add (gb=3D0x555555569aa0, s=3D0x7fffffffb50c, len=3D12)=
 at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/gobuffer.c:87
> > > #3  0x00007ffff7f8671f in btf_elf__add_datasec_type
> > (btfe=3Dbtfe@entry=3D0x555555569a40,
> > section_name=3Dsection_name@entry=3D0x7ffff7fa43ad ".data..percpu",
> > var_secinfo_buf=3Dvar_secinfo_buf@entry=3D0x555555569ac0) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf.c:721
> > > #4  0x00007ffff7f8d766 in btf_elf__encode (flags=3D0 '\000',
> > btfe=3D0x555555569a40) at /usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf=
.c:857
> > > #5  btf_elf__encode (btfe=3D0x555555569a40, flags=3D<optimized out>) =
at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/libbtf.h:71
> > > #6  0x00007ffff7f7fc70 in btf_encoder__encode () at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/btf_encoder.c:213
> > > #7  0x00007ffff7f80d17 in cu__encode_btf (cu=3D0x55555638d9b0, verbos=
e=3D0,
> > force=3Dfalse, skip_encoding_vars=3Dfalse) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/btf_encoder.c:255
> > > #8  0x000055555555ac4d in pahole_stealer (cu=3D0x55555638d9b0,
> > conf_load=3D<optimized out>) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/pahole.c:2366
> > > #9  0x00007ffff7f89dab in finalize_cu (cus=3D0x5555555622d0,
> > dcu=3D0x7fffffffd080, conf=3D0x5555555610e0 <conf_load>, cu=3D0x5555563=
8d9b0) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2473
> > > #10 finalize_cu_immediately (conf=3D0x5555555610e0 <conf_load>,
> > dcu=3D0x7fffffffd080, cu=3D0x55555638d9b0, cus=3D0x5555555622d0) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2317
> > > #11 cus__load_module (cus=3Dcus@entry=3D0x5555555622d0, conf=3D0x5555=
555610e0
> > <conf_load>, mod=3Dmod@entry=3D0x555555564760, dw=3D0x555555565960,
> > elf=3Delf@entry=3D0x555555562360, filename=3D0x7fffffffe846 "ss") at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2473
> > > #12 0x00007ffff7f8a0f1 in cus__process_dwflmod (dwflmod=3D0x555555564=
760,
> > userdata=3D<optimized out>, name=3D<optimized out>, base=3D<optimized o=
ut>,
> > arg=3D0x7fffffffe1b0) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2518
> > > #13 0x00007ffff7d4f571 in dwfl_getmodules () from /usr/lib64/libdw.so=
.1
> > > #14 0x00007ffff7f823ed in cus__process_file (filename=3D0x7fffffffe84=
6 "ss",
> > fd=3D3, conf=3D<optimized out>, cus=3D0x5555555622d0) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2571
> > > #15 dwarf__load_file (cus=3D0x5555555622d0, conf=3D<optimized out>,
> > filename=3D0x7fffffffe846 "ss") at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarf_loader.c:2588
> > > #16 0x00007ffff7f76771 in cus__load_file (cus=3Dcus@entry=3D0x5555555=
622d0,
> > conf=3Dconf@entry=3D0x5555555610e0 <conf_load>, filename=3D0x7fffffffe8=
46 "ss") at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarves.c:1958
> > > #17 0x00007ffff7f798a8 in cus__load_files (cus=3D0x5555555622d0,
> > conf=3D0x5555555610e0 <conf_load>, filenames=3D0x7fffffffe518) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/dwarves.c:2316
> > > #18 0x00005555555576fc in main (argc=3D3, argv=3D0x7fffffffe508) at
> > /usr/src/debug/dwarves-1.18-1.1.x86_64/pahole.c:2687
> >
> >
> > I suspect:
> > commit f3d9054ba8ff1df0fc44e507e3a01c0964cabd42
> > Author:     Hao Luo <haoluo@google.com>
> > AuthorDate: Wed Jul 8 13:44:10 2020 -0700
> >
> >     btf_encoder: Teach pahole to store percpu variables in vmlinux BTF.
> >
> >
> > Which added this machinery (btf_elf__add_datasec_type in particular).
> >
> > > - [1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/p=
ahole.c?h=3Dv1.18&id=3D1abc001417b579b86a9b27ff88c9095d8f498a46
> > >
> > > Thanks,
> > > =C3=89rico
> > >
> >
> >
> > --
> > js
> > suse labs
>
> --
>
> - Arnaldo
