Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3546D2D211A
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 03:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgLHCsb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 21:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgLHCsb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 21:48:31 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F1EC061749
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 18:47:50 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id w135so9219842ybg.13
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 18:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4WD372dJFO6AwC5JpfsnyvGiFuVVj10n/ri2U/yPHyY=;
        b=aSpXlAHhbtLaGzBBFEjNVzgq2l/a81Z6ly2+lL2gLCNkhSL5DELcPfeO/d4F239l8O
         sbyK5HoZjNLD8wic8k7Cpck5JJ1UKv9YMWWwf1OF2njLKy5KqakLGDPV/dMuNsN0pi87
         6nL1d3l1V9SpvC1nMetD9K2BRcntKFpYvZJcOW+HleTm3J0FUy/HBWVWQhj7m7J4KwbE
         8isCfMRZJACRtzpby7q0U8NlXJuDJ88+42VvZYEnZmrynx0vAyos3mBcejRdlBUKA33M
         vUN/AtaOMJ6oZv1dhXcILC29F63wy//S0TeVuOq99puhuRhtNegLpJUzZrJpo3+ZYaQN
         5Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4WD372dJFO6AwC5JpfsnyvGiFuVVj10n/ri2U/yPHyY=;
        b=p3EblUGji+wrqpaH9TbrUutZX97R3hqLFf0Wu4wpufMLAOBbfOIjPwW9M9IfoatFB+
         dLxvfwxzwZdhS6D0dGSomnIdgSD6qjBpUFg7cVrvaq0Al8PvkFiU/2LA3cbjVTCaPi3V
         4ESSFt/Zu2qEZRDq8n5BIV6qrIKzL5XAFYPX/nKxwhvueMA8uUiJHL99w2k+lt3x6Zic
         kyGPF+TyoSYp5Uc2y0zzMwOqRDx8NtB0UqP3oGPlI4fhsWJ8HeEy7tAbr0BZGH5oBHDU
         0yd238oC66UkAH0Ul5Km/B1nkXIBlWBSjIZHcP0TjiKsIG/xdoFf1HtEnz+qWv6hnlmD
         NVwg==
X-Gm-Message-State: AOAM532M/7rrE3NE3zeys3opvXArvDMF/l3Ms5Y/iQBDZBdwEq3UXNys
        lDHo3rJh3D8vJZDys4PKeSDHCgXVtedhA1rr4Dj/BEiPynE=
X-Google-Smtp-Source: ABdhPJywyL7rSo6ATIeHln17ExbCyuhO3mHItGD3yGxoFtfgSewj5OCvTlFpTQBRYB0du4fzijY4HcmKckUHSTIS2IQ=
X-Received: by 2002:a25:d44:: with SMTP id 65mr15160167ybn.260.1607395670148;
 Mon, 07 Dec 2020 18:47:50 -0800 (PST)
MIME-Version: 1.0
References: <87lfeebwpu.fsf@toke.dk> <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
 <87r1o59aoc.fsf@toke.dk> <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com> <875z5d7ufl.fsf@toke.dk>
In-Reply-To: <875z5d7ufl.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Dec 2020 18:47:39 -0800
Message-ID: <CAEf4Bzb=zi6ew3fgAg29ZB0tcBw8xfEX-pRuMeAyYBiXp5ewTw@mail.gmail.com>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 3:00 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Dec 4, 2020 at 9:55 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 12/4/20 1:34 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> > Yonghong Song <yhs@fb.com> writes:
> >> >
> >> >> On 12/3/20 9:55 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >>> Hi Andrii
> >> >>>
> >> >>> I noticed that recent libbpf versions fail to load BPF files compi=
led
> >> >>> with old versions of LLVM. E.g., if I compile xdp-tools with LLVM =
7 I
> >> >>> get:
> >> >>>
> >> >>> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
> >> >>> Loading 1 files on interface 'testns'.
> >> >>> libbpf: loading ../lib/testing/xdp_drop.o
> >> >>> libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=3D1
> >> >>> libbpf: sec 'prog': failed to find program symbol at offset 0
> >> >>> Couldn't open file '../lib/testing/xdp_drop.o': BPF object format =
invalid
> >> >>>
> >> >>> The 'failed to find program symbol' error seems to have been intro=
duced
> >> >>> with commit c112239272c6 ("libbpf: Parse multi-function sections i=
nto
> >> >>> multiple BPF programs").
> >> >>>
> >> >>> Looking at the object file in question, indeed it seems to not hav=
e any
> >> >>> function symbols defined:
> >> >>>
> >> >>> $  llvm-objdump --syms ../lib/testing/xdp_drop.o
> >> >>>
> >> >>> ../lib/testing/xdp_drop.o:  file format elf64-bpf
> >> >>>
> >> >>> SYMBOL TABLE:
> >> >>> 0000000000000000 l       .debug_str 0000000000000000
> >> >>> 0000000000000037 l       .debug_str 0000000000000000
> >> >>> 0000000000000042 l       .debug_str 0000000000000000
> >> >>> 0000000000000068 l       .debug_str 0000000000000000
> >> >>> 0000000000000071 l       .debug_str 0000000000000000
> >> >>> 0000000000000076 l       .debug_str 0000000000000000
> >> >>> 000000000000008a l       .debug_str 0000000000000000
> >> >>> 0000000000000097 l       .debug_str 0000000000000000
> >> >>> 00000000000000a3 l       .debug_str 0000000000000000
> >> >>> 00000000000000ac l       .debug_str 0000000000000000
> >> >>> 00000000000000b5 l       .debug_str 0000000000000000
> >> >>> 00000000000000bc l       .debug_str 0000000000000000
> >> >>> 00000000000000c9 l       .debug_str 0000000000000000
> >> >>> 00000000000000d4 l       .debug_str 0000000000000000
> >> >>> 00000000000000dd l       .debug_str 0000000000000000
> >> >>> 00000000000000e1 l       .debug_str 0000000000000000
> >> >>> 00000000000000e5 l       .debug_str 0000000000000000
> >> >>> 00000000000000ea l       .debug_str 0000000000000000
> >> >>> 00000000000000f0 l       .debug_str 0000000000000000
> >> >>> 00000000000000f9 l       .debug_str 0000000000000000
> >> >>> 0000000000000103 l       .debug_str 0000000000000000
> >> >>> 0000000000000113 l       .debug_str 0000000000000000
> >> >>> 0000000000000122 l       .debug_str 0000000000000000
> >> >>> 0000000000000131 l       .debug_str 0000000000000000
> >> >>> 0000000000000000 l    d  prog       0000000000000000 prog
> >> >>> 0000000000000000 l    d  .debug_abbrev      0000000000000000 .debu=
g_abbrev
> >> >>> 0000000000000000 l    d  .debug_info        0000000000000000 .debu=
g_info
> >> >>> 0000000000000000 l    d  .debug_frame       0000000000000000 .debu=
g_frame
> >> >>> 0000000000000000 l    d  .debug_line        0000000000000000 .debu=
g_line
> >> >>> 0000000000000000 g       license    0000000000000000 _license
> >> >>> 0000000000000000 g       prog       0000000000000000 xdp_drop
> >> >>>
> >> >>>
> >> >>> I assume this is because old LLVM versions simply don't emit that =
symbol
> >> >>> information?
> >>
> >> Thanks for the below instruction and xdp_drop.c file. I can reproduce
> >> the issue now.
> >>
> >> I added another function 'xdp_drop1' in the same thing. Below is the
> >> symbol table with llvm7 vs. llvm12.
> >>
> >> -bash-4.4$ llvm-readelf -symbols xdp-7.o | grep xdp_drop
> >>      32: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT     3 xdp_drop
> >>      33: 0000000000000010     0 NOTYPE  GLOBAL DEFAULT     3 xdp_drop1
> >>
> >>    [ 3] prog              PROGBITS        0000000000000000 000040 0000=
20
> >> 00  AX  0   0  8
> >>
> >> -bash-4.4$ llvm-readelf -symbols xdp-12.o | grep xdp_drop
> >>      32: 0000000000000000    16 FUNC    GLOBAL DEFAULT     3 xdp_drop
> >>      33: 0000000000000010    16 FUNC    GLOBAL DEFAULT     3 xdp_drop1
> >> -bash-4.4$
> >>
> >>    [ 3] prog              PROGBITS        0000000000000000 000040 0000=
20
> >> 00  AX  0   0  8
> >>
> >>
> >> Yes, llvm7 does not encode type and size for FUNC's. I guess libbpf ca=
n
> >> change to recognize NOTYPE and use the symbol value (representing the
> >> offset from the start of the section) and section size to
> >> calculate the individual function size. This is more complicated than
> >> elf file providing FUNC type and symbol size directly.
> >
> > I think we should just face the fact that LLVM7 is way too old to
> > produce a sensible BPF ELF file layout. We can extend:
> >
> > libbpf: sec 'prog': failed to find program symbol at offset 0
> > Couldn't open file '../lib/testing/xdp_drop.o': BPF object format inval=
id
> >
> > with a suggestion to upgrade Clang/LLVM to something more recent, if
> > that would be helpful.
> >
> > But I don't want to add error-prone checks and assumptions in the
> > already quite complicated logic. Even the kernel itself maintains that
> > Clang 10+ needs to be used for its compilation. BPF CO-RE is also not
> > working with older than Clang10, so lots of people have already
> > upgraded way beyond that.
>
> Wait, what? This is a regression that *breaks people's programs* on
> compiler versions that are still very much in the wild! I mean, fine if
> you don't want to support new features on such files, but then surely we
> can at least revert back to the old behaviour?

This is clearly a bug in LLVM7, which didn't produce correct ELF
symbols, do we agree on that? libbpf used to handle such invalid ELF
files *by accident* until it changed its internal logic to be more
strict in v0.2. It became more strict and doesn't work with such
invalid ELF files anymore. Does it need to add extra quirks to support
such broken ELF? I don't think so.

Surely, users that can't upgrade LLVM7 to something less ancient, can
stick to libbpf v0.1, that was lenient enough to accept such invalid
ELF files. libbpf v0.2 was released more than a month ago, and so far
you are the only one who noticed this "regression". So hopefully it's
not super annoying to people and they would be accommodating enough to
use more up to date compiler (and save themselves lots of trouble
along the way).

>
> > Speaking of legacy. Toke, can you please update all the samples in
> > your xdp-tools repo to not use arbitrary sections names. I see
> > SEC("prog"), where it should really be SEC("xdp"). It sets a bad
> > example for newcomers, IMO.
>
> I used "prog" because that's what iproute2 looks for if you don't supply

Ok.

> a section name, so it makes it convenient to load programs with 'ip'
> without supplying the section name. However, I do realise this is not
> the best of reasons, and I am not opposed to changing it. However...
>
> > I'm also going to emit warnings in libbpf soon for section names that
> > don't follow proper libbpf naming pattern, so it would be good if you
> > could get ahead of the curve.
>
> ...this sounds like just another way to annoy users by breaking things
> that were working before? :/

It won't break, libbpf will emit a warning about the need to use
proper section name format, which will start to be enforced only with
major version bump. So that will give users plenty of time to make
sure their BPF programs are compatible with stricter libbpf.

>
> -Toke
>
