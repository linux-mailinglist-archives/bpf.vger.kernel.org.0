Return-Path: <bpf+bounces-17628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A980FC00
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9C9282319
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD0630;
	Wed, 13 Dec 2023 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpQzqkGv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437283
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 16:10:18 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso65070535e9.2
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 16:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426217; x=1703031017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJ8CZsan83CPpXxPgmRIebiK1g1lZUIOy+fRnR8wYwY=;
        b=GpQzqkGvfMQEGdILkc1y3PSfoc2axhD2l9YVWsTdZPgbYzaeGumkNFHldkIVwyAqbx
         FOmpFeOK7Rb/dvi5U85jyznz0qcabrwYq/j+r+p4nVDJaGrWxKF4RRnQhzvhJdQ/ua8y
         /MRRsAMT4W/0XgdiPMM8M0q0pNXoTtyUVaNOafZQNGq4aHceD3zqVjJTtu5M8aDialzZ
         N8dlhGDAD8wSO1nKVdRItY/liBEI0bh3kfMaUr6PH6NWrudU6uf0Y3JJBV8pxD70oTPa
         U4DEymhPJg3bMMHv/BsM6xonfnsKc72SO9XpEqLCWXZBH+u1MIhCQ87LYJq4S1C0Ap6d
         5g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426217; x=1703031017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJ8CZsan83CPpXxPgmRIebiK1g1lZUIOy+fRnR8wYwY=;
        b=iHAfK+wXX7pYlJbzPTZGX4txC70wFdtToD2yzifR/yqmxtSg0veLPt+KhnGU0YEeAE
         vfSzNEXa3B1vVoGHLNthVOcwIfLO9hke63i0U3YvOS1O8WQmvCYqlazCeeKthOfDdI6X
         7DbfahAeC+O7tMTl2slpLDhli8hBcoqpzzwb1FWjj4bPfSNtQsQI4IZxHOQK/UHhHSyR
         josacmgQA7rEhMRr7G7nylkN1g7o+Qpq9goTR21OLCvRnzoK6f2oQcIOhzIdltIrTyLN
         ihjfWOJOtytEHyg47x4FLwKtJeuJjhjWprcDDpJ0iCsd8IjYrXYA0ur/uzeNri9rZ2YA
         3YLw==
X-Gm-Message-State: AOJu0YyGLFmYCazahlaezu6Zcqxy2xeEO2xuvWTK2Z4ElggxGKDGCFt/
	ZVHoqplb5dqhDp0T06lxg0URukIi3r4yksUm695rd0E9hyM=
X-Google-Smtp-Source: AGHT+IGwAsrrvRzsebP29RzF3vQFQiKi0yPMHDYvmMKqIGBp0j/husfmyDRU9c0gjt1lFb22WDzFMSujfbQJVoWLN4o=
X-Received: by 2002:a05:600c:1895:b0:40c:343b:4515 with SMTP id
 x21-20020a05600c189500b0040c343b4515mr3239738wmp.243.1702426216687; Tue, 12
 Dec 2023 16:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZXcFRJVKbKxtEL5t@nz.home>
In-Reply-To: <ZXcFRJVKbKxtEL5t@nz.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Dec 2023 16:10:04 -0800
Message-ID: <CAEf4BzbN7cUVQgd7nUAsmAQMmCpz7O9v+r3iyiUfa_FK6WMY-w@mail.gmail.com>
Subject: Re: bpftool fails on 32-bit hosts when -Wa,--compress-debug-sections
 is used
To: Sergei Trofimovich <slyich@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 4:49=E2=80=AFAM Sergei Trofimovich <slyich@gmail.co=
m> wrote:
>
> Hi bpf@!
>
> Tl;DR:
>
> BPF programs built with `clang`'s `-g -Wa,--compress-debug-sections`
> fail when processed by `bpftool` on section alignment checks as:
>
>     $ cat src/core/bpf/socket_bind/bpf.c
>     struct socket_bind_map_t { int value; };
>     struct socket_bind_map_t sd_bind_allow __attribute__((section(".maps"=
), used));
>
>     $ clang-16 -target bpf -fno-stack-protector -c src/core/bpf/socket_bi=
nd/bpf.c -o bpf.unstripped.o -g -Wa,--compress-debug-sections
>     $ bpftool gen object bpf.o bpf.unstripped.o
>     libbpf: ELF section #9 has inconsistent alignment addr=3D8 !=3D d=3D4=
 in bpf.unstripped.o

So we are talking about this check in libbpf's linker:

  if (sec->shdr->sh_addralign !=3D sec->data->d_align)

And it's confusing that it would be ok to have actual data alignment
that doesn't match declared alignment in section header? Is that
expected in ELF in general?


Having said that, I think we can mitigate all this easily by ignoring
DWARF sections. Libbpf linker drops all that while linking, see
is_ignored_sec() check, but when doing a sanity check we still
validate everything for DWARF sections.

So perhaps an easy way out is just to ignore DWARF sections in sanity
checks as well?


>     Error: failed to link 'bpf.unstripped.o': Invalid argument (22)
>
> This happens only when `bpftool` is a 32-bit ELF binary. 64-bit
> `bpftool` seems to work as expected.
>
> More words:
>
> Here is my understanding of the failure. Without the
> `-Wa,--compress-debug-sections` option `clang` generates byte-aligned
> uncompressed `.debug` sections:
>
>     $ clang -target bpf -fno-stack-protector -c src/core/bpf/socket_bind/=
bpf.c -o bpf.unstripped.o -g
>     $ readelf -SW bpf.unstripped.o
>     There are 19 section headers, starting at offset 0x530:
>
>     Section Headers:
>       [Nr] Name              Type            Address          Off    Size=
   ES Flg Lk Inf Al
>       [ 0]                   NULL            0000000000000000 000000 0000=
00 00      0   0  0
>       [ 1] .strtab           STRTAB          0000000000000000 000471 0000=
b8 00      0   0  1
>       [ 2] .text             PROGBITS        0000000000000000 000040 0000=
00 00  AX  0   0  4
>       [ 3] .maps             PROGBITS        0000000000000000 000040 0000=
04 00  WA  0   0  4
>       [ 4] .debug_abbrev     PROGBITS        0000000000000000 000044 0000=
4c 00      0   0  1
>       [ 5] .debug_info       PROGBITS        0000000000000000 000090 0000=
3d 00      0   0  1
>       [ 6] .rel.debug_info   REL             0000000000000000 000380 0000=
40 10   I 18   5  8
>       [ 7] .debug_str_offsets PROGBITS        0000000000000000 0000cd 000=
024 00      0   0  1
>       [ 8] .rel.debug_str_offsets REL             0000000000000000 0003c0=
 000070 10   I 18   7  8
>       [ 9] .debug_str        PROGBITS        0000000000000000 0000f1 0000=
80 01  MS  0   0  1
>       [10] .debug_addr       PROGBITS        0000000000000000 000171 0000=
10 00      0   0  1
>       [11] .rel.debug_addr   REL             0000000000000000 000430 0000=
10 10   I 18  10  8
>       [12] .BTF              PROGBITS        0000000000000000 000184 0000=
99 00      0   0  4
>       [13] .rel.BTF          REL             0000000000000000 000440 0000=
10 10   I 18  12  8
>       [14] .debug_line       PROGBITS        0000000000000000 00021d 0000=
43 00      0   0  1
>       [15] .rel.debug_line   REL             0000000000000000 000450 0000=
20 10   I 18  14  8
>       [16] .debug_line_str   PROGBITS        0000000000000000 000260 0000=
41 01  MS  0   0  1
>       [17] .llvm_addrsig     LOOS+0xfff4c03  0000000000000000 000470 0000=
01 00   E 18   0  1
>       [18] .symtab           SYMTAB          0000000000000000 0002a8 0000=
d8 18      1   8  8
>     Key to Flags:
>       W (write), A (alloc), X (execute), M (merge), S (strings), I (info)=
,
>       L (link order), O (extra OS processing required), G (group), T (TLS=
),
>       C (compressed), x (unknown), o (OS specific), E (exclude),
>       D (mbind), p (processor specific)
>
> Note how `.debug_str` has `alignment=3D1` here. Loading of such a section
> has no problems on x86_64 or i686.
>
> But when we add `-Wa,--compress-debug-sections` some debug sections
> become aligned 8 bytes (usual `ELF64`) alignment:
>
>     $ clang -target bpf -fno-stack-protector -c src/core/bpf/socket_bind/=
bpf.c -o bpf.unstripped.o -g -Wa,--compress-debug-sections
>     $ LANG=3DC readelf -SW bpf.unstripped.o
>     There are 19 section headers, starting at offset 0x530:
>
>     Section Headers:
>       [Nr] Name              Type            Address          Off    Size=
   ES Flg Lk Inf Al
>       [ 0]                   NULL            0000000000000000 000000 0000=
00 00      0   0  0
>       [ 1] .strtab           STRTAB          0000000000000000 000471 0000=
b8 00      0   0  1
>       [ 2] .text             PROGBITS        0000000000000000 000040 0000=
00 00  AX  0   0  4
>       [ 3] .maps             PROGBITS        0000000000000000 000040 0000=
04 00  WA  0   0  4
>       [ 4] .debug_abbrev     PROGBITS        0000000000000000 000044 0000=
4c 00      0   0  1
>       [ 5] .debug_info       PROGBITS        0000000000000000 000090 0000=
3d 00      0   0  1
>       [ 6] .rel.debug_info   REL             0000000000000000 000380 0000=
40 10   I 18   5  8
>       [ 7] .debug_str_offsets PROGBITS        0000000000000000 0000cd 000=
024 00      0   0  1
>       [ 8] .rel.debug_str_offsets REL             0000000000000000 0003c0=
 000070 10   I 18   7  8
>       [ 9] .debug_str        PROGBITS        0000000000000000 0000f1 0000=
86 01 MSC  0   0  8
>       [10] .debug_addr       PROGBITS        0000000000000000 000177 0000=
10 00      0   0  1
>       [11] .rel.debug_addr   REL             0000000000000000 000430 0000=
10 10   I 18  10  8
>       [12] .BTF              PROGBITS        0000000000000000 000188 0000=
99 00      0   0  4
>       [13] .rel.BTF          REL             0000000000000000 000440 0000=
10 10   I 18  12  8
>       [14] .debug_line       PROGBITS        0000000000000000 000221 0000=
43 00      0   0  1
>       [15] .rel.debug_line   REL             0000000000000000 000450 0000=
20 10   I 18  14  8
>       [16] .debug_line_str   PROGBITS        0000000000000000 000264 0000=
41 01  MS  0   0  1
>       [17] .llvm_addrsig     LOOS+0xfff4c03  0000000000000000 000470 0000=
01 00   E 18   0  1
>       [18] .symtab           SYMTAB          0000000000000000 0002a8 0000=
d8 18      1   8  8
>     Key to Flags:
>       W (write), A (alloc), X (execute), M (merge), S (strings), I (info)=
,
>       L (link order), O (extra OS processing required), G (group), T (TLS=
),
>       C (compressed), x (unknown), o (OS specific), E (exclude),
>       D (mbind), p (processor specific)
>
> Note how `.debug_str` alignment changed from 1-byte to 8-byte alignment.
>
> AFAIU 8-byte alignment of compressed section for `ELF64` files is expecte=
d:
> compressed sections all have a small header that consistes of a few
> 64-bit values (compression type, uncompressed size, uncompressed data
> alignment).
>
> Thus the binary loads as expected by `x86_64` `bpftool` and fails when
> loaded by `i686` `bpftool`.
>
> Should `bpftool` work in this scenario? Or compressed sections are not
> supported on 32-bit hosts?
>
> It feels like debugging sections with strings should be easily
> decompressable on any host type.
>
> Thanks!
>
> --
>
>   Sergei
>

