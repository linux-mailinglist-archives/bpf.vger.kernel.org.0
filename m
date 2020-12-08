Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94FB2D324A
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 19:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgLHSkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 13:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgLHSkg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 13:40:36 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A28BC061749
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 10:39:56 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id w135so11393072ybg.13
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 10:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RR1N0hwEGy9XXDADWx9wdjc9QjNvbbJc8CvWdtWU6Aw=;
        b=eJWeoNyL3iOyFshQc2tF9Y5KxZTf5PNpDJzgpy3Q7ubaPe6lYfc1wY9t3rNa+JaAnu
         wcudX3iwW2r9yqMpuLyiv3wYfHPGIdyFYrp9Q7wtIlWhvqhIAwJfguUAp9Y+Jta8010w
         5zZKvb2FD4xioPQFhkGuVmuX/sFqpQyLgaBKTeR0jW3dN2HJPlx6NEOaQqDS7A9jh8Rm
         4V0TMzosPu06KmqYUn2SnUVKdB6HdK7uzX8lt/qN+z6aQvWrdUqNKbY0Asmix3HGqHmO
         3dl+kfm6+D83eNFbRA7VsCp3vm0CBu+yoJRF8fWw25jOF5lCBI0PcYOPKzcMq4GO3FYD
         lhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RR1N0hwEGy9XXDADWx9wdjc9QjNvbbJc8CvWdtWU6Aw=;
        b=CiHuMF66mrprU9Zx8vtCWtqimEv+9QUOowvfK62WL4X/wmcZpWNtugFXecesvci+Wi
         mcU6UpO72Mz8vEg2EPHaYa0Iiky58oQDDME6Xrf0cP1YfWOEEX89W3Z8JaC3fFpZMvWQ
         alt/l3IKplQhWe6Xb/hL3CG+orWAUaxADXqCZIIMV9RYeE+x0/+XZdGCfk1MAoqTj91K
         32LMlIWEX2SAzG7u3f70Teak0yFuGWPGVoMb+oqap0tTRnNpasMNzMpGzy4nwVeG/aem
         ifTnKenTOUvHh4X392IJxGgXfty/wb2PmEUUZBwC4ZaLXUsoKjdTV/DWlYvf1GxH01Wb
         hQdA==
X-Gm-Message-State: AOAM530snydJwNp0srRIRPiL5QEA6KMSWj18g55lcxRyUruby1/U/Gdj
        XGM8wMUMhM1bkTfCBfxKpwIk92TNU84xc0+1WwB623yZCLo=
X-Google-Smtp-Source: ABdhPJwFbtop3vamh70asevQ2uUQLJlMPr2x8L0xxTAJ6FwmdmRfJN2yQQ/g3B86wqsjNJxYjiZ/5NNW/RIqHTqBTP0=
X-Received: by 2002:a25:c089:: with SMTP id c131mr30792966ybf.510.1607452794849;
 Tue, 08 Dec 2020 10:39:54 -0800 (PST)
MIME-Version: 1.0
References: <87lfeebwpu.fsf@toke.dk> <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
 <87r1o59aoc.fsf@toke.dk> <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk> <CAEf4Bzb=zi6ew3fgAg29ZB0tcBw8xfEX-pRuMeAyYBiXp5ewTw@mail.gmail.com>
 <87czzkifef.fsf@toke.dk>
In-Reply-To: <87czzkifef.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Dec 2020 10:39:44 -0800
Message-ID: <CAEf4Bzb-b8eye6pi5JRPAL439Yx0FPcd64WwpQz57GPra7Jr_w@mail.gmail.com>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 8, 2020 at 5:41 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redha=
t.com> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Mon, Dec 7, 2020 at 3:00 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
> >>
> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> >>
> >> > On Fri, Dec 4, 2020 at 9:55 AM Yonghong Song <yhs@fb.com> wrote:
> >> >>
> >> >>
> >> >>
> >> >> On 12/4/20 1:34 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >> > Yonghong Song <yhs@fb.com> writes:
> >> >> >
> >> >> >> On 12/3/20 9:55 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> >> >>> Hi Andrii
> >> >> >>>
> >> >> >>> I noticed that recent libbpf versions fail to load BPF files co=
mpiled
> >> >> >>> with old versions of LLVM. E.g., if I compile xdp-tools with LL=
VM 7 I
> >> >> >>> get:
> >> >> >>>
> >> >> >>> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
> >> >> >>> Loading 1 files on interface 'testns'.
> >> >> >>> libbpf: loading ../lib/testing/xdp_drop.o
> >> >> >>> libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=3D=
1
> >> >> >>> libbpf: sec 'prog': failed to find program symbol at offset 0
> >> >> >>> Couldn't open file '../lib/testing/xdp_drop.o': BPF object form=
at invalid
> >> >> >>>
> >> >> >>> The 'failed to find program symbol' error seems to have been in=
troduced
> >> >> >>> with commit c112239272c6 ("libbpf: Parse multi-function section=
s into
> >> >> >>> multiple BPF programs").
> >> >> >>>
> >> >> >>> Looking at the object file in question, indeed it seems to not =
have any
> >> >> >>> function symbols defined:
> >> >> >>>
> >> >> >>> $  llvm-objdump --syms ../lib/testing/xdp_drop.o
> >> >> >>>
> >> >> >>> ../lib/testing/xdp_drop.o:  file format elf64-bpf
> >> >> >>>
> >> >> >>> SYMBOL TABLE:
> >> >> >>> 0000000000000000 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000037 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000042 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000068 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000071 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000076 l       .debug_str 0000000000000000
> >> >> >>> 000000000000008a l       .debug_str 0000000000000000
> >> >> >>> 0000000000000097 l       .debug_str 0000000000000000
> >> >> >>> 00000000000000a3 l       .debug_str 0000000000000000
> >> >> >>> 00000000000000ac l       .debug_str 0000000000000000
> >> >> >>> 00000000000000b5 l       .debug_str 0000000000000000
> >> >> >>> 00000000000000bc l       .debug_str 0000000000000000
> >> >> >>> 00000000000000c9 l       .debug_str 0000000000000000
> >> >> >>> 00000000000000d4 l       .debug_str 0000000000000000
> >> >> >>> 00000000000000dd l       .debug_str 0000000000000000
> >> >> >>> 00000000000000e1 l       .debug_str 0000000000000000
> >> >> >>> 00000000000000e5 l       .debug_str 0000000000000000
> >> >> >>> 00000000000000ea l       .debug_str 0000000000000000
> >> >> >>> 00000000000000f0 l       .debug_str 0000000000000000
> >> >> >>> 00000000000000f9 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000103 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000113 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000122 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000131 l       .debug_str 0000000000000000
> >> >> >>> 0000000000000000 l    d  prog       0000000000000000 prog
> >> >> >>> 0000000000000000 l    d  .debug_abbrev      0000000000000000 .d=
ebug_abbrev
> >> >> >>> 0000000000000000 l    d  .debug_info        0000000000000000 .d=
ebug_info
> >> >> >>> 0000000000000000 l    d  .debug_frame       0000000000000000 .d=
ebug_frame
> >> >> >>> 0000000000000000 l    d  .debug_line        0000000000000000 .d=
ebug_line
> >> >> >>> 0000000000000000 g       license    0000000000000000 _license
> >> >> >>> 0000000000000000 g       prog       0000000000000000 xdp_drop
> >> >> >>>
> >> >> >>>
> >> >> >>> I assume this is because old LLVM versions simply don't emit th=
at symbol
> >> >> >>> information?
> >> >>
> >> >> Thanks for the below instruction and xdp_drop.c file. I can reprodu=
ce
> >> >> the issue now.
> >> >>
> >> >> I added another function 'xdp_drop1' in the same thing. Below is th=
e
> >> >> symbol table with llvm7 vs. llvm12.
> >> >>
> >> >> -bash-4.4$ llvm-readelf -symbols xdp-7.o | grep xdp_drop
> >> >>      32: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT     3 xdp_dr=
op
> >> >>      33: 0000000000000010     0 NOTYPE  GLOBAL DEFAULT     3 xdp_dr=
op1
> >> >>
> >> >>    [ 3] prog              PROGBITS        0000000000000000 000040 0=
00020
> >> >> 00  AX  0   0  8
> >> >>
> >> >> -bash-4.4$ llvm-readelf -symbols xdp-12.o | grep xdp_drop
> >> >>      32: 0000000000000000    16 FUNC    GLOBAL DEFAULT     3 xdp_dr=
op
> >> >>      33: 0000000000000010    16 FUNC    GLOBAL DEFAULT     3 xdp_dr=
op1
> >> >> -bash-4.4$
> >> >>
> >> >>    [ 3] prog              PROGBITS        0000000000000000 000040 0=
00020
> >> >> 00  AX  0   0  8
> >> >>
> >> >>
> >> >> Yes, llvm7 does not encode type and size for FUNC's. I guess libbpf=
 can
> >> >> change to recognize NOTYPE and use the symbol value (representing t=
he
> >> >> offset from the start of the section) and section size to
> >> >> calculate the individual function size. This is more complicated th=
an
> >> >> elf file providing FUNC type and symbol size directly.
> >> >
> >> > I think we should just face the fact that LLVM7 is way too old to
> >> > produce a sensible BPF ELF file layout. We can extend:
> >> >
> >> > libbpf: sec 'prog': failed to find program symbol at offset 0
> >> > Couldn't open file '../lib/testing/xdp_drop.o': BPF object format in=
valid
> >> >
> >> > with a suggestion to upgrade Clang/LLVM to something more recent, if
> >> > that would be helpful.
> >> >
> >> > But I don't want to add error-prone checks and assumptions in the
> >> > already quite complicated logic. Even the kernel itself maintains th=
at
> >> > Clang 10+ needs to be used for its compilation. BPF CO-RE is also no=
t
> >> > working with older than Clang10, so lots of people have already
> >> > upgraded way beyond that.
> >>
> >> Wait, what? This is a regression that *breaks people's programs* on
> >> compiler versions that are still very much in the wild! I mean, fine i=
f
> >> you don't want to support new features on such files, but then surely =
we
> >> can at least revert back to the old behaviour?
> >
> > This is clearly a bug in LLVM7, which didn't produce correct ELF
> > symbols, do we agree on that? libbpf used to handle such invalid ELF
> > files *by accident* until it changed its internal logic to be more
> > strict in v0.2. It became more strict and doesn't work with such
> > invalid ELF files anymore. Does it need to add extra quirks to support
> > such broken ELF? I don't think so.
>
> I don't know enough about the intricacies of the ELF format to say, but
> I believe you when you say it's a bug. However, that doesn't change the
> fact that from a user's PoV, something that was working before is now
> broken, with the only change being a newer libbpf.
>
> This is not a theoretical concern, BTW, I discovered this due to
> feedback from a partner that we've been pushing to adopt libbpf. When
> they finally tried it out, the first thing they noticed is that their
> programs wouldn't load due to this issue.
>
> Sure, I can tell them to just upgrade their toolchain (and I will), but
> that still means we're back to "in order to use this library, you should
> expect to keep chasing the latest version of the entire toolchain". And

Migrating from LLVM7 to something like LLVM10 or LLVM11 (not asking
for not-yet-released LLVM12) hardly qualifies as "chasing the latest
version". LLVM8 or LLVM9 might work for their simple use case either,
I haven't checked. Just please don't use the extremely outdated
toolchain that is (now) known to be broken. That's all I'm asking.

> this is a much harder sell than "this is a stable library and upstream
> takes backwards compatibility very serious", which I *thought* was the
> expectation.

That's still true and I'd rather not go over the same discussion
again. But libbpf is also not a dumpster of work-arounds for all
possible bugs in the kernel and compiler. Libbpf does a lot of that
for backwards compatibility reasons, no need to deal with quirks of
buggy and very outdated compilers (and kernels, if there are obvious
bugs like this).

>
> > Surely, users that can't upgrade LLVM7 to something less ancient, can
> > stick to libbpf v0.1, that was lenient enough to accept such invalid
> > ELF files. libbpf v0.2 was released more than a month ago, and so far
> > you are the only one who noticed this "regression". So hopefully it's
> > not super annoying to people and they would be accommodating enough to
> > use more up to date compiler (and save themselves lots of trouble
> > along the way).
>
> Oh, boy, do I envy your adoption rate for new versions! In my world I
> would expect that by one month a few people who are very early adopters
> have started noticing and maybe thinking about testing the new version :)

In practice with the new libbpf releases I've been getting reports
about something broken within a few days. So yeah, I'm a lucky guy, I
suppose.

>
> >> > Speaking of legacy. Toke, can you please update all the samples in
> >> > your xdp-tools repo to not use arbitrary sections names. I see
> >> > SEC("prog"), where it should really be SEC("xdp"). It sets a bad
> >> > example for newcomers, IMO.
> >>
> >> I used "prog" because that's what iproute2 looks for if you don't supp=
ly
> >
> > Ok.
>
> Fixed now, BTW:
> https://github.com/xdp-project/xdp-tools/commit/83ab8aa1c29408aac842bebe7=
04aa47ec5dc5bc3

Thanks!

>
> >> a section name, so it makes it convenient to load programs with 'ip'
> >> without supplying the section name. However, I do realise this is not
> >> the best of reasons, and I am not opposed to changing it. However...
> >>
> >> > I'm also going to emit warnings in libbpf soon for section names tha=
t
> >> > don't follow proper libbpf naming pattern, so it would be good if yo=
u
> >> > could get ahead of the curve.
> >>
> >> ...this sounds like just another way to annoy users by breaking things
> >> that were working before? :/
> >
> > It won't break, libbpf will emit a warning about the need to use
> > proper section name format, which will start to be enforced only with
> > major version bump. So that will give users plenty of time to make
> > sure their BPF programs are compatible with stricter libbpf.
>
> Well see above re: different expectations for "plenty of time". But OK,
> maybe this isn't as bad as I figured at first glance :)

So far libbpf releases were timed to Linux releases, so roughly one
every 2 months. libbpf 1.0 is unlikely to come sooner than 2 releases
out. So it's not like 2 weeks notice, right? Waiting for a year or
more seems excessive as well.

>
> -Toke
>
