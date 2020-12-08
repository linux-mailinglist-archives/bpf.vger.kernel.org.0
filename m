Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFEB2D3660
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 23:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgLHWkN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 17:40:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgLHWkN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 17:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607467124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PemhUXF6Fu0rU5mxUg5KHVvpDzfaZjWrXsz7h6lWqEg=;
        b=fbebu61N6NnEqlO+M9KDNeHeRHtI3ifUTPz9UzrYUuzBFSG7OjH546Q/0ezbAPEp5r2XgU
        A47jd4JgcNbtv2NxyV1Q0Iwa6QTnabGiZl/e/Duy9X0ndaq+y4FqOzls37SIUUDi8G6I/B
        49CkxuD3tbC65nUc0zaB4W5TzzhYEcM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-_98zJEIrM_GrOFWC-IVNag-1; Tue, 08 Dec 2020 17:38:43 -0500
X-MC-Unique: _98zJEIrM_GrOFWC-IVNag-1
Received: by mail-wr1-f72.google.com with SMTP id v5so23386wrr.0
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 14:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PemhUXF6Fu0rU5mxUg5KHVvpDzfaZjWrXsz7h6lWqEg=;
        b=g3sZOGjWilcu7uwkApNA6Ab9q0EJZXes9t6HT/xiJaUaa+Gj+acgLVOcj9cS3uWw8r
         n7/HdjhCujv6mevp22faGHlIp7LuzOvcAGOhkfU3Fha+8dNY8h9kaYRHce/nRqDU7pt5
         dcXoGAq23tYBc2ILmDk52bqZmat83wAF7N7NZzPLnRmaXfkO7yekFmSfm5+Sp2nvzpB3
         AXwCTnT3DLPgvqb6+I1JDFOaDNkGlHK3Q8V+yUSY+1eT+a2CEofoF7wHQSNTBxVGkhqF
         5JffQJ/9ox/xTWw80cCPbQDjPiMJRuz+7mQeIDgcZ3iXyM3sNRDw/Do4ERxwvfi6i+pv
         HJkg==
X-Gm-Message-State: AOAM533SBSo+cjUfmbsD229wXxPVpXpfo1ou40vLJC9d490klMfnMN1t
        TtfNiOdJiEms2PQVwBVVJCG7VKXf6bw9kBQ79ndJl8aY3ilu3HwZ9BMk5nSTA2LhbOALoIeilkD
        dUSKJ4TTabCLT
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr25848wmb.124.1607467121474;
        Tue, 08 Dec 2020 14:38:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdg8qopMo8XIZ+yLQhCChpTW+o92vfU8ZLu15v3ZKuTMtUyRgXkKVDkxpH79EVQdaiDPicOg==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr25808wmb.124.1607467120738;
        Tue, 08 Dec 2020 14:38:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g184sm327437wma.16.2020.12.08.14.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:38:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 92FC2180002; Tue,  8 Dec 2020 23:38:39 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
In-Reply-To: <CAEf4Bzb-b8eye6pi5JRPAL439Yx0FPcd64WwpQz57GPra7Jr_w@mail.gmail.com>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com> <87r1o59aoc.fsf@toke.dk>
 <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk>
 <CAEf4Bzb=zi6ew3fgAg29ZB0tcBw8xfEX-pRuMeAyYBiXp5ewTw@mail.gmail.com>
 <87czzkifef.fsf@toke.dk>
 <CAEf4Bzb-b8eye6pi5JRPAL439Yx0FPcd64WwpQz57GPra7Jr_w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 08 Dec 2020 23:38:39 +0100
Message-ID: <87lfe7q5xs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Dec 8, 2020 at 5:41 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Mon, Dec 7, 2020 at 3:00 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>
>> >> > On Fri, Dec 4, 2020 at 9:55 AM Yonghong Song <yhs@fb.com> wrote:
>> >> >>
>> >> >>
>> >> >>
>> >> >> On 12/4/20 1:34 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> >> > Yonghong Song <yhs@fb.com> writes:
>> >> >> >
>> >> >> >> On 12/3/20 9:55 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> >> >>> Hi Andrii
>> >> >> >>>
>> >> >> >>> I noticed that recent libbpf versions fail to load BPF files c=
ompiled
>> >> >> >>> with old versions of LLVM. E.g., if I compile xdp-tools with L=
LVM 7 I
>> >> >> >>> get:
>> >> >> >>>
>> >> >> >>> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
>> >> >> >>> Loading 1 files on interface 'testns'.
>> >> >> >>> libbpf: loading ../lib/testing/xdp_drop.o
>> >> >> >>> libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=
=3D1
>> >> >> >>> libbpf: sec 'prog': failed to find program symbol at offset 0
>> >> >> >>> Couldn't open file '../lib/testing/xdp_drop.o': BPF object for=
mat invalid
>> >> >> >>>
>> >> >> >>> The 'failed to find program symbol' error seems to have been i=
ntroduced
>> >> >> >>> with commit c112239272c6 ("libbpf: Parse multi-function sectio=
ns into
>> >> >> >>> multiple BPF programs").
>> >> >> >>>
>> >> >> >>> Looking at the object file in question, indeed it seems to not=
 have any
>> >> >> >>> function symbols defined:
>> >> >> >>>
>> >> >> >>> $  llvm-objdump --syms ../lib/testing/xdp_drop.o
>> >> >> >>>
>> >> >> >>> ../lib/testing/xdp_drop.o:  file format elf64-bpf
>> >> >> >>>
>> >> >> >>> SYMBOL TABLE:
>> >> >> >>> 0000000000000000 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000037 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000042 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000068 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000071 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000076 l       .debug_str 0000000000000000
>> >> >> >>> 000000000000008a l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000097 l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000a3 l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000ac l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000b5 l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000bc l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000c9 l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000d4 l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000dd l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000e1 l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000e5 l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000ea l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000f0 l       .debug_str 0000000000000000
>> >> >> >>> 00000000000000f9 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000103 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000113 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000122 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000131 l       .debug_str 0000000000000000
>> >> >> >>> 0000000000000000 l    d  prog       0000000000000000 prog
>> >> >> >>> 0000000000000000 l    d  .debug_abbrev      0000000000000000 .=
debug_abbrev
>> >> >> >>> 0000000000000000 l    d  .debug_info        0000000000000000 .=
debug_info
>> >> >> >>> 0000000000000000 l    d  .debug_frame       0000000000000000 .=
debug_frame
>> >> >> >>> 0000000000000000 l    d  .debug_line        0000000000000000 .=
debug_line
>> >> >> >>> 0000000000000000 g       license    0000000000000000 _license
>> >> >> >>> 0000000000000000 g       prog       0000000000000000 xdp_drop
>> >> >> >>>
>> >> >> >>>
>> >> >> >>> I assume this is because old LLVM versions simply don't emit t=
hat symbol
>> >> >> >>> information?
>> >> >>
>> >> >> Thanks for the below instruction and xdp_drop.c file. I can reprod=
uce
>> >> >> the issue now.
>> >> >>
>> >> >> I added another function 'xdp_drop1' in the same thing. Below is t=
he
>> >> >> symbol table with llvm7 vs. llvm12.
>> >> >>
>> >> >> -bash-4.4$ llvm-readelf -symbols xdp-7.o | grep xdp_drop
>> >> >>      32: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT     3 xdp_d=
rop
>> >> >>      33: 0000000000000010     0 NOTYPE  GLOBAL DEFAULT     3 xdp_d=
rop1
>> >> >>
>> >> >>    [ 3] prog              PROGBITS        0000000000000000 000040 =
000020
>> >> >> 00  AX  0   0  8
>> >> >>
>> >> >> -bash-4.4$ llvm-readelf -symbols xdp-12.o | grep xdp_drop
>> >> >>      32: 0000000000000000    16 FUNC    GLOBAL DEFAULT     3 xdp_d=
rop
>> >> >>      33: 0000000000000010    16 FUNC    GLOBAL DEFAULT     3 xdp_d=
rop1
>> >> >> -bash-4.4$
>> >> >>
>> >> >>    [ 3] prog              PROGBITS        0000000000000000 000040 =
000020
>> >> >> 00  AX  0   0  8
>> >> >>
>> >> >>
>> >> >> Yes, llvm7 does not encode type and size for FUNC's. I guess libbp=
f can
>> >> >> change to recognize NOTYPE and use the symbol value (representing =
the
>> >> >> offset from the start of the section) and section size to
>> >> >> calculate the individual function size. This is more complicated t=
han
>> >> >> elf file providing FUNC type and symbol size directly.
>> >> >
>> >> > I think we should just face the fact that LLVM7 is way too old to
>> >> > produce a sensible BPF ELF file layout. We can extend:
>> >> >
>> >> > libbpf: sec 'prog': failed to find program symbol at offset 0
>> >> > Couldn't open file '../lib/testing/xdp_drop.o': BPF object format i=
nvalid
>> >> >
>> >> > with a suggestion to upgrade Clang/LLVM to something more recent, if
>> >> > that would be helpful.
>> >> >
>> >> > But I don't want to add error-prone checks and assumptions in the
>> >> > already quite complicated logic. Even the kernel itself maintains t=
hat
>> >> > Clang 10+ needs to be used for its compilation. BPF CO-RE is also n=
ot
>> >> > working with older than Clang10, so lots of people have already
>> >> > upgraded way beyond that.
>> >>
>> >> Wait, what? This is a regression that *breaks people's programs* on
>> >> compiler versions that are still very much in the wild! I mean, fine =
if
>> >> you don't want to support new features on such files, but then surely=
 we
>> >> can at least revert back to the old behaviour?
>> >
>> > This is clearly a bug in LLVM7, which didn't produce correct ELF
>> > symbols, do we agree on that? libbpf used to handle such invalid ELF
>> > files *by accident* until it changed its internal logic to be more
>> > strict in v0.2. It became more strict and doesn't work with such
>> > invalid ELF files anymore. Does it need to add extra quirks to support
>> > such broken ELF? I don't think so.
>>
>> I don't know enough about the intricacies of the ELF format to say, but
>> I believe you when you say it's a bug. However, that doesn't change the
>> fact that from a user's PoV, something that was working before is now
>> broken, with the only change being a newer libbpf.
>>
>> This is not a theoretical concern, BTW, I discovered this due to
>> feedback from a partner that we've been pushing to adopt libbpf. When
>> they finally tried it out, the first thing they noticed is that their
>> programs wouldn't load due to this issue.
>>
>> Sure, I can tell them to just upgrade their toolchain (and I will), but
>> that still means we're back to "in order to use this library, you should
>> expect to keep chasing the latest version of the entire toolchain". And
>
> Migrating from LLVM7 to something like LLVM10 or LLVM11 (not asking
> for not-yet-released LLVM12) hardly qualifies as "chasing the latest
> version". LLVM8 or LLVM9 might work for their simple use case either,
> I haven't checked. Just please don't use the extremely outdated
> toolchain that is (now) known to be broken. That's all I'm asking.

"Extremely outdated" is very much subjective: It's only two years old,
and still shipping as the current version in major Linux distributions.

But fine, "we won't promise not to break compilers older than a year" is
also a support statement, it's just not the one (I thought you were)
making before.

In any case, having a clearly stated expectation articulated somewhere
would be very helpful. Something concrete like "expect to run an LLVM
version no older than two stable releases"; just saying "it's stable"
seems to be a tad too subjective, as evidenced by this discussion (and
similar ones we've had before) :)

>> this is a much harder sell than "this is a stable library and upstream
>> takes backwards compatibility very serious", which I *thought* was the
>> expectation.
>
> That's still true and I'd rather not go over the same discussion
> again. But libbpf is also not a dumpster of work-arounds for all
> possible bugs in the kernel and compiler. Libbpf does a lot of that
> for backwards compatibility reasons, no need to deal with quirks of
> buggy and very outdated compilers (and kernels, if there are obvious
> bugs like this).

Not adding new workarounds for things that were broken from the start is
fine. But we're discussing a change that broke something that was
working before. Look at the kernel stability policy: If something was
working with an old kernel, we promise it will keep working on new ones,
regardless of whether what it was doing is technically outside of some
spec. *That's* a stability promise.

>> > Surely, users that can't upgrade LLVM7 to something less ancient, can
>> > stick to libbpf v0.1, that was lenient enough to accept such invalid
>> > ELF files. libbpf v0.2 was released more than a month ago, and so far
>> > you are the only one who noticed this "regression". So hopefully it's
>> > not super annoying to people and they would be accommodating enough to
>> > use more up to date compiler (and save themselves lots of trouble
>> > along the way).
>>
>> Oh, boy, do I envy your adoption rate for new versions! In my world I
>> would expect that by one month a few people who are very early adopters
>> have started noticing and maybe thinking about testing the new version :)
>
> In practice with the new libbpf releases I've been getting reports
> about something broken within a few days. So yeah, I'm a lucky guy, I
> suppose.

Don't mean to knock early testing, that's awesome. I'm just objecting to
the converse implication (i.e., "if it doesn't show up in early testing
it's not a real bug").

>> >> a section name, so it makes it convenient to load programs with 'ip'
>> >> without supplying the section name. However, I do realise this is not
>> >> the best of reasons, and I am not opposed to changing it. However...
>> >>
>> >> > I'm also going to emit warnings in libbpf soon for section names th=
at
>> >> > don't follow proper libbpf naming pattern, so it would be good if y=
ou
>> >> > could get ahead of the curve.
>> >>
>> >> ...this sounds like just another way to annoy users by breaking things
>> >> that were working before? :/
>> >
>> > It won't break, libbpf will emit a warning about the need to use
>> > proper section name format, which will start to be enforced only with
>> > major version bump. So that will give users plenty of time to make
>> > sure their BPF programs are compatible with stricter libbpf.
>>
>> Well see above re: different expectations for "plenty of time". But OK,
>> maybe this isn't as bad as I figured at first glance :)
>
> So far libbpf releases were timed to Linux releases, so roughly one
> every 2 months. libbpf 1.0 is unlikely to come sooner than 2 releases
> out. So it's not like 2 weeks notice, right? Waiting for a year or
> more seems excessive as well.

Removing deprecated features on major release versions does seem
reasonable. But do keep in mind that for some projects, adding a warning
still constitutes "breaking the build" due to downstream policy.

-Toke

