Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877D82D0E99
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 12:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgLGLBb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 06:01:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgLGLBb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 06:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607338803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpD02b7HWqQW9bkSIPogOOv3sWD86A0GtXqkLqvlc60=;
        b=Gog41t/ZDQVSnilbU71TEOA/sjGPsvs/MfJQR8b/uJYnhjppEmJ55uuIIavv3SNxPsbTul
        UOTMP3OWA/Py00wl9u14gQiToSSeigJbKGvDVisna7y31YebH+Awr8ipgZtrl9hUsaCQbG
        pS7amp68FTyJmq8a2hqAHjBij3zgWmY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-Y9WAjgqnN1i8odTcQnafTg-1; Mon, 07 Dec 2020 06:00:01 -0500
X-MC-Unique: Y9WAjgqnN1i8odTcQnafTg-1
Received: by mail-wm1-f69.google.com with SMTP id q1so4056388wmq.2
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 03:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=hpD02b7HWqQW9bkSIPogOOv3sWD86A0GtXqkLqvlc60=;
        b=XfFS4Uuxo1GmVatMnguLsrxFLLdLO+jj4T04CafSAT+us6VsO/FKjDkJyEXl+wCWGm
         07acBS/rexjmXExrpqrE9UFn0uXFyojUQ4vFy/QRzGdxnbiDBEJ3vyi/INYdscnb+F6I
         D88cUsdeEru4OuK+ZHJzzTR54chPHT2i0QqGv5FOe82ZKCCwe3ox5aPijlyg81zxS/yi
         LALxq42w3pvO09j5X6l4Wrd+u1Bo762FK3T7/l5ZiFjXvB6Pls71GHTmn3yQ3t2w/sQp
         3FdLATdIScikhotaIqLvkImIW6Mwy7O7Vd6tFBSNMiHCsK7QtofKR7yV+jehQLDaSE+v
         Mf4w==
X-Gm-Message-State: AOAM531QHvROAZYTJpM+xEEiATFJ6KFZXJ5IKtcvAWmKNAjjzeHnobMp
        U1/PxehyQGmXq6VAK5sZPy5NfDHrQs5VmoEHG9rhW4xztKYEj6Ewm1b8C9Ihfum+Dis3NOQwseU
        DCBmkSQi4SwTW
X-Received: by 2002:adf:902d:: with SMTP id h42mr18498621wrh.175.1607338799708;
        Mon, 07 Dec 2020 02:59:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCaE05Ua0KPlERLAddiaOpMRnwzyT/2gldwYNdCco/8Uj+GWIzvvdPWLckMyZ8QaQlbpP42Q==
X-Received: by 2002:adf:902d:: with SMTP id h42mr18498576wrh.175.1607338799209;
        Mon, 07 Dec 2020 02:59:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id o74sm14829956wme.36.2020.12.07.02.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 02:59:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1EE7018063F; Mon,  7 Dec 2020 11:59:58 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
In-Reply-To: <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com> <87r1o59aoc.fsf@toke.dk>
 <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 07 Dec 2020 11:59:58 +0100
Message-ID: <875z5d7ufl.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Dec 4, 2020 at 9:55 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 12/4/20 1:34 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > Yonghong Song <yhs@fb.com> writes:
>> >
>> >> On 12/3/20 9:55 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >>> Hi Andrii
>> >>>
>> >>> I noticed that recent libbpf versions fail to load BPF files compiled
>> >>> with old versions of LLVM. E.g., if I compile xdp-tools with LLVM 7 I
>> >>> get:
>> >>>
>> >>> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
>> >>> Loading 1 files on interface 'testns'.
>> >>> libbpf: loading ../lib/testing/xdp_drop.o
>> >>> libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=3D1
>> >>> libbpf: sec 'prog': failed to find program symbol at offset 0
>> >>> Couldn't open file '../lib/testing/xdp_drop.o': BPF object format in=
valid
>> >>>
>> >>> The 'failed to find program symbol' error seems to have been introdu=
ced
>> >>> with commit c112239272c6 ("libbpf: Parse multi-function sections into
>> >>> multiple BPF programs").
>> >>>
>> >>> Looking at the object file in question, indeed it seems to not have =
any
>> >>> function symbols defined:
>> >>>
>> >>> $  llvm-objdump --syms ../lib/testing/xdp_drop.o
>> >>>
>> >>> ../lib/testing/xdp_drop.o:  file format elf64-bpf
>> >>>
>> >>> SYMBOL TABLE:
>> >>> 0000000000000000 l       .debug_str 0000000000000000
>> >>> 0000000000000037 l       .debug_str 0000000000000000
>> >>> 0000000000000042 l       .debug_str 0000000000000000
>> >>> 0000000000000068 l       .debug_str 0000000000000000
>> >>> 0000000000000071 l       .debug_str 0000000000000000
>> >>> 0000000000000076 l       .debug_str 0000000000000000
>> >>> 000000000000008a l       .debug_str 0000000000000000
>> >>> 0000000000000097 l       .debug_str 0000000000000000
>> >>> 00000000000000a3 l       .debug_str 0000000000000000
>> >>> 00000000000000ac l       .debug_str 0000000000000000
>> >>> 00000000000000b5 l       .debug_str 0000000000000000
>> >>> 00000000000000bc l       .debug_str 0000000000000000
>> >>> 00000000000000c9 l       .debug_str 0000000000000000
>> >>> 00000000000000d4 l       .debug_str 0000000000000000
>> >>> 00000000000000dd l       .debug_str 0000000000000000
>> >>> 00000000000000e1 l       .debug_str 0000000000000000
>> >>> 00000000000000e5 l       .debug_str 0000000000000000
>> >>> 00000000000000ea l       .debug_str 0000000000000000
>> >>> 00000000000000f0 l       .debug_str 0000000000000000
>> >>> 00000000000000f9 l       .debug_str 0000000000000000
>> >>> 0000000000000103 l       .debug_str 0000000000000000
>> >>> 0000000000000113 l       .debug_str 0000000000000000
>> >>> 0000000000000122 l       .debug_str 0000000000000000
>> >>> 0000000000000131 l       .debug_str 0000000000000000
>> >>> 0000000000000000 l    d  prog       0000000000000000 prog
>> >>> 0000000000000000 l    d  .debug_abbrev      0000000000000000 .debug_=
abbrev
>> >>> 0000000000000000 l    d  .debug_info        0000000000000000 .debug_=
info
>> >>> 0000000000000000 l    d  .debug_frame       0000000000000000 .debug_=
frame
>> >>> 0000000000000000 l    d  .debug_line        0000000000000000 .debug_=
line
>> >>> 0000000000000000 g       license    0000000000000000 _license
>> >>> 0000000000000000 g       prog       0000000000000000 xdp_drop
>> >>>
>> >>>
>> >>> I assume this is because old LLVM versions simply don't emit that sy=
mbol
>> >>> information?
>>
>> Thanks for the below instruction and xdp_drop.c file. I can reproduce
>> the issue now.
>>
>> I added another function 'xdp_drop1' in the same thing. Below is the
>> symbol table with llvm7 vs. llvm12.
>>
>> -bash-4.4$ llvm-readelf -symbols xdp-7.o | grep xdp_drop
>>      32: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT     3 xdp_drop
>>      33: 0000000000000010     0 NOTYPE  GLOBAL DEFAULT     3 xdp_drop1
>>
>>    [ 3] prog              PROGBITS        0000000000000000 000040 000020
>> 00  AX  0   0  8
>>
>> -bash-4.4$ llvm-readelf -symbols xdp-12.o | grep xdp_drop
>>      32: 0000000000000000    16 FUNC    GLOBAL DEFAULT     3 xdp_drop
>>      33: 0000000000000010    16 FUNC    GLOBAL DEFAULT     3 xdp_drop1
>> -bash-4.4$
>>
>>    [ 3] prog              PROGBITS        0000000000000000 000040 000020
>> 00  AX  0   0  8
>>
>>
>> Yes, llvm7 does not encode type and size for FUNC's. I guess libbpf can
>> change to recognize NOTYPE and use the symbol value (representing the
>> offset from the start of the section) and section size to
>> calculate the individual function size. This is more complicated than
>> elf file providing FUNC type and symbol size directly.
>
> I think we should just face the fact that LLVM7 is way too old to
> produce a sensible BPF ELF file layout. We can extend:
>
> libbpf: sec 'prog': failed to find program symbol at offset 0
> Couldn't open file '../lib/testing/xdp_drop.o': BPF object format invalid
>
> with a suggestion to upgrade Clang/LLVM to something more recent, if
> that would be helpful.
>
> But I don't want to add error-prone checks and assumptions in the
> already quite complicated logic. Even the kernel itself maintains that
> Clang 10+ needs to be used for its compilation. BPF CO-RE is also not
> working with older than Clang10, so lots of people have already
> upgraded way beyond that.

Wait, what? This is a regression that *breaks people's programs* on
compiler versions that are still very much in the wild! I mean, fine if
you don't want to support new features on such files, but then surely we
can at least revert back to the old behaviour?

> Speaking of legacy. Toke, can you please update all the samples in
> your xdp-tools repo to not use arbitrary sections names. I see
> SEC("prog"), where it should really be SEC("xdp"). It sets a bad
> example for newcomers, IMO.

I used "prog" because that's what iproute2 looks for if you don't supply
a section name, so it makes it convenient to load programs with 'ip'
without supplying the section name. However, I do realise this is not
the best of reasons, and I am not opposed to changing it. However...

> I'm also going to emit warnings in libbpf soon for section names that
> don't follow proper libbpf naming pattern, so it would be good if you
> could get ahead of the curve.

...this sounds like just another way to annoy users by breaking things
that were working before? :/

-Toke

