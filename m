Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECC72CEAFF
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 10:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgLDJgS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 04:36:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgLDJgS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 04:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607074491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcbKnY/reOQtGQp41fnWN327+aBcJaG3Qzuu+E9AruQ=;
        b=CgaNafJVKG/zQVzSOjFRX99JiF3BIpv95CE9Wjmb7LxHkYnALifHwXsPkmQHnVixNX/AYR
        l9JJN6gzDGobLXkm3R9hP0Iy36kufUzazku7w+HWksaVbDpUUH/ua2+3FYgLplqO4zjHtq
        IaPYASw+XJn3xBI3RZsaQ2Q9cMSDfxo=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-vmOMIAu-P0mxH8N2Ydy7fg-1; Fri, 04 Dec 2020 04:34:48 -0500
X-MC-Unique: vmOMIAu-P0mxH8N2Ydy7fg-1
Received: by mail-ot1-f69.google.com with SMTP id f11so1894993otp.2
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 01:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=RcbKnY/reOQtGQp41fnWN327+aBcJaG3Qzuu+E9AruQ=;
        b=kc4fxXaCtT2EAxzmP55arO9oNW7dPPjBboxqEM/rkURj5A/n74Q9yDp1lm0kgSCMJU
         zQtItX2Z55fkFZAb2IvbYGIT0JVttTaN/pJ1nnajpL6/UKh4NwRhUqxR1XaLp8Y8rDRm
         Qpx3+PjpoGPGQp7LIvGkIWr2I/Nhi7GfK7qxfCjVSIEAaOvUrd73V1s+svR5u6PrBCsG
         9pJflnXDoBuVAHgzgAUkbGIFvrTb0LvY+deyZfWcWwxz4+XxCtO1CPA/b6vFq+ykB84x
         zKnNPfdt4XLkzU5E+6Outo8Fe75mRsH18ylWgxZsKPKqNP49WqFMgsgSjwfaYFMHxnkr
         WEAQ==
X-Gm-Message-State: AOAM533CgWbH0LuU3JJqeFkXbUcfGQ2nFIGHcNDo/zpM0TKtdqdQW2Lh
        MQfI938Rw9af6FAZHQaELbL8d4tO3tnRf7mpmcH6J0M4iKNS9fHZ8l+KRx8ZjCspLYm5pAKLGOn
        VIrRsZqR9stRL
X-Received: by 2002:a9d:7d06:: with SMTP id v6mr2926227otn.296.1607074487608;
        Fri, 04 Dec 2020 01:34:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKfuxkbFqsWm6XKhTQSF5knRBmTMWDcrQrosLK8tfy0PBuias/hGiE7RsXZ7EpOE3RqhqNXw==
X-Received: by 2002:a9d:7d06:: with SMTP id v6mr2926205otn.296.1607074487068;
        Fri, 04 Dec 2020 01:34:47 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h17sm525819oor.1.2020.12.04.01.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:34:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 68AE2182EEA; Fri,  4 Dec 2020 10:34:43 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
In-Reply-To: <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
References: <87lfeebwpu.fsf@toke.dk>
 <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 04 Dec 2020 10:34:43 +0100
Message-ID: <87r1o59aoc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> writes:

> On 12/3/20 9:55 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hi Andrii
>>=20
>> I noticed that recent libbpf versions fail to load BPF files compiled
>> with old versions of LLVM. E.g., if I compile xdp-tools with LLVM 7 I
>> get:
>>=20
>> $ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv
>> Loading 1 files on interface 'testns'.
>> libbpf: loading ../lib/testing/xdp_drop.o
>> libbpf: elf: section(3) prog, size 16, link 0, flags 6, type=3D1
>> libbpf: sec 'prog': failed to find program symbol at offset 0
>> Couldn't open file '../lib/testing/xdp_drop.o': BPF object format invalid
>>=20
>> The 'failed to find program symbol' error seems to have been introduced
>> with commit c112239272c6 ("libbpf: Parse multi-function sections into
>> multiple BPF programs").
>>=20
>> Looking at the object file in question, indeed it seems to not have any
>> function symbols defined:
>>=20
>> $  llvm-objdump --syms ../lib/testing/xdp_drop.o
>>=20
>> ../lib/testing/xdp_drop.o:	file format elf64-bpf
>>=20
>> SYMBOL TABLE:
>> 0000000000000000 l       .debug_str	0000000000000000
>> 0000000000000037 l       .debug_str	0000000000000000
>> 0000000000000042 l       .debug_str	0000000000000000
>> 0000000000000068 l       .debug_str	0000000000000000
>> 0000000000000071 l       .debug_str	0000000000000000
>> 0000000000000076 l       .debug_str	0000000000000000
>> 000000000000008a l       .debug_str	0000000000000000
>> 0000000000000097 l       .debug_str	0000000000000000
>> 00000000000000a3 l       .debug_str	0000000000000000
>> 00000000000000ac l       .debug_str	0000000000000000
>> 00000000000000b5 l       .debug_str	0000000000000000
>> 00000000000000bc l       .debug_str	0000000000000000
>> 00000000000000c9 l       .debug_str	0000000000000000
>> 00000000000000d4 l       .debug_str	0000000000000000
>> 00000000000000dd l       .debug_str	0000000000000000
>> 00000000000000e1 l       .debug_str	0000000000000000
>> 00000000000000e5 l       .debug_str	0000000000000000
>> 00000000000000ea l       .debug_str	0000000000000000
>> 00000000000000f0 l       .debug_str	0000000000000000
>> 00000000000000f9 l       .debug_str	0000000000000000
>> 0000000000000103 l       .debug_str	0000000000000000
>> 0000000000000113 l       .debug_str	0000000000000000
>> 0000000000000122 l       .debug_str	0000000000000000
>> 0000000000000131 l       .debug_str	0000000000000000
>> 0000000000000000 l    d  prog	0000000000000000 prog
>> 0000000000000000 l    d  .debug_abbrev	0000000000000000 .debug_abbrev
>> 0000000000000000 l    d  .debug_info	0000000000000000 .debug_info
>> 0000000000000000 l    d  .debug_frame	0000000000000000 .debug_frame
>> 0000000000000000 l    d  .debug_line	0000000000000000 .debug_line
>> 0000000000000000 g       license	0000000000000000 _license
>> 0000000000000000 g       prog	0000000000000000 xdp_drop
>>=20
>>=20
>> I assume this is because old LLVM versions simply don't emit that symbol
>> information?
>
> Could you share xdp_drop.c or other test which I can compile and check
> to understand the issue?

It's just an empty program returning XDP_DROP:

https://github.com/xdp-project/xdp-tools/blob/master/lib/testing/xdp_drop.c

I basically just did this on Debian buster:

$ sudo apt install gcc-multilib build-essential libpcap-dev libelf-dev git =
llc lld clang gcc-multilib pkt-config m4
$ git clone --recurse-submodules https://github.com/xdp-project/xdp-tools
$ cd xdp-tools
$ LLC=3Dllc-7 ./configure
$ make -k
$ cd xdp-loader
$ sudo ip link add dev testns type veth
$ sudo ./xdp-loader load testns ../lib/testing/xdp_drop.o -vv

(xdpdump will fail to build with llvm7, but the rest should work)

-Toke

