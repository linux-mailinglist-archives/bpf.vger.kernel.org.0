Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA472CF4B3
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 20:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgLDTYY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 14:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgLDTYX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 14:24:23 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1EC061A4F
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 11:23:43 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id a16so1369536ybh.5
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 11:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a/qDNYPVbfxJkToZrhFD3UgvCnlXQn77CikfMbw/K9E=;
        b=dZ79GbH1NjwE5/ecqHdQr68gy61s4V6+4dB8WQfMnYMhCrhjX9rGg1Qpj3wiLJ7MKk
         Ex8aGHYDgp38nvYAABR2bX7HM17KLF+h3rUufoZiJpUZIft1cWu7TJPYPPLdBBVXxB5V
         pkhzlMMEYEsgj8VTAdM/y76FbYo7DAIT5rDJkcgxtc3/yxcr2G4gqMymJuZNh0eKE5SO
         S9uD/fBiEWomarpgaRMdDOpZXGpRRsXEuQtzwFl/q3C88WhKP7p0oj2TNfHw1MTsl0MV
         iAbvRabHwyFv8cgoBcUnia3GoHOoaOw+OB71G74GZtIU9bYMWaGlijQarPC6yqAlpYCg
         oXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a/qDNYPVbfxJkToZrhFD3UgvCnlXQn77CikfMbw/K9E=;
        b=E29h23IvbiiGqcB0pxNmlQxzulfE/fZIYA86UrPpcKIczRUx8zrE1KrvW2Oow/ECEx
         YSin1MbqomyyDHTm1qdKb5GOXHxRU4iQjFLvCoSqXwvtZIB8dSyq7nsvuTV637utgrXV
         hZlg155r0DmnooLwguLy0kUZ8uJvd40WY7ufx6/cJm4XSyVpkHarRObS3OPu7BUHOL3+
         3K/PlqOT0PfWrd5MyYEfePDDUKstJCP9fKkxV0H6+aVo7q+U2qtEL8xlnWMcaTSkIto5
         KrWPiczlktsJZjAkRp5rYVHU27JKMuKNDlhE8LsziHtK6UxzXKeStQaPt2KD9nn87i6l
         3i3A==
X-Gm-Message-State: AOAM530hseNVf+V7+1eO4/yhAGwJPm61izos4j8oIXqUkcjrmgOhr7wg
        uOylvazda5j9rYyxsBnS8Y/vDai/xNp2ppMwe9I=
X-Google-Smtp-Source: ABdhPJwePxQu5m80tO1lBWHgbGBh67DtCBSo8npPjkyQlGwJnxaP0vFLLki0X3V5auTIiDPFQkA5Pyvk4IHfc7upSvY=
X-Received: by 2002:a25:df8e:: with SMTP id w136mr7670354ybg.230.1607109822478;
 Fri, 04 Dec 2020 11:23:42 -0800 (PST)
MIME-Version: 1.0
References: <87lfeebwpu.fsf@toke.dk> <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
 <87r1o59aoc.fsf@toke.dk> <6801fcdb-932e-c185-22db-89987099b553@fb.com>
In-Reply-To: <6801fcdb-932e-c185-22db-89987099b553@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Dec 2020 11:23:31 -0800
Message-ID: <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     Yonghong Song <yhs@fb.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 4, 2020 at 9:55 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 12/4/20 1:34 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Yonghong Song <yhs@fb.com> writes:
> >
> >> On 12/3/20 9:55 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>> Hi Andrii
> >>>
> >>> I noticed that recent libbpf versions fail to load BPF files compiled
> >>> with old versions of LLVM. E.g., if I compile xdp-tools with LLVM 7 I
> >>> get:
> >>>
> >>> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
> >>> Loading 1 files on interface 'testns'.
> >>> libbpf: loading ../lib/testing/xdp_drop.o
> >>> libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=3D1
> >>> libbpf: sec 'prog': failed to find program symbol at offset 0
> >>> Couldn't open file '../lib/testing/xdp_drop.o': BPF object format inv=
alid
> >>>
> >>> The 'failed to find program symbol' error seems to have been introduc=
ed
> >>> with commit c112239272c6 ("libbpf: Parse multi-function sections into
> >>> multiple BPF programs").
> >>>
> >>> Looking at the object file in question, indeed it seems to not have a=
ny
> >>> function symbols defined:
> >>>
> >>> $  llvm-objdump --syms ../lib/testing/xdp_drop.o
> >>>
> >>> ../lib/testing/xdp_drop.o:  file format elf64-bpf
> >>>
> >>> SYMBOL TABLE:
> >>> 0000000000000000 l       .debug_str 0000000000000000
> >>> 0000000000000037 l       .debug_str 0000000000000000
> >>> 0000000000000042 l       .debug_str 0000000000000000
> >>> 0000000000000068 l       .debug_str 0000000000000000
> >>> 0000000000000071 l       .debug_str 0000000000000000
> >>> 0000000000000076 l       .debug_str 0000000000000000
> >>> 000000000000008a l       .debug_str 0000000000000000
> >>> 0000000000000097 l       .debug_str 0000000000000000
> >>> 00000000000000a3 l       .debug_str 0000000000000000
> >>> 00000000000000ac l       .debug_str 0000000000000000
> >>> 00000000000000b5 l       .debug_str 0000000000000000
> >>> 00000000000000bc l       .debug_str 0000000000000000
> >>> 00000000000000c9 l       .debug_str 0000000000000000
> >>> 00000000000000d4 l       .debug_str 0000000000000000
> >>> 00000000000000dd l       .debug_str 0000000000000000
> >>> 00000000000000e1 l       .debug_str 0000000000000000
> >>> 00000000000000e5 l       .debug_str 0000000000000000
> >>> 00000000000000ea l       .debug_str 0000000000000000
> >>> 00000000000000f0 l       .debug_str 0000000000000000
> >>> 00000000000000f9 l       .debug_str 0000000000000000
> >>> 0000000000000103 l       .debug_str 0000000000000000
> >>> 0000000000000113 l       .debug_str 0000000000000000
> >>> 0000000000000122 l       .debug_str 0000000000000000
> >>> 0000000000000131 l       .debug_str 0000000000000000
> >>> 0000000000000000 l    d  prog       0000000000000000 prog
> >>> 0000000000000000 l    d  .debug_abbrev      0000000000000000 .debug_a=
bbrev
> >>> 0000000000000000 l    d  .debug_info        0000000000000000 .debug_i=
nfo
> >>> 0000000000000000 l    d  .debug_frame       0000000000000000 .debug_f=
rame
> >>> 0000000000000000 l    d  .debug_line        0000000000000000 .debug_l=
ine
> >>> 0000000000000000 g       license    0000000000000000 _license
> >>> 0000000000000000 g       prog       0000000000000000 xdp_drop
> >>>
> >>>
> >>> I assume this is because old LLVM versions simply don't emit that sym=
bol
> >>> information?
>
> Thanks for the below instruction and xdp_drop.c file. I can reproduce
> the issue now.
>
> I added another function 'xdp_drop1' in the same thing. Below is the
> symbol table with llvm7 vs. llvm12.
>
> -bash-4.4$ llvm-readelf -symbols xdp-7.o | grep xdp_drop
>      32: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT     3 xdp_drop
>      33: 0000000000000010     0 NOTYPE  GLOBAL DEFAULT     3 xdp_drop1
>
>    [ 3] prog              PROGBITS        0000000000000000 000040 000020
> 00  AX  0   0  8
>
> -bash-4.4$ llvm-readelf -symbols xdp-12.o | grep xdp_drop
>      32: 0000000000000000    16 FUNC    GLOBAL DEFAULT     3 xdp_drop
>      33: 0000000000000010    16 FUNC    GLOBAL DEFAULT     3 xdp_drop1
> -bash-4.4$
>
>    [ 3] prog              PROGBITS        0000000000000000 000040 000020
> 00  AX  0   0  8
>
>
> Yes, llvm7 does not encode type and size for FUNC's. I guess libbpf can
> change to recognize NOTYPE and use the symbol value (representing the
> offset from the start of the section) and section size to
> calculate the individual function size. This is more complicated than
> elf file providing FUNC type and symbol size directly.

I think we should just face the fact that LLVM7 is way too old to
produce a sensible BPF ELF file layout. We can extend:

libbpf: sec 'prog': failed to find program symbol at offset 0
Couldn't open file '../lib/testing/xdp_drop.o': BPF object format invalid

with a suggestion to upgrade Clang/LLVM to something more recent, if
that would be helpful. But I don't want to add error-prone checks and
assumptions in the already quite complicated logic. Even the kernel
itself maintains that Clang 10+ needs to be used for its compilation.
BPF CO-RE is also not working with older than Clang10, so lots of
people have already upgraded way beyond that.

Speaking of legacy. Toke, can you please update all the samples in
your xdp-tools repo to not use arbitrary sections names. I see
SEC("prog"), where it should really be SEC("xdp"). It sets a bad
example for newcomers, IMO. I'm also going to emit warnings in libbpf
soon for section names that don't follow proper libbpf naming pattern,
so it would be good if you could get ahead of the curve.


>
> Maybe in this case, libbpf can do some sanity check. If there are more
> than one functions in the 'prog' section and they are not marked at FUNC
> type, simply recommend newer compiler and bail out saying this feature
> not available with old llvm?
>
> >>
> >> Could you share xdp_drop.c or other test which I can compile and check
> >> to understand the issue?
> >
> > It's just an empty program returning XDP_DROP:
> >
> > https://github.com/xdp-project/xdp-tools/blob/master/lib/testing/xdp_dr=
op.c
> >
> > I basically just did this on Debian buster:
> >
> > $ sudo apt install gcc-multilib build-essential libpcap-dev libelf-dev =
git llc lld clang gcc-multilib pkt-config m4
> > $ git clone --recurse-submodules https://github.com/xdp-project/xdp-too=
ls
> > $ cd xdp-tools
> > $ LLC=3Dllc-7 ./configure
> > $ make -k
> > $ cd xdp-loader
> > $ sudo ip link add dev testns type veth
> > $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
> >
> > (xdpdump will fail to build with llvm7, but the rest should work)
> >
> > -Toke
> >
