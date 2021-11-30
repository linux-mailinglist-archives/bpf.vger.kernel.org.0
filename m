Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC4462AF6
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 04:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhK3DUG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 22:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhK3DUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 22:20:06 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08597C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 19:16:48 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id x32so48247516ybi.12
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 19:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jtGinGJe8JdSQ4rZFVyNFHdaqAYJNm5eCirYrcgthL8=;
        b=bYRbjinL+ZD9OtNtKbAWJ5k5DQgJRkQ84nWeceNJbIjBYXK8b+zOiYQz2zovk19z5c
         tAiTGTFWwXEgA1FLR4mCKFtMoArHoLxUBll8lHuL6GK93UwWcufz4o7kS1o5ZbRJLAUg
         NXh7F2Qkspro/YRZpJUkHqbjKLUOwnFwqEdz0LlhczkGpdS0gAAD9h29T9RtYvBPkMlY
         w0wCzd0VznnS2/M0m1mOx9M6xOx7RbYDhgkkQoV4NmPIQrKNwVehHoatjM88BImpxLa4
         VqnUrcuuI4aUZFuxZahPPWtrjCB1UE8HHAm25oWQAXtlrA23Bs1/dAuWYnptfXNrNdQU
         6g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtGinGJe8JdSQ4rZFVyNFHdaqAYJNm5eCirYrcgthL8=;
        b=MX/xcJXA1Fm0XTtUgfC84+EIeCvAOcSOEhKoBBY8Cgliv4PhWMPf99WLz63ttXLAzF
         lAlbPI4cDDyEiD8LrQyrx+Irw30NzvRmZ70aKUQYI7YkRnMhP/lvKGU29Bp715IBZPo9
         tarrZyIWJDWPWmQAQZy3aarF1vwMn1jokwrAf1goUQZihmqsDrOMN0fk74y9F6AS3Fmw
         uDl9Vbv/n7t3/DZevXX7tgOqdgwaZdj+WWpBOe+st8rPhg4pJSL4jQQBI8sQTWnGAv71
         6SztY1dU5hm3Df+z7B40Y3c+0HSkijo/5289QYXqnUrwnoAf9XEw8O0ATrdzVLJOs+//
         XKJg==
X-Gm-Message-State: AOAM530wnwRAW32X50p3yuj5wajbMttNI4ozQYNtvcLAUEwL7cu1fy1R
        jXCCqYcjZfLZsM9MFGZu7JPOHqfvjFm4/wcZxGOBQkYbkS/HEw==
X-Google-Smtp-Source: ABdhPJykh7yMWAfP4+reyvlsgWiF+thqrCVPkQel6XQAVYrJs6le8xer9at6tzF/TQXNAa9GdbDAfFTLWtdUz9j46Hc=
X-Received: by 2002:a25:e617:: with SMTP id d23mr10409563ybh.555.1638242207236;
 Mon, 29 Nov 2021 19:16:47 -0800 (PST)
MIME-Version: 1.0
References: <CAK-59YFPU3qO+_pXWOH+c1LSA=8WA1yabJZfREjOEXNHAqgXNg@mail.gmail.com>
 <CAEf4BzZM480NkS+At2Cb=mJaj1FowgUTbepp5QPreXXDriTBLg@mail.gmail.com> <CAK-59YHxGKDvwoShORK5gDenS+yKKzjWdEmayzoCG043_PoyOg@mail.gmail.com>
In-Reply-To: <CAK-59YHxGKDvwoShORK5gDenS+yKKzjWdEmayzoCG043_PoyOg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 19:16:36 -0800
Message-ID: <CAEf4Bzavv2wQ2OmxwQh3HtihBUfxNKs4C5ZixYz5+OfiZVec4g@mail.gmail.com>
Subject: Re: Custom 'hello' BPF CO-RE example failed on Debian 10 again for
 some reason
To:     Pony Sew <poony20115@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 6:50 PM Pony Sew <poony20115@gmail.com> wrote:
>
> No worries, thanks for the update! You are probably busy with Libbpf proj=
ect, so take your time. I think I'll try "const volatile" method.
>
> Best regards,
> Poony.
>

Please don't top post when sending email to the mailing list.

This issue was fixed (see [0]) and synced to Github. I forgot to CC
you on the patch itself, sorry. If you update to latest libbpf
version, the issue should be gone.

  [0] https://github.com/libbpf/libbpf/commit/5c31bcf220f66e70f39fd141f5b0c=
55c6ab65e8e

> Andrii Nakryiko <andrii.nakryiko@gmail.com> =E6=96=BC 2021=E5=B9=B411=E6=
=9C=8819=E6=97=A5 =E9=80=B1=E4=BA=94 06:39 =E5=AF=AB=E9=81=93=EF=BC=9A
>>
>> On Mon, Nov 15, 2021 at 1:48 AM Pony Sew <poony20115@gmail.com> wrote:
>> >
>> > Hello,
>> > This (https://github.com/sartura/ebpf-core-sample) is the code I'm usi=
ng.
>> > But I add " #define BPF_NO_GLOBAL_DATA 1 " on 'hello.bpf.c' so that
>> > Debian 10 is able to execute it.
>> > Compiled on default Debian11 amd64 environment with clang package
>> > installed from mirror source.
>> > Both 'hello' and 'maps' used to work on Debian10 about a month ago.
>> > But 'hello' now can't. I'd like to improve this result.
>> > ----------------------------------------------------------------------=
-------------------
>> > This is how I compiled them in steps:
>> >
>> > # bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
>> > # clang -g -O2 -target bpf -D__TARGET_ARCH_x86_64 -I . -c hello.bpf.c =
-o
>> > # hello.bpf.o
>> > # bpftool gen skeleton hello.bpf.o > hello.skel.h
>> > # clang -g -O2 -Wall -I . -c hello.c -o hello.o
>> > # git clone https://github.com/libbpf/libbpf
>> > # cd libbpf/src
>> > # make BUILD_STATIC_ONLY=3D1 OBJDIR=3D../build/libbpf DESTDIR=3D../bui=
ld
>> > INCLUDEDIR=3D LIBDIR=3D UAPIDIR=3D install
>> > # cd ../../
>> > # clang -Wall -O2 -g hello.o libbpf/build/libbpf.a -lelf -lz -o hello
>> >
>> > There was only one warning message: "libbpf: elf: skipping
>> > unrecognized data section(4) .rodata.str1.1", which appeared during
>> > the generation of 'hello.skel.h'. There are no other warning and error
>> > messages during this whole 'hello' and 'maps' compilation.
>> > ----------------------------------------------------------------------=
---------------------------------------------
>> > Result of executing 'hello' on default amd64 Debian10 environment:
>> >
>> > libbpf: kernel doesn't support global data
>>
>> Sorry for the late reply, I didn't ignore or forget, I was trying to
>> come up with the best solution.
>>
>> In short, I suspect it's because of the recent libbpf feature to
>> support multiple .rodata.* sections. In your case, kernel is old and
>> doesn't support those special maps, but Clang actually sometimes emits
>> unused .rodata.strN.M sections. No code is referencing them, yet
>> compiler stubbornly emits them. After recent changes libbpf will try
>> to create a map for such sections which is causing "kernel doesn't
>> support global data" error.
>>
>> I think I'm going to teach libbpf to recognize such maps that are not
>> referenced from BPF program code and not create them, if kernel
>> doesn't support global data. Will need to see how to do it in the
>> least intrusive way, but I'm going to solve this before official 0.6
>> release.
>>
>> Thanks for reporting. Stay tuned for the solution.
>>
>> > libbpf: failed to load object 'hello_bpf'
>> > libbpf: failed to load BPF skeleton 'hello_bpf': -95
>> > failed to load BPF object -95
>> > ----------------------------------------------------------------------=
---------------------------------------------
>> > From what I can remember, That warning message used to appear even
>> > when I'm executing 'hello' on Debian10. But the BPF program work just
>> > fine then. Maybe there is something else I can do?
>> >
>> > Sincerely,
>> > Poony.
